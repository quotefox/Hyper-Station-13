import { Button, Section } from '../../components';
import { SleeperOpenButton } from "./SleeperOpenButton";


export const SleeperInjectChems = (props, context) => {
  const { data, act } = props;
  const { showOpenClosed, chems } = props;
  const { occupied } = data;

  return (
    <Section
      title="Inject Chemicals"
      minHeight="105px"
      buttons={showOpenClosed && <SleeperOpenButton data={data} act={act} />}>
      {chems.map(chem => (
        <Button
          key={chem.name}
          icon="flask"
          content={chem.name}
          disabled={!(occupied && chem.allowed)}
          width="140px"
          onClick={() => act('inject', {
            chem: chem.id,
          })} />
      ))}
    </Section>
  );
};
