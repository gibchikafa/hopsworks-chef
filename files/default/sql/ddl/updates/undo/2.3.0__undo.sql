DROP TABLE IF EXISTS `default_job_configuration`;
ALTER TABLE `hopsworks`.`validation_rule` DROP COLUMN `feature_type`;

DROP TABLE IF EXISTS `alert_manager_config`;
DROP TABLE IF EXISTS `job_alert`;
DROP TABLE IF EXISTS `feature_group_alert`;
DROP TABLE IF EXISTS `project_service_alert`;

ALTER TABLE `hopsworks`.`rstudio_settings`
    ADD COLUMN `num_tf_ps` int(11) DEFAULT '1',
    ADD COLUMN `num_tf_gpus` int(11) DEFAULT '0',
    ADD COLUMN `num_mpi_np` int(11) DEFAULT '1',
    ADD COLUMN `appmaster_cores` int(11) DEFAULT '1',
    ADD COLUMN `appmaster_memory` int(11) DEFAULT '1024',
    ADD COLUMN `num_executors` int(11) DEFAULT '1',
    ADD COLUMN `num_executor_cores` int(11) DEFAULT '1',
    ADD COLUMN `executor_memory` int(11) DEFAULT '1024',
    ADD COLUMN `dynamic_initial_executors` int(11) DEFAULT '1',
    ADD COLUMN `dynamic_min_executors` int(11) DEFAULT '1',
    ADD COLUMN `dynamic_max_executors` int(11) DEFAULT '1',
    ADD COLUMN `mode` varchar(32) COLLATE latin1_general_cs NOT NULL,
    ADD COLUMN `umask` varchar(32) COLLATE latin1_general_cs DEFAULT '022',
    ADD COLUMN `advanced` tinyint(1) DEFAULT '0',
    ADD COLUMN `archives` varchar(1500) COLLATE latin1_general_cs DEFAULT '',
    ADD COLUMN `jars` varchar(1500) COLLATE latin1_general_cs DEFAULT '',
    ADD COLUMN `files` varchar(1500) COLLATE latin1_general_cs DEFAULT '',
    ADD COLUMN `py_files` varchar(1500) COLLATE latin1_general_cs DEFAULT '',
    ADD COLUMN `spark_params` varchar(6500) COLLATE latin1_general_cs DEFAULT '';

ALTER TABLE `hopsworks`.`rstudio_project`
    ADD COLUMN `host_ip` varchar(255) COLLATE latin1_general_cs NOT NULL,
    ADD COLUMN `token` varchar(255) COLLATE latin1_general_cs NOT NULL;

ALTER TABLE `hopsworks`.`rstudio_project`
DROP COLUMN `expires`,
    DROP COLUMN `login_username`,
    DROP COLUMN `login_password`;

ALTER TABLE `hopsworks`.`rstudio_project` MODIFY COLUMN `pid` bigint(20) NOT NULL;

ALTER TABLE `hopsworks`.`rstudio_settings` DROP COLUMN `job_config`;
