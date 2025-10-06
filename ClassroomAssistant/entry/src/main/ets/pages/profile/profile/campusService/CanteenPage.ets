@Component
export struct CanteenPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Text('这是食堂页面')
    }
    .title('食堂')
    .hideBackButton(false)
  }
}