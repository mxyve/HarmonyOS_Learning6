@Component
@Preview
export struct ExplictAnimation {
  // 圆形的状态变量
  @State isCircleMoved: boolean = false;
  // 矩形的状态变量
  @State isRectMoved: boolean = false;
  @State color: string = '#2196F3';
  @State rotateAngle: number = 0;
  @State _scale: number = 1;

  build() {
    Column({ space: 15 }) {
      Text('显示动画演示')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 圆形控制按钮和元素
      Button('移动圆形').onClick(() => {
        this.isCircleMoved = !this.isCircleMoved;
      })

      Circle({ width: 60, height: 60 })
        .fill('#ff4fa9e3')
        .translate({ x: this.isCircleMoved ? 100 : 0, y: 0 })
        .animation({
          duration: 1000,
          curve: Curve.Smooth
        })

      // 矩形控制按钮和元素
      Button('移动并变色矩形').onClick(() => {
        this.isRectMoved = !this.isRectMoved;
      })

      // 矩形元素
      Row()
        .width(60)
        .height(60)
        // 根据状态切换颜色：蓝色→红色
        .backgroundColor(this.isRectMoved ? '#ff0000' : '#0000ff')
        // 根据状态切换位置
        .translate({ x: this.isRectMoved ? 100 : 0, y: 0 })
        .animation({
          duration: 1000,
          curve: Curve.Smooth
        })

      Button('角度变化')
        .onClick(() => {
          this.rotateAngle = 90
        })
        .margin(50)
        .rotate({ angle: this.rotateAngle })
        .animation({
          duration: 1000,
          curve: Curve.Friction,
          delay: 500,
          iterations: -1,
          playMode: PlayMode.Alternate,
          expectedFrameRateRange: {
            min: 20,
            max: 120,
            expected: 90,
          }
        })

      Text('心跳动画示例')
        .fontSize(20).fontWeight(FontWeight.Bold).padding(10)
      Image($r('app.media.heart'))
        .width(100)
        .height(100)
        .scale({ x: this._scale, y: this._scale })
        .animation({
          duration: 1000,
          curve: Curve.Friction, // 阻尼动画，先快后慢，模拟摩擦减速
          delay: 500, // 动画延迟 500ms 开始
          iterations: -1, // 无限循环
          playMode: PlayMode.Alternate, // 交替播放：放大 ➡ 缩小 ➡ 放大...
          expectedFrameRateRange: {
            min: 20, // 最低帧率 20fps (保证地段低端设备不卡死)
            max: 120, // 最高帧率 120fps (支持高刷屏)
            expected: 90 // 期望运行在 90fps 左右
          }
        })
        .onAppear(() => {
          // // 出现后触发动画：切换状态
          // setInterval(() => {
          //   this._scale = this._scale === 1 ? 1.3 : 1
          // }, 200)
          // 可以简写成以下形式
          this._scale = 1.3
        })

    }
    .padding(6)
    .width('100%')
    .height('100%')
  }
}
