import React, { useState, useEffect } from 'react';
import { fetchClientData } from 'utils/DataHandler';

interface Warning {
  UID: number;
  WarningId: number;
  WarningType: string;
  WarningAdmin: string;
  WarningDate: string;
  WarningReason: string;
}

interface WarningProps {
  setViewingWarning: (Warning) => void;
}

export const WarningSideBar: React.FC<WarningProps> = ({ setViewingWarning }) => {
  const [sortedBy, setSortedBy] = useState<string>('REPORT ID');
  const [registeredWarnings, setRegisteredWarnings] = useState<any>([]);

  useEffect(() => {
    fetchClientData('RIVAL::fetchWarnings').then(setRegisteredWarnings);
  }, []);

  const handleSort = (): void => {
    const newSortingType = sortedBy === 'REPORT ID' ? 'DATE' : 'REPORT ID';
    setSortedBy(newSortingType);
    let sortedWarnings;

    if (newSortingType === 'REPORT ID') {
      sortedWarnings = registeredWarnings.sort((a, b) => {
        return a.warningId - b.warningId;
      });
    } else {
      sortedWarnings = registeredWarnings.sort((a, b) => {
        return new Date(a.warningDate).getTime() - new Date(b.warningDate).getTime();
      });
    }

    setRegisteredWarnings(sortedWarnings);
  };

  return (
    <div className='warning-sidebar'>
      <div className='warning-sidebar-info'>
        <h1>
          <span>RIVAL</span> WARFARE
        </h1>
        <label>WARNING HISTORY</label>
      </div>
      <div className='warning-sort-by' onClick={handleSort}>
        <span>SORT BY</span>
        <label>{sortedBy}</label>
      </div>
      <div className='warning-list'>
        {registeredWarnings.map((warning: Warning, idx: number) => (
          <section
            className='warning-card'
            data-type={warning.WarningType}
            key={idx}
            onClick={() => setViewingWarning(warning)}>
            <span>{warning.WarningType.toUpperCase()}</span>
            <label>#{warning.WarningId}</label>
          </section>
        ))}
      </div>
    </div>
  );
};
