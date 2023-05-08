ALTER TABLE `hopsworks`.`project` ADD COLUMN `retention_period` date DEFAULT NULL,
  ADD COLUMN `archived` tinyint(1) DEFAULT '0',
  ADD COLUMN `logs` tinyint(1) DEFAULT '0',
  ADD COLUMN `deleted` tinyint(1) DEFAULT '0';

DROP TABLE IF EXISTS `hopsworks`.`hdfs_command_execution`;

ALTER TABLE `hopsworks`.`executions` MODIFY COLUMN `app_id` char(30) COLLATE latin1_general_cs DEFAULT NULL;

ALTER TABLE `hopsworks`.`maggy_driver` MODIFY COLUMN `app_id` char(30) COLLATE latin1_general_cs NOT NULL;

--
-- Table structure for table `shared_topics`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shared_topics` (
                                 `topic_name` varchar(255) COLLATE latin1_general_cs NOT NULL,
                                 `project_id` int(11) NOT NULL,
                                 `owner_id` int(11) NOT NULL,
                                 `accepted` tinyint(1) NOT NULL DEFAULT '0',
                                 PRIMARY KEY (`project_id`,`topic_name`),
                                 KEY `topic_idx` (`topic_name`,`owner_id`),
                                 CONSTRAINT `topic_idx_shared` FOREIGN KEY (`topic_name`,`owner_id`) REFERENCES `project_topics` (`topic_name`,`project_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=ndbcluster DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs
    /*!50100 PARTITION BY KEY (topic_name) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topic_acls`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_acls` (
                              `id` int(11) NOT NULL AUTO_INCREMENT,
                              `topic_name` varchar(255) COLLATE latin1_general_cs NOT NULL,
                              `project_id` int(11) NOT NULL,
                              `username` varchar(150) COLLATE latin1_general_cs NOT NULL,
                              `principal` varchar(170) COLLATE latin1_general_cs NOT NULL,
                              `permission_type` varchar(255) COLLATE latin1_general_cs NOT NULL,
                              `operation_type` varchar(255) COLLATE latin1_general_cs NOT NULL,
                              `host` varchar(255) COLLATE latin1_general_cs NOT NULL,
                              `role` varchar(255) COLLATE latin1_general_cs NOT NULL,
                              PRIMARY KEY (`id`),
                              KEY `username` (`username`),
                              KEY `topic_idx` (`topic_name`,`project_id`),
                              CONSTRAINT `FK_262_338` FOREIGN KEY (`username`) REFERENCES `users` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
                              CONSTRAINT `topic_idx_topic_acls` FOREIGN KEY (`topic_name`,`project_id`) REFERENCES `project_topics` (`topic_name`,`project_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=ndbcluster DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

ALTER TABLE `hopsworks`.`project_topics` DROP INDEX `topic_name_UNIQUE`;

SET SQL_SAFE_UPDATES = 0;
UPDATE `project_team`
SET team_role = 'Data scientist'
WHERE team_member = 'serving@hopsworks.se';
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE `hopsworks`.`cached_feature_group` ADD COLUMN `online_enabled` TINYINT(1) NULL;
ALTER TABLE `hopsworks`.`stream_feature_group` ADD COLUMN `online_enabled` TINYINT(1) NOT NULL DEFAULT 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE `hopsworks`.`cached_feature_group` `cfg` 
  INNER JOIN `feature_group` `fg` ON `fg`.`cached_feature_group_id` = `cfg`.`id`
SET `cfg`.`online_enabled` = `fg`.`online_enabled`;
UPDATE `hopsworks`.`stream_feature_group` `sfg` 
  INNER JOIN `feature_group` `fg` ON `fg`.`cached_feature_group_id` = `sfg`.`id`
SET `sfg`.`online_enabled` = `fg`.`online_enabled`;
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE `hopsworks`.`feature_group` DROP COLUMN `online_enabled`;
ALTER TABLE `hopsworks`.`on_demand_feature` DROP COLUMN `default_value`;