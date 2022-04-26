import { useBackend } from '../backend';
import { Section } from '../components';
import { Window } from '../layouts';
import { CardsPeekList } from './Cards/CardsPeekList';
import { CardStatus } from './Cards/CardStatus';

export const CardsHand = (props, context) => {
  const { data } = useBackend(context);
  const { cards } = data;

  return (
    <Window resizable>
      <Window.Content scrollable>
        <CardStatus noRotation notOrdered />
        <Section title="hand of cards">
          <CardsPeekList peeking flipIndvidualCards height={190} />
        </Section>
      </Window.Content>
    </Window>
  );
};


