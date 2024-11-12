source ~/.bash_profile

source $commonConfigurationFilePath
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL


INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('', 'duplicate_reminder_table_name', 0, 'duplicate_device_detail', 0, 'duplicate_reminder', '', '', '');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('', 'duplicate_reminder_first_notification_days', 0, '1', 0, 'duplicate_reminder', '', '', '');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('', 'duplicate_reminder_second_notification_days', 0, '2', 0, 'duplicate_reminder', '', '', '');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('', 'duplicate_reminder_third_notification_days', 0, '3', 0, 'duplicate_reminder', '', '', '');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('', 'duplicate_reminder_where_clause', 0, "status='DUPLICATE'", 0, 'duplicate_reminder', '', '', '');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('', 'duplicate_reminder_notification_sms_start_time', 0, '09:00:00', 1, 'duplicate_reminder', '', '', '');

INSERT INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by)
VALUES ('', 'duplicate_reminder_notification_sms_end_time', 0, '18:00:00', 1, 'duplicate_reminder', '', '', '');

EOFMYSQL
