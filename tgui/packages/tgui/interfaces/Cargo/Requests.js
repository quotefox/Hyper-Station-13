import { Fragment } from 'inferno';
import { useBackend } from '../../backend';
import { Box, Button } from '../../components';

export const Requests = (props, context) => {
  const { data, act } = useBackend(context);
  const { 
    requestonly, 
  } = data;
  const requests = data.requests || [];

  if (requests.length === 0) {
    return (
      <Box color="good">
        No Requests
      </Box>
    );
  }
  
  // Labeled list reimplementation to squeeze extra columns out of it
  return (
    <table className="LabeledList">
      {requests.map(request => (
        <Fragment key={request.id}>
          <tr className="LabeledList__row candystripe">
            <td className="LabeledList__cell LabeledList__label">
              #{request.id}:
            </td>
            <td className="LabeledList__cell LabeledList__content">
              {request.object}
            </td>
            <td className="LabeledList__cell">
              By <b>{request.orderer}</b>
            </td>
            <td className="LabeledList__cell">
              <i>{request.reason}</i>
            </td>
            <td className="LabeledList__cell LabeledList__buttons">
              {request.cost} credits
              {' '}
              {!requestonly && (
                <Fragment>
                  <Button
                    icon="check"
                    color="good"
                    onClick={() => act('approve', {
                      id: request.id,
                    })} />
                  <Button
                    icon="times"
                    color="bad"
                    onClick={() => act('deny', {
                      id: request.id,
                    })} />
                </Fragment>
              )}
            </td>
          </tr>
        </Fragment>
      ))}
    </table>
  );
};
