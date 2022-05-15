import { useBackend } from '../../backend';
import { Box, Section } from '../../components';

export const CardStatus = (props, context) => {
  const { data } = useBackend(context);
  const { face_up, rotation, cards, name } = data;
  const { noRotation = false, notOrdered = false, children } = props;

  return (
    <Section title={name}>
      <Box>
        This <b>{name}</b> contains <b>{cards.length} cards</b>.
      </Box>
      {!noRotation && (
        <Box>
          The deck is <b>{rotation}</b> and turned <b>{face_up ? "face-up" : "face-down"}</b>.
        </Box>
      )}
      {!notOrdered & !!face_up && cards.length > 0 && (
        <Box>
          You can see a <b>{cards[cards.length - 1].name}</b> on top.
        </Box>
      ) || null}
      {...children}
    </Section>
  );
};
