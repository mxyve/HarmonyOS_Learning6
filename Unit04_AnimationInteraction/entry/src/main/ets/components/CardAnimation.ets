@Component
@Preview
export struct CardAnimation {
  // 状态：是否展开
  @State private isExpanded: boolean = false;
  // 动画属性：控制卡片垂直偏移（底部 ↔ 中间）
  @State private translateY: number = 0;
  // 动画属性：控制内容透明度（淡入淡出）
  @State private contentOpacity: number = 0;
  // 动画公共配置
  private readonly ANIMATION_DURATION: number = 800;
  private readonly ANIMATION_CURVE: Curve = Curve.EaseInOut;
  // 任务列表
  private readonly tasks: string[] = [
    '任务一',
    '任务二',
    '任务三'
  ];

  build() {
    // 在Stack容器上添加底部padding: 5px，使卡片距离底部5px
    Stack({ alignContent: Alignment.Bottom }) {
      // 背景占位，方便观察卡片滑动
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F5');

      // 卡片
      Column() {
        // 标题栏（始终可见）
        Row() {
          Text('今日待办')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333');
        }
        .width('100%')
        .padding(16)
        .justifyContent(FlexAlign.Center)
        .onClick(() => this.toggleCard());

        // 展开时才显示的任务列表
        if (this.isExpanded) {
          Column() {
            ForEach(this.tasks, (task: string) => {
              Row() {
                Text('•  ' + task)
                  .fontSize(14)
                  .fontColor('#555')
                  .padding({ left: 16, bottom: 8 });
              }
              .width('100%');
            });
          }
          .opacity(this.contentOpacity);
        }
      }
      .width('90%')
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({
        radius: 8,
        color: 'rgba(0,0,0,0.08)'
      })
      .translate({ y: this.translateY })
      .transition({
        type: TransitionType.All,
        opacity: 0,
        scale: { x: 0.9, y: 0.9 }
      })
      .onClick(() => this.toggleCard());
    }
    .width('100%')
    .height('100%')
    .padding({ bottom: 5 }); // 关键修改：设置底部内边距为5px
  }

  // 切换展开/收起
  private toggleCard(): void {
    const targetExpanded: boolean = !this.isExpanded;

    // 1. 先触发位置动画
    animateTo({
      duration: this.ANIMATION_DURATION,
      curve: this.ANIMATION_CURVE,
      onFinish: () => {
        // 3. 位置动画结束后更新展开状态，触发列表的插入/删除
        this.isExpanded = targetExpanded;
      }
    }, () => {
      this.translateY = targetExpanded ? -300 : 0; // 上移 300vp 到中间
    });

    // 2. 内容透明度动画（与位置动画并行）
    animateTo({
      duration: this.ANIMATION_DURATION,
      curve: this.ANIMATION_CURVE
    }, () => {
      this.contentOpacity = targetExpanded ? 1 : 0;
    });
  }
}
