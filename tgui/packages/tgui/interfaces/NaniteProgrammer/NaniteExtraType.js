import { Dropdown } from '../../components';


export const NaniteExtraType = (props, context) => {
  const { act, extra_setting } = props;
  const {
    name, value, types,
  } = extra_setting;
  return (
    <Dropdown
      over
      selected={value}
      width="150px"
      options={types}
      onSelected={val => act('set_extra_setting', {
        target_setting: name,
        value: val,
      })} />
  );
};
