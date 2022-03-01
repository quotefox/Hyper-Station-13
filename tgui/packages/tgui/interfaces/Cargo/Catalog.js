import { useSharedState } from '../../backend';
import { Flex, Tabs } from '../../components';
import { CatalogPackItemList } from './CatalogPackItemList';

export const Catalog = (props, context) => {
  const { supplies } = props;

  const [activeSupplyName, setActiveSupplyName] 
    = useSharedState(context, 'supply', supplies[0]?.name);

  const activeSupply = supplies.find(supply => {
    return supply.name === activeSupplyName;
  });

  return (
    <Flex direction="row">
      <Flex.Item>
        <Tabs vertical>
          {supplies.map(supply => {
            const name = supply.name;
            return (
              <Tabs.Tab 
                key={name}
                selected={activeSupplyName === name}
                onClick={() => setActiveSupplyName(name)}>
                {name}
              </Tabs.Tab>
            );
          })}
        </Tabs>
      </Flex.Item>
      <Flex.Item grow={1} basis={0}>
        <CatalogPackItemList supply={activeSupply} />
      </Flex.Item>
    </Flex>
  );
};