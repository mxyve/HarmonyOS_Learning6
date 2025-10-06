import { Course, WeekType } from '../model/Course';

@Component
export struct CourseDetailPopup {
  @Prop course: Course;
  // 声明一个事件回调参数（用箭头函数类型）
  onClose: () => void = () => {
  }; // 默认为空函数，避免未传参时报错

  build() {
    Column({ space: 20 }) {
      this.buildHeader()
      this.buildCourseInfo()

      Button('关闭')
        .width('80%')
        .height(40)
        .fontSize(16)
        .backgroundColor('#1890FF')
        .fontColor(Color.White)
        .borderRadius(8)
        .onClick(() => {
          this.onClose(); // 点击时触发回调
        })
    }
    .width('100%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .shadow({
      radius: 24,
      color: '#00000040',
      offsetX: 0,
      offsetY: 8
    })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildHeader() {
    Row() {
      Text(this.course.courseName)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildCourseInfo() {
    Column({ space: 12 }) {
      InfoItem({ label: '授课教师', value: this.course.teacher })
      InfoItem({ label: '上课地点', value: this.course.location })
      InfoItem({ label: '上课时间', value: this.getTimeDescription() })
      InfoItem({ label: '上课周次', value: this.getWeekDescription() })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
  }

  // 获取时间描述
  private getTimeDescription(): string {
    return `周${this.getChineseDay(this.course.dayOfWeek)} 第${this.course.startSession}-${this.course.endSession}节`;
  }

  // 获取周次描述
  private getWeekDescription(): string {
    let weekTypeText: string = '每周';

    switch (this.course.weekType) {
      case WeekType.All:
        weekTypeText = '每周';
        break;
      case WeekType.Odd:
        weekTypeText = '单周';
        break;
      case WeekType.Even:
        weekTypeText = '双周';
        break;
      default:
        weekTypeText = '每周';
        break;
    }

    return `第${this.course.startWeek}-${this.course.endWeek}周 (${weekTypeText})`;
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
}

// 信息项组件
@Component
struct InfoItem {
  @Prop label: string = '';
  @Prop value: string = '';

  build() {
    Row() {
      Text(this.label + '：')
        .fontSize(14)
        .fontColor('#666666')
        .width(80)

      Text(this.value)
        .fontSize(14)
        .fontColor('#333333')
        .flexGrow(1)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
}