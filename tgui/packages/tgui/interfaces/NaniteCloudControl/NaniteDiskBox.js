import { useBackend } from '../../backend';
import { NoticeBox } from '../../components';
import { NaniteInfoBox } from "./NaniteInfoBox";

export const NaniteDiskBox = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_disk, has_program, disk,
  } = data;

  if (!has_disk) {
    return (
      <NoticeBox>
        No disk inserted
      </NoticeBox>
    );
  }

  if (!has_program) {
    return (
      <NoticeBox>
        Inserted disk has no program
      </NoticeBox>
    );
  }

  return (
    <NaniteInfoBox program={disk} />
  );
};
