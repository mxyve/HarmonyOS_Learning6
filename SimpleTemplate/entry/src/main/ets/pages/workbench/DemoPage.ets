@Component
export struct DemoPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
     Text('Hello')
    }
    .title('签到')
  }
}
