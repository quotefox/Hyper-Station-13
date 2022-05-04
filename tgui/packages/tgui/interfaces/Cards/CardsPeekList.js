import { useBackend, useLocalState } from '../../backend';
import { Box, Button, Dropdown, Table } from '../../components';

export const CardsPeekList = (props, context) => {
  const { data, act } = useBackend(context);
  const { cards, possible_rotations } = data;
  const { 
    peeking = false,
    drawMultiple = false,
    flipIndvidualCards = false,
    numbered = true, 
    height = 130,
  } = props;

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
    peeking && (
      <>
        <Box style={{ "padding-bottom": "10px" }}>
          <Button
            content="Draw"
            onClick={() => {
              act('draw', { cards: selectedCards });
              setSelectedCards([]);
            }}
            disabled={!drawMultiple} />
          <Button
            content="Select All"
            onClick={() => setSelectedCards(Array.from(Array(cards.length).keys()))}
            disabled={!drawMultiple} />
          <Button
            content="Deselect All"
            onClick={() => setSelectedCards([])}
            disabled={!drawMultiple} />
        </Box>
        <Box
          overflowY="scroll"
          height={"calc(100vh - " + (400 - height) + "px)"}>
          <Table>
            {cards.map((card, i) => (
              <Table.Row key={card.name}>
                {numbered && (
                  <Table.Cell color="label">
                    {i + 1}
                  </Table.Cell>
                )}
                {drawMultiple && (
                  <Table.Cell>
                    <Button.Checkbox
                      checked={selectedCards.includes(i)}
                      onClick={() => select_card(i)} />
                  </Table.Cell>
                )}
                {flipIndvidualCards && (
                  <Table.Cell>
                    <Dropdown
                      selected={card["rotation"]}
                      options={possible_rotations}
                      width={7}
                      onSelected={selected => act('rotate', { card: i, angle: selected })} />
                    <Button
                      onClick={() => act('flip', { card: i })}
                      content={card["face_up"] ? "face-up" : "face-down"} />
                  </Table.Cell>
                )}
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
    )
  );
};
