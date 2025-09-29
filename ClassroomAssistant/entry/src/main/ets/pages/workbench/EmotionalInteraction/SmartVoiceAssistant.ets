
@Component
export struct SmartVoiceAssistant {
 @State message: string = 'Hello World';

  build() {

      Row() {
        Text(this.message)
          .fontSize(30)
      }
      .height('100%')
      .width('100%')

  }
}