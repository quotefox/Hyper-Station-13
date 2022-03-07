import { LabeledList } from '../../components';
import { NaniteExtraBoolean } from "./NaniteExtraBoolean";
import { NaniteExtraType } from "./NaniteExtraType";
import { NaniteExtraText } from "./NaniteExtraText";
import { NaniteExtraNumber } from "./NaniteExtraNumber";


export const NaniteExtraEntry = (props, context) => {
  const { act, extra_setting } = props;
  const {
    name, type,
  } = extra_setting;
  const typeComponentMap = {
    number: <NaniteExtraNumber act={act} extra_setting={extra_setting} />,
    text: <NaniteExtraText act={act} extra_setting={extra_setting} />,
    type: <NaniteExtraType act={act} extra_setting={extra_setting} />,
    boolean: <NaniteExtraBoolean act={act} extra_setting={extra_setting} />,
  };
  return (
    <LabeledList.Item label={name}>
      {typeComponentMap[type]}
    </LabeledList.Item>
  );
};
