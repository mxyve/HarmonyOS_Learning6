// @Preview
@Component
export struct MyButton {
  // 定义接收的属性：按钮文字和背景色，设置默认值
  label: string = '默认按钮';
  bgColor: string = '#3698a0';

  build() {
    Row({ space: 10 }) {
      Button(this.label)  // 使用传递过来的文字
        .type(ButtonType.Normal)
        .backgroundColor(this.bgColor)  // 使用传递过来的底色
    }
  }
}
