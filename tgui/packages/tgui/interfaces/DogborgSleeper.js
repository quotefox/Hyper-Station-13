import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';
import { SleeperInjectChems } from './Sleeper/SleeperInjectChems';
import { SleeperOccupantStats } from './Sleeper/SleeperOccupantStats';
import { SleeperPatientReagents } from './Sleeper/SleeperPatientReagents';

export const DogborgSleeper = (props, context) => {
  const { data, act } = useBackend(context);
  const preSortChems = data.chem || [];
  const chems = preSortChems.sort((a, b) => {
    const descA = a.name.toLowerCase();
    const descB = b.name.toLowerCase();
    if (descA < descB) {
      return -1;
    }
    if (descA > descB) {
      return 1;
    }
    return 0;
  });

  return (
    <Window>
      <Window.Content scrollable>
        <SleeperOccupantStats data={data} />
        {data.cleaning && data.items && (
          <NoticeBox>
            {data.items}
          </NoticeBox>
        ) || null}
        <SleeperPatientReagents data={data} />
        {chems.length > 0 && <SleeperInjectChems chems={chems} data={data} act={act} />}
        <DogborgControls data={data} act={act} />
      </Window.Content>
    </Window>
  );
};

const DogborgControls = (props, context) => { 
  const { data, act } = props;
  const { occupant, cleaning } = data;

  return (
    <Section title="Operations">
      <Box>
        <Button 
          icon="sign-out-alt"
          disabled={!occupant}
          onClick={() => act('eject')}>
          Eject Contents
        </Button>
      </Box>
      <Box>
        <Button 
          icon="recycle"
          onClick={() => act('cleaning')}>
          Activate Self-Cleaning Cycle
        </Button>
      </Box>
    </Section>
  );
};