import { Course, WeekType } from '../model/Course';
import { SessionTime } from '../model/Types';

// 时间节次配置 - 使用显式类型
export const SESSION_TIMES: SessionTime[] = [
  { session: 1, start: '08:00', end: '08:45' },
  { session: 2, start: '08:55', end: '09:40' },
  { session: 3, start: '10:00', end: '10:45' },
  { session: 4, start: '10:55', end: '11:40' },
  { session: 5, start: '14:00', end: '14:45' },
  { session: 6, start: '14:55', end: '15:40' },
  { session: 7, start: '16:00', end: '16:45' },
  { session: 8, start: '16:55', end: '17:40' },
  { session: 9, start: '19:00', end: '19:45' }
];

// 星期几名称 - 使用字符串数组
export const WEEK_DAYS: string[] = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日'];

// 检查课程是否在当前周次
export function isCourseInWeek(course: Course, currentWeek: number): boolean {
  // 检查周次范围
  if (currentWeek < course.startWeek || currentWeek > course.endWeek) {
    return false;
  }

  // 检查周类型
  switch (course.weekType) {
    case WeekType.All:
      return true;
    case WeekType.Odd:
      return currentWeek % 2 === 1;
    case WeekType.Even:
      return currentWeek % 2 === 0;
    default:
      return true;
  }
}

// 获取当前时间对应的节次
export function getCurrentSession(): number {
  const now = new Date();
  const hours = now.getHours();
  const minutes = now.getMinutes();
  const currentTime = hours * 60 + minutes;

  for (let i = 0; i < SESSION_TIMES.length; i++) {
    const session: SessionTime = SESSION_TIMES[i];

    // 避免解构，使用传统方式
    const startParts: string[] = session.start.split(':');
    const endParts: string[] = session.end.split(':');

    const startHour: number = Number(startParts[0]);
    const startMinute: number = Number(startParts[1]);
    const endHour: number = Number(endParts[0]);
    const endMinute: number = Number(endParts[1]);

    const startTime: number = startHour * 60 + startMinute;
    const endTime: number = endHour * 60 + endMinute;

    if (currentTime >= startTime && currentTime <= endTime) {
      return session.session;
    }
  }

  return -1; // 不在任何节次中
}

// 获取当前星期几 (1-7)
export function getCurrentDayOfWeek(): number {
  const day: number = new Date().getDay();
  return day === 0 ? 7 : day; // 周日返回7
}