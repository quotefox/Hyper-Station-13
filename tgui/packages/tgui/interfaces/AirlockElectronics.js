import { useBackend, useLocalState } from '../backend';
import { Box, Button, Flex, LabeledList, Section, Tabs } from '../components';
import { Window } from '../layouts';

export const AirlockElectronics = (props, context) => {
  const { act, data } = useBackend(context);
  const regions = data.regions || [];

  const [tab, setTab] = useLocalState(context, 'tab', regions[0].name);
  const activeRegion = regions.find(region => {
    return region.name === tab;
  });

  const diffMap = {
    0: {
      icon: 'times-circle',
    },
    1: {
      icon: 'stop-circle',
    },
    2: {
      icon: 'check-circle',
    },
  };

  const checkAccessIcon = accesses => {
    let oneAccess = false;
    let oneInaccess = false;

    accesses.forEach(element => {
      if (element.req) {
        oneAccess = true;
      }
      else {
        oneInaccess = true;
      }
    });

    if (!oneAccess && oneInaccess) {
      return 0;
    }
    else if (oneAccess && oneInaccess) {
      return 1;
    }
    else {
      return 2;
    }
  };

  return (
    <Window resizable>
      <Window.Content>
        <Section title="Main">
          <LabeledList>
            <LabeledList.Item
              label="Access Required">
              <Button
                icon={data.oneAccess ? 'unlock' : 'lock'}
                content={data.oneAccess ? 'One' : 'All'}
                onClick={() => act('one_access')}
              />
            </LabeledList.Item>
            <LabeledList.Item
              label="Mass Modify">
              <Button
                icon="check-double"
                content="Grant All"
                onClick={() => act('grant_all')}
              />
              <Button
                icon="undo"
                content="Clear All"
                onClick={() => act('clear_all')}
              />
            </LabeledList.Item>
            <LabeledList.Item
              label="Unrestricted Access">
              <Button
                icon={data.unres_direction & 1 ? 'check-square-o' : 'square-o'}
                content="North"
                selected={data.unres_direction & 1}
                onClick={() => act('direc_set', {
                  unres_direction: '1',
                })}
              />
              <Button
                icon={data.unres_direction & 2 ? 'check-square-o' : 'square-o'}
                content="East"
                selected={data.unres_direction & 2}
                onClick={() => act('direc_set', {
                  unres_direction: '2',
                })}
              />
              <Button
                icon={data.unres_direction & 4 ? 'check-square-o' : 'square-o'}
                content="South"
                selected={data.unres_direction & 4}
                onClick={() => act('direc_set', {
                  unres_direction: '4',
                })}
              />
              <Button
                icon={data.unres_direction & 8 ? 'check-square-o' : 'square-o'}
                content="West"
                selected={data.unres_direction & 8}
                onClick={() => act('direc_set', {
                  unres_direction: '8',
                })}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Access">
          <Flex direction="row">
            <Flex.Item>
              <Tabs vertical>
                {regions.map(region => {
                  const { name } = region;
                  const accesses = region.accesses || [];
                  const icon = diffMap[checkAccessIcon(accesses)].icon;
                  return (
                    <Tabs.Tab
                      key={name}
                      icon={icon}
                      selected={tab===name}
                      onClick={() => setTab(name)}>
                      {name}
                    </Tabs.Tab>
                  );
                })}
              </Tabs>
            </Flex.Item>
            <Flex.Item grow={1} basis={0}>
              {activeRegion.accesses.map(access => (
                <Box key={access.id}>
                  <Button
                    icon={access.req ? 'check-square-o' : 'square-o'}
                    content={access.name}
                    selected={access.req}
                    onClick={() => act('set', {
                      access: access.id,
                    })} />
                </Box>
              ))}
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
