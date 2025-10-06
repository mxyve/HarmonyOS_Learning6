import { Course, mockCourses } from '../../../model/Course';
import { WEEK_DAYS, SESSION_TIMES, isCourseInWeek, getCurrentSession, getCurrentDayOfWeek } from '../../../utils/Utils';
import { SessionTime } from '../../../model/Types';
import { CourseDetailPopup } from '../../../components/CourseDetailPopup';

@Component
export struct SchedulePage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State currentWeek: number = 1; // 当前周次
  @State courses: Course[] = mockCourses;
  @State selectedCourse: Course | null = null;
  @State showCourseDetail: boolean = false;

  // 计算课程格子的宽度（与星期标题保持一致）
  private getCourseCellWidth(): string {
    return 'calc((100% - 80px) / 7)';
  }

  // 获取当前周次的课程
  getCurrentWeekCourses(): Course[] {
    return this.courses.filter((course: Course) => isCourseInWeek(course, this.currentWeek));
  }

  // 获取某天某节次的课程
  getCourseAt(day: number, session: number): Course | null {
    const weekCourses: Course[] = this.getCurrentWeekCourses();
    const foundCourse: Course | undefined = weekCourses.find((course: Course) =>
    course.dayOfWeek === day &&
      session >= course.startSession &&
      session <= course.endSession
    );
    return foundCourse || null;
  }

  // 处理课程点击
  handleCourseClick(course: Course): void {
    this.selectedCourse = course;
    this.showCourseDetail = true;
  }

  // 切换周次
  switchWeek(direction: number): void {
    const newWeek: number = this.currentWeek + direction;
    if (newWeek >= 1 && newWeek <= 20) {
      this.currentWeek = newWeek;
    }
  }

  build() {
    NavDestination() {
      Column() {
        // 标题栏和周次切换
        this.buildHeader()

        // 课表容器
        Column() {
          // 星期标题行
          this.buildWeekdayHeader()

          // 课表内容区域
          Scroll() {
            Column() {
              // 每一行：时间轴 + 7天的课程
              ForEach(SESSION_TIMES, (sessionTime: SessionTime) => {
                this.buildScheduleRow(sessionTime)
              })
            }
          }
          .width('100%')
          .flexGrow(1)
        }
        .width('100%')
        .flexGrow(1)
        .backgroundColor('#F5F5F5')
        .gesture(
          PanGesture({})
            .onActionEnd((event: GestureEvent) => {
              const offsetX: number = event.offsetX;
              const minSwipeDistance: number = 30;
              if (Math.abs(offsetX) > minSwipeDistance) {
                this.switchWeek(offsetX > 0 ? -1 : 1);
              }
            })
        )

        // 课程详情弹窗
        if (this.showCourseDetail && this.selectedCourse) {
          this.buildCourseDetailPopup()
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }.title('课程表')
  }

  // 构建标题栏
  @Builder
  buildHeader() {
    Row({ space: 10 }) {
      Button('<')
        .onClick(() => {
          this.switchWeek(-1);
        })
        .backgroundColor(Color.White)
        .fontColor('#666666')
        .width(40)
        .height(40)
        .borderRadius(20)

      Text(`第 ${this.currentWeek} 周`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Button('>')
        .onClick(() => {
          this.switchWeek(1);
        })
        .backgroundColor(Color.White)
        .fontColor('#666666')
        .width(40)
        .height(40)
        .borderRadius(20)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding(10)
    .backgroundColor('#FFFFFF')
  }

  // 构建星期标题行
  @Builder
  buildWeekdayHeader() {
    Row() {
      // 左上角空白（对应时间轴位置）
      Text('')
        .width(15)
        .height(40)

      // 周一到周日标题 - 使用统一的宽度计算方法
      ForEach(this.getDayArray(), (day: number) => {
        Text(WEEK_DAYS[day])
          .width(this.getCourseCellWidth())
          .height(40)
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#F0F0F0')
          .borderRadius(4)
          .margin({ left: 2, right: 2 })
      })
    }
    .width('100%')
    .padding({ left: 10, right: 10, bottom: 5 })
  }

  // 构建课表行（一节课程的时间行）
  @Builder
  buildScheduleRow(sessionTime: SessionTime) {
    Row() {
      // 时间轴单元格（左侧固定宽度）
      this.buildTimeAxisCell(sessionTime)

      // 7天的课程格子 - 使用统一的宽度
      ForEach(this.getDayArray(), (day: number) => {
        this.buildCourseCell(day, sessionTime.session)
      })
    }
    .width('100%')
    .height(65)
    .padding({ left: 1, right: 1 })
  }

  // 构建时间轴单元格
  @Builder
  buildTimeAxisCell(sessionTime: SessionTime) {
    Column({ space: 2 }) {
      Text(`第${sessionTime.session}节`)
        .fontSize(8)
        .fontWeight(FontWeight.Medium)
      Text(sessionTime.start)
        .fontSize(8)
        .fontColor('#666666')
      Text(sessionTime.end)
        .fontSize(8)
        .fontColor('#666666')
    }
    .width(30)
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.isCurrentTimeSession(sessionTime.session) ? '#E6F7FF' : Color.White)
    .borderRadius(3)
    .border({ width: 1, color: '#E8E8E8' })
  }

  // 构建课程格子
  @Builder
  buildCourseCell(day: number, session: number) {
    if (this.shouldShowCourse(day, session)) {
      // 直接调用方法，不声明变量
      this.buildCourseBlock(this.getCourseAt(day, session)!, this.isCurrentTime(day, session))
    } else {
      this.buildBlankBlock(this.isCurrentTime(day, session))
    }
  }

  // 构建课程块
  @Builder
  buildCourseBlock(course: Course, isNow: boolean) {
    Column({ space: 2 }) {
      Text(course.courseName)
        .fontSize(12)
        .fontColor(Color.White)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Text(course.location)
        .fontSize(10)
        .fontColor(Color.White)
        .opacity(0.9)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(this.getCourseCellWidth())
    .height('100%')
    .padding(4)
    .backgroundColor(course.color)
    .borderRadius(3)
    .border({
      width: isNow ? 2 : 0,
      color: '#FFA940'
    })
    .margin({ left: 0, right: 0 })
    .onClick(() => {
      this.handleCourseClick(course);
    })
  }

  // 构建空白格子
  @Builder
  buildBlankBlock(isNow: boolean) {
    Column()
      .width(this.getCourseCellWidth())
      .height('100%')
      .backgroundColor(isNow ? '#FFF2E8' : Color.White)
      .borderRadius(8)
      .border({
        width: isNow ? 2 : 1,
        color: isNow ? '#FFA940' : '#E8E8E8'
      })
      .margin({ left: 0, right: 0 })
  }

  // 判断是否应该显示课程
  private shouldShowCourse(day: number, session: number): boolean {
    const course = this.getCourseAt(day, session);
    return !!(course && course.startSession === session);
  }

  // 检查是否是当前时间的格子
  isCurrentTime(day: number, session: number): boolean {
    const currentDay: number = getCurrentDayOfWeek();
    const currentSession: number = getCurrentSession();
    return currentDay === day && currentSession === session;
  }

  // 检查是否是当前时间的节次
  isCurrentTimeSession(session: number): boolean {
    const currentSession: number = getCurrentSession();
    return currentSession === session;
  }

  // 课程详情弹窗（最终正确版本）
  @Builder
  buildCourseDetailPopup() {
    Column() {
      // 遮罩层
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#00000033')
        .onClick(() => {
          this.showCourseDetail = false;
          this.selectedCourse = null;
        })

      // 弹窗内容（正确传递事件回调）
      Column() {
        if (this.selectedCourse) {
          // 直接在组件属性中传递onClose回调，无方法调用
          CourseDetailPopup({
            course: this.selectedCourse,
            onClose: () => { // 作为属性参数传递
              this.showCourseDetail = false;
              this.selectedCourse = null;
            }
          })
        }
      }
      .width('90%') // ← 比原来大
      .backgroundColor('#FFFFFFD9') // ← 毛玻璃底（白色 85% 不透明）
      .backdropBlur(16) // ← 背景模糊
      .borderRadius(24)
      .padding(4) // 给卡片留一点白边
      .shadow({
        radius: 40,
        color: '#00000050',
        offsetX: 0,
        offsetY: 16
      })
      .position({ x: '5%', y: '50%' })
      .translate({ y: '-50%' })
      .scale({ x: this.showCourseDetail ? 1 : 0.9, y: this.showCourseDetail ? 1 : 0.9 }) // 小缩放动画
      .opacity(this.showCourseDetail ? 1 : 0)
      .animation({
        duration: 250,
        curve: Curve.EaseOut,
        playMode: PlayMode.Normal
      })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
  }

  // 获取中文星期
  private getChineseDay(day: number): string {
    switch (day) {
      case 1:
        return '一';
      case 2:
        return '二';
      case 3:
        return '三';
      case 4:
        return '四';
      case 5:
        return '五';
      case 6:
        return '六';
      case 7:
        return '日';
      default:
        return '';
    }
  }

  // 获取周类型文本
  private getWeekTypeText(weekType: number): string {
    switch (weekType) {
      case 0:
        return '(每周)';
      case 1:
        return '(单周)';
      case 2:
        return '(双周)';
      default:
        return '';
    }
  }

  // 获取星期数组 (1-7)
  private getDayArray(): number[] {
    return [1, 2, 3, 4, 5, 6, 7];
  }
}