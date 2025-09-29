import { ExplictAnimation } from '../../components/ExplictAnimation'

@Component
export struct ExplictAnimationPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  // 用于绑定输入框内容（双向绑定）
  @State inputValue: string = "";
  // 用于演示密码输入框
  @State passwordValue: string = "";

  build() {
    NavDestination() {
      Column({ space: 25 }) {
        // 1. 页面标题
        Text('动画练习')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333')
          .alignSelf(ItemAlign.Start); // 标题左对齐

        ExplictAnimation();

      }
    }
    .title("动画练习")
    .onBackPressed(() => {
      this.pageInfos.pop();
      return true;
    });
  }
}