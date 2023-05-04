import React, { useState, useRef } from 'react';
import { RegisterCommand } from 'utils/CommandManager';
import { useIcon } from 'utils/hooks';

export const WeaponHolder = () => {
  const [holdingWeapon, setHoldingWeapon] = useState<string>('');
  const weaponData = useIcon(holdingWeapon);
  const clipRef = useRef<HTMLSpanElement>(null);
  const ammoRef = useRef<HTMLParagraphElement>(null);

  RegisterCommand('EQUIP_WEAPON', setHoldingWeapon);
  RegisterCommand('FORCE_AMMO_DATA', (data) => {
    if (clipRef.current) clipRef.current.innerText = data.clip;
    if (ammoRef.current) ammoRef.current.innerText = data.ammo;
  });

  if (!weaponData) {
    return null;
  }

  return (
    <div className='ingame-weapon-holder'>
      <img alt='' src={weaponData.src} />
      <section />
      <div className='image-weapon-holder-content'>
        <div>
          <span ref={clipRef}>30</span>
          <p ref={ammoRef}>210</p>
        </div>
        <label>{holdingWeapon}</label>
      </div>
    </div>
  );
};
