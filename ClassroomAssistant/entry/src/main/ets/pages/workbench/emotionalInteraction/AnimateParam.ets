export interface AnimateParam {
  duration: number;
  curve?: Curve;
  onFinish?: () => void;
}