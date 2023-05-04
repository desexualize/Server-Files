import React, { useState, useRef } from 'react';
import { useOutsideClick } from 'utils/hooks';
import { sendClientData } from 'utils/DataHandler';
import { WarningDisplay } from './WarningDisplay';
import { WarningSideBar } from './WarningSideBar';

import './WarningSystem.scss';

const WarningSystem: React.FC = () => {
  const [viewingWarning, setViewingWarning] = useState<any>();
  const warningRef = useRef<HTMLDivElement>(null);

  useOutsideClick(warningRef, () => sendClientData('RIVAL::closeWarningSystem'));

  return (
    <div className='warning-container' ref={warningRef}>
      <WarningSideBar setViewingWarning={setViewingWarning} />
      {viewingWarning && <WarningDisplay viewingWarning={viewingWarning} />}
    </div>
  );
};

export default WarningSystem;
