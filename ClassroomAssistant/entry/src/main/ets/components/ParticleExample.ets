@Component
export struct ParticleExample {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State touchX: number = 200;
  @State touchY: number = 200;
  @State effectType: ParticleEffectType = 'fireworks';
  @State particles: Array<ParticleData> = [];

  // 粒子ID计数器
  private particleId: number = 0;
  private intervals: Array<number> = [];

  // 定义粒子数据结构
  private particleData: ParticleEffectConfig = {
    fireworks: { count: 50, interval: 2000 },
    flame: { count: 1, interval: 50 },
    snow: { count: 30, interval: 300 },
    stars: { count: 50, interval: 2000 }
  };

  aboutToAppear() {
    this.startEffect();
  }

  aboutToDisappear() {
    this.cleanupIntervals();
  }

  build() {
    NavDestination() {
      Column() {
        // 效果选择器
        Row({ space: 10 }) {
          Button('烟花')
            .onClick(() => {
              this.effectType = 'fireworks';
              this.startEffect();
            })
            .backgroundColor(this.effectType === 'fireworks' ? '#007DFF' : '#F1F3F5')
            .width('20%')

          Button('火焰')
            .onClick(() => {
              this.effectType = 'flame';
              this.startEffect();
            })
            .backgroundColor(this.effectType === 'flame' ? '#007DFF' : '#F1F3F5')
            .width('20%')

          Button('雪花')
            .onClick(() => {
              this.effectType = 'snow';
              this.startEffect();
            })
            .backgroundColor(this.effectType === 'snow' ? '#007DFF' : '#F1F3F5')
            .width('20%')

          Button('星空')
            .onClick(() => {
              this.effectType = 'stars';
              this.startEffect();
            })
            .backgroundColor(this.effectType === 'stars' ? '#007DFF' : '#F1F3F5')
            .width('20%')
        }
        .margin(10)
        .width('100%')
        .justifyContent(FlexAlign.Center)

        // 粒子效果区域
        Stack() {
          ForEach(this.particles, (particle: ParticleData) => {
            Circle({ width: particle.size, height: particle.size })
              .fill(particle.color)
              .opacity(particle.opacity)
              .position({ x: particle.x, y: particle.y })
          }, (particle: ParticleData) => particle.id.toString())

          // 显示当前效果信息
          this.BuildEffectInfoOverlay()
        }
        .width('100%')
        .height('75%')
        .backgroundColor('#1a1a1a')
        .gesture(
          TapGesture({ count: 1 })
            .onAction((event: GestureEvent) => {
              this.touchX = event.offsetX;
              this.touchY = event.offsetY;
              this.createBurstEffect();
            })
        )

        // 底部控制按钮
        this.BuildControlButtons()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#2a2a2a')
    }
    .title('粒子效果演示')
  }



  @Builder BuildEffectInfoOverlay() {
    Column() {
      Text(this.getEffectChineseName())
        .fontSize(24)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)

      Text(`粒子数量: ${this.particles.length}`)
        .fontSize(16)
        .fontColor('#CCCCCC')
        .margin({ top: 8 })

      Text('点击屏幕触发特效')
        .fontSize(14)
        .fontColor('#888888')
        .margin({ top: 4 })
    }
    .position({ x: '50%', y: 50 })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder BuildControlButtons() {
    Row({ space: 20 }) {
      Button('清空粒子')
        .onClick(() => {
          this.particles = [];
        })
        .width(120)
        .backgroundColor('#FF3B30')
        .fontColor(Color.White)

      Button('随机爆发')
        .onClick(() => {
          this.createRandomBurst();
        })
        .width(120)
        .backgroundColor('#4CAF50')
        .fontColor(Color.White)
    }
    .margin(10)
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  // 获取中文效果名
  private getEffectChineseName(): string {
    const names: Record<ParticleEffectType, string> = {
      'fireworks': '烟花效果',
      'flame': '火焰效果',
      'snow': '雪花效果',
      'stars': '星空效果'
    };
    return names[this.effectType];
  }

  // 清理定时器
  private cleanupIntervals(): void {
    this.intervals.forEach(interval => {
      clearInterval(interval);
    });
    this.intervals = [];
  }

  // 随机爆发效果
  private createRandomBurst(): void {
    for (let i = 0; i < 3; i++) {
      setTimeout(() => {
        const x = Math.random() * 300 + 50;
        const y = Math.random() * 200 + 100;
        this.createFireworkBurst(x, y);
      }, i * 300);
    }
  }

  // 开始效果
  private startEffect(): void {
    this.cleanupIntervals();
    this.particles = [];

    switch (this.effectType) {
      case 'fireworks':
        this.startFireworks();
        break;
      case 'flame':
        this.startFlame();
        break;
      case 'snow':
        this.startSnow();
        break;
      case 'stars':
        this.startStars();
        break;
    }
  }

  // 其他方法保持不变（只需要添加 private 修饰符）
  private startFireworks(): void {
    this.createFireworkBurst(this.touchX, this.touchY);

    const interval = setInterval(() => {
      const x: number = Math.random() * 350 + 25;
      const y: number = Math.random() * 300 + 50;
      this.createFireworkBurst(x, y);
    }, this.particleData.fireworks.interval);

    this.intervals.push(interval);
  }

  private createFireworkBurst(x: number, y: number): void {
    const colors: string[] = ['#FF5252', '#FF4081', '#E040FB', '#7C4DFF', '#536DFE'];

    for (let i = 0; i < this.particleData.fireworks.count; i++) {
      const particle: ParticleData = {
        id: this.particleId++,
        x: x,
        y: y,
        size: Math.random() * 6 + 2,
        color: colors[Math.floor(Math.random() * colors.length)],
        opacity: 1,
        vx: (Math.random() - 0.5) * 10,
        vy: (Math.random() - 0.5) * 10 - 2,
        life: 2000,
        createdAt: Date.now(),
        effectType: 'fireworks',
        twinkle: false
      };

      this.particles.push(particle);
    }

    this.animateParticles();
  }

  private startFlame(): void {
    const interval = setInterval(() => {
      this.createFlameParticle();
    }, this.particleData.flame.interval);

    this.intervals.push(interval);
    this.animateParticles();
  }

  private createFlameParticle(): void {
    const colors: string[] = ['#FF6D00', '#FF9100', '#FFAB00', '#FFD600'];
    const particle: ParticleData = {
      id: this.particleId++,
      x: 200 + (Math.random() - 0.5) * 60,
      y: 500,
      size: Math.random() * 8 + 2,
      color: colors[Math.floor(Math.random() * colors.length)],
      opacity: 1,
      vx: (Math.random() - 0.5) * 2,
      vy: -Math.random() * 4 - 2,
      life: 1500,
      createdAt: Date.now(),
      effectType: 'flame',
      twinkle: false
    };

    this.particles.push(particle);
  }

  private startSnow(): void {
    for (let i = 0; i < this.particleData.snow.count; i++) {
      this.createSnowflake();
    }

    const interval = setInterval(() => {
      this.createSnowflake();
    }, this.particleData.snow.interval);

    this.intervals.push(interval);
    this.animateParticles();
  }

  private createSnowflake(): void {
    const particle: ParticleData = {
      id: this.particleId++,
      x: Math.random() * 400,
      y: -10,
      size: Math.random() * 4 + 1,
      color: '#FFFFFF',
      opacity: Math.random() * 0.6 + 0.3,
      vx: (Math.random() - 0.5) * 0.5,
      vy: Math.random() * 1 + 0.5,
      life: 8000,
      createdAt: Date.now(),
      effectType: 'snow',
      twinkle: false
    };

    this.particles.push(particle);
  }

  private startStars(): void {
    for (let i = 0; i < this.particleData.stars.count; i++) {
      this.createStar();
    }

    const starInterval = setInterval(() => {
      this.createStar();
    }, this.particleData.stars.interval);

    const shootingStarInterval = setInterval(() => {
      this.createShootingStar();
    }, 5000);

    this.intervals.push(starInterval, shootingStarInterval);
    this.animateParticles();
  }

  private createStar(): void {
    const colors: string[] = ['#FFFFFF', '#BBDEFB', '#90CAF9'];
    const particle: ParticleData = {
      id: this.particleId++,
      x: Math.random() * 400,
      y: Math.random() * 600,
      size: Math.random() * 2 + 0.5,
      color: colors[Math.floor(Math.random() * colors.length)],
      opacity: Math.random() * 0.7 + 0.1,
      vx: (Math.random() - 0.5) * 0.1,
      vy: 0,
      life: 10000,
      createdAt: Date.now(),
      effectType: 'stars',
      twinkle: Math.random() > 0.5
    };

    this.particles.push(particle);
  }

  private createShootingStar(): void {
    const particle: ParticleData = {
      id: this.particleId++,
      x: Math.random() * 200,
      y: Math.random() * 100,
      size: 3,
      color: '#FFFFFF',
      opacity: 1,
      vx: 5 + Math.random() * 5,
      vy: 3 + Math.random() * 3,
      life: 1000,
      createdAt: Date.now(),
      effectType: 'stars',
      twinkle: false
    };

    this.particles.push(particle);
  }

  private createBurstEffect(): void {
    switch (this.effectType) {
      case 'fireworks':
        this.createFireworkBurst(this.touchX, this.touchY);
        break;
      case 'flame':
        for (let i = 0; i < 20; i++) {
          this.createFlameParticle();
        }
        break;
    }
  }

  private animateParticles(): void {
    const animate = (): void => {
      const now: number = Date.now();

      this.particles = this.particles.filter((particle: ParticleData) => {
        const age: number = now - particle.createdAt;

        if (age > particle.life) {
          return false;
        }

        particle.x += particle.vx;
        particle.y += particle.vy;
        this.updateParticleByEffect(particle, age);

        return true;
      });

      setTimeout(animate, 16);
    };

    animate();
  }

  private updateParticleByEffect(particle: ParticleData, age: number): void {
    switch (particle.effectType) {
      case 'fireworks':
        particle.vy += 0.1;
        particle.opacity = 1 - (age / particle.life);
        break;
      case 'flame':
        particle.opacity = 1 - (age / particle.life);
        particle.vx *= 0.98;
        break;
      case 'snow':
        particle.vx += (Math.random() - 0.5) * 0.1;
        break;
      case 'stars':
        if (particle.twinkle) {
          particle.opacity = 0.3 + Math.sin(age / 200) * 0.4;
        }
        break;
    }
  }
}

// 类型定义保持不变
interface ParticleData {
  id: number;
  x: number;
  y: number;
  size: number;
  color: string;
  opacity: number;
  vx: number;
  vy: number;
  life: number;
  createdAt: number;
  effectType: ParticleEffectType;
  twinkle: boolean;
}

type ParticleEffectType = 'fireworks' | 'flame' | 'snow' | 'stars';

interface ParticleEffectConfig {
  fireworks: EffectConfig;
  flame: EffectConfig;
  snow: EffectConfig;
  stars: EffectConfig;
}

interface EffectConfig {
  count: number;
  interval: number;
}