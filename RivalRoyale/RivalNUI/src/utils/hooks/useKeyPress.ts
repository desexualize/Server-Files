import { useMountEffectFixed } from '.';

export const useKeyPress = (targetKey: string, callback: () => void): void => {
  useMountEffectFixed(() =>
    window.addEventListener('keydown', (e: KeyboardEvent) => targetKey === e.key && callback())
  );
};
