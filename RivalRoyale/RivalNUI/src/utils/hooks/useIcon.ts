import { DownloadResource } from 'utils/Resource';

interface weaponData {
  [index: string]: { type: string; src: string };
}

const weaponCache: weaponData = {
  M700a: { type: 'Sniper', src: DownloadResource('resources/photos/WeaponM700a.png') },
  SR25: { type: 'Sniper', src: DownloadResource('resources/photos/WeaponSR25.png') },
  SVD: { type: 'Sniper', src: DownloadResource('resources/photos/WeaponSVD.png') },
  M203: { type: 'AR', src: DownloadResource('resources/photos/WeaponM203.png') },
  NSR: { type: 'AR', src: DownloadResource('resources/photos/WeaponNSR.png') },
  'SIG 516': { type: 'AR', src: DownloadResource('resources/photos/WeaponSIG516.png') },
  SIGMpx: { type: 'SMG', src: DownloadResource('resources/photos/WeaponSigMpx.png') },
  Thompson: { type: 'SMG', src: DownloadResource('resources/photos/WeaponThompson.png') },
  'Mossberg 590': {
    type: 'Shotgun',
    src: DownloadResource('resources/photos/WeaponMossberg590.png'),
  },
  M870: { type: 'Shotgun', src: DownloadResource('resources/photos/WeaponW1200.png') },
  'Glock 22': { type: 'Pistol', src: DownloadResource('resources/photos/WeaponGlock22.png') },
  Molotov: { type: 'Throwable', src: '' },
};

export const useIcon = (weapon: string): { type: string; src: string } => {
  return weaponCache[weapon];
};
