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
INSERT INTO `ofid` VALUES (18,11),(19,3),(23,1),(25,12),(26,2);
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
INSERT INTO `ofpresence` VALUES ('15999999000',NULL,'001417767055646');
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
INSERT INTO `ofproperty` VALUES ('passwordKey','EQ153H099zDK931'),('provider.admin.className','org.jivesoftware.openfire.admin.DefaultAdminProvider'),('provider.auth.className','org.jivesoftware.openfire.auth.DefaultAuthProvider'),('provider.group.className','org.jivesoftware.openfire.group.DefaultGroupProvider'),('provider.lockout.className','org.jivesoftware.openfire.lockout.DefaultLockOutProvider'),('provider.securityAudit.className','org.jivesoftware.openfire.security.DefaultSecurityAuditProvider'),('provider.user.className','org.jivesoftware.openfire.user.DefaultUserProvider'),('provider.vcard.className','org.jivesoftware.openfire.vcard.DefaultVCardProvider'),('update.lastCheck','1417771525903'),('xmpp.auth.anonymous','true'),('xmpp.domain','localhost'),('xmpp.session.conflict-limit','0'),('xmpp.socket.ssl.active','true');
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
INSERT INTO `ofroster` VALUES (1,'15999999000','15999999000',0,-1,-1,NULL),(8,'15999999000','15999843546@localhost',3,-1,-1,'15999843546'),(9,'15999843546','15999999000@localhost',3,-1,-1,'bigTom');
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
INSERT INTO `ofrostergroups` VALUES (8,0,'Friends'),(9,0,'Friends');
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
INSERT INTO `ofsecurityauditlog` VALUES (1,'admin',1417069732352,'created new user tom','H6M6CIH9R8A87AT','name = tom, email = null, admin = false'),(2,'admin',1417069754840,'deleted user tom','H6M6CIH9R8A87AT','full jid was tom@localhost'),(3,'admin',1417426059216,'created new user 15999843546','H6M6CIH9R8A87AT','name = snake, email = 123@163.com, admin = false'),(4,'admin',1417426089590,'created new user 15999999000','H6M6CIH9R8A87AT','name = Tom, email = null, admin = false'),(5,'admin',1417426109389,'created new user 15999999001','H6M6CIH9R8A87AT','name = May, email = null, admin = false'),(6,'admin',1417426126714,'created new user 15999999002','H6M6CIH9R8A87AT','name = Jay, email = null, admin = false'),(7,'admin',1417426161136,'created new user 15999999003','H6M6CIH9R8A87AT','name = Ben, email = null, admin = false'),(8,'admin',1417426179296,'created new user 15999999004','H6M6CIH9R8A87AT','name = Jason, email = null, admin = false'),(9,'admin',1417849603748,'added roster item for 15999999000','H6M6CIH9R8A87AT','roster item:\njid = 15999999000\nnickname = null\ngroupList = []'),(10,'admin',1417849608223,'added roster item for 15999999000','H6M6CIH9R8A87AT','roster item:\njid = 1361\nnickname = null\ngroupList = []'),(11,'admin',1417849991934,'deleted roster item from 15999999000','H6M6CIH9R8A87AT','roster item:\njid = 1361');
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
INSERT INTO `ofuser` VALUES ('15999843546',NULL,'2dd7e6d149e529996470a59bcc8fe63d','snake','123@163.com','001417426059080','001417426059080'),('15999999000',NULL,'27676b2ef1f41b66950f94a5b619f7e6','Tom',NULL,'001417426089456','001417426089456'),('15999999001',NULL,'ed83fba8d9821ce0dd557f6269995b42','May',NULL,'001417426109307','001417426109307'),('15999999002',NULL,'c7b77ef5550aa6d01dba7e252d11dbfb','Jay',NULL,'001417426126588','001417426126588'),('15999999003',NULL,'1f7972800b6909d9fb030e631f205961','Ben',NULL,'001417426161099','001417426161099'),('15999999004',NULL,'8c5eb18d9c282d9cde3e3f9da118e679','Jason',NULL,'001417426179225','001417426179225'),('admin','admin',NULL,'Administrator','admin@example.com','0','0');
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
INSERT INTO `ofvcard` VALUES ('15999999000','<vCard xmlns=\"vcard-temp\"><N><FAMILY/>\n<GIVEN/>\n<MIDDLE/>\n</N>\n<ORG><ORGNAME/>\n<ORGUNIT/>\n</ORG>\n<FN/>\n<URL/>\n<TITLE/>\n<NICKNAME>Tom</NICKNAME>\n<EMAIL><HOME/><INTERNET/><PREF/><USERID/>\n</EMAIL>\n<TEL><PAGER/><WORK/><NUMBER/>\n</TEL>\n<TEL><CELL/><WORK/><NUMBER/>\n</TEL>\n<TEL><VOICE/><WORK/><NUMBER/>\n</TEL>\n<TEL><FAX/><WORK/><NUMBER/>\n</TEL>\n<TEL><PAGER/><HOME/><NUMBER/>\n</TEL>\n<TEL><CELL/><HOME/><NUMBER/>\n</TEL>\n<TEL><VOICE/><HOME/><NUMBER/>\n</TEL>\n<TEL><FAX/><HOME/><NUMBER/>\n</TEL>\n<ADR><WORK/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n<ADR><HOME/><PCODE/>\n<REGION/>\n<STREET/>\n<CTRY/>\n<LOCALITY/>\n</ADR>\n</vCard>');
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

-- Dump completed on 2014-12-06 18:09:38
