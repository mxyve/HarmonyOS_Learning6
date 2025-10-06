import {GradeChart} from './GradeChart';
import {LearningProgressBar} from './LearningProgressBar';
@Component
export struct DataStatisticsPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      LearningProgressBar()
      GradeChart()

    }
    .title('Workbench')

  }
}