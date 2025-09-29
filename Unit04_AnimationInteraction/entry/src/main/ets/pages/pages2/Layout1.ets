import { RowDemo } from '../../components/RowDemo'
import { FlexDemo } from '../../components/FlexDemo'
import { ColumnDemo } from '../../components/ColumnDemo'
@Component
export struct Layout1 {
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
        Text('Layout1 综合布局示例')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333')
          .alignSelf(ItemAlign.Start); // 标题左对齐

        // 2. 引入 RowDemo 组件
        RowDemo();

        // 3. 引入 FlexDemo 组件
        FlexDemo();

        // 4. 引入 ColumnDemo 组件
        ColumnDemo();
      }
    }
    .title("TextInput 组件详情")
    .onBackPressed(() => {
      this.pageInfos.pop();
      return true;
    });
  }
}