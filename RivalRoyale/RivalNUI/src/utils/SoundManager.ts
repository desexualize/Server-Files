import { RegisterCommand } from 'utils/CommandManager';
import { DownloadResource } from './Resource';
import { Howl, Howler } from 'howler';

const fileCache: never[] = [];

export const PlaySound = async (audioFile: string, volume?: number) => {
  let relativeSound = fileCache[audioFile];
  if (!relativeSound) {
    relativeSound = DownloadResource(`resources/sounds/${audioFile}.ogg`);
    fileCache[audioFile] = relativeSound;
  }

  const audioPlayer: HTMLAudioElement = new Audio(relativeSound);
  if (audioPlayer != null) audioPlayer.pause(); // If audioPlayer is already playing then pause that

  audioPlayer.volume = volume ?? 1.0;
  audioPlayer.play();
};

RegisterCommand('PLAY_SOUND', (data: any): void => {
  const { fileName, volume } = data;
  PlaySound(fileName, volume);
});

RegisterCommand('PLAY_3D_AUDIO', ({ audioFile, volume, coords, rotation }): void => {
  const relativeSound = DownloadResource(`resources/sounds/${audioFile}.ogg`);
  const howl = new Howl({ src: relativeSound });

  howl.pos(coords.x, coords.y, coords.z);
  howl.volume(volume ?? 1.0);
  howl.play();

  howl.pannerAttr({
    panningModel: 'equalpower',
    refDistance: 0.01,
    rolloffFactor: 40,
    distanceModel: 'linear',
  });
});

RegisterCommand('UPDATE_3D_AUDIO', ({ coords, rotation }) => {
  Howler.pos(coords.x, coords.y, coords.z);
  Howler.orientation(rotation.x, rotation.y, rotation.z, 0, 1, 0);
});
