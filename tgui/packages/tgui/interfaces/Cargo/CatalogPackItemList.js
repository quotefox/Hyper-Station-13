import { useBackend } from '../../backend';
import { Button, LabeledList } from '../../components';

export const CatalogPackItemList = (props, context) => {
  const { supply } = props;
  const { data, act } = useBackend(context);
  const { self_paid } = data;

  const packs = supply.packs;

  return (
    <LabeledList>
      {packs.map(pack => {
        const RequestButton = (
          <Button fluid
            content={(self_paid
              ? Math.round(pack.cost * 1.1)
              : pack.cost) + ' credits'}
            tooltip={pack.desc}
            tooltipPosition="left"
            onClick={() => act('add', {
              id: pack.id,
            })} />
        );

        return (
          <LabeledList.Item
            key={pack.name}
            label={pack.name}
            buttons={RequestButton}>
            {!!pack.access && "Restrictions Apply"}
          </LabeledList.Item>
        ); 
      },
      )}
    </LabeledList>
  );
};