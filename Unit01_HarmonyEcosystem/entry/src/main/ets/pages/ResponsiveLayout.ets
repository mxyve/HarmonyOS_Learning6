@Component
@Preview
@Entry
struct ResponsiveLayout {
  @State screenWidth: number = 360

  aboutToAppear() {
    this.getScreenWidth()
  }

  private getScreenWidth() {
    try {
      // 使用 AppStorage 获取屏幕宽度，如果没有就使用默认值
      this.screenWidth = AppStorage.get('screenWidth') as number || 360
    } catch (error) {
      this.screenWidth = 360
    }
  }


  build() {
    Navigation() {
      Column() {
        // 根据屏幕宽度调整布局
        if (this.screenWidth > 600) {
          // 平板布局：横向排列
          Row() {
            this.buildLeftPanel()
            this.buildRightPanel()
          }
        } else {
          // 手机布局：纵向排列
          Column() {
            this.buildLeftPanel()
            this.buildRightPanel()
          }
        }
      }
    }
    .title('响应式布局')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
  }

  @Builder buildLeftPanel() {
    Column() {
      Text('左侧面板')
      // 更多内容...
    }
    .backgroundColor(Color.Blue)
    .flexGrow(1)
  }

  @Builder buildRightPanel() {
    Column() {
      Text('右侧面板')
      // 更多内容...
    }
    .backgroundColor(Color.Green)
    .flexGrow(1)
  }
}