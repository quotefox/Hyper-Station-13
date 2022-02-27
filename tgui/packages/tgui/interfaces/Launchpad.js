import { useBackend } from '../backend';
import { Button, Grid, Input, Section } from '../components';
import { Window } from '../layouts';
import { LaunchpadButtonPad } from './Launchpad/LaunchpadButtonPad';
import { LaunchTarget } from './Launchpad/LaunchTarget';

export const LaunchpadControl = (props, context) => {
  const { topLevel } = props;
  const { act, data } = useBackend(context);

  const { pad_name } = data;

  return (
    <Window>
      <Window.Content>
        <Section
          title={(
            <Input
              value={pad_name}
              width="170px"
              onChange={(e, value) => act('rename', {
                name: value,
              })}
            />
          )}
          level={topLevel ? 1 : 2}
          buttons={(
            <Button
              icon="times"
              content="Remove"
              color="bad"
              onClick={() => act('remove')} />
          )}>
          <Grid>
            <Grid.Column>
              <Section title="Controls" level={2}>
                <LaunchpadButtonPad state={props.state} />
              </Section>
            </Grid.Column>
            <Grid.Column>
              <LaunchTarget data={data} act={act} />
            </Grid.Column>
          </Grid>
          <Grid>
            <Grid.Column>
              <Button
                fluid
                icon="upload"
                content="Launch"
                textAlign="center"
                onClick={() => act('launch')} />
            </Grid.Column>
            <Grid.Column>
              <Button
                fluid
                icon="download"
                content="Pull"
                textAlign="center"
                onClick={() => act('pull')} />
            </Grid.Column>
          </Grid>
        </Section>
      </Window.Content>
    </Window>
  );
};

