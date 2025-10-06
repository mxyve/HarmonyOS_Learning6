// 周类型枚举
export enum WeekType {
  All = 0, // 每周
  Odd = 1, // 单周
  Even = 2 // 双周
}

// 课程信息接口
export interface Course {
  id: string;
  courseName: string;
  teacher: string;
  location: string;
  dayOfWeek: number; // 1-7 周一到周日
  startSession: number; // 开始节次
  endSession: number; // 结束节次
  startWeek: number; // 起始周
  endWeek: number; // 结束周
  weekType: WeekType; // 周类型
  color: string; // 课程颜色
}

// 颜色池 - 使用字符串数组
const COLOR_POOL: string[] = [
  '#FF6B82', '#4ECB71', '#3A8CFF', '#FFA235',
  '#9D5CFF', '#FF55C6', '#00CED1', '#FFD700',
  '#98FB98', '#FFA07A', '#87CEEB', '#DDA0DD',
  '#F08080', '#20B2AA', '#FF6347', '#9370DB'// 新增4个颜色，避免重复
];

// 根据课程名生成颜色
function getCourseColor(courseName: string): string {
  let hash: number = 0;
  for (let i = 0; i < courseName.length; i++) {
    hash = courseName.charCodeAt(i) + ((hash << 5) - hash);
  }
  const index: number = Math.abs(hash) % COLOR_POOL.length;
  return COLOR_POOL[index];
}

// 调整后的课程数据 - 新增6-9节课程，各周变化更大
export const mockCourses: Course[] = [
  // 原有课程（保持不变）
  {
    id: '1',
    courseName: '高等数学',
    teacher: '张教授',
    location: '教学楼A301',
    dayOfWeek: 1,
    startSession: 1,
    endSession: 2,
    startWeek: 1,
    endWeek: 8,
    weekType: WeekType.All,
    color: getCourseColor('高等数学')
  },
  {
    id: '2',
    courseName: '大学英语',
    teacher: '李老师',
    location: '外语楼102',
    dayOfWeek: 1,
    startSession: 3,
    endSession: 4,
    startWeek: 1,
    endWeek: 16,
    weekType: WeekType.All,
    color: getCourseColor('大学英语')
  },
  {
    id: '3',
    courseName: '计算机基础',
    teacher: '王教授',
    location: '计算机中心201',
    dayOfWeek: 2,
    startSession: 1,
    endSession: 2,
    startWeek: 9,
    endWeek: 16,
    weekType: WeekType.All,
    color: getCourseColor('计算机基础')
  },
  {
    id: '4',
    courseName: '线性代数',
    teacher: '刘老师',
    location: '教学楼B205',
    dayOfWeek: 3,
    startSession: 3,
    endSession: 4,
    startWeek: 1,
    endWeek: 12,
    weekType: WeekType.Odd,
    color: getCourseColor('线性代数')
  },
  {
    id: '5',
    courseName: '体育',
    teacher: '陈教练',
    location: '体育馆',
    dayOfWeek: 3,
    startSession: 5,
    endSession: 6,
    startWeek: 1,
    endWeek: 16,
    weekType: WeekType.All,
    color: getCourseColor('体育')
  },
  {
    id: '6',
    courseName: '数据结构',
    teacher: '赵教授',
    location: '计算机中心301',
    dayOfWeek: 4,
    startSession: 1,
    endSession: 3,
    startWeek: 5,
    endWeek: 16,
    weekType: WeekType.All,
    color: getCourseColor('数据结构')
  },
  {
    id: '7',
    courseName: '概率论',
    teacher: '周老师',
    location: '教学楼A101',
    dayOfWeek: 5,
    startSession: 3,
    endSession: 4,
    startWeek: 4,
    endWeek: 14,
    weekType: WeekType.Even,
    color: getCourseColor('概率论')
  },
  {
    id: '8',
    courseName: '大学物理',
    teacher: '吴教授',
    location: '实验楼105',
    dayOfWeek: 2,
    startSession: 5,
    endSession: 6,
    startWeek: 1,
    endWeek: 8,
    weekType: WeekType.All,
    color: getCourseColor('大学物理')
  },
  {
    id: '9',
    courseName: '马克思主义原理',
    teacher: '郑老师',
    location: '人文楼203',
    dayOfWeek: 5,
    startSession: 1,
    endSession: 2,
    startWeek: 1,
    endWeek: 10,
    weekType: WeekType.Odd,
    color: getCourseColor('马克思主义原理')
  },
  {
    id: '10',
    courseName: '专业导论',
    teacher: '孙教授',
    location: '教学楼C101',
    dayOfWeek: 4,
    startSession: 5,
    endSession: 6,
    startWeek: 11,
    endWeek: 16,
    weekType: WeekType.All,
    color: getCourseColor('专业导论')
  },
  {
    id: '11',
    courseName: '英语口语',
    teacher: 'Smith',
    location: '外语楼305',
    dayOfWeek: 6,
    startSession: 1,
    endSession: 2,
    startWeek: 3,
    endWeek: 15,
    weekType: WeekType.Even,
    color: getCourseColor('英语口语')
  },

  // -------------------------- 新增：6-9节课程 --------------------------
  // 1. 周一 6-7节：Python编程（覆盖6-7节）
  {
    id: '12',
    courseName: 'Python编程',
    teacher: '马老师',
    location: '计算机中心103',
    dayOfWeek: 1, // 周一
    startSession: 6,
    endSession: 7,
    startWeek: 2,
    endWeek: 14,
    weekType: WeekType.All,
    color: getCourseColor('Python编程')
  },
  // 2. 周二 7-8节：数据库原理（覆盖7-8节）
  {
    id: '13',
    courseName: '数据库原理',
    teacher: '朱老师',
    location: '计算机中心402',
    dayOfWeek: 2, // 周二
    startSession: 7,
    endSession: 8,
    startWeek: 5,
    endWeek: 16,
    weekType: WeekType.Odd,
    color: getCourseColor('数据库原理')
  },
  // 3. 周四 8-9节：软件工程（覆盖8-9节）
  {
    id: '14',
    courseName: '软件工程',
    teacher: '何教授',
    location: '教学楼B308',
    dayOfWeek: 4, // 周四
    startSession: 8,
    endSession: 9,
    startWeek: 1,
    endWeek: 10,
    weekType: WeekType.All,
    color: getCourseColor('软件工程')
  },
  // 4. 周五 6-8节：人工智能导论（覆盖6-8节）
  {
    id: '15',
    courseName: '人工智能导论',
    teacher: '郭老师',
    location: '计算机中心205',
    dayOfWeek: 5, // 周五
    startSession: 6,
    endSession: 8,
    startWeek: 9,
    endWeek: 16,
    weekType: WeekType.Even,
    color: getCourseColor('人工智能导论')
  },
  // 5. 周日 7-9节：创新创业实践（覆盖7-9节，周日有课更真实）
  {
    id: '16',
    courseName: '创新创业实践',
    teacher: '韩老师',
    location: '创客空间101',
    dayOfWeek: 7, // 周日
    startSession: 7,
    endSession: 9,
    startWeek: 3,
    endWeek: 15,
    weekType: WeekType.All,
    color: getCourseColor('创新创业实践')
  }
];