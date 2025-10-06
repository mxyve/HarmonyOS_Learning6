@Component
export struct TeachingBuildingPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Text('这是教学楼页面')
    }
    .title('教学楼')
    .hideBackButton(false)
  }
}