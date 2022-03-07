import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';
import { useBackend } from '../../backend';

export const CPLCloneMode = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <LabeledList.Item label="Clone Mode">
      <Button
        content="Launch Clones"
        selected={data.launchClone}
        tooltip={multiline`
                Choosing this will create a duplicate of the item to be
                launched in Centcom, allowing you to send one type of item
                multiple times. Either way, the atoms are forceMoved into
                the supplypod after it lands (but before it opens).
              `}
        onClick={() => act('launchClone')} />
    </LabeledList.Item>
  );
};
