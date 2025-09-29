import { StarParticles } from '../../components/StarParticles';

@Component
export struct SignPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State rippleScale: number = 1;
  @State rippleOpacity: number = 0.6;
  @State buttonScale: number = 1;
  @State showRipple: boolean = false;
  @State showCheck: boolean = false;
  @State checkScale: number = 0.5;
  @State checkOpacity: number = 0;
  @State isSigned: boolean = false;
  // 控制星星粒子显示
  @State showStars: boolean = false;

  private buttonSize: number = 90;
  private checkSize: number = 60;

  private handleClick(): void {
    if (this.isSigned) return;

    // 1. 按钮缩放动画
    this.buttonScale = 0.9;
    animateTo(
      { duration: 200 },
      () => {
        this.buttonScale = 1.0;
      }
    );

    // 2. 波纹扩散动画
    this.showRipple = true;
    this.rippleScale = 1;
    this.rippleOpacity = 0.6;
    animateTo(
      { duration: 800 },
      () => {
        this.rippleScale = 1.35;
        this.rippleOpacity = 0;
      }
    );

    // 3. 打勾动画
    this.showCheck = true;
    animateTo(
      {
        duration: 500,
        curve: Curve.EaseOut,
        onFinish: () => {
          this.isSigned = true;
          // 触发星星粒子效果
          this.showStars = true;

          // 打勾显示2秒后隐藏
          setTimeout(() => {
            animateTo(
              {
                duration: 300,
                onFinish: () => {
                  this.showCheck = false;
                  this.checkScale = 0.5;
                  this.checkOpacity = 0;
                  this.showStars = false; // 同时隐藏星星
                }
              },
              () => {
                this.checkScale = 0.8;
                this.checkOpacity = 0;
              }
            );
          }, 2000);
        }
      },
      () => {
        this.checkScale = 1;
        this.checkOpacity = 1;
      }
    );

    // 4. 隐藏波纹
    setTimeout(() => {
      this.showRipple = false;
    }, 800);
  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          // 1. 打勾图标和星星粒子（在上方）
          if (this.showCheck) {
            Text('签到成功')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20 });

            // 使用Stack层叠打勾图标和星星粒子
            Stack() {
              Image($r('app.media.success'))
                .width(this.checkSize)
                .height(this.checkSize)
                .scale({ x: this.checkScale, y: this.checkScale })
                .opacity(this.checkOpacity);

              // 星星粒子组件
              StarParticles({
                show: this.showStars,
                count: 20,
                maxDistance: 120,
                sizeRange: [8, 14],
                durationRange: [1000, 1800]
              })
            }
            .width(this.checkSize)
            .height(this.checkSize)
            .margin({ bottom: 20 });
          }

          // 2. 按钮和波纹（在下方，用Stack层叠）
          Stack({ alignContent: Alignment.Center }) {
            // 波纹效果
            if (this.showRipple) {
              Column()
                .width(this.buttonSize)
                .height(this.buttonSize)
                .borderRadius(this.buttonSize / 2)
                .backgroundColor('#007DFE')
                .opacity(this.rippleOpacity)
                .scale({ x: this.rippleScale, y: this.rippleScale });
            }

            // 签到按钮
            Button('签到', {
              type: ButtonType.Capsule,
              stateEffect: !this.isSigned
            })
              .width(this.buttonSize)
              .height(this.buttonSize)
              .borderRadius(this.buttonSize / 2)
              .fontSize(16)
              .backgroundColor(this.isSigned ? '#E5E7EB' : '#007DFE')
              .fontColor(this.isSigned ? '#9CA3AF' : '#FFFFFF')
              .scale({ x: this.buttonScale, y: this.buttonScale })
              .enabled(!this.isSigned)
              .onClick(() => this.handleClick());
          }
        }
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .title('签到')
  }
}
