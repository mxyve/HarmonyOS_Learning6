@Component
export struct LostFoundPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Text('这是失物招领页面')
    }
    .title('失物招领')
    .hideBackButton(false)
  }
}