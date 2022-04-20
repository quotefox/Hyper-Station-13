import { Fragment } from 'inferno';
import { Box, Grid, LabeledList, Section } from '../../components';


export const NaniteInfoBox = (props, context) => {
  const { program } = props;

  const {
    name, desc, activated, use_rate, can_trigger, trigger_cost, 
    trigger_cooldown, activation_code, deactivation_code, kill_code, 
    trigger_code, timer_restart, timer_shutdown, timer_trigger, 
    timer_trigger_delay,
  } = program;

  const extra_settings = program.extra_settings || [];

  return (
    <Section
      title={name}
      level={2}
      buttons={(
        <Box
          inline
          bold
          color={activated ? 'good' : 'bad'}>
          {activated ? 'Activated' : 'Deactivated'}
        </Box>
      )}>
      <Grid>
        <Grid.Column mr={1}>
          {desc}
        </Grid.Column>
        <Grid.Column size={0.5}>
          <LabeledList>
            <LabeledList.Item label="Use Rate">
              {use_rate}
            </LabeledList.Item>
            {!!can_trigger && (
              <Fragment>
                <LabeledList.Item label="Trigger Cost">
                  {trigger_cost}
                </LabeledList.Item>
                <LabeledList.Item label="Trigger Cooldown">
                  {trigger_cooldown}
                </LabeledList.Item>
              </Fragment>
            )}
          </LabeledList>
        </Grid.Column>
      </Grid>
      <Grid>
        <Grid.Column>
          <Section
            title="Codes"
            level={3}
            mr={1}>
            <LabeledList>
              <LabeledList.Item label="Activation">
                {activation_code}
              </LabeledList.Item>
              <LabeledList.Item label="Deactivation">
                {deactivation_code}
              </LabeledList.Item>
              <LabeledList.Item label="Kill">
                {kill_code}
              </LabeledList.Item>
              {!!can_trigger && (
                <LabeledList.Item label="Trigger">
                  {trigger_code}
                </LabeledList.Item>
              )}
            </LabeledList>
          </Section>
        </Grid.Column>
        <Grid.Column>
          <Section
            title="Delays"
            level={3}
            mr={1}>
            <LabeledList>
              <LabeledList.Item label="Restart">
                {timer_restart} s
              </LabeledList.Item>
              <LabeledList.Item label="Shutdown">
                {timer_shutdown} s
              </LabeledList.Item>
              {!!can_trigger && (
                <Fragment>
                  <LabeledList.Item label="Trigger">
                    {timer_trigger} s
                  </LabeledList.Item>
                  <LabeledList.Item label="Trigger Delay">
                    {timer_trigger_delay} s
                  </LabeledList.Item>
                </Fragment>
              )}
            </LabeledList>
          </Section>
        </Grid.Column>
      </Grid>
      <Section
        title="Extra Settings"
        level={3}>
        <LabeledList>
          {extra_settings.map(setting => {
            const naniteTypesDisplayMap = {
              number: <Fragment>{setting.value}{setting.unit}</Fragment>,
              text: setting.value,
              type: setting.value,
              boolean: (setting.value ? setting.true_text : setting.false_text),
            };
            return (
              <LabeledList.Item key={setting.name} label={setting.name}>
                {naniteTypesDisplayMap[setting.type]}
              </LabeledList.Item>
            );
          })}
        </LabeledList>
      </Section>
    </Section>
  );
};
