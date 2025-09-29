// 应用的入口组件
@Entry
  // 表明这是一个 ArkUI 组件
@Component
  // 定义了一个名为 Index 的结构体组件
struct Index {
  // @State 装饰器意味着当该变量值发生变化时，会自动触发 UI 刷新
  @State message: string = 'Hello World';

  // 组件的 UI 构建函数，用于描述 UI 结构
  build() {
    // 相对布局容器，内部元素可以相对于容器或其他元素进行定位
    RelativeContainer() {
      // 文本组件
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        // 设置文本在相对容器中的定位：垂直方向居中、水平方向居中
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        // 点击事件，当用户点击文本时，UI会自动更新显示新内容
        .onClick(() => {
          this.message = 'Welcome';
        })
    }
    .height('100%')
    .width('100%')
  }
}
