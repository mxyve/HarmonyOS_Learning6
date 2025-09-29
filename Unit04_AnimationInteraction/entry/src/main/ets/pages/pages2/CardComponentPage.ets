import { CardAnimation } from '../../components/CardAnimation'

@Component
export struct CardComponentPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  // 用于绑定输入框内容（双向绑定）
  @State inputValue: string = "";
  // 用于演示密码输入框
  @State passwordValue: string = "";

  build() {
    NavDestination() {
      Column({ space: 25 }) {
        CardAnimation();

      }
    }
    .title("动画练习2")
    .onBackPressed(() => {
      this.pageInfos.pop();
      return true;
    });
  }
}