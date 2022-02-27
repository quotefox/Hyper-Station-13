import { useBackend } from '../../backend';
import { NoticeBox } from '../../components';
import { LaunchpadControl } from '../Launchpad';


export const LaunchpadRemote = (props, context) => {
  const { data } = useBackend(context);

  const {
    has_pad, pad_closed,
  } = data;

  if (!has_pad) {
    return (
      <NoticeBox>
        No Launchpad Connected
      </NoticeBox>
    );
  }

  if (pad_closed) {
    return (
      <NoticeBox>
        Launchpad Closed
      </NoticeBox>
    );
  }

  return (
    <LaunchpadControl topLevel state={props.state} />
  );
};
