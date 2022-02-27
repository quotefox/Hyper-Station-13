import { multiline } from 'common/string';
import { Button, LabeledList } from '../../components';

export const CPLSupplyBay = (data, act) => {
  return (
    <LabeledList.Item label="Supply Bay">
      <Button
        content="Bay #1"
        selected={data.bayNumber === 1}
        onClick={() => act('bay1')} />
      <Button
        content="Bay #2"
        selected={data.bayNumber === 2}
        onClick={() => act('bay2')} />
      <Button
        content="Bay #3"
        selected={data.bayNumber === 3}
        onClick={() => act('bay3')} />
      <Button
        content="Bay #4"
        selected={data.bayNumber === 4}
        onClick={() => act('bay4')} />
      <Button
        content="ERT Bay"
        selected={data.bayNumber === 5}
        tooltip={multiline`
                This bay is located on the western edge of CentCom. Its the
                glass room directly west of where ERT spawn, and south of the
                CentCom ferry. Useful for launching ERT/Deathsquads/etc. onto
                the station via drop pods.
              `}
        onClick={() => act('bay5')} />
    </LabeledList.Item>
  );
};
