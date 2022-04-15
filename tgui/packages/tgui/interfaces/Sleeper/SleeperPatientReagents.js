import { Box, LabeledList, Section } from '../../components';


export const SleeperPatientReagents = (props, context) => {
  const { data } = props;
  const { chemical_list } = data;

  return (
    <Section title="Chemical Analysis">
      <LabeledList.Item label="Chemical Contents">
        {chemical_list.map(specificChem => (
          <Box
            key={specificChem.id}
            color="good">
            {specificChem.volume} units of {specificChem.name}
          </Box>
        ),
        )}
      </LabeledList.Item>
    </Section>
  );
};
