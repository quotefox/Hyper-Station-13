import { useBackend } from '../backend';
import { Box, Button, Grid, NoticeBox, Section } from '../components';
import { Window } from '../layouts';
import { LaunchpadControl } from './Launchpad/LaunchpadControl';

export const LaunchpadConsole = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    launchpads = [], selected_id,
  } = data;

  if (launchpads.length <= 0) {
    return (
      <Window>
        <Window.Content>
          <NoticeBox>
            No Pads Connected
          </NoticeBox>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window>
      <Window.Content>
        <Section>
          <Grid>
            <Grid.Column size={0.6}>
              <Box
                style={{
                  'border-right': '2px solid rgba(255, 255, 255, 0.1)',
                }}
                minHeight="190px"
                mr={1}>
                {launchpads.map(launchpad => (
                  <Button
                    fluid
                    key={launchpad.name}
                    content={launchpad.name}
                    selected={selected_id === launchpad.id}
                    color="transparent"
                    onClick={() => act('select_pad', { id: launchpad.id })} />
                ))}
              </Box>
            </Grid.Column>
            <Grid.Column>
              {selected_id ? (
                <LaunchpadControl />
              ) : (
                <Box>
                  Please select a pad
                </Box>
              )}
            </Grid.Column>
          </Grid>
        </Section>
      </Window.Content>
    </Window>
  );
};
