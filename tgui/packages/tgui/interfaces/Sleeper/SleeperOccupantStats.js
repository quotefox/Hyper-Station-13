import { Fragment } from 'inferno';
import { AnimatedNumber, Box, LabeledList, ProgressBar, Section } from '../../components';


export const SleeperOccupantStats = (props, context) => {
  const { data } = props;
  const { occupant, occupied } = data;
  const damageTypes = [
    {
      label: 'Brute',
      type: 'bruteLoss',
    },
    {
      label: 'Burn',
      type: 'fireLoss',
    },
    {
      label: 'Toxin',
      type: 'toxLoss',
    },
    {
      label: 'Oxygen',
      type: 'oxyLoss',
    },
  ];

  return (
    <Section
      title={occupant.name ? occupant.name : 'No Occupant'}
      minHeight="210px"
      buttons={!!occupant.stat && (
        <Box
          inline
          bold
          color={occupant.statstate}>
          {occupant.stat}
        </Box>
      )}>
      {!!occupied && (
        <Fragment>
          <ProgressBar
            value={occupant.health}
            minValue={occupant.minHealth}
            maxValue={occupant.maxHealth}
            ranges={{
              good: [50, Infinity],
              average: [0, 50],
              bad: [-Infinity, 0],
            }} />
          <Box mt={1} />
          <LabeledList>
            {damageTypes.map(type => (
              <LabeledList.Item
                key={type.type}
                label={type.label}>
                <ProgressBar
                  value={occupant[type.type]}
                  minValue={0}
                  maxValue={occupant.maxHealth}
                  color="bad" />
              </LabeledList.Item>
            ))}
            <LabeledList.Item
              label={'Blood'}>
              <ProgressBar
                value={data.blood_levels / 100}
                color="bad">
                <AnimatedNumber value={data.blood_levels} />
              </ProgressBar>
              {data.blood_status}
            </LabeledList.Item>
            <LabeledList.Item
              label="Cells"
              color={occupant.cloneLoss ? 'bad' : 'good'}>
              {occupant.cloneLoss ? 'Damaged' : 'Healthy'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Brain"
              color={occupant.brainLoss ? 'bad' : 'good'}>
              {occupant.brainLoss ? 'Abnormal' : 'Healthy'}
            </LabeledList.Item>
          </LabeledList>
        </Fragment>
      )}
    </Section>
  );
};
