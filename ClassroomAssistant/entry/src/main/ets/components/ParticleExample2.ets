@Preview
@Component
export struct ParticleExample {
  @Consume('pageInfos') pageInfos: NavPathStack;
  build() {
    NavDestination() {
      Stack() {
        // 基础粒子动画组件
        Particle({
          particles: [
            {
              emitter: {
                particle: {
                  type: ParticleType.POINT,
                  count: 100,
                  config: {
                    radius: 10
                  }
                },
                emitRate: 10,
                position: [300, 300],
                shape: ParticleEmitterShape.CIRCLE
              },
              color: {
                range: [Color.Red, Color.Blue],
                updater: {
                  type: ParticleUpdater.RANDOM,
                  config: {
                    r: [255, 0],
                    g: [255, 0],
                    b: [255, 0],
                    a: [255, 255]
                  }
                }
              },
              opacity: {
                range: [0.0, 1.0],
                updater: {
                  type: ParticleUpdater.CURVE,
                  config: [{
                    from: 1.0,
                    to: 0.0,
                    startMillis: 0,
                    endMillis: 3000,
                    curve: Curve.EaseIn
                  }]
                }
              },
              scale: {
                range: [0.0, 1.0],
                updater: {
                  type: ParticleUpdater.CURVE,
                  config: [{
                    from: 0.0,
                    to: 1.0,
                    startMillis: 0,
                    endMillis: 1000,
                    curve: Curve.EaseOut
                  }]
                }
              },
              velocity: {
                speed: [10, 20],
                angle: [0, 360]
              },
              acceleration: {
                speed: {
                  range: [5, 10],
                  updater: {
                    type: ParticleUpdater.CURVE,
                    config: [{
                      from: 5,
                      to: 0,
                      startMillis: 0,
                      endMillis: 2000,
                      curve: Curve.Linear
                    }]
                  }
                },
                angle: {
                  range: [0, 360]
                }
              },
              spin: {
                range: [0, 360],
                updater: {
                  type: ParticleUpdater.CURVE,
                  config: [{
                    from: 0,
                    to: 360,
                    startMillis: 0,
                    endMillis: 3000,
                    curve: Curve.Linear
                  }]
                }
              }
            }
          ]
        })
          .width('100%')
          .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Black)
    }
  }
}
