import { Fragment } from 'inferno';
import { AnimatedNumber, Box, Button, LabeledList, Section } from '../components';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';
import { Window } from '../layouts';
import { Catalog } from './Cargo/Catalog';
import { useBackend } from '../backend';


export const CargoExpress = (props, context) => {
  const { config, data, act } = useBackend(context);
  const { ref } = config;
  const supplies = data.supplies || {};
  return (
    <Window>
      <Window.Content>
        <InterfaceLockNoticeBox
          siliconUser={data.siliconUser}
          locked={data.locked}
          onLockStatusChange={() => act('lock')}
          accessText="a QM-level ID card" />
        {!data.locked && (
          <Fragment>
            <Section
              title="Cargo Express"
              buttons={(
                <Box inline bold>
                  <AnimatedNumber value={Math.round(data.points)} /> credits
                </Box>
              )}>
              <LabeledList>
                <LabeledList.Item label="Landing Location">
                  <Button
                    content="Cargo Bay"
                    selected={!data.usingBeacon}
                    onClick={() => act('LZCargo')} />
                  <Button
                    selected={data.usingBeacon}
                    disabled={!data.hasBeacon}
                    onClick={() => act('LZBeacon')}>
                    {data.beaconzone} ({data.beaconName})
                  </Button>
                  <Button
                    content={data.printMsg}
                    disabled={!data.canBuyBeacon}
                    onClick={() => act('printBeacon')} />
                </LabeledList.Item>
                <LabeledList.Item label="Notice">
                  {data.message}
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
