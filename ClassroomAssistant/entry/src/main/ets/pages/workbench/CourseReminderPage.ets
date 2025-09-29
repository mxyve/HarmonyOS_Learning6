@Component
export struct CourseReminderPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  // 控制卡片显示状态的变量
  @State isCardVisible: boolean = false;
  // 卡片位置的动画变量
  @State cardPosition: number = 100; // 初始位置在屏幕底部外
  @State cardOpacity: number = 0;    // 初始透明度为0

  aboutToAppear() {
    // 页面加载后延迟一点时间再显示卡片，增强效果
    setTimeout(() => {
      this.isCardVisible = true;

      // 第一个动画：卡片从底部滑入
      animateTo({
        duration: 800,
        curve: Curve.Sharp, // 先快后慢的曲线
        iterations: 1
      }, () => {
        this.cardPosition = 0; // 移动到正常位置
        this.cardOpacity = 1;  // 完全显示
      });

      // 延迟第一个动画的时长后执行弹性动画
      setTimeout(() => {
        // 弹性动画1：轻微上弹
        animateTo({
          duration: 200,
          curve: Curve.EaseOut
        }, () => {
          this.cardPosition = -10; // 轻微上弹
        });

        // 延迟弹性动画1的时长后执行最后一个动画
        setTimeout(() => {
          // 弹性动画2：回到正常位置
          animateTo({
            duration: 150,
            curve: Curve.EaseIn
          }, () => {
            this.cardPosition = 0; // 回到正常位置
          });
        }, 200); // 与弹性动画1的duration保持一致
      }, 800); // 与第一个动画的duration保持一致
    }, 500); // 延迟500ms显示，避免与页面加载冲突
  }

  build() {
    NavDestination() {
      Stack() {

        // 提醒卡片 - 带滑入动画
        if (this.isCardVisible) {
          Column() {
            Text('课程提醒')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin(15)

            Text('数学课程将在30分钟后开始')
              .fontSize(14)
              .margin({ left: 15, right: 15, bottom: 15 })

            Button('知道了')
              .width(120)
              .height(40)
              .margin({ bottom: 15 })
              .onClick(() => {
                this.isCardVisible = false;
              })
          }
          .width('90%')
          .backgroundColor('#ffffff')
          .borderRadius(12)
          .shadow({ radius: 10, color: '#00000010', offsetX: 0, offsetY: 2 })
          .position({ x: '5%', y: `calc(100% - ${this.cardPosition}% - 200px)` })
          .opacity(this.cardOpacity)
          .transition({ type: TransitionType.All })
        }
      }
      .height('100%')
      .width('100%')
    }
    .title('课程提醒')
  }
}
