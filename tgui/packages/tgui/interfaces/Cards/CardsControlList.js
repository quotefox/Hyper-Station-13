import { useBackend, useLocalState } from '../../backend';
import { Box, Button, Dropdown, LabeledList, NumberInput } from '../../components';

export const CardsControlList = (props, context) => {
  const { data, act } = useBackend(context);
  const { face_up, rotation, cards, possible_rotations } = data;
  const { flip, rotate, draw, deal, shuffle } = props;

  const [drawCount, setDrawCount] = useLocalState(context, 'drawCount', 1);
  const [dealCardsCount, setDealCardsCount] = useLocalState(context, 'dealCards', 1);
  const [dealHandsCount, setDealHandsCount] = useLocalState(context, 'dealHands', 1);
  const [selectedCards, setSelectedCards] = useLocalState(context, 'selectedCards', []);

  return (
    <LabeledList>
      {!!flip && (
        <LabeledList.Item label="Flip">
          <Button
            onClick={() => act('flip')}
            content={face_up ? "face-up" : "face-down"} />
        </LabeledList.Item>
      )}
      {!!rotate && (
        <LabeledList.Item label="Rotate">
          <Dropdown
            selected={rotation}
            options={possible_rotations}
            onSelected={selected => act('rotate', { angle: selected })} />
        </LabeledList.Item>
      )}
      {!!draw && (
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
      )}
      {!!deal && (
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
            maxValue={Math.ceil(cards.length / 4)}
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
      )}
      {!!shuffle && (
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
      )}
    </LabeledList>
  );
};
