import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';

export const CPLExplosion = (data, act) => {
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
