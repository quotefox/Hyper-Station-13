import { useBackend } from '../backend';
import { Window } from '../layouts';
import { AirAlarmControl } from './AirAlarm/AirAlarmControl';
import { AirAlarmStatus } from './AirAlarm/AirAlarmStatus';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';

export const AirAlarm = (props, context) => {
  const { state } = props;
  const { act, data } = useBackend(context);
  const locked = data.locked && !data.siliconUser;
  return (
    <Window>
      <Window.Content>
        <InterfaceLockNoticeBox
          siliconUser={data.siliconUser}
          locked={data.locked}
          onLockStatusChange={() => act('lock')} />
        <AirAlarmStatus state={state} />
        {!locked && (
          <AirAlarmControl state={state} />
        )}
      </Window.Content>
    </Window>
  );
};