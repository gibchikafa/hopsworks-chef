ALTER TABLE `hopsworks`.`on_demand_feature` DROP COLUMN `idx`;

ALTER TABLE `hopsworks`.`statistics_config` DROP COLUMN `exact_uniqueness`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ndb_backup` (
  `backup_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`backup_id`)
) ENGINE=ndbcluster DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_devices`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_devices` (
  `project_id` int(11) NOT NULL,
  `device_uuid` varchar(36) NOT NULL,
  `password` varchar(64) NOT NULL,
  `alias` varchar(80) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `last_logged_in` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`project_id`,`device_uuid`),
  CONSTRAINT `FK_284_533` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=ndbcluster DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_devices_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_devices_settings` (
  `project_id` int(11) NOT NULL,
  `jwt_secret` varchar(128) NOT NULL,
  `jwt_token_duration` int(11) NOT NULL,
  PRIMARY KEY (`project_id`),
  CONSTRAINT `FK_284_535` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=ndbcluster DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


ALTER TABLE `hopsworks`.`dataset_shared_with` DROP CONSTRAINT `fk_shared_by`;
ALTER TABLE `hopsworks`.`dataset_shared_with` DROP CONSTRAINT `fk_accepted_by`;

ALTER TABLE `hopsworks`.`dataset_shared_with` DROP COLUMN `shared_by`;

ALTER TABLE `hopsworks`.`dataset_shared_with` DROP COLUMN `accepted_by`;

DROP TABLE IF EXISTS `feature_store_code`;

ALTER TABLE `hopsworks`.`feature_store_snowflake_connector` DROP COLUMN `application`;

DROP TABLE IF EXISTS `hopsworks`.`alert_receiver`;

ALTER TABLE `hopsworks`.`project_service_alert` DROP FOREIGN KEY `fk_project_service_alert_1`, DROP COLUMN `receiver`;

ALTER TABLE `hopsworks`.`job_alert` DROP FOREIGN KEY `fk_job_alert_1`, DROP COLUMN `receiver`;

ALTER TABLE `hopsworks`.`feature_group_alert` DROP FOREIGN KEY `fk_feature_group_alert_1`, DROP COLUMN `receiver`;

DROP TABLE IF EXISTS `hopsworks`.`alert_receiver`;

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

ALTER TABLE `hopsworks`.`rstudio_settings` DROP COLUMN `docker_config`;
