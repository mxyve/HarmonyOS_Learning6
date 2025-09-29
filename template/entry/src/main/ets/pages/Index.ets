import router from '@ohos.router';

interface NavigationItem {
  title: Resource;
  description: Resource;
  icon: Resource;
  route: string;
}

@Entry
@Component
struct Index {
  @State navigationItems: NavigationItem[] = [
    {
      title: $r('app.string.card_title_1'),
      description: $r('app.string.card_desc_1'),
      icon: $r('app.media.alternative_cyan_lightning'),
      route: 'pages/DemoPage'
    },
    {
      title: $r('app.string.card_title_2'),
      description: $r('app.string.card_desc_2'),
      icon: $r('app.media.alternative_orange_sun'),
      route: 'pages/DemoPage2'
    },
    {
      title: $r('app.string.card_title_3'),
      description: $r('app.string.card_desc_3'),
      icon: $r('app.media.alternative_blue_qubit'),
      route: 'pages/DemoPage3'
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
    }
    .width('100%')
    .title($r('app.string.home_title'))
    .backgroundColor($r('app.color.background')) // ← 替换
  }

  @Builder
  buildList() {
    Column({ space: 20 }) {
      ForEach(this.navigationItems, (item: NavigationItem) => {
        this.buildCard(item)
      }, (item: NavigationItem, index: number) => `${index}`)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildCard(item: NavigationItem) {
    Row() {
      Image(item.icon)
        .width(48)
        .height(48)
        .borderRadius(12)
        .margin({ right: 12 })

      Column() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(item.description)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))   // ← 替换
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('app.media.arrow_right'))
        .width(24)
        .height(24)
        .fillColor($r('app.color.text_hint')) // ← 替换
    }
    .width('100%')
    .padding({
      top: 12,
      bottom: 12,
      left: 16,
      right: 16
    })
    .borderRadius(16)
    .backgroundColor($r('app.color.surface')) // ← 替换
    .shadow({
      radius: 6,
      color: '#1F000000', // 无对应变量，保持字面量
      offsetX: 0,
      offsetY: 2
    })
    .onClick(() => {
      console.log(`准备跳转到: ${item.route}`);
      router.pushUrl({ url: item.route })
        .then(() => console.log(`成功跳转到: ${item.route}`))
        .catch((err: Error) =>
        console.error(`路由跳转失败: ${err.message}, 路径: ${item.route}`)
        );
    })
    .stateStyles({
      pressed: { opacity: 0.7 }
    })
  }
}