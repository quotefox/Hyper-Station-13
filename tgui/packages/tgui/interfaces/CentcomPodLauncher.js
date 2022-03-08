import { multiline } from 'common/string';
import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';
import { CPLCloneMode } from './CentcomPodLauncher/CPLCloneMode';
import { CPLDamage } from './CentcomPodLauncher/CPLDamage';
import { CPLEffects } from './CentcomPodLauncher/CPLEffects';
import { CPLExplosion } from './CentcomPodLauncher/CPLExplosion';
import { CPLLaunchStyle } from './CentcomPodLauncher/CPLLaunchStyle';
import { CPLMovement } from './CentcomPodLauncher/CPLMovement';
import { CPLNameAndDescription } from './CentcomPodLauncher/CPLNameAndDescription';
import { CPLSound } from './CentcomPodLauncher/CPLSound';
import { CPLStyle } from './CentcomPodLauncher/CPLStyle';
import { CPLSupplyBay } from './CentcomPodLauncher/CPLSupplyBay';
import { CPLTeleportTo } from './CentcomPodLauncher/CPLTeleportTo';
import { CPLTimers } from './CentcomPodLauncher/CPLTimers';

// This is more or less a direct port from old tgui, with some slight
// text cleanup. But yes, it actually worked like this.
export const CentcomPodLauncher = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window resizable>
      <Window.Content>
        <NoticeBox>
          To use this, simply spawn the atoms you want in one of the five
          Centcom Supplypod Bays. Items in the bay will then be launched inside
          your supplypod, one turf-full at a time! You can optionally use the
          following buttons to configure how the supplypod acts.
        </NoticeBox>
        <Section
          // eslint-disable-next-line max-len
          title="Centcom Pod Customization (To be used against Helen Weinstein)">
          <LabeledList>
            <CPLSupplyBay />
            <CPLTeleportTo />
            <CPLCloneMode />
            <CPLLaunchStyle />
            <CPLExplosion />
            <CPLDamage />
            <CPLEffects />
            <CPLMovement />
            <CPLNameAndDescription />
            <CPLSound />
            <CPLTimers />
            <CPLStyle />
          </LabeledList>
        </Section>
        <Section>
          <LabeledList>
            <LabeledList.Item
              label={data.numObjects + ' turfs in ' + data.bay}
              buttons={(
                <Fragment>
                  <Button
                    content="undo Pod Bay"
                    tooltip={multiline`
                    Manually undoes the possible things to launch in the
                    pod bay.
                  `}
                    onClick={() => act('undo')} />
                  <Button
                    content="Enter Launch Mode"
                    selected={data.giveLauncher}
                    tooltip="THE CODEX ASTARTES CALLS THIS MANEUVER: STEEL RAIN"
                    onClick={() => act('giveLauncher')} />
                  <Button
                    content="Clear Selected Bay"
                    color="bad"
                    tooltip={multiline`
                    This will delete all objs and mobs from the selected bay.
                  `}
                    tooltipPosition="left"
                    onClick={() => act('clearBay')} />
                </Fragment>
              )} />
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};

