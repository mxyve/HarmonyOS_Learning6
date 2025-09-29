/* ========== 数据接口 ========== */
interface TabItem {
  nameKey: string; // 改为存储字符串资源的 key
  normalIcon: Resource;
  selectedIcon: Resource;
}

interface WorkbenchItem {
  id: number;
  nameKey: string; // 改为存储字符串资源的 key
  pageName: string;
}

interface ProfileItem {
  id: number;
  nameKey: string; // 改为存储字符串资源的 key
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
      nameKey: 'tab_workbench',
      normalIcon: $r('app.media.nav_workbench_normal'),
      selectedIcon: $r('app.media.nav_workbench_selected')
    },
    {
      nameKey: 'tab_mine',
      normalIcon: $r('app.media.nav_home_normal'),
      selectedIcon: $r('app.media.nav_home_selected')
    }
  ];
  /* ---- 组件列表数据 ---- */
  private workbenchItem: WorkbenchItem[] = [
    { id: 1, nameKey: 'item_workbench', pageName: 'WorkbenchPage' },
    { id: 2, nameKey: 'item_demo', pageName: 'DemoPage' },
  ];
  private profileItem: ProfileItem[] = [
    { id: 1, nameKey: 'item_profile', pageName: 'ProfilePage' }
  ];

  build() {
    // Tabs与TabContent使用
    Tabs({
      index: this.currentIndex,
      controller: new TabsController()
    }) {
      /* 工作台 Tab */
      TabContent() {
        this.WorkbenchTab()
      }
      .tabBar(this.TabBuilder(0))

      /* 我的 Tab */
      TabContent() {
        this.ProfileTab()
      }
      .tabBar(this.TabBuilder(1))

    }
    .barPosition(BarPosition.End)
    .onChange(idx => this.currentIndex = idx)
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5');
  }

  /* ---------------- 我的 Tab ---------------- */
  @Builder
  ProfileTab() {
    List({ space: 12 }) {
      ForEach(this.profileItem, (item: ProfileItem) => {
        ListItem() {
          Text($r('app.string.' + item.nameKey)) // 使用多语言字符串
            .width('100%')
            .height(72)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              // 点击跳转到对应的页面
              this.pageInfos.pushPath({ name: item.pageName });
            });
        }
      }, (item: ProfileItem) => item.id.toString()); // 用id作为唯一标识
    }
    .width('90%')
    .margin({ top: 12 })
    .backgroundColor('#F5F5F5');
  }

  /* ---------------- 工作台 Tab ---------------- */
  @Builder
  WorkbenchTab() {
    List({ space: 12 }) {
      ForEach(this.workbenchItem, (item: WorkbenchItem) => {
        ListItem() {
          Text($r('app.string.' + item.nameKey)) // 使用多语言字符串
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
      }, (item: WorkbenchItem) => item.id.toString());
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

      Text($r('app.string.' + this.tabsData[index].nameKey)) // 使用多语言字符串
        .fontSize(12)
        .margin({ top: 4 })
        .fontColor(this.currentIndex === index ? '#1296db' : Color.Gray);
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center);
  }
}