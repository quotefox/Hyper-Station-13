import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { AnimatedNumber, Box, Button, LabeledList, Section, Tabs } from '../components';
import { Window } from '../layouts';
import { Cart } from './Cargo/Cart';
import { Catalog } from './Cargo/Catalog';
import { Requests } from './Cargo/Requests';

export const Cargo = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    requestonly,
    points,
    docked,
    location,
    message,
    loan,
    loan_dispatched,
    away,
  } = data;
  const cart = data.cart || [];
  const requests = data.requests || [];
  const supplies = Object.values(data.supplies);

  const [tab, setTab] = useLocalState(context, 'tab', 'catalog');

  const cartTotalAmount = cart
    .reduce((total, entry) => total + entry.cost, 0);

  const cartButtons = requestonly && (
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
        onClick={() => act('clear')} />
    </Fragment>
  );

  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section
          title="Cargo"
          buttons={(
            <Box inline bold>
              <AnimatedNumber value={Math.round(points)} /> credits
            </Box>
          )}>
          <LabeledList>
            <LabeledList.Item label="Shuttle">
              {docked && !requestonly && (
                <Button
                  content={location}
                  onClick={() => act('send')} />
              ) || location}
            </LabeledList.Item>
            <LabeledList.Item label="CentCom Message">
              {message}
            </LabeledList.Item>
            {(loan && !requestonly) ? (
              <LabeledList.Item label="Loan">
                {!loan_dispatched ? (
                  <Button
                    content="Loan Shuttle"
                    disabled={!(away && docked)}
                    onClick={() => act('loan')} />
                ) : (
                  <Box color="bad">Loaned to Centcom</Box>
                )}
              </LabeledList.Item>
            ) : ''}
          </LabeledList>
        </Section>
        <Tabs mt={2}>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 'catalog'}
            onClick={() => setTab('catalog')}>
            Catalog
          </Tabs.Tab>
          <Tabs.Tab
            icon="envelope"
            className={requests.length > 0 && tab !== 'requests' && 'color-yellow'}
            lineHeight="23px"
            selected={tab === 'requests'}
            onClick={() => setTab('requests')}>
            Requests ({requests.length})
          </Tabs.Tab>
          {!requestonly && (
            <Tabs.Tab
              icon="shopping-cart"
              className={cart.length > 0 && tab !== 'cart' && 'color-yellow'}
              lineHeight="23px"
              selected={tab === 'cart'}
              onClick={() => setTab('cart')}>
              Checkout ({cart.length})
            </Tabs.Tab>
          )}
        </Tabs>
        {tab === 'catalog' && (
          <Section
            title="Catalog"
            buttons={cartButtons}>
            <Catalog supplies={supplies} />
          </Section>
        )}
        {tab === 'requests' && (
          <Section
            title="Active Requests"
            buttons={!requestonly && (
              <Button
                icon="times"
                content="Clear"
                color="transparent"
                onClick={() => act('denyall')} />
            )}>
            <Requests />
          </Section>
        )}
        {tab === 'cart' && (
          <Section
            title="Current Cart"
            buttons={cartButtons}>
            <Cart />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};


