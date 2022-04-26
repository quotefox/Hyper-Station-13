import { Fragment } from 'inferno';
import { AnimatedNumber, Box, Button, LabeledList, Section } from '../components';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';
import { Window } from '../layouts';
import { Catalog } from './Cargo/Catalog';
import { useBackend } from '../backend';


export const CargoExpress = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    siliconUser,
    locked,
    points,
    usingBeacon,
    hasBeacon,
    beaconName,
    beaconzone,
    printMsg,
    canBuyBeacon,
    message,
  } = data;

  const supplies = Object.values(data.supplies);

  return (
    <Window resizable>
      <Window.Content scrollable>
        <InterfaceLockNoticeBox
          siliconUser={siliconUser}
          locked={locked}
          onLockStatusChange={() => act('lock')}
          accessText="a QM-level ID card" />
        {!locked && (
          <Fragment>
            <Section
              title="Cargo Express"
              buttons={(
                <Box inline bold>
                  <AnimatedNumber value={Math.round(points)} /> credits
                </Box>
              )}>
              <LabeledList>
                <LabeledList.Item label="Landing Location">
                  <Button
                    content="Cargo Bay"
                    selected={!usingBeacon}
                    onClick={() => act('LZCargo')} />
                  <Button
                    selected={usingBeacon}
                    disabled={!hasBeacon}
                    onClick={() => act('LZBeacon')}>
                    {beaconzone} ({beaconName})
                  </Button>
                  <Button
                    content={printMsg}
                    disabled={!canBuyBeacon}
                    onClick={() => act('printBeacon')} />
                </LabeledList.Item>
                <LabeledList.Item label="Notice">
                  {message}
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Catalog supplies={supplies} />
          </Fragment>
        )}
      </Window.Content>
    </Window>
  );
};
