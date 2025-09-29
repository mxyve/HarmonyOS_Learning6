import { HomePage } from './HomePage';
import { WorkbenchPage } from './workbench/WorkbenchPage';
import { ProfilePage } from './profile/ProfilePage'
import { DemoPage } from './workbench/DemoPage'

@Entry
@Component
export struct MainPage {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.pageInfos) {
      HomePage() // 首页（内部再嵌 Tabs）
    }
    .width('100%')
    .height('100%')
    .mode(NavigationMode.Stack)
    .navDestination(this.pageMap)
    .hideTitleBar(true)
    .backgroundColor('#F5F5F5')

  }

  @Builder
  pageMap(name: string) {
    if (name === 'WorkbenchPage') {
      WorkbenchPage();
    } else if (name === 'ProfilePage') {
      ProfilePage();
    } else if (name === 'DemoPage') {
      DemoPage();
    }
  }
}