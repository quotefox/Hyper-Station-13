import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { AnimatedNumber, Box, Button, LabeledList, Section, Tabs } from '../components';
import { Window } from '../layouts';
import { Cart } from './Cargo/Cart';
import { Catalog } from './Cargo/Catalog';
import { Requests } from './Cargo/Requests';

export const Cargo = (props, context) => {
  const { config, data, act } = useBackend(context);
  const { ref } = config;
  const supplies = data.supplies || {};
  const requests = data.requests || [];
  const cart = data.cart || [];

  const cartTotalAmount = cart
    .reduce((total, entry) => total + entry.cost, 0);

  const cartButtons = !data.requestonly && (
    <Fragment>
      <Box inline mx={1}>
        {cart.length === 0 && 'Cart is empty'}
        {cart.length === 1 && '1 item'}
        {cart.length >= 2 && cart.length + ' items'}
        {' '}
        {cartTotalAmount > 0 && `(${cartTotalAmount} cr)`}
      </Box>
      <Button
        icon="times"
        color="transparent"
        content="Clear"
        onClick={() => act(ref, 'clear')} />
    </Fragment>
  );

  return (
    <Window>
      <Window.Content>
        <Section
          title="Cargo"
          buttons={(
            <Box inline bold>
              <AnimatedNumber value={Math.round(data.points)} /> credits
            </Box>
          )}>
          <LabeledList>
            <LabeledList.Item label="Shuttle">
              {data.docked && !data.requestonly && (
                <Button
                  content={data.location}
                  onClick={() => act(ref, 'send')} />
              ) || data.location}
            </LabeledList.Item>
            <LabeledList.Item label="CentCom Message">
              {data.message}
            </LabeledList.Item>
            {(data.loan && !data.requestonly) ? (
              <LabeledList.Item label="Loan">
                {!data.loan_dispatched ? (
                  <Button
                    content="Loan Shuttle"
                    disabled={!(data.away && data.docked)}
                    onClick={() => act(ref, 'loan')} />
                ) : (
                  <Box color="bad">Loaned to Centcom</Box>
                )}
              </LabeledList.Item>
            ) : ''}
          </LabeledList>
        </Section>
        <Tabs mt={2}>
          <Tabs.Tab
            key="catalog"
            label="Catalog"
            icon="list"
            lineHeight="23px">
            {() => (
              <Section
                title="Catalog"
                buttons={cartButtons}>
                <Catalog supplies={supplies} />
              </Section>
            )}
          </Tabs.Tab>
          <Tabs.Tab
            key="requests"
            label={`Requests (${requests.length})`}
            icon="envelope"
            highlight={requests.length > 0}
            lineHeight="23px">
            {() => (
              <Section
                title="Active Requests"
                buttons={!data.requestonly && (
                  <Button
                    icon="times"
                    content="Clear"
                    color="transparent"
                    onClick={() => act(ref, 'denyall')} />
                )}>
                <Requests requests={requests} />
              </Section>
            )}
          </Tabs.Tab>
          {!data.requestonly && (
            <Tabs.Tab
              key="cart"
              label={`Checkout (${cart.length})`}
              icon="shopping-cart"
              highlight={cart.length > 0}
              lineHeight="23px">
              {() => (
                <Section
                  title="Current Cart"
                  buttons={cartButtons}>
                  <Cart cart={cart} />
                </Section>
              )}
            </Tabs.Tab>
          )}
        </Tabs>
      </Window.Content>
    </Window>
  );
};


