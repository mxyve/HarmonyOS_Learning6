// @Preview
@Component
export struct MyButton {
  build() {
   Row({ space: 10 }) {
     Button('主要按钮')
       .type(ButtonType.Normal)
       .backgroundColor('#3698a0')
   }
  }
}