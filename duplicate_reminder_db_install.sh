#!/bin/bash
conf_file=${APP_HOME}/configuration/configuration.properties
typeset -A config # init array

while read line
do
    if echo $line | grep -F = &>/dev/null
    then
        varname=$(echo "$line" | cut -d '=' -f 1)
        config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
    fi
done < $conf_file
dbPassword=$(java -jar  ${APP_HOME}/utility/pass_dypt/pass_dypt.jar spring.datasource.password)
conn="mysql -h${config[dbIp]} -P${config[dbPort]} -u${config[dbUsername]} -p${dbPassword} ${config[appdbName]}"

`${conn} <<EOFMYSQL


INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('Name of the table from reminder process read records to send reminder message', 'duplicate_reminder_table_name', 0, 'duplicate_device_detail', 1, 'duplicate_reminder', NULL, 'system', 'system');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('1st reminder days', 'duplicate_reminder_first_notification_days', 0, '1',1, 'duplicate_reminder', NULL, 'system', 'system');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('2nd reminder days', 'duplicate_reminder_second_notification_days', 0, '2', 1, 'duplicate_reminder', NULL, 'system', 'system');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('3rd reminder days', 'duplicate_reminder_third_notification_days', 0, '3', 1, 'duplicate_reminder', NULL, 'system', 'system');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('Where clause of the query', 'duplicate_reminder_where_clause', 0, "status='DUPLICATE'", 1, 'duplicate_reminder', NULL, 'system', 'system');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('Notification send start time', 'duplicate_reminder_notification_sms_start_time', 0, '09:00', 1, 'duplicate_reminder', NULL, 'system', 'system');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('Notification send end time', 'duplicate_reminder_notification_sms_end_time', 0, '18:00', 1, 'duplicate_reminder', NULL, 'system', 'system');


INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remarks, user_type, modified_by, language)
VALUES ('First Reminder Notification as SMS Message sent to the public user for duplicate IMEI', 'duplicate_GenericReminder1Sms', NULL, 'First Reminder to <ACTUAL_IMEI> , <MSISDN> , <IMSI>  , <DATE_DD_MMM_YYYY>', 1, 'duplicate_reminder', NULL, 'system', 'system', 'en');


INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remarks, user_type, modified_by, language)
VALUES ('Second Reminder Notification as SMS Message sent to the public user for duplicate IMEI', 'duplicate_GenericReminder2Sms', NULL, 'Second Reminder to <ACTUAL_IMEI> , <MSISDN> , <IMSI>  , <DATE_DD_MMM_YYYY>', 1, 'duplicate_reminder', NULL, 'system', 'system', 'en');


INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remarks, user_type, modified_by, language)
VALUES ('Third Reminder Notification as SMS Message sent to the public user for duplicate IMEI', 'duplicate_GenericReminder3Sms', NULL, 'Third Reminder to <ACTUAL_IMEI> , <MSISDN> , <IMSI>  , <DATE_DD_MMM_YYYY>', 1, 'duplicate_reminder', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remarks, user_type, modified_by, language)
VALUES ('First Reminder Notification as SMS Message sent to the public user for duplicate IMEI', 'duplicate_GenericReminder1Sms', NULL, '', 1, 'duplicate_reminder', NULL, 'system', 'system', 'km');


INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remarks, user_type, modified_by, language)
VALUES ('Second Reminder Notification as SMS Message sent to the public user for duplicate IMEI', 'duplicate_GenericReminder2Sms', NULL, '', 1, 'duplicate_reminder', NULL, 'system', 'system', 'km');


INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remarks, user_type, modified_by, language)
VALUES ('Third Reminder Notification as SMS Message sent to the public user for duplicate IMEI', 'duplicate_GenericReminder3Sms', NULL, '', 1, 'duplicate_reminder', NULL, 'system', 'system', 'km');


EOFMYSQL`

echo "DB Script Execution Completed"
