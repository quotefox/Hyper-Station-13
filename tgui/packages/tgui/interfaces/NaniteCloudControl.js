import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, NumberInput, Section } from '../components';
import { Window } from '../layouts';
import { NaniteCloudBackupDetails } from './NaniteCloudControl/NaniteCloudBackupDetails';
import { NaniteCloudBackupList } from './NaniteCloudControl/NaniteCloudBackupList';
import { NaniteDiskBox } from './NaniteCloudControl/NaniteDiskBox';

export const NaniteCloudControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_disk,
    current_view,
    new_backup_id,
  } = data;

  return (
    <Window>
      <Window.Content>
        <Section
          title="Program Disk"
          buttons={(
            <Button
              icon="eject"
              content="Eject"
              disabled={!has_disk}
              onClick={() => act('eject')} />
          )}>
          <NaniteDiskBox />
        </Section>
        <Section
          title="Cloud Storage"
          buttons={(
            current_view ? (
              <Button
                icon="arrow-left"
                content="Return"
                onClick={() => act('set_view', {
                  view: 0,
                })} />
            ) : (
              <Fragment>
                {"New Backup: "}
                <NumberInput
                  value={new_backup_id}
                  minValue={1}
                  maxValue={100}
                  stepPixelSize={4}
                  width="39px"
                  onChange={(e, value) => act('update_new_backup_value', {
                    value: value,
                  })} />
                <Button
                  icon="plus"
                  onClick={() => act('create_backup')} />
              </Fragment>
            )
          )}>
          {/* {!data.current_view ? (
            <NaniteCloudBackupList />
          ) : (
            <NaniteCloudBackupDetails />
          )} */}
        </Section>
      </Window.Content>
    </Window>
  );
};

