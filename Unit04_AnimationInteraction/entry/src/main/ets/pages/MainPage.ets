import { HomePage } from './HomePage';
import { Layout1 } from './pages2/Layout1';
import { Layout2 } from './pages2/Layout2';
import { ExplictAnimationPage } from './pages2/ExplictAnimationPage'
import { CardComponentPage } from './pages2/CardComponentPage'
import { KeyframeComponentPage } from './pages2/KeyframeComponentPage'
import { PageComponentPage } from './pages2/PageComponentPage'
import { Page2 } from '../components/Page2'
import { Page1 } from '../components/Page1'

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
    if (name === 'Layout1') {
      Layout1();
    } else if (name ===
      'Layout2') {
      Layout2();
    } else if (name ===
      'ExplictAnimationPage') {
      ExplictAnimationPage();
    } else if (name ===
      'CardComponentPage') {
      CardComponentPage();
    } else if (name ===
      'KeyframeComponentPage') {
      KeyframeComponentPage();
    } else if (name ===
      'PageComponentPage') {
      PageComponentPage();
    } else if (name ===
      'Page2') {
      Page2();
    } else if (name ===
      'Page1') {
      Page1();
    }
  }
}