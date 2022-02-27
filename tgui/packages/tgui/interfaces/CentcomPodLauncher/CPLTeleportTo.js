import { Button, LabeledList } from '../../components';

export const CPLTeleportTo = (data, act) => {
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
