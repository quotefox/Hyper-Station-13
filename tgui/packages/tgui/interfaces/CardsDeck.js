import { useBackend, useLocalState } from '../backend';
import { Box, Button, Dropdown, LabeledList, NumberInput, Section, Table, Tabs } from '../components';
import { Window } from '../layouts';

export const CardsDeck = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    face_up,
    rotation,
    cards,
    name,
    peeking,
    possible_rotations,
  } = data;

  const [tab, setTab] = useLocalState(context, 'tab', 0);
  const [drawCount, setDrawCount] = useLocalState(context, 'drawCount', 1);
  const [dealCardsCount, setDealCardsCount] = useLocalState(context, 'dealCards', 1);
  const [dealHandsCount, setDealHandsCount] = useLocalState(context, 'dealHands', 1);
  const [selectedCards, setSelectedCards] = useLocalState(context, 'selectedCards', []);
  const select_card = card => {
    if (selectedCards.includes(card)) {
      setSelectedCards(selectedCards.filter(element => element !== card));
    }
    else {
      setSelectedCards([...selectedCards, card]);
    }
  };
	
  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section title={name}>
          <Box>
            This <b>{name}</b> contains <b>{cards.length} cards</b>.	
          </Box>
          <Box>
            The deck is <b>{rotation}</b> and turned <b>{face_up ? "face-up" : "face-down"}</b>.	
          </Box>
          {!!face_up && cards.length > 0 && (
            <Box>
              You can see a <b>{cards[cards.length - 1].name}</b> on top.
            </Box>
          ) || null}
        </Section>
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
            <LabeledList>
              <LabeledList.Item label="Flip">
                <Button 
                  onClick={() => act('flip')}
                  content={face_up ? "face-up" : "face-down"} />
              </LabeledList.Item>
              <LabeledList.Item label="Rotate">
                <Dropdown
                  selected={rotation}
                  options={possible_rotations}
                  onSelected={selected => act('rotate', { angle: selected })} />
              </LabeledList.Item>
              <LabeledList.Item label="Draw">
                <NumberInput 
                  minValue={1}
                  maxValue={cards.length}
                  unit="cards"
                  value={drawCount}
                  onChange={(e, value) => setDrawCount(parseInt(value, 10) || 1)} />
                <Button
                  onClick={() => act('draw', { cards: Object.keys(cards.slice(0, drawCount)) })}
                  content="into new hand" />
              </LabeledList.Item>
              <LabeledList.Item label="Deal">
                <NumberInput 
                  minValue={1}
                  maxValue={8}
                  unit="hands"
                  value={dealHandsCount}
                  onChange={(e, value) => setDealHandsCount(parseInt(value, 10) || 1)} />
                with
                <NumberInput 
                  minValue={1}
                  maxValue={Math.ceil(cards.length/4)}
                  unit="cards"
                  value={dealCardsCount}
                  onChange={(e, value) => setDealCardsCount(parseInt(value, 10) || 1)} />
                <Button
                  onClick={() => act('deal', { count: dealCardsCount, hands: dealHandsCount })}
                  content="Deal" />
                <Box as="small" color={dealCardsCount * dealHandsCount > cards.length ? "bad" : "good"}>
                  ({dealCardsCount * dealHandsCount} cards total)
                </Box>
              </LabeledList.Item>
              <LabeledList.Item label="Shuffle">
                <Button
                  content="Shuffle deck"
                  icon="retweet"
                  onClick={() => {
                    act('shuffle');
                    act('flip', { side: "face_down" });
                    setDrawCount(1);
                    setSelectedCards([]);
                  }} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
        {tab === 1 && (
          <Section title="Peek">
            {peeking && (
              <>
                <Box style={{ "padding-bottom": "10px" }}>
                  <Button 
                    content="Draw" 
                    onClick={() => {
                      act('draw', { cards: selectedCards });
                      setSelectedCards([]);
                    }} />
                  <Button 
                    content="Select All" 
                    onClick={() => setSelectedCards(Array.from(Array(cards.length).keys()))} />
                  <Button 
                    content="Deselect All" 
                    onClick={() => setSelectedCards([])} />
                </Box>
                <Box
                  overflowY="scroll" 
                  height="calc(100vh - 270px)">
                  <Table>
                    {cards.map((card, i) => (
                      <Table.Row key={card.name}>
                        <Table.Cell color="label">
                          {i + 1}
                        </Table.Cell>
                        <Table.Cell>
                          <Button.Checkbox
                            checked={selectedCards.includes(i)}
                            onClick={() => select_card(i)} />
                        </Table.Cell>
                        <Table.Cell>
                          {card.name}
                        </Table.Cell>
                        <Table.Cell>
                          <Button
                            content="Draw 1"
                            onClick={() => act('draw', { cards: [i] })} />
                        </Table.Cell>
                      </Table.Row>
                    ))}
                  </Table>
                </Box>
              </>
            )
            || ( 
              <Box textAlign="center">
                <Button
                  onClick={() => act('peek')}
                  content="Peek in deck" />
                <Box color="average">
                  (Announces to surroundings!)
                </Box>
              </Box>
            )}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};