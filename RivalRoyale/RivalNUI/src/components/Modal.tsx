import React, { useRef } from 'react';
import { useOutsideClick } from 'utils/hooks';

interface ModalProps {
  setDisplay: (boolean) => void;
  width?: string;
  height?: string;
  className?: string;
}

export const Modal: React.FC<ModalProps> = ({ className, setDisplay, children, width, height }) => {
  const modalRef = useRef<HTMLDivElement>(null);

  const handleKeyDown = ({ code }) => code === 'Escape' && setDisplay(false);
  useOutsideClick(modalRef, () => setDisplay(false));

  return (
    <div className='modal-overlay' onKeyDown={handleKeyDown}>
      <div className={`modal ${className}`} ref={modalRef} style={{ width: width, height: height }}>
        {children}
      </div>
    </div>
  );
};
