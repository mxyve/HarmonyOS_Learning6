// 服务图标数据类型定义
interface ServiceItem {
  id: number;
  name: string;
  icon: Resource;
  path: string;
}

// 最近使用记录数据类型（新增时间格式化方法，方便显示）
interface RecentService extends ServiceItem {
  timestamp: number; // 原始时间戳（用于排序）
  // 格式化时间为 "HH:MM"（如 14:30）
  getFormatTime(): string;
}

// 2. 关键：创建类实现 RecentService 接口（显式关联接口，解决报错）
class RecentServiceClass implements RecentService {
  id: number;
  name: string;
  icon: Resource;
  path: string;
  timestamp: number;

  // 构造函数：接收原始数据和时间戳，初始化属性
  constructor(service: ServiceItem | RecentService, timestamp: number) {
    this.id = service.id;
    this.name = service.name;
    this.icon = service.icon;
    this.path = service.path;
    this.timestamp = timestamp;
  }

  // 实现接口的 getFormatTime 方法（类内实现，符合 ArkTS 规范）
  getFormatTime(): string {
    const date = new Date(this.timestamp);
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    return `${hours}:${minutes}`;
  }
}

@Component
export struct CampusServicePage {
  @Consume("pageInfos") pageInfos: NavPathStack;
  // 服务图标网格数据
  private serviceItems: ServiceItem[] = [
    {
      id: 1,
      name: '食堂',
      icon: $r('app.media.ic_school_cafeteria'),
      path: 'CanteenPage'
    },
    {
      id: 2,
      name: '图书馆',
      icon: $r('app.media.ic_school_library'),
      path: 'LibraryPage'
    },
    {
      id: 3,
      name: '体育馆',
      icon: $r('app.media.ic_school_gymnasium'),
      path: 'GymPage'
    },
    {
      id: 4,
      name: '教学楼',
      icon: $r('app.media.ic_school_teaching_building'),
      path: 'TeachingBuildingPage'
    },
    {
      id: 5,
      name: '校园卡',
      icon: $r('app.media.ic_school_campus_card_recharge'),
      path: 'CampusCardPage'
    },
    {
      id: 6,
      name: '电费充值',
      icon: $r('app.media.ic_school_electricity_fee_reset'),
      path: 'ElectricityRechargePage'
    },
    {
      id: 7,
      name: '医务室',
      icon: $r('app.media.ic_school_infirmary'),
      path: 'InfirmaryPage'
    },
    {
      id: 8,
      name: '失物招领',
      icon: $r('app.media.ic_school_lost_add_office'),
      path: 'LostFoundPage'
    }
  ];
  // 最近使用记录（纵向列表数据源）
  @State recentServices: RecentService[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          // 页面标题
          Text('校园服务')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 16, bottom: 20, left: 16 })

          // 服务图标网格 - 3×3布局（保持不变）
          Column() {
            ForEach(
              this.serviceItems.filter((_, index: number) => index % 3 === 0),
              (item: ServiceItem, rowIndex: number) => {
                Row() {
                  ForEach(
                    this.serviceItems.slice(rowIndex * 3, rowIndex * 3 + 3),
                    (subItem: ServiceItem) => {
                      Column() {
                        Image(subItem.icon)
                          .width(68)
                          .height(68)
                          .objectFit(ImageFit.Contain)
                          .backgroundColor('#F5F5F5')
                          .borderRadius(10)
                          .padding(10)
                          .onClick(() => {
                            this.pageInfos.pushPathByName(subItem.path, null);
                            this.addRecentService(subItem); // 记录最近使用
                          })

                        Text(subItem.name)
                          .fontSize(12)
                          .margin({ top: 6 })
                      }
                      .width('33.33%')
                      .justifyContent(FlexAlign.Center)
                      .alignItems(HorizontalAlign.Center)
                    },
                    (subItem: ServiceItem) => subItem.id.toString()
                  )
                }
                .width('100%')
                .padding({ bottom: 16 })
              },
              (item: ServiceItem, index: number) => index.toString()
            )
          }
          .margin({ bottom: 24, left: 12, right: 12 })

          // 最近使用服务列表（纵向排列：从Row改为List）
          if (this.recentServices.length > 0) {
            Column() {
              // 列表标题
              Text('最近使用')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .margin({ bottom: 12, left: 8 })
                .alignSelf(ItemAlign.Start)

              // 纵向列表：每一行显示「图标+名称+时间」
              List({ space: 10 }) { // space: 列表项之间的间距
                ForEach(
                  this.recentServices,
                  (item: RecentService) => {
                    ListItem() {
                      // 单行容器：横向排列图标、名称、时间
                      Row() {
                        // 1. 图标
                        Image(item.icon)
                          .width(40)
                          .height(40)
                          .objectFit(ImageFit.Contain)
                          .backgroundColor('#F5F5F5')
                          .borderRadius(6)
                          .padding(6)

                        // 2. 服务名称（占中间剩余空间，文字超出省略）
                        Text(item.name)
                          .fontSize(14)
                          .margin({ left: 12 })
                          .flexGrow(1) // 自动填充中间空白
                          .textOverflow({ overflow: TextOverflow.Ellipsis }) // 文字过长省略
                          .maxLines(1) // 限制只显示一行

                        // 3. 浏览时间（靠右显示）
                        Text(item.getFormatTime())
                          .fontSize(12)
                          .fontColor('#999999') // 灰色文字区分时间
                          .margin({ right: 8 })
                      }
                      .width('100%')
                      .height(56) // 固定行高，保持整齐
                      .backgroundColor('#FFFFFF') // 白色背景区分列表项
                      .borderRadius(8)
                      .padding({ left: 16, right: 16 })
                      .onClick(() => {
                        // 点击最近使用项，跳转并更新记录
                        this.pageInfos.pushPathByName(item.path, null);
                        this.addRecentService(item);
                      })
                    }
                  },
                  (item: RecentService) => item.id.toString() // 唯一标识（避免重复渲染）
                )
              }
              .width('100%')
              .padding({ left: 8, right: 8 })
            }
            .margin({ bottom: 30, left: 12, right: 12 })
          }

        }
        .width('100%')
        .backgroundColor('#F9F9F9')
      }
    }
    .title('校园服务')
    .backgroundColor('#FFFFFF')
  }

  // 3. 修复 addRecentService 方法：用类实例化替代对象字面量
  private addRecentService(service: ServiceItem | RecentService) {
    // 1. 生成当前时间戳
    const timestamp = new Date().getTime();

    // 2. 过滤重复记录（不变）
    const filtered: RecentService[] = [];
    for (let i = 0; i < this.recentServices.length; i++) {
      if (this.recentServices[i].id !== service.id) {
        filtered.push(this.recentServices[i]);
      }
    }

    // 4. 关键：通过类实例化生成 RecentService 对象（完全符合接口，无报错）
    const newService: RecentService = new RecentServiceClass(service, timestamp);

    // 5. 构建新数组（不变）
    const newRecent: RecentService[] = [];
    newRecent.push(newService); // 新记录置顶
    for (let i = 0; i < filtered.length; i++) {
      newRecent.push(filtered[i]);
    }

    // 6. 只保留前3条记录（不变）
    this.recentServices = newRecent.slice(0, 3);
  }
}