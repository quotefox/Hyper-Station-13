import { useBackend } from '../../backend';
import { LabeledList, NumberInput, Section } from '../../components';


export const NaniteCodes = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section
      title="Codes"
      level={3}
      mr={1}>
      <LabeledList>
        <LabeledList.Item label="Activation">
          <NumberInput
            value={data.activation_code}
            width="47px"
            minValue={0}
            maxValue={9999}
            onChange={(e, value) => act('set_code', {
              target_code: "activation",
              code: value,
            })} />
        </LabeledList.Item>
        <LabeledList.Item label="Deactivation">
          <NumberInput
            value={data.deactivation_code}
            width="47px"
            minValue={0}
            maxValue={9999}
            onChange={(e, value) => act('set_code', {
              target_code: "deactivation",
              code: value,
            })} />
        </LabeledList.Item>
        <LabeledList.Item label="Kill">
          <NumberInput
            value={data.kill_code}
            width="47px"
            minValue={0}
            maxValue={9999}
            onChange={(e, value) => act('set_code', {
              target_code: 'kill',
              code: value,
            })} />
        </LabeledList.Item>
        {!!data.can_trigger && (
          <LabeledList.Item label="Trigger">
            <NumberInput
              value={data.trigger_code}
              width="47px"
              minValue={0}
              maxValue={9999}
              onChange={(e, value) => act('set_code', {
                target_code: 'trigger',
                code: value,
              })} />
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};
