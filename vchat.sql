-- MySQL dump 10.13  Distrib 5.6.21, for Win64 (x86_64)
--
-- Host: localhost    Database: vchat
-- ------------------------------------------------------
-- Server version	5.6.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ofextcomponentconf`
--

DROP TABLE IF EXISTS `ofextcomponentconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofextcomponentconf` (
  `subdomain` varchar(255) NOT NULL,
  `wildcard` tinyint(4) NOT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `permission` varchar(10) NOT NULL,
  PRIMARY KEY (`subdomain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofextcomponentconf`
--

LOCK TABLES `ofextcomponentconf` WRITE;
/*!40000 ALTER TABLE `ofextcomponentconf` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofextcomponentconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofgroup`
--

DROP TABLE IF EXISTS `ofgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofgroup` (
  `groupName` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`groupName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofgroup`
--

LOCK TABLES `ofgroup` WRITE;
/*!40000 ALTER TABLE `ofgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofgroupprop`
--

DROP TABLE IF EXISTS `ofgroupprop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofgroupprop` (
  `groupName` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY (`groupName`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofgroupprop`
--

LOCK TABLES `ofgroupprop` WRITE;
/*!40000 ALTER TABLE `ofgroupprop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofgroupprop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofgroupuser`
--

DROP TABLE IF EXISTS `ofgroupuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofgroupuser` (
  `groupName` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `administrator` tinyint(4) NOT NULL,
  PRIMARY KEY (`groupName`,`username`,`administrator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofgroupuser`
--

LOCK TABLES `ofgroupuser` WRITE;
/*!40000 ALTER TABLE `ofgroupuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofgroupuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofid`
--

DROP TABLE IF EXISTS `ofid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofid` (
  `idType` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY (`idType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofid`
--

LOCK TABLES `ofid` WRITE;
/*!40000 ALTER TABLE `ofid` DISABLE KEYS */;
INSERT INTO `ofid` VALUES (18,21),(19,3),(23,1),(25,16),(26,2);
/*!40000 ALTER TABLE `ofid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofmucaffiliation`
--

DROP TABLE IF EXISTS `ofmucaffiliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofmucaffiliation` (
  `roomID` bigint(20) NOT NULL,
  `jid` text NOT NULL,
  `affiliation` tinyint(4) NOT NULL,
  PRIMARY KEY (`roomID`,`jid`(70))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofmucaffiliation`
--

LOCK TABLES `ofmucaffiliation` WRITE;
/*!40000 ALTER TABLE `ofmucaffiliation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofmucaffiliation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofmucconversationlog`
--

DROP TABLE IF EXISTS `ofmucconversationlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofmucconversationlog` (
  `roomID` bigint(20) NOT NULL,
  `sender` text NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `logTime` char(15) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `body` text,
  KEY `ofMucConversationLog_time_idx` (`logTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofmucconversationlog`
--

LOCK TABLES `ofmucconversationlog` WRITE;
/*!40000 ALTER TABLE `ofmucconversationlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofmucconversationlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofmucmember`
--

DROP TABLE IF EXISTS `ofmucmember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofmucmember` (
  `roomID` bigint(20) NOT NULL,
  `jid` text NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `faqentry` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`roomID`,`jid`(70))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofmucmember`
--

LOCK TABLES `ofmucmember` WRITE;
/*!40000 ALTER TABLE `ofmucmember` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofmucmember` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofmucroom`
--

DROP TABLE IF EXISTS `ofmucroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofmucroom` (
  `serviceID` bigint(20) NOT NULL,
  `roomID` bigint(20) NOT NULL,
  `creationDate` char(15) NOT NULL,
  `modificationDate` char(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `naturalName` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `lockedDate` char(15) NOT NULL,
  `emptyDate` char(15) DEFAULT NULL,
  `canChangeSubject` tinyint(4) NOT NULL,
  `maxUsers` int(11) NOT NULL,
  `publicRoom` tinyint(4) NOT NULL,
  `moderated` tinyint(4) NOT NULL,
  `membersOnly` tinyint(4) NOT NULL,
  `canInvite` tinyint(4) NOT NULL,
  `roomPassword` varchar(50) DEFAULT NULL,
  `canDiscoverJID` tinyint(4) NOT NULL,
  `logEnabled` tinyint(4) NOT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `rolesToBroadcast` tinyint(4) NOT NULL,
  `useReservedNick` tinyint(4) NOT NULL,
  `canChangeNick` tinyint(4) NOT NULL,
  `canRegister` tinyint(4) NOT NULL,
  PRIMARY KEY (`serviceID`,`name`),
  KEY `ofMucRoom_roomid_idx` (`roomID`),
  KEY `ofMucRoom_serviceid_idx` (`serviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofmucroom`
--

LOCK TABLES `ofmucroom` WRITE;
/*!40000 ALTER TABLE `ofmucroom` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofmucroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofmucroomprop`
--

DROP TABLE IF EXISTS `ofmucroomprop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofmucroomprop` (
  `roomID` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY (`roomID`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofmucroomprop`
--

LOCK TABLES `ofmucroomprop` WRITE;
/*!40000 ALTER TABLE `ofmucroomprop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofmucroomprop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofmucservice`
--

DROP TABLE IF EXISTS `ofmucservice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofmucservice` (
  `serviceID` bigint(20) NOT NULL,
  `subdomain` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isHidden` tinyint(4) NOT NULL,
  PRIMARY KEY (`subdomain`),
  KEY `ofMucService_serviceid_idx` (`serviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofmucservice`
--

LOCK TABLES `ofmucservice` WRITE;
/*!40000 ALTER TABLE `ofmucservice` DISABLE KEYS */;
INSERT INTO `ofmucservice` VALUES (1,'conference',NULL,0);
/*!40000 ALTER TABLE `ofmucservice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofmucserviceprop`
--

DROP TABLE IF EXISTS `ofmucserviceprop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofmucserviceprop` (
  `serviceID` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY (`serviceID`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofmucserviceprop`
--

LOCK TABLES `ofmucserviceprop` WRITE;
/*!40000 ALTER TABLE `ofmucserviceprop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofmucserviceprop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofoffline`
--

DROP TABLE IF EXISTS `ofoffline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofoffline` (
  `username` varchar(64) NOT NULL,
  `messageID` bigint(20) NOT NULL,
  `creationDate` char(15) NOT NULL,
  `messageSize` int(11) NOT NULL,
  `stanza` text NOT NULL,
  PRIMARY KEY (`username`,`messageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofoffline`
--

LOCK TABLES `ofoffline` WRITE;
/*!40000 ALTER TABLE `ofoffline` DISABLE KEYS */;
INSERT INTO `ofoffline` VALUES ('15999999000',1,'001417850458527',204,'<message id=\"PyVmC-31\" to=\"15999999000@localhost\" from=\"15999843546@localhost/Spark 2.6.3\" type=\"chat\"><body>123</body><thread>E64OOJ</thread><x xmlns=\"jabber:x:event\"><offline/><composing/></x></message>'),('15999999000',2,'001417850487317',128,'<message id=\"PyVmC-32\" to=\"15999999000@localhost\" from=\"15999843546@localhost/Spark 2.6.3\"><x xmlns=\"jabber:x:event\"/></message>');
/*!40000 ALTER TABLE `ofoffline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofpresence`
--

DROP TABLE IF EXISTS `ofpresence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofpresence` (
  `username` varchar(64) NOT NULL,
  `offlinePresence` text,
  `offlineDate` char(15) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofpresence`
--

LOCK TABLES `ofpresence` WRITE;
/*!40000 ALTER TABLE `ofpresence` DISABLE KEYS */;
INSERT INTO `ofpresence` VALUES ('15999843546',NULL,'001418035082056'),('15999999000',NULL,'001417767055646'),('15999999010','<presence id=\"PQl30-30\" type=\"unavailable\" from=\"15999999010@localhost/Spark 2.6.3\"><x xmlns=\"vcard-temp:x:update\"><photo>c5fe2e62f478ec4cbe2f200a689ef6c7653508d9</photo></x><x xmlns=\"jabber:x:avatar\"><hash>c5fe2e62f478ec4cbe2f200a689ef6c7653508d9</hash></x></presence>','001418204189610'),('15999999011','<presence id=\"ye8Gu-30\" type=\"unavailable\" from=\"15999999011@localhost/Spark 2.6.3\"><x xmlns=\"vcard-temp:x:update\"><photo>2027c62d0d2de61de80fa32e433a4a3fbfccb083</photo></x><x xmlns=\"jabber:x:avatar\"><hash>2027c62d0d2de61de80fa32e433a4a3fbfccb083</hash></x></presence>','001418204214041');
/*!40000 ALTER TABLE `ofpresence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofprivacylist`
--

DROP TABLE IF EXISTS `ofprivacylist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofprivacylist` (
  `username` varchar(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `isDefault` tinyint(4) NOT NULL,
  `list` text NOT NULL,
  PRIMARY KEY (`username`,`name`),
  KEY `ofPrivacyList_default_idx` (`username`,`isDefault`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofprivacylist`
--

LOCK TABLES `ofprivacylist` WRITE;
/*!40000 ALTER TABLE `ofprivacylist` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofprivacylist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofprivate`
--

DROP TABLE IF EXISTS `ofprivate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofprivate` (
  `username` varchar(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `namespace` varchar(200) NOT NULL,
  `privateData` text NOT NULL,
  PRIMARY KEY (`username`,`name`,`namespace`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofprivate`
--

LOCK TABLES `ofprivate` WRITE;
/*!40000 ALTER TABLE `ofprivate` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofprivate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofproperty`
--

DROP TABLE IF EXISTS `ofproperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofproperty` (
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofproperty`
--

LOCK TABLES `ofproperty` WRITE;
/*!40000 ALTER TABLE `ofproperty` DISABLE KEYS */;
INSERT INTO `ofproperty` VALUES ('passwordKey','EQ153H099zDK931'),('provider.admin.className','org.jivesoftware.openfire.admin.DefaultAdminProvider'),('provider.auth.className','org.jivesoftware.openfire.auth.DefaultAuthProvider'),('provider.group.className','org.jivesoftware.openfire.group.DefaultGroupProvider'),('provider.lockout.className','org.jivesoftware.openfire.lockout.DefaultLockOutProvider'),('provider.securityAudit.className','org.jivesoftware.openfire.security.DefaultSecurityAuditProvider'),('provider.user.className','org.jivesoftware.openfire.user.DefaultUserProvider'),('provider.vcard.className','org.jivesoftware.openfire.vcard.DefaultVCardProvider'),('update.lastCheck','1421226833163'),('xmpp.auth.anonymous','true'),('xmpp.domain','localhost'),('xmpp.session.conflict-limit','0'),('xmpp.socket.ssl.active','true');
/*!40000 ALTER TABLE `ofproperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofpubsubaffiliation`
--

DROP TABLE IF EXISTS `ofpubsubaffiliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofpubsubaffiliation` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `jid` varchar(255) NOT NULL,
  `affiliation` varchar(10) NOT NULL,
  PRIMARY KEY (`serviceID`,`nodeID`,`jid`(70))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofpubsubaffiliation`
--

LOCK TABLES `ofpubsubaffiliation` WRITE;
/*!40000 ALTER TABLE `ofpubsubaffiliation` DISABLE KEYS */;
INSERT INTO `ofpubsubaffiliation` VALUES ('pubsub','','localhost','owner');
/*!40000 ALTER TABLE `ofpubsubaffiliation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofpubsubdefaultconf`
--

DROP TABLE IF EXISTS `ofpubsubdefaultconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofpubsubdefaultconf` (
  `serviceID` varchar(100) NOT NULL,
  `leaf` tinyint(4) NOT NULL,
  `deliverPayloads` tinyint(4) NOT NULL,
  `maxPayloadSize` int(11) NOT NULL,
  `persistItems` tinyint(4) NOT NULL,
  `maxItems` int(11) NOT NULL,
  `notifyConfigChanges` tinyint(4) NOT NULL,
  `notifyDelete` tinyint(4) NOT NULL,
  `notifyRetract` tinyint(4) NOT NULL,
  `presenceBased` tinyint(4) NOT NULL,
  `sendItemSubscribe` tinyint(4) NOT NULL,
  `publisherModel` varchar(15) NOT NULL,
  `subscriptionEnabled` tinyint(4) NOT NULL,
  `accessModel` varchar(10) NOT NULL,
  `language` varchar(255) DEFAULT NULL,
  `replyPolicy` varchar(15) DEFAULT NULL,
  `associationPolicy` varchar(15) NOT NULL,
  `maxLeafNodes` int(11) NOT NULL,
  PRIMARY KEY (`serviceID`,`leaf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofpubsubdefaultconf`
--

LOCK TABLES `ofpubsubdefaultconf` WRITE;
/*!40000 ALTER TABLE `ofpubsubdefaultconf` DISABLE KEYS */;
INSERT INTO `ofpubsubdefaultconf` VALUES ('pubsub',0,0,0,0,0,1,1,1,0,0,'publishers',1,'open','English',NULL,'all',-1),('pubsub',1,1,5120,0,-1,1,1,1,0,1,'publishers',1,'open','English',NULL,'all',-1);
/*!40000 ALTER TABLE `ofpubsubdefaultconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofpubsubitem`
--

DROP TABLE IF EXISTS `ofpubsubitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofpubsubitem` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `id` varchar(100) NOT NULL,
  `jid` varchar(255) NOT NULL,
  `creationDate` char(15) NOT NULL,
  `payload` mediumtext,
  PRIMARY KEY (`serviceID`,`nodeID`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofpubsubitem`
--

LOCK TABLES `ofpubsubitem` WRITE;
/*!40000 ALTER TABLE `ofpubsubitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofpubsubitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofpubsubnode`
--

DROP TABLE IF EXISTS `ofpubsubnode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofpubsubnode` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `leaf` tinyint(4) NOT NULL,
  `creationDate` char(15) NOT NULL,
  `modificationDate` char(15) NOT NULL,
  `parent` varchar(100) DEFAULT NULL,
  `deliverPayloads` tinyint(4) NOT NULL,
  `maxPayloadSize` int(11) DEFAULT NULL,
  `persistItems` tinyint(4) DEFAULT NULL,
  `maxItems` int(11) DEFAULT NULL,
  `notifyConfigChanges` tinyint(4) NOT NULL,
  `notifyDelete` tinyint(4) NOT NULL,
  `notifyRetract` tinyint(4) NOT NULL,
  `presenceBased` tinyint(4) NOT NULL,
  `sendItemSubscribe` tinyint(4) NOT NULL,
  `publisherModel` varchar(15) NOT NULL,
  `subscriptionEnabled` tinyint(4) NOT NULL,
  `configSubscription` tinyint(4) NOT NULL,
  `accessModel` varchar(10) NOT NULL,
  `payloadType` varchar(100) DEFAULT NULL,
  `bodyXSLT` varchar(100) DEFAULT NULL,
  `dataformXSLT` varchar(100) DEFAULT NULL,
  `creator` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `replyPolicy` varchar(15) DEFAULT NULL,
  `associationPolicy` varchar(15) DEFAULT NULL,
  `maxLeafNodes` int(11) DEFAULT NULL,
  PRIMARY KEY (`serviceID`,`nodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofpubsubnode`
--

LOCK TABLES `ofpubsubnode` WRITE;
/*!40000 ALTER TABLE `ofpubsubnode` DISABLE KEYS */;
INSERT INTO `ofpubsubnode` VALUES ('pubsub','',0,'001417069640507','001417069640507',NULL,0,0,0,0,1,1,1,0,0,'publishers',1,0,'open','','','','localhost','','English','',NULL,'all',-1);
/*!40000 ALTER TABLE `ofpubsubnode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofpubsubnodegroups`
--

DROP TABLE IF EXISTS `ofpubsubnodegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofpubsubnodegroups` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `rosterGroup` varchar(100) NOT NULL,
  KEY `ofPubsubNodeGroups_idx` (`serviceID`,`nodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofpubsubnodegroups`
--

LOCK TABLES `ofpubsubnodegroups` WRITE;
/*!40000 ALTER TABLE `ofpubsubnodegroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofpubsubnodegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofpubsubnodejids`
--

DROP TABLE IF EXISTS `ofpubsubnodejids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofpubsubnodejids` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `jid` varchar(255) NOT NULL,
  `associationType` varchar(20) NOT NULL,
  PRIMARY KEY (`serviceID`,`nodeID`,`jid`(70))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofpubsubnodejids`
--

LOCK TABLES `ofpubsubnodejids` WRITE;
/*!40000 ALTER TABLE `ofpubsubnodejids` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofpubsubnodejids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofpubsubsubscription`
--

DROP TABLE IF EXISTS `ofpubsubsubscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofpubsubsubscription` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `id` varchar(100) NOT NULL,
  `jid` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `state` varchar(15) NOT NULL,
  `deliver` tinyint(4) NOT NULL,
  `digest` tinyint(4) NOT NULL,
  `digest_frequency` int(11) NOT NULL,
  `expire` char(15) DEFAULT NULL,
  `includeBody` tinyint(4) NOT NULL,
  `showValues` varchar(30) DEFAULT NULL,
  `subscriptionType` varchar(10) NOT NULL,
  `subscriptionDepth` tinyint(4) NOT NULL,
  `keyword` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`serviceID`,`nodeID`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofpubsubsubscription`
--

LOCK TABLES `ofpubsubsubscription` WRITE;
/*!40000 ALTER TABLE `ofpubsubsubscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofpubsubsubscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofremoteserverconf`
--

DROP TABLE IF EXISTS `ofremoteserverconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofremoteserverconf` (
  `xmppDomain` varchar(255) NOT NULL,
  `remotePort` int(11) DEFAULT NULL,
  `permission` varchar(10) NOT NULL,
  PRIMARY KEY (`xmppDomain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofremoteserverconf`
--

LOCK TABLES `ofremoteserverconf` WRITE;
/*!40000 ALTER TABLE `ofremoteserverconf` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofremoteserverconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofroster`
--

DROP TABLE IF EXISTS `ofroster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofroster` (
  `rosterID` bigint(20) NOT NULL,
  `username` varchar(64) NOT NULL,
  `jid` varchar(1024) NOT NULL,
  `sub` tinyint(4) NOT NULL,
  `ask` tinyint(4) NOT NULL,
  `recv` tinyint(4) NOT NULL,
  `nick` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rosterID`),
  KEY `ofRoster_unameid_idx` (`username`),
  KEY `ofRoster_jid_idx` (`jid`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofroster`
--

LOCK TABLES `ofroster` WRITE;
/*!40000 ALTER TABLE `ofroster` DISABLE KEYS */;
INSERT INTO `ofroster` VALUES (1,'15999999000','15999999000',0,-1,-1,NULL),(8,'15999999000','15999843546@localhost',3,-1,-1,'15999843546'),(9,'15999843546','15999999000@localhost',3,-1,-1,'bigTom'),(11,'15999843546','15999999010@localhost',3,-1,-1,'num10'),(12,'15999999010','15999843546@localhost',3,-1,-1,'15999843546'),(13,'15999843546','15999999011@localhost',3,-1,-1,'num11'),(14,'15999999011','15999843546@localhost',3,-1,-1,'15999843546'),(15,'15999843546','15999999012@localhost',3,-1,-1,'num12'),(16,'15999999012','15999843546@localhost',3,-1,-1,'15999843546');
/*!40000 ALTER TABLE `ofroster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofrostergroups`
--

DROP TABLE IF EXISTS `ofrostergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofrostergroups` (
  `rosterID` bigint(20) NOT NULL,
  `rank` tinyint(4) NOT NULL,
  `groupName` varchar(255) NOT NULL,
  PRIMARY KEY (`rosterID`,`rank`),
  KEY `ofRosterGroup_rosterid_idx` (`rosterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofrostergroups`
--

LOCK TABLES `ofrostergroups` WRITE;
/*!40000 ALTER TABLE `ofrostergroups` DISABLE KEYS */;
INSERT INTO `ofrostergroups` VALUES (8,0,'Friends'),(9,0,'Friends'),(11,0,'Friends'),(12,0,'Friends'),(13,0,'Friends'),(14,0,'Friends'),(15,0,'Friends'),(16,0,'Friends');
/*!40000 ALTER TABLE `ofrostergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofsaslauthorized`
--

DROP TABLE IF EXISTS `ofsaslauthorized`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofsaslauthorized` (
  `username` varchar(64) NOT NULL,
  `principal` text NOT NULL,
  PRIMARY KEY (`username`,`principal`(200))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofsaslauthorized`
--

LOCK TABLES `ofsaslauthorized` WRITE;
/*!40000 ALTER TABLE `ofsaslauthorized` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofsaslauthorized` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofsecurityauditlog`
--

DROP TABLE IF EXISTS `ofsecurityauditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofsecurityauditlog` (
  `msgID` bigint(20) NOT NULL,
  `username` varchar(64) NOT NULL,
  `entryStamp` bigint(20) NOT NULL,
  `summary` varchar(255) NOT NULL,
  `node` varchar(255) NOT NULL,
  `details` text,
  PRIMARY KEY (`msgID`),
  KEY `ofSecurityAuditLog_tstamp_idx` (`entryStamp`),
  KEY `ofSecurityAuditLog_uname_idx` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofsecurityauditlog`
--

LOCK TABLES `ofsecurityauditlog` WRITE;
/*!40000 ALTER TABLE `ofsecurityauditlog` DISABLE KEYS */;
INSERT INTO `ofsecurityauditlog` VALUES (1,'admin',1417069732352,'created new user tom','H6M6CIH9R8A87AT','name = tom, email = null, admin = false'),(2,'admin',1417069754840,'deleted user tom','H6M6CIH9R8A87AT','full jid was tom@localhost'),(3,'admin',1417426059216,'created new user 15999843546','H6M6CIH9R8A87AT','name = snake, email = 123@163.com, admin = false'),(4,'admin',1417426089590,'created new user 15999999000','H6M6CIH9R8A87AT','name = Tom, email = null, admin = false'),(5,'admin',1417426109389,'created new user 15999999001','H6M6CIH9R8A87AT','name = May, email = null, admin = false'),(6,'admin',1417426126714,'created new user 15999999002','H6M6CIH9R8A87AT','name = Jay, email = null, admin = false'),(7,'admin',1417426161136,'created new user 15999999003','H6M6CIH9R8A87AT','name = Ben, email = null, admin = false'),(8,'admin',1417426179296,'created new user 15999999004','H6M6CIH9R8A87AT','name = Jason, email = null, admin = false'),(9,'admin',1417849603748,'added roster item for 15999999000','H6M6CIH9R8A87AT','roster item:\njid = 15999999000\nnickname = null\ngroupList = []'),(10,'admin',1417849608223,'added roster item for 15999999000','H6M6CIH9R8A87AT','roster item:\njid = 1361\nnickname = null\ngroupList = []'),(11,'admin',1417849991934,'deleted roster item from 15999999000','H6M6CIH9R8A87AT','roster item:\njid = 1361'),(12,'admin',1418089494371,'deleted user 15999999010','H6M6CIH9R8A87AT','full jid was 15999999010@localhost'),(13,'admin',1418195107184,'deleted user 1599999012','H6M6CIH9R8A87AT','full jid was 1599999012@localhost'),(14,'admin',1418195125250,'deleted user 15999999010','H6M6CIH9R8A87AT','full jid was 15999999010@localhost'),(15,'admin',1418195128467,'deleted user 15999999011','H6M6CIH9R8A87AT','full jid was 15999999011@localhost');
/*!40000 ALTER TABLE `ofsecurityauditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofuser`
--

DROP TABLE IF EXISTS `ofuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofuser` (
  `username` varchar(64) NOT NULL,
  `plainPassword` varchar(32) DEFAULT NULL,
  `encryptedPassword` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `creationDate` char(15) NOT NULL,
  `modificationDate` char(15) NOT NULL,
  PRIMARY KEY (`username`),
  KEY `ofUser_cDate_idx` (`creationDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofuser`
--

LOCK TABLES `ofuser` WRITE;
/*!40000 ALTER TABLE `ofuser` DISABLE KEYS */;
INSERT INTO `ofuser` VALUES ('15999843546',NULL,'2dd7e6d149e529996470a59bcc8fe63d','snake','123@163.com','001417426059080','001417426059080'),('15999999000',NULL,'27676b2ef1f41b66950f94a5b619f7e6','Tom',NULL,'001417426089456','001417426089456'),('15999999001',NULL,'ed83fba8d9821ce0dd557f6269995b42','May',NULL,'001417426109307','001417426109307'),('15999999002',NULL,'c7b77ef5550aa6d01dba7e252d11dbfb','Jay',NULL,'001417426126588','001417426126588'),('15999999003',NULL,'1f7972800b6909d9fb030e631f205961','Ben',NULL,'001417426161099','001417426161099'),('15999999004',NULL,'8c5eb18d9c282d9cde3e3f9da118e679','Jason',NULL,'001417426179225','001417426179225'),('15999999010',NULL,'08f894a70097aac249c29c506f63fca9',NULL,NULL,'001418195174951','001418195174951'),('15999999011',NULL,'cece3d25074f042263d8736ea4eb5672',NULL,NULL,'001418202868417','001418202868417'),('15999999012',NULL,'3c247a3a337b41ed6aa507e165a1db5c',NULL,NULL,'001418202889292','001418202889292'),('admin','admin',NULL,'Administrator','admin@example.com','0','0');
/*!40000 ALTER TABLE `ofuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofuserflag`
--

DROP TABLE IF EXISTS `ofuserflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofuserflag` (
  `username` varchar(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `startTime` char(15) DEFAULT NULL,
  `endTime` char(15) DEFAULT NULL,
  PRIMARY KEY (`username`,`name`),
  KEY `ofUserFlag_sTime_idx` (`startTime`),
  KEY `ofUserFlag_eTime_idx` (`endTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofuserflag`
--

LOCK TABLES `ofuserflag` WRITE;
/*!40000 ALTER TABLE `ofuserflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofuserflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofuserprop`
--

DROP TABLE IF EXISTS `ofuserprop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofuserprop` (
  `username` varchar(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY (`username`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofuserprop`
--

LOCK TABLES `ofuserprop` WRITE;
/*!40000 ALTER TABLE `ofuserprop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofuserprop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofvcard`
--

DROP TABLE IF EXISTS `ofvcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofvcard` (
  `username` varchar(64) NOT NULL,
  `vcard` mediumtext NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofvcard`
--

LOCK TABLES `ofvcard` WRITE;
/*!40000 ALTER TABLE `ofvcard` DISABLE KEYS */;
INSERT INTO `ofvcard` VALUES ('15999999000','<vCard xmlns=\"vcard-temp\"><N><FAMILY/>\n<GIVEN/>\n<MIDDLE/>\n</N>\n<ORG><ORGNAME/>\n<ORGUNIT/>\n</ORG>\n<FN/>\n<URL/>\n<TITLE/>\n<NICKNAME>Tom</NICKNAME>\n<EMAIL><HOME/><INTERNET/><PREF/><USERID/>\n</EMAIL>\n<TEL><PAGER/><WORK/><NUMBER/>\n</TEL>\n<TEL><CELL/><WORK/><NUMBER/>\n</TEL>\n<TEL><VOICE/><WORK/><NUMBER/>\n</TEL>\n<TEL><FAX/><WORK/><NUMBER/>\n</TEL>\n<TEL><PAGER/><HOME/><NUMBER/>\n</TEL>\n<TEL><CELL/><HOME/><NUMBER/>\n</TEL>\n<TEL><VOICE/><HOME/><NUMBER/>\n</TEL>\n<TEL><FAX/><HOME/><NUMBER/>\n</TEL>\n<ADR><WORK/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n<ADR><HOME/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n</vCard>'),('15999999010','<vCard xmlns=\"vcard-temp\"><N><FAMILY/>\n<GIVEN/>\n<MIDDLE/>\n</N>\n<ORG><ORGNAME/>\n<ORGUNIT/>\n</ORG>\n<FN/>\n<URL/>\n<TITLE/>\n<NICKNAME>num10</NICKNAME>\n<PHOTO><TYPE>image/jpeg</TYPE><BINVAL>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</BINVAL></PHOTO>\n<EMAIL><HOME/><INTERNET/><PREF/><USERID/>\n</EMAIL>\n<TEL><PAGER/><WORK/><NUMBER/>\n</TEL>\n<TEL><CELL/><WORK/><NUMBER/>\n</TEL>\n<TEL><VOICE/><WORK/><NUMBER/>\n</TEL>\n<TEL><FAX/><WORK/><NUMBER/>\n</TEL>\n<TEL><PAGER/><HOME/><NUMBER/>\n</TEL>\n<TEL><CELL/><HOME/><NUMBER/>\n</TEL>\n<TEL><VOICE/><HOME/><NUMBER/>\n</TEL>\n<TEL><FAX/><HOME/><NUMBER/>\n</TEL>\n<ADR><WORK/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n<ADR><HOME/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n</vCard>'),('15999999011','<vCard xmlns=\"vcard-temp\"><N><FAMILY/>\n<GIVEN/>\n<MIDDLE/>\n</N>\n<ORG><ORGNAME/>\n<ORGUNIT/>\n</ORG>\n<FN/>\n<URL/>\n<TITLE/>\n<NICKNAME>num11</NICKNAME>\n<PHOTO><TYPE>image/jpeg</TYPE><BINVAL>iVBORw0KGgoAAAANSUhEUgAAAcUAAAHFCAYAAACDweKEAAAACXBIWXMAAAsTAAALEwEAmpwYAAAKT2lDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVNnVFPpFj333vRCS4iAlEtvUhUIIFJCi4AUkSYqIQkQSoghodkVUcERRUUEG8igiAOOjoCMFVEsDIoK2AfkIaKOg6OIisr74Xuja9a89+bN/rXXPues852zzwfACAyWSDNRNYAMqUIeEeCDx8TG4eQuQIEKJHAAEAizZCFz/SMBAPh+PDwrIsAHvgABeNMLCADATZvAMByH/w/qQplcAYCEAcB0kThLCIAUAEB6jkKmAEBGAYCdmCZTAKAEAGDLY2LjAFAtAGAnf+bTAICd+Jl7AQBblCEVAaCRACATZYhEAGg7AKzPVopFAFgwABRmS8Q5ANgtADBJV2ZIALC3AMDOEAuyAAgMADBRiIUpAAR7AGDIIyN4AISZABRG8lc88SuuEOcqAAB4mbI8uSQ5RYFbCC1xB1dXLh4ozkkXKxQ2YQJhmkAuwnmZGTKBNA/g88wAAKCRFRHgg/P9eM4Ors7ONo62Dl8t6r8G/yJiYuP+5c+rcEAAAOF0ftH+LC+zGoA7BoBt/qIl7gRoXgugdfeLZrIPQLUAoOnaV/Nw+H48PEWhkLnZ2eXk5NhKxEJbYcpXff5nwl/AV/1s+X48/Pf14L7iJIEyXYFHBPjgwsz0TKUcz5IJhGLc5o9H/LcL//wd0yLESWK5WCoU41EScY5EmozzMqUiiUKSKcUl0v9k4t8s+wM+3zUAsGo+AXuRLahdYwP2SycQWHTA4vcAAPK7b8HUKAgDgGiD4c93/+8//UegJQCAZkmScQAAXkQkLlTKsz/HCAAARKCBKrBBG/TBGCzABhzBBdzBC/xgNoRCJMTCQhBCCmSAHHJgKayCQiiGzbAdKmAv1EAdNMBRaIaTcA4uwlW4Dj1wD/phCJ7BKLyBCQRByAgTYSHaiAFiilgjjggXmYX4IcFIBBKLJCDJiBRRIkuRNUgxUopUIFVIHfI9cgI5h1xGupE7yAAygvyGvEcxlIGyUT3UDLVDuag3GoRGogvQZHQxmo8WoJvQcrQaPYw2oefQq2gP2o8+Q8cwwOgYBzPEbDAuxsNCsTgsCZNjy7EirAyrxhqwVqwDu4n1Y8+xdwQSgUXACTYEd0IgYR5BSFhMWE7YSKggHCQ0EdoJNwkDhFHCJyKTqEu0JroR+cQYYjIxh1hILCPWEo8TLxB7iEPENyQSiUMyJ7mQAkmxpFTSEtJG0m5SI+ksqZs0SBojk8naZGuyBzmULCAryIXkneTD5DPkG+Qh8lsKnWJAcaT4U+IoUspqShnlEOU05QZlmDJBVaOaUt2ooVQRNY9aQq2htlKvUYeoEzR1mjnNgxZJS6WtopXTGmgXaPdpr+h0uhHdlR5Ol9BX0svpR+iX6AP0dwwNhhWDx4hnKBmbGAcYZxl3GK+YTKYZ04sZx1QwNzHrmOeZD5lvVVgqtip8FZHKCpVKlSaVGyovVKmqpqreqgtV81XLVI+pXlN9rkZVM1PjqQnUlqtVqp1Q61MbU2epO6iHqmeob1Q/pH5Z/YkGWcNMw09DpFGgsV/jvMYgC2MZs3gsIWsNq4Z1gTXEJrHN2Xx2KruY/R27iz2qqaE5QzNKM1ezUvOUZj8H45hx+Jx0TgnnKKeX836K3hTvKeIpG6Y0TLkxZVxrqpaXllirSKtRq0frvTau7aedpr1Fu1n7gQ5Bx0onXCdHZ4/OBZ3nU9lT3acKpxZNPTr1ri6qa6UbobtEd79up+6Ynr5egJ5Mb6feeb3n+hx9L/1U/W36p/VHDFgGswwkBtsMzhg8xTVxbzwdL8fb8VFDXcNAQ6VhlWGX4YSRudE8o9VGjUYPjGnGXOMk423GbcajJgYmISZLTepN7ppSTbmmKaY7TDtMx83MzaLN1pk1mz0x1zLnm+eb15vft2BaeFostqi2uGVJsuRaplnutrxuhVo5WaVYVVpds0atna0l1rutu6cRp7lOk06rntZnw7Dxtsm2qbcZsOXYBtuutm22fWFnYhdnt8Wuw+6TvZN9un2N/T0HDYfZDqsdWh1+c7RyFDpWOt6azpzuP33F9JbpL2dYzxDP2DPjthPLKcRpnVOb00dnF2e5c4PziIuJS4LLLpc+Lpsbxt3IveRKdPVxXeF60vWdm7Obwu2o26/uNu5p7ofcn8w0nymeWTNz0MPIQ+BR5dE/C5+VMGvfrH5PQ0+BZ7XnIy9jL5FXrdewt6V3qvdh7xc+9j5yn+M+4zw33jLeWV/MN8C3yLfLT8Nvnl+F30N/I/9k/3r/0QCngCUBZwOJgUGBWwL7+Hp8Ib+OPzrbZfay2e1BjKC5QRVBj4KtguXBrSFoyOyQrSH355jOkc5pDoVQfujW0Adh5mGLw34MJ4WHhVeGP45wiFga0TGXNXfR3ENz30T6RJZE3ptnMU85ry1KNSo+qi5qPNo3ujS6P8YuZlnM1VidWElsSxw5LiquNm5svt/87fOH4p3iC+N7F5gvyF1weaHOwvSFpxapLhIsOpZATIhOOJTwQRAqqBaMJfITdyWOCnnCHcJnIi/RNtGI2ENcKh5O8kgqTXqS7JG8NXkkxTOlLOW5hCepkLxMDUzdmzqeFpp2IG0yPTq9MYOSkZBxQqohTZO2Z+pn5mZ2y6xlhbL+xW6Lty8elQfJa7OQrAVZLQq2QqboVFoo1yoHsmdlV2a/zYnKOZarnivN7cyzytuQN5zvn//tEsIS4ZK2pYZLVy0dWOa9rGo5sjxxedsK4xUFK4ZWBqw8uIq2Km3VT6vtV5eufr0mek1rgV7ByoLBtQFr6wtVCuWFfevc1+1dT1gvWd+1YfqGnRs+FYmKrhTbF5cVf9go3HjlG4dvyr+Z3JS0qavEuWTPZtJm6ebeLZ5bDpaql+aXDm4N2dq0Dd9WtO319kXbL5fNKNu7g7ZDuaO/PLi8ZafJzs07P1SkVPRU+lQ27tLdtWHX+G7R7ht7vPY07NXbW7z3/T7JvttVAVVN1WbVZftJ+7P3P66Jqun4lvttXa1ObXHtxwPSA/0HIw6217nU1R3SPVRSj9Yr60cOxx++/p3vdy0NNg1VjZzG4iNwRHnk6fcJ3/ceDTradox7rOEH0x92HWcdL2pCmvKaRptTmvtbYlu6T8w+0dbq3nr8R9sfD5w0PFl5SvNUyWna6YLTk2fyz4ydlZ19fi753GDborZ752PO32oPb++6EHTh0kX/i+c7vDvOXPK4dPKy2+UTV7hXmq86X23qdOo8/pPTT8e7nLuarrlca7nuer21e2b36RueN87d9L158Rb/1tWeOT3dvfN6b/fF9/XfFt1+cif9zsu72Xcn7q28T7xf9EDtQdlD3YfVP1v+3Njv3H9qwHeg89HcR/cGhYPP/pH1jw9DBY+Zj8uGDYbrnjg+OTniP3L96fynQ89kzyaeF/6i/suuFxYvfvjV69fO0ZjRoZfyl5O/bXyl/erA6xmv28bCxh6+yXgzMV70VvvtwXfcdx3vo98PT+R8IH8o/2j5sfVT0Kf7kxmTk/8EA5jz/GMzLdsAAAAgY0hSTQAAeiUAAICDAAD5/wAAgOkAAHUwAADqYAAAOpgAABdvkl/FRgAAeA9JREFUeNrsnXdcVFf6/z/MDEOZgaFKFaQIAqIQezf2qNFoLFnW+M1KNtkkm2/a5mfabpJN8k1M3Wx6ookxkTRLYmyxEHtBERQRURBBem8Dw8DM/P6YCxGZClPuvfO8Xy9eMcPMcO9zzj2f85zznOdx0mg0IAiCIAgCEJAJCIIgCEKLqPsfNVtUZA2CMI9AACHMvxMBiAHIAEQzr0UA8DHw+VgAUj2/awWQb+Cz9QCKmH8XAGgCoASQw7xWBqCSmojf+C8TkhGsJYoEQfQRLH8A8Yy4+QNIYoQv0QZ/XwpglIW+K4cRzGwANYyYXmL+nU9NTRAkigQBRuSSGNELZP7tz/w/n+gWcX0iW8QIZDbjXRYx/86mLkKQKBIE/whhhOHmnyQySw8RzM9YHb/LZjzNm3/KyGQEiSJBcINoAJMZr6hbAH3ILAP2pm+m/iaBzARwDNp9TYIgUSQIOyIEMIH5mcz815/MYnV8AExjfrqpAXCSEciTzA9F7xEkigRhRfxvEsFuIaTwO/a0zSLmB4wg3iyQJxnhJAhW49R9eJ+OZNiHdWmpZAQ9rE3ZIAQwg/lZBG0kKMFdLgHYASAdQPq6tFQadAbI29s2khHIUyR4LoRhABYAmMeIoZSswhvimZ9nALSuTdmQDmAvgF3r0lJLyDwEiSJBIpiyQXyTN7gEfxx8J/iNFDctt65N2VAAYPtNXqSSTESQKBKOIoRSxhNMYf7rRlZxeKIBPM38tK9N2bAXQBqAvevSUlvJPASJIsE3IXRjBPBeEkLCCG7MqsGSmwTyG0Yg28k8BIkiwVUhFN/kES4A7Q8SAxPI1rUpG3bd5EHSEitBokhwQgwXAFgJ7X6RjCxCWAgp069WAmham7JhB4Af1qWl7iLTECSKBNuEMARAKoAH8EflCIKwFjJol+LvXZuyoQzA5wA2rEtLpRR0BIkiYTchFDLeYCq0y6MEYQ9CALwM4GVmeXUDgB10DpIgUSRsJYYRjEeYCkqrRrCLBcxPzdqUDRsAfL4uLbWIzEKQKBLW8AqXMWI4gyxCsBx/aJMEPMMkCfgcwBbyHgkSRWKgYihlPMInAYSRRQgO0p0comRtyoZ3AWxcl5baRGYhSBQJc8QwhBHCVFAEKQCgo7MdDS3VUCjlaGytQXtHC5rl9WhVNKG1raHXe5vl9WjraDH4fZ4SH7i7eAAA3F084Cnx1bo4XqFwcXaDryyYed26la9a2hogVzQDAKobSqDWqHt+Jxa5wsczEADg7TEILs6cPl4aBuA/0O49bgDwLgXmECSKhDExTGLEMAUOWoFCrmhCVcMNVDeUoKaxFNUNN1DbVG7xv9Msr0ezvN6k93YL0iDvMHi4ecNXFgR/r1D4yYLN+psqdReKyi+itOYqqhpKUN1ww6h434yrWIIA7zAE+oQjyDcCgwNie4SdQ8iYPv7Y2pQNaYw4ZtPTTwBUJcPusKVKxtqUDbOh3YNxqP1CuaIJxZWXUd1QgqqGEtQ0lkGu4M7KmpOTAAHegzHIOwx+smAE+oQj2C8KQsEf812NRo0rN87hUvFpXK/IhbKrw6LXEOgTjqjgkRgWPsZskWYR6QDeWJeWup9LF01VMkgUSRQtL4ZLoA1nT3QUmxdX5aG48jIKyy+guoGfxRlC/YcixC8KLmI3ZBccNtkjHSg+noFIHno7EiMncXWpNQfAi+vSUreTKJIokjUcSBSZrDMvAxjFdxu3tDWgqOIiCssvoLgyDx2dlD7T2ohFLkiImIjbYmZw1XvMZMSR1dlySBRJFEkUBy6GMwC8DmAsn+3a0dmOS9dP4ULhUVTWF1NHsyPhAXEYEzcHUcEjuHj5GQBeYOuyKomi5aFAGwdhbcqGyYwYTubzfZbVFuJC4VFcLs6w+N4Z0T+Kq/JQXJWHIN8ITEu6G+EBcVy6/LEA9q1N2XAMwLPr0lKPUYuSp0hw2FNcm7JhAoBXweMAmo7OduQWnUR2wWHUNJZSp2I5kUHDMXPUn3qOenCMdMZzPEmeIokiwSFRXJuyIRrAm9CW3OElNY2lOJ23F/klmehSURUhLiEUiDA6dhYmJi6CWOTCxVvYDuD/rUtLLSBRJFEkWCyKa1M2yAD8C8DfAYj5KobHcn7BlRvnqANxHA93b8wbdx8ig4Zz8fKVAD4E8G97ZcghUbQ8AjIBf1ibsiEVwGVoDybzThBrm8qx/ehH+HL3iySIPKGlrQE//f4edp5cz8WoYDHzrF1lnj2CB1CgDT/EcBq06auS+Hh/CqUcR85vR3bBYWhuSkFG8IfcopMoqbqMBRNSuRaIA2iTj69fm7Lh7wAeX5eWephalLvQ8qmdGcjy6dqUDWHQ7huu5KNtNBo1sgsO43D2Vjpb6CgDkpMAExMWYlLinXBy4uxC1hYAT61LS7V6ZghaPiVPkdCKoRu0KdmeBuDGx3usaSzFrye+oGhSB0OjUeP4xR0orsrDXVMegsSVk7nolwFYsDZlw1vQpo6jGR2HoD1F7gniNABZ0AbT8E4QVeouHDm/HV/teZkE0YEprbmKTb+9yuU+4MY8o1nMM0twBFo+tTOmLp8yUaVvQlvkl5dU1BVhz+mNJIZED2KRC+6c+ACiQ5O4fisboF1StWiUKi2fkqfoqN7hEgC5fBbE03l7sXn/GySIRC+UXR3YeuQDnLq0m+u3kgogl3mWCRZDe4rsFsMQAB+AxwfwFUo5dp5Yj8LyC9TghF4OZ29FfXMl5o5d3assFscIAbBtbcqG7QAepQLH5CkS5gliKuMd8lYQqxtKsHHvv0kQCZPIuXYcP6S/C4VSzvVbWcJ4jQ9Qq7IP2lO0M7fuKa5N2RAB4CsAvN6cv1ZxEduPfETp2QizkUn9kDJzLTwlPrxwggH8ZV1aalF/Pkx7iuQp8t07TIE2spTXgnjuSjq2HHqfBJHoF02ttUg7uM5mhZOtzDRoI1RTqGVJFIk/xFC6NmXDZgCbAcj4fK/p537A/rObKTMNMWBh3HzgdTS11vLC+QWweW3Khs1MlDlBoujQgjgZwAUAvJ4pajRq7Dj+Gc5c3keNTliEZnk90g6u44swghkDspgxgSBRdDiEAF4GcAhABJ9vVKXuwi/HP0NecQa1OmFxYdx84A0+CWMEgENrUza8ujZlg5BamETRUYgAcALajBe87vgqdRd+PfEF8kvOUqsTVqGlrQGbD7yB+uZKPk2Ynwdwggm8I0gUec190C6XjuX7jarUXdhx/DMSRMImwvh9+tt8EkYwY8SFtSkb7qMWJlHkI2IAn0F73ELqCDd84Gwa1T0kbCqMaQfe5JswSgF8tTZlw2drUzaIqZVJFPlCCICj4HGatlvJK85AdgGVlSNsi1zRhO/T30ZDSzXfbu0BAEeZcnEEiSKnmQbgLBxgubSbZnk9fsvYRC1P2M1j/O7gm5Armvh2a2MBnKaqGySKXOZJAAcBBDrSTe8+9SUVBSbsLoxbD3/AxwQRgQAOrk3Z8CS1snWgNG/WQQpgPYCVjnbj566kY//ZzdQDCFYQHZqEpVMegZMTL+f/PwC4H0ArtbRl8F8mJE/RGs8hgNOOKIgNLdU4nL2FegDBGgpKs7H/bBpfb28lM9ZEU0tbDhJFyzIP2tyl8Y524xqNGrtOroeyq4N6AcEqsq7+zod6jPqIZ8acedTSJIps4yEAO+Egxy1uJePyPpTVFlIvIFjJ4eytfM6oJGXGnoeopUkU2cLrAD4Gz7PT6KO2qRxHz2+nXkCwmt2nvkJNYylfb0/IjEGvU0uTKNoTNwA/AXjGkY3wW8YmqNRd1BsIVtOlUmL70Y/4Hhn9DDMmuVGLkyjaGh9oj1ssc2QjXCg8itKaq9QbCE7Q0FKNX49/zvfbXAZtoQEfanESRVvRHWE6wZGNoFDK8XvWT9QbCE5RWH4BJ3N38v02x4IiU0kUbcQ06mxafs/6CQqlnHoEwTmOXvjFEVY4uifvlAGHRNFqLAGwD7QsgdKaq7hQeJR6BMFJNBo1fj3xuSNM6nyYMWsJtTqJoqW5D9oNbIfPVK/RqPl8IJpwEJrl9dh35ltHuFUxM3bdR61OomgpHoK25BNVwgZwOm8vqhtKyBAE53Ggai5CZgyjs4wkigPmaWjP/xDQJlo+eXEnGYLgDb+f+4GPpab08TEzphEkiv3iVQBvkhn+4EBmGqVyI3iFsqsDu099CY1G7Si3/CYzthEkimbxHwDPkxn+oLD8Aq7cOEeGIHhHac1VZF5Jd6Rbfp4Z4wgSRaMIAXwG4DEyxR+o1F04mPkdGYLgLUfPb3OkZVQwY9xnoFgJEkUDiAFsAvAAmaI3566kO9qAQTgYyq4O/JaxydFu+wFmzCNhJFHU6SF+BSCFTNEbhVKOExRcQzgAxVV5jhKNejMpJIwkirr4jARRN0cv/EyZawiH4fdzP6ClrcERhfEzan0SxW7+AyCVzNCXhpZqnC84QoYgHAZlVwcOZTtkTt9UUPANiSK0ockUVKOHg5nfUVkowuG4dP20o1Z/eQwOflzD0UXxadCxC72U1lxFYfkFMgThkOw/m+ZIZxdv5nk48AF/RxbFv4MO5hvkEJWFIhyY6oYSRwy66eZNZowkUXQQ7gPwAT32+iksv4Cy2kIyBOHQHDm/3ZGDzD6AAyYRd0RRXAlgPT3uxgcDgnB0FEq5oz8L65kxk0SRp0wGnccxSn7JWaqCQRAM2QWHUdNY6qi3L2TGTIcpVOxIohgNYBuoHqJBNBo1jlwgL5Eg6JnoobseYzSJIn/wB7CH+S9hgItFJ1HfXEmGIIibKCjNdvQ9docZQx1BFN0A7HSUWc5AUKm7cPziDjIEQejgcPZWRzdBNDOWupEocptNAMbSI22c3ae+RFNrLRmCIHRwozof1youOroZxgLYTKLIXV4HsIweZ9NmwZeunyZDEIQBjp7fRkYAljBjK4kix3gIwDPUf42TdfV3nLq0mwxBEEaorC9GfslZMoR2bH2IRJE7LAIdzjeJgtJs7D+bRoYgCBM5cmG7o6Z/u5UPmLGWRJHlxILOIppERV0Rfjn+GT3gBGEG9c2VKCyjnMD44wxjLIkie5FCexZRRv3VMHJFE7Ye/gBdKiUZgyDMhLYbepAxY66URJGdfAUgnvqpYVTqLvx89BPIFU1kDILoB2W1hY5aWkoX8czYS6LIMp4ERZqaxKGsn+iBJogBcjpvLxnhD5YxYzCJIkuYBioDZRI5147jbP4BMgRBDJCC0mzUNpWTIf7gTfAgRyofRDEE2rx8FFhjhOqGEuw78y0ZgiAsRAZ5izcjZMbiEBJF+9GdqJZymhpBoZRj29GPKLCGICzIpeunaW++N/7MmMzZwgtcF8X/AJhA/dA4vx7/nFK4EYSFUam7cCZvHxmiNxOYsZlE0cbcC55mVLA0Z/MPUM5GgrAS5wuP0gpMXx5ixmgSRRsRAeBj6nfGqWksxaGsn8gQBGElFEo58ksyyRB9+ZgZq0kUrYwQwPfg0WFRa6FSd2HH8c+gUneRMQjCimRd/Z2M0BcpM1ZzKgiSi6L4L1ApKJM4lPUThYwThA0oqy1EdUMJGaIvY5kxm0TRSkwG8Dz1M+OU1lxF5pV0MgRB2IjzhUfJCLp5nhm7SRQtjAyU6NskVOou7D71JSX6Jggbcun6aQq40U134nBO5KTmkihyctPWHhw9vx0NLdVkCIKwIQqlnKpn6IczwZFcEcUU5ocwQkVdETIu07kpgrAHF2gJlfPjOBdEkY5fmIhGo8bejE20bEoQdqKo8hJluDEM61f8uCCKX4HqI5pEdsFhioAjCDtPTPOKz5Ah9CMDy8tMsV0UHwAPsq7bAoVSjiPnt5MhCIOEDY3E3HuW4NHXX4DMx5sMYgUuF2eQEQwzjRnbWYmIxYYLAfA69R/T2H92MxRKORmC6EPcqJEYMWEM4kaPhNTTAwBw8XQmmuobyDhWoKy2EM3yenhKfMgY+nkdwC4AZSSKpvMBAOpVJlBacxWXrp8mQxA9BEeEYdS0ibht6gR4ePXdfTixl86wWpNLxacwPn4+GUI/PswYv5RE0TSWMD+ECVBuUwIAXN3dMGbGFIydORVB4aF631ecX4Ar53PJYFYkv+QsiaLp4zyr9n3YKIoyZgZBmPjwldUWkiEcGL+gAEy6YybGzJgCV3c3o+/fuelHVlx3UHgoJsydgV++TIOqi1/5eSvri2kJ1TQ+AHAYQD2Jon7eBMcrN9sKlboLh89vJUM4KNGJcZiycA4SxiSb/JlT+w6hKO8KK64/MmEYJs6bgbChkdj09keor6rhVfsUlp9H8tDbqaMapjt25EG2XBDbok8ng8VRSWzjQuFRylzjgAxLTsTjb72Ev7281ixBrCmrxM5NP7DqPgAgNGoIHn39BQRHhPFLFCm7jak8ABblRmWTpygGy8+vsAllVwcdwXAwEsYkY/aKxQiNGmL2ZxVt7dj45n+haGtnxb24urshOjGu5/89vGR4+JVnseG191jjyQ6U65WXoFDK4SqWUOc1zlcAEgDYPXksmzzFlwFEU98wjcz8/XQEw0EYPm4UHn/rJfzl2cf6JYidSiW+ev19VN1gTxmxxPGj4CwW9xHKB178B8KGRvKi3VTqLlwrv0gd2DSiGQ2wO2wRxRAAT1K/MN1LPHv5ABnCAXB1d8N9ax/tlxjeLIiFuZdZdV/jZ0/X+bqzWIw1zz+BgMHBvGi/4qo86sSm8yQAu6+hs0UU34R2+ZQwgfMFh9HW0UKG4Dkurq5Y9tB9/f58a3MLPn/5bdYdvwiOCEN4rP5FIamnBx548emeRANc5nolHX0xAzFYkLCFDaI4GVQBw2S6VEqcvrSXDMFzwmOj8dR7ryBp0rh+fb7k6jX85x8vsXJ/7va7jJ/fk/l4496nH4FAIOB0OzbL61HTWEod2nRSYOegG3v3OCHoTKJZZBccoSz8PEYgEGDuPUvwyGvPwSfAv1/fkXHgCD755xtorK1j3f35BPhj5KSxJr03KmEY5q9azvk2La25Sh3bPD6AHYvJ21sUHwCQRH3ANFTqLmTkkZfIV3wC/PHIa89h9orF/fKQmuob8NXr7+PHj79Ep5KdFeBn3X2nWfc2ddFcRCUM43S70tEMs0mCHY/m2VMUpQD+Re1vOldunENLGyVx5iPJU8bjqfdeMbjXZogTe9Px1v8+h9wzWf3yTsfOmgoXV1er3mNwRBhGz5hs9rWt/Huq1a/N2p4i1Tg1m5cZjbA59jyn+DyAQGp708nMp4hTvtEdTJM8ZXz/vJDcy9i16UeUXL3Wr88PHzcKC1Ytx6XMbHQoFFa91yX3r+qXB+wT4I8Fq1dg2+ebONnGHZ3tqGq4gUCfcOrwpuPPaMSzjiKK0aAjGGZRUVdEOU55RnRiHFY8vKZfe4flRSXYuemHfkeWhsdGY/6qZYhKGIYOhQK/b9tldU84Ii6m358fP2c6Tu0/hPIibhbRvlGdT6JoPk8C2ACgwBFE8T+gIxjmeYlXDpIReIKruxsWrl6J8XOmm/3Zy1k5OLZzHy5n5fTrb0clDMOce+7qtU+XdeQUWputd8THXSrB4tQ/D+g7BAIBlty/Ch89/3+cbPOy2kKMoa5vLmJGKxbyXRTHAlhA7W06ckUTLhefIUPwgIQxyVj64Gqzqt63tcqRceAITvyW3u+k2XGjRmLG0gU6vbXje6y7LL/sofsscuYwIi4Gw5IT+z0hsCel1RSB2k8WAJgA4CSfRfFVamfzyC44DJW6iwzBYaSeHrjrr6vMOndYXlSCY3sOIOvIqX5FkwaFh2L07ZMxavokvaJUlHcFFcXWO0c3fs50jJhgOR9p/qrlnBRFuaKJSkn1n5cBzOGrKE4DMJva2Dxyi06SEThM8pTxWPLXe+EuNZ4YurG2DueOnELumSwU55u/leIulSB56gSMuX2ySanhTuxNt9p9hw2NxOI1ls3LERwRhuHjRuHi6UzO9YOKumskiv1jNqMdh/koii9T+5pHac1VKg/FUbz8fHH3g6sRN2qk4cGyuBQXTp7BxdOZ/fba4kaNxJgZk5EwJhlCkWmPdW1FFc4fz7DKvct8vLHm+Sf6JP22BDOWLuCkKFbWFyM2bDQ9GP3Xjul8E8VutSfMIOfacTICx3AWizH9rjswY+kCnaLQoVCgKO8qCnIuIftYRr8yz0g9PRCZMAwxIxOQMDYZHl4ys7/j143fQ622/Pk5F1dX3P/Pp6yWuzRsaCSiEoaxLsm5cVG8Tg9H/+leZdzPJ1EkL9FMulRK5JecJUNwiOHjRuGu1BR4+fn2vKZoa0dR3hUU5V1BQU5ev84U+gT4I3hIGMKGRiJu1EgEhYcO6DovnDzTr4P+xhCKREh54sEBX58xJs2fyTlRrG64QQ/IwHiVT6I4D9oIIsIMrpZmo6OznQzBAQIGB2PpA6sRMDgE5UUlyD6WgYriGyi/XmLWkmjA4GC4uLoiOCIMAaHBCI4IQ0hEOFzd3Sx2rbUVVdjyyUarCOLqpx9Bwphkm0w+PLxkaGnkTh7gto4WNLRUw9tjED0w/WMsoyVWzXVpK1GkiNN+cJGWTlmPq7sb7ki5GxPmzYC8uQXlRSWor6qBq7sbIuJiEBEXg5rySnQoFPDy8+2zpOgqcYNfYAC8/H1tUiqprVWOr9/8AG2tli1Q7SwW43/WPophyYk2sbtAIMCYGZORbuWkA5amrqmcRHHgWsJ5UVwCYBS1pXkolHIUVV4iQ7AUZ7EY4+dMx+wVi3uiSj28ZP3a27OZp9Iqx6cvrrP4EQxnsRipzz+B6MQ4m97P+NnTcejnPVbZF7UWNU2liA5Nogeo/4xiNGU7l0WR9hL7wbXyi5REmIV0J8+evWKxWQfw7Y224PBbFk+T5uXni9VPP4KwoZE2vyefAH9EJ8axroiyQU+xuZIeIstoCmdFcQGARGpD8yksP09GYBljZkzGzLvvhF9QAKeuu6asEl++8R/UlFl2QI5OjMOqpx62ybKvPpImjeOUKNY0ltGDNHASGW2xytq5tUXxaWo/89Fo1LhWfpEMwRJGTBiDufcsQcDgYM5d+5n0Y/h5/bcWr4Ax/a47MH/V8n5VvbAkw8ePwtbPN0HVxY2MT/XNldBo1HByEtCDNXBt4ZwoTgCdS+wXZbWFUCjlZAg7IhSJcNvU8Zh65zyrHy+wBh0KBX5e/y3OpB+z6PdKPT2w7KH7MHwcO8IE3KUSxIxMQF4mN1ZWulRKNMvrIZP60UM2MKbBSjlRrSmKz1C79Y+84gwygp1wdXfDuFnTMHXRXE7tGd5M1tFT2PHVdxY/rjB+znQsXL3SosdDLEHS5HGcEUUAqGupJFG0nMYs5oooxgNYRG3WPwrLL5ARbIyHlwzTFs3D+DnTWTfom0p5UQl++TLN4ofaAwYHY8XDaxAeG83K+44bNRICgYAzUajN8jp64CzDIkZrLBqmby1RfIzaq78PTD2aWmtNeq+Tk4AiVAdIzMgEjJ8z3aycoWyjorgUB7f8iuzjpy36vS6urpi57E5MWzSX1bZxl0oQHhuNorwrnGgvU59vwmSteZDtougP4F5qq/5RWmN63bWhoUm4cuMcGa0fXuG4WVMxdubUflW9ZwvF+QX4/ec9Fk+O7SwWY9L8mZixdKFJlT3Y4i1yRhTlJIoW5F4ALwCosdQXWkMU7wPgRm1lXVF0FUsQE3obiaIZA31scmJPJQmu0qFQIPPQCZzaf8jiZw7dpRKMnzMdUxfNs+sxi/5w29Tx2P3tT5y41sbWGnogLYcbgAcAvMZWURQC+Du1U/+5UZ1v0vsmJS5Co5weLoOdUSTCsOREJE8dj7hRI+Hi6srZe7mclYMLJ8/g/LEMix+vCI0agrEzp2LMjMlWKfVkC7z8fBEUHmrVgskW8xRp+dTSPADgDQAqNoriMgBh1Eb9Q6GUo7ap3Oj7JK4yJEVPxc9HPyGj3YLU0wPRifEYMXE0YpMTOSuEarUaBTl5yD2ThfPHTqO1ucWi3+8XFIDkKeMxatpEziUj0EfcqJGcEMW2jhao1F0QCkT0wFqGMEZ7fmCjKD5E7dN/SqpM8xLHJ8yHSChGdSOVohEIBIhMiEV0YjyGJSeaVG2erdRWVOHi6XMozL2Mgpw8dCqVFv1+Dy8ZkiaPQ/KU8XZJy2ZtkqdM4EyCcHl7MzwlPjToWVZ7WCeK8aDD+gPClP1EdxcPJEVPhUIpR0tbg0PZRygSITRqCEKjhiBkSBhCo4YgOIK7CxONtXUouXoNl7NykH8uB031lm1PmY83IuJiEB4bhejEeE4mITCHoPBQzhQfliuaSBQtyzRY6HiGJUXxAWqXgVFRV2T0PSOjp0EkFJv0Xq7i6u4Gv6AASD094B8ShGBGALk8qDfVN6C08DpKC6/jxtVrKC28bvEl0YDBwQiPjcbQxHiEx0RxOrK2v0y/6w5OiGJbRwsIi/MAgMfZIopu0EadEgOgptHwfoiTkwBJ0dOY93IrsbDMxxse3jIER4T15Mv0GeQPd6kEAoEAwRFhcBaLOZlftJtOpRJVN8pRVVqOhpo61FfX9NRXtET9wm77+AUGQObrDf/gQPiHBELm482bfcGBEjdqJAIGB6PqRjmrr1Pe3kSNZXnuA/AsgAFVZreUKKYAkFGb9J+Glmp0dBpuy6iQET1LLsYE1N4IBAKMmDAG4+dMt3mdPXvhLBb3LO8CgKqrq0/gR0Vxaa/k1Yq29j4ZdHwC/PucD7x5MkEYZtayRdj83qesvsaW9gZqKCvMvRkt2sAGUSQv0cpeIgAkRkzq+Tdb67K5uLpiwrzbMW3RPFYX3LUF3XugN8PlQCCukDxlPA7v2IvSwuusvcYOZTs1lPW8xQGJoiWmnrEAJlNbDIy6ZsPLPa5iCSKDh/f8f2NrNevuITgiDI+/9RIWrl7p8IJI2JelD6xmtWdtbFWI6DeTGU2yqyiSl2gRUTTs+Q0LGw2RUHuwWtnVwbrI0ykL5+Cxdf+Cf0ggNSZhd8KGRmLKwjkkio7rLdpNFIWgPKeWEUUjh/ajQ5N6/l3PsqXTlX+/H4vXpHA2oTbBT+alLGVt4FaHso0ayHrcy2iTXURxNoAQaoOB09CifznUVSxBeMAwVoriyr/fjzEzaPWcYB/OYjFW/+PvrExd19nVQQ1kPUIYbbKLKJKXaIlZY2e7weWUyODhPUunANDEkpynKx5eQ4JIsJqAwcFYvCaFlc88YXVv0eai6AZgCdl+4DQZyZofGZTY6/+b5fV2v+YZSxdg7Kyp1HgE6xk/ZzqSp4xn1TUpuxTUMNZlCfpZrUlgjz9KwCyRGzyodzCVvUvPRCfGYV7K3dRwBGdY8cgaVuV7ValU1CjWpd9O20BEMYXsbhkMHeT18QzskyPRnkVKPbxkWPXUw3SQnOAUzmIx/vLsY5D5eLPierpUSmoU69MvjervyOYDYB7Z3DIYyoMYHhBntmdpTZY9dB/nCtASRPeE7v5/PsXpupqEWcxjtMomorgEAwh5JXojb2/W+7sQv6g+AqpSd9nlOpMmjeN01XqCCAoPxZrnH7d7RKpGo6bGsD5CaOss2kwUCUuJokJ/cuAg34hbBNQ+iYRdXF2xOJVWzAnuE5UwDP+z9lG7nqtV0pEMW7HIFqLogwGcASH6oi8PoqtYAh/PwFsEtNku1zhz2Z2Uuo3gDcOSE7H66Uco4QT/mQ0zl1D7I4rzAIjJ1pacNeoOzw70Ce/zmj3Su8l8vDFp/kxqKIJXJIxJxp8e+ysFjfEbMcyMf+lPb1hJdrawp6jnIG+Ad9+q8vYoTjr9rjsoOIHgJUmTxmHlo/eTMPIbszTL3J7gBlo6tbwo6lk+HaRDFNsVthVFd6mEDukTvGbUtIlIeeJBCEW2ix0Ui1zI8LZjNsw4U2+uKM4AHdi3OPrOLA3yHmyyV2ktJs6bQV4i4RAe471PPWKzv+fkRJ6pDXFjtMsqoriA7Gu7h8bbY1BfT1Ept9k1CIRCTGZx+R2CsCTDx90GkbMzGYKfmKxdImt9MWE6us4s+XoGQijo2zyKDtuJYmjUEE4d1K8oLkVNeQXqq2pRW1mFxpo6tDb3Xm52l0rgE+APAPAZ5I/w2CgMiY2mKEQ9lBeV4GrOJdSUV6KmrBIdCgXUajXKi0q0EyeBAMER2mV+Dy8ZfAL8ERQWioDBwQiPjebcXp3PID9Ul1VY/e+4iGnBzcaYXLnAnJEgEUAY2dby6Dqz5KXDS7S1pxibNJzVdivMvYyivKu4nncFRXlX0aHof5LliLgYhMdGISphGOJGjXTYvthU34CMA0dQnF9gkk3VajVKC6/rHvhdXRGdGIfoxDgkjEnumYywmaAhg20iioTN6davEkuKInmJVsLJSdDHW/R01320ptOG2fWH3ZbIOltdzsrBxdOZyM3IQkuj5RIZFOVdQVHeFRz6eQ88vGS4beoETLpjJicGcktw4eQZHN99EIW5ly32nR0KBXLPZCH3TBZ++TINPgH+SBiTjJiRCaydeHj5+tjk7+haBSKszgIAn5AocgCxyKVPAI2XVPdgrOy0XSYMLz9fVtinrVWOjANHcGz3ATTW1ln977U0NuHwjr04unMfkqeMx4ylC1lbwX2gZB4+gQNbdqCmzPqFq+uranB05z4c3bkPXn6+mLZoLsbMmAJXd/YsJUpstF3gLKLgNa6LohuACWRT2yGT+Ol83ZbZ9d3c3e1qg/KiEhzbcwBZR06hU2n7qgJqtRqZh08g+3gGZixdgFnL7uTN3mNtRRW2fLoRBTl5dvn7jbV1+OXLNOxN24ZR0ydi0h2zWDHxcJdKbDYRJmxO9+mJdkuI4gxQAnCroSs821Oi20uzVc5EgVAIsat9HtyLpzNxeMdvKMq7wor2UXV1Yf+PvyD7+Gks+9t9iEoYxtm+plarcejnPdj/4y92mWjcSodCgRN703FibzqiE+Mwe8Viu9rXzUai6OJMgTb2aF5Gy3ZZQhRp6dSas0ZnFyhuCaCRuHrqfK+tsuu7S2zvJRbnF+CXL9NQcvUaK9uppqwSn/zzDYyZMRl33b+Kc+c3q26U49t3P0ZFcSkrr68gJw8FOXmIGzUSC1evtIvn6C51t9EzT8undmKypURxMtnSmrNGdwC9ayS6u9r3KIS7h9SmYrPr259w8XSmxb4zKDwUDTV1ULRZPtnBmfRjKCsqwV//+RRnkqQX5V3Bhtfes6g9hCIRgsJDe73W2tQy4H3fvMzzyM/KwdhZUzH3niU2tbGbxDaeopuLFIRdWADg2YGKYiC04ayEtWaNt+wvuLt46IxOs2U2G1cbeIotjU3Y/+MvOLXvENRq0zxgoUiEsKGRCBsaCf/gQLhK3OAXGAAA8PL31XuusqK4FKquLnQqlSgvKkHZ9RIU5xeg6kZ5v669vKgEHzz7Kv720v9jfYRqXuZ5bHrrowEtl4bHRmNIbDTCY6PgM8gfwRFhRs8gdp9r7FQqUXWjHPXVNagoLkVFcalR4VSr1Ti17xCyjpzC7UsXYNqiuTapgWgr799NTKJoJxIZTasciChOIzta21Psvb/g6iKx+zUJhdbdQs44cAQ7Nn5n1HPxDwlEWLRWBMNjoxEaNaTfnmM3EXExf3g2zS24lnsZZ9KPIS/zvFnfWV9Vgw+efRWPvPYc/IICWNm3cs9kYdNbH0HVZV5hanepBGNmTEH8mKR+JzfwDwnUaXMAULS1oyjvCgpzL+Nabr7eJfMOhQJ707Yi4+ARLH1gNYYlW3d+7uxim4w2bHjGHZhpAH4gUWQxbrcslXq4edv/opys87W1FVX46eOv9J6Hk/l4Y8TEMYgbNRJhQyOtHq4v9fTAiAljMGLCGLQ0NuHUvkM4feCIyUuALY1NWP/qu3j8rZdYdbSg25v99p1PzBLEmJEJGDtrKhLHjbJqpK2ruxviRo3sOa+oaGtHYe7lnjOoba3yPhOQ9a+8g6RJ43DXX1dxKtOSzkmHiwcI7ooi7Sfa+AGx934iALi6WXaANxT1GDA4GCMmjEHCmOR+e4KWwMNLhtkrFmP2isXIOHAEe9K2mpQgoLaiCls/+xp/fuJvrOlTqq4ubP7PpyYvmcaMTMDC1St7UrbZvL+5uyFhTDISxiQDAK6cz0V+Vg7OHTnZqw2yj59GQc4lLHvoPgwfN8ryqzY2Wj6VuHnSwGc/DGqaMVH0Ae0nWl8UbxFBVzG/llZqyiqx6e0Pe0U9Sj09MHLyOIy5fbJdhVAfY2dNxYiJY7D/x19wbPcBo95W1tFTGDNjCmJGJrDi+k/sTTdpv1Tq6YGlD67GiAljWGX/mJEJiBmZgDvvuwd5medxJv0Ycs9kQdXVhdbmFmxc9wGSp4zHsofus6iQOdkoVyt5inYlkdG2+v6IInmJdnhA9B3sFQpsd1TUUrXlTuxNx68bv+/xWBLGJGPsrKmIGzWS9cmiXd3dcOd992DEhNH45p1PjC6pnkk/yhpRPLX/kNH3RCUMw6qnHmJ9BG33MmtbqxxZR07i9MEjKC8qQdbRUyi+UohVTz6EsKGRnHrmJW4yEHb3Fnf0RxTHku2sj0zaO3uNs7NuURQJxTa7JlWXakCfb21uwU8ffYncM1lwFosxfs50TF98B2sDUgwRHhuNx99+Cd++87HBDDA15ZWsuebaimqDv5+2aB4WrF7BqSoW7lIJJs2fhUnzZ6EgJw/7f/wFhbmX8eGzr2LOPUswY+kCTtyPUCAiT9H+jO2vKFJqNxvg6e57i6fI7YO9BTl5+O79z9GhUGDG0gWYumge5wMjpJ4e+Os/n8JXr7+Py1k5Ot/DJm8lKiEWV87n6vzd7BWLMfeeJZxuj+7qG6WF13Ho5z3Ym7YVV8/nIuWJByHz8Wb38y7xAWF39GqboWmVkDxF+zwkzgbyItqqYndXZ6fZn1Gr1fjt++347v3PMXXRXPxz/XuYv2o55wWx54EQifCXZx/TmYYsadI4LF6TwpprTXnibzqvc9qieZwXxJsJjRqCVU89hLUfvAH/kED89//9W+9kwBQ62q1/Fljq5g2CFZ6i0FxPMREAnTC1xWArEMHD3RstbQ1GPUVdFTWsI4rmnWtrqm/Ab99vx5CYaDz36Vu8LdorFIlw79OP4Ot1H0Di6YGg8FAkTRrHuioaUk8PPPTKMyi5eg0XTp5BcX4hZD7eWLB6BS/bxT8kEMv+dh9aGptw6Oc9KC8qwdRFc81eTtVoNFa/Vg93Lxr0WPCIAIgHkGOOKI4iu9kOL+mgHlEUCfUfIHYRu9k0s40p1JRVoqm+ASseXuMYT5OnBx557TlOXGt39h9HwcNLhjvvuweKtnYU5OQhNGqIWZUvBrqXbgoyiT8I1niLfURRQKLIDvxkf3gaQqHIgKdom/1GU5eR1Go1/EMCEZ0YR41IsAZXdzfEjEwwO6GCssP6lUO8pH7UQOxAp8aRKLJQFA1hq5IzHe0Kk97HpehFwvEwt38q2tqsfk3eHoOoYTgoikLQoX2b4uMZaNL7nG1UnLRN3kaNQjgct6aXswa0fMoaEqEj2EbfOl00tAUZCRsxyHuwSd6gi9g29d4UHBPFlsZmKNra0NGuQIdCARdXVwhFIkg8pfD09qIOZiUBaW+Vo13ehs4OJURi5142d3Jysvk1qdXqAa1etFu534tFLnQkgz24MVqXb4oo0tKpjXF38egVgaq3FW2UAk6j0aBd3gY3OxQbNnZdZdeKcT2/ACVXClF+/Qbqq2ugVHTo967FYvgE+GFQSBDCY6IxeGgEwqIj4ewipo5nIlWl5Si6dAUlVwtRdq0EdVXVBiucCEUiePv7YlBIEAZHRyAsJhLhMdH9Tpre1io3GDCjVqtxZMdviEyIHVBgUbuVPUUvjwDqTOxilKmimES2soO36DUYLW0NUKn1H4eQuNouPZS5olhRXNqn6KylhLAo7woyD59A3tnzaG5oNOvz3fX8qm6UI+eUtpCxyNkZkQmxSBw3ConjR0EqowTNt1J2rRhnDx3HpTNZqKuqMeuzqq4u1FZUobaiCpfOZgMABEIhhsRGI2FsMkZOHAMvP1+TvuvUvkMoKbimN7q55Oo1/PTxl/ANDMD0u+7Q+Z6m+gaTDvVb21P0NXGbhLAZSQDSTBHFeLKV7Qn0GYLC8gvoUuk/OG/L7PptLa3wGWR6pFynUon1r7yDlY/erzefZktjE0quXuuphmAIpaIDGelHcXTnPtRVVlv03ro6O3El+yKuZF/Ezxs2Y/jYZIybPR1DR8TbZdmPLahUKmQdPYVju/ajtPC6Rb9brVLh2qV8XLuUj51f/4CYkcMxbvY0JIxN1lm/s76qBj9+/CUKcvLw0CvP9Pm9oq0de9K24vjuA3B1d8P9/3xK59+9nJWDxpo6jJ8z3eg1yltarWpfHw8SRZbRR+tIFFlEsH+U0ffYMmeiPo/swskzOqsqhA2NhE+AP9763+cwL+VujJ8zvc/+joeXDOnbdiH72Gnc/eD/6FxO61QqcXz3QaRv22mTwAdVVxfOnziD8yfOwDdwEKYvvgNjZkyGyNnZYfqeWqXC2UMnsO+H7Wisrbf639NoNMjPzkF+dg48vGSYsnAOJs6bAVd3N5QXleDwjr3IPp4BVVcXEsYk98rO01hbh2O7DyDjwJGe/rHkr/fq9ATzMs/jx4++xDMfrzPpuprqGqx63/5eITTQcVAUpQDCyFZ2EEXfCKNp3GyZXb+5XrcoKuTt+O377TrThS1YvQK5GVnY9vkmnPwtHfNXLe8pJNvNlIWz8e07n+Babj7m37scyVPG94hnzqlM/PJlmslFfi1NXWU1tn72NQ78tAOzli/CuFlTIRAKed3vii5dwdbPvkbljTK7/P2Wxibs/vYn7P/xF0hlHmio+aPtfQL8sfLR+wFoc+oe230AF09n9vr82FlTMWraxD4Tq71p23B4x15Mv+sOk8tLNdVZd0IwyJuGVpYRxmheqyFRjIWenHCEdXEVS+DrGQhlp4LVnmLy1PF47YGn0KlUYv6q5b28QRdXVyx/ZA3Wv/IOKopLseG19+AXFICpd87FqOkT4eLqiqRJ43A2/RguZ+Xgu/c/x57NWzFh7u24nn8VeWfPG70uoUiEsKERqCguNRjsMRCa6huw9bOvcWz3fixe82fWlISyJJ0dSuzY+B1O7TtkNL2Zk5MTBg+NRGhkOM6fOAN5c4tZf0soEhrNFtOpVPYSRJmPN8bPno6dm35A/rkcNNX39eIi4mJw9wOre72WeyYLe9O2oqK4FO5SCWYsXWh6u1vRUxSLXOjgPvsQMprXM9MSvvTSSwCAtks9D8UsAEvIVvahprEUEjcZAvTMKMXOrjhxcadNrsUvKEDn3p9QKESnshMHt/yKa7n5GBIbDYmntNfntPtHV7R9q1WOvMzzOPXb75C3tMLDywujpk9C1pFT6GhXMCm5LqG2vMrgoDx0RALm/WkpVjy8BsX5BbhRUKTzfVHDhyF+1Ej4BwdC3tyKDkXfSYZAIEDSlPFoaWhCp4EsJvLmFmQePoHy6zcQNjQSblJ+FICuLCnFF/9+G5fPXTD4vvCYKMxevhgr/p6KCXOmY9+Pv/Rrf1ej1iBu1Egkjh+Nxtp6kyYzHe0KXL1wCWXXinUmk4hKGIbUF56As1gMVVcXLp7OxHf//QJHdvyG1qZmAMCd9/0JkfGxJl2jWqXC7m+3WC3/aaDPEIyMnkqDHPs4BuACAEjiBXo9RcJODB4Ui45O/RFwtyYPt6qnWK//b0xdNBen9h1CYe5lvP3ECxg3aypmr1jcE2Az554lqC6rxIWTZ3o+09Yqx6Gf9+DQz3vgE+CPmKQE5JzKNDpAxoxIwJK/3gv/EG2QQl1VDc4dOdnnfQGhwbj3Hw8jMOyPCFhVVxcObt2J/T/+0muwU6vVEAqF+OcX7+Hi6Uyc3Pc7Ci9e1nsNF09n4uqFXNz5P/dg3OxpnA7GyTx8Aj99/JXeSihOTk5IHD8K0++a3+t4w2/fb0fZtWLda1BDIxESGQ5VVxcKL17WGa2al3kek+bPwvxVy3A5Kwcn9hxEXuZ5s69fIBBgysI5mHTHTORn5eDK+VxcOHGmz/5zRFyMScE1f6yMNEGtVlvN7rR0ylp6aZ4uUYwmG9mPIUHxyLl23OB7PN19bCKKddW1en/n4uqK+fcux3fvfw5VVxdO7E1H5qETGDl5LMbNnIrw2Giseuoh/PCBMzIPn+jz+fqqGtQbCfMXikRY+fdU3Da1d+mz88dO95nNSz098MCL/4DM16fPd8xZeRfUajUO/NS7pmjOybNY/tB9SJo8DkmTx6H4SiEO/PgL8vR4Tx3tCmz5dCMuns7E8kfWsL5uny4O/LQDv32/Xa83FBkfi8VrUhASGd7rdaWiA0d37uvbF729kPL4g71y32o0GmQcOILt67/pU23lwE87MCw5EXG3jUDcbSNQVVqOze9+gvLrN0y6fld3N4REhCP3TBYO79hrsH+ueHiNWQf5rb2PTUE2rKWX5ulaPn0aALWenXAWuaClrd7gA1RclYeaRusHRXQoFJi1bJHe3wcPGYzrl6/2eAWqri6UXStGxsEjyDh4FKWF1xGbnIiwoZGoLq0wOZ8qAHj6eOHxN19E1PC+NQHTt+1EbUXvpdZZyxb1Cei5mfDYKJzYc7CXd9Qd2dgtbl6+Prht6gTEjR6JypIyvUEXtZXVOJt+DLHJI/QePWEbGo0Gv2zYjPTtu/SKzd0P3ofFa1Lg6ePV5/c5pzP7eOdCkQiPvPYswmOi+niaoVFD4OnjjdwzWbcITz3GzpwCV3f3nsnMhLkzIPP1Qf65C0aXLrs6u9BQU2s0KnnFI2vMTlJ/9UIecjPOWa0NJgxfCE93ymbDQtoArAe0y6cC8hTZR7Cv4Ywctsqd2KXs1BnccOvgo6uIcGNtHbKOnsJ373+O3d/+1JN6zRTiR43E2g/fgF+Q7uwfjTrEKnqE4VNEzmIxIuJi+nqsOrzhwVER+Pv/PY8/P/E3nQIBaJeC9/2wnTN9asdX3+HY7gO6JwwxUfjHf17FmBmT9S4LX79c0Oe1UdMmICh8sN6/OWbGZAQODjHpu8bNmornPnsboVFDBnyv4+dM7xONago1FZVWs7+TkwD+XqEg2O8p3iqKPswPYUeM5Ua0Ze7E+krDS5xefr5Y9dTDRpepFG3tOgNeenVGgQALVq/AmuefMCiguqIYncXGU7bpOneoVqn0DGJOSJ4yHms/eAPj50zXKRYtjc2c6E+Zh0/oXPrsFq6HX3vOaHaZBh2Th5iRw40IgROG6ojabajRvSwv8/HG42+9hGUP3dfvM6LRiXFYcv+qfn3WUKDXQPGTBUNso2T+hNn00r1bR7IIso/9MXZW0ZapomorjQ8U0YlxA67o7uXngyfe+Tduv2u+0fdKZH090/LrJUY/p+s9Ht6Glz9d3Fyx7G/3IfWFJ/vsIY6byY1Iwu40a7cy954lWPn3+3Vmk+kzedARgCJyFhn9nK78siqV4WCW8bOn46Wv/otR0yeaFdDkHxKI+9b+L4QiUf/6uhU9xRC/KBDc8BZvHX0pPIoD+JpYe9ESVJeZNlBMWzRPZ5YbU0gcPxrPfvymyXlTQyOH9Hnt2M79BiMHczPO9dmHFAqFCIkIN+lvDktOxD/+8yrmrLwLyVPG496nHsbYWdwQRV0BQbNXLMbsFYtN/g5duWFNCY4pK+wbrapruf1WXN3d8Kf/fQBrP3wDkQmxRj3HoPBQPPji0/1OOA4AdZU1VmuDYBJFttOzzi8iUeQe7i4ecBVLoFBaPwVaaWGRye9d+WgqqkrLUHWj3ESP2AkL7l2hN4mzPoaPva3PcuCNwiJs+eQrLPvbfX0y0JQWXsdPH3/V53siE4aZlfDcTSrBnJV3ca6/zFi6AAUX81BeVAInJyfMvHuhzmxEhgiLicSZ9KO9Xju17xCmLZoHFzfdS90VxaW4eiG376TGjH1Dv6AAPPzKs1Cr1bh0JgvnT5xBVWk5yotKIBAIEB4bjYQxyZg0f6ZJS+j6aKytM7q8T54irwkjUeQ4/l6huFGdb/bnhCIRZixdgBETxkDR1oaCnDxkHj7Rx4vqprKk1OTvdnF1xd9eXosvXnkH5UUlej2A26ZOQNTwYYgeHgeJp/kZeiITYhESEY6yot5eSMbBoyi+Uojxs6cjIDQYHYoOXD53AWcPHYeqq2/lkUl3zHCIviKVeeKJt19GZUkZ3KXufY6tmELC6GRsc9rUKzq0uaER37zzMe79x8N99oDrq2rw9Zsf9PHevfx8+hz3MAWBQIDh40Zh+DjrVLUz5PWGDY1E/JhkRCXEokPRgb1pW81Klu7u4mFyEXGCRJHoJ36yYLNFUSAQ4M9PPNhrmTMiLgbT77oD+3/8Benb+obrtza1oFOpNHkW7uElw5Pv/BsXTp7B5awclBeVQOrpAf+QIETEDUXcqJEDmtF3e5hL/roKH7/wep9Bt+pGOX75Ms3odwxLTrTaAMtGnJycBlTWy9PHC4njR/dKxgAAl89dwFv/+zwmzr0dwZHhUHepUJh7Gaf2HdLpeU1eMJuViQ90iaK7VIKlD65G0qRxvV6PiBuKz158EyVXr5n03aYk+ifYK4p0PpEznqL5TZU8ZbzOfT9nsRjzVy1HaNQQfPf+F+hU/pH2TKPRoOpGudmh8iMmjOn3HqMpDBk2FHf8eRl2ffOj+ROKoAD8+Ym/UScyk4WrV+DK+Yt9MhA11tZh9+YtRj8fEBqMyfNns/LeKop7i6J/SCBSn3tC57EgF1dXpDz+IN589FmTMuAE+1L8IpdEUUCiyE0CfYaY/Zlpi+YZFbLU55/o48npyjHKBm5fMh+L16SYVcUiPCYKD7/yLG9ymNoSnwB//PmJv5mVJaYbN6kE9z79iEkRq/bxFP9Y7g+OCMMjrz2v95xs98TK1ElfqP9Q6jwcGFL1iaI/2YYbDPIeDKHA9AEmKDwUwRHGV8ejE+OQ+vwTvcLaC3IusdYOUxbOwaOvv4CI+BiD73N1d8OclXfhoVee0XsgnzBO3KiR+Muzj5kV5enl54uHX3lG50F+NtCpVKKuorrnOXngxadNipAdNd14ggCRUIwg8hQ5JYo3j6oyAG5kG24gFIjg7xWCyvpik96vK5uLIWG859H7sfm9TwEApYXFrLbF4OgIPPLqc6i6UY7cM1moulGGlqZmOMEJPgF+iE0ajtikRJ1n5oj+CeMTb7+MHV99h0tns/WmZhM5izBu9nTM+9NSs6J8bU3F9RtQq9Xw8JLh/n8+ZZIgdj8nAoHA4BJqiF8URELqdxxAzGhgk0iXUhLcIMg30iqiCGj3H2srqvDb99vRUFsHjUbD+soQAYODETA4mDqGDfANHIS/PPsYGmrqkJtxDtfzCyBvboWz2BmePl6IiItB3KiRcOfAMnXxlUI4i8X4y7OPmZXk3VksRmB4qN5Ia0Cb4J/glLfYSxRp6ZRzohiBrKu/myYYoeaLxcxld6Iw9zIKcvJQU1aBQaEkOERvvP19MXnBbExeMJuz91B8pRBLH1jdq0yWqQwKDjIsioEJ1Em4gz+AfAF5itwWRVPxCTB/zqM9wvE3SD09kH08gwxO8NPrDfDHmBmT+/VZv6BBen/nKpYgwHswGZhbnmKvQBtKBM61h9kzEK5i48tTzmJxv9NfeXjJcM9jD+DqhUtkcIJ3yFtaB5SlyFDyiYigBKN5jAlWIbtVFGVkE27h5CRAWECs0fcNdF9nWHKi2bXpCIILiESificQB3TnhO1m8KAYMjC38CFR5AGDBxkXRVfJwIOKZy27s1eBXoLgA/rytpqKoRWYqOCRZGCOe4q0fMpBwkyYjfbnsPWtCEUidHV2kcEJ4iac9DxbnhIfm9Y9JchTJBj8vUKN7is21TVY5G8NpCwPQfCRZj3PVuzg0WQcHniKJIpcnKk6CYyWpWlrlaOtVU7GIggLo68Id8zg28g4PBBFKdmEm0SFjDD6nlsTHhMEMXAqivuWVnMVS6h+IjeR3iqKlIuIq6Jowoa+oQPGBEFYThQjg4fTUQxuIiZPkSd4Snzg72W4Vl5hbj4ZiiAsSGNtHRpr6/q8Hhc2lozDE0+RRJHT3qLhJdRruZdNqv1GEIRp6JpoioRiynfKI1Gk5VMui6KRfcW2VjmK8q6QoQjCQlw4cabPa+EBw6gqBneh5VM+EeIXBbHIxeB7so6eIkMRhAVQtLXjyvlcsyenBLc8RYLDqDVqdKoMZ5zJPHQCLY1NZCyCGCCn9h1Cp1LZ5/Ug30gyDschUeQJTa210GgM7xl2KpU49PMeMhZBDABVVxdO/Jau83f1zZVkIB6JopDMwV0a5bUmz3Bbm1vIYATRT07sTUd9VY3O39U2lZOBuAvtKfJKFFuqTXpfh0KBLZ9sJIMRRD+orajC3rRten9f30KeIodxu1UUCQ7TLK8z+b0XT2fiTPoxMhpBmIFarcZ3//0CHQqF3vfUkafIeUgUeUJLu3lJv39e/63ObBwEQehm97c/oTi/wOB7Glqqje7tEySKhA2Qtzeb9f4OhQJfvfE+7S8ShAlkHT1lUpCaSt2FlrZGMhhPRLGVzOE4niIA1FfV4KvX34eqi+okEoQ+ivKu4PsP1pv8/ua2OjIaN2m/VRRVZBPu0qbon8dXnF9g1gNPEI5EbUUVvl73gVkTx2Z5PRmOmyhvFUWCo6jUXVAo+18vMevoKez/8RcyJEHchKKtHRv+7z2ztxj6s2pDsAcSRR7Q2dUx4O/47fvtKMjJI2MSBMOPH32JmjLzj1i0tpEo8kUUaU+Ro3Qo2y3yPZvf+xRtrXIyKOHwZBw4ggsnz/Trs81ttHzKUVpvFUUl2YSjotjZZpHvaWlswo8ffUkGJRya2ooq/PJlWr8/395BE0uOoiRPkS8taYHl024uns5EYe5lMirhsOxN22bwgL7xSWo7GZEnniK1JGc9Rcs23a5NP5JRCYekvKgE2cdPD+g7FEryL0gUCV5RcvUaLp7OJEMQDsfOTT8M+DsUtHzKVWj5lC9o1JZPK7UnbSsZlnAoivKu6CwcbPbI2tVBqd544ilS9VmuTm8suKfYTdWNcvIWCYfCkmd1rfFMElaniUSRMMiBLb+SEQiHoLTwukW8xB5R7FSQUXkginS4hugzUGQdPWXWZxRtbWQ4gnP8uvF7i36fRqMho3KPegAQkadIGGJP2laMmDAaQpHI6HvVajUObtmJBatXkOH6gVqtxvXLV1GcX4CmugY4CQTwDw7A0BEJ8A8OJAOZQWtzC6SeHia9Ny/zvMWPIanUlGSfq54iiSIPEItcrDd1qqrBnrStWLh6pdH3lheV4OS+30kUzaRTqcSxXQdwdNc+NNc36nzP0BHxWHDvCoRGDSGDmUDm78cwbfEdRt/XoVBg62ebLP73u1SUC4WrniItn/IAJ4F1U9ge2fEbivKuGH1fxsEjULS1m73k6sgU5OThrf99Dru++VGvIALA1QuX8N9nXkH61p1kNBMmGQe37kRp4XWj7/15/bdorKVST8QfjuHNo2kl2YTQhVqtxtfrPkBTvf5Ex031Dcg8dAIAsPvbLWQ0I2g0Guz/aQc+e+lN1FfXmtYOKhV2b96CrZ9+TXtWBjh35CTaWuX47fvtBt93Ym86zqQfI4MRvTTwZlGsIZtwE2sun3bT2tyCD555FeVFJTpFc8snG3tSYzXU1OLapSvUMAYmGVs+2YjfvtvWL3E7ue937NlMEw+9YrcnHYB2rzDz8Amd70nftgvbPt9ktWtwcXanhuAeNeQp8gRnkatN/k5jbR0+ePZVnNib3lNjrq1Vjm/f+QR5med7vXfn199Tw+jh5/Xf4vSBwzp/JxAKkTD2NixcvRJz/7QU/iG6A2x+374bOafoHOmtFF68jLKi4p7///GjL3F894Ge/6+6UY7N732K3d/+RMYidHqKtwbaKAGIyTbcwsXZzWZ/q1OpxLbPN2Hb55vgE+CP+irdCwwlV6+h6kY5AgYHUwPdxLkjJ3Fib7rO30XGx2JxagpCIsJ7Xpu5dAF2b96CQz/v6fVejUaDnz7+EkNHxMPV3Y0My3Bk575e/6/q6sL29d9ix8bv4S6VoKWR4gkJnSihY0+RvEWuiqLYPoOiPkHshpb4+nLx9Dmdr9++ZD4eeuWZXoLY7TkuXL0Ss5cv6vOZtlY5Sq9dJ6My1FZU4dKZLJ2/U3V12VQQ7fVMEgPzEkkUyVO0Krlnsiiy7xZkvt59Xlv4Pyux4N4VcHJy0vu5OfcswYgJo3u9JhQK6fziTRz+ZS9rApCEAiE1CE9EsYRswz2EAhGEAhHrrkuj0VCquFuYefdChERqvUEnJyfM+9NSTDfhPJ2TkxNWPJKK2KRE7UTI1RV3/+0+yHy8yagA5M0tOHvoOGueR5GQdqE4Ro/2iUgU+YHEzRPNcvYdNT2TfgzzUu42ObsI35HKPPH4Wy+hurQC7h4SeHjJTP6sq7sb/vqvp9DWKoeLq4tJWYYchaO79qNTyY4D82xduSFME0XyFHmCuws7RUfV1YWjv/5GDXSL1xcwONgsQezV1lIJCeJNdCgUOLZrP2uuh/YTSRQJNniKrjLWXtux3Qd6zjAShKU5secgFG3sqZFuqyNShEUp0yeKZWQbjoqiG3tFsaNdgdP7D1MjERans0OJwzv2suqa3F2k1DA88hQLyDbchK3Lp90c2PIrVF1UOYCwsJf4Wzpam1rY9Sy60v45BynQJ4r1oMTgnMRT4sPq62traUXWsdPUUITlvESlEoe272bddbF5K4PQSS/dExhSTII7yKT+rL9GOsxPWNRL3JuOlqZm1l2Xhzsdk+EYRTf/j8DYGwiOeIruPqy/xqa6BlzMOEeNRQyYjnYFft+2i5XXxvatDMKwI0ieIl9EUeLLievctelHaixiwBzdua8nKT37nkUfaiCeiWI+2Yh7iEUunJih1pRXUlkpYkC0tbTi0C972DtBdfelRuIW+cZE8RLZiJt4ewzixHX+vOFbaiyi3xzcupNV5xJvxslJAKm7FzUSt7hEniJP8eKIKJYXlfSqeUcQptJQU4fjew6w9vo83L1YmYeYGJin2AoKtuEkvp7cqZiw9ZOvqcEIs9n97U/o6mTveVeZxJ8aiVsUMZpnUBT7uJMERzxF6SDOXGtJwTVU3qAESoQZfebqNWSz/KwrV7YwCP1aR6LII/y9Qjl1vT98sJ4ajTAJjUaDHV99x5p6ifrw8aT6llwXRX2L39lkK+7h7TEITk4CaDRqTlzvjYIilBeVIDgijBPXe/F0JnLPZKGiuBShUUMwYsIYxIxM4Ez/6FQqcXz3QZRcvQZ5cwtCo4Zg7MypCBgczPprP3fkJK5fvsr66/T1IFHkGNkkijxGKBDBTxaMmsZSzlzzd//9HE+99yqrr1HV1YWvXn8fl7Nyel4rLbyOU/sOYcyMyVj59/uNfkdXZyfkzS1obW5BS2Mz5M0t2v9vatb+NLdA3twKoVAIdw8p3D0kkHh4QOIphbtUComHRPu6VAp3D+3/C4SmV3evr6rBF6++g5qyngLjKMy9jGO7D2DxmhRMnDeDtfZXtLVj59c/cKI/+8qCaSDiqSjmA2gHQIXBOIa/VwinRLGiuBQFF/MQPTyOtde4J21rL0G8mTPpx+AsFiM8NrpH9Fobm3pETt7cgpbGJnS0W750lqu7GyQeUkg8PeAuZUTTQwp3qQQSj27xlMJV6o6tn27qJYg3C/7P679FaNQQhA2NZKX99//4C1oamzgxKfWS+tEgxB3aoeO0hT5RVAHIATCW7MY1UQwFwK3E29+//wWe//wdODk5sdJLOb77oMH3nNibjhN70+1ybYq2dtRV1Qzoe9RqNdK37cJ9ax9lnf0rS0pxlEUFhA3h4xkIJycBDULcIYfRul4YasFMshn3GOQdxrlrbqyrx6n9h1h5bfVVNehUKnnfbypL2Lm68PP6zVCrVBx59gbTAMQtdGociSLPCODog7nz6x/Q1tLKuuty95A4RL+ReLIvRWDm4RMouJjHoWcvDAT3RVFEosizwc1VBg93b7S0NXDqujvaFfj16+9NClqxJV5+voiIi0FR3sDytQqEQkg8pJDKPCDx9ICHl0y7HyjzhNTTAx5enpB4eEClVvXsRba1ytHW0qr9aZVDzvxb3tKK9la5RY8nJE1i105Ja1Mzdnz1Haf6MHmKnCPDXFHMgfakv5Rsxy2CfCM4J4oAcPb34xg7Yyoi4mNYdV0rHl6Dd5/6l8FlVIFAgPFzboeHt6yXyElkHpB6esDdw7KPkUaj6RHLbqHU9f/1VbW4UWg4QVVUwjBMmj+LVTb/ef1myFlaBUMfXDsn7OC0Qs95fEOiqGKUdAbZj1sE+oTjyg3u1S3UaDTY8tlGPPnOvyEUsSd/pH9IIJ5859/YsfE75GWe1/ketVqNwLAQmx1tcHJygsTTw+iy597vtukVRVd3N0ycNwOzVyyGQMCeAJHcM1nIPs6tYDGZ1I/qKHLPS1SZK4oAcJJEkYueYiRnr73qRjkObPkVc+9Zwi4vICQQqc8/AbVajcriUuzY+B0Kcnrvd+1J24rh426Dp7cXK665raUVJ/b0jZxd+sBqxIxMgF9QAOvaX9HWjm2fbeLgRHQIDTzc4qS+XxibHmaQ7bgoihGcDg1P37oTFcXsjIYUCAQIjgjDHSl39zlC0t4qxzfvfMyaaMk9aVvR1irv9Zq7VILR0yexUhABYOemH9BUz72l/xC/KBp4uEVmf0XxGNmOe7g4u8GPw5k1VCoVfvhwPatD8cNjozF25tQ+rxdduoKtn22ye47Oi6fP4dS+Q31en3rnXIhdXVhp08vnLuD0/sOcnYgSnOJwf0WxHtqAG4JmrjaltPA60rfvZvU1Lli9AjIf7z6vnz5wGD998hVUdhL1wouXsfk/n/YRZpmPN6YsnMNKW7Y0NuOHDzewPuG3LpycBAj0CadBhzvkMNrWL1Ekb5GjhPoP5fw97P/xF5RdY28xYnepBKuefEhnkErGgSP4+Pn/Q311rc2uR6PR4NjuA/jilXfQ2dE3Uvau+1fBxc2VdXbUaDT46eMvOZHKTRcB3oMhEopp0OEOBjXNFFE8TDYkUbQHqq4upL3/GaszykTEx+Cu+1fp/F3xlUK89dhz2LN5q1X3yTQaDa5euISP//k6fl7/Lbo6O/u8Z+zMKUgcP4qVNjz52++4dDabnjXCVhjUNNFAv4BgJzKpHycP8d9K1Y1y7Nr0o17hYQMT581AW0sr9n63rc/vOjuUOLj1V6Rv24mo4cMQGR+LkIgweHh7wV0qQaeyE+1yOWrKK1FaeB01ZZUQOYvgGxSAwLAQBA4Ogc8gP7hK3OHiqvXy1Go1WhoaUXqtGEV5V3A584LBgs1Rw4fh7gf/h5W2qy6rwK9ff8/pPjp4UCwNOA4mipXQrsEmki259rDG4NL105y/j+N7DmLYqJEYlszeLjhr+SK4SSX45cs0nQFCGo0GBTl5fY5x6EVHVQ6BUAiRswhKRYfJ1xWdGIfU555g1bnPbro6u7D5vU91LvVyylMcRJ4ih8hhNE0vpsbt074iBwkPiOPFfWg0Gnz/3y/QXN/I6uucdMdMPPTyWnj7+1rl+9UqlcmC6OTkhKl3zsVf//UPOLuwc79rx1dprN4zNgUfz0A6tM8t9hp7g6miuItsSaJoT1qbmvHtu59ArVaz+joj4mPw9Pv/hxlLF9jt6INfUADWPPc4Fv3lTxCaUYjYlmQfO22Xclv0jDk8RrcDRWZ8kQqAkGzKHWRSP3hKfNAsr+fF/Vy7lI9932/HvJS7WX2dYlcXzF+1HFPvnItT+w7h7KHjqK2osvrfDRsaiQlzZ+C2aRNYK4aAtkzVjx9/yYs+OXhQDAjO0A7A6EzMVFFshTYtzmSyK9ce2ljkFp3kzf0c3LoTEfExiE1i/xa3VOaJWcsXYdbyRai8UYZruZdRVlSCuspqtDY2o1OphNjVBWIXF3j5+yIgNBhhMVFQKjpQXVaByuJSVJeVo7W5BYq29l5LpxJPD3j7+2JwVARCo4cgOjEevgH+rLeJoq0dG9d9YNa+KFtxchIgIiiBBhnukM4Io0VEEdAuoZIocozIoEReiaJGo8Hmdz/F/677F2tTlekicLA2knQgqFUqdHZ29kShcg21Wo3N731qE6/ZFvjJguEqdox6mzzBpG1AgaW/kGCZKAYP53QeVF20tcrx9Zv88DbMQSAUclYQAWDHl2l6q4xwkajgETTAOLgo5gAoIbtyC1exhNN5UPVRUVyK7z/4gpNpwRyRE3vTcWz3AV7dEx3F4BSXTNUvc10I8hZpRssaLpw8i4NbfqUGZjlXL+Ti5/Xf8uqeREIxwgOGUeNyB5OT0JAoOoIohvB3mee377dzriCtI1FZUoqv3/yQ9UdpzCU8YBjlO+UWJmuXuaJoUvQOwS5C/KJ4GxCg0Wjww4cbUHKlkBqaZTTV1eOLV96Foo1/QwafJ5o8xKSjGP0VRbO+nGAHTk4CRAYP5+39dXYo8eX//Yc3UY18oLW5BZ+99Baa6up5eX9RwSOpkbmDWc5cf8IS08jG9BCzcRBe/+q7aG5opMa2M4q2dmx45V1Ul1Xw8v78vULhKfGhhuYOZmlWf0RxLwAl2Zlb8PFoxq3UVlTh85ffRmtzCzW4Hb32jW/8FzcKi3g8waSlUw6hggn5TgcqivUA9pOtuYWrWIIQvyje32dlSSm++PfbvNzHYv3o09WFTW9/hIKLeby+T9pP5BR7Gc2yqigCwA6yNT3MbKXsWjG+eOUdhzvcb29B/PrND3l1OF8X7i4eDjG55BFma1V/RXEL45YSXBJFB1r2Kc4vwJev/4fztfq4QFdnJzau+wCXzmbz/l5jw0bzfhuCT3M1RqtsIor1MHOdlrA//l6hkEn9HOZ+C3Ly8MUr79BSqhXpUCiw/tV3ee8h9kwsaemUS5i9dDoQUQQoCpWTxIWNdaj7vXYpH5+9+CbaWlqp8S1MW0srPnvpLRTk5DnE/VIWG87RL40aiChuBx3kp5kuB7hRWISPX3idjmtYkIaaOnz43GsOlTSBsthwinZGo2wqiv3+o4T9CPGLcsgzVpU3yvDR8/+Huspq6gQDpLTwOj549hXenkPUR2zYaGp87tBvp22gO8bfkO25hZOTwGGzcdRVVuODZ19FMaWE6zcXT2fi43++jub6Rod7boaGJlEH4A793t4bqCjuB1BJ9ucWceFjHPbeW5ua8em/1uH88QzqCGag0WhwcOuv+PrNDx3yqEtk0HAqKMwdKjGAQNCBiqIKFHDDOUL9hzrQA+7U55VOpRLfvvsJ9qZtpXqMJtChUOCbtz/Gns2Oa6+YwbdRR+CWl9jvI4OWOHCzgdqAYzLhJEBcuKNEoWog0HGuTKPR4MCWX/Hl//2HIlMNTblLSvH+0y/jwskzDv28kChyio0D+bAlRPESAFqL4hjRDrQ/otao9UYN5mWex3v/eJHXuTr7y8l9v+P9tf92uICaW4kIjKelU+6QASDH3qIIAJ9TW9CDzma6VEpI3bx0/q6hpg4fPvMqft++m5ZTAcibW7Bx3X+x9dOvKSMQgKHkJXKJAWuRpUQxDUATtQd3cMRoutb2RgT7RUEoEPX5nUqlwq5vfsRnL76J+upah+0XF06exduPP4+Lp8/p/L1QINK5HM3n52QYHcXgCk0AfmCLKLaDjmdwjmHhYx3unstrCzEiajI83L11/r7gYh7eefwFHN9z0KG8xuaGRmx66yNseutDtDQ263yPh5s3hAIh1Bq1w9iFlk45xTcABhwgYMkp3yfUJvTAc4HsgiOYlnQ3IoMTdf6+Q6HA9i++wUfPv4byohJe20KtUuHY7gN489FnDQbTRIcmQSgUQdnlWMcxaOmUU1hEgywpipcAHKZ24Q6OFYX6BxqNGvsyvsHtyctxe/IKncupAHD9cgH+8/9exvYvvoGch4WLL2fl4J0n/4mf13+rN2m62NkVs0evgry9CY2tNQ7VT4QCES2dcodjjAYNvN1feuklAEDbJYssFbUDWEbtwx3Ezi7IuXbc4e5bpVbhemUu5o5djbjwMSitKUCbolmHgGpwo6AIp/cfhpMTEBo1BEKhkNP3XnL1Gr7/YD0O/PSLQbEP9R+KFbc/iZxrx1BUketwfSQyaDhGRE2hQYIbPIsBRp0CgCReAKfufZOaLRYpjygGUAwgkNqIO17TJ7/8P7S0NTjk/UcFj8Dd0x6FWqPGyYu7cOrSbqjUXXrf7+nthel33YEJc26Hswu3kkMXXynEgZ924PK5Cwb3S8XOrpg28m4kD70dGZd/w6Gsnxyyb9w58QHEDxlHgwT7qQQQDmDAodL+y4QW9xRVAFwBzKB24gZOTk5oaWtAea1j5gNtaKmCWqNBRFACwgKGYWhoMmoay9DcprsMW4dCgfzsizi9/xDa5G3wDfCHm5S9+7JqtRq5Geew5dOv8dt321BbUWXw/TGDb8OyaY9hSGA8iipzsefUVwAc75iKSCjGggl/gUAgpEGC/bwB4JAlvsganiIA+DPeohu1FTeoqCvCpt9edWgbLJnyyE1ZSzS4eO0kDp/fgtb2JqOTitjkREycOwPDRo2AQMCO4wqNtXU48/txnN5/GI21dUbf7ycLxozb7kFEUAIzWajG13v/jY5Ox6wOFxc+FosmPUiDA/tpZ7xEi2x4+y8TQmSFi6yBNjT2AWovbhDkGwGZ1A9NrY57Pm/3qS8R4B0GmdQPgBOGR05ETNgonMrdjbP5+9GpJ+pSo9Hg8rkLuHzuArz8fJA8ZQJGTBiN0KghcHJysuk91FfXIufUWeScOovi/EKTjpRI3WSYOHwRRkZP7Tl/qOzqwPajHzmsIAJAfDgtm3KEbywliD0TXSt4igAQDyCX2os7HM7eilOXdjv85ODPs5/pE40qVzThZO5unC84jC5Vp0nfJfPxRkzScMSMTEBkQixkPt4Wv15FWzuu5xfget4VXM7KQWnhdZM/6+7igbHx85A89HaIRS69frf96Ee4cuOcw/YDV7EEf1/6rt6oZIJVJMBCUafW9BTBXOQOAIuozbiBi5hWuyvqinD0/HZMT17e63WJqwyzRv0J4+Lm4Wz+fmQXHIayU2Hwu5rqG3Am/SjOpB/VipCHFMFDBiMofDCCwkIRFDEYPv5+kHh6GL0uVVcXGmvr0VBTh6rSclQWl6L4SgEqikvNTjDgKfHFmNjZGBE9tY8YAsDZ/AMOLYiAdl+VBJET7LCkIHZjzZZ/i0SRO3R1dZIRAJzO24uwwDhEBg3v8zsPd2/cnrwCExMW4nzhUWQXHEJDS7VJ39vW0oqCnDwU5OT1el0oFEIq84TY1QUubq69vEClogPKjg69ZwjNIXRQDG4bejtiw0brTdNWUVfksJGmt4oiwQnessaXWlMUjzE/k6nt2I+hYwiOxq4T67FmwcuQuMr0eNXuGBs3F2Pj5uB6ZR5yrh3HlRvn0KUyPyJcpVKhqd46x2Gkbl6IHzIOiZGT4ScLNvhehVKOn499TP2A4Ard+sIpUQS0obI7qf3YjyMHVfTx6jpa8OvxL7ByxpNwMpj82glDAuMxJDAeyq4OFJRm4UppFq6V5+gNzLE2nu4+iA5NQszg2xA2KNbI9f/BzhPr0Syvp8YH0NVFlUE4wBvW+mJri+IuaLMMJFIbkqfIJYqr8nDq0m5MSFho0vvFIhfEDxmP+CHj0aXqRFltAa5XXsKNqiuoaig2OUCnPyIYOigGg5kfX88gs7/jdN5eFJZfoEbveRZUZAR2k8NoCydFEQBeBLCN2pHls2MVzY5v5eiFXzB4UCxC/Yea91AJnREeEIfwgDgAgFqtQlVDCaobbqC2uRwNLdVoaq1Bs7zO5ATbElcZZBJfeEp84ecVDD/PYAT6DoFM4jege6yoK8Lh7K3U2L1WTdrICOzmRWt+uS1EcTuATACjqC3Zi6NVPzAFjUaNX098jr/c8dKAqokIBEIE+UYgyDdC52SkvUMOhVLex0MRi1zgKnaHm4vU5GVQc9v81xOfQ+NApaDIU+Q8mYymcFoUu5Wd9hZZjFpFy6e6aJbXY8/pjVgy5RHrPIBCMTzcxXrrO1qT38/9YHL0rCNBqyas5t/W/gO2ykm1C0AGtSd5ilzkyo1zuHT9NK/uqbD8ArILqNKbzmehk54FlpIB7dlEXogiALxAbUqzY66y/+xmKJRyXtxLW0cLdp/8khpVD2oKOmMrNtEQW4riflARYhaLIh3eN4RCKce+M9/y4l5+y9iEto4WalR9niKtmrCRw4yG8EoUAStHDREDGQgUZAQj5BVnoKA0m9P3cOn6aYdP42Z8gkirJizEZtpha1G0mdoTZg4ElObNJPad/ZaziQ4USjnSz/1AjWgEOrPLOmy6ymiP4m+0t0gDAWdpaWvAqVxuVhM5nL0VckUTNaIROpSU3clRvUR7iWIGrJiNgOgfdFbNdM5c3se5owylNVcp2tREaH+dVewCcJLvoggAjwOghXsWQcEF5nnVBzO/49T17jm9kRrODHsR7BiWGK2wKfYSxQIA71KbE1ylsPwCZ/KFnrm8D/XNldRoBNd4l9EKhxBFAHgNQA21O82MucrBzO9Ybzu5ogknL1IyKXOgijGsoJ7RCJtjT1FsBR3RYAW0h9I/GlqqkXPtOKuv8XjOr7Q0TnCRFxiNcChRBIDPAWRT+xNc5WTuTtZ6iw0t1RRc0w8o6MzuZDPaYBfsLYoqAI9SHyC4SrO8nrXe4qHsn2iA7weUyMLuPMpog0OKIgAcA5BG/cCOg0AnDQJ88xbLagspcw3BRdIYTbAbApYY4gXQEQ27odFoyAgD9BZzi06y6ppO5OyghiE4Nz8HC+JM2CKKRaAjGgSHYdPeXW1TOa5VXKRGIbiGXY5gsFUUAW3xyALqFwQXqagrQmV9MSuuJTP/ADXIQNwVqqdoDwpgpyMYbBbFdlDQDcFhLhQetfs1tHW04CLLlnK5BgUn2YVHYacjGGwWRQDYCwq6ITjKpeun7H4m8ELhUSp9RHCNNGbsZwUCFhroKWizGRAEp+jobLdrvUWNRk3nEgmuUc+M+ayBjaJYCeD/UV8huEhh+Xm7/e2y2kI0tdZSIxBc4llmzCdRNMIGAOnUXwiucb3ikt3+9qXrp6kBCC6RDjtmruGaKALA/WDJxitBmEpbR4vdKlLY00slCDNpZcZ41sFmUSxiXGuC4BQVdUU2/5vN8no0y2krnuAMzzJjPImimXwIgCIHCE5RZwdPsbgqjwxPcIXDzNjOSgQcMOBfADRRP7IeYmcXMoIlvba2OtsLcVM5GZ7gAk3MmM5auCCKRQAepr5kPZycBGQEC2KPIrU1jaVkeAshEorJCNbjUbB02ZRLoghoD3fSoX6CE2jUts+I0tbRQoa3EEKhkIxgvXH8G7ZfJJdchIfZPsPgKi7ObmQEC2KPrDb28E4JwgxKwJEVPy6JYhOA1bBj8UmCMIXqhhKb589UU75Oi0HLpxZHBeDP4EhsCNc2k44BeIP6mP0HgttiZjiUfVzFEjy0+C1EhyaZ5LU1tFTb7No0GjUUHXLqxBZCKBCRESzLG7Bz4WA+iyKgLUKZQf3M0gOB6fsofrJgTB251KECdIJ9I+Ap8cFdkx9CiF+U0ffX2jAatLap3OTlU1exxOH6tlhE0dV2JAPasoCcgYujWrcrTtluLIiL2PR9xQkJC+Hi7AZfz0CHsY+bq0ePFzFnzCqj729otZ2nWN1ww6T33TX5Ifz1ztccql87OQkwLWmZec8C7bFbilZmrOZU2RauTvULQMc0LD54mIK7iwdiw0YBAIJ8IxzI23Dt+fcg7zAMHhRr8P3NctudVTQlWcDo2FmIDRsNdxcPyKR+DtNuAd6DMTJ6KjwlPiZ/hpZPLcbD4GDheC6vf30DbeJwwsKDviFGRE3pGTQCfYY4jid9i/cQFz7G4PvlimabXZuxZAGeEh9MT15+0724O0y7DfIOg1Agwphhc03+jEjoTAPCwNkADhy/4Jsods9EMqn/WUIUTdt3GRE1peffvrIgxxHFW5aXhwQmGHy/LQNfGo0E9SRFT+vl/TjS8mD3akZi5CSTg8nEzq40IAyMTHB4JY/roqgEsBRADfVDy3pCugj0CYe3x6Ce//fxcJw9xVsHVG+PQQZtplJ32ezajB3cjw5J6tcEiA/4e4X29G9j3n3PoCigw/sDoIYZk5VcvQE+hA+WQLuZS+cXB4CzCbPj2LDRvf7fw93bYaIZdUXn3jxBuBVbnlNsN+CVSlxlPcKgz+t1BFHs9hYtNUEkdM8FmbG4hNMT4J7Os4zTs6P9NVtUzwJ4k/ql9TzFuLCxfV7z9QxEWW0h7+2ja89VJvVHZX2xzvfb8riKIQEO9AnX0daOsafoKfHp5RWH+g+Fp8THaIktU/fXiT684L9MuJ/rN8Gng2ZvAdhC/dI6oujtMUhn1KKjRDI661hyNGQztgRr6GofRwkk8fMM7jNRuXUpWeezICZPsR9sAU8Sq/Dt9PVfAFyi/tkPUTQyEOgLLPF093VY+xgSRTcXKSuu28Pd22E9IR8d52jjwscOeIJI9OESWF4OypFFsRXaTV6qv2gmEleZwd9HBg3XLYpmnP/itifdd8nR0Hk2qZsXKyY0uvZ8nR2kfqZM6t/ntRC/KKOBRo50ZMUCNDFjLm+SqfAxT1c+KHG42bgZCZgJHTRUjyg6iKeow3swtJfnpWNAtqVgG/IKHSX61NO974TNyUlgNPGCq4uEBgTTUDFjbT6fboqvySt3QFvMkjARQwOBj2eg3ihTdxcPxxhgdXjEhkpE2fIMp4eZXqmjeEK6lo4BIDI4cUATRKKHR5mxllfwOaPzJ9AG3xAmYEjcDCXAdoT9F3cXD51Lpfo8RScngU2z/XgZOBqi835cHXciAwCh/tH9fhaIHt5ixljewfcyB8/ycSZjDSRu+vcUDQ3wzg6wFKfPNu1K3ecD/WTBNp0sGGqfjs62vvfj6unQEz1/r1CDS8huriSKRtjBjK28hO+iqAJwD6jUVL+9IQAY5D1Yv6co5v9SnL5jJ/pSuUUFj7Dp9ek6i/iHN6sxawLEF8QiF71nRZ2cBAjWs/ohEoqp1JRhMpgxlbcxG45QEK8dwEJwMFu7rdG33DTIO8zg4MN3/GWhOl+XK3QHOZuaTsxS+MmC9e75tiladE6A+F5d3tnIsZNbs/x04+HuRQOBfgqYsbSdzzfpKFViawDcATqqYRBdxzI83L2NCh/fhVFf3ciWtgadAmVoEmENnJwEGBqapHtGqNQdKe/D81qYxs7d6ltyNnY0yYFpYsZQ3ueZFjhQoxaA44lq7eEpekmNB3Hw3evwlQX3ea2js11ntfvx8fPtco235qX9w5ttNkvo+YKxiZq/V4geT9GbBoK+dBdecIjVNoGDNW466AyjXmQS/34NniIRf9OGiYRi+Ok4XtHUWqNzQB1m46XTboYExuv0chr0lJXSJwp8ajdD6POUbZl0gSN0n0VMd5QbFjhgI/8A4H7q66Z5D6aE+/M5bVigT7jOAVZXtfvpScvtVrVdKBBh9LBZfV5vlusuQMz3sl/GPEWhQKTTK7Rl0gWO8CAzZjoMAgdt6I0AHqf+3htdy6e6soL0nZXz11MM9dedyaextbqPpxY/ZJxdr/W2mJl9Am4USjkUOo6OBBs4e8oLT1FkfElf19aAuWc+ec7jADY42k0LHLjB3wfwAvX7m7wHHZ6iScunPN5T1JferqrhRs+/Pdy9sXCi/RcfxCIXTB25RIeA1/Z5zcPdm9cVTkyZqOnq26ZMAh2EF5gx0uEQOHjDv8b8ENBG3t164FlqQuABX6NPRUIxwgOG6fxddYO2jqqLsxuWT3+cNVGLyUNvR3hAXK/XGlqqzPKC+YApS/q3eoVOTgKDhaNpXCRRpBmRA3Lz+S2hQGRSyitnZ37uKQ4JitfpBXd0tqOhpRoioRhLpj6i98ybvVg0+cFeg3tNY5nDiaJAYLxoupekt6fsJfWz254wi3D4FTQSRS2PwwHXznVxc/YaiZtp6cD4mkA5Lkx37b3K+uvwlPhg9dzn+3hlbMDdxQPLpz/RM6Hp9mpvJTIo0aE9xVsz+9j6fCkL2QCKtSBRvIkHAaQ5uhECbhoYTF0SdOWhKIqEYkSFjND7u9VzX2Cdh3gz3h6DsGz6Y3AVS1DdeEPnezwlPrz1Fk0p/3Rr/+b7MRUjpDFjoMNDovgHKmirRzu0MAb5RuidSQ9kAOIakcHD9Sb1DvGL4kTmkyDfCNw3719wFUvQ1tGi8z36Dv1zHVNWL25N6aYvnZ+DCCKd3yZR1ImS6RwOu5R6c+1EU5dF2bB8aqxwrLmMjp3Fi/aUSf2was5zen8fE3obL/uxKVVKREJxr1UOW5b7YhEbSBBJFE3xGO8H8KGjGqC76oKpdeXsXVNRJBRj6dRHLFYHL8g3wuIia0/EIhe9tvGU+LByX3SgmLp6IWVWQySuMr0J8XnMh8xYR4JIomgSj8JBw5JD/LRFWE2tK2fv5dPwgGFwFUssdu5uzLA5DtXeI6OnWk6MxBK7JzHQTtRMK2nmxkwWQvyjHO0xf40Z4wgSRbN4ATwupmnMUzR1WdTDzb5JlLsDYjwlvgP+Lk+JD4bxdJ9NH8PCRlvMSwodNBRTRyy1+z2ZvPTPTOgM1aTkIc+CEpeQKA6ANxxtRhXMzJpNDbSxd9HaqOCRZg2Ehpg2cpne4rR8xclJgDHD5lrku7wkfpBJ/ewemWvyKgfTZ4J8Ix2luR9lxjSCRHFAfAhtZKpDrL27u3jA3yvUrD1Fe6V6C/Uf2uPlDFTMQv2HsmLpzx4kRU+1SNmk7glSVPAIu92LSCg2OctSdx+/Oeqap3RH1ztsrASJouXZCODPcJB6jEMC481aUrNXxfKbzxI6OTkNyFuaPTrFYTu3SCjG9KTlA/6e7qCrODuV0DK3L7q7esDHM9DuwWJWpjuqfiMN4ySKluYHAHMA1PP9RiePuMuss3j2Ord3s0fSpeocgKc0zeEzmsQPGTfgw/zdKwaDvMPsFs1pbr/lY/TtTdQzY5bDJyYhUbQehwGMA1DE55s0N8m3PfYVPSU+vfauulT9c+L9ZMGYnrycejaA2aNTBrQMfXMbdO/12lwUzeiLPp6BiA0bxdfmLGLGqsPUs0kUrU0BgIkAMsgUWm5NrmwbL7H3oNumaOmX+C+e/BBvK32YyyDvMCQPnd7vz6vUf2y760uTZ2083LxMfm+gTzhfPcUMZowqoF5NomgrKgFMB7CFTGGZ4xBmi+Itg65c0Wz2d8wfvwZ+smBqwJu4PXl5v5eSb/YUwwOG2SUAS+ru7ehNuIUZmyqpN5Mo2pp2AMsBvOvohrB1wVpXsaRPrcOWtgazvmN07Cze5v4cCCKhGEunPNKvRO/y9qZe36OvHqVVJ2iOXSj4fWZMaqeeTKJoT56C9vyPw6ZLktl4+TQyeHgvL6Sjsx0Kpdzkz8eGjaZ9RCOTnIUT7zf7cy3tjQa9eVvg7RHgiE2mYsagx6n3kiiyhQ8BLATQ6og372VjTzF+yPhe/1/TWGqWIN458a9UUNYIUcEjMGn4IrM+03qLtx4XPtbmyRBs3RdZQCsz9tAZRBJF1rEXwGgA+Y524yKh2CKHv03BVSzBkMD4foli/JBxWDzpQRJEE5k8YjFui5lh8vvrmiv7tFWYDZOruzi78bK+pwHymTFnL/VWEkW2d9Ltjnbj/jLbFGkdFja6j6hVN9wwSRAXTrjf4dK4DZTZo/9scikthVLeZ293mA0P8suk/o7UNNsddRJu1Qk+mcAqtAJYCuBpAK8DEDrCTft4BuJaxUWr/53hkZP6vGbMUxwfPx9TRy4hQewnM0f9CUKBCKfzjDsk1Y03eq0aDAsbjQNn06BSd1n9On09Ax2hOVQAnl2XlvrW29s2UuckT5FTvAVtNokaR7hZXxscbfDxDESIX+8yPxqNWq8oikUuuGvyQ5iWdDcJ4gCZnrwc4+PnG33frW3hKpbYLODGVxbE92aoATBnXVrqW9QjSRS5Sjq0Sxy8P+hvi/N+yUNv7/NaVcMNKLs6+rwe5BuB/5n3Lzp2YUGmJd2Nu4wkO9A1QUkYMsE2qxUevPYUMwCMXpeWmk49kUSR65QAmAJgA59v0trlgkRCMYZH9B1ci6vy+rxv6sgluHfOc/BxjOU0mxIbNhpr5v9bbw3CyvriPq9FhYywSX5ce5essiIbAExfl5ZaQj2QRJEvKAHcz/zw8tiGi7MbvD0GWe3748LH6IwsvFH1R5xBVPAIrJn/MiYkLKTlUisik/ph1ZzndEam1jdX9gm2EQpEGBE1xarX5OQksGr/sxOtAO5fl5Z6/7q0VDqQT6LI2xlfMni6nBroM8Rq3z02bl6f1zQaNUprrsLfKxR3T30Uy6Y/xseBkZUIBSLMHv1nLJnySJ+KGDeqr/R5/8ioKVadqPh7hfLtqE0GgOR1aakbqLeRKPKdAmiXU18Dz7LgWKtYa1TwCJ17ls3yeswduxpr5r+M6NAk6ll2IGbwbUhd8CrGx8/vEaVbl7S7vUtrBtzoW87lICpmbJiyLi2VEnrbGDqSYT+UAF4AsB/AJgC8KOZnrYFpXPw8na/LpH42z7tK9EUscsG0pLuRFD0Nxy/uwPXKXN3tGDcPBaXZJIr6KQGwel1aKpV7Ik/RMWE6/whoCxjzwlO09BLW4EGxGGzDrChE/5FJ/TB//Bosn/6EzvqWof5D+xypsZwoDuG6+X4AMIIEkUSRhDEttWldWuo9AFaD40E4IqHY4jP2aUl3UyfhGH6yYL1lo0w569iffufvFcJVc7Uy3uE969JSm6j3kCgSf4jjN4zXyOmZoiW9uujQJKt5FoR9iA5Nsvjec6BPuF1qN1qAw4x3+A31DBJFQrcwFq1LS50ObTkqTnqNoYOGWuR7hAIRbk+i8k58xNLePweX11sBPLUuLXX6urTUIuoRJIqEcXF8l/EaOZe9wlIV18cMm0OH73lKeEBcn0onbJiI2Yh0xjt8l3oCiSJhvtc4E8CDADiz12CJiuveHoMwYfhC6gQ85vbk5RY5tygSihE2KIYLt9wE4MF1aakzyTskUSQGJo6fAxgGDkWoDvQ82qzRfzaYX5PgPoO8wzAubt6AvyfEL4oL+4k/ABjGPMsEiSJhAWGsZCJU7wDA+llmVPDIfn/2tpgZiAwaTo3uAEwYvrBPNhxzGRIUz+ZbLAKwkIksraQWJ1EkLC+OewEkQJvxgrW5ED0lPv2KGh3kHYYZt62khnYQxCIX3DHuLwOcgI1g4621M89owrq01F3U0iSKhHWFsX1dWuoL0AbibGfrdZpbssnF2Q2LJz3It/yVhDFPLzC+38uo/l6hbKyMsR3aQJoXKIk3iSJhW3EsWJeWuhTAdADZbLu++CHjTA6kEApEWDL1EYo2dVCmjFzSr7OLLPMSs6Et77SUcpaSKBL2FcfD69JSk6EtS1XPluuSuMpMDriZP34NwgPiqDEdFKFAhMWT/gZ3Fw+zPpcYOYkNl18PbVRpMqVoI1Ek2CWOGwBEAngX2oTjdmfssDlG3zNnzCrEDxlHDejgyKR+WDb9MZMjSYN8I+y9sqBknrVIiiolUSTYK4xN69JSn4I2GMfu+42DB8VikLfuAiBOTgLMHbsayUNvp4YjeoRuydRHTNpXtnbRYiNshzaI5inKV0qiSHBDHLv3GyfCzllxdHmLYpEL7p72KJKip1FjEb2IDBqOBRNSDQqju4sHhkdMsMflpQOYSPuG/IXC/PgvjicBzFybsmEygDcB2HwkiR8yDhmX96G6oQSA9rD1/PFrKKiG0Etc+FhI3WTYevgDdHT2DeAcGT3N1gf2TwL4f+vSUo9R65CnSPBDHI+tS0udCGAOgAxb/m0nJwFmj06BSCjGjNtWYtWc50gQCaMMHhSLP89+ps/hfrHIBaOHzbLVZWQAmLMuLXUiCaJj4KTRaHhxIzVbVFwVK7v83bUpGxYBeBlAkq3+pkIph6tYQk8dYRYdne3Yf3YzcotOAtBW2LBGTcZbyAbw4rq01B1sts3b2zZSB7EwtHzquJ7jDgA71qZsWAbgXwASrf03SRCJ/uDi7IaFE+5H/JDxOJW7G2NMiGgeADkA/r0uLXULWZ5EkXBMcdwCYMvalA0LADwJYAZZhWAjkUHDrZkTNx3Au5SSjSBRJLrFcReAXWtTNiQx4pgCQEiWIXiMCkAaI4bZZA4CoD1FQj8hjDimApCROQge0QRgA7QH78u4fCP+y2jeamko+pTQRxmApwCEM/8tIZMQPOvTZWQSgkSR6M+s+l1o08fdAzsnAiCIfpDO9N1wpi9TBhqCRJEYMCpoq4fPBDAUwBsAasgsBEupYfroUKbP/sD0YYIgUSQsTgGAZwEEAVgOYC+ZhGAJe5k+GcT0UUrFRpAoEjb1HrcAuANAKIB/A6gksxA2ppLpe+FMX9xCXiFBokjYmzIALzIz9IXQLle1klkIK9HK9LGFTJ97ERQMRlgAOqdIWINdzI8bgHkA7mX+60amIQZAO7TLo98w/20nkxAkigTXBrHtzA8JJEFCSJAoEoQOgZQCWABt1px5AMRkHuImlIwApkG74kDL8ASJIsFruveDfmA8xhkAZgNYBCCCzOOQFAHYAWA/tOcKySMk7AKleSPYRgQjjrMZsaRlVv6uHKQzIriDEUXCTCjNG4kiiaJjIWaEcQaAJQCiySScpgDa5fN05kdJJiFRJFEkUST6TyCACTf9TCaTsJpjAE7e9ENnWEkUWQ/tKRJcohJ/BOt0e5I3C+QEAD5kJrtQzwjfzUJIniBBokgQNkQJ4DDz000sI45jASQyP1T6yrI0QVuhPgdABiOA+WQWgkSRINhHPvOz8abXwm4SyJt/COPk6PihzDEEiSJBcJgS5mfXLa+PYsQxAtr9yiTmv2EOaJ9KANnMf4sY8cukrkOQKBKE45BpYOCPB+AP7XJsNPPvRGgTD8Ry0HtuZYSuBtoo0Hzm35eoGxAEiSJBGKNbLA4beE8YI5ZgvEwhtPuX3UdHIqA/8EcM40u4OdAfrFKPP872FUC7z6divD0wgkfLnARhJrw5kkEQBEEQA+X/DwC0y8AOmTDsmQAAAABJRU5ErkJggg==</BINVAL></PHOTO>\n<EMAIL><HOME/><INTERNET/><PREF/><USERID/>\n</EMAIL>\n<TEL><PAGER/><WORK/><NUMBER/>\n</TEL>\n<TEL><CELL/><WORK/><NUMBER/>\n</TEL>\n<TEL><VOICE/><WORK/><NUMBER/>\n</TEL>\n<TEL><FAX/><WORK/><NUMBER/>\n</TEL>\n<TEL><PAGER/><HOME/><NUMBER/>\n</TEL>\n<TEL><CELL/><HOME/><NUMBER/>\n</TEL>\n<TEL><VOICE/><HOME/><NUMBER/>\n</TEL>\n<TEL><FAX/><HOME/><NUMBER/>\n</TEL>\n<ADR><WORK/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n<ADR><HOME/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n</vCard>'),('15999999012','<vCard xmlns=\"vcard-temp\"><N><FAMILY/>\n<GIVEN/>\n<MIDDLE/>\n</N>\n<ORG><ORGNAME/>\n<ORGUNIT/>\n</ORG>\n<FN/>\n<URL/>\n<TITLE/>\n<NICKNAME>num12</NICKNAME>\n<PHOTO><TYPE>image/jpeg</TYPE><BINVAL>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</BINVAL></PHOTO>\n<EMAIL><HOME/><INTERNET/><PREF/><USERID/>\n</EMAIL>\n<TEL><PAGER/><WORK/><NUMBER/>\n</TEL>\n<TEL><CELL/><WORK/><NUMBER/>\n</TEL>\n<TEL><VOICE/><WORK/><NUMBER/>\n</TEL>\n<TEL><FAX/><WORK/><NUMBER/>\n</TEL>\n<TEL><PAGER/><HOME/><NUMBER/>\n</TEL>\n<TEL><CELL/><HOME/><NUMBER/>\n</TEL>\n<TEL><VOICE/><HOME/><NUMBER/>\n</TEL>\n<TEL><FAX/><HOME/><NUMBER/>\n</TEL>\n<ADR><WORK/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n<ADR><HOME/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n</vCard>');
/*!40000 ALTER TABLE `ofvcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofversion`
--

DROP TABLE IF EXISTS `ofversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofversion` (
  `name` varchar(50) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofversion`
--

LOCK TABLES `ofversion` WRITE;
/*!40000 ALTER TABLE `ofversion` DISABLE KEYS */;
INSERT INTO `ofversion` VALUES ('openfire',21);
/*!40000 ALTER TABLE `ofversion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-01-18 13:12:20
