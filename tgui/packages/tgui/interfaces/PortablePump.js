import { useBackend } from '../backend';
import { Fragment } from 'inferno';
import { Section, LabeledList, Button, NumberInput } from '../components';
import { PortableBasicInfo } from './PortableBasicInfo';


export const PortablePump = props => {
  const { act, data } = useBackend(props);

  const {
    direction, holding, target_pressure, 
    default_pressure, min_pressure, max_pressure,
  } = data;

  return (
    <Fragment>
      <PortableBasicInfo state={props.state} />
      <Section
        title="Pump"
        buttons={(
          <Button
            icon={direction ? 'sign-in-alt' : 'sign-out-alt'}
            content={direction ? 'In' : 'Out'}
            selected={direction}
            onClick={() => act('direction')} />
        )}>
        <LabeledList>
          <LabeledList.Item label="Output">
            <NumberInput
              value={target_pressure}
              unit="kPa"
              width="75px"
              minValue={min_pressure}
              maxValue={max_pressure}
              step={10}
              onChange={(e, value) => act('pressure', {
                pressure: value,
              })} />
          </LabeledList.Item>
          <LabeledList.Item label="Presets">
            <Button
              icon="minus"
              disabled={target_pressure === min_pressure}
              onClick={() => act('pressure', {
                pressure: 'min',
              })} />
            <Button
              icon="sync"
              disabled={target_pressure === default_pressure}
              onClick={() => act('pressure', {
                pressure: 'reset',
              })} />
            <Button
              icon="plus"
              disabled={target_pressure === max_pressure}
              onClick={() => act('pressure', {
                pressure: 'max',
              })} />
          </LabeledList.Item>
        </LabeledList>
      </Section>
    </Fragment>
  );
};
