import { Button, Section } from '../../components';


export const SleeperSynthChems = (props, context) => {
  const { data, act } = props;
  const preSortSynth = data.synthchems || [];
  const synthchems = preSortSynth.sort((a, b) => {
    const descA = a.name.toLowerCase();
    const descB = b.name.toLowerCase();
    if (descA < descB) {
      return -1;
    }
    if (descA > descB) {
      return 1;
    }
    return 0;
  });

  return (
    <Section
      title="Synthesize Chemicals">
      {synthchems.map(chem => (
        <Button
          key={chem.name}
          content={chem.name}
          width="140px"
          onClick={() => act('synth', {
            chem: chem.id,
          })} />
      ))}
    </Section>
  );
};
