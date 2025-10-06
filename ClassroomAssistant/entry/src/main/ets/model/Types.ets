// 节次时间接口
export interface SessionTime {
  session: number;
  start: string;
  end: string;
}

// 新增：滚动方向枚举（用于控制Scroll组件的滚动方向）
export enum Direction {
  None = 0, // 禁止滚动
  Vertical = 1, // 允许垂直滚动
  Horizontal = 2, // 允许水平滚动
  Both = 3 // 允许垂直和水平滚动
}