import { sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { toFixed } from 'common/math';
import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, ProgressBar, Section, Table } from '../components';
import { getGasColor, getGasLabel } from '../constants';
import { NtosWindow, Window } from '../layouts';

const logScale = value => Math.log2(16 + Math.max(0, value)) - 4;

export const NtosSupermatterMonitor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    active,
  } = data;
  const gases = flow([
    gases => gases.filter(gas => gas.amount >= 0.01),
    sortBy(gas => -gas.amount),
  ])(data.gases || []);
  const gasMaxAmount = Math.max(1, ...gases.map(gas => gas.amount));

  if (!active) {
    return (
      <NtosWindow resizable>
        <NtosWindow.Content>
          <SupermatterList />
        </NtosWindow.Content>
      </NtosWindow>
    );
  }

  return (
    <NtosWindow resizable>
      <NtosWindow.Content scrollable>
        <Flex spacing={1}>
          <Flex.Item width="270px">
            <Section title="Metrics">
              <NtosSmMetrics />
            </Section>
          </Flex.Item>
          <Flex.Item grow={1}>
            <Section
              title="Gases"
              buttons={(
                <Button
                  icon="arrow-left"
                  content="Back"
                  onClick={() => act('PRG_clear')} />
              )}>
              <Box.Forced height={gases.length * 24 + 'px'}>
                <LabeledList>
                  {gases.map(gas => (
                    <LabeledList.Item
                      key={gas.name}
                      label={getGasLabel(gas.name)}>
                      <ProgressBar
                        color={getGasColor(gas.name)}
                        value={gas.amount}
                        minValue={0}
                        maxValue={gasMaxAmount}>
                        {toFixed(gas.amount, 2) + '%'}
                      </ProgressBar>
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              </Box.Forced>
            </Section>
          </Flex.Item>
        </Flex>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const NtosSmMetrics = (props, context) => {
  const { data } = useBackend(context);
  const {
    SM_integrity,
    SM_power,
    SM_ambienttemp,
    SM_ambientpressure,
  } = data;
  
  return (
    <LabeledList>
      <LabeledList.Item label="Integrity">
        <ProgressBar
          value={SM_integrity / 100}
          ranges={{
            good: [0.90, Infinity],
            average: [0.5, 0.90],
            bad: [-Infinity, 0.5],
          }} />
      </LabeledList.Item>
      <LabeledList.Item label="Relative EER">
        <ProgressBar
          value={SM_power}
          minValue={0}
          maxValue={5000}
          ranges={{
            good: [-Infinity, 5000],
            average: [5000, 7000],
            bad: [7000, Infinity],
          }}>
          {toFixed(SM_power) + ' MeV/cm3'}
        </ProgressBar>
      </LabeledList.Item>
      <LabeledList.Item label="Temperature">
        <ProgressBar
          value={logScale(SM_ambienttemp)}
          minValue={0}
          maxValue={logScale(10000)}
          ranges={{
            teal: [-Infinity, logScale(80)],
            good: [logScale(80), logScale(373)],
            average: [logScale(373), logScale(1000)],
            bad: [logScale(1000), Infinity],
          }}>
          {toFixed(SM_ambienttemp) + ' K'}
        </ProgressBar>
      </LabeledList.Item>
      <LabeledList.Item label="Pressure">
        <ProgressBar
          value={logScale(SM_ambientpressure)}
          minValue={0}
          maxValue={logScale(50000)}
          ranges={{
            good: [logScale(1), logScale(300)],
            average: [-Infinity, logScale(1000)],
            bad: [logScale(1000), +Infinity],
          }}>
          {toFixed(SM_ambientpressure) + ' kPa'}
        </ProgressBar>
      </LabeledList.Item>
    </LabeledList>
  );
};

const SupermatterList = (props, context) => {
  const { act, data } = useBackend(context);
  const { supermatters = [] } = data;
  return (
    <Section
      title="Detected Supermatters"
      buttons={(
        <Button
          icon="sync"
          content="Refresh"
          onClick={() => act('PRG_refresh')} />
      )}>
      <Table>
        {supermatters.map(sm => (
          <Table.Row key={sm.uid}>
            <Table.Cell>
              {sm.uid + '. ' + sm.area_name}
            </Table.Cell>
            <Table.Cell collapsing color="label">
              Integrity:
            </Table.Cell>
            <Table.Cell collapsing width="120px">
              <ProgressBar
                value={sm.integrity / 100}
                ranges={{
                  good: [0.90, Infinity],
                  average: [0.5, 0.90],
                  bad: [-Infinity, 0.5],
                }} />
            </Table.Cell>
            <Table.Cell collapsing>
              <Button
                content="Details"
                onClick={() => act('PRG_set', {
                  target: sm.uid,
                })} />
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};
