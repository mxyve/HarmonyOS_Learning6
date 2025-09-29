import { Particle } from './Particle';

@Component
export struct ClassroomRewards2 {
  @State private showScore: boolean = false;
  @State private score: number = 95;
  @State private particles: Particle[] = [];

  private readonly colors: string[] =
    ['#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A', '#98D8C8', '#F7DC6F', '#BB8FCE'];
  private readonly particleCount: number = 50;

  build() {
    Stack() {
      // 主内容
      Column() {
        Text('课堂奖励系统')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 30 });

        Button('查看分数')
          .width(200)
          .height(50)
          .backgroundColor('#4ECDC4')
          .borderRadius(25)
          .onClick(() => {
            this.showScore = true;
            this.createParticleEffect();
          });
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center);

      // 弹窗
      if (this.showScore) {
        this.ScoreCard();
      }

      // 粒子层
      ForEach(this.particles, (p: Particle) => {
        Circle()
          .width(8).height(8)
          .fill(p.color)
          .opacity(p.opacity)
          .scale({ x: p.scale, y: p.scale })
          .position({ x: p.x, y: p.y });
      }, (p: Particle, idx: number) => idx.toString());
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Center);
  }

  @Builder
  private ScoreCard() {
    Column() {
      Text('恭喜！')
        .fontSize(28)
        .fontColor('#333')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 10 });

      Text(`得分：${this.score}分`)
        .fontSize(36)
        .fontColor('#4ECDC4')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 });

      Text('表现优秀，继续加油！')
        .fontSize(16)
        .fontColor('#666')
        .margin({ bottom: 20 });

      Button('确定')
        .width(120)
        .height(40)
        .backgroundColor('#4ECDC4')
        .borderRadius(20)
        .onClick(() => {
          this.showScore = false;
          this.particles = [];
        });
    }
    .width(300)
    .padding(30)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({
      radius: 10,
      color: 'rgba(0,0,0,0.2)',
      offsetX: 0,
      offsetY: 5
    })
    .scale({ x: this.showScore ? 1 : 0, y: this.showScore ? 1 : 0 })
    .animation({ duration: 300, curve: Curve.EaseOut });
  }

  private createParticleEffect(): void {
    this.particles = [];
    for (let i = 0; i < this.particleCount; i++) {
      setTimeout(() => {
        const p: Particle = {
          x: px2vp(200 + Math.random() * 200),
          y: px2vp(400 + Math.random() * 200),
          color: this.colors[Math.floor(Math.random() * this.colors.length)],
          opacity: 1,
          scale: 1 + Math.random() * 0.5
        };
        this.particles.push(p);

        setTimeout(() => {
          p.y -= px2vp(Math.random() * 300 + 100);
          p.opacity = 0;
          p.scale = 0;
          this.particles = [...this.particles];
        }, 50);
      }, i * 20);
    }
  }
}