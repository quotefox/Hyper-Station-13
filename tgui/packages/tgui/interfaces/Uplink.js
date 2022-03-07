import { decodeHtmlEntities } from 'common/string';
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Flex, Input, Section, Tabs } from '../components';
import { Window } from '../layouts';

export const Uplink = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    compact_mode,
    lockable,
    telecrystals,
    categories = [],
  } = data;

  const [hoveredItem, setHoveredItem] = useLocalState(context, 'hover', {});
  const [searchText, setSearchText] = useLocalState(context, 'search', '');
  const [activeCategory, setActiveCategory] = useLocalState(context, 'category', 0);
  
  return (
    <Window theme="syndicate">
      <Window.Content scrollable>
        <Section
          title={(
            <Box
              inline
              color={telecrystals > 0 ? 'good' : 'bad'}>
              {telecrystals} TC
            </Box>
          )}
          buttons={(
            <Fragment>
              Search
              <Input
                value={searchText}
                onInput={(e, value) => setSearchText(value)}
                ml={1}
                mr={1} />
              <Button
                icon={compact_mode ? 'list' : 'info'}
                content={compact_mode ? 'Compact' : 'Detailed'}
                onClick={() => act('compact_toggle')} />
              {!!lockable && (
                <Button
                  icon="lock"
                  content="Lock"
                  onClick={() => act('lock')} />
              )}
            </Fragment>
          )}>
          {searchText.length > 0 ? (
            <table className="Table">
              <ItemList
                compact
                items={categories
                  .flatMap(category => {
                    return category.items || [];
                  })
                  .filter(item => {
                    const searchTerm = searchText.toLowerCase();
                    const searchableString = String(item.name + item.desc)
                      .toLowerCase();
                    return searchableString.includes(searchTerm);
                  })}
                hoveredItem={hoveredItem}
                onBuyMouseOver={item => setHoveredItem(item)}
                onBuyMouseOut={item => setHoveredItem({})}
                onBuy={item => act('buy', {
                  item: item.name,
                })} />
            </table>
          ) : (
            <Flex>
              <Flex.Item>
                <Tabs vertical>
                  {categories.map((category, index) => {
                    const { name, items } = category;
                    if (items === null) {
                      return;
                    }
                    return (
                      <Tabs.Tab
                        key={name}
                        selected={activeCategory===index}
                        onClick={() => setActiveCategory(index)}>
                        {name} ({items.length})
                      </Tabs.Tab>
                    );
                  })}
                </Tabs>
              </Flex.Item>
              <Flex.Item grow={1}>
                <UplinkItemCatalog activeCategory={activeCategory} />
              </Flex.Item>
            </Flex>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};


const UplinkItemCatalog = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    compact_mode,
    telecrystals,
    categories = [],
  } = data;
  
  const {
    activeCategory,
  } = props;

  const [hoveredItem, setHoveredItem] = useLocalState(context, 'hover', {});
  const { items } = categories[activeCategory];

  return (
    <ItemList
      compact={compact_mode}
      items={items}
      hoveredItem={hoveredItem}
      telecrystals={telecrystals}
      onBuyMouseOver={item => setHoveredItem(item)}
      onBuyMouseOut={item => setHoveredItem({})}
      onBuy={item => act('buy', {
        item: item.name,
      })} />
  );
};


const ItemList = (props, context) => {
  const {
    items,
    hoveredItem,
    telecrystals,
    compact,
    onBuy,
    onBuyMouseOver,
    onBuyMouseOut,
  } = props;
  const hoveredCost = hoveredItem && hoveredItem.cost || 0;

  if (compact) {
    return (
      <Flex direction="column">
        {items.map(item => {
          const notSameItem = hoveredItem && hoveredItem.name !== item.name;
          const notEnoughHovered = telecrystals - hoveredCost < item.cost;
          const disabledDueToHovered = notSameItem && notEnoughHovered;
          return (
            <Flex.Item
              key={item.name}
              className="candystripe">
              <Flex direction="row">
                <Flex.Item bold>
                  {decodeHtmlEntities(item.name)}
                </Flex.Item>
                <Flex.Item shrink={1} textAlign="right">
                  <Button
                    fluid
                    content={item.cost + " TC"}
                    disabled={telecrystals < item.cost || disabledDueToHovered}
                    tooltip={item.desc}
                    tooltipPosition="left"
                    onmouseover={() => onBuyMouseOver(item)}
                    onmouseout={() => onBuyMouseOut(item)}
                    onClick={() => onBuy(item)} />
                </Flex.Item>
              </Flex>
            </Flex.Item>
          );
        })}
      </Flex>
    );
  }

  return items.map(item => {
    const notSameItem = hoveredItem && hoveredItem.name !== item.name;
    const notEnoughHovered = telecrystals - hoveredCost < item.cost;
    const disabledDueToHovered = notSameItem && notEnoughHovered;
    return (
      <Section
        key={item.name}
        title={item.name}
        level={2}
        buttons={(
          <Button
            content={item.cost + ' TC'}
            disabled={telecrystals < item.cost || disabledDueToHovered}
            onmouseover={() => onBuyMouseOver(item)}
            onmouseout={() => onBuyMouseOut(item)}
            onClick={() => onBuy(item)} />
        )}>
        {decodeHtmlEntities(item.desc)}
      </Section>
    );
  });
};
