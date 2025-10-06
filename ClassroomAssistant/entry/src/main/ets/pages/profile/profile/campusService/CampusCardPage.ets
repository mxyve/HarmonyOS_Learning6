@Component
export struct CampusCardPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Text('这是校园卡页面')
    }
    .title('校园卡')
    .hideBackButton(false)
  }
}