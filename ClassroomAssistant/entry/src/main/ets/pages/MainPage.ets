import { HomePage } from './HomePage';
import { WorkbenchPage } from './workbench/WorkbenchPage';
import { ProfilePage } from './profile/ProfilePage'
import { SignPage } from './workbench/SignPage'
import { CourseReminderPage } from './workbench/CourseReminderPage'
import { QaInteractionPage } from './workbench/QaInteractionPage'
import { HomeworkSubmissionPage } from './workbench/HomeworkSubmissionPage'
import { DataStatisticsPage } from './workbench/DataStatistics/DataStatisticsPage'
import { EmotionalInteractionPage } from './workbench/EmotionalInteraction/EmotionalInteractionPage'
import  {StarDisplay} from './../components/StarDisplay'
import {ParticleExample} from './../components/ParticleExample'
import { StarSuccess } from './../components/StarSuccess'

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
    } else if (name === 'SignPage') {
      SignPage();
    } else if (name === 'CourseReminderPage') {
      CourseReminderPage();
    } else if (name === 'QaInteractionPage') {
      QaInteractionPage();
    } else if (name === 'HomeworkSubmissionPage') {
      HomeworkSubmissionPage();
    } else if (name === 'DataStatisticsPage') {
      DataStatisticsPage();
    } else if (name === 'EmotionalInteractionPage') {
      EmotionalInteractionPage();
    } else if (name === 'StarDisplay'){
      StarDisplay();
    } else if (name === 'ParticleExample'){
      ParticleExample();
    } else if (name === 'StarSuccess'){
      StarSuccess();
    }
  }
}