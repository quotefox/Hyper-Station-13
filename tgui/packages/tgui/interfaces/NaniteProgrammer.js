import { useBackend } from '../backend';
import { Button, Grid, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';
import { NaniteInfo } from './NaniteProgrammer/NaniteInfo';
import { NaniteCodes } from './NaniteProgrammer/NaniteCodes';
import { NaniteDelays } from './NaniteProgrammer/NaniteDelays';
import { NaniteExtraEntry } from './NaniteProgrammer/NaniteExtraEntry';

export const NaniteProgrammer = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_disk,
    has_program,
    name,
    activated,
    has_extra_settings,
    extra_settings = {},
  } = data;

  if (!has_disk) {
    return (
      <Window>
        <Window.Content scrollable>
          <NoticeBox textAlign="center">
            Insert a nanite program disk
          </NoticeBox>
        </Window.Content>
      </Window>
    );
  }

  if (!has_program) {
    return (
      <Section
        title="Blank Disk"
        buttons={(
          <Button
            icon="eject"
            content="Eject"
            onClick={() => act('eject')} />
        )} />
    );
  }

  return (
    <Window>
      <Window.Content scrollable>
        <Section
          title={name}
          buttons={(
            <Button
              icon="eject"
              content="Eject"
              onClick={() => act('eject')} />
          )}>
          <NaniteInfo {...data} />
          <Section
            title="Settings"
            level={2}
            buttons={(
              <Button
                icon={activated ? 'power-off' : 'times'}
                content={activated ? 'Active' : 'Inactive'}
                selected={activated}
                color="bad"
                bold
                onClick={() => act('toggle_active')} />
            )}>
            <Grid>
              <Grid.Column>
                <NaniteCodes state={props.state} />
              </Grid.Column>
              <Grid.Column>
                <NaniteDelays state={props.state} />
              </Grid.Column>
            </Grid>
            {!!has_extra_settings && (
              <Section
                title="Special"
                level={3}>
                <LabeledList>
                  {extra_settings.map(setting => (
                    <NaniteExtraEntry
                      key={setting.name}
                      act={act}
                      extra_setting={setting} />
                  ))}
                </LabeledList>
              </Section>
            )}
          </Section>
        </Section>
      </Window.Content>
    </Window>
  );
};