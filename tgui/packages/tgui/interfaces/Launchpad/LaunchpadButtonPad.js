import { useBackend } from '../../backend';
import { Button, Grid } from '../../components';


export const LaunchpadButtonPad = (props, context) => {
  const { act } = useBackend(context);

  return (
    <Grid width="1px">
      <Grid.Column>
        <Button
          fluid
          icon="arrow-left"
          iconRotation={45}
          mb={1}
          onClick={() => act('move_pos', {
            x: -1,
            y: 1,
          })} />
        <Button
          fluid
          icon="arrow-left"
          mb={1}
          onClick={() => act('move_pos', {
            x: -1,
          })} />
        <Button
          fluid
          icon="arrow-down"
          iconRotation={45}
          mb={1}
          onClick={() => act('move_pos', {
            x: -1,
            y: -1,
          })} />
      </Grid.Column>
      <Grid.Column>
        <Button
          fluid
          icon="arrow-up"
          mb={1}
          onClick={() => act('move_pos', {
            y: 1,
          })} />
        <Button
          fluid
          content="R"
          mb={1}
          onClick={() => act('set_pos', {
            x: 0,
            y: 0,
          })} />
        <Button
          fluid
          icon="arrow-down"
          mb={1}
          onClick={() => act('move_pos', {
            y: -1,
          })} />
      </Grid.Column>
      <Grid.Column>
        <Button
          fluid
          icon="arrow-up"
          iconRotation={45}
          mb={1}
          onClick={() => act('move_pos', {
            x: 1,
            y: 1,
          })} />
        <Button
          fluid
          icon="arrow-right"
          mb={1}
          onClick={() => act('move_pos', {
            x: 1,
          })} />
        <Button
          fluid
          icon="arrow-right"
          iconRotation={45}
          mb={1}
          onClick={() => act('move_pos', {
            x: 1,
            y: -1,
          })} />
      </Grid.Column>
    </Grid>
  );
};
