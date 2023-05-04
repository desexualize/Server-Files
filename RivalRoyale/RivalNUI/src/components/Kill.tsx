import React from 'react';

export const Kill: React.FC<{
  deleteSelf: () => void;
  id: number;
  message: string;
  distance: number;
}> = ({ deleteSelf, id, message, distance }) => {
  setTimeout(deleteSelf, 5000);

  return (
    <label>
      {message} <span>[{distance}m]</span>
    </label>
  );
};
