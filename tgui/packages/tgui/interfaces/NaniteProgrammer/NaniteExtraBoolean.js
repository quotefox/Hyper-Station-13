import { Button } from '../../components';


export const NaniteExtraBoolean = (props, context) => {
  const { act, extra_setting } = props;
  const {
    name, value, true_text, false_text,
  } = extra_setting;
  return (
    <Button.Checkbox
      content={value ? true_text : false_text}
      checked={value}
      onClick={() => act('set_extra_setting', {
        target_setting: name,
      })} />
  );
};
