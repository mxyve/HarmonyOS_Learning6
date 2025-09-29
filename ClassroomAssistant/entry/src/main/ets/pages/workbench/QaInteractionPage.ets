
@Component
export struct QaInteractionPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State message: string = 'Hello World';

  build() {
    NavDestination() {

    }
    .title('Workbench')

  }
}