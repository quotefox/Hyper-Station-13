import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, ProgressBar, Section, Table } from '../components';
import { NtosWindow } from '../layouts';

export const NtosAiRestorer = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    restoring,
    error,
    name,
    nocard,
    isDead,
    health,
    no_ai,
    ai_laws = [],
  } = data;

  return (
    <NtosWindow>
      <NtosWindow.Content scrollable>
        <Section title="Insert AI">
          <Box>
            Inserted AI:
          </Box>
          <Button
            icon="eject"
            content={nocard ? "---" : name}
            onClick={() => act('PRG_eject')}
            disabled={nocard} />
        </Section>
        {!!restoring && (
          <NoticeBox>
            Reconstruction in progress!
          </NoticeBox>
        )}
        {!!error && (
          <NoticeBox>
            ERROR: {error}
          </NoticeBox>
        ) || (
          <Section title="System Status">
            <LabeledList>
              <LabeledList.Item
                label="AI Name">
                {name}    
              </LabeledList.Item>
              <LabeledList.Item
                label="Status">
                {isDead ? "Non-functional" : "Functional"}
              </LabeledList.Item>
              <LabeledList.Item
                label="System Integrity">
                <ProgressBar
                  minValue={0}
                  maxValue={100}
                  value={health}
                  ranges={{
                    good: [70, Infinity],
                    average: [50, 70],
                    bad: [-Infinity, 50],
                  }} />
              </LabeledList.Item>
              <LabeledList.Item
                label="Active Laws" />
              {ai_laws.length > 0 && (ai_laws.map((law, index) => (
                <LabeledList.Item className="candystripe" key={'law_' + index.toString()}>
                  {law}
                </LabeledList.Item> 
              ))
              ) || (
                <LabeledList.Item>
                  <NoticeBox danger>
                    No laws found.
                  </NoticeBox>
                </LabeledList.Item>
              )}
              <LabeledList.Item
                label="Operations">
                <Button 
                  icon="plus"
                  disabled={restoring}
                  onClick={() => act('PRG_beginReconstruction')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </NtosWindow.Content>
    </NtosWindow>
  );
};