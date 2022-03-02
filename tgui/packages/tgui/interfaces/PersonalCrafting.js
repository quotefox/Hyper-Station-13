import { map } from 'common/collections';
import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Box, Button, Dimmer, Flex, Icon, LabeledList, Section, Tabs } from '../components';
import { Window } from '../layouts';


export const PersonalCrafting = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    busy,
    display_craftable_only,
    display_compact,
    category,
    subcategory,
  } = data;

  const craftingRecipes = map((subcategory, category) => {
    const hasSubcats = ('has_subcats' in subcategory);
    const firstSubcatName = Object.keys(subcategory)
      .find(name => name !== 'has_subcats');
    return {
      category,
      subcategory,
      hasSubcats,
      firstSubcatName,
    };
  })(data.crafting_recipes || {});
  
  const currentCategory = craftingRecipes.find(recipeTab => {
    return recipeTab.category === category;
  });

  // Shows an overlay when crafting an item
  const busyBox = !!busy && (
    <Dimmer
      fontSize="40px"
      textAlign="center">
      <Box mt={30}>
        <Icon name="cog" spin={1} />
        {' Crafting...'}
      </Box>
    </Dimmer>
  );

  return (
    <Window>
      <Window.Content>
        {busyBox}
        <Section
          title="Personal Crafting"
          buttons={(
            <Fragment>
              <Button
                icon={display_compact ? "check-square-o" : "square-o"}
                content="Compact"
                selected={display_compact}
                onClick={() => act('toggle_compact')} />
              <Button
                icon={display_craftable_only ? "check-square-o" : "square-o"}
                content="Craftable Only"
                selected={display_craftable_only}
                onClick={() => act('toggle_recipes')} />
            </Fragment>
          )}>
          <Tabs>
            {craftingRecipes.map(recipeTab => (
              <Tabs.Tab
                key={recipeTab.category}
                onClick={() => act('set_category', {
                  category: recipeTab.category,
                  subcategory: recipeTab.firstSubcatName,
                  // Backend expects "0" or "" to indicate no subcategory
                })}
                selected={category===recipeTab.category}>
                {recipeTab.category}
              </Tabs.Tab>
            ))}
          </Tabs>
          {!currentCategory.hasSubcats && (
            <CraftingList craftables={currentCategory.subcategory} />
          ) 
          || (
            <Flex direction="row">
              <Flex.Item>
                <Tabs vertical>
                  {map((_, subcatName) => (subcatName !== 'has_subcats' && ( 
                    <Tabs.Tab
                      key={subcatName}
                      onClick={() => act('set_category', {
                        subcategory: subcatName,
                      })}
                      selected={subcategory===subcatName}>
                      {subcatName}
                    </Tabs.Tab>
                  )
                  ))(currentCategory.subcategory)}
                  {/* {JSON.stringify(currentCategory.subcategory, null, 2)} */}
                </Tabs>
              </Flex.Item>
              <Flex.Item grow={1} basis={0}>
                <CraftingList craftables={currentCategory.subcategory[subcategory]} />
              </Flex.Item>
            </Flex>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};


const CraftingList = (props, context) => {
  const {
    craftables = [],
  } = props;
  const { act, data } = useBackend(context);
  const {
    craftability = {},
    display_compact,
    display_craftable_only,
  } = data;
  
  return craftables.map(craftable => {
    if (display_craftable_only && !craftability[craftable.ref]) {
      return null;
    }
    // Compact display
    if (display_compact) {
      return (
        <LabeledList.Item
          key={craftable.name}
          label={craftable.name}
          className="candystripe"
          buttons={(
            <Button
              icon="cog"
              content="Craft"
              disabled={!craftability[craftable.ref]}
              tooltip={craftable.tool_text && (
                'Tools needed: ' + craftable.tool_text
              )}
              tooltipPosition="left"
              onClick={() => act('make', {
                recipe: craftable.ref,
              })} />
          )}>
          {craftable.req_text}
        </LabeledList.Item>
      );
    }
    // Full display
    return (
      <Section
        key={craftable.name}
        title={craftable.name}
        level={2}
        buttons={(
          <Button
            icon="cog"
            content="Craft"
            disabled={!craftability[craftable.ref]}
            onClick={() => act('make', {
              recipe: craftable.ref,
            })} />
        )}>
        <LabeledList>
          {!!craftable.req_text && (
            <LabeledList.Item label="Required">
              {craftable.req_text}
            </LabeledList.Item>
          )}
          {!!craftable.catalyst_text && (
            <LabeledList.Item label="Catalyst">
              {craftable.catalyst_text}
            </LabeledList.Item>
          )}
          {!!craftable.tool_text && (
            <LabeledList.Item label="Tools">
              {craftable.tool_text}
            </LabeledList.Item>
          )}
        </LabeledList>
      </Section>
    );
  });
};