import router from '@ohos.router'; // 显式导入路由模块

// 定义明确的接口类型
interface NavigationItem {
  title: string;
  description: string;
  icon: Resource;
  route: string;
}

@Entry
@Component
struct Index {
  // 明确指定数组类型
  @State navigationItems: NavigationItem[] = [
    // {
    //   title: 'title',
    //   description: 'description',
    //   icon: $r('app.media.heart_filled'),
    //   route: 'pages/DemoPage'
    // },
    {
      title: '基础装饰器',
      description: '@Entry @Component @State ',
      icon: $r('app.media.basic'),
      route: 'pages/MainPage'
    },
    {
      title: '响应式状态',
      description: '@State @Prop @Link',
      icon: $r('app.media.state'),
      route: 'pages/StudentCard'
    },
    {
      title: '响应式布局',
      description: 'AppStorage 获取屏幕宽度',
      icon: $r('app.media.layout'),
      route: 'pages/ResponsiveLayout'
    },
    {
      title: '计数器',
      description: '计数器',
      icon: $r('app.media.count'),
      route: 'pages/CountPage'
    },
    {
      title: '学生信息',
      description: '学生信息',
      icon: $r('app.media.studentInfo'),
      route: 'pages/StudentPage'
    },
    {
      title: '课程表',
      description: '课程表',
      icon: $r('app.media.timetable'),
      route: 'pages/CourseSchedulePage'
    }
  ];

  build() {
    Navigation() {
      Scroll() {
        Column() {
          this.buildList()
        }
        .padding(10)
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .title('首页')
  }

  @Builder
  buildList() {
    Column({ space: 20 }) {
      ForEach(this.navigationItems, (item: NavigationItem) => {
        this.buildCard(item)
      }, (item: NavigationItem) => item.title) // 添加唯一标识符
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildCard(item: NavigationItem) {
    Row() {
      Image(item.icon)
        .width('60vp')
        .height('60vp')
        .borderRadius(10)
        .margin({ right: 20 })

      Column() {
        Text(item.title)
          .fontSize(20)
        Text(item.description) // 显示描述文本
          .fontSize(14)
          .fontColor('#666666')
      }
      .alignItems(HorizontalAlign.Start)

      Blank();
      Image($r('app.media.arrow_right'))
        .width('20vp')
        .height('20vp')
        .fillColor('#999999')
    }
    .width('100%')
    .padding(10)
    .borderRadius(10)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 4, color: '#00000010' })
    .onClick(() => {
      // 路由跳转带日志输出，方便调试
      console.log(`准备跳转到: ${item.route}`);
      const url: string = item.route;
      router.pushUrl({ url: url })
        .then(() => {
          console.log(`成功跳转到: ${url}`);
        })
        .catch((err: Error) => {
          console.error(`路由跳转失败: ${err.message}, 路径: ${url}`);
        });
    })
  }
}
