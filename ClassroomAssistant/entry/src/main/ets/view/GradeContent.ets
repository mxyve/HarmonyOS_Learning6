import { GradeModel, Course } from '../model/GradeModel';
import { promptAction } from '@kit.ArkUI';

@ComponentV2
export struct GradeContent {
  @Local model: GradeModel = new GradeModel();
  @Local isRefreshing: boolean = false;
  @Local isLoadingMore: boolean = false;
  @Local forceUpdate: number = 0; // 添加强制更新触发器

  build() {
    /* 整个页面只有一个根节点：Refresh */
    Refresh({
      refreshing: this.isRefreshing
    }) {
      Column() {
        /* 1. 学期选择器 */
        Row() {
          Text('选择学期').fontSize(16).fontWeight(FontWeight.Bold)
          Blank()
          Select(this.model.termOptions.map((t: string): SelectOption => ({ value: t })))
            .selected(this.model.termOptions.indexOf(this.model.currentTerm))
            .onSelect((idx: number) => {
              this.model.currentTerm = this.model.termOptions[idx];
              this.forceUpdate++; // 触发UI重新渲染
            })
            .width(160)
        }
        .width('100%')
        .padding({
          left: 16,
          right: 16,
          top: 12,
          bottom: 12
        })

        /* 3. 统计卡片 - 添加 forceUpdate 依赖 */
        Row({ space: 12 }) {
          this.StatCard('平均分', () => this.model.avg.toString())
          this.StatCard('最高分', () => this.model.max.toString())
          this.StatCard('最低分', () => this.model.min.toString())
        }
        .width('100%')
        .padding({
          left: 16,
          right: 16,
          top: 8,
          bottom: 8
        })

        /* 4. 列表 */
        List({ space: 8 }) {
          // ① 正常数据
          ForEach(this.model.pageList, (c: Course) => {
            ListItem() {
              Row() {
                Text(c.name).fontSize(16).layoutWeight(1)
                Text(c.score.toString())
                  .fontSize(16)
                  .fontColor(
                    c.score >= 85 ? '#52C41A' :
                      c.score >= 60 ? '#262626' : '#FF4D4F'
                  )
              }
              .width('100%')
              .padding({
                left: 16,
                right: 16,
                top: 14,
                bottom: 14
              })
              .backgroundColor(Color.White)
              .borderRadius(12)
            }
          }, (c: Course) => c.id)

          // ② 底部提示（仅做展示，不再负责触发）
          if (this.model.pageList.length > 0) {
            ListItem() {
              Text(this.model.hasMore ? '上拉加载更多' : '没有更多数据')
                .fontSize(14)
                .fontColor('#999')
                .width('100%')
                .textAlign(TextAlign.Center)
                .padding(16)
            }
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F5F5F5')
        .edgeEffect(EdgeEffect.Spring)
        // 关键：官方上拉到底事件
        .onReachEnd(async () => {
          if (this.model.hasMore) { // 还有数据才加载
            this.isLoadingMore = true; // 可选：转圈动画
            const hasNext = await this.model.loadMore();
            this.isLoadingMore = false;
            if (!hasNext) {
              promptAction.showToast({ message: '已加载全部' });
            }
          }
        })
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F5F5F5')
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .onRefreshing(async () => {
      this.isRefreshing = true;
      await this.model.randomRefresh();
      this.isRefreshing = false;
      promptAction.showToast({ message: '已刷新' });
    })
    .width('100%')
    .height('100%')
  }

  // 添加依赖 forceUpdate 的获取方法
  getAvgWithUpdate(): string {
    const update = this.forceUpdate; // 显式依赖
    console.log('==getAvgWithUpdate 被调用, forceUpdate:', this.forceUpdate);
    console.log('==当前学期:', this.model.currentTerm);
    console.log('==displayList 长度:', this.model.displayList.length);
    console.log('==计算出的平均分:', this.model.avg);
    return this.model.avg.toString();
  }

  getMaxWithUpdate(): string {
    const update = this.forceUpdate; // 显式依赖
    console.log('==getMaxWithUpdate 被调用, 最高分:', this.model.max);
    return this.model.max.toString();
  }

  getMinWithUpdate(): string {
    const update = this.forceUpdate; // 显式依赖
    console.log('==getMinWithUpdate 被调用, 最低分:', this.model.min);
    return this.model.min.toString();
  }

  @Builder
  StatCard(label: string, valGetter: () => string) {
    Column({ space: 4 }) {
      Text(label).fontSize(12).fontColor('#666')

      // 用立即调用函数返回颜色
      Text(valGetter())
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor((() => {
          const score = Number(valGetter());
          return score >= 85 ? '#52C41A' :
            score >= 60 ? '#262626' : '#FF4D4F';
        })())
    }
    .width(0)
    .layoutWeight(1)
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Center)
  }

  async onRefresh(): Promise<void> {
    this.isRefreshing = true;
    await this.model.randomRefresh();
    this.isRefreshing = false;
    promptAction.showToast({ message: '已刷新' });
  }

  async loadMore(): Promise<void> {
    if (this.isLoadingMore) {
      return;
    }
    this.isLoadingMore = true;
    await this.model.reload();
    this.isLoadingMore = false;
  }
}