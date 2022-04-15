import { Button, Section } from '../../components';


export const SleeperPurgeChems = (props, context) => {
  const { chems, act } = props;

  return (
    <Section
      title="Purge Chemicals">
      {chems.map(chem => (
        <Button
          key={chem.name}
          content={chem.name}
          disabled={!(chem.allowed)}
          width="140px"
          onClick={() => act('purge', {
            chem: chem.id,
          })} />
      ))}
    </Section>
  );
};
