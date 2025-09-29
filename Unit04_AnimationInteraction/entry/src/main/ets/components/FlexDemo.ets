@Component
@Preview
export struct FlexDemo {
  @State skill: string[] = ['项目管理','Vue','Java','Python','JavaScript','鸿蒙开发','UI设计']

  build() {
    Flex({
      direction: FlexDirection.Row, // 水平排列
      wrap: FlexWrap.Wrap, // 换行
      justifyContent: FlexAlign.Start // 左对齐
    }) {
      ForEach(this.skill, (skill:
        string, index:
        number
      ) => {
        Text(skill)
          .fontSize(14)
          .fontColor('#333')
          .backgroundColor('')
          .padding({
            left: 12,
            right:12,
            top: 4,
            bottom: 4
          })
          .borderRadius(12)
          .margin({right: 8, bottom: 8})
      }
      )
    }
  }
}