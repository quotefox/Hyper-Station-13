import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';

export const CPLNameAndDescription = (data, act) => {
  return (
    <LabeledList.Item label="Name/Desc">
      <Button
        content="Custom Name/Desc"
        selected={data.effectName}
        tooltip="Allows you to add a custom name and description."
        onClick={() => act('effectName')} />
      <Button
        content="Alert Ghosts"
        selected={data.effectAnnounce}
        tooltip={multiline`
          Alerts ghosts when a pod is launched. Useful if some dumb
          shit is aboutta come outta the pod.
        `}
        onClick={() => act('effectAnnounce')} />
    </LabeledList.Item>
  );
};
