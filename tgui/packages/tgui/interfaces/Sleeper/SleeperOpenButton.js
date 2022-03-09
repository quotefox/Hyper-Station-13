import { Button } from '../../components';


export const SleeperOpenButton = (props, context) => {
  const { data, act } = props;
  const { open } = data;

  return (
    <Button
      icon={open ? 'door-open' : 'door-closed'}
      content={open ? 'Open' : 'Closed'}
      onClick={() => act('door')} />
  );
};
