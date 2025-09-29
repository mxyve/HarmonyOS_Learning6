@Component
export struct Page2 {
  @State scale1: number = 1;
  @State opacity1: number = 1;
  // 同样接收导航栈
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    Column() {
      Button("返回页面1")
        .onClick(() => {
          // 弹出当前页面，回到上一页（Page1）
          this.pageInfos.pushPath({ name: 'Page1' });
        })
        .width(200)
        .height(60)
        .fontSize(36)

      Text("END")
        .fontSize(36)
        .textAlign(TextAlign.Center)
    }
    .scale({ x: this.scale1 })
    .opacity(this.opacity1)
    .height("100%")
    .width("100%")
    .backgroundColor(Color.Gray)
    .justifyContent(FlexAlign.Center)
  }

  pageTransition() {
    PageTransitionEnter({ duration: 200 }).slide(SlideEffect.Right)
    PageTransitionExit({ delay: 100 }).slide(SlideEffect.Right)
  }
}