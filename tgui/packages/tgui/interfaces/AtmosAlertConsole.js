import { useBackend } from '../backend';
import { Button, Section } from '../components';
import { Window } from '../layouts';

export const AtmosAlertConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const priorityAlerts = data.priority || [];
  const minorAlerts = data.minor || [];
  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section title="Alarms">
          <ul>
            {priorityAlerts.length > 0 ? (
              priorityAlerts.map(alert => (
                <li key={alert}>
                  <Button
                    icon="times"
                    content={alert}
                    color="bad"
                    onClick={() => act('clear', { zone: alert })} />
                </li>
              ))
            ) : (
              <li className="color-good">
                No Priority Alerts
              </li>
            )}
            {minorAlerts.length > 0 ? (
              minorAlerts.map(alert => (
                <li key={alert}>
                  <Button
                    icon="times"
                    content={alert}
                    color="average"
                    onClick={() => act('clear', { zone: alert })} />
                </li>
              ))
            ) : (
              <li className="color-good">
                No Minor Alerts
              </li>
            )}
          </ul>
        </Section>
      </Window.Content>
    </Window>
  );
};
