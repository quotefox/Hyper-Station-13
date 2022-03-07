import { Button, LabeledList } from '../../components';
import { useBackend } from '../../backend';

export const CPLTeleportTo = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <LabeledList.Item label="Teleport to">
      <Button
        content={data.bay}
        onClick={() => act('teleportCentcom')} />
      <Button
        content={data.oldArea ? data.oldArea : 'Where you were'}
        disabled={!data.oldArea}
        onClick={() => act('teleportBack')} />
    </LabeledList.Item>
  );
};
