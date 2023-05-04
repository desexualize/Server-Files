import React from 'react';

export const Arrow = ({ onClick }) => {
  return (
    <svg
      width='13'
      height='25'
      viewBox='0 0 13 25'
      fill='none'
      xmlns='http://www.w3.org/2000/svg'
      onClick={onClick}>
      <path
        d='M0.338501 24.9932L4.38904 12.4427L0.446273 1.40371e-05L12.889 12.4427L0.338501 24.9932Z'
        fill='white'
      />
    </svg>
  );
};
