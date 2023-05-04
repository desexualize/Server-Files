type rangeSlider = { min: number; max: number };

export interface CardProps {
  value: boolean | number;
  label: string;
  type?: string;
  range?: rangeSlider;
}
