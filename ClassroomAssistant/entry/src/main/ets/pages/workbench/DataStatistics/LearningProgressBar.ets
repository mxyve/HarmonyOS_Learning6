@Component
export struct LearningProgressBar {
  @State private progress: number = 0;   // 0~100

  aboutToAppear() {
    this.startEaseAnimation();
  }

  build() {
    Column({ space: 12 }) {
      // 进度条容器 - 使用Stack的alignContent属性设置对齐方式
      Stack() {
        // 背景槽
        Row()
          .width('100%')
          .height(12)
          .borderRadius(6)
          .backgroundColor('#E4E4E4')

        // 填充条（从左到右展开）
        Row()
          .width(this.progress + '%')
          .height(12)
          .borderRadius(6)
          .backgroundColor('#00BBFF')
          .animation({
            duration: 2000,
            curve: Curve.EaseInOut,
            delay: 300
          })
      }
      .width('80%')
      .alignContent(Alignment.Start)  // Stack使用alignContent配合Alignment枚举

      // 百分比文字
      Text(`${Math.round(this.progress)} %`)
        .fontSize(18)
        .fontColor('#666')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  private startEaseAnimation(): void {
    this.progress = 0;
    setTimeout(() => {
      this.progress = 80;
    }, 50);
  }
}
    