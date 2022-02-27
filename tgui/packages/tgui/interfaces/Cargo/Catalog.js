import { map } from 'common/collections';
import { Fragment } from 'inferno';
import { useBackend } from '../../backend';
import { Button, Tabs } from '../../components';

export const Catalog = (props, context) => {
  const { supplies } = props;
  const { config, data, act } = useBackend(context);
  const { ref } = config;
  const renderTab = key => {
    const supply = supplies[key];
    const packs = supply.packs;
    return (
      <table className="LabeledList">
        {packs.map(pack => (
          <tr
            key={pack.name}
            className="LabeledList__row candystripe">
            <td className="LabeledList__cell LabeledList__label">
              {pack.name}:
            </td>
            <td className="LabeledList__cell">
              {!!pack.small_item && (
                <Fragment>Small Item</Fragment>
              )}
            </td>
            <td className="LabeledList__cell">
              {!!pack.access && (
                <Fragment>Restrictions Apply</Fragment>
              )}
            </td>
            <td className="LabeledList__cell LabeledList__buttons">
              <Button fluid
                content={(data.self_paid
                  ? Math.round(pack.cost * 1.1)
                  : pack.cost) + ' credits'}
                tooltip={pack.desc}
                tooltipPosition="left"
                onClick={() => act(ref, 'add', {
                  id: pack.id,
                })} />
            </td>
          </tr>
        ))}
      </table>
    );
  };
  return (
    <Tabs vertical>
      {map(supply => {
        const name = supply.name;
        return (
          <Tabs.Tab key={name} label={name}>
            {renderTab}
          </Tabs.Tab>
        );
      })(supplies)}
    </Tabs>
  );
};
