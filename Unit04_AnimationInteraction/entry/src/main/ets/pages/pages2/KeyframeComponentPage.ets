import { KeyframeAnimationPage } from '../../components/KeyframeAnimationPage'

@Component
export struct KeyframeComponentPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Column({ space: 25 }) {

        KeyframeAnimationPage();

      }
    }
    .title("关键帧动画练习")
    .onBackPressed(() => {
      this.pageInfos.pop();
      return true;
    });
  }
}