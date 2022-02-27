import { useBackend } from '../backend';
import { Section } from '../components';
import { Window } from '../layouts';

export const StationAlertConsole = (props, context) => {
  const { data } = useBackend(context);
  const categories = data.alarms || [];
  const fire = categories['Fire'] || [];
  const atmos = categories['Atmosphere'] || [];
  const power = categories['Power'] || [];
  return (
    <Window>
      <Window.Content>
        <Section title="Fire Alarms">
          <ul>
            {fire.length === 0 && (
              <li className="color-good">
                Systems Nominal
              </li>
            )}
            {fire.map(alert => (
              <li key={alert} className="color-average">
                {alert}
              </li>
            ))}
          </ul>
        </Section>
        <Section title="Atmospherics Alarms">
          <ul>
            {atmos.length === 0 && (
              <li className="color-good">
                Systems Nominal
              </li>
            )}
            {atmos.map(alert => (
              <li key={alert} className="color-average">
                {alert}
              </li>
            ))}
          </ul>
        </Section>
        <Section title="Power Alarms">
          <ul>
            {power.length === 0 && (
              <li className="color-good">
                Systems Nominal
              </li>
            )}
            {power.map(alert => (
              <li key={alert} className="color-average">
                {alert}
              </li>
            ))}
          </ul>
        </Section>
      </Window.Content>
    </Window>
  );
};
