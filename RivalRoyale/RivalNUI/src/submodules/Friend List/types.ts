export interface Friend {
  id: number | unknown;
  name: string;
  status: string;
}

export interface FriendProp extends Friend {
  onClick: (event, player: number | unknown) => void;
}
