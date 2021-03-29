var alert_essentials = workflowContext.trigger.outputs.body.data.essentials;
var alert_context = workflowContext.trigger.outputs.body.data.alertContext;
var states = {"Resolved": "good", "Fired": "danger"};
var links = "";

for (let index = 0; index < alert_essentials.alertTargetIDs.length; index++) {
  const element = alert_essentials.alertTargetIDs[index];
  links = links + "- <https://portal.azure.com/#resource" +element  +"| " +element +"> \n"
}

return response = {
  "channel": "${slack_channel_id}",
  "username": "${slack_username}",
  "text": alert_essentials.monitorCondition +": " + alert_essentials.alertRule +" - " +alert_essentials.severity,
  "attachments": [
    {
      "color": states[alert_essentials.monitorCondition],
      "fields": [
        { "title": "Alarm Description", "value": alert_essentials,  "short": false },
        { "title": "Affected Target IDs", "value": links,  "short": false },
      ]
    }
  ]
}