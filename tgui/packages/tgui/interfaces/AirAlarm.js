import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';
import { AirAlarmControl } from './AirAlarm/AirAlarmControl';
import { AirAlarmStatus } from './AirAlarm/AirAlarmStatus';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';

export const AirAlarm = (props, context) => {
  const { act, data } = useBackend(context);
  const locked = data.locked && !data.siliconUser;

  return (
    <Window>
      <Window.Content scrollable>
        <InterfaceLockNoticeBox
          siliconUser={data.siliconUser}
          locked={data.locked}
          onLockStatusChange={() => act('lock')} />
        <AirAlarmStatus />
        {!locked && (
          <AirAlarmControl />
        )}
      </Window.Content>
    </Window>
  );
};