import { useBackend } from '../backend';
import { Box, Button, Divider, NoticeBox, Section, Table } from '../components';
import { NtosWindow } from '../layouts';

export const NtosFileManager = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    error,
    usbconnected,
    files = [],
    usbfiles = [],
  } = data;

  if (error) {
    return (
      <NtosWindow>
        <NtosWindow.Content scrollable>
          <NoticeBox danger>
            {error}
            <br />
            <i>Please try again. If the problem persists contact your system administrator for assistance.</i>
          </NoticeBox>  
        </NtosWindow.Content>
      </NtosWindow>
    );
  }

  return (
    <NtosWindow>
      <NtosWindow.Content scrollable>
        <Section title="Available files (local)">
          <Table>
            <Table.Row header>
              <Table.Cell>File name</Table.Cell>
              <Table.Cell>File type</Table.Cell>
              <Table.Cell>File size (GQ)</Table.Cell>
              <Table.Cell>Operations</Table.Cell>
            </Table.Row>
            {files.map(file => (
              <Table.Row key={file.name}>
                <Table.Cell>{file.name}</Table.Cell>
                <Table.Cell>.{file.type}</Table.Cell>
                <Table.Cell>{file.size}GQ</Table.Cell>
                <Table.Cell>
                  <Button
                    content="DELETE"
                    disabled={file.undeletable}
                    onClick={() => act('PRG_deletefile', { name: file.name })} />
                  <Button
                    content="RENAME"
                    disabled={file.undeletable}
                    onClick={() => act('PRG_rename', { name: file.name })} />
                  {!!usbconnected && (
                    <Button
                      content="EXPORT"
                      disabled={file.undeletable}
                      onClick={() => act('PRG_copytousb', { name: file.name })} />
                  )}
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
        {usbconnected && (
          <Section title="Available files (portable device)">
            <Table>
              <Table.Row header>
                <Table.Cell>File name</Table.Cell>
                <Table.Cell>File type</Table.Cell>
                <Table.Cell>File size (GQ)</Table.Cell>
                <Table.Cell>Operations</Table.Cell>
              </Table.Row>
              {usbfiles.map(file => (
                <Table.Row key={file.name}>
                  <Table.Cell>{file.name}</Table.Cell>
                  <Table.Cell>.{file.type}</Table.Cell>
                  <Table.Cell>{file.size}GQ</Table.Cell>
                  <Table.Cell>
                    <Button
                      content="DELETE"
                      disabled={file.undeletable}
                      onClick={() => act('PRG_usbdeletefile', { name: file.name })} />
                    <Button
                      content="RENAME"
                      disabled={file.undeletable}
                      onClick={() => act('PRG_usbrenamefile', { name: file.name })} />
                    <Button
                      content="IMPORT"
                      disabled={file.undeletable}
                      onClick={() => act('PRG_copyfromusb', { name: file.name })} />
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </Section>
        )}
      </NtosWindow.Content>
    </NtosWindow>
  );
};