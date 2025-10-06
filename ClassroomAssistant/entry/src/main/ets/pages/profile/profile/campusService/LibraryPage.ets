@Component
export struct LibraryPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Text('这是图书馆页面')
    }
    .title('图书馆')
    .hideBackButton(false)
  }
}