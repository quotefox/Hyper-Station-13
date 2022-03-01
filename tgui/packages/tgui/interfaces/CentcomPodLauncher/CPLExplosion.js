import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';
import { useBackend } from '../../backend';

export const CPLExplosion = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <LabeledList.Item label="Explosion">
      <Button
        content="Custom Size"
        selected={data.explosionChoice === 1}
        tooltip={multiline`
          This will cause an explosion of whatever size you like
          (including flame range) to occur as soon as the supplypod
          lands. Dont worry, supply-pods are explosion-proof!
        `}
        onClick={() => act('explosionCustom')} />
      <Button
        content="Adminbus"
        selected={data.explosionChoice === 2}
        tooltip={multiline`
          This will cause a maxcap explosion (dependent on server
          config) to occur as soon as the supplypod lands. Dont worry,
          supply-pods are explosion-proof!
        `}
        onClick={() => act('explosionBus')} />
    </LabeledList.Item>
  );
};
