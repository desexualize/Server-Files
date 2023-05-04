import React from 'react';
import { DisputeIcon } from './DisputeIcon';

interface WarningProps {
  viewingWarning: any;
}

export const WarningDisplay: React.FC<WarningProps> = ({ viewingWarning }) => {
  const { WarningId, WarningType, WarningAdmin, WarningDate, WarningReason } = viewingWarning;

  return (
    <div className='warning-display'>
      <label className='warning-title'>{WarningType.toUpperCase()}</label>
      <div className='warning-content'>
        <label>
          <span>WARNING ID</span> {WarningId}
        </label>
        <label>
          <span>NAME</span> Katos
        </label>
        <label>
          <span>ADMIN</span> {WarningAdmin}
        </label>
        <label>
          <span>DATE</span> {WarningDate}
        </label>
      </div>
      <label className='warning-reason'>
        REASON
        <label>{WarningReason}</label>
      </label>
      <section className='warning-dispute'>
        <label>
          DISPUTE DESCRIPTION <span>[ONLY FOR FALSE WARNINGS]</span>
        </label>
        <textarea placeholder='DESCRIPTION...' />
        <button>
          DISPUTE CASE <DisputeIcon />
        </button>
      </section>
    </div>
  );
};
