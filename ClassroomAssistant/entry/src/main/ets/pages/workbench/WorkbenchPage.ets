
@Component
export struct WorkbenchPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State message: string = 'Hello World';

  build() {
    NavDestination() {
      Row() {
        Text(this.message)
          .fontSize(30)
      }
      .height('100%')
      .width('100%')
    }
    .title('Workbench')

  }
}