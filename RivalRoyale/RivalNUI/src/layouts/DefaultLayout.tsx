import React from 'react';

interface Props {
  className?: string;
}

export const DefaultLayout: React.FC<Props> = React.memo(({ className, children }) => {
  // Todo
  return <div className={className}>{children}</div>;
});
