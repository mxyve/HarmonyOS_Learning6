import { Course } from './Course';

@Component
export struct CourseCard {
  @Prop course: Course;

  build() {
    Column() {
      Text(this.course.name)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 4 });

      Text(`教师: ${this.course.teacher}`)
        .fontSize(14);

      Text(`时间: ${this.course.time}`)
        .fontSize(14)
        .margin({ top: 2 });

      Text(`地点: ${this.course.location}`)
        .fontSize(14)
        .margin({ top: 2 });

      Text(`类型: ${this.course.type}`)
        .fontSize(14)
        .margin({ top: 2 });
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .shadow({
      radius: 2,
      color: '#00000014',
      offsetX: 0,
      offsetY: 2
    })
    .margin({ bottom: 10 });
  }
}