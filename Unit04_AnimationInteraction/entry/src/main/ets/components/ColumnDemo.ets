@Preview
@Component
export struct ColumnDemo {
  build() {
    Column({ space: 8 }) {
      // 1. 文本，签到
      Text('签到提醒').fontSize(24).fontWeight(FontWeight.Bold)

      // 2. 文本，提醒
      Text('上课前5分钟扫码签到').fontSize(14).fontColor('#666').maxLines(2)


      // 3. 按钮
      Button('详情').margin({ top: 12 }).onClick(() => {
        console.log('允许签到')
      })
      
      //自适应拉伸
      Column() {
        Row() {
          Text('Bluetooth').fontSize(18)
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: true })
        }.backgroundColor(0xFFFFFF).borderRadius(15).padding({ left: 12 }).width('100%')
      }.backgroundColor(0xFFFFFF).padding(20).width('100%')
    }
    .padding(10)
    .width('100%')
    .backgroundColor('#ff5d91bf')
    .borderRadius(12)
    .shadow({ radius: 8, color: '#f00' })
  }
}