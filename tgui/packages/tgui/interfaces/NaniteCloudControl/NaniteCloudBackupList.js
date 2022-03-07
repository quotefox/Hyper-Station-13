import { useBackend } from '../../backend';
import { Button } from '../../components';

export const NaniteCloudBackupList = (props, context) => {
  const { act, data } = useBackend(context);
  const cloud_backups = data.cloud_backups || [];
  return (
    cloud_backups.map(backup => (
      <Button
        fluid
        key={backup.cloud_id}
        content={"Backup #" + backup.cloud_id}
        textAlign="center"
        onClick={() => act('set_view', {
          view: backup.cloud_id,
        })} />
    ))
  );
};
