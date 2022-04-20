import { Fragment } from 'inferno';
import { useBackend } from '../../backend';
import { Box, Button, Collapsible, NoticeBox, Section } from '../../components';
import { NaniteInfoBox } from './NaniteInfoBox';

export const NaniteCloudBackupDetails = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current_view, disk, has_program, cloud_backup,
  } = data;

  const can_rule = (disk && disk.can_rule) || false;

  if (!cloud_backup) {
    return (
      <NoticeBox>
        ERROR: Backup not found
      </NoticeBox>
    );
  }

  const cloud_programs = data.cloud_programs || [];

  return (
    <Section
      title={"Backup #" + current_view}
      level={2}
      buttons={(
        !!has_program && (
          <Button
            icon="upload"
            content="Upload From Disk"
            color="good"
            onClick={() => act('upload_program')} />
        )
      )}>
      {cloud_programs.map(program => {
        const rules = program.rules || [];
        return (
          <Collapsible
            key={program.name}
            title={program.name}
            buttons={(
              <Button
                icon="minus-circle"
                color="bad"
                onClick={() => act('remove_program', {
                  program_id: program.id,
                })} />
            )}>
            <Section>
              <NaniteInfoBox program={program} />
              {!!can_rule && (
                <Section
                  mt={-2}
                  title="Rules"
                  level={2}
                  buttons={(
                    <Button
                      icon="plus"
                      content="Add Rule from Disk"
                      color="good"
                      onClick={() => act('add_rule', {
                        program_id: program.id,
                      })} />
                  )}>
                  {program.has_rules ? (
                    rules.map(rule => (
                      <Fragment key={rule.display}>
                        <Button
                          icon="minus-circle"
                          color="bad"
                          onClick={() => act('remove_rule', {
                            program_id: program.id,
                            rule_id: rule.id,
                          })} />
                        {rule.display}
                      </Fragment>
                    ))
                  ) : (
                    <Box color="bad">
                      No Active Rules
                    </Box>
                  )}
                </Section>
              )}
            </Section>
          </Collapsible>
        );
      })}
    </Section>
  );
};
