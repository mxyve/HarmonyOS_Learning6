import { GridDemo } from '../../components/GridDemo'
import { StackDemo } from '../../components/StackDemo'

@Component
export struct Layout2 {
  @Consume('pageInfos') pageInfos: NavPathStack;
  // 用于绑定输入框内容（双向绑定）
  @State inputValue: string = "";
  // 用于演示密码输入框
  @State passwordValue: string = "";

  build() {
    NavDestination() {
      Column({ space: 25 })
      {
        // 1. 页面标题
        Text('Layout2 二维布局示例')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333')
          .alignSelf(ItemAlign.Start); // 标题左对齐

        StackDemo();

        GridDemo();


      }
    }
    .title("布局组件详情")
    .onBackPressed(() => {
      this.pageInfos.pop();
      return true;
    });
  }
}