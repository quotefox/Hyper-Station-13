import { useBackend } from '../backend';
import { Fragment } from 'inferno';
import { Section, Button } from '../components';
import { getGasLabel } from '../constants';
import { PortableBasicInfo } from './PortableBasicInfo';
import { Window } from '../layouts';


export const PortableScrubber = (props, context) => {
  const { act, data } = useBackend(context);

  const filter_types = data.filter_types || [];

  return (
    <Window resizable>
      <Window.Content>
        <PortableBasicInfo state={props.state} />
        <Section title="Filters">
          {filter_types.map(filter => (
            <Button
              key={filter.id}
              icon={filter.enabled ? 'check-square-o' : 'square-o'}
              content={getGasLabel(filter.gas_id, filter.gas_name)}
              selected={filter.enabled}
              onClick={() => act('toggle_filter', {
                val: filter.gas_id,
              })} />
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
