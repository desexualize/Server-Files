import React, { useState } from 'react';
import { fetchClientData } from 'utils/DataHandler';
import { useSettings, useNotification } from 'stores';
import { LargeKey } from './LargeKey';
import { MediumKey } from './MediumKey';
import { SmallKey } from './SmallKey';

export const KeyCard: React.FC<any> = (props) => {
  const { value = 'NONE', label } = props;

  const [pressKey, setPressKey] = useState<boolean>(false);
  const updateKey = useSettings((state) => state.updateKey);
  const pushNotification = useNotification((state) => state.pushNotification);

  const handleKeySwap = (): void => {
    setPressKey(true);

    const waitForInput = (e: KeyboardEvent) => {
      const pressedKey: string = e.key.length === 0 || !e.key.trim() ? e.code : e.key;

      if (pressedKey) {
        if (pressedKey === 'Backspace') {
          setPressKey(false);
          updateKey(label, 'NONE');

          return window.removeEventListener('keydown', waitForInput);
        }

        fetchClientData('RIVAL::IsKeySafe', pressedKey.toUpperCase()).then((wasSafe: boolean) => {
          if (wasSafe) {
            setPressKey(false);
            updateKey(label, pressedKey.toUpperCase());
            window.removeEventListener('keydown', waitForInput);
          } else {
            // Key is not supported
            pushNotification({
              id: Math.random(),
              type: 'message',
              message: 'KEY IS NOT SUPPORTED!',
              callbackUrl: '',
            });
          }
        });
      }
    };

    window.addEventListener('keydown', waitForInput);
  };

  return (
    <div className='settings-card settings-key-card' onClick={handleKeySwap}>
      <label>{label}</label>

      {pressKey ? (
        <p>PRESS A KEY</p>
      ) : value.length <= 2 ? (
        <SmallKey value={value} />
      ) : value.length <= 5 ? (
        <MediumKey value={value} />
      ) : (
        <LargeKey value={value} />
      )}
    </div>
  );
};
