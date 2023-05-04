import { useRef } from 'react';

export const useRenderCount = (): number => {
  const renderCount = useRef<number>(0);
  renderCount.current = renderCount.current + 1;

  return renderCount.current;
};
