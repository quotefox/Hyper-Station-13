import { useBackend } from '../backend';
import { Fragment } from 'inferno';
import { Section, Button } from '../components';
import { getGasLabel } from '../constants';
import { PortableBasicInfo } from './PortableBasicInfo';


export const PortableScrubber = props => {
  const { act, data } = useBackend(props);

  const filter_types = data.filter_types || [];

  return (
    <Fragment>
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
    </Fragment>
  );
};
