import React from 'react';

interface Props {
  onSell: () => void;
}

export const ButtonGroup: React.FC<Props> = ({ onSell }) => {
  return (
    <div className='btn-group'>
      <button>USE</button>
      <button>GIVE TO NEAREST</button>
      <button onClick={onSell}>SELL</button>
      <button>DESTROY</button>
    </div>
  );
};
