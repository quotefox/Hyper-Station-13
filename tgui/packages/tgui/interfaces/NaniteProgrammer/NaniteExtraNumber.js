import { NumberInput } from '../../components';


export const NaniteExtraNumber = (props, context) => {
  const { act, extra_setting } = props;
  const {
    name, value, min, max, unit,
  } = extra_setting;
  return (
    <NumberInput
      value={value}
      width="64px"
      minValue={min}
      maxValue={max}
      unit={unit}
      onChange={(e, val) => act('set_extra_setting', {
        target_setting: name,
        value: val,
      })} />
  );
};
