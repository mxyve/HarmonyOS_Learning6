@Component
export struct GymPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Text('这是体育馆页面')
    }
    .title('体育馆')
    .hideBackButton(false)
  }
}