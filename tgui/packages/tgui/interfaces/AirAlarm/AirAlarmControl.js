import { useBackend, useLocalState } from '../../backend';
import { Button, Section } from '../../components';
import { AirAlarmControlHome } from './AirAlarmControlHome';
import { AirAlarmControlModes } from './AirAlarmControlModes';
import { AirAlarmControlScrubbers } from './AirAlarmControlScrubbers';
import { AirAlarmControlThresholds } from './AirAlarmControlThresholds';
import { AirAlarmControlVents } from './AirAlarmControlVents';

export const AirAlarmControl = (props, context) => {
  const { config, data } = useBackend(context);
  const [currentPage, setCurrentPage] = useLocalState(context, "AirAlarmPage", "home");
  const route = AIR_ALARM_ROUTES[currentPage] || AIR_ALARM_ROUTES.home;
  const Component = route.component();
  return (
    <Section
      title={route.title}
      buttons={data.screen !== 'home' && (
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => setCurrentPage("home")} />
      )}>
      <Component />
    </Section>
  );
};


const AIR_ALARM_ROUTES = {
  home: {
    title: 'Air Controls',
    component: () => AirAlarmControlHome,
  },
  vents: {
    title: 'Vent Controls',
    component: () => AirAlarmControlVents,
  },
  scrubbers: {
    title: 'Scrubber Controls',
    component: () => AirAlarmControlScrubbers,
  },
  modes: {
    title: 'Operating Mode',
    component: () => AirAlarmControlModes,
  },
  thresholds: {
    title: 'Alarm Thresholds',
    component: () => AirAlarmControlThresholds,
  },
};