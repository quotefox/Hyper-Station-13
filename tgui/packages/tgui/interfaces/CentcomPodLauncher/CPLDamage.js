import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';
import { useBackend } from '../../backend';

export const CPLDamage = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <LabeledList.Item label="Damage">
      <Button
        content="Custom Damage"
        selected={data.damageChoice === 1}
        tooltip={multiline`
          Anyone caught under the pod when it lands will be dealt
          this amount of brute damage. Sucks to be them!
        `}
        onClick={() => act('damageCustom')} />
      <Button
        content="Gib"
        selected={data.damageChoice === 2}
        tooltip={multiline`
          This will attempt to gib any mob caught under the pod when
          it lands, as well as dealing a nice 5000 brute damage. Ya
          know, just to be sure!
        `}
        onClick={() => act('damageGib')} />
    </LabeledList.Item>
  );
};
