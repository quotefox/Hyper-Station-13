import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';
import { useBackend } from '../../backend';

export const CPLEffects = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <LabeledList.Item label="Effects">
      <Button
        content="Stun"
        selected={data.effectStun}
        tooltip={multiline`
          Anyone who is on the turf when the supplypod is launched
          will be stunned until the supplypod lands. They cant get
          away that easy!
        `}
        onClick={() => act('effectStun')} />
      <Button
        content="Delimb"
        selected={data.effectLimb}
        tooltip={multiline`
          This will cause anyone caught under the pod to lose a limb,
          excluding their head.
        `}
        onClick={() => act('effectLimb')} />
      <Button
        content="Yeet Organs"
        selected={data.effectOrgans}
        tooltip={multiline`
          This will cause anyone caught under the pod to lose all
          their limbs and organs in a spectacular fashion.
        `}
        onClick={() => act('effectOrgans')} />
    </LabeledList.Item>
  );
};
