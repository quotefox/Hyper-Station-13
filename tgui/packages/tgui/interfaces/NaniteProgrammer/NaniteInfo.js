import { Fragment } from 'inferno';
import { Grid, LabeledList, Section } from '../../components';

export const NaniteInfo = data => {
  const {
    desc, use_rate, can_trigger, trigger_cost, trigger_cooldown,
  } = data;

  return (
    <Section
      title="Info"
      level={2}>
      <Grid>
        <Grid.Column>
          {desc}
        </Grid.Column>
        <Grid.Column size={0.7}>
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
    </Section>
  );
};
