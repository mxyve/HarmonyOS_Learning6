// 星星粒子接口定义
interface StarParticle {
  id: number;
  x: number;
  y: number;
  size: number;
  isSolid: boolean;
  opacity: number;
  speed: number;
  angle: number;
  createdAt: number;
  life: number;
}

@Component
export struct StarSuccess {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State stars: Array<StarParticle> = [];
  private starId: number = 0;
  private isAnimating: boolean = false;
  private animationTimer: number = 0;

  aboutToAppear() {
    this.startAnimation();
  }

  aboutToDisappear() {
    this.stopAnimation();
  }

  // 启动动画
  startAnimation() {
    if (this.isAnimating) {
      return;
    }
    this.isAnimating = true;

    // 初始生成星星
    this.generateInitialStars();

    // 开始动画循环
    this.animateStars();
  }

  // 停止动画
  stopAnimation() {
    this.isAnimating = false;
    if (this.animationTimer) {
      clearTimeout(this.animationTimer);
    }
  }

  // 生成初始星星
  generateInitialStars() {
    for (let i = 0; i < 15; i++) {
      setTimeout(() => {
        this.createStar();
      }, i * 100);
    }
  }

  // 创建星星粒子
  createStar() {
    const centerX = 180; // 中心点X坐标
    const centerY = 180; // 中心点Y坐标
    const angle = Math.random() * Math.PI * 2;
    const distance = Math.random() * 30 + 10;
    const size = Math.random() * 8 + 6;
    const life = 1500 + Math.random() * 1000;

    const star: StarParticle = {
      id: this.starId++,
      x: centerX + Math.cos(angle) * distance,
      y: centerY + Math.sin(angle) * distance,
      size: size,
      isSolid: Math.random() > 0.3,
      opacity: 1,
      speed: Math.random() * 1.5 + 0.5,
      angle: angle,
      createdAt: Date.now(),
      life: life
    };
    this.stars.push(star);
  }

  // 动画循环
  animateStars() {
    if (!this.isAnimating) {
      return;
    }

    const now = Date.now();
    const newStars: Array<StarParticle> = [];

    // 更新现有星星状态
    this.stars.forEach((star) => {
      const age = now - star.createdAt;

      if (age < star.life) {
        // 向外移动
        const progress = age / star.life;
        const distance = 80 * progress; // 最大移动距离
        star.x = 180 + Math.cos(star.angle) * distance;
        star.y = 180 + Math.sin(star.angle) * distance;

        // 透明度衰减
        star.opacity = 1 - progress * progress; // 二次方衰减更自然

        newStars.push(star);
      }
    });

    this.stars = newStars;

    // 随机添加新星星
    if (Math.random() < 0.3 && this.stars.length < 25) {
      this.createStar();
    }

    // 继续动画循环
    this.animationTimer = setTimeout(() => {
      this.animateStars();
    }, 16); // 约60fps

  }

  build() {
    NavDestination() {
      Column() {
        Stack() {
          // 绿色圆形背景
          Circle()
            .width(160)
            .height(160)
            .fill('#4CAF50')
            .shadow({
              radius: 10,
              color: '#000000',
              offsetX: 0,
              offsetY: 4
            })

          // 对勾图标
          this.BuildCheckmark()


          // 星星粒子层（在背景之上，对勾之下）
          ForEach(this.stars, (star: StarParticle) => {
            this.BuildStar(star)
          }, (star: StarParticle) => star.id.toString())
        }
        .width(200)
        .height(200)
        .margin({ bottom: 30 })

        // 签到成功文字
        Text('签到成功!')
          .fontSize(28)
          .fontColor('#4CAF50')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10 })

        Text('积分+10')
          .fontSize(16)
          .fontColor('#666666')

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F9FA')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .title('签到成功')
  }

  @Builder
  BuildCheckmark() {
    Column() {
      Path()
        .commands('M10,30 L25,45 L50,20')
        .stroke(Color.White)
        .strokeWidth(6)
        .fill(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  BuildStar(star: StarParticle) {
    Column() {
      if (star.isSolid) {
        // 实心星星
        Text('★')
          .fontSize(star.size)
          .fontColor('#FFD700') // 金色
      } else {
        // 空心星星
        Text('☆')
          .fontSize(star.size)
          .fontColor('#FFA500') // 橙色
      }
    }
    .opacity(star.opacity)
    .position({ x: star.x - star.size / 2, y: star.y - star.size / 2 })
  }
}
