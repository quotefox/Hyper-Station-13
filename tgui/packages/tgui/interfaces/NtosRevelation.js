import { Section, Button, LabeledList } from '../components';
import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

export const NtosRevelation = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <NtosWindow
      width={400}
      height={250}
      theme="syndicate">
      <NtosWindow.Content>
        <Section>
          <Button.Input
            fluid
            content="Obfuscate Name..."
            onCommit={(e, value) => act('PRG_obfuscate', {
              new_name: value,
            })}
            mb={1} />
          <LabeledList>
            <LabeledList.Item
              label="Payload Status"
              buttons={(
                <Button
                  content={data.armed ? 'ARMED' : 'DISARMED'}
                  color={data.armed ? 'bad' : 'average'}
                  onClick={() => act('PRG_arm')} />
              )} />
          </LabeledList>
          <Button
            fluid
            bold
            icon="radiation"
            content="ACTIVATE"
            textAlign="center"
            color="bad"
            disabled={!data.armed}
            onClick={() => act('PRG_activate')} />
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
