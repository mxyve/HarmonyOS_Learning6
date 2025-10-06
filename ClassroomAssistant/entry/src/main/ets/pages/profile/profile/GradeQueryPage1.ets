// GradeQueryPage.ets  已验证：切换学期 → 列表 & 统计卡片立即刷新
@Component
export struct GradeQueryPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  /* ========== 固定数据 ========== */
  private semesterOptions: string[] = [
    '全部', '大一上', '大一下', '大二上', '大二下', '大三上', '大三下', '大四上', '大四下'
  ];
  private allCourses: Course[] = [
    {
      id: 1,
      name: '高等数学',
      score: 92,
      credit: 5,
      semester: '大一上'
    },
    {
      id: 2,
      name: '大学英语',
      score: 88,
      credit: 4,
      semester: '大一上'
    },
    {
      id: 3,
      name: '计算机基础',
      score: 95,
      credit: 4,
      semester: '大一下'
    },
    {
      id: 4,
      name: '线性代数',
      score: 85,
      credit: 3,
      semester: '大一下'
    },
    {
      id: 5,
      name: '数据结构',
      score: 90,
      credit: 5,
      semester: '大二上'
    },
    {
      id: 6,
      name: '操作系统',
      score: 87,
      credit: 4,
      semester: '大二下'
    },
    {
      id: 7,
      name: '计算机网络',
      score: 93,
      credit: 4,
      semester: '大三上'
    },
    {
      id: 8,
      name: '数据库原理',
      score: 89,
      credit: 5,
      semester: '大三上'
    },
    {
      id: 9,
      name: '软件工程',
      score: 91,
      credit: 4,
      semester: '大三下'
    },
    {
      id: 10,
      name: '毕业设计',
      score: 94,
      credit: 10,
      semester: '大四上'
    }
  ];
  /* ========== 核心状态（无分页） ========== */
  @State selectedSemester: string = '全部';
  @State isDropdownVisible: boolean = false;
  @State displayCourses: Course[] = [];
  @State stat: StatResult = { avg: 0, max: 0, min: 0 };
  /* ========== 辅助状态 ========== */
  @State isRefreshing: boolean = false;
  @State refreshOffset: number = 120;
  @State flag: boolean = true;
  @State msg: string = '下拉刷新';

  /* ========== 生命周期 ========== */
  aboutToAppear() {
    this.loadDataAndComputeStat();
  }

  build() {
    NavDestination() {
      Stack() {
        Column({ space: 12 }) {
          /* 1. 学期选择器 */
          Button() {
            Row() {
              Text(this.selectedSemester).fontSize(16).flexGrow(1)
              Text('▼').fontSize(16)
            }.padding({ left: 15, right: 15 })
          }
          .width('90%')
          .height(45)
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#EEEEEE' })
          .borderRadius(8)
          .onClick(() => this.isDropdownVisible = !this.isDropdownVisible)
          .margin({ top: 10 })

          /* 2. 统计卡片（自动刷新） */
          Row() {
            this.statItem('平均分', this.stat.avg.toFixed(1), '#00B42A');
            this.statItem('最高分', this.stat.max.toString(), '#007DFF');
            this.statItem('最低分', this.stat.min.toString(), '#FF7D00');
          }
          .width('90%')
          .height(80)
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#EEEEEE' })
          .borderRadius(8)
          .justifyContent(FlexAlign.SpaceEvenly)

          /* 3. 下拉刷新 + 完整课程列表（无分页） */
          Refresh({
            refreshing: $$this.isRefreshing,
            builder: this.customRefreshComponent()
          }) {
            this.buildCourseList()
          }
          .refreshOffset(this.refreshOffset)
          .pullToRefresh(true)
          .onRefreshing(() => {
            setTimeout(() => {
              this.refreshCourseData();
              this.isRefreshing = false;
            }, 2000);
          })
          .width('90%')
          .height('80%')
          .margin({ top: 15 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F5')

        /* 4. 学期下拉框 */
        if (this.isDropdownVisible) {
          Column() {
            List() {
              ForEach(this.semesterOptions, (opt: string) => {
                ListItem() {
                  Text(opt)
                    .fontSize(16)
                    .padding(15)
                    .width('100%')
                    .textAlign(TextAlign.Center)
                    .backgroundColor(this.selectedSemester === opt ? '#F0F7FF' : '#FFFFFF')
                    .onClick(() => {
                      this.isDropdownVisible = false;
                      this.selectedSemester = opt;
                      this.loadDataAndComputeStat(); // 统一入口
                    })
                }
              }, (opt: string) => opt)
            }
            .width('90%')
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#EEEEEE' })
            .borderRadius(8)
          }
          .position({ x: '5%', y: 65 })
          .zIndex(100)
        }
      }
    }
    .title('成绩查询')
  }

  /* ========== 统一入口：加载 + 统计 ========== */
  private loadDataAndComputeStat(): void {
    const filtered = (this.selectedSemester === '全部'
      ? this.allCourses
      : this.allCourses.filter(c => c.semester === this.selectedSemester))
      .map(this.copyCourse); // ← 使用显式复制

    const stat = this.computeStat(filtered);
    this.stat = stat;
    this.displayCourses = filtered; // 已为新引用
  }

  private computeStat(list: Course[]): StatResult {
    if (list.length === 0) {
      return { avg: 0, max: 0, min: 0 };
    }
    let sum = 0, max = -Infinity, min = Infinity;
    list.forEach(c => {
      sum += c.score;
      max = Math.max(max, c.score);
      min = Math.min(min, c.score);
    });
    return {
      avg: parseFloat((sum / list.length).toFixed(1)),
      max,
      min
    };
  }

  private refreshCourseData(): void {
    this.allCourses = this.allCourses.map((c: Course): Course => {
      const adjust = (Math.random() > 0.5 ? 1 : -1) * (Math.floor(Math.random() * 3) + 1);
      return {
        id: c.id,
        name: c.name,
        score: Math.min(100, Math.max(60, c.score + adjust)),
        credit: c.credit,
        semester: c.semester
      } as Course; // 显式实现接口
    });
    this.loadDataAndComputeStat();
  }

  /* ========== 组件 ========== */
  @Builder
  statItem(label: string, value: string, color: string) {
    Column() {
      Text(label).fontSize(12).fontColor('#999')
      Text(value).fontSize(20).fontColor(color).fontWeight(FontWeight.Bold)
    }
  }

  @Builder
  customRefreshComponent() {
    Stack() {
      Column() {
        LoadingProgress()
          .height(32).width(32).color('#007DFF')
          .visibility(this.flag ? Visibility.None : Visibility.Visible)
        Text(this.msg).fontSize(14).fontColor('#666').margin({ top: 8 })
      }.alignItems(HorizontalAlign.Center)
    }
    .width('100%').height(100).align(Alignment.Center)
  }

  @Builder
  buildCourseList() {
    List() {
      ListItem() {
        Row() {
          Text('课程名称').fontSize(14).fontWeight(FontWeight.Bold).width('40%')
          Text('学分').fontSize(14).fontWeight(FontWeight.Bold).width('20%')
          Text('成绩').fontSize(14).fontWeight(FontWeight.Bold).width('20%')
          Text('学期').fontSize(14).fontWeight(FontWeight.Bold).width('20%')
        }.padding(12).backgroundColor('#F5F5F5')
      }

      ForEach(this.displayCourses, (c: Course, idx: number) => {
        ListItem() {
          Column() {
            Row() {
              Text(c.name).fontSize(15).width('40%')
              Text(c.credit.toString()).fontSize(15).width('20%')
              Text(c.score.toString())
                .fontSize(15).width('20%')
                .fontColor(this.getScoreColor(c.score))
              Text(c.semester).fontSize(15).width('20%')
            }.padding(12)

            if (idx !== this.displayCourses.length - 1) {
              Divider()
                .height(1).color('#EEEEEE')
                .margin({
                  left: 12,
                  right: 12,
                  top: 8,
                  bottom: 8
                })
            }
          }
        }
      }, (c: Course) => c.id.toString())
    }
    .scrollBar(BarState.Off)
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(8)
  }

  private copyCourse(c: Course): Course {
    return {
      id: c.id,
      name: c.name,
      score: c.score,
      credit: c.credit,
      semester: c.semester
    } as Course; // 显式声明
  }

  private getScoreColor(s: number): ResourceColor {
    if (s >= 90) {
      return '#00B42A';
    }
    if (s >= 80) {
      return '#007DFF';
    }
    if (s >= 60) {
      return '#FF7D00';
    }
    return '#F53F3F';
  }
}

/* ========== 类型 ========== */
interface Course {
  id: number;
  name: string;
  score: number;
  credit: number;
  semester: string;
}

interface StatResult {
  avg: number;
  max: number;
  min: number;
}