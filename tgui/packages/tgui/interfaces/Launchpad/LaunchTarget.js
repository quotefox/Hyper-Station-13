import { Box, NumberInput, Section } from '../../components';

export const LaunchTarget = (data, act) => {
  const { x, y, range } = data;
  return (
    <Section title="Target" level={2}>
      <Box fontSize="26px">
        <Box mb={1}>
          <Box
            inline
            bold
            mr={1}>
            X:
          </Box>
          <NumberInput
            value={x}
            minValue={-range}
            maxValue={range}
            lineHeight="30px"
            fontSize="26px"
            width="90px"
            height="30px"
            stepPixelSize={10}
            onChange={(e, value) => act('set_pos', {
              x: value,
            })} />
        </Box>
        <Box>
          <Box
            inline
            bold
            mr={1}>
            Y:
          </Box>
          <NumberInput
            value={y}
            minValue={-range}
            maxValue={range}
            stepPixelSize={10}
            lineHeight="30px"
            fontSize="26px"
            width="90px"
            height="30px"
            onChange={(e, value) => act('set_pos', {
              y: value,
            })} />
        </Box>
      </Box>
    </Section>
  );
};
