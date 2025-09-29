// 1. 定义星星样式的接口（明确类型约束，解决未类型化对象报错）
interface StarStyle {
  fontSize: number;
  color: string;
  margin: number;
}

@Component
export struct StarDisplay {
  @Consume('pageInfos') pageInfos: NavPathStack;
  // 2. 状态变量：控制星星显示/隐藏
  @State showStars: boolean = false;

  // 3. 修复：结构体成员变量需用访问修饰符（private/public）声明，不能用const
  // 这里用private确保样式仅内部使用，同时通过StarStyle接口约束类型
  private starStyle: StarStyle = {
    fontSize: 30,
    color: '#FFD700', // 金色星星
    margin: 4         // 星星间间距
  };

  build() {
    NavDestination() {
      Column() {
        // 显示区域标题
        Text('星星显示区域')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 50, bottom: 20 })

        // 固定的星星显示容器（位置固定，带边框提示）
        Column() {
          if (this.showStars) {
            // 横向排列5个星星
            Row() {
              Text('★')
                .fontSize(this.starStyle.fontSize)
                .fontColor(this.starStyle.color)
                .margin(this.starStyle.margin)

              Text('★')
                .fontSize(this.starStyle.fontSize)
                .fontColor(this.starStyle.color)
                .margin(this.starStyle.margin)

              Text('★')
                .fontSize(this.starStyle.fontSize)
                .fontColor(this.starStyle.color)
                .margin(this.starStyle.margin)

              Text('★')
                .fontSize(this.starStyle.fontSize)
                .fontColor(this.starStyle.color)
                .margin(this.starStyle.margin)

              Text('★')
                .fontSize(this.starStyle.fontSize)
                .fontColor(this.starStyle.color)
                .margin(this.starStyle.margin)
            }
          } else {
            // 未显示星星时的提示文本
            Text('点击下方按钮显示星星')
              .fontSize(14)
              .fontColor('#666666') // 灰色提示，降低视觉权重
          }
        }
        .width('90%')
        .height(80)
        .border({ width: 1, color: '#EEEEEE', radius: 8 }) // 浅色边框，明确显示区域
        .justifyContent(FlexAlign.Center) // 内容垂直居中
        .alignItems(HorizontalAlign.Center) // 内容水平居中
        .margin({ bottom: 30 })

        // 控制按钮（点击切换星星状态）
        Button('显示/隐藏星星')
          .fontSize(16)
          .width(200)
          .height(45)
          .backgroundColor('#007DFE') // 蓝色按钮，符合常见交互风格
          .fontColor('#FFFFFF') // 白色文字，提高对比度
          .onClick(() => {
            // 切换showStars状态（显示→隐藏，隐藏→显示）
            this.showStars = !this.showStars;
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start) // 整体内容靠上排列
      .alignItems(HorizontalAlign.Center) // 整体内容水平居中
      .padding(16) // 避免内容贴边
    }
  }
}