@Component
export struct HomeworkSubmissionPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  // 状态管理
  @State submissionState: 'ready' | 'submitting' | 'completed' = 'ready';
  @State progress: number = 0;
  @State buttonWidth: number = 150; // 按钮初始宽度
  @State buttonHeight: number = 48; // 按钮高度

  build() {
    NavDestination() {
      Column() {

        // 提交按钮区域 - 使用Stack实现状态切换
        Stack() {
          // 1. 初始状态：提交按钮
          Button('提交作业')
            .width(this.submissionState === 'ready' ? this.buttonWidth : 0)
            .height(this.buttonHeight)
            .borderRadius(24)
            .backgroundColor('#007AFF')
            .fontColor('#FFFFFF')
            .visibility(this.submissionState === 'ready' ? Visibility.Visible : Visibility.Hidden)
            .animation({
              duration: 300,
              curve: Curve.EaseInOut
            })
            .onClick(() => this.startSubmission())

          // 2. 提交中状态：进度条 - 修正类型定义方式
          Progress({
            value: this.progress,
            total: 100,
            type: ProgressType.Linear
          })
            .width(this.submissionState === 'submitting' ? this.buttonWidth : 0)
            .height(this.buttonHeight)
            .borderRadius(24)
            .backgroundColor('#EEEEEE')
            .color('#007AFF')
            .visibility(this.submissionState === 'submitting' ? Visibility.Visible : Visibility.Hidden)
            .animation({
              duration: 300,
              curve: Curve.EaseInOut
            })

          // 3. 完成状态：绿色勾号
          Image($r('app.media.success')) // 请确保有绿色勾号图标资源
            .width(this.submissionState === 'completed' ? this.buttonHeight : 0)
            .height(this.buttonHeight)
            .objectFit(ImageFit.Contain)
            .visibility(this.submissionState === 'completed' ? Visibility.Visible : Visibility.Hidden)
            .animation({
              duration: 300,
              curve: Curve.EaseInOut
            })
        }
        .margin({ bottom: 100 })
      }
      .width('100%')
      .height('100%')
    }
    .title('作业提交')
  }

  // 开始提交流程
  private startSubmission() {
    // 从准备状态切换到提交中状态
    this.submissionState = 'submitting';

    // 模拟进度更新
    const updateProgress = () => {
      if (this.progress < 100) {
        // 随机增加进度，模拟真实提交过程
        this.progress += Math.floor(Math.random() * 10) + 1;
        // 限制在100以内
        if (this.progress > 100) this.progress = 100;
        // 继续更新进度
        setTimeout(updateProgress, 200);
      } else {
        // 进度完成后切换到完成状态
        setTimeout(() => {
          this.submissionState = 'completed';
        }, 500);
      }
    };

    // 开始更新进度
    updateProgress();
  }
}
