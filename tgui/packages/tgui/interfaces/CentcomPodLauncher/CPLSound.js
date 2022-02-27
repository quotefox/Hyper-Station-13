import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';

export const CPLSound = (data, act) => {
  return (
    <LabeledList.Item label="Sound">
      <Button
        content="Custom Falling Sound"
        selected={data.fallingSound}
        tooltip={multiline`
          Choose a sound to play as the pod falls. Note that for this
          to work right you should know the exact length of the sound,
          in seconds.
        `}
        onClick={() => act('fallSound')} />
      <Button
        content="Custom Landing Sound"
        selected={data.landingSound}
        tooltip="Choose a sound to play when the pod lands."
        onClick={() => act('landingSound')} />
      <Button
        content="Custom Opening Sound"
        selected={data.openingSound}
        tooltip="Choose a sound to play when the pod opens."
        onClick={() => act('openingSound')} />
      <Button
        content="Custom Leaving Sound"
        selected={data.leavingSound}
        tooltip={multiline`
          Choose a sound to play when the pod departs (whether that be
          delection in the case of a bluespace pod, or leaving for
          centcom for a reversing pod).
        `}
        onClick={() => act('leavingSound')} />
      <Button
        content="Admin Sound Volume"
        selected={data.soundVolume}
        tooltip={multiline`
          Choose the volume for the sound to play at. Default values
          are between 1 and 100, but hey, do whatever. Im a tooltip,
          not a cop.
        `}
        onClick={() => act('soundVolume')} />
    </LabeledList.Item>
  );
};
