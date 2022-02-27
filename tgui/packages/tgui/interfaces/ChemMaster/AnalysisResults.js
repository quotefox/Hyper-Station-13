import { useBackend } from '../../backend';
import { Button, ColorBox, LabeledList, Section } from '../../components';

export const AnalysisResults = (props, context) => {
  const { config, data, act } = useBackend(context);
  const { ref } = config;
  const { analyzeVars, fermianalyze } = data;
  return (
    <Section
      title="Analysis Results"
      buttons={(
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => act(ref, 'goScreen', {
            screen: 'home',
          })} />
      )}>
      {!fermianalyze && (
        <LabeledList>
          <LabeledList.Item label="Name">
            {analyzeVars.name}
          </LabeledList.Item>
          <LabeledList.Item label="State">
            {analyzeVars.state}
          </LabeledList.Item>
          <LabeledList.Item label="Color">
            <ColorBox color={analyzeVars.color} mr={1} />
            {analyzeVars.color}
          </LabeledList.Item>
          <LabeledList.Item label="Description">
            {analyzeVars.description}
          </LabeledList.Item>
          <LabeledList.Item label="Metabolization Rate">
            {analyzeVars.metaRate} u/minute
          </LabeledList.Item>
          <LabeledList.Item label="Overdose Threshold">
            {analyzeVars.overD}
          </LabeledList.Item>
          <LabeledList.Item label="Addiction Threshold">
            {analyzeVars.addicD}
          </LabeledList.Item>
        </LabeledList>
      )}
      {!!fermianalyze && (
        <LabeledList>
          <LabeledList.Item label="Name">
            {analyzeVars.name}
          </LabeledList.Item>
          <LabeledList.Item label="State">
            {analyzeVars.state}
          </LabeledList.Item>
          <LabeledList.Item label="Color">
            <ColorBox color={analyzeVars.color} mr={1} />
            {analyzeVars.color}
          </LabeledList.Item>
          <LabeledList.Item label="Description">
            {analyzeVars.description}
          </LabeledList.Item>
          <LabeledList.Item label="Metabolization Rate">
            {analyzeVars.metaRate} u/minute
          </LabeledList.Item>
          <LabeledList.Item label="Overdose Threshold">
            {analyzeVars.overD}
          </LabeledList.Item>
          <LabeledList.Item label="Addiction Threshold">
            {analyzeVars.addicD}
          </LabeledList.Item>
          <LabeledList.Item label="Purity">
            {analyzeVars.purityF}
          </LabeledList.Item>
          <LabeledList.Item label="Inverse Ratio">
            {analyzeVars.inverseRatioF}
          </LabeledList.Item>
          <LabeledList.Item label="Purity E">
            {analyzeVars.purityE}
          </LabeledList.Item>
          <LabeledList.Item label="Lower Optimal Temperature">
            {analyzeVars.minTemp}
          </LabeledList.Item>
          <LabeledList.Item label="Upper Optimal Temperature">
            {analyzeVars.maxTemp}
          </LabeledList.Item>
          <LabeledList.Item label="Explosive Temperature">
            {analyzeVars.eTemp}
          </LabeledList.Item>
          <LabeledList.Item label="pH Peak">
            {analyzeVars.pHpeak}
          </LabeledList.Item>
        </LabeledList>
      )}
    </Section>
  );
};
