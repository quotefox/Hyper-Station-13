import { Fragment } from 'inferno';
import { useBackend } from '../../backend';
import { LabeledList, NumberInput, Section } from '../../components';


export const NaniteDelays = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Section
      title="Delays"
      level={3}
      ml={1}>
      <LabeledList>
        <LabeledList.Item label="Restart Timer">
          <NumberInput
            value={data.timer_restart}
            unit="s"
            width="57px"
            minValue={0}
            maxValue={3600}
            onChange={(e, value) => act('set_restart_timer', {
              delay: value,
            })} />
        </LabeledList.Item>
        <LabeledList.Item label="Shutdown Timer">
          <NumberInput
            value={data.timer_shutdown}
            unit="s"
            width="57px"
            minValue={0}
            maxValue={3600}
            onChange={(e, value) => act('set_shutdown_timer', {
              delay: value,
            })} />
        </LabeledList.Item>
        {!!data.can_trigger && (
          <Fragment>
            <LabeledList.Item label="Trigger Repeat Timer">
              <NumberInput
                value={data.timer_trigger}
                unit="s"
                width="57px"
                minValue={0}
                maxValue={3600}
                onChange={(e, value) => act('set_trigger_timer', {
                  delay: value,
                })} />
            </LabeledList.Item>
            <LabeledList.Item label="Trigger Delay">
              <NumberInput
                value={data.timer_trigger_delay}
                unit="s"
                width="57px"
                minValue={0}
                maxValue={3600}
                onChange={(e, value) => act('set_timer_trigger_delay', {
                  delay: value,
                })} />
            </LabeledList.Item>
          </Fragment>
        )}
      </LabeledList>
    </Section>
  );
};
