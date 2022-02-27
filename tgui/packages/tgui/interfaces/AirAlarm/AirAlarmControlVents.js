import { decodeHtmlEntities } from 'common/string';
import { useBackend } from '../../backend';
import { Button, LabeledList, NumberInput, Section } from '../../components';

//  Vents
// --------------------------------------------------------
export const AirAlarmControlVents = (props, context) => {
  const { state } = props;
  const { data } = useBackend(context);
  const { vents } = data;
  if (!vents || vents.length === 0) {
    return 'Nothing to show';
  }
  return vents.map(vent => (
    <Vent key={vent.id_tag}
      state={state}
      {...vent} />
  ));
};


const Vent = (props, context) => {
  const {
    id_tag, long_name, power, checks, excheck, incheck, 
    direction, external, internal, extdefault, intdefault,
  } = props;
  const { act } = useBackend(context);
  return (
    <Section
      level={2}
      title={decodeHtmlEntities(long_name)}
      buttons={(
        <Button
          icon={power ? 'power-off' : 'times'}
          selected={power}
          content={power ? 'On' : 'Off'}
          onClick={() => act('power', {
            id_tag,
            val: Number(!power),
          })} />
      )}>
      <LabeledList>
        <LabeledList.Item label="Mode">
          {direction === 'release' ? 'Pressurizing' : 'Releasing'}
        </LabeledList.Item>
        <LabeledList.Item label="Pressure Regulator">
          <Button
            icon="sign-in-alt"
            content="Internal"
            selected={incheck}
            onClick={() => act('incheck', {
              id_tag,
              val: checks,
            })} />
          <Button
            icon="sign-out-alt"
            content="External"
            selected={excheck}
            onClick={() => act('excheck', {
              id_tag,
              val: checks,
            })} />
        </LabeledList.Item>
        {!!incheck && (
          <LabeledList.Item label="Internal Target">
            <NumberInput
              value={Math.round(internal)}
              unit="kPa"
              width="75px"
              minValue={0}
              step={10}
              maxValue={5066}
              onChange={(e, value) => act('set_internal_pressure', {
                id_tag,
                value,
              })} />
            <Button
              icon="undo"
              disabled={intdefault}
              content="Reset"
              onClick={() => act('reset_internal_pressure', {
                id_tag,
              })} />
          </LabeledList.Item>
        )}
        {!!excheck && (
          <LabeledList.Item label="External Target">
            <NumberInput
              value={Math.round(external)}
              unit="kPa"
              width="75px"
              minValue={0}
              step={10}
              maxValue={5066}
              onChange={(e, value) => act('set_external_pressure', {
                id_tag,
                value,
              })} />
            <Button
              icon="undo"
              disabled={extdefault}
              content="Reset"
              onClick={() => act('reset_external_pressure', {
                id_tag,
              })} />
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};
