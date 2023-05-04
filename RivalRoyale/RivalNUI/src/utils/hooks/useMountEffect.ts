import { useEffect, EffectCallback } from 'react';
const cachedEffects: string[] = [];

// Only gets called when parents does
export const useMountEffect = (effect: EffectCallback) => {
  return useEffect(effect, []);
};

// Gets called once once loaded
export const useMountEffectFixed = (effect: EffectCallback) => {
  if (cachedEffects[effect.toString()]) {
    return;
  }

  cachedEffects[effect.toString()] = true;
  effect();
};
