import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';


export const SlimeBodySwapper = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    bodies = [],
  } = data;

  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section>
          {bodies.map(body => (
            <BodyEntry
              key={body.name}
              body={body}
              swapFunc={() => act('swap', { ref: body.ref })} />
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};


export const BodyEntry = (props, context) => {
  const { body, swapFunc } = props;

  const statusMap = {
    Dead: "bad",
    Unconscious: "average",
    Conscious: "good",
  };

  const occupiedMap = {
    owner: "You Are Here",
    stranger: "Occupied",
    available: "Swap",
  };

  return (
    <Section
      title={(
        <Box inline color={body.htmlcolor}>
          {body.name}
        </Box>
      )}
      level={2}
      buttons={(
        <Button
          content={occupiedMap[body.occupied]}
          selected={body.occupied === 'owner'}
          color={(body.occupied === 'stranger') && 'bad'}
          onClick={() => swapFunc()}
        />
      )}>
      <LabeledList>
        <LabeledList.Item
          label="Status"
          bold
          color={statusMap[body.status]}>
          {body.status}
        </LabeledList.Item>
        <LabeledList.Item label="Jelly">
          {body.exoticblood}
        </LabeledList.Item>
        <LabeledList.Item label="Location">
          {body.area}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};