@Preview
@Component
export struct RowDemo {
  build() {
    Row({ space: $r('app.float.row_demo_space') }) {
      // 1. 图片
      Image($r('app.media.img2'))
        .width($r('app.float.row_demo_image_size'))
        .height($r('app.float.row_demo_image_size'));

      // 2. 文本框
      Text('鸿蒙开发')
        .fontSize($r('app.float.row_demo_text_font_size'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.row_demo_text_color'))
        .layoutWeight(1);

      // 3. 按钮
      Button('详情')
        .type(ButtonType.Capsule)
        .width($r('app.float.row_demo_button_width'))
        .fontColor($r('app.color.row_demo_button_text_color'))
        .backgroundColor($r('app.color.row_demo_button_bg_color'));
    }
    .padding({ left: $r('app.float.row_demo_padding_horizontal'), right: $r('app.float.row_demo_padding_horizontal') })
    .width($r('app.float.row_demo_container_width'))
    .height($r('app.float.row_demo_container_height'))
    .backgroundColor($r('app.color.row_demo_bg_color'));
  }
}