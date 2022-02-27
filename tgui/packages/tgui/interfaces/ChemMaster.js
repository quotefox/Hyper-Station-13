import { Fragment } from 'inferno';
import { AnimatedNumber, Box, Button, Section } from '../components';
import { Window } from '../layouts';
import { ChemicalBuffer, ChemicalBufferEntry } from './ChemMaster/ChemicalBufferEntry';
import { AnalysisResults } from './ChemMaster/AnalysisResults';
import { PackagingControls } from './ChemMaster/PackagingControls';
import { useBackend } from '../backend';

export const ChemMaster = (props, context) => {
  const { config, data, act } = useBackend(context);
  const { ref } = config;
  const {
    screen,
    beakerContents = [],
    bufferContents = [],
    beakerCurrentVolume,
    beakerMaxVolume,
    isBeakerLoaded,
    isPillBottleLoaded,
    pillBottleCurrentAmount,
    pillBottleMaxAmount,
  } = data;
  if (screen === "analyze") {
    return <AnalysisResults props={props} context={context} />;
  }
  return (
    <Window>
      <Window.Content>
        <Section
          title="Beaker"
          buttons={!!data.isBeakerLoaded && (
            <Fragment>
              <Box inline color="label" mr={2}>
                <AnimatedNumber
                  value={beakerCurrentVolume}
                  initial={0} />
                {` / ${beakerMaxVolume} units`}
              </Box>
              <Button
                icon="eject"
                content="Eject"
                onClick={() => act(ref, 'eject')} />
            </Fragment>
          )}>
          {!isBeakerLoaded && (
            <Box color="label" mt="3px" mb="5px">
              No beaker loaded.
            </Box>
          )}
          {!!isBeakerLoaded && beakerContents.length === 0 && (
            <Box color="label" mt="3px" mb="5px">
              Beaker is empty.
            </Box>
          )}
          <ChemicalBuffer>
            {beakerContents.map(chemical => (
              <ChemicalBufferEntry
                key={chemical.id}
                chemical={chemical}
                transferTo="buffer" />
            ))}
          </ChemicalBuffer>
        </Section>
        <Section
          title="Buffer"
          buttons={(
            <Fragment>
              <Box inline color="label" mr={1}>
                Mode:
              </Box>
              <Button
                color={data.mode ? 'good' : 'bad'}
                icon={data.mode ? 'exchange-alt' : 'times'}
                content={data.mode ? 'Transfer' : 'Destroy'}
                onClick={() => act(ref, 'toggleMode')} />
            </Fragment>
          )}>
          {bufferContents.length === 0 && (
            <Box color="label" mt="3px" mb="5px">
              Buffer is empty.
            </Box>
          )}
          <ChemicalBuffer>
            {bufferContents.map(chemical => (
              <ChemicalBufferEntry
                key={chemical.id}
                chemical={chemical}
                transferTo="beaker" />
            ))}
          </ChemicalBuffer>
        </Section>
        <Section
          title="Packaging">
          <PackagingControls />
        </Section>
        {!!isPillBottleLoaded && (
          <Section
            title="Pill Bottle"
            buttons={(
              <Fragment>
                <Box inline color="label" mr={2}>
                  {pillBottleCurrentAmount} / {pillBottleMaxAmount} pills
                </Box>
                <Button
                  icon="eject"
                  content="Eject"
                  onClick={() => act(ref, 'ejectPillBottle')} />
              </Fragment>
            )} />
        )}
      </Window.Content>
    </Window>
  );
};