// 定义星星粒子的属性接口
interface StarParticle {
  id: number;
  size: number;
  color: string;
  x: number;
  y: number;
  rotation: number;
  opacity: number;
  destX: number;
  destY: number;
  destRotation: number;
}

@Preview
@Component
export struct StarParticles {
  // 控制粒子是否显示
  @Prop show: boolean = false;
  // 粒子数量
  @Prop count: number = 20;
  // 粒子最大飞行距离
  @Prop maxDistance: number = 100;
  // 粒子大小范围
  @Prop sizeRange: [number, number] = [6, 12];
  // 粒子颜色列表 - 增加对比度
  @Prop colors: string[] = ['#FFD700', '#FFFACD', '#FFFF00', '#FFFFFF', '#E6E6FA'];
  // 动画持续时间范围
  @Prop durationRange: [number, number] = [800, 1500];

  @State particles: StarParticle[] = [];

  // 当show属性变化时触发
  aboutToAppear() {
    if (this.show) {
      this.generateParticles();
    }
  }

  // 监听show属性变化
  onPropChange(propName: string) {
    if (propName === 'show') {
      if (this.show) {
        this.generateParticles();
      } else {
        // 隐藏时清空粒子
        this.particles = [];
      }
    }
  }

  // 生成粒子
  private generateParticles() {
    // 清空现有粒子
    this.particles = [];

    for (let i = 0; i < this.count; i++) {
      // 随机生成粒子属性
      const angle = Math.random() * Math.PI * 2;
      const distance = Math.random() * this.maxDistance;
      const size = this.sizeRange[0] + Math.random() * (this.sizeRange[1] - this.sizeRange[0]);
      const color = this.colors[Math.floor(Math.random() * this.colors.length)];

      // 计算目标位置
      const destX = Math.cos(angle) * distance;
      const destY = Math.sin(angle) * distance;

      // 添加粒子
      this.particles.push({
        id: i,
        size: size,
        color: color,
        x: 0,
        y: 0,
        rotation: 0,
        opacity: 0,
        destX: destX,
        destY: destY,
        destRotation: Math.random() * 360
      });

      // 逐个启动动画，创建错落感
      setTimeout(() => {
        this.animateParticle(i);
      }, i * 30); // 缩短间隔，让粒子更密集
    }
  }

  // 粒子动画
  private animateParticle(id: number) {
    const index = this.particles.findIndex(item => item.id === id);
    if (index === -1) return;

    // 显示粒子
    animateTo({
      duration: 200,
      curve: Curve.EaseOut
    }, () => {
      this.particles[index].opacity = 1;
    });

    // 飞行动画
    const duration = this.durationRange[0] + Math.random() * (this.durationRange[1] - this.durationRange[0]);
    setTimeout(() => {
      animateTo({
        duration: duration,
        curve: Curve.EaseInOut
      }, () => {
        this.particles[index].x = this.particles[index].destX;
        this.particles[index].y = this.particles[index].destY;
        this.particles[index].rotation = this.particles[index].destRotation;
      });

      // 淡出动画 - 延长显示时间
      setTimeout(() => {
        animateTo({
          duration: 500
        }, () => {
          this.particles[index].opacity = 0;
        });
      }, duration * 0.5); // 提前开始淡出，延长可见时间
    }, 100);
  }

  build() {
    // 确保粒子容器占满空间，以便粒子可以在打勾图标周围显示
    Stack() {
      ForEach(this.particles, (particle: StarParticle) => {
        Text('★')
          .fontSize(particle.size)
          .fontColor(particle.color)
          .opacity(particle.opacity)
          .rotate({ angle: particle.rotation })
          .translate({ x: particle.x, y: particle.y })
      },(particle: StarParticle) => particle.id.toString())
    }
    .width('100%')
    .height('100%')
  }
}
