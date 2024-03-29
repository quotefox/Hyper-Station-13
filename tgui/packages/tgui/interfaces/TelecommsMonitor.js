import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { RADIO_CHANNELS } from '../constants';
import { Box, Button, LabeledList, NoticeBox, Section, Tabs, Input } from '../components';
import { NtosWindow, Window } from '../layouts';


export const TelecommsMonitor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    notice,
    network = "NULL",
    servers,
    selected = null,
    selected_servers,
  } = data;
  const operational = (selected && selected.status);
  const [tab, setTab] = useLocalState(context, 'tab', 'network_entities');

  return (
    <NtosWindow resizable>
      <NtosWindow.Content scrollable>
        {!!notice && (
          <NoticeBox>
            {notice}
          </NoticeBox>
        )}
        <Section title="Network Control">
          <LabeledList>
            <LabeledList.Item label="Network">
              <Input
                value={network}
                width="150px"
                maxLength={15}
                onChange={(e, value) => act('network', {
                  'value': value,
                })} />
            </LabeledList.Item>
            <LabeledList.Item
              label="Memory"
              buttons={(
                <Fragment>
                  <Button
                    content="Flush Buffer"
                    icon="minus-circle"
                    disabled={!servers.length || !!selected}
                    onClick={() => act('release')} />
                  <Button
                    content="Probe Network"
                    icon="sync"
                    disabled={selected}
                    onClick={() => act('probe')} />
                </Fragment>
              )}>
              {!selected ? (
                servers ? (
                  `${servers.length} currently probed and buffered`
                ) : (
                  'Buffer is empty!'
                )
              ) : (
                selected_servers ? (
                  `${selected_servers.length} currently probed and buffered`
                ) : (
                  'Connected devices is empty!'
                )
              )}
            </LabeledList.Item>
            <LabeledList.Item
              label="Selected Entity"
              buttons={(
                <Button
                  content="Disconnect"
                  icon="minus-circle"
                  disabled={!selected}
                  onClick={() => act('mainmenu')}
                />
              )}>
              {selected ? (
                `${selected.name} (${selected.id})`
              ) : (
                "None (None)"
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Tabs>
          <Tabs.Tab
            selected={tab==='network_entities'}
            onClick={() => setTab('network_entities')} >
            Network Entities
          </Tabs.Tab>
          <Tabs.Tab
            disabled={!selected}
            selected={tab==='entity_status'}
            onClick={() => setTab('entity_status')}>
            Entity Status
          </Tabs.Tab>
        </Tabs>
        {tab === 'network_entities' && (
          <Section title="Detected Network Entities">
            {(servers && servers.length) ? (
              <LabeledList>
                {servers.map(server => {
                  return (
                    <LabeledList.Item
                      key={server.name}
                      label={server.ref}
                      buttons={(
                        <Button
                          content="Connect"
                          selected={selected
                        && (server.ref === selected.ref)}
                          onClick={() => act('viewmachine', {
                            'value': server.id,
                          })} />
                      )}>
                      {`${server.name} (${server.id})`}
                    </LabeledList.Item>
                  );
                })}
              </LabeledList>
            ) : (
              '404 Servers not found. Have you tried scanning the network?'
            )}
          </Section>
        )}
        {tab === 'entity_status' && (
          <Section title="Network Entity Status">
            <LabeledList>
              <LabeledList.Item
                label="Status"
                color={operational ? 'good' : 'bad'}>
                {operational ? (
                  'Running'
                ) : (
                  'Server down!'
                )}
              </LabeledList.Item>
              <LabeledList.Item
                label="Network Traffic"
                // eslint-disable-next-line max-len
                color={operational && (selected.netspeed < selected.traffic) ? (
                  'bad'
                ) : (
                  'good'
                )}>
                {operational ? ( // Not to be confused to totaltraffic
                  selected.traffic <= 1024 ? (
                    `${Math.max(selected.traffic, 0)} Gigabytes`
                  ) : (
                    `${Math.round(selected.traffic/1024)} Terrabytes`
                  )
                ) : (
                  '0 Gigabytes'
                )}
              </LabeledList.Item>
              <LabeledList.Item label="Network Speed">
                {operational ? (
                  selected.netspeed <= 1024 ? (
                    `${selected.netspeed} Gigabytes/second`
                  ) : (
                    `${Math.round(selected.netspeed/1024)} Terrabytes/second`
                  )
                ) : (
                  '0 Gigabytes/second'
                )}
              </LabeledList.Item>
              <LabeledList.Item
                label="Multi-Z Link"
                color={(operational && selected.long_range_link) ? (
                  'good'
                ) : (
                  'bad'
                )}>
                {(operational && selected.long_range_link) ? (
                  'true'
                ) : (
                  'false'
                )}
              </LabeledList.Item>
              <FrequencyListening 
                operational={operational} 
                selected={selected} />
            </LabeledList>
            <Section
              title="Servers Linked"
              level={3}>
              {(operational && selected_servers) ? (
                <LabeledList>
                  {selected_servers.map(server => {
                    return (
                      <LabeledList.Item
                        key={server.name}
                        label={server.ref}
                        buttons={(
                          <Button
                            content="Connect"
                            onClick={() => act('viewmachine', {
                              'value': server.id,
                            })} />
                        )}>
                        {`${server.name} (${server.id})`}
                      </LabeledList.Item>
                    );
                  })}
                </LabeledList>
              ) : (
                !operational ? (
                  "Server currently down! Cannot fetch the buffer list!"
                ) : (
                  "Buffer is empty!"
                )
              )}
            </Section>
          </Section>
        )}
      </NtosWindow.Content>
    </NtosWindow>
  );
};


const FrequencyListening = (props, context) => {
  const { operational, selected } = props;

  return (
    <LabeledList.Item label="Frequency Listening">
      <Box>
        {operational && selected.freq_listening.map(thing => {
          const valid = RADIO_CHANNELS
            .find(channel => channel.freq === thing);
          return (
            (valid) ? (
              <span style={`color: ${valid.color}`}>
                {`[${thing}] (${valid.name}) `}
              </span>
            ) : (
              `[${thing}] `
            )
          );
        })}
      </Box>
    </LabeledList.Item>
  );
};