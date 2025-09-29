/* ========== 数据接口 ========== */
interface TabItem {
  name: Resource;
  normalIcon: Resource;
  selectedIcon: Resource;
}

interface LayoutItem {
  id: number;
  name: Resource;
  pageName: string;
}

interface AnimationArr {
  id: number;
  name: string;
  pageName: string;
}

/* ========== 首页组件 ========== */
@Component
export struct HomePage {
  @State currentIndex: number = 0;
  @Consume('pageInfos') pageInfos: NavPathStack;
  /* ---- 底部导航数据 ---- */
  private tabsData: TabItem[] = [
    {
      name: $r('app.string.layout_tab_name'),
      normalIcon: $r('app.media.ic_layout_normal'),
      selectedIcon: $r('app.media.ic_layout_selected')
    },
    {
      name: $r('app.string.animation_tab_name'),
      normalIcon: $r('app.media.ic_animation_normal'),
      selectedIcon: $r('app.media.ic_animation_selected')
    }
  ];
  /* ---- 组件列表数据 ---- */
  private animationArr: AnimationArr[] = [
    { id: 1, name: 'Animation Page 1', pageName: 'ExplictAnimationPage' },
    { id: 2, name: 'Animation Page 2', pageName: 'CardComponentPage' },
    { id: 3, name: '关键帧练习', pageName: 'KeyframeComponentPage' },
    { id: 4, name: '转场动画练习', pageName: 'PageComponentPage' },
  ];
  private layoutItems: LayoutItem[] = [
    { id: 3, name: $r('app.string.layout1_name'), pageName: 'Layout1' },
    { id: 4, name: $r('app.string.layout2_name'), pageName: 'Layout2' }
  ];

  build() {
    // Tabs与TabContent使用
    Tabs({
      index: this.currentIndex,
      controller: new TabsController()
    }) {
      /* 2. 布局 Tab */
      TabContent() {
        this.LayoutTab()
      }
      .tabBar(this.TabBuilder(1))

      /* 3. 动画 Tab */
      TabContent() {
        this.AnimationTab()
      }
      .tabBar(this.TabBuilder(2))
    }
    .barPosition(BarPosition.End)
    .onChange(idx => this.currentIndex = idx)
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5');
  }

  /* ---------------- 布局 Tab ---------------- */
  @Builder
  LayoutTab() {
    List({ space: 12 }) {
      ForEach(this.layoutItems, (item: LayoutItem) => {
        ListItem() {
          Text(item.name) // 显示“Layout1 综合布局练习”等名称
            .width('100%')
            .height(72)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              // 点击跳转到对应的页面（包括Layout1）
              this.pageInfos.pushPath({ name: item.pageName });
            });
        }
      }, (item: LayoutItem) => item.id.toString()); // 用id作为唯一标识
    }
    .width('90%')
    .margin({ top: 12 })
    .backgroundColor('#F5F5F5');
  }

  /* ---------------- 动画 Tab ---------------- */
  @Builder
  AnimationTab() {
    List({ space: 12 }) {
      ForEach(this.animationArr, (item: AnimationArr) => {
        ListItem() {
          Text(item.name)
            .width('100%')
            .height(72)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.pageInfos.pushPath({ name: item.pageName });
            });
        }
      }, (item: AnimationArr) => item.id.toString());
    }
    .width('90%')
    .margin({ top: 12 });
  }

  /* ---------------- 底部导航栏 Builder ---------------- */
  @Builder
  TabBuilder(index: number) {
    Column() {
      Image(this.currentIndex === index
        ? this.tabsData[index].selectedIcon
        : this.tabsData[index].normalIcon)
        .size({ width: 24, height: 24 });

      Text(this.tabsData[index].name)
        .fontSize(12)
        .margin({ top: 4 })
        .fontColor(this.currentIndex === index ? Color.Blue : Color.Gray);
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center);
  }
}