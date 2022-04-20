import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';
import { useBackend } from '../../backend';

export const CPLStyle = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <LabeledList.Item label="Style">
      <Button
        content="Standard"
        selected={data.styleChoice === 1}
        tooltip={multiline`
          Same color scheme as the normal station-used supplypods
        `}
        onClick={() => act('styleStandard')} />
      <Button
        content="Advanced"
        selected={data.styleChoice === 2}
        tooltip={multiline`
          The same as the stations upgraded blue-and-white
          Bluespace Supplypods
        `}
        onClick={() => act('styleBluespace')} />
      <Button
        content="Syndicate"
        selected={data.styleChoice === 4}
        tooltip={multiline`
          A menacing black and blood-red. Great for sending meme-ops
          in style!
        `}
        onClick={() => act('styleSyndie')} />
      <Button
        content="Deathsquad"
        selected={data.styleChoice === 5}
        tooltip={multiline`
          A menacing black and dark blue. Great for sending deathsquads
          in style!
        `}
        onClick={() => act('styleBlue')} />
      <Button
        content="Cult Pod"
        selected={data.styleChoice === 6}
        tooltip="A blood and rune covered cult pod!"
        onClick={() => act('styleCult')} />
      <Button
        content="Missile"
        selected={data.styleChoice === 7}
        tooltip={multiline`
          A large missile. Combos well with a missile mode, so the
          missile doesnt stick around after landing.
        `}
        onClick={() => act('styleMissile')} />
      <Button
        content="Syndicate Missile"
        selected={data.styleChoice === 8}
        tooltip={multiline`
          A large blood-red missile. Combos well with missile mode,
          so the missile doesnt stick around after landing.
        `}
        onClick={() => act('styleSMissile')} />
      <Button
        content="Supply Crate"
        selected={data.styleChoice === 9}
        tooltip="A large, dark-green military supply crate."
        onClick={() => act('styleBox')} />
      <Button
        content="HONK"
        selected={data.styleChoice === 10}
        tooltip="A colorful, clown inspired look."
        onClick={() => act('styleHONK')} />
      <Button
        content="~Fruit"
        selected={data.styleChoice === 11}
        tooltip="For when an orange is angry"
        onClick={() => act('styleFruit')} />
      <Button
        content="Invisible"
        selected={data.styleChoice === 12}
        tooltip={multiline`
          Makes the supplypod invisible! Useful for when you want to
          use this feature with a gateway or something. Combos well
          with the "Stealth" and "Quiet Landing" effects.
        `}
        onClick={() => act('styleInvisible')} />
      <Button
        content="Gondola"
        selected={data.styleChoice === 13}
        tooltip={multiline`
          This gondola can control when he wants to deliver his supplies
          if he has a smart enough mind, so offer up his body to ghosts
          for maximum enjoyment. (Make sure to turn off bluespace and
          set a arbitrarily high open-time if you do!
        `}
        onClick={() => act('styleGondola')} />
      <Button
        content="Show Contents (See Through Pod)"
        selected={data.styleChoice === 14}
        tooltip={multiline`
          By selecting this, the pod will instead look like whatevers
          inside it (as if it were the contents falling by themselves,
          without a pod). Useful for launching mechs at the station
          and standing tall as they soar in from the heavens.
        `}
        onClick={() => act('styleSeeThrough')} />
    </LabeledList.Item>
  );
};
