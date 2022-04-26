import { useBackend, useLocalState } from '../backend';
import { Section, Tabs } from '../components';
import { Window } from '../layouts';
import { CardStatus } from './Cards/CardStatus';
import { CardsControlList } from './Cards/CardsControlList';
import { CardsPeekList } from './Cards/CardsPeekList';

export const CardsDeck = (props, context) => {
  const [tab, setTab] = useLocalState(context, 'tab', 0);
  const { data } = useBackend(context);
  const { peeking } = data;
	
  return (
    <Window resizable>
      <Window.Content scrollable>
        <CardStatus />
        <Tabs>
          <Tabs.Tab
            selected={tab === 0}
            onClick={() => setTab(0)}>
            Controls
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 1}
            onClick={() => setTab(1)}>
            Peek
          </Tabs.Tab>
        </Tabs>
        {tab === 0 && (
          <Section title="Controls">
            <CardsControlList flip rotate draw deal shuffle />
          </Section>
        )}
        {tab === 1 && (
          <Section title="Peek">
            <CardsPeekList peeking={!!peeking} drawMultiple numbered />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};


