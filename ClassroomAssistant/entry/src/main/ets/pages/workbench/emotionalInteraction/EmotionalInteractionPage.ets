import {ClassroomRewards} from './ClassroomRewards';
import {SmartVoiceAssistant} from './SmartVoiceAssistant';

@Component
export struct EmotionalInteractionPage {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      ClassroomRewards()
      // SmartVoiceAssistant()
    }
    .title('Workbench')

  }
}