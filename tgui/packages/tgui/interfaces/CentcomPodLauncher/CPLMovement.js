import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';

export const CPLMovement = (data, act) => {
  return (
    <LabeledList.Item label="Movement">
      <Button
        content="Bluespace"
        selected={data.effectBluespace}
        tooltip={multiline`
          Gives the supplypod an advanced Bluespace Recyling Device.
          After opening, the supplypod will be warped directly to the
          surface of a nearby NT-designated trash planet (/r/ss13).
        `}
        onClick={() => act('effectBluespace')} />
      <Button
        content="Stealth"
        selected={data.effectStealth}
        tooltip={multiline`
          This hides the red target icon from appearing when you
          launch the supplypod. Combos well with the "Invisible"
          style. Sneak attack, go!
        `}
        onClick={() => act('effectStealth')} />
      <Button
        content="Quiet"
        selected={data.effectQuiet}
        tooltip={multiline`
          This will keep the supplypod from making any sounds, except
          for those specifically set by admins in the Sound section.
        `}
        onClick={() => act('effectQuiet')} />
      <Button
        content="Reverse Mode"
        selected={data.effectReverse}
        tooltip={multiline`
          This pod will not send any items. Instead, after landing,
          the supplypod will close (similar to a normal closet closing),
          and then launch back to the right centcom bay to drop off any
          new contents.
        `}
        onClick={() => act('effectReverse')} />
      <Button
        content="Missile Mode"
        selected={data.effectMissile}
        tooltip={multiline`
          This pod will not send any items. Instead, it will immediately
          delete after landing (Similar visually to setting openDelay
          & departDelay to 0, but this looks nicer). Useful if you just
          wanna fuck some shit up. Combos well with the Missile style.
        `}
        onClick={() => act('effectMissile')} />
      <Button
        content="Any Descent Angle"
        selected={data.effectCircle}
        tooltip={multiline`
          This will make the supplypod come in from any angle. Im not
          sure why this feature exists, but here it is.
        `}
        onClick={() => act('effectCircle')} />
      <Button
        content="Machine Gun Mode"
        selected={data.effectBurst}
        tooltip={multiline`
          This will make each click launch 5 supplypods inaccuratly
          around the target turf (a 3x3 area). Combos well with the
          Missile Mode if you dont want shit lying everywhere after.
        `}
        onClick={() => act('effectBurst')} />
      <Button
        content="Specific Target"
        selected={data.effectTarget}
        tooltip={multiline`
          This will make the supplypod target a specific atom, instead
          of the mouses position. Smiting does this automatically!
        `}
        onClick={() => act('effectTarget')} />
    </LabeledList.Item>
  );
};
