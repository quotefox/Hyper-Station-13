import { Component } from 'inferno';
import { useBackend } from '../../backend';
import { act } from '../../byond';
import { Box, Button, LabeledList, NumberInput } from '../../components';

export class PackagingControls extends Component {
  constructor() {
    super();
    this.state = {
      pillAmount: 1,
      patchAmount: 1,
      bottleAmount: 1,
      packAmount: 1,
      vialAmount: 1,
      dartAmount: 1,
    };
  }

  render() {
    const { props, context } = this;
    const { data, act } = useBackend(context);
    const {
      pillAmount, patchAmount, bottleAmount, packAmount, vialAmount, dartAmount,
    } = this.state;
    const {
      condi, chosenPillStyle, pillStyles = [],
    } = data;
    return (
      <LabeledList>
        {!condi && (
          <LabeledList.Item label="Pill type">
            {pillStyles.map(pill => (
              <Button
                key={pill.id}
                width={5}
                selected={pill.id === chosenPillStyle}
                textAlign="center"
                color="transparent"
                onClick={() => act('pillStyle', { id: pill.id })}>
                <Box mx={-1} className={pill.className} />
              </Button>
            ))}
          </LabeledList.Item>
        )}
        {!condi && (
          <PackagingControlsItem
            label="Pills"
            amount={pillAmount}
            amountUnit="pills"
            sideNote="max 50u"
            onChangeAmount={(e, value) => this.setState({
              pillAmount: value,
            })}
            onCreate={() => act('create', {
              type: 'pill',
              amount: pillAmount,
              volume: 'auto',
            })} />
        )}
        {!condi && (
          <PackagingControlsItem
            label="Patches"
            amount={patchAmount}
            amountUnit="patches"
            sideNote="max 40u"
            onChangeAmount={(e, value) => this.setState({
              patchAmount: value,
            })}
            onCreate={() => act('create', {
              type: 'patch',
              amount: patchAmount,
              volume: 'auto',
            })} />
        )}
        {!condi && (
          <PackagingControlsItem
            label="Bottles"
            amount={bottleAmount}
            amountUnit="bottles"
            sideNote="max 30u"
            onChangeAmount={(e, value) => this.setState({
              bottleAmount: value,
            })}
            onCreate={() => act('create', {
              type: 'bottle',
              amount: bottleAmount,
              volume: 'auto',
            })} />
        )}
        {!condi && (
          <PackagingControlsItem
            label="Hypovials"
            amount={vialAmount}
            amountUnit="vials"
            sideNote="max 60u"
            onChangeAmount={(e, value) => this.setState({
              vialAmount: value,
            })}
            onCreate={() => act('create', {
              type: 'hypoVial',
              amount: vialAmount,
              volume: 'auto',
            })} />
        )}
        {!condi && (
          <PackagingControlsItem
            label="Smartdarts"
            amount={dartAmount}
            amountUnit="darts"
            sideNote="max 20u"
            onChangeAmount={(e, value) => this.setState({
              dartAmount: value,
            })}
            onCreate={() => act('create', {
              type: 'smartDart',
              amount: dartAmount,
              volume: 'auto',
            })} />
        )}
        {!!condi && (
          <PackagingControlsItem
            label="Packs"
            amount={packAmount}
            amountUnit="packs"
            sideNote="max 10u"
            onChangeAmount={(e, value) => this.setState({
              packAmount: value,
            })}
            onCreate={() => act('create', {
              type: 'condimentPack',
              amount: packAmount,
              volume: 'auto',
            })} />
        )}
        {!!condi && (
          <PackagingControlsItem
            label="Bottles"
            amount={bottleAmount}
            amountUnit="bottles"
            sideNote="max 50u"
            onChangeAmount={(e, value) => this.setState({
              bottleAmount: value,
            })}
            onCreate={() => act('create', {
              type: 'condimentBottle',
              amount: bottleAmount,
              volume: 'auto',
            })} />
        )}
      </LabeledList>
    );
  }
}
const PackagingControlsItem = (props, context) => {
  const {
    label, amountUnit, amount, onChangeAmount, onCreate, sideNote,
  } = props;
  return (
    <LabeledList.Item label={label}>
      <NumberInput
        width={14}
        unit={amountUnit}
        step={1}
        stepPixelSize={15}
        value={amount}
        minValue={1}
        maxValue={10}
        onChange={onChangeAmount} />
      <Button ml={1}
        content="Create"
        onClick={onCreate} />
      <Box inline ml={1}
        color="label"
        content={sideNote} />
    </LabeledList.Item>
  );
};
