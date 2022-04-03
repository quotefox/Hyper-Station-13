import { Input } from '../../components';


export const NaniteExtraText = (props, context) => {
  const { act, extra_setting } = props;
  const {
    name, value,
  } = extra_setting;
  return (
    <Input
      value={value}
      width="200px"
      onInput={(e, val) => act('set_extra_setting', {
        target_setting: name,
        value: val,
      })} />
  );
};
