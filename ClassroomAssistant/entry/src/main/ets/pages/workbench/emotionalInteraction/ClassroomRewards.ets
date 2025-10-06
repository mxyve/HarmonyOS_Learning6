@Component
export struct ClassroomRewards {
  @State private particles: Array<Particle> = []
  private ctx: Canvas2DContext | null = null
  private timer: number = -1
  private canvasWidth: number = 400
  private canvasHeight: number = 300

  // 样式属性
  private stackWidth: string = '100%'
  private stackHeight: string = this.canvasHeight + 'px'

  private buttonPadding: number = 15
  private buttonFontSize: number = 18
  private buttonBgColor: string = '#45b7d1'
  private buttonBorderRadius: number = 10
  private buttonMargin: number = 20

  private canvasWidthStr: string = this.canvasWidth + 'px'
  private canvasHeightStr: string = this.canvasHeight + 'px'

  build(): void {
    Stack() {
      Button('💯 高分测验')
        .onClick(() => this.fire())
        .padding(this.buttonPadding)
        .fontSize(this.buttonFontSize)
        .backgroundColor(this.buttonBgColor)
        .borderRadius(this.buttonBorderRadius)
        .margin(this.buttonMargin)

      Canvas()
        .width(this.canvasWidthStr)
        .height(this.canvasHeightStr)
        .onReady(this.handleCanvasReady.bind(this))
    }
    .width(this.stackWidth)
    .height(this.stackHeight)
  }

  private handleCanvasReady(): void {
    // 创建Canvas元素实现类实例，不传递this引用
    const canvasElement: CanvasElement = new CanvasElementImpl();
    this.ctx = canvasElement.getContext('2d');
    this.startLoop();
  }

  // 将方法改为公共方法，允许外部访问
  public createCanvas2DContext(): Canvas2DContext {
    return new Canvas2DContextImpl();
  }

  private fire(): void {
    this.particles = [];
    for (let i = 0; i < 60; i++) {
      const particle: Particle = this.createParticle();
      this.particles.push(particle);
    }
    setTimeout(() => this.particles = [], 2000);
  }

  private createParticle(): Particle {
    return {
      x: Math.random() * this.canvasWidth,
      y: -20,
      size: Math.random() * 5 + 3,
      color: this.randColor(),
      speed: Math.random() * 3 + 2
    };
  }

  private randColor(): string {
    const colors: string[] = ['#ff6b6b', '#4ecdc4', '#45b7d1', '#feca57', '#ff9ff3'];
    return colors[Math.floor(Math.random() * colors.length)];
  }

  private startLoop(): void {
    if (this.timer !== -1) {
      clearInterval(this.timer);
    }

    this.timer = setInterval(() => {
      if (!this.ctx) return;

      this.ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

      for (let i = this.particles.length - 1; i >= 0; i--) {
        const p: Particle = this.particles[i];
        p.y += p.speed;

        if (p.y > this.canvasHeight) {
          this.particles.splice(i, 1);
          continue;
        }

        this.ctx.fillStyle = p.color;
        this.ctx.beginPath();
        this.ctx.arc(p.x, p.y, p.size, 0, 2 * Math.PI);
        this.ctx.fill();
      }
    }, 16);
  }

  aboutToDisappear(): void {
    if (this.timer !== -1) {
      clearInterval(this.timer);
    }
  }
}

// 修改Canvas元素实现类，直接创建上下文
class CanvasElementImpl implements CanvasElement {
  getContext(contextType: string): Canvas2DContext | null {
    if (contextType === '2d') {
      // 直接创建上下文实例，不依赖外部类
      return new Canvas2DContextImpl();
    }
    return null;
  }
}

// Canvas2D上下文实现类
class Canvas2DContextImpl implements Canvas2DContext {
  fillStyle: string = '';

  clearRect(x: number, y: number, width: number, height: number): void {
    // 实际实现由ArkUI提供
  }

  beginPath(): void {
    // 实际实现由ArkUI提供
  }

  arc(x: number, y: number, radius: number, startAngle: number, endAngle: number): void {
    // 实际实现由ArkUI提供
  }

  fill(): void {
    // 实际实现由ArkUI提供
  }
}

// 粒子接口
interface Particle {
  x: number;
  y: number;
  size: number;
  color: string;
  speed: number;
}

// Canvas相关接口
interface CanvasElement {
  getContext(contextType: string): Canvas2DContext | null;
}

interface Canvas2DContext {
  fillStyle: string;
  clearRect(x: number, y: number, width: number, height: number): void;
  beginPath(): void;
  arc(x: number, y: number, radius: number, startAngle: number, endAngle: number): void;
  fill(): void;
}
