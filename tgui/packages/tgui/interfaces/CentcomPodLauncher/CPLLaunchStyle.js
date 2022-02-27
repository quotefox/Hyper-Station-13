import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';

export const CPLLaunchStyle = (data, act) => {
  return (
    <LabeledList.Item label="Launch style">
      <Button
        content="Ordered"
        selected={data.launchChoice === 1}
        tooltip={multiline`
          Instead of launching everything in the bay at once, this
          will "scan" things (one turf-full at a time) in order, left
          to right and top to bottom. undoing will reset the "scanner"
          to the top-leftmost position.
        `}
        onClick={() => act('launchOrdered')} />
      <Button
        content="Random"
        selected={data.launchChoice === 2}
        tooltip={multiline`
          Instead of launching everything in the bay at once, this
          will launch one random turf of items at a time.
        `}
        onClick={() => act('launchRandom')} />
    </LabeledList.Item>
  );
};
