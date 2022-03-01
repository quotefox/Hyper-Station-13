import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';
import { useBackend } from '../../backend';

export const CPLTimers = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <LabeledList.Item label="Timers">
      <Button
        content="Custom Falling Duration"
        selected={data.fallDuration !== 4}
        tooltip={multiline`
          Set how long the animation for the pod falling lasts. Create
          dramatic, slow falling pods!
        `}
        onClick={() => act('fallDuration')} />
      <Button
        content="Custom Landing Time"
        selected={data.landingDelay !== 20}
        tooltip={multiline`
          Choose the amount of time it takes for the supplypod to hit
          the station. By default this value is 0.5 seconds.
        `}
        onClick={() => act('landingDelay')} />
      <Button
        content="Custom Opening Time"
        selected={data.openingDelay !== 30}
        tooltip={multiline`
          Choose the amount of time it takes for the supplypod to open
          after landing. Useful for giving whatevers inside the pod a
          nice dramatic entrance! By default this value is 3 seconds.
        `}
        onClick={() => act('openingDelay')} />
      <Button
        content="Custom Leaving Time"
        selected={data.departureDelay !== 30}
        tooltip={multiline`
          Choose the amount of time it takes for the supplypod to leave
          after landing. By default this value is 3 seconds.
        `}
        onClick={() => act('departureDelay')} />
    </LabeledList.Item>
  );
};
