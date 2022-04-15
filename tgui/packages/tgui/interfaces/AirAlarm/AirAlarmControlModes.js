import { Fragment } from 'inferno';
import { useBackend } from '../../backend';
import { Box, Button } from '../../components';

//  Modes
// --------------------------------------------------------
export const AirAlarmControlModes = (props, context) => {
  const { act, data } = useBackend(context);
  const { modes } = data;
  if (!modes || modes.length === 0) {
    return 'Nothing to show';
  }
  return modes.map(mode => (
    <Fragment key={mode.mode}>
      <Button
        icon={mode.selected ? 'check-square-o' : 'square-o'}
        selected={mode.selected}
        color={mode.selected && mode.danger && 'danger'}
        content={mode.name}
        onClick={() => act('mode', { mode: mode.mode })} />
      <Box mt={1} />
    </Fragment>
  ));
};
