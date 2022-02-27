import { Fragment } from 'inferno';
import { useBackend } from '../../backend';
import { Box, Button, LabeledList } from '../../components';

export const Cart = (props, context) => {
  const { cart } = props;
  const { config, data, act } = useBackend(context);
  const { ref } = config;
  return (
    <Fragment>
      {cart.length === 0 && 'Nothing in cart'}
      {cart.length > 0 && (
        <LabeledList>
          {cart.map(entry => (
            <LabeledList.Item
              key={entry.id}
              className="candystripe"
              label={'#' + entry.id}
              buttons={(
                <Fragment>
                  <Box inline mx={2}>
                    {!!entry.paid && (<b>[Paid Privately]</b>)}
                    {' '}
                    {entry.cost} credits
                  </Box>
                  <Button
                    icon="minus"
                    onClick={() => act(ref, 'remove', {
                      id: entry.id,
                    })} />
                </Fragment>
              )}>
              {entry.object}
            </LabeledList.Item>
          ))}
        </LabeledList>
      )}
      {cart.length > 0 && !data.requestonly && (
        <Box mt={2}>
          {data.away === 1 && data.docked === 1 && (
            <Button
              color="green"
              style={{
                'line-height': '28px',
                'padding': '0 12px',
              }}
              content="Confirm the order"
              onClick={() => act(ref, 'send')} />
          ) || (
            <Box opacity={0.5}>
              Shuttle in {data.location}.
            </Box>
          )}
        </Box>
      )}
    </Fragment>
  );
};
