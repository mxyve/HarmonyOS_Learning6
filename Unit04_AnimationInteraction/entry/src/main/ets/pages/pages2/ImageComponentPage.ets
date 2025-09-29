@Component
export struct ImageComponentPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 30 }) {
          // 标题
          Text("Image组件示例")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .alignSelf(ItemAlign.Start)

          // 1. 基本图片展示
          Column() {
            Text("1. 基本图片展示")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 15 })
              .alignSelf(ItemAlign.Start)

            Image($r('app.media.img2')) // 使用本地资源app.media.img2
              .alt('示例图片') // 图片加载失败时显示的文本
              .width(300)
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(8)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(10)

          // 2. 不同大小的图片
          Column() {
            Text("2. 不同大小的图片")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 15 })
              .alignSelf(ItemAlign.Start)

            Row({ space: 10 }) {
              Image($r('app.media.img2')) // 使用本地资源app.media.img2
                .alt('小图片')
                .width(100)
                .height(100)
                .objectFit(ImageFit.Contain)
                .borderRadius(4)
                .backgroundColor('#EEEEEE')

              Image($r('app.media.img2')) // 使用本地资源app.media.img2
                .alt('中图片')
                .width(150)
                .height(150)
                .objectFit(ImageFit.Contain)
                .borderRadius(4)
                .backgroundColor('#EEEEEE')

              Image($r('app.media.img2')) // 使用本地资源app.media.img2
                .alt('大图片')
                .width(200)
                .height(200)
                .objectFit(ImageFit.Contain)
                .borderRadius(4)
                .backgroundColor('#EEEEEE')
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(10)

          // 3. 圆形图片
          Column() {
            Text("3. 圆形图片")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 15 })
              .alignSelf(ItemAlign.Start)

            Row({ space: 30 }) {
              // 圆形图片
              Image($r('app.media.img2')) // 使用本地资源app.media.img2
                .alt('圆形图片1')
                .width(120)
                .height(120)
                .borderRadius(60)
                .objectFit(ImageFit.Cover)

              // 带边框的圆形图片
              Image($r('app.media.img2')) // 使用本地资源app.media.img2
                .alt('圆形图片2')
                .width(120)
                .height(120)
                .borderRadius(60)
                .objectFit(ImageFit.Cover)
                .border({ width: 4, color: '#007AFF' })
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(10)

          // 4. 图片加载模式
          Column() {
            Text("4. 不同图片适配模式")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 15 })
              .alignSelf(ItemAlign.Start)

            Column({ space: 15 }) {
              // 拉伸填充
              Column() {
                Text("ImageFit.Fill - 拉伸填充")
                  .fontSize(14)
                  .margin({ bottom: 5 })
                Image($r('app.media.img2')) // 使用本地资源app.media.img2
                  .alt('拉伸填充模式')
                  .width('100%')
                  .height(100)
                  .objectFit(ImageFit.Fill)
                  .borderRadius(4)
                  .backgroundColor('#EEEEEE')
              }

              // 保持比例适应
              Column() {
                Text("ImageFit.Contain - 保持比例适应")
                  .fontSize(14)
                  .margin({ bottom: 5 })
                Image($r('app.media.img2')) // 使用本地资源app.media.img2
                  .alt('保持比例适应模式')
                  .width('100%')
                  .height(100)
                  .objectFit(ImageFit.Contain)
                  .borderRadius(4)
                  .backgroundColor('#EEEEEE')
              }

              // 保持比例覆盖
              Column() {
                Text("ImageFit.Cover - 保持比例覆盖")
                  .fontSize(14)
                  .margin({ bottom: 5 })
                Image($r('app.media.img2')) // 使用本地资源app.media.img2
                  .alt('保持比例覆盖模式')
                  .width('100%')
                  .height(100)
                  .objectFit(ImageFit.Cover)
                  .borderRadius(4)
                  .backgroundColor('#EEEEEE')
              }
            }
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(10)

          // 5. 带点击效果的图片
          Column() {
            Text("5. 可交互图片")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 15 })
              .alignSelf(ItemAlign.Start)

            Image($r('app.media.img2')) // 使用本地资源app.media.img2
              .alt('可点击图片')
              .width('100%')
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(8)
              .onClick(() => {
                console.log('图片被点击了');
              })
              .gesture(
                TapGesture()
                  .onAction(() => {
                    console.log('图片被点击（手势）');
                  })
              )
              .overlay('点击查看详情', {
                align: Alignment.Bottom,
                offset: { x: 0, y: -10 }
              })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(10)
        }
        .width('100%')
        .padding(20)
      }
    }
    .title("Image 组件详情")
    .onBackPressed(() => {
      this.pageInfos.pop();
      return true;
    });
  }
}
