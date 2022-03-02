import { useBackend } from '../backend';
import { Button, Section, Table } from '../components';
import { Window } from '../layouts';

export const GulagItemReclaimer = (props, context) => {
  const { act, data } = useBackend(context);
  const mobs = data.mobs || [];
  return (
    <Window>
      <Window.Content scrollable>
        <Section title="Stored Items">
          <Table>
            {mobs.map(mob => (
              <Table.Row key={mob.mob}>
                <Table.Cell>
                  {mob.name}
                </Table.Cell>
                <Table.Cell textAlign="right">
                  <Button
                    content="Retrieve Items"
                    disabled={!data.can_reclaim}
                    onClick={() => act('release_items', {
                      mobref: mob.mob,
                    })} />
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
