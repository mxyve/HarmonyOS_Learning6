import { HomePage } from './HomePage';
import { WorkbenchPage } from './workbench/WorkbenchPage';
import { ProfilePage } from './profile/ProfilePage'
import { SignPage } from './workbench/SignPage'
import { CourseReminderPage } from './workbench/CourseReminderPage'
import { QaInteractionPage } from './workbench/QaInteractionPage'
import { HomeworkSubmissionPage } from './workbench/HomeworkSubmissionPage'
import { DataStatisticsPage } from './workbench/dataStatistics/DataStatisticsPage'
import { EmotionalInteractionPage } from './workbench/emotionalInteraction/EmotionalInteractionPage'
import { StarDisplay } from './../components/StarDisplay'
import { ParticleExample } from './../components/ParticleExample'
import { StarSuccess } from './../components/StarSuccess'
import { PersonalInfoPage } from './profile/profile/PersonalInfoPage'
import { GradeQueryPage } from './profile/profile/GradeQueryPage'
import { SchedulePage } from './profile/profile/SchedulePage'
import { CampusServicePage } from './profile/profile/CampusServicePage'
// 校园服务
import { CanteenPage } from './profile/profile/campusService/CanteenPage'; // 食堂页面
import { LibraryPage } from './profile/profile/campusService/LibraryPage'; // 图书馆页面
import { GymPage } from './profile/profile/campusService/GymPage'; // 体育馆页面
import { TeachingBuildingPage } from './profile/profile/campusService/TeachingBuildingPage'; // 教学楼页面
import { CampusCardPage } from './profile/profile/campusService/CampusCardPage'; // 校园卡页面
import { ElectricityRechargePage } from './profile/profile/campusService/ElectricityRechargePage'; // 电费充值页面
import { InfirmaryPage } from './profile/profile/campusService/InfirmaryPage'; // 医务室页面
import { LostFoundPage } from './profile/profile/campusService/LostFoundPage'; // 失物招领页面

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
    } else if (name === 'StarDisplay') {
      StarDisplay();
    } else if (name === 'ParticleExample') {
      ParticleExample();
    } else if (name === 'StarSuccess') {
      StarSuccess();
    } else if (name === 'PersonalInfoPage') {
      PersonalInfoPage();
    } else if (name === 'GradeQueryPage') {
      GradeQueryPage();
    } else if (name === 'SchedulePage') {
      SchedulePage();
    } else if (name === 'CampusServicePage') {
      CampusServicePage();
    } else if (name === 'CanteenPage') {
      CanteenPage();
    } else if (name === 'LibraryPage') {
      LibraryPage();
    } else if (name === 'GymPage') {
      GymPage();
    } else if (name === 'TeachingBuildingPage') {
      TeachingBuildingPage();
    } else if (name === 'CampusCardPage') {
      CampusCardPage();
    } else if (name === 'ElectricityRechargePage') {
      ElectricityRechargePage();
    } else if (name === 'InfirmaryPage') {
      InfirmaryPage();
    } else if (name === 'LostFoundPage') {
      LostFoundPage();
    }
  }
}