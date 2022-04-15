import { useBackend } from '../backend';
import { NoticeBox } from '../components';
import { Window } from '../layouts';
import { LaunchpadControl } from './Launchpad/LaunchpadControl';


export const LaunchpadRemote = (props, context) => {
  const { data } = useBackend(context);

  const {
    has_pad, pad_closed,
  } = data;

  if (!has_pad) {
    return (
      <Window theme="syndicate">
        <Window.Content>
          <NoticeBox>
            No Launchpad Connected
          </NoticeBox>
        </Window.Content>
      </Window>
    );
  }

  if (pad_closed) {
    return (
      <Window theme="syndicate">
        <Window.Content>
          <NoticeBox>
            Launchpad Closed
          </NoticeBox>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window theme="syndicate">
      <Window.Content>
        <LaunchpadControl topLevel />
      </Window.Content>
    </Window>
  );
};
