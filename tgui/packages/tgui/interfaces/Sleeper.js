import { useBackend } from '../backend';
import { Window } from '../layouts';
import { SleeperInjectChems } from './Sleeper/SleeperInjectChems';
import { SleeperOccupantStats } from './Sleeper/SleeperOccupantStats';
import { SleeperPatientReagents } from './Sleeper/SleeperPatientReagents';
import { SleeperPurgeChems } from './Sleeper/SleeperPurgeChems';
import { SleeperSynthChems } from './Sleeper/SleeperSynthChems';

export const Sleeper = (props, context) => {
  const { act, data } = useBackend(context);
  const preSortChems = data.chems || [];
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
        <SleeperPatientReagents data={data} />
        <SleeperInjectChems showOpenClosed chems={chems} data={data} act={act} />
        <SleeperSynthChems data={data} act={act} />
        <SleeperPurgeChems chems={chems} act={act} />
      </Window.Content>
    </Window>
  );
};
