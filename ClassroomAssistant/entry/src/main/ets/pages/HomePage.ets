/* ========== 数据接口 ========== */
interface TabItem {
  name: string;
  normalIcon: Resource;
  selectedIcon: Resource;
}

interface WorkbenchItem {
  id: number;
  name: string;
  pageName: string;
}

interface ProfileItem {
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
      name: '工作台',
      normalIcon: $r('app.media.ic_workbench_normal'),
      selectedIcon: $r('app.media.ic_workbench_selected')
    },
    {
      name: '我的',
      normalIcon: $r('app.media.ic_home_normal'),
      selectedIcon: $r('app.media.ic_home_selected')
    }
  ];
  /* ---- 组件列表数据 ---- */
  private workbenchItem: WorkbenchItem[] = [
    { id: 1, name: '工作台', pageName: 'WorkbenchPage' },
    { id: 2, name: '签到场景', pageName: 'SignPage' },
    { id: 3, name: '课程提醒', pageName: 'CourseReminderPage' },
    { id: 4, name: '答疑互动', pageName: 'QaInteractionPage' },
    { id: 5, name: '作业/测验提交', pageName: 'HomeworkSubmissionPage' },
    { id: 6, name: '数据与统计', pageName: 'DataStatisticsPage' },
    { id: 7, name: '情感化交互', pageName: 'EmotionalInteractionPage' },
    { id: 8, name: 'kongban', pageName: 'StarDisplay' },
    { id: 9, name: 'ParticleExample', pageName: 'ParticleExample' },
    { id: 10, name: 'StarSuccess', pageName: 'StarSuccess' },
  ];
  private profileItem: ProfileItem[] = [
    { id: 1, name: '我的', pageName: 'ProfilePage' }
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