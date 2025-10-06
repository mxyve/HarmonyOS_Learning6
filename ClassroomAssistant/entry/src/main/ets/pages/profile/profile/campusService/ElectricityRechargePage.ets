@Component
export struct ElectricityRechargePage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Text('这是电费充值页面')
    }
    .title('电费充值')
    .hideBackButton(false)
  }
}