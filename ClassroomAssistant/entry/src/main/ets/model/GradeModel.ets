// 单门课程
export interface Course {
  id: string;
  name: string;
  score: number; // 0-100
  term: string; // 如 "2025-2026-1"
}

// 统一数据层
@ObservedV2
export class GradeModel {
  // 原始数据
  @Trace public _list: Course[] = [];
  // 当前选中学期
  @Trace currentTerm: string = '全部学期';
  @Trace private _pageSize: number = 5; // 当前已展示条数
  @Trace private _step: number = 3; // 每次增量

  /** 对外暴露：是否还有数据 */
  get hasMore(): boolean {
    return this._pageSize < this.displayList.length;
  }

  /** 对外暴露：当前页要渲染的数据（先过滤再切片） */
  get pageList(): Course[] {
    return this.displayList.slice(0, this._pageSize);
  }

  constructor() {
    this.fetchAll(); // 现在这是同步的
  }

  // 改为同步方法
  fetchAll(): void {
    // 直接设置数据，不等待
    this._list = mockRemote();
    this.resetPage();
  }

  // 异步方法保留给刷新用
  async reload(): Promise<void> {
    await new Promise<void>(resolve => setTimeout(resolve, 600));
    this._list = mockRemote();
    this.resetPage();
  }

  /** 模拟下拉刷新：每门课成绩 ±1~3 分，60-100 截断 */
  async randomRefresh(): Promise<void> {
    await new Promise<void>(resolve => setTimeout(resolve, 600));
    // ① 整体替换数组，触发 @Trace
    this._list = this._list.map(c => {
      const delta = (Math.random() > 0.5 ? 1 : -1) * (Math.floor(Math.random() * 3) + 1);
      return {
        id: c.id,
        name: c.name,
        score: Math.min(100, Math.max(60, c.score + delta)),
        term: c.term
      } as Course;
    });
    this.resetPage();
  }

  /** 上拉加载更多 */
  async loadMore(): Promise<boolean> {
    if (!this.hasMore) {
      return false;
    }
    // 模拟网络延迟
    await new Promise<void>(r => setTimeout(r, 400));
    this._pageSize = Math.min(this._pageSize + this._step, this.displayList.length);
    return this.hasMore;
  }

  /** 任何“重新拉数据”的场景都要重置分页 */
  public resetPage(): void {
    this._pageSize = 8; // 初始 5 条
    this._step = 5; // 每次 +3
  }

  // 学期列表
  get termOptions(): string[] {
    const set = new Set(this._list.map(c => c.term));
    return ['全部学期', ...Array.from(set).sort()];
  }

  // 根据学期过滤后的列表
  get displayList(): Course[] {
    if (this.currentTerm === '全部学期') {
      return this._list.slice(); // ← 返回新引用
    }
    return this._list.filter(c => c.term === this.currentTerm).slice();
  }

  // 统计
  get avg(): number {
    const arr = this.displayList;
    if (!arr.length) {
      return 0;
    }
    const sum = arr.reduce((s, c) => s + c.score, 0);
    return Math.round(sum / arr.length);
  }

  get max(): number {
    const arr = this.displayList;
    return arr.length ? Math.max(...arr.map(c => c.score)) : 0;
  }

  get min(): number {
    const arr = this.displayList;
    return arr.length ? Math.min(...arr.map(c => c.score)) : 0;
  }
}

// 假数据
function mockRemote(): Course[] {
  return [
    /* === 原有 5 条 === */
    {
      id: '1',
      name: '高等数学',
      score: 86,
      term: '2025-2026-1'
    },
    {
      id: '2',
      name: '大学英语',
      score: 92,
      term: '2025-2026-1'
    },
    {
      id: '3',
      name: '程序设计',
      score: 78,
      term: '2025-2025-2'
    },
    {
      id: '4',
      name: '线性代数',
      score: 63,
      term: '2025-2025-2'
    },
    {
      id: '5',
      name: '物理实验',
      score: 55,
      term: '2025-2025-1'
    },

    /* === 新增计算机类 & 通识课（原有补充） === */
    {
      id: '6',
      name: '形势与政策',
      score: 95,
      term: '2025-2026-1'
    },
    {
      id: '7',
      name: '离散数学',
      score: 82,
      term: '2025-2026-1'
    },
    {
      id: '8',
      name: '编译技术',
      score: 76,
      term: '2025-2026-2'
    },
    {
      id: '9',
      name: '软件工程',
      score: 88,
      term: '2025-2026-2'
    },
    {
      id: '10',
      name: '创业基础',
      score: 90,
      term: '2025-2026-2'
    },
    {
      id: '11',
      name: '计算机网络技术',
      score: 73,
      term: '2025-2025-2'
    },
    {
      id: '12',
      name: '操作系统',
      score: 69,
      term: '2025-2025-2'
    },
    {
      id: '13',
      name: '数据库系统概论',
      score: 85,
      term: '2025-2025-1'
    },
    {
      id: '14',
      name: '人工智能导论',
      score: 91,
      term: '2025-2026-1'
    },
    {
      id: '15',
      name: '信息安全基础',
      score: 67,
      term: '2025-2026-2'
    },

    /* === 新增 通识教育类课程（2024-2025学年） === */
    {
      id: '16',
      name: '思想道德修养与法律基础',
      score: 89,
      term: '2024-2025-1'
    },
    {
      id: '17',
      name: '中国近现代史纲要',
      score: 93,
      term: '2024-2025-1'
    },
    {
      id: '18',
      name: '大学体育（篮球）',
      score: 77,
      term: '2024-2025-1'
    },
    {
      id: '19',
      name: '大学语文',
      score: 81,
      term: '2024-2025-2'
    },
    {
      id: '20',
      name: '环境保护导论',
      score: 84,
      term: '2024-2025-2'
    },

    /* === 新增 专业核心类课程（2024-2025学年） === */
    {
      id: '21',
      name: '数据结构',
      score: 72,
      term: '2024-2025-1'
    },
    {
      id: '22',
      name: 'C语言程序设计',
      score: 65,
      term: '2024-2025-1'
    },
    {
      id: '23',
      name: '概率论与数理统计',
      score: 79,
      term: '2024-2025-2'
    },
    {
      id: '24',
      name: '面向对象程序设计（Java）',
      score: 87,
      term: '2024-2025-2'
    },
    {
      id: '25',
      name: '数字逻辑电路',
      score: 61,
      term: '2024-2025-2'
    },

    /* === 新增 实践与选修类课程（跨学年） === */
    {
      id: '26',
      name: '软件开发综合实训',
      score: 94,
      term: '2024-2025-2'
    },
    {
      id: '27',
      name: 'Python数据分析',
      score: 83,
      term: '2025-2026-1'
    },
    {
      id: '28',
      name: '云计算基础',
      score: 75,
      term: '2025-2026-2'
    },
    {
      id: '29',
      name: '机器学习实践',
      score: 68,
      term: '2025-2026-2'
    },
    {
      id: '30',
      name: '毕业实习报告',
      score: 96,
      term: '2025-2026-2'
    },
    {
      id: '31',
      name: '算法设计与分析',
      score: 59,
      term: '2024-2025-1' // 不及格案例
    },
    {
      id: '32',
      name: '移动应用开发（Android）',
      score: 80,
      term: '2025-2026-1'
    },
    {
      id: '33',
      name: '网络安全攻防实践',
      score: 71,
      term: '2025-2026-2'
    },
    {
      id: '34',
      name: '大数据存储技术',
      score: 86,
      term: '2025-2026-1'
    },
    {
      id: '35',
      name: '学术论文写作',
      score: 92,
      term: '2024-2025-2'
    }
  ];
}