import { map } from 'common/collections';
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { Button, Flex, LabeledList, NoticeBox, Section, Table, Tabs } from '../components';
import { Window } from '../layouts';

export const NaniteProgramHub = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    detail_view,
    disk,
    has_disk,
    has_program,
    programs = {},
  } = data;

  const [activeCategoryKey, setActiveCategoryKey] 
    = useLocalState(context, 'category', 
      programs !== null ? Object.keys(programs)[0] : null);
  
  const activeCategory = programs !== null ? programs[activeCategoryKey] : null;

  return (
    <Window>
      <Window.Content scrollable>
        <Section
          title="Program Disk"
          buttons={(
            <Fragment>
              <Button
                icon="eject"
                content="Eject"
                onClick={() => act('eject')} />
              <Button
                icon="minus-circle"
                content="Delete Program"
                onClick={() => act('clear')} />
            </Fragment>
          )}>
          {has_disk ? (
            has_program ? (
              <LabeledList>
                <LabeledList.Item label="Program Name">
                  {disk.name}
                </LabeledList.Item>
                <LabeledList.Item label="Description">
                  {disk.desc}
                </LabeledList.Item>
              </LabeledList>
            ) : (
              <NoticeBox>
                No Program Installed
              </NoticeBox>
            )
          ) : (
            <NoticeBox>
              Insert Disk
            </NoticeBox>
          )}
        </Section>
        <Section
          title="Programs"
          buttons={(
            <Fragment>
              <Button
                icon={detail_view ? 'info' : 'list'}
                content={detail_view ? 'Detailed' : 'Compact'}
                onClick={() => act('toggle_details')} />
              <Button
                icon="sync"
                content="Sync Research"
                onClick={() => {
                  act('refresh');
                  (programs !== null && activeCategoryKey === null 
                    && setActiveCategoryKey(Object.keys(programs)[0]));
                }} />
            </Fragment>
          )}>
          {programs !== null ? (
            <Flex direction="row">
              <Flex.Item>
                <Tabs vertical>
                  {map((cat_contents, category) => {
                    const progs = cat_contents || [];
                    const tabLabel = category.substring(0, category.length - 8);
                    return (
                      <Tabs.Tab
                        key={category}
                        selected={activeCategoryKey===category}
                        onClick={() => setActiveCategoryKey(category)}>
                        {tabLabel}
                      </Tabs.Tab>
                    );
                  })(programs)}
                </Tabs>
              </Flex.Item>
              <Flex.Item grow={1} basis={0}>
                {detail_view ? (
                  activeCategory.map(program => (
                    <Section
                      key={program.id}
                      title={program.name}
                      level={2}
                      buttons={(
                        <Button
                          icon="download"
                          content="Download"
                          disabled={!has_disk}
                          onClick={() => act('download', {
                            program_id: program.id,
                          })} />
                      )}>
                      {program.desc}
                    </Section>
                  ))
                ) : (
                  <LabeledList>
                    {activeCategory.map(program => (
                      <LabeledList.Item
                        key={program.id}
                        label={program.name}
                        buttons={(
                          <Button
                            icon="download"
                            content="Download"
                            disabled={!has_disk}
                            onClick={() => act('download', {
                              program_id: program.id,
                            })} />
                        )} />
                    ))}
                  </LabeledList>
                )}
              </Flex.Item>
            </Flex>
          ) : (
            <NoticeBox>
              No nanite programs are currently researched.
            </NoticeBox>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};