CREATE TABLE `address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `address1` varchar(100) COLLATE latin1_general_cs DEFAULT '-',
  `address2` varchar(100) COLLATE latin1_general_cs DEFAULT '-',
  `address3` varchar(100) COLLATE latin1_general_cs DEFAULT '-',
  `city` varchar(40) COLLATE latin1_general_cs DEFAULT 'San Francisco',
  `state` varchar(50) COLLATE latin1_general_cs DEFAULT 'CA',
  `country` varchar(40) COLLATE latin1_general_cs DEFAULT 'US',
  `postalcode` varchar(10) COLLATE latin1_general_cs DEFAULT '-',
  PRIMARY KEY (`address_id`),
  KEY `uid` (`uid`),
  CONSTRAINT `FK_257_265` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=ndbcluster AUTO_INCREMENT=178 DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

CREATE TABLE `authorized_sshkeys` (
  `project` varchar(64) NOT NULL,
  `user` varchar(48) NOT NULL,
  `sshkey_name` varchar(64) NOT NULL,
  PRIMARY KEY (`project`,`user`,`sshkey_name`),
  KEY `idx_user` (`user`),
  KEY `idx_project` (`project`)
) ENGINE=ndbcluster DEFAULT CHARSET=latin1;

CREATE TABLE `ssh_keys` (
  `uid` int(11) NOT NULL,
  `name` varchar(255) COLLATE latin1_general_cs NOT NULL,
  `public_key` varchar(2000) COLLATE latin1_general_cs NOT NULL,
  PRIMARY KEY (`uid`,`name`),
  CONSTRAINT `FK_257_471` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=ndbcluster DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

CREATE TABLE `organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `org_name` varchar(100) COLLATE latin1_general_cs DEFAULT '-',
  `website` varchar(2083) COLLATE latin1_general_cs DEFAULT '-',
  `contact_person` varchar(100) COLLATE latin1_general_cs DEFAULT '-',
  `contact_email` varchar(150) COLLATE latin1_general_cs DEFAULT '-',
  `department` varchar(100) COLLATE latin1_general_cs DEFAULT '-',
  `phone` varchar(20) COLLATE latin1_general_cs DEFAULT '-',
  `fax` varchar(20) COLLATE latin1_general_cs DEFAULT '-',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `FK_257_380` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=ndbcluster AUTO_INCREMENT=178 DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

ALTER TABLE `users`
    ADD COLUMN `security_question` varchar(20) COLLATE latin1_general_cs DEFAULT NULL,
    ADD COLUMN `security_answer` varchar(128) COLLATE latin1_general_cs DEFAULT NULL,
    ADD COLUMN `mobile` varchar(15) COLLATE latin1_general_cs DEFAULT "-";

ALTER TABLE `hopsworks`.`feature_store_tag` ADD COLUMN `type` varchar(45) NOT NULL DEFAULT 'STRING';
ALTER TABLE `hopsworks`.`feature_store_tag` DROP COLUMN `tag_schema`;
DROP TABLE IF EXISTS `validation_rule`;
DROP TABLE IF EXISTS `feature_group_rule`;
DROP TABLE IF EXISTS `feature_group_validation`;
DROP TABLE IF EXISTS `feature_store_expectation_rule`;
ALTER TABLE `hopsworks`.`feature_group` DROP COLUMN `validation_type`;

ALTER TABLE `hopsworks`.`oauth_client` 
DROP COLUMN `end_session_endpoint`,
DROP COLUMN `logout_redirect_param`;

DROP TABLE `feature_store_activity`;

ALTER TABLE `hopsworks`.`feature_store_statistic` MODIFY `commit_time` VARCHAR(30) NOT NULL,
    DROP COLUMN `feature_group_commit_id`,
    DROP FOREIGN KEY `fg_ci_fk_fss`;

ALTER TABLE `hopsworks`.`training_dataset` DROP COLUMN `coalesce`;

ALTER TABLE `hopsworks`.`feature_store_connector` 
DROP FOREIGN KEY `fs_connector_snowflake_fk`,
DROP COLUMN `snowflake_id`;

DROP TABLE IF EXISTS `hopsworks`.`feature_store_snowflake_connector`;

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

ALTER TABLE `hopsworks`.`rstudio_project` DROP COLUMN `expires`;
