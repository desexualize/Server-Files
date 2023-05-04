import create from 'zustand';
import { sendClientData } from 'utils/DataHandler';

interface SettingState {
  section: string;
  resetModal: boolean;

  GamePlay: any[];
  KeyBinds: any[];
  Audio: any[];

  setModalDisplay: (display: boolean) => void;

  // GamePlay
  toggleValue: (key: string) => void;
  setSection: (section: string) => void;
  forceNewSettings: <T>(settings: T) => void;
  setValue: (key: string, num: number) => void;
  applySettings: () => void;

  // KeyBinds
  updateKey: (key: string, value: string) => void;
  applyKeyBinds: () => void;

  // Audio
  setVolumeOverride: (key: string, num: number) => void;
  applyVolume: () => void;
}

const SettingsStore = (set, get) => ({
  section: 'GAMEPLAY',
  resetModal: false,

  GamePlay: [],
  KeyBinds: [],
  Audio: [],

  setModalDisplay: (value) => {
    set((state) => ({ resetModal: value }));
  },

  // GamePlay functions
  toggleValue: (key) => {
    const currentSettings = get().GamePlay;
    currentSettings[key].value = !currentSettings[key].value;

    set((state) => ({ GamePlay: currentSettings }));
  },

  setValue: (key, num) => {
    const currentSettings = get().GamePlay;
    currentSettings[key].value = num;

    set((state) => ({ GamePlay: currentSettings }));
  },

  setSection: (validSection) => {
    set((state) => ({ section: validSection }));
  },

  forceNewSettings: (kvpSettings) => {
    const { GamePlay, KeyBinds, Audio } = kvpSettings;
    set((state) => ({ GamePlay: GamePlay, KeyBinds: KeyBinds, Audio: Audio }));
  },

  applySettings: () => {
    sendClientData('RIVAL::applySettings', get().GamePlay);
  },

  // KeyBind functions
  updateKey: (key, value) => {
    const currentBinds = get().KeyBinds;
    currentBinds[key] = value;

    set((state) => ({ KeyBinds: currentBinds }));
  },

  applyKeyBinds: () => {
    sendClientData('RIVAL::applyKeys', get().KeyBinds);
  },

  // Volume functions
  setVolumeOverride: (key, num) => {
    const currentSettings = get().Audio;
    currentSettings[key] = num;

    set((state) => ({ Audio: currentSettings }));
  },

  applyVolume: () => {
    sendClientData('RIVAL::applyVolume', get().Audio);
  },
});

export const useSettings = create<SettingState>(SettingsStore);
