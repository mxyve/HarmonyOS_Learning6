import router from '@ohos.router'; // 导入路由模块，用于返回

@Component
@Entry
struct DemoPage {
  build() {
    Navigation(){
      Column({ space: 16 }) {
        Text('HarmonyOS Next')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)

        // 添加一个返回按钮，方便测试
        Button('返回首页')
          .onClick(() => {
            router.back();
          })
      }
      .padding(16)
      .width('100%')
      .height('100%')
    }
    .title('Demo Page')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
  }
}
