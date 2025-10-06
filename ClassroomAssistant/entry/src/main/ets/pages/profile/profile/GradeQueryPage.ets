import { GradeContent } from '../../../view/GradeContent';

@Component
export struct GradeQueryPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      GradeContent()
    }
    .title('成绩查询')
    .hideTitleBar(false)
  }
}