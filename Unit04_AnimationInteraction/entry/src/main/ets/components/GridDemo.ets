@Component
@Preview
export struct GridDemo {
    @State assignments: Assignment[] = [
      { title: '数学作业', deadline: '2025-09-15', status: 'pending' },
      { title: 'Java编程', deadline: '2025-09-16', status: 'completed' },
      { title: '英语作文', deadline: '2025-09-17', status: 'pending' },
      { title: '物理实验', deadline: '2025-09-18', status: 'overdue' },
      { title: '化学报告', deadline: '2025-09-19', status: 'pending' },
      { title: '历史论文', deadline: '2025-09-20', status: 'completed' }
    ]

    build() {
        Grid() {
          ForEach
          (this.assignments, (assignment: Assignment) => {
            GridItem() {
              Column({ space: 8 }) {
                // 作业标题
                Text(assignment.title).fontSize(16)

                // 作业状态图标
                Text(this.getIconByStatus(assignment.status)).fontSize(24)
                Text(assignment.status).fontColor(this.getColorByStatus(assignment.status)).fontSize(26)
                Text(assignment.deadline).fontSize(12)
              }
            }
          })
        }.columnsTemplate('1fr 1fr')
        .rowsTemplate('auto auto auto')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
        .padding(16)
    }

    getIconByStatus(status: string): string {
      switch (status) {
        case 'completed':
          return '✅'; // 已完成
        case 'pending':
          return '📝'; // 待完成
        case 'overdue':
          return '⚠'; // 已逾期
        default:
          return '📋';
      }
    }

    getColorByStatus(status: string): string {
      switch (status) {
        case 'completed':
          return '#00B050'; // 绿色
        case 'pending':
          return '#FFC000'; // 橙色
        case 'overdue':
          return '#FF0000'; // 红色
        default:
          return '#000000';
      }
    }
}

interface Assignment {
  title: string;
  deadline: string;
  status: string;
}