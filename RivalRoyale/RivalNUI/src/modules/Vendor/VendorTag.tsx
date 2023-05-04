import React from 'react';

export const VendorTag: React.FC<{ label: string }> = ({ label }) => {
  return <div className='vendor-tag'>{label}</div>;
};
