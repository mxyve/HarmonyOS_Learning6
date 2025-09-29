import { Page1 } from '../../components/Page1'
import { Page2 } from '../../components/Page2'

@Component
export struct PageComponentPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Column({ space: 25 }) {

        Page1();
        // Page2();

      }
    }
    .title("专场动画练习")
    .onBackPressed(() => {
      this.pageInfos.pop();
      return true;
    });
  }
}