import { Fragment } from 'inferno';
import { act } from '../byond';
import { AnimatedNumber, Box, Button, LabeledList, Section } from '../components';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';
import { Catalog } from './Cargo';


export const CargoExpress = props => {
  const { state } = props;
  const { config, data } = state;
  const { ref } = config;
  const supplies = data.supplies || {};
  return (
    <Fragment>
      <InterfaceLockNoticeBox
        siliconUser={data.siliconUser}
        locked={data.locked}
        onLockStatusChange={() => act(ref, 'lock')}
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
                  onClick={() => act(ref, 'LZCargo')} />
                <Button
                  selected={data.usingBeacon}
                  disabled={!data.hasBeacon}
                  onClick={() => act(ref, 'LZBeacon')}>
                  {data.beaconzone} ({data.beaconName})
                </Button>
                <Button
                  content={data.printMsg}
                  disabled={!data.canBuyBeacon}
                  onClick={() => act(ref, 'printBeacon')} />
              </LabeledList.Item>
              <LabeledList.Item label="Notice">
                {data.message}
              </LabeledList.Item>
            </LabeledList>
          </Section>
          <Catalog state={state} supplies={supplies} />
        </Fragment>
      )}
    </Fragment>
  );
};
