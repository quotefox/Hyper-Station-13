import { useBackend, useLocalState } from '../backend';
import { Box, Button, Collapsible, Flex, NoticeBox, Section, Table, Tabs } from '../components';
import { NtosWindow } from '../layouts';


export const NtosCard = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    have_id_slot,
    manifest,
    slots,
    has_id,
    authenticated,
    all_centcom_access,
    station_name,
    regions,
    id_name,
    auth_name,
    minor,
    centcom_access,
    id_owner,
    id_rank,
  } = data;

  const [tab, setTab] = useLocalState(context, 'tab', 0);

  return (
    <NtosWindow resizable>
      <NtosWindow.Content scrollable>
        <Tabs>
          {!!have_id_slot && (
            <Tabs.Tab
              icon="folder-open"
              selected={tab===0}
              onClick={() => {
                setTab(0);
                act('PRG_switchm', { target: 'mod' });
              }}>
              Access Modification
            </Tabs.Tab>
          )}
          <Tabs.Tab
            icon="folder-open"
            selected={tab===1}
            onClick={() => {
              setTab(1);
              act('PRG_switchm', { target: 'manage' });
            }}>
            Job Management
          </Tabs.Tab>
          <Tabs.Tab
            icon="folder-open"
            selected={tab===2}
            onClick={() => {
              setTab(2);
              act('PRG_switchm', { target: 'manifest' });
            }}>
            Crew Manifest
          </Tabs.Tab>
          <Button
            icon="print"
            content="Print"
            disabled={tab===1 || (tab===0 && !has_id)}
            onClick={() => act('PRG_print')} />
        </Tabs>

        {tab === 0 && (
          <Section title="Access Modification">
            <NtosCardAccessAuth id_name={id_name} auth_name={auth_name} />
            {authenticated && has_id && (
              <>
                <NtosCardAccessDetails
                  minor={minor}
                  id_owner={id_owner}
                  id_rank={id_rank}
                  act={act} />
                <NtosCardAccessAssignments centcom_access={centcom_access} />
                <NtosCardAccessRegions 
                  centcom_access={centcom_access}
                  all_centcom_access={all_centcom_access}
                  station_name={station_name}
                  regions={regions}
                  act={act} />
              </>
            ) || null}
          </Section>
        )}
        {tab === 1 && (
          <Section title="Job Management">
            <NtosCardJobManagement slots={slots} act={act} />
          </Section>
        )}
        {tab === 2 && (
          <Section title="Crew Manifest">
            <NoticeBox>
              Please use a <b>security records console</b> to modify entries.
            </NoticeBox>
            <Box>
              {manifest && manifest.map(crewmember => (
                <><b>{crewmember.name}</b> - {crewmember.rank}</>
              ))}
            </Box>
          </Section>
        )}
      </NtosWindow.Content>
    </NtosWindow>
  );
};


const NtosCardAccessRegions = (props, context) => {
  const {
    centcom_access,
    all_centcom_access,
    station_name,
    regions = [],
    act,
  } = props;

  const [regionTab, setRegionTab] = useLocalState(context, 'regionTab', 0);
  
  if (centcom_access) {
    return (
      <Section title="Central Command" level={2}>
        {all_centcom_access && all_centcom_access.map(access => (
          <Button.Checkbox
            key={access.desc} 
            content={access.desc}
            checked={access.allowed}
            onClick={() => act('PRG_access', { 
              access_target: access.ref,
              allowed: access.allowed,
            })} />
        ))}
      </Section>
    );
  }
  else {
    const activeRegion = regions[regionTab];

    return (
      <Section title={station_name} level={2}>
        <Tabs>
          {regions.map(region => (
            <Tabs.Tab
              key={region.regid}
              selected={region.selected}
              onClick={() => {
                act('PRG_regsel', { region: region.regid });
                setRegionTab(region.regid-1);
              }}>
              {region.name}
            </Tabs.Tab>
          ))}
        </Tabs>
        {activeRegion.accesses && (
          <Box>
            {activeRegion.accesses.map(access => (
              <Button.Checkbox
                key={access.desc} 
                content={access.desc}
                checked={access.allowed}
                onClick={() => act('PRG_access', { 
                  access_target: access.ref,
                  allowed: access.allowed,
                })} />
            ))}
          </Box>
        )}
      </Section>
    );
  }
};


const NtosCardJobManagement = (props, context) => {
  const { slots, act } = props;

  return (
    <Table>
      <Table.Row header>
        <Table.Cell>Job</Table.Cell>
        <Table.Cell>Slots</Table.Cell>
        <Table.Cell>Open Job</Table.Cell>
        <Table.Cell>Close Job</Table.Cell>
      </Table.Row>
      {!!slots && slots.map(slot => (
        <Table.Row key={slot.title}>
          <Table.Cell>{slot.title}</Table.Cell>
          <Table.Cell>{slot.current}/{slot.total}</Table.Cell>
          <Table.Cell>
            <Button 
              content={slot.desc_open}
              disabled={!slot.status_open}
              onClick={() => act('PRG_open_job', {
                target: slot.title,
              })} />
          </Table.Cell>
          <Table.Cell>
            <Button 
              content={slot.desc_close}
              disabled={!slot.status_close}
              onClick={() => act('PRG_close_job', {
                target: slot.title,
              })} />
          </Table.Cell>   
        </Table.Row>
      ))}
    </Table>
  );
};


const NtosCardAccessAuth = (props, context) => {
  const { act, data } = useBackend(context);
  const { 
    id_name,
    auth_name,
  } = props;
  
  return (
    <>
      <NoticeBox>
        Please insert the ID into the terminal to proceed.
      </NoticeBox>
      <Flex justify="space-between" direction="row" wrap="wrap">
        <Flex.Item>
          <Box>Target Identity:</Box>
          <Button
            icon="eject"
            content={id_name}
            onClick={() => act('PRG_eject', { target: 'id' })} />
        </Flex.Item>
        <Flex.Item>
          <Box>Auth Identity:</Box>
          <Button 
            icon="eject"
            content={auth_name} 
            onClick={() => act('PRG_eject', { target: 'auth' })} />
        </Flex.Item>
      </Flex>
    </>
  );
};


const NtosCardAccessDetails = (props, context) => {
  const {
    minor,
    id_owner,
    id_rank,
    act,
  } = props;

  return (
    <Section 
      title="Details"
      level={2}>
      {!!minor && (
        <>
          <Box>
            <b>Registered Name:</b> {id_owner}
          </Box>
          <Box>
            <b>Rank:</b> {id_rank}
          </Box>
          <Box>
            <Button
              icon="gear"
              onClick={() => act('PRG_terminate')}
              disabled={id_rank === 'Unassigned'}
              label={"Demote " + id_owner} />
          </Box>
        </>
      ) || (
        <Box>
          Registered Name:
          <Button
            content={id_owner.trim()}
            icon="pencil-alt"
            onClick={() => act('PRG_edit', { name: true })} />
        </Box>
      )}
    </Section>
  );
};


const NtosCardAccessAssignments = (props, context) => {
  const { data } = useBackend(context);
  const { centcom_access } = props;
  const {
    engineering_jobs = [],
    medical_jobs = [],
    science_jobs = [],
    security_jobs = [],
    cargo_jobs = [],
    civilian_jobs = [],
    centcom_jobs = [],
  } = data;

  return (
    <Section
      title="Assigments"
      level={2}>
      <Collapsible title="Job Presets">
        <Table>
          <Table.Row>
            <Table.Cell header>
              Special
            </Table.Cell>
            <Table.Cell>
              <NtosCardAssignButton 
                selectable
                icon="pencil-alt"
                assignJob={{
                  display_name: 'Custom Job Title',
                  job: 'Custom',
                }} />
            </Table.Cell>
          </Table.Row>
          <Table.Row>
            <Table.Cell header>
              Command
            </Table.Cell>
            <Table.Cell>
              <NtosCardAssignButton selectable assignJob={{
                display_name: 'Captain',
                job: 'Captain',
              }} />
            </Table.Cell>
          </Table.Row>
          {!!engineering_jobs && (
            <Table.Row>
              <Table.Cell header>
                Engineering
              </Table.Cell>
              <Table.Cell>
                {engineering_jobs.map(target => (
                  <NtosCardAssignButton 
                    key={target.display_name}
                    selectable 
                    assignJob={target} />
                ))}
              </Table.Cell>
            </Table.Row>
          )}
          {!!medical_jobs && (
            <Table.Row>
              <Table.Cell header>
                Medical
              </Table.Cell>
              <Table.Cell>
                {medical_jobs.map(target => (
                  <NtosCardAssignButton 
                    key={target.display_name}
                    selectable 
                    assignJob={target} />
                ))}
              </Table.Cell>
            </Table.Row>
          )}
          {!!science_jobs && (
            <Table.Row>
              <Table.Cell header>
                Science
              </Table.Cell>
              <Table.Cell>
                {science_jobs.map(target => (
                  <NtosCardAssignButton 
                    key={target.display_name}
                    selectable 
                    assignJob={target} />
                ))}
              </Table.Cell>
            </Table.Row>
          )}
          {!!security_jobs && (
            <Table.Row>
              <Table.Cell header>
                Security
              </Table.Cell>
              <Table.Cell>
                {security_jobs.map(target => (
                  <NtosCardAssignButton 
                    key={target.display_name}
                    selectable 
                    assignJob={target} />
                ))}
              </Table.Cell>
            </Table.Row>
          )}
          {!!cargo_jobs && (
            <Table.Row>
              <Table.Cell header>
                Cargo
              </Table.Cell>
              <Table.Cell>
                {cargo_jobs.map(target => (
                  <NtosCardAssignButton 
                    key={target.display_name}
                    selectable 
                    assignJob={target} />
                ))}
              </Table.Cell>
            </Table.Row>
          )}
          {!!civilian_jobs && (
            <Table.Row>
              <Table.Cell header>
                Civilian
              </Table.Cell>
              <Table.Cell>
                {civilian_jobs.map(target => (
                  <NtosCardAssignButton 
                    key={target.display_name}
                    selectable 
                    assignJob={target} />
                ))}
              </Table.Cell>
            </Table.Row>
          )}
          {!!centcom_access && !!centcom_jobs && (
            <Table.Row>
              <Table.Cell header>
                Centcom
              </Table.Cell>
              <Table.Cell>
                {centcom_jobs.map(target => (
                  <NtosCardAssignButton 
                    key={target.display_name}
                    selectable
                    assignJob={target} />
                ))}
              </Table.Cell>
              {/* {JSON.stringify(centcom_jobs)} */}
            </Table.Row>
          ) || null}
        </Table>
      </Collapsible>
    </Section>
  );
};


const NtosCardAssignButton = (props, context) => {
  const { act, data } = useBackend(context);
  const { id_rank } = data;
  const { assignJob, selectable, icon } = props;
  const { display_name, job } = assignJob;

  return (
    <Button
      content={display_name}
      icon={icon}
      selected={selectable && id_rank === job}
      onClick={() => act('PRG_assign', {
        assign_target: job,
      })} />
  );
};