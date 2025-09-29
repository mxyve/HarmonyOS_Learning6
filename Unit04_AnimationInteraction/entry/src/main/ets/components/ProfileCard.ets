// 自定义个人信息卡片组件
@Preview
@Component
export struct ProfileCard {
  // 定义接收的个人信息属性，设置默认值
  nickname: string = "默认昵称";
  avatar: Resource = $r('app.media.img');
  status: string = "在线";
  level: string = "Lv.1";
  signature: string = "这个人很神秘，没有留下签名";

  build() {
    Column() {
      // 头像区域
      Image(this.avatar)
        .width(80)
        .height(80)
        .borderRadius(50) // 圆形头像
        .objectFit(ImageFit.Cover)
        .border({ width: 3, color: "#f0f0f0" })
        .margin({ top: 20 })

      // 昵称和状态
      Column({ space: 8 }) {
        Text(this.nickname)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 15 })

        Row({ space: 5 }) {
          Text(this.status)
            .fontSize(14)
            .fontColor(this.status === "在线" ? "#00b42a" : "#666666")

          Text(this.level)
            .fontSize(12)
            .fontColor("#3698a0")
            .backgroundColor("#e6f7f0")
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
        }

        // 个性签名
        Text(this.signature)
          .fontSize(14)
          .fontColor("#666666")
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width("80%")
          .margin({ top: 5 })
      }
    }
    .width("100%")
    .backgroundColor("#ffffff")
    .borderRadius(12)
    .shadow({ radius: 6, color: "#00000010", offsetY: 2 })
    .padding({ bottom: 25 })
  }
}
