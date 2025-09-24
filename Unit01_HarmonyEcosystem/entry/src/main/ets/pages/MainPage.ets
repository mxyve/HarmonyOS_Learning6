
// @Entry装饰器标识这是应用的入口组件
@Entry
// @Component装饰器标识这是一个UI组件
@Component
@Preview
struct MainPage {
  // @State装饰器标识这是一个状态变量，当它发生变化时UI会自动更新
  @State title: string = 'Hello HarmonyOS'

  // build方法定义UI结构
  build() {
    Navigation() {
      Column() {
        Text(this.title)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)

        Button('点击我')
          .onClick(() => {
            // 当状态变量改变时，UI会自动更新
            this.title = '你好，鸿蒙！'
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('基础装饰器')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
  }
}