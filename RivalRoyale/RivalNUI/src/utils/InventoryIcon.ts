import { useIcon } from './hooks';

interface cacheType {
  [index: string]: string;
}

const iconCache: cacheType = {
  empty: '',
};

export function getInventoryIcon(label: string, type: string) {
  if (type === 'weapon') {
    // eslint-disable-next-line react-hooks/rules-of-hooks
    return useIcon(label).src ?? '';
  }

  return iconCache[label] || iconCache[type];
}
