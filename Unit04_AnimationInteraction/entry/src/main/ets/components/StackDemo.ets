@Component
@Preview
export struct StackDemo {
  @Prop avatarUrl: string = 'https://mjzhcx.oss-cn-beijing.aliyuncs.com/image/20250914/a7e5325c7904445c9f41622f6249cee6_%E5%A4%B4%E5%83%8F13.jpg'
  @Prop username: string = '张三'
  @State hasNewMsg: boolean = true // 是否有消息

  build() {
      Stack({ alignContent: Alignment.TopEnd }) {
        // 底层：头像
        Image(this.avatarUrl || $r('app.media.img'))
          .width(60)
          .height(60)
          .borderRadius(30)
          .border({
            width: 2,
            color: Color.Red
          })

        // 消息徽章背景，红色圆定位到左上角
        if (this.hasNewMsg) {
          Circle({ width: 18, height: 18 }).fill(Color.Red).position({ x: 50, y: 0 })
          Text('8').fontSize(10).fontColor(Color.White).position({ x: 55, y:4 })
        }

        Text(this.username)
         .fontSize(16)
         .fontColor(Color.Black)
         .position({ x: 8, y: 65 })
          .width(60)
          .textAlign(TextAlign.Center)
      }
      .width(78)
      .height(90)
    }
}