@Component
export struct InfirmaryPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Text('这是医务室页面')
    }
    .title('医务室')
    .hideBackButton(false)
  }
}