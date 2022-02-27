import { act } from '../../byond';
import { AnimatedNumber, Button, Table } from '../../components';

export const ChemicalBufferEntry = (props, context) => {
  const { state, chemical, transferTo } = props;
  const { ref } = state.config;
  return (
    <Table.Row key={chemical.id}>
      <Table.Cell color="label">
        <AnimatedNumber
          value={chemical.volume}
          initial={0} />
        {` units of ${chemical.name}`}
      </Table.Cell>
      <Table.Cell collapsing>
        <Button
          content="1"
          onClick={() => act(ref, 'transfer', {
            id: chemical.id,
            amount: 1,
            to: transferTo,
          })} />
        <Button
          content="5"
          onClick={() => act(ref, 'transfer', {
            id: chemical.id,
            amount: 5,
            to: transferTo,
          })} />
        <Button
          content="10"
          onClick={() => act(ref, 'transfer', {
            id: chemical.id,
            amount: 10,
            to: transferTo,
          })} />
        <Button
          content="All"
          onClick={() => act(ref, 'transfer', {
            id: chemical.id,
            amount: 1000,
            to: transferTo,
          })} />
        <Button
          icon="ellipsis-h"
          title="Custom amount"
          onClick={() => act(ref, 'transfer', {
            id: chemical.id,
            amount: -1,
            to: transferTo,
          })} />
        <Button
          icon="question"
          title="Analyze"
          onClick={() => act(ref, 'analyze', {
            id: chemical.id,
          })} />
      </Table.Cell>
    </Table.Row>
  );
};
export const ChemicalBuffer = Table;
