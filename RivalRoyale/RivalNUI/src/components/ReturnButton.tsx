import React from 'react';
import { useHistory } from 'react-router-dom';
import { sendClientData } from 'utils/DataHandler';

interface ButtonProps {
  onClick?: any;
}

export const ReturnButton: React.FC<ButtonProps> = (props) => {
  const { onClick } = props;
  const history = useHistory();

  const handleClick = (): void => {
    onClick && onClick();
    history.goBack();
    sendClientData('RIVAL::requestSquadPlayers');
  };

  return (
    <button className='btn-return' onClick={handleClick}>
      RETURN
    </button>
  );
};
