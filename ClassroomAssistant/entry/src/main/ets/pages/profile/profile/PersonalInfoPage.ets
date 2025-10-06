@Component
export struct PersonalInfoPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State isAvatarPreviewVisible: boolean = false;

  build() {
    NavDestination() {
      Stack() {
        // 主内容
        Column({ space: 24 }) {
          // 头像区域
          Column({ space: 12 }) {
            Text('个人信息')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .textAlign(TextAlign.Start)

            Column({ space: 8 }) {
              Image($r('app.media.img'))
                .width(100)
                .height(100)
                .borderRadius(50)
                .backgroundColor('#F0F0F0')
                .onClick(() => {
                  this.isAvatarPreviewVisible = true;
                })

              Text('点击头像可放大预览')
                .fontSize(12)
                .fontColor('#666666')
            }
            .alignItems(HorizontalAlign.Center)
            .width('100%')
          }
          .width('100%')
          .padding({ top: 16 })

          // 信息列表区域
          Column({ space: 0 }) {
            // 学号行
            Row() {
              Text('学号')
                .fontSize(16)
                .fontColor('#333333')
                .width(80)
                .textAlign(TextAlign.Start)

              Text('20230001')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)
            }
            .width('100%')
            .height(48)
            .padding({ left: 16, right: 16 })
            .border({ width: { bottom: 1 }, color: '#F0F0F0' })

            // 姓名行
            Row() {
              Text('姓名')
                .fontSize(16)
                .fontColor('#333333')
                .width(80)
                .textAlign(TextAlign.Start)

              Text('张三')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)
            }
            .width('100%')
            .height(48)
            .padding({ left: 16, right: 16 })
            .border({ width: { bottom: 1 }, color: '#F0F0F0' })

            // 专业行
            Row() {
              Text('专业')
                .fontSize(16)
                .fontColor('#333333')
                .width(80)
                .textAlign(TextAlign.Start)

              Text('计算机科学与技术')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)
            }
            .width('100%')
            .height(48)
            .padding({ left: 16, right: 16 })
            .border({ width: { bottom: 1 }, color: '#F0F0F0' })

            // 年级行
            Row() {
              Text('年级')
                .fontSize(16)
                .fontColor('#333333')
                .width(80)
                .textAlign(TextAlign.Start)

              Text('2023级')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)
            }
            .width('100%')
            .height(48)
            .padding({ left: 16, right: 16 })
            .border({ width: { bottom: 1 }, color: '#F0F0F0' })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(8)
          .shadow({
            radius: 4,
            color: '#1A000000',
            offsetX: 0,
            offsetY: 2
          })

          // 编辑按钮
          Button('编辑', { type: ButtonType.Normal })
            .width('90%')
            .height(44)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .backgroundColor('#007DFF')
            .fontColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              console.log('点击了编辑按钮');
            })

          // 空白区域填充
          Blank()
        }
        .width('100%')
        .height('100%')
        .padding(20)
        .alignItems(HorizontalAlign.Center)

        // 头像放大预览层
        if (this.isAvatarPreviewVisible) {
          Column() {
            Image($r('app.media.img'))
              .width('80%')
              .height('80%')
              .objectFit(ImageFit.Contain)
              .borderRadius(8)
          }
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.8)')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.isAvatarPreviewVisible = false;
          })
        }
      }
      .backgroundColor('#F5F5F5')
    }
    .title('个人信息')
    .hideBackButton(false)
  }
}