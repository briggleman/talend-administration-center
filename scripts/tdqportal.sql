DROP TABLE IF EXISTS tflowmetercatcher;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE tflowmetercatcher (
  moment DATETIME DEFAULT NULL,
  pid VARCHAR(20) DEFAULT NULL,
  father_pid VARCHAR(20) DEFAULT NULL,
  root_pid VARCHAR(20) DEFAULT NULL,
  system_pid BIGINT(8) DEFAULT NULL,
  project VARCHAR(50) DEFAULT NULL,
  job VARCHAR(50) DEFAULT NULL,
  job_repository_id VARCHAR(255) DEFAULT NULL,
  job_version VARCHAR(255) DEFAULT NULL,
  context VARCHAR(50) DEFAULT NULL,
  origin VARCHAR(255) DEFAULT NULL,
  label VARCHAR(255) DEFAULT NULL,
  count INT(3) DEFAULT NULL,
  reference INT(3) DEFAULT NULL,
  thresholds VARCHAR(255) DEFAULT NULL
);

DROP TABLE IF EXISTS tlogcatcher;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE tlogcatcher (
  moment datetime DEFAULT NULL,
  pid VARCHAR(20) DEFAULT NULL,
  root_pid VARCHAR(20) DEFAULT NULL,
  father_pid VARCHAR(20) DEFAULT NULL,
  project VARCHAR(50) DEFAULT NULL,
  job VARCHAR(255) DEFAULT NULL,
  context VARCHAR(50) DEFAULT NULL,
  priority INT(3) DEFAULT NULL,
  type VARCHAR(255) DEFAULT NULL,
  origin VARCHAR(255) DEFAULT NULL,
  message VARCHAR(255) DEFAULT NULL,
  code INT(3) DEFAULT NULL
);

DROP TABLE IF EXISTS tstatcatcher;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE tstatcatcher (
  moment datetime DEFAULT NULL,
  pid VARCHAR(20) DEFAULT NULL,
  father_pid VARCHAR(20) DEFAULT NULL,
  root_pid VARCHAR(20) DEFAULT NULL,
  system_pid BIGINT(8) DEFAULT NULL,
  project VARCHAR(50) DEFAULT NULL,
  job VARCHAR(50) DEFAULT NULL,
  job_repository_id VARCHAR(255) DEFAULT NULL,
  job_version VARCHAR(255) DEFAULT NULL,
  context VARCHAR(50) DEFAULT NULL,
  origin VARCHAR(255) DEFAULT NULL,
  message_type VARCHAR(255) DEFAULT NULL,
  message VARCHAR(255) DEFAULT NULL,
  duration BIGINT(8) DEFAULT NULL
);
