import { Course } from '../components/Course';
import { CourseCard } from '../components/CourseCard';

// 模拟一周的课程数据 - 明确指定类型
const weekCourses: Course[][] = [
  [
    {
      name: 'HarmonyOS开发基础',
      teacher: '张教授',
      time: '08:00-09:40',
      location: '计算机楼301',
      type: '理论课',
      isFavorite: true, // 标记为收藏
    },
    {
      name: '移动应用开发实践',
      teacher: '李老师',
      time: '10:00-11:40',
      location: '实验楼501',
      type: '实践课',
      isFavorite: false,
    }
  ],
  [
    {
      name: '数据库原理',
      teacher: '王教授',
      time: '09:00-10:40',
      location: '教学楼205',
      type: '理论课',
      isFavorite: true,
    }
  ],
  [{
    name: '软件工程实验',
    teacher: '陈教授',
    time: '09:00-10:40',
    location: '教学楼205',
    type: '理论课',
    isFavorite: false,
  }], [{
  name: '移动应用开发实践',
  teacher: '李老师',
  time: '10:00-11:40',
  location: '实验楼501',
  type: '实践课',
  isFavorite: true,
}], [], [], []
];

@Component
struct CourseSchedulePage {
  @State currentDay: number = 0; // 0-6 对应周一到周日
  private days: string[] = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

  // 计算当前选中日期的课程数量（添加明确返回类型）
  private getCurrentDayCourseCount(): number {
    return weekCourses[this.currentDay].length;
  }

  // 计算当前选中日期的收藏课程数量
  private getFavoriteCourseCount(): number {
    return weekCourses[this.currentDay].filter(course => course.isFavorite).length;
  }

  // 计算当前选中日期的课程总时长（分钟）
  private getTotalCourseDuration(): number {
    let totalMinutes = 0;
    weekCourses[this.currentDay].forEach(course => {
      const timeParts = course.time.split('-');
      const startTime = timeParts[0].split(':');
      const endTime = timeParts[1].split(':');

      const startHour = parseInt(startTime[0]);
      const startMinute = parseInt(startTime[1]);
      const endHour = parseInt(endTime[0]);
      const endMinute = parseInt(endTime[1]);

      const duration = endHour - startHour;
      const durationMinutes = endMinute - startMinute;

      totalMinutes += duration * 60 + durationMinutes;
    });
    return totalMinutes;
  }

  build() {
    // 确保只有一个根容器组件
    Column() {
      // 顶部标题栏
      Row() {

        Image($r('app.media.book'))
          .width(28)
          .height(28)
          .margin({ right: 10 })

        Text('我的课程表')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')

        Blank();

        Text(this.days[this.currentDay])
          .fontSize(16)
          .margin({ left: 10 })
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#007DFF')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start);

      // 日期选择栏
      Row() {
        ForEach(this.days, (day: string, index: number) => { // 添加明确的参数类型
          Text(day)
            .fontSize(14)
            .padding(8)
            .backgroundColor(this.currentDay === index ? '#007DFF' : '#FFFFFF')
            .fontColor(this.currentDay === index ? '#FFFFFF' : '#000000')
            .borderRadius(4)
            .onClick(() => {
              this.currentDay = index;
            });
        });
      }
      .width('100%')
      .padding(8)
      .justifyContent(FlexAlign.SpaceEvenly);

      // 今日课程统计
      Row() {
        Column() {
          Text(this.getCurrentDayCourseCount().toString())
            .fontSize(18)
            .fontColor('#0000FF')
          Text('今日课程')
            .fontSize(14)
        }.flexGrow(1)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text(this.getFavoriteCourseCount().toString())
            .fontSize(18)
            .fontColor('#FF0000')
          Text('收藏课程')
            .fontSize(14)
        }
        .flexGrow(1)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text(`${this.getTotalCourseDuration()}分钟`)
            .fontSize(18)
            .fontColor('#00FF00')
          Text('总时长')
            .fontSize(14)
        }
        .flexGrow(1)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding(10)
      .backgroundColor('#FFFFFF')

      // 如果当天有课程
      if (this.getCurrentDayCourseCount() > 0) {

        // 课程列表
        List() {
          ForEach(weekCourses[this.currentDay], (course: Course) => { // 添加明确的参数类型
            ListItem() {
              CourseCard({ course: course });
            }
          });
        }
        .width('100%')
        .padding(10);
      } else {
        Column() {
          Image($r('app.media.none'))
            .width(80)
            .height(80)
            .margin({ bottom: 16 });

          Text(`${this.days[this.currentDay]}没有课程安排`)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .fontColor('#000000')
            .margin({ bottom: 16 });

          Text(`享受轻松的一天吧！`)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .fontColor('#808080')
        }
        .width('100%')
        .flexGrow(1)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5');
  }
}

@Entry
@Component
struct MainPage {
  build() {
    Navigation() {
      // 确保入口组件有一个根容器组件
      Column() {
        CourseSchedulePage();
      }
      .width('100%')
      .height('100%');
    }
    .title('课程表')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
  }
}
