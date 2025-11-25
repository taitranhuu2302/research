/*
 Navicat Premium Dump SQL

 Source Server         : opendental root
 Source Server Type    : MariaDB
 Source Server Version : 101110 (10.11.10-MariaDB)
 Source Host           : 4.193.202.124:3306
 Source Schema         : demo

 Target Server Type    : MariaDB
 Target Server Version : 101110 (10.11.10-MariaDB)
 File Encoding         : 65001

 Date: 22/11/2025 09:00:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `AccountNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AcctType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `BankNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Inactive` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `AccountColor` int(11) NOT NULL DEFAULT 0,
  `IsRetainedEarnings` tinyint(4) NOT NULL,
  PRIMARY KEY (`AccountNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for accountingautopay
-- ----------------------------
DROP TABLE IF EXISTS `accountingautopay`;
CREATE TABLE `accountingautopay`  (
  `AccountingAutoPayNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PayType` bigint(20) NOT NULL,
  `PickList` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`AccountingAutoPayNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for activeinstance
-- ----------------------------
DROP TABLE IF EXISTS `activeinstance`;
CREATE TABLE `activeinstance`  (
  `ActiveInstanceNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ComputerNum` bigint(20) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `ProcessId` bigint(20) NOT NULL,
  `DateTimeLastActive` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTRecorded` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ConnectionType` tinyint(4) NOT NULL,
  PRIMARY KEY (`ActiveInstanceNum`) USING BTREE,
  INDEX `ComputerNum`(`ComputerNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `ProcessId`(`ProcessId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 27 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for adjustment
-- ----------------------------
DROP TABLE IF EXISTS `adjustment`;
CREATE TABLE `adjustment`  (
  `AdjNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AdjDate` date NOT NULL DEFAULT '0001-01-01',
  `AdjAmt` double NOT NULL DEFAULT 0,
  `PatNum` bigint(20) NOT NULL,
  `AdjType` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `AdjNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ProcDate` date NOT NULL DEFAULT '0001-01-01',
  `ProcNum` bigint(20) NOT NULL,
  `DateEntry` date NOT NULL DEFAULT '0001-01-01',
  `ClinicNum` bigint(20) NOT NULL,
  `StatementNum` bigint(20) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `TaxTransID` bigint(20) NOT NULL,
  PRIMARY KEY (`AdjNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `StatementNum`(`StatementNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `indexProvNum`(`ProvNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `indexPNAmt`(`ProcNum`, `AdjAmt`) USING BTREE,
  INDEX `AdjDatePN`(`AdjDate`, `PatNum`) USING BTREE,
  INDEX `TaxTransID`(`TaxTransID`) USING BTREE,
  INDEX `SecDateTEditPN`(`SecDateTEdit`, `PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alertcategory
-- ----------------------------
DROP TABLE IF EXISTS `alertcategory`;
CREATE TABLE `alertcategory`  (
  `AlertCategoryNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `IsHQCategory` tinyint(4) NOT NULL,
  `InternalName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`AlertCategoryNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alertcategorylink
-- ----------------------------
DROP TABLE IF EXISTS `alertcategorylink`;
CREATE TABLE `alertcategorylink`  (
  `AlertCategoryLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AlertCategoryNum` bigint(20) NOT NULL,
  `AlertType` tinyint(4) NOT NULL,
  PRIMARY KEY (`AlertCategoryLinkNum`) USING BTREE,
  INDEX `AlertCategoryNum`(`AlertCategoryNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 72 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for alertitem
-- ----------------------------
DROP TABLE IF EXISTS `alertitem`;
CREATE TABLE `alertitem`  (
  `AlertItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `Description` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Type` tinyint(4) NOT NULL,
  `Severity` tinyint(4) NOT NULL,
  `Actions` tinyint(4) NOT NULL,
  `FormToOpen` tinyint(4) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `ItemValue` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`AlertItemNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alertread
-- ----------------------------
DROP TABLE IF EXISTS `alertread`;
CREATE TABLE `alertread`  (
  `AlertReadNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AlertItemNum` bigint(20) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  PRIMARY KEY (`AlertReadNum`) USING BTREE,
  INDEX `AlertItemNum`(`AlertItemNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for alertsub
-- ----------------------------
DROP TABLE IF EXISTS `alertsub`;
CREATE TABLE `alertsub`  (
  `AlertSubNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `Type` tinyint(4) NOT NULL,
  `AlertCategoryNum` bigint(20) NOT NULL,
  PRIMARY KEY (`AlertSubNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `AlertCategoryNum`(`AlertCategoryNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for allergy
-- ----------------------------
DROP TABLE IF EXISTS `allergy`;
CREATE TABLE `allergy`  (
  `AllergyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AllergyDefNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `Reaction` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StatusIsActive` tinyint(4) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DateAdverseReaction` date NOT NULL DEFAULT '0001-01-01',
  `SnomedReaction` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`AllergyNum`) USING BTREE,
  INDEX `AllergyDefNum`(`AllergyDefNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for allergydef
-- ----------------------------
DROP TABLE IF EXISTS `allergydef`;
CREATE TABLE `allergydef`  (
  `AllergyDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `SnomedType` tinyint(4) NULL DEFAULT NULL,
  `MedicationNum` bigint(20) NOT NULL,
  `UniiCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`AllergyDefNum`) USING BTREE,
  INDEX `MedicationNum`(`MedicationNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apikey
-- ----------------------------
DROP TABLE IF EXISTS `apikey`;
CREATE TABLE `apikey`  (
  `APIKeyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CustApiKey` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DevName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`APIKeyNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apisubscription
-- ----------------------------
DROP TABLE IF EXISTS `apisubscription`;
CREATE TABLE `apisubscription`  (
  `ApiSubscriptionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EndPointUrl` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Workstation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CustomerKey` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WatchTable` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PollingSeconds` int(11) NOT NULL,
  `UiEventType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeStart` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeStop` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ApiSubscriptionNum`) USING BTREE,
  INDEX `PollingSeconds`(`PollingSeconds`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for appointment
-- ----------------------------
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE `appointment`  (
  `AptNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `AptStatus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Pattern` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Confirmed` bigint(20) NOT NULL,
  `TimeLocked` tinyint(1) NOT NULL,
  `Op` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `ProvHyg` bigint(20) NOT NULL,
  `AptDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `NextAptNum` bigint(20) NOT NULL,
  `UnschedStatus` bigint(20) NOT NULL,
  `IsNewPatient` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `ProcDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Assistant` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `IsHygiene` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DateTimeArrived` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeSeated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeDismissed` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `InsPlan1` bigint(20) NOT NULL,
  `InsPlan2` bigint(20) NOT NULL,
  `DateTimeAskedToArrive` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ProcsColored` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ColorOverride` int(11) NOT NULL,
  `AppointmentTypeNum` bigint(20) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Priority` tinyint(4) NOT NULL,
  `ProvBarText` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatternSecondary` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrderPlanned` int(11) NOT NULL,
  `IsMirrored` tinyint(4) NOT NULL,
  PRIMARY KEY (`AptNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `indexNextAptNum`(`NextAptNum`) USING BTREE,
  INDEX `indexProvNum`(`ProvNum`) USING BTREE,
  INDEX `indexProvHyg`(`ProvHyg`) USING BTREE,
  INDEX `indexAptDateTime`(`AptDateTime`) USING BTREE,
  INDEX `InsPlan1`(`InsPlan1`) USING BTREE,
  INDEX `InsPlan2`(`InsPlan2`) USING BTREE,
  INDEX `DateTimeArrived`(`DateTimeArrived`) USING BTREE,
  INDEX `AppointmentTypeNum`(`AppointmentTypeNum`) USING BTREE,
  INDEX `Op`(`Op`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `StatusDate`(`AptStatus`, `AptDateTime`, `ClinicNum`) USING BTREE,
  INDEX `Priority`(`Priority`) USING BTREE,
  INDEX `UnschedStatus`(`UnschedStatus`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `DateTStamp`(`DateTStamp`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 52 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for appointmentrule
-- ----------------------------
DROP TABLE IF EXISTS `appointmentrule`;
CREATE TABLE `appointmentrule`  (
  `AppointmentRuleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `RuleDesc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `CodeStart` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CodeEnd` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsEnabled` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`AppointmentRuleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for appointmenttype
-- ----------------------------
DROP TABLE IF EXISTS `appointmenttype`;
CREATE TABLE `appointmenttype`  (
  `AppointmentTypeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AppointmentTypeName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AppointmentTypeColor` int(11) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `Pattern` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeStr` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeStrRequired` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RequiredProcCodesNeeded` tinyint(4) NOT NULL,
  `BlockoutTypes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`AppointmentTypeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apptfield
-- ----------------------------
DROP TABLE IF EXISTS `apptfield`;
CREATE TABLE `apptfield`  (
  `ApptFieldNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AptNum` bigint(20) NOT NULL,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FieldValue` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ApptFieldNum`) USING BTREE,
  INDEX `AptNum`(`AptNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apptfielddef
-- ----------------------------
DROP TABLE IF EXISTS `apptfielddef`;
CREATE TABLE `apptfielddef`  (
  `ApptFieldDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FieldType` tinyint(4) NOT NULL,
  `PickList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  PRIMARY KEY (`ApptFieldDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apptgeneralmessagesent
-- ----------------------------
DROP TABLE IF EXISTS `apptgeneralmessagesent`;
CREATE TABLE `apptgeneralmessagesent`  (
  `ApptGeneralMessageSentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApptNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TSPrior` bigint(20) NOT NULL,
  `ApptReminderRuleNum` bigint(20) NOT NULL,
  `SendStatus` tinyint(4) NOT NULL,
  `ApptDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `MessageType` tinyint(4) NOT NULL,
  `MessageFk` bigint(20) NOT NULL,
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ResponseDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ApptGeneralMessageSentNum`) USING BTREE,
  INDEX `ApptNum`(`ApptNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ApptReminderRuleNum`(`ApptReminderRuleNum`) USING BTREE,
  INDEX `MessageFk`(`MessageFk`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apptnewpatthankyousent
-- ----------------------------
DROP TABLE IF EXISTS `apptnewpatthankyousent`;
CREATE TABLE `apptnewpatthankyousent`  (
  `ApptNewPatThankYouSentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApptNum` bigint(20) NOT NULL,
  `ApptDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ApptSecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TSPrior` bigint(20) NOT NULL,
  `ApptReminderRuleNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ResponseDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeNewPatThankYouTransmit` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ShortGUID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SendStatus` tinyint(4) NOT NULL,
  `MessageType` tinyint(4) NOT NULL,
  `MessageFk` bigint(20) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`ApptNewPatThankYouSentNum`) USING BTREE,
  INDEX `ApptNum`(`ApptNum`) USING BTREE,
  INDEX `TSPrior`(`TSPrior`) USING BTREE,
  INDEX `ApptReminderRuleNum`(`ApptReminderRuleNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `MessageFk`(`MessageFk`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apptreminderrule
-- ----------------------------
DROP TABLE IF EXISTS `apptreminderrule`;
CREATE TABLE `apptreminderrule`  (
  `ApptReminderRuleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TypeCur` tinyint(4) NOT NULL,
  `TSPrior` bigint(20) NOT NULL,
  `SendOrder` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsSendAll` tinyint(4) NOT NULL,
  `TemplateSMS` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateEmailSubject` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateEmail` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `TemplateSMSAggShared` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateSMSAggPerAppt` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateEmailSubjAggShared` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateEmailAggShared` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateEmailAggPerAppt` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DoNotSendWithin` bigint(20) NOT NULL,
  `IsEnabled` tinyint(4) NOT NULL,
  `TemplateAutoReply` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateAutoReplyAgg` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsAutoReplyEnabled` tinyint(4) NOT NULL,
  `Language` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateComeInMessage` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailTemplateType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AggEmailTemplateType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsSendForMinorsBirthday` tinyint(4) NOT NULL,
  `EmailHostingTemplateNum` bigint(20) NOT NULL,
  `MinorAge` int(11) NOT NULL,
  `TemplateFailureAutoReply` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SendMultipleInvites` tinyint(4) NOT NULL,
  `TimeSpanMultipleInvites` bigint(20) NOT NULL,
  PRIMARY KEY (`ApptReminderRuleNum`) USING BTREE,
  INDEX `TSPrior`(`TSPrior`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `EmailHostingTemplateNum`(`EmailHostingTemplateNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apptremindersent
-- ----------------------------
DROP TABLE IF EXISTS `apptremindersent`;
CREATE TABLE `apptremindersent`  (
  `ApptReminderSentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApptNum` bigint(20) NOT NULL,
  `ApptDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TSPrior` bigint(20) NOT NULL,
  `ApptReminderRuleNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `SendStatus` tinyint(4) NOT NULL,
  `MessageType` tinyint(4) NOT NULL,
  `MessageFk` bigint(20) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ResponseDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ApptReminderSentNum`) USING BTREE,
  INDEX `ApptNum`(`ApptNum`) USING BTREE,
  INDEX `TSPrior`(`TSPrior`) USING BTREE,
  INDEX `ApptReminderRuleNum`(`ApptReminderRuleNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `MessageFk`(`MessageFk`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apptthankyousent
-- ----------------------------
DROP TABLE IF EXISTS `apptthankyousent`;
CREATE TABLE `apptthankyousent`  (
  `ApptThankYouSentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApptNum` bigint(20) NOT NULL,
  `ApptDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ApptSecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TSPrior` bigint(20) NOT NULL,
  `ApptReminderRuleNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ResponseDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeThankYouTransmit` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ShortGUID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SendStatus` tinyint(4) NOT NULL,
  `DoNotResend` tinyint(4) NOT NULL,
  `MessageType` tinyint(4) NOT NULL,
  `MessageFk` bigint(20) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`ApptThankYouSentNum`) USING BTREE,
  INDEX `ApptNum`(`ApptNum`) USING BTREE,
  INDEX `TSPrior`(`TSPrior`) USING BTREE,
  INDEX `ApptReminderRuleNum`(`ApptReminderRuleNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ApptDateTime`(`ApptDateTime`) USING BTREE,
  INDEX `MessageFk`(`MessageFk`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apptview
-- ----------------------------
DROP TABLE IF EXISTS `apptview`;
CREATE TABLE `apptview`  (
  `ApptViewNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ItemOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `RowsPerIncr` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `OnlyScheduledProvs` tinyint(3) UNSIGNED NOT NULL,
  `OnlySchedBeforeTime` time NOT NULL,
  `OnlySchedAfterTime` time NOT NULL,
  `StackBehavUR` tinyint(4) NOT NULL,
  `StackBehavLR` tinyint(4) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ApptTimeScrollStart` time NOT NULL,
  `IsScrollStartDynamic` tinyint(4) NOT NULL,
  `IsApptBubblesDisabled` tinyint(4) NOT NULL,
  `WidthOpMinimum` smallint(5) UNSIGNED NOT NULL,
  `WaitingRmName` tinyint(4) NOT NULL,
  `OnlyScheduledProvDays` tinyint(4) NOT NULL,
  `ShowMirroredAppts` tinyint(4) NOT NULL,
  PRIMARY KEY (`ApptViewNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for apptviewitem
-- ----------------------------
DROP TABLE IF EXISTS `apptviewitem`;
CREATE TABLE `apptviewitem`  (
  `ApptViewItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApptViewNum` bigint(20) NOT NULL,
  `OpNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `ElementDesc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ElementOrder` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ElementColor` int(11) NOT NULL DEFAULT 0,
  `ElementAlignment` tinyint(4) NOT NULL,
  `ApptFieldDefNum` bigint(20) NOT NULL,
  `PatFieldDefNum` bigint(20) NOT NULL,
  `IsMobile` tinyint(4) NOT NULL,
  PRIMARY KEY (`ApptViewItemNum`) USING BTREE,
  INDEX `OpNum`(`OpNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 250 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for asapcomm
-- ----------------------------
DROP TABLE IF EXISTS `asapcomm`;
CREATE TABLE `asapcomm`  (
  `AsapCommNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FKey` bigint(20) NOT NULL,
  `FKeyType` tinyint(4) NOT NULL,
  `ScheduleNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ShortGUID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeExpire` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeSmsScheduled` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SmsSendStatus` tinyint(4) NOT NULL,
  `EmailSendStatus` tinyint(4) NOT NULL,
  `DateTimeSmsSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeEmailSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `EmailMessageNum` bigint(20) NOT NULL,
  `ResponseStatus` tinyint(4) NOT NULL,
  `DateTimeOrig` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TemplateText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateEmail` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateEmailSubj` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GuidMessageToMobile` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailTemplateType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`AsapCommNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `ScheduleNum`(`ScheduleNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `EmailMessageNum`(`EmailMessageNum`) USING BTREE,
  INDEX `SmsSendStatus`(`SmsSendStatus`) USING BTREE,
  INDEX `EmailSendStatus`(`EmailSendStatus`) USING BTREE,
  INDEX `ShortGUID`(`ShortGUID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for autocode
-- ----------------------------
DROP TABLE IF EXISTS `autocode`;
CREATE TABLE `autocode`  (
  `AutoCodeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsHidden` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `LessIntrusive` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`AutoCodeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for autocodecond
-- ----------------------------
DROP TABLE IF EXISTS `autocodecond`;
CREATE TABLE `autocodecond`  (
  `AutoCodeCondNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AutoCodeItemNum` bigint(20) NOT NULL,
  `Cond` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`AutoCodeCondNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 38 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for autocodeitem
-- ----------------------------
DROP TABLE IF EXISTS `autocodeitem`;
CREATE TABLE `autocodeitem`  (
  `AutoCodeItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AutoCodeNum` bigint(20) NOT NULL,
  `OldCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `CodeNum` bigint(20) NOT NULL,
  PRIMARY KEY (`AutoCodeItemNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 29 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for autocommexcludedate
-- ----------------------------
DROP TABLE IF EXISTS `autocommexcludedate`;
CREATE TABLE `autocommexcludedate`  (
  `AutoCommExcludeDateNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `DateExclude` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`AutoCommExcludeDateNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for automation
-- ----------------------------
DROP TABLE IF EXISTS `automation`;
CREATE TABLE `automation`  (
  `AutomationNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Autotrigger` tinyint(4) NOT NULL,
  `ProcCodes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AutoAction` tinyint(4) NOT NULL,
  `SheetDefNum` bigint(20) NOT NULL,
  `CommType` bigint(20) NOT NULL,
  `MessageContent` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AptStatus` tinyint(4) NOT NULL,
  `AppointmentTypeNum` bigint(20) NOT NULL,
  `PatStatus` tinyint(4) NOT NULL,
  PRIMARY KEY (`AutomationNum`) USING BTREE,
  INDEX `AppointmentTypeNum`(`AppointmentTypeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for automationcondition
-- ----------------------------
DROP TABLE IF EXISTS `automationcondition`;
CREATE TABLE `automationcondition`  (
  `AutomationConditionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AutomationNum` bigint(20) NOT NULL,
  `CompareField` tinyint(4) NOT NULL,
  `Comparison` tinyint(4) NOT NULL,
  `CompareString` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`AutomationConditionNum`) USING BTREE,
  INDEX `AutomationNum`(`AutomationNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for autonote
-- ----------------------------
DROP TABLE IF EXISTS `autonote`;
CREATE TABLE `autonote`  (
  `AutoNoteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AutoNoteName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MainText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Category` bigint(20) NOT NULL,
  PRIMARY KEY (`AutoNoteNum`) USING BTREE,
  INDEX `Category`(`Category`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for autonotecontrol
-- ----------------------------
DROP TABLE IF EXISTS `autonotecontrol`;
CREATE TABLE `autonotecontrol`  (
  `AutoNoteControlNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Descript` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ControlType` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ControlLabel` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ControlOptions` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`AutoNoteControlNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 30 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for benefit
-- ----------------------------
DROP TABLE IF EXISTS `benefit`;
CREATE TABLE `benefit`  (
  `BenefitNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PlanNum` bigint(20) NOT NULL,
  `PatPlanNum` bigint(20) NOT NULL,
  `CovCatNum` bigint(20) NOT NULL,
  `BenefitType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Percent` tinyint(4) NOT NULL,
  `MonetaryAmt` double NOT NULL DEFAULT 0,
  `TimePeriod` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `QuantityQualifier` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Quantity` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `CodeNum` bigint(20) NOT NULL,
  `CoverageLevel` int(11) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `CodeGroupNum` bigint(20) NOT NULL,
  `TreatArea` tinyint(4) NOT NULL,
  PRIMARY KEY (`BenefitNum`) USING BTREE,
  INDEX `indexPlanNum`(`PlanNum`) USING BTREE,
  INDEX `indexPatPlanNum`(`PatPlanNum`) USING BTREE,
  INDEX `CovCatNum`(`CovCatNum`) USING BTREE,
  INDEX `BenefitType`(`BenefitType`) USING BTREE,
  INDEX `Percent`(`Percent`) USING BTREE,
  INDEX `MonetaryAmt`(`MonetaryAmt`) USING BTREE,
  INDEX `TimePeriod`(`TimePeriod`) USING BTREE,
  INDEX `QuantityQualifier`(`QuantityQualifier`) USING BTREE,
  INDEX `Quantity`(`Quantity`) USING BTREE,
  INDEX `CodeNum`(`CodeNum`) USING BTREE,
  INDEX `CoverageLevel`(`CoverageLevel`) USING BTREE,
  INDEX `SecDateTEntry`(`SecDateTEntry`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE,
  INDEX `CodeGroupNum`(`CodeGroupNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 189 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for branding
-- ----------------------------
DROP TABLE IF EXISTS `branding`;
CREATE TABLE `branding`  (
  `BrandingNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `BrandingType` tinyint(4) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ValueString` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeUpdated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`BrandingNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for canadiannetwork
-- ----------------------------
DROP TABLE IF EXISTS `canadiannetwork`;
CREATE TABLE `canadiannetwork`  (
  `CanadianNetworkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Abbrev` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `CanadianTransactionPrefix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanadianIsRprHandler` tinyint(4) NOT NULL,
  PRIMARY KEY (`CanadianNetworkNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for carecreditwebresponse
-- ----------------------------
DROP TABLE IF EXISTS `carecreditwebresponse`;
CREATE TABLE `carecreditwebresponse`  (
  `CareCreditWebResponseNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `PayNum` bigint(20) NOT NULL,
  `RefNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Amount` double NOT NULL,
  `WebToken` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProcessingStatus` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimePending` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeCompleted` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeExpired` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeLastError` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `LastResponseStr` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ServiceType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TransType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MerchantNumber` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HasLogged` tinyint(4) NOT NULL,
  PRIMARY KEY (`CareCreditWebResponseNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `PayNum`(`PayNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ProcessingStatus`(`ProcessingStatus`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for carrier
-- ----------------------------
DROP TABLE IF EXISTS `carrier`;
CREATE TABLE `carrier`  (
  `CarrierNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CarrierName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Address2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `City` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `State` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Zip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ElectID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NoSendElect` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `IsCDA` tinyint(3) UNSIGNED NOT NULL,
  `CDAnetVersion` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanadianNetworkNum` bigint(20) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `CanadianEncryptionMethod` tinyint(4) NOT NULL,
  `CanadianSupportedTypes` int(11) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `TIN` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CarrierGroupName` bigint(20) NOT NULL,
  `ApptTextBackColor` int(11) NOT NULL,
  `IsCoinsuranceInverted` tinyint(4) NOT NULL,
  `TrustedEtransFlags` tinyint(4) NOT NULL,
  `CobInsPaidBehaviorOverride` tinyint(4) NOT NULL,
  `EraAutomationOverride` tinyint(4) NOT NULL,
  `OrthoInsPayConsolidate` tinyint(4) NOT NULL,
  PRIMARY KEY (`CarrierNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `CarrierNumName`(`CarrierNum`, `CarrierName`) USING BTREE,
  INDEX `CanadianNetworkNum`(`CanadianNetworkNum`) USING BTREE,
  INDEX `CarrierGroupName`(`CarrierGroupName`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cdcrec
-- ----------------------------
DROP TABLE IF EXISTS `cdcrec`;
CREATE TABLE `cdcrec`  (
  `CdcrecNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CdcrecCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HeirarchicalCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CdcrecNum`) USING BTREE,
  INDEX `CdcrecCode`(`CdcrecCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cdspermission
-- ----------------------------
DROP TABLE IF EXISTS `cdspermission`;
CREATE TABLE `cdspermission`  (
  `CDSPermissionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `SetupCDS` tinyint(4) NOT NULL,
  `ShowCDS` tinyint(4) NOT NULL,
  `ShowInfobutton` tinyint(4) NOT NULL,
  `EditBibliography` tinyint(4) NOT NULL,
  `ProblemCDS` tinyint(4) NOT NULL,
  `MedicationCDS` tinyint(4) NOT NULL,
  `AllergyCDS` tinyint(4) NOT NULL,
  `DemographicCDS` tinyint(4) NOT NULL,
  `LabTestCDS` tinyint(4) NOT NULL,
  `VitalCDS` tinyint(4) NOT NULL,
  PRIMARY KEY (`CDSPermissionNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for centralconnection
-- ----------------------------
DROP TABLE IF EXISTS `centralconnection`;
CREATE TABLE `centralconnection`  (
  `CentralConnectionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ServerName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DatabaseName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MySqlUser` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MySqlPassword` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ServiceURI` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OdUser` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OdPassword` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `WebServiceIsEcw` tinyint(4) NOT NULL,
  `ConnectionStatus` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HasClinicBreakdownReports` tinyint(4) NOT NULL,
  PRIMARY KEY (`CentralConnectionNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cert
-- ----------------------------
DROP TABLE IF EXISTS `cert`;
CREATE TABLE `cert`  (
  `CertNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WikiPageLink` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `CertCategoryNum` bigint(20) NOT NULL,
  PRIMARY KEY (`CertNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for certemployee
-- ----------------------------
DROP TABLE IF EXISTS `certemployee`;
CREATE TABLE `certemployee`  (
  `CertEmployeeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CertNum` bigint(20) NOT NULL,
  `EmployeeNum` bigint(20) NOT NULL,
  `DateCompleted` date NOT NULL DEFAULT '0001-01-01',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  PRIMARY KEY (`CertEmployeeNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `CertNum`(`CertNum`) USING BTREE,
  INDEX `EmployeeNum`(`EmployeeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chartview
-- ----------------------------
DROP TABLE IF EXISTS `chartview`;
CREATE TABLE `chartview`  (
  `ChartViewNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `ProcStatuses` tinyint(4) NOT NULL,
  `ObjectTypes` smallint(6) NOT NULL,
  `ShowProcNotes` tinyint(4) NOT NULL,
  `IsAudit` tinyint(4) NOT NULL,
  `SelectedTeethOnly` tinyint(4) NOT NULL,
  `OrionStatusFlags` int(11) NOT NULL,
  `DatesShowing` tinyint(4) NOT NULL,
  `IsTpCharting` tinyint(4) NOT NULL,
  PRIMARY KEY (`ChartViewNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claim
-- ----------------------------
DROP TABLE IF EXISTS `claim`;
CREATE TABLE `claim`  (
  `ClaimNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateService` date NOT NULL DEFAULT '0001-01-01',
  `DateSent` date NOT NULL DEFAULT '0001-01-01',
  `ClaimStatus` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DateReceived` date NOT NULL DEFAULT '0001-01-01',
  `PlanNum` bigint(20) NOT NULL,
  `ProvTreat` bigint(20) NOT NULL,
  `ClaimFee` double NOT NULL DEFAULT 0,
  `InsPayEst` double NOT NULL DEFAULT 0,
  `InsPayAmt` double NOT NULL DEFAULT 0,
  `DedApplied` double NOT NULL DEFAULT 0,
  `PreAuthString` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsProsthesis` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PriorDate` date NOT NULL DEFAULT '0001-01-01',
  `ReasonUnderPaid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ClaimNote` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ClaimType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ProvBill` bigint(20) NOT NULL,
  `ReferringProv` bigint(20) NOT NULL,
  `RefNumString` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PlaceService` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `AccidentRelated` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `AccidentDate` date NOT NULL DEFAULT '0001-01-01',
  `AccidentST` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `EmployRelated` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `IsOrtho` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `OrthoRemainM` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `OrthoDate` date NOT NULL DEFAULT '0001-01-01',
  `PatRelat` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `PlanNum2` bigint(20) NOT NULL,
  `PatRelat2` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `WriteOff` double NOT NULL DEFAULT 0,
  `Radiographs` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ClinicNum` bigint(20) NOT NULL,
  `ClaimForm` bigint(20) NOT NULL,
  `AttachedImages` int(11) NOT NULL,
  `AttachedModels` int(11) NOT NULL,
  `AttachedFlags` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `AttachmentID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CanadianMaterialsForwarded` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanadianReferralProviderNum` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanadianReferralReason` tinyint(4) NOT NULL,
  `CanadianIsInitialLower` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanadianDateInitialLower` date NOT NULL DEFAULT '0001-01-01',
  `CanadianMandProsthMaterial` tinyint(4) NOT NULL,
  `CanadianIsInitialUpper` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanadianDateInitialUpper` date NOT NULL DEFAULT '0001-01-01',
  `CanadianMaxProsthMaterial` tinyint(4) NOT NULL,
  `InsSubNum` bigint(20) NOT NULL,
  `InsSubNum2` bigint(20) NOT NULL,
  `CanadaTransRefNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanadaEstTreatStartDate` date NOT NULL DEFAULT '0001-01-01',
  `CanadaInitialPayment` double NOT NULL,
  `CanadaPaymentMode` tinyint(3) UNSIGNED NOT NULL,
  `CanadaTreatDuration` tinyint(3) UNSIGNED NOT NULL,
  `CanadaNumAnticipatedPayments` tinyint(3) UNSIGNED NOT NULL,
  `CanadaAnticipatedPayAmount` double NOT NULL,
  `PriorAuthorizationNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecialProgramCode` tinyint(4) NOT NULL,
  `UniformBillType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedType` tinyint(4) NOT NULL,
  `AdmissionTypeCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AdmissionSourceCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatientStatusCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CustomTracking` bigint(20) NOT NULL,
  `DateResent` date NOT NULL DEFAULT '0001-01-01',
  `CorrectionType` tinyint(4) NOT NULL,
  `ClaimIdentifier` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrigRefNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvOrderOverride` bigint(20) NOT NULL,
  `OrthoTotalM` tinyint(3) UNSIGNED NOT NULL,
  `ShareOfCost` double NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `OrderingReferralNum` bigint(20) NOT NULL,
  `DateSentOrig` date NOT NULL DEFAULT '0001-01-01',
  `DateIllnessInjuryPreg` date NOT NULL DEFAULT '0001-01-01',
  `DateIllnessInjuryPregQualifier` smallint(6) NOT NULL,
  `DateOther` date NOT NULL DEFAULT '0001-01-01',
  `DateOtherQualifier` smallint(6) NOT NULL,
  `IsOutsideLab` tinyint(4) NOT NULL,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Narrative` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ClaimNum`) USING BTREE,
  INDEX `indexPlanNum`(`PlanNum`) USING BTREE,
  INDEX `InsSubNum`(`InsSubNum`) USING BTREE,
  INDEX `InsSubNum2`(`InsSubNum2`) USING BTREE,
  INDEX `CustomTracking`(`CustomTracking`) USING BTREE,
  INDEX `ProvOrderOverride`(`ProvOrderOverride`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `indexOutClaimCovering`(`PlanNum`, `ClaimStatus`, `ClaimType`, `PatNum`, `ClaimNum`, `DateService`, `ProvTreat`, `ClaimFee`, `ClinicNum`) USING BTREE,
  INDEX `OrderingReferralNum`(`OrderingReferralNum`) USING BTREE,
  INDEX `ProvBill`(`ProvBill`) USING BTREE,
  INDEX `ProvTreat`(`ProvTreat`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PatStatusTypeDate`(`PatNum`, `ClaimStatus`, `ClaimType`, `DateSent`) USING BTREE,
  INDEX `DateService`(`DateService`, `SecDateEntry`) USING BTREE,
  INDEX `ClaimStatus`(`ClaimStatus`) USING BTREE,
  INDEX `ClaimIdentifier`(`ClaimIdentifier`(30)) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claimattach
-- ----------------------------
DROP TABLE IF EXISTS `claimattach`;
CREATE TABLE `claimattach`  (
  `ClaimAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClaimNum` bigint(20) NOT NULL,
  `DisplayedFileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ActualFileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ImageReferenceId` int(11) NOT NULL,
  PRIMARY KEY (`ClaimAttachNum`) USING BTREE,
  INDEX `ClaimNum`(`ClaimNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claimcondcodelog
-- ----------------------------
DROP TABLE IF EXISTS `claimcondcodelog`;
CREATE TABLE `claimcondcodelog`  (
  `ClaimCondCodeLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClaimNum` bigint(20) NOT NULL,
  `Code0` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code1` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code2` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code3` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code4` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code5` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code6` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code7` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code8` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code9` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Code10` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ClaimCondCodeLogNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claimform
-- ----------------------------
DROP TABLE IF EXISTS `claimform`;
CREATE TABLE `claimform`  (
  `ClaimFormNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsHidden` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `FontName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FontSize` float UNSIGNED NOT NULL DEFAULT 0,
  `UniqueID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PrintImages` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `OffsetX` smallint(5) NOT NULL DEFAULT 0,
  `OffsetY` smallint(5) NOT NULL DEFAULT 0,
  `Width` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  PRIMARY KEY (`ClaimFormNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claimformitem
-- ----------------------------
DROP TABLE IF EXISTS `claimformitem`;
CREATE TABLE `claimformitem`  (
  `ClaimFormItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClaimFormNum` bigint(20) NOT NULL,
  `ImageFileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FormatString` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `XPos` float NOT NULL DEFAULT 0,
  `YPos` float NOT NULL DEFAULT 0,
  `Width` float NOT NULL DEFAULT 0,
  `Height` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ClaimFormItemNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1739 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claimpayment
-- ----------------------------
DROP TABLE IF EXISTS `claimpayment`;
CREATE TABLE `claimpayment`  (
  `ClaimPaymentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CheckDate` date NOT NULL DEFAULT '0001-01-01',
  `CheckAmt` double NOT NULL DEFAULT 0,
  `CheckNum` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `BankBranch` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ClinicNum` bigint(20) NOT NULL,
  `DepositNum` bigint(20) NOT NULL,
  `CarrierName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DateIssued` date NOT NULL DEFAULT '0001-01-01',
  `IsPartial` tinyint(4) NOT NULL,
  `PayType` bigint(20) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `PayGroup` bigint(20) NOT NULL,
  PRIMARY KEY (`ClaimPaymentNum`) USING BTREE,
  INDEX `DepositNum`(`DepositNum`) USING BTREE,
  INDEX `PayType`(`PayType`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `CheckDate`(`CheckDate`) USING BTREE,
  INDEX `PayGroup`(`PayGroup`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claimproc
-- ----------------------------
DROP TABLE IF EXISTS `claimproc`;
CREATE TABLE `claimproc`  (
  `ClaimProcNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProcNum` bigint(20) NOT NULL,
  `ClaimNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `FeeBilled` double NOT NULL DEFAULT 0,
  `InsPayEst` double NOT NULL DEFAULT 0,
  `DedApplied` double NOT NULL DEFAULT 0,
  `Status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `InsPayAmt` double NOT NULL DEFAULT 0,
  `Remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ClaimPaymentNum` bigint(20) NOT NULL,
  `PlanNum` bigint(20) NOT NULL,
  `DateCP` date NOT NULL DEFAULT '0001-01-01',
  `WriteOff` double NOT NULL DEFAULT 0,
  `CodeSent` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `AllowedOverride` double NOT NULL,
  `Percentage` tinyint(4) NOT NULL DEFAULT -1,
  `PercentOverride` tinyint(4) NOT NULL DEFAULT -1,
  `CopayAmt` double NOT NULL DEFAULT -1,
  `NoBillIns` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `PaidOtherIns` double NOT NULL DEFAULT -1,
  `BaseEst` double NOT NULL DEFAULT 0,
  `CopayOverride` double NOT NULL DEFAULT -1,
  `ProcDate` date NOT NULL DEFAULT '0001-01-01',
  `DateEntry` date NOT NULL DEFAULT '0001-01-01',
  `LineNumber` tinyint(3) UNSIGNED NOT NULL,
  `DedEst` double NOT NULL,
  `DedEstOverride` double NOT NULL,
  `InsEstTotal` double NOT NULL,
  `InsEstTotalOverride` double NOT NULL,
  `PaidOtherInsOverride` double NOT NULL,
  `EstimateNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WriteOffEst` double NOT NULL,
  `WriteOffEstOverride` double NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `InsSubNum` bigint(20) NOT NULL,
  `PaymentRow` int(11) NOT NULL,
  `PayPlanNum` bigint(20) NOT NULL,
  `ClaimPaymentTracking` bigint(20) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DateSuppReceived` date NOT NULL DEFAULT '0001-01-01',
  `DateInsFinalized` date NOT NULL DEFAULT '0001-01-01',
  `IsTransfer` tinyint(4) NOT NULL,
  `ClaimAdjReasonCodes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsOverpay` tinyint(4) NOT NULL,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ClaimProcNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `indexPlanNum`(`PlanNum`) USING BTREE,
  INDEX `indexClaimNum`(`ClaimNum`) USING BTREE,
  INDEX `indexProvNum`(`ProvNum`) USING BTREE,
  INDEX `indexProcNum`(`ProcNum`) USING BTREE,
  INDEX `indexClaimPaymentNum`(`ClaimPaymentNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `InsSubNum`(`InsSubNum`) USING BTREE,
  INDEX `Status`(`Status`) USING BTREE,
  INDEX `PayPlanNum`(`PayPlanNum`) USING BTREE,
  INDEX `indexCPNSIPA`(`ClaimPaymentNum`, `Status`, `InsPayAmt`) USING BTREE,
  INDEX `indexPNPD`(`ProvNum`, `ProcDate`) USING BTREE,
  INDEX `indexPNDCP`(`ProvNum`, `DateCP`) USING BTREE,
  INDEX `ClaimPaymentTracking`(`ClaimPaymentTracking`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `indexAcctCov`(`ProcNum`, `PlanNum`, `Status`, `InsPayAmt`, `InsPayEst`, `WriteOff`, `NoBillIns`) USING BTREE,
  INDEX `DateCP`(`DateCP`) USING BTREE,
  INDEX `DateSuppReceived`(`DateSuppReceived`) USING BTREE,
  INDEX `indexAgingCovering`(`Status`, `PatNum`, `DateCP`, `PayPlanNum`, `InsPayAmt`, `WriteOff`, `InsPayEst`, `ProcDate`, `ProcNum`) USING BTREE,
  INDEX `indexTxFinder`(`InsSubNum`, `ProcNum`, `Status`, `ProcDate`, `PatNum`, `InsPayAmt`, `InsPayEst`) USING BTREE,
  INDEX `indexOutClaimCovering`(`ClaimNum`, `ClaimPaymentNum`, `InsPayAmt`, `DateCP`, `IsTransfer`) USING BTREE,
  INDEX `SecDateTEditPN`(`SecDateTEdit`, `PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 99 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claimsnapshot
-- ----------------------------
DROP TABLE IF EXISTS `claimsnapshot`;
CREATE TABLE `claimsnapshot`  (
  `ClaimSnapshotNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProcNum` bigint(20) NOT NULL,
  `ClaimType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Writeoff` double NOT NULL,
  `InsPayEst` double NOT NULL,
  `Fee` double NOT NULL,
  `DateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ClaimProcNum` bigint(20) NOT NULL,
  `SnapshotTrigger` tinyint(4) NOT NULL,
  PRIMARY KEY (`ClaimSnapshotNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `ClaimProcNum`(`ClaimProcNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claimtracking
-- ----------------------------
DROP TABLE IF EXISTS `claimtracking`;
CREATE TABLE `claimtracking`  (
  `ClaimTrackingNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClaimNum` bigint(20) NOT NULL,
  `TrackingType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `DateTimeEntry` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TrackingDefNum` bigint(20) NOT NULL,
  `TrackingErrorDefNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ClaimTrackingNum`) USING BTREE,
  INDEX `ClaimNum`(`ClaimNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `TrackingDefNum`(`TrackingDefNum`) USING BTREE,
  INDEX `TrackingErrorDefNum`(`TrackingErrorDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claimvalcodelog
-- ----------------------------
DROP TABLE IF EXISTS `claimvalcodelog`;
CREATE TABLE `claimvalcodelog`  (
  `ClaimValCodeLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClaimNum` bigint(20) NOT NULL,
  `ClaimField` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ValCode` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ValAmount` double NOT NULL,
  `Ordinal` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ClaimValCodeLogNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clearinghouse
-- ----------------------------
DROP TABLE IF EXISTS `clearinghouse`;
CREATE TABLE `clearinghouse`  (
  `ClearinghouseNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ExportPath` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Payors` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Eformat` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ISA05` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SenderTIN` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ISA07` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ISA08` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ISA15` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ResponsePath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `CommBridge` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ClientProgram` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `LastBatchNumber` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `ModemPort` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `LoginID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `SenderName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SenderTelephone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `GS03` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ISA02` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ISA04` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ISA16` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SeparatorData` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SeparatorSegment` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `HqClearinghouseNum` bigint(20) NOT NULL,
  `IsEraDownloadAllowed` tinyint(4) NOT NULL DEFAULT 2,
  `IsClaimExportAllowed` tinyint(4) NOT NULL DEFAULT 1,
  `IsAttachmentSendAllowed` tinyint(4) NOT NULL,
  `LocationID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ClearinghouseNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `HqClearinghouseNum`(`HqClearinghouseNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clinic
-- ----------------------------
DROP TABLE IF EXISTS `clinic`;
CREATE TABLE `clinic`  (
  `ClinicNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Address2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `City` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `State` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Zip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `BankNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DefaultPlaceService` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `InsBillingProv` bigint(20) NOT NULL,
  `Fax` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailAddressNum` bigint(20) NOT NULL,
  `DefaultProv` bigint(20) NOT NULL,
  `SmsContractDate` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SmsMonthlyLimit` double NOT NULL,
  `IsMedicalOnly` tinyint(4) NOT NULL,
  `BillingAddress` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BillingAddress2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BillingCity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BillingState` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BillingZip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PayToAddress` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PayToAddress2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PayToCity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PayToState` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PayToZip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UseBillAddrOnClaims` tinyint(4) NOT NULL,
  `Region` bigint(20) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `IsInsVerifyExcluded` tinyint(4) NOT NULL,
  `Abbr` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedLabAccountNum` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsConfirmEnabled` tinyint(4) NOT NULL,
  `IsConfirmDefault` tinyint(4) NOT NULL,
  `IsNewPatApptExcluded` tinyint(4) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `ExternalID` bigint(20) NOT NULL,
  `SchedNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HasProcOnRx` tinyint(4) NOT NULL,
  `TimeZone` varchar(75) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailAliasOverride` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ClinicNum`) USING BTREE,
  INDEX `EmailAddressNum`(`EmailAddressNum`) USING BTREE,
  INDEX `DefaultProv`(`DefaultProv`) USING BTREE,
  INDEX `Region`(`Region`) USING BTREE,
  INDEX `ExternalID`(`ExternalID`) USING BTREE,
  INDEX `InsBillingProv`(`InsBillingProv`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clinicerx
-- ----------------------------
DROP TABLE IF EXISTS `clinicerx`;
CREATE TABLE `clinicerx`  (
  `ClinicErxNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ClinicDesc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `EnabledStatus` tinyint(4) NOT NULL,
  `ClinicId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicKey` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AccountId` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RegistrationKeyNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ClinicErxNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `RegistrationKeyNum`(`RegistrationKeyNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clinicpref
-- ----------------------------
DROP TABLE IF EXISTS `clinicpref`;
CREATE TABLE `clinicpref`  (
  `ClinicPrefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `PrefName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ValueString` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ClinicPrefNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clockevent
-- ----------------------------
DROP TABLE IF EXISTS `clockevent`;
CREATE TABLE `clockevent`  (
  `ClockEventNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EmployeeNum` bigint(20) NOT NULL,
  `TimeEntered1` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TimeDisplayed1` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ClockStatus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `TimeEntered2` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TimeDisplayed2` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `OTimeHours` time NOT NULL,
  `OTimeAuto` time NOT NULL,
  `Adjust` time NOT NULL,
  `AdjustAuto` time NOT NULL,
  `AdjustIsOverridden` tinyint(4) NOT NULL,
  `Rate2Hours` time NOT NULL,
  `Rate2Auto` time NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `Rate3Hours` time NOT NULL,
  `Rate3Auto` time NOT NULL,
  `IsWorkingHome` tinyint(4) NOT NULL,
  PRIMARY KEY (`ClockEventNum`) USING BTREE,
  INDEX `TimeDisplayed1`(`TimeDisplayed1`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `EmployeeNum`(`EmployeeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cloudaddress
-- ----------------------------
DROP TABLE IF EXISTS `cloudaddress`;
CREATE TABLE `cloudaddress`  (
  `CloudAddressNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `IpAddress` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserNumLastConnect` bigint(20) NOT NULL,
  `DateTimeLastConnect` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`CloudAddressNum`) USING BTREE,
  INDEX `UserNumLastConnect`(`UserNumLastConnect`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for codegroup
-- ----------------------------
DROP TABLE IF EXISTS `codegroup`;
CREATE TABLE `codegroup`  (
  `CodeGroupNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `GroupName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProcCodes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `CodeGroupFixed` tinyint(4) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `ShowInAgeLimit` tinyint(4) NOT NULL,
  `ShowInFrequency` tinyint(4) NOT NULL,
  PRIMARY KEY (`CodeGroupNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for codesystem
-- ----------------------------
DROP TABLE IF EXISTS `codesystem`;
CREATE TABLE `codesystem`  (
  `CodeSystemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `VersionCur` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `VersionAvail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HL7OID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CodeSystemNum`) USING BTREE,
  INDEX `CodeSystemName`(`CodeSystemName`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for commlog
-- ----------------------------
DROP TABLE IF EXISTS `commlog`;
CREATE TABLE `commlog`  (
  `CommlogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `CommDateTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `CommType` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Mode_` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `SentOrReceived` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `UserNum` bigint(20) NOT NULL,
  `Signature` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SigIsTopaz` tinyint(4) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DateTimeEnd` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `CommSource` tinyint(4) NULL DEFAULT NULL,
  `ProgramNum` bigint(20) NOT NULL,
  `DateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ReferralNum` bigint(20) NOT NULL,
  `CommReferralBehavior` tinyint(4) NOT NULL,
  PRIMARY KEY (`CommlogNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `CommDateTime`(`CommDateTime`) USING BTREE,
  INDEX `CommType`(`CommType`) USING BTREE,
  INDEX `ProgramNum`(`ProgramNum`) USING BTREE,
  INDEX `indexPNCDateCType`(`PatNum`, `CommDateTime`, `CommType`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `ReferralNum`(`ReferralNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for commoptout
-- ----------------------------
DROP TABLE IF EXISTS `commoptout`;
CREATE TABLE `commoptout`  (
  `CommOptOutNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `OptOutSms` int(11) NOT NULL,
  `OptOutEmail` int(11) NOT NULL,
  PRIMARY KEY (`CommOptOutNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for computer
-- ----------------------------
DROP TABLE IF EXISTS `computer`;
CREATE TABLE `computer`  (
  `ComputerNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CompName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `LastHeartBeat` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`ComputerNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for computerpref
-- ----------------------------
DROP TABLE IF EXISTS `computerpref`;
CREATE TABLE `computerpref`  (
  `ComputerPrefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ComputerName` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GraphicsUseHardware` tinyint(1) NOT NULL DEFAULT 0,
  `GraphicsSimple` tinyint(1) NOT NULL DEFAULT 0,
  `SensorType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'D',
  `SensorBinned` tinyint(4) NOT NULL,
  `SensorPort` int(11) NULL DEFAULT 0,
  `SensorExposure` int(11) NULL DEFAULT 1,
  `GraphicsDoubleBuffering` tinyint(4) NOT NULL,
  `PreferredPixelFormatNum` int(11) NULL DEFAULT 0,
  `AtoZpath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `TaskKeepListHidden` tinyint(1) NOT NULL,
  `TaskDock` int(11) NOT NULL DEFAULT 0,
  `TaskX` int(11) NOT NULL DEFAULT 900,
  `TaskY` int(11) NOT NULL DEFAULT 625,
  `DirectXFormat` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ScanDocSelectSource` tinyint(4) NOT NULL,
  `ScanDocShowOptions` tinyint(4) NOT NULL,
  `ScanDocDuplex` tinyint(4) NOT NULL,
  `ScanDocGrayscale` tinyint(4) NOT NULL,
  `ScanDocResolution` int(11) NOT NULL,
  `ScanDocQuality` tinyint(3) UNSIGNED NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ApptViewNum` bigint(20) NOT NULL,
  `RecentApptView` tinyint(3) UNSIGNED NOT NULL,
  `PatSelectSearchMode` tinyint(4) NOT NULL,
  `NoShowLanguage` tinyint(4) NOT NULL,
  `NoShowDecimal` tinyint(4) NOT NULL,
  `ComputerOS` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HelpButtonXAdjustment` double NOT NULL,
  `GraphicsUseDirectX11` tinyint(4) NOT NULL DEFAULT 0,
  `Zoom` int(11) NOT NULL DEFAULT 0,
  `VideoRectangle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CreditCardTerminalId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ComputerPrefNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ApptViewNum`(`ApptViewNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for confirmationrequest
-- ----------------------------
DROP TABLE IF EXISTS `confirmationrequest`;
CREATE TABLE `confirmationrequest`  (
  `ConfirmationRequestNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ApptNum` bigint(20) NOT NULL,
  `DateTimeConfirmExpire` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ShortGUID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ConfirmCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeConfirmTransmit` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeRSVP` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `RSVPStatus` tinyint(4) NOT NULL,
  `ResponseDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GuidMessageFromMobile` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ApptDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TSPrior` bigint(20) NOT NULL,
  `DoNotResend` tinyint(4) NOT NULL,
  `SendStatus` tinyint(4) NOT NULL,
  `ApptReminderRuleNum` bigint(20) NOT NULL,
  `MessageType` tinyint(4) NOT NULL,
  `MessageFk` bigint(20) NOT NULL,
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`ConfirmationRequestNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ApptNum`(`ApptNum`) USING BTREE,
  INDEX `TSPrior`(`TSPrior`) USING BTREE,
  INDEX `ApptReminderRuleNum`(`ApptReminderRuleNum`) USING BTREE,
  INDEX `MessageFk`(`MessageFk`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for connectiongroup
-- ----------------------------
DROP TABLE IF EXISTS `connectiongroup`;
CREATE TABLE `connectiongroup`  (
  `ConnectionGroupNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ConnectionGroupNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for conngroupattach
-- ----------------------------
DROP TABLE IF EXISTS `conngroupattach`;
CREATE TABLE `conngroupattach`  (
  `ConnGroupAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ConnectionGroupNum` bigint(20) NOT NULL,
  `CentralConnectionNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ConnGroupAttachNum`) USING BTREE,
  INDEX `ConnectionGroupNum`(`ConnectionGroupNum`) USING BTREE,
  INDEX `CentralConnectionNum`(`CentralConnectionNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact`  (
  `ContactNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `WkPhone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Fax` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Category` bigint(20) NOT NULL,
  `Notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ContactNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for county
-- ----------------------------
DROP TABLE IF EXISTS `county`;
CREATE TABLE `county`  (
  `CountyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CountyName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `CountyCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`CountyNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for covcat
-- ----------------------------
DROP TABLE IF EXISTS `covcat`;
CREATE TABLE `covcat`  (
  `CovCatNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DefaultPercent` smallint(6) NOT NULL,
  `CovOrder` int(11) NOT NULL,
  `IsHidden` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `EbenefitCat` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`CovCatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for covspan
-- ----------------------------
DROP TABLE IF EXISTS `covspan`;
CREATE TABLE `covspan`  (
  `CovSpanNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CovCatNum` bigint(20) NOT NULL,
  `FromCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  `ToCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`CovSpanNum`) USING BTREE,
  INDEX `CovCatNum`(`CovCatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 21 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cpt
-- ----------------------------
DROP TABLE IF EXISTS `cpt`;
CREATE TABLE `cpt`  (
  `CptNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CptCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `VersionIDs` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CptNum`) USING BTREE,
  INDEX `CptCode`(`CptCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for creditcard
-- ----------------------------
DROP TABLE IF EXISTS `creditcard`;
CREATE TABLE `creditcard`  (
  `CreditCardNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Zip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `XChargeToken` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CCNumberMasked` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CCExpiration` date NOT NULL DEFAULT '0001-01-01',
  `ItemOrder` int(11) NOT NULL,
  `ChargeAmt` double NOT NULL,
  `DateStart` date NOT NULL DEFAULT '0001-01-01',
  `DateStop` date NOT NULL DEFAULT '0001-01-01',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PayPlanNum` bigint(20) NOT NULL,
  `PayConnectToken` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PayConnectTokenExp` date NOT NULL DEFAULT '0001-01-01',
  `Procedures` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CCSource` tinyint(4) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ExcludeProcSync` tinyint(4) NOT NULL,
  `PaySimpleToken` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ChargeFrequency` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanChargeWhenNoBal` tinyint(4) NOT NULL,
  `PaymentType` bigint(20) NOT NULL,
  `IsRecurringActive` tinyint(4) NOT NULL,
  `Nickname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CardHolderName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CreditCardNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `PayPlanNum`(`PayPlanNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PaymentType`(`PaymentType`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for custrefentry
-- ----------------------------
DROP TABLE IF EXISTS `custrefentry`;
CREATE TABLE `custrefentry`  (
  `CustRefEntryNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNumCust` bigint(20) NOT NULL,
  `PatNumRef` bigint(20) NOT NULL,
  `DateEntry` date NOT NULL DEFAULT '0001-01-01',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CustRefEntryNum`) USING BTREE,
  INDEX `PatNumCust`(`PatNumCust`) USING BTREE,
  INDEX `PatNumRef`(`PatNumRef`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for custreference
-- ----------------------------
DROP TABLE IF EXISTS `custreference`;
CREATE TABLE `custreference`  (
  `CustReferenceNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateMostRecent` date NOT NULL DEFAULT '0001-01-01',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsBadRef` tinyint(4) NOT NULL,
  PRIMARY KEY (`CustReferenceNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cvx
-- ----------------------------
DROP TABLE IF EXISTS `cvx`;
CREATE TABLE `cvx`  (
  `CvxNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CvxCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsActive` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CvxNum`) USING BTREE,
  INDEX `CvxCode`(`CvxCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dashboardar
-- ----------------------------
DROP TABLE IF EXISTS `dashboardar`;
CREATE TABLE `dashboardar`  (
  `DashboardARNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateCalc` date NOT NULL DEFAULT '0001-01-01',
  `BalTotal` double NOT NULL,
  `InsEst` double NOT NULL,
  PRIMARY KEY (`DashboardARNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for dashboardcell
-- ----------------------------
DROP TABLE IF EXISTS `dashboardcell`;
CREATE TABLE `dashboardcell`  (
  `DashboardCellNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DashboardLayoutNum` bigint(20) NOT NULL,
  `CellRow` int(11) NOT NULL,
  `CellColumn` int(11) NOT NULL,
  `CellType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CellSettings` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LastQueryTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `LastQueryData` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RefreshRateSeconds` int(11) NOT NULL,
  PRIMARY KEY (`DashboardCellNum`) USING BTREE,
  INDEX `DashboardLayoutNum`(`DashboardLayoutNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dashboardlayout
-- ----------------------------
DROP TABLE IF EXISTS `dashboardlayout`;
CREATE TABLE `dashboardlayout`  (
  `DashboardLayoutNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `UserGroupNum` bigint(20) NOT NULL,
  `DashboardTabName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DashboardTabOrder` int(11) NOT NULL,
  `DashboardRows` int(11) NOT NULL,
  `DashboardColumns` int(11) NOT NULL,
  `DashboardGroupName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DashboardLayoutNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `UserGroupNum`(`UserGroupNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for databasemaintenance
-- ----------------------------
DROP TABLE IF EXISTS `databasemaintenance`;
CREATE TABLE `databasemaintenance`  (
  `DatabaseMaintenanceNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MethodName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `IsOld` tinyint(4) NOT NULL,
  `DateLastRun` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`DatabaseMaintenanceNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dbmlog
-- ----------------------------
DROP TABLE IF EXISTS `dbmlog`;
CREATE TABLE `dbmlog`  (
  `DbmLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `FKeyType` tinyint(4) NOT NULL,
  `ActionType` tinyint(4) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `MethodName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LogText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DbmLogNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `FKeyAndType`(`FKey`, `FKeyType`) USING BTREE,
  INDEX `DateTimeEntry`(`DateTimeEntry`) USING BTREE,
  INDEX `MethodName`(`MethodName`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for definition
-- ----------------------------
DROP TABLE IF EXISTS `definition`;
CREATE TABLE `definition`  (
  `DefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Category` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ItemOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `ItemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ItemValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ItemColor` int(11) NOT NULL DEFAULT 0,
  `IsHidden` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`DefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 331 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for deflink
-- ----------------------------
DROP TABLE IF EXISTS `deflink`;
CREATE TABLE `deflink`  (
  `DefLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DefNum` bigint(20) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `LinkType` tinyint(4) NOT NULL,
  PRIMARY KEY (`DefLinkNum`) USING BTREE,
  INDEX `DefNum`(`DefNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for deletedobject
-- ----------------------------
DROP TABLE IF EXISTS `deletedobject`;
CREATE TABLE `deletedobject`  (
  `DeletedObjectNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ObjectNum` bigint(20) NOT NULL,
  `ObjectType` int(11) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`DeletedObjectNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 75 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for deposit
-- ----------------------------
DROP TABLE IF EXISTS `deposit`;
CREATE TABLE `deposit`  (
  `DepositNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateDeposit` date NOT NULL DEFAULT '0001-01-01',
  `BankAccountInfo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Amount` double NOT NULL DEFAULT 0,
  `Memo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Batch` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DepositAccountNum` bigint(20) NOT NULL,
  `IsSentToQuickBooksOnline` tinyint(4) NOT NULL,
  PRIMARY KEY (`DepositNum`) USING BTREE,
  INDEX `DepositAccountNum`(`DepositAccountNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dictcustom
-- ----------------------------
DROP TABLE IF EXISTS `dictcustom`;
CREATE TABLE `dictcustom`  (
  `DictCustomNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `WordText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DictCustomNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for discountplan
-- ----------------------------
DROP TABLE IF EXISTS `discountplan`;
CREATE TABLE `discountplan`  (
  `DiscountPlanNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FeeSchedNum` bigint(20) NOT NULL,
  `DefNum` bigint(20) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `PlanNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ExamFreqLimit` int(11) NOT NULL,
  `XrayFreqLimit` int(11) NOT NULL,
  `ProphyFreqLimit` int(11) NOT NULL,
  `FluorideFreqLimit` int(11) NOT NULL,
  `PerioFreqLimit` int(11) NOT NULL,
  `LimitedExamFreqLimit` int(11) NOT NULL,
  `PAFreqLimit` int(11) NOT NULL,
  `AnnualMax` double NOT NULL DEFAULT -1,
  PRIMARY KEY (`DiscountPlanNum`) USING BTREE,
  INDEX `FeeSchedNum`(`FeeSchedNum`) USING BTREE,
  INDEX `DefNum`(`DefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for discountplansub
-- ----------------------------
DROP TABLE IF EXISTS `discountplansub`;
CREATE TABLE `discountplansub`  (
  `DiscountSubNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DiscountPlanNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `DateEffective` date NOT NULL DEFAULT '0001-01-01',
  `DateTerm` date NOT NULL DEFAULT '0001-01-01',
  `SubNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DiscountSubNum`) USING BTREE,
  INDEX `DiscountPlanNum`(`DiscountPlanNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for disease
-- ----------------------------
DROP TABLE IF EXISTS `disease`;
CREATE TABLE `disease`  (
  `DiseaseNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DiseaseDefNum` bigint(20) NOT NULL,
  `PatNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `ProbStatus` tinyint(4) NOT NULL,
  `DateStart` date NOT NULL DEFAULT '0001-01-01',
  `DateStop` date NOT NULL DEFAULT '0001-01-01',
  `SnomedProblemType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FunctionStatus` tinyint(4) NOT NULL,
  PRIMARY KEY (`DiseaseNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `DiseaseDefNum`(`DiseaseDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for diseasedef
-- ----------------------------
DROP TABLE IF EXISTS `diseasedef`;
CREATE TABLE `diseasedef`  (
  `DiseaseDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DiseaseName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ItemOrder` smallint(5) UNSIGNED NOT NULL,
  `IsHidden` tinyint(3) UNSIGNED NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `ICD9Code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SnomedCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Icd10Code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DiseaseDefNum`) USING BTREE,
  INDEX `ICD9Code`(`ICD9Code`) USING BTREE,
  INDEX `SnomedCode`(`SnomedCode`) USING BTREE,
  INDEX `Icd10Code`(`Icd10Code`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for displayfield
-- ----------------------------
DROP TABLE IF EXISTS `displayfield`;
CREATE TABLE `displayfield`  (
  `DisplayFieldNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `InternalName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ItemOrder` int(11) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ColumnWidth` int(11) NOT NULL,
  `Category` int(11) NOT NULL DEFAULT 0,
  `ChartViewNum` bigint(20) NOT NULL,
  `PickList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DescriptionOverride` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DisplayFieldNum`) USING BTREE,
  INDEX `ChartViewNum`(`ChartViewNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 111 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for displayreport
-- ----------------------------
DROP TABLE IF EXISTS `displayreport`;
CREATE TABLE `displayreport`  (
  `DisplayReportNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `InternalName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Category` tinyint(4) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `IsVisibleInSubMenu` tinyint(4) NOT NULL,
  PRIMARY KEY (`DisplayReportNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 63 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dispsupply
-- ----------------------------
DROP TABLE IF EXISTS `dispsupply`;
CREATE TABLE `dispsupply`  (
  `DispSupplyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SupplyNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `DateDispensed` date NOT NULL DEFAULT '0001-01-01',
  `DispQuantity` float NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DispSupplyNum`) USING BTREE,
  INDEX `SupplyNum`(`SupplyNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for document
-- ----------------------------
DROP TABLE IF EXISTS `document`;
CREATE TABLE `document`  (
  `DocNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DateCreated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DocCategory` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `FileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ImgType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `IsFlipped` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `DegreesRotated` float NOT NULL,
  `ToothNumbers` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Note` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SigIsTopaz` tinyint(3) UNSIGNED NOT NULL,
  `Signature` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CropX` int(11) NOT NULL,
  `CropY` int(11) NOT NULL,
  `CropW` int(11) NOT NULL,
  `CropH` int(11) NOT NULL,
  `WindowingMin` int(11) NOT NULL,
  `WindowingMax` int(11) NOT NULL,
  `MountItemNum` bigint(20) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `RawBase64` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Thumbnail` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ExternalGUID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ExternalSource` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `IsCropOld` tinyint(3) UNSIGNED NOT NULL,
  `OcrResponseData` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ImageCaptureType` tinyint(4) NOT NULL DEFAULT 0,
  `PrintHeading` tinyint(4) NOT NULL,
  `ChartLetterStatus` tinyint(4) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `ChartLetterHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DocNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `PNDC`(`PatNum`, `DocCategory`) USING BTREE,
  INDEX `MountItemNum`(`MountItemNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for documentmisc
-- ----------------------------
DROP TABLE IF EXISTS `documentmisc`;
CREATE TABLE `documentmisc`  (
  `DocMiscNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateCreated` date NOT NULL DEFAULT '0001-01-01',
  `FileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DocMiscType` tinyint(4) NOT NULL,
  `RawBase64` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DocMiscNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 52 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for drugmanufacturer
-- ----------------------------
DROP TABLE IF EXISTS `drugmanufacturer`;
CREATE TABLE `drugmanufacturer`  (
  `DrugManufacturerNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ManufacturerName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ManufacturerCode` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DrugManufacturerNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for drugunit
-- ----------------------------
DROP TABLE IF EXISTS `drugunit`;
CREATE TABLE `drugunit`  (
  `DrugUnitNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UnitIdentifier` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DrugUnitNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dunning
-- ----------------------------
DROP TABLE IF EXISTS `dunning`;
CREATE TABLE `dunning`  (
  `DunningNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DunMessage` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `BillingType` bigint(20) NOT NULL,
  `AgeAccount` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `InsIsPending` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `MessageBold` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `EmailSubject` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailBody` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DaysInAdvance` int(11) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `IsSuperFamily` tinyint(4) NOT NULL,
  PRIMARY KEY (`DunningNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ebill
-- ----------------------------
DROP TABLE IF EXISTS `ebill`;
CREATE TABLE `ebill`  (
  `EbillNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `ClientAcctNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ElectUserName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ElectPassword` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PracticeAddress` tinyint(4) NOT NULL,
  `RemitAddress` tinyint(4) NOT NULL,
  PRIMARY KEY (`EbillNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eclipboardimagecapture
-- ----------------------------
DROP TABLE IF EXISTS `eclipboardimagecapture`;
CREATE TABLE `eclipboardimagecapture`  (
  `EClipboardImageCaptureNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DefNum` bigint(20) NOT NULL,
  `IsSelfPortrait` tinyint(4) NOT NULL,
  `DateTimeUpserted` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DocNum` bigint(20) NOT NULL,
  `OcrCaptureType` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`EClipboardImageCaptureNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `DefNum`(`DefNum`) USING BTREE,
  INDEX `DocNum`(`DocNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for eclipboardimagecapturedef
-- ----------------------------
DROP TABLE IF EXISTS `eclipboardimagecapturedef`;
CREATE TABLE `eclipboardimagecapturedef`  (
  `EClipboardImageCaptureDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DefNum` bigint(20) NOT NULL,
  `IsSelfPortrait` tinyint(4) NOT NULL,
  `FrequencyDays` int(11) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `OcrCaptureType` tinyint(4) NOT NULL DEFAULT 0,
  `Frequency` tinyint(4) NOT NULL,
  `ResubmitInterval` bigint(20) NOT NULL,
  PRIMARY KEY (`EClipboardImageCaptureDefNum`) USING BTREE,
  INDEX `DefNum`(`DefNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ResubmitInterval`(`ResubmitInterval`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for eclipboardsheetdef
-- ----------------------------
DROP TABLE IF EXISTS `eclipboardsheetdef`;
CREATE TABLE `eclipboardsheetdef`  (
  `EClipboardSheetDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SheetDefNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ResubmitInterval` bigint(20) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `PrefillStatus` tinyint(4) NOT NULL,
  `MinAge` int(11) NOT NULL DEFAULT -1,
  `MaxAge` int(11) NOT NULL DEFAULT -1,
  `IgnoreSheetDefNums` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PrefillStatusOverride` bigint(20) NOT NULL,
  `EFormDefNum` bigint(20) NOT NULL,
  `Frequency` tinyint(4) NOT NULL,
  `SheetDefNumsConsidered` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EClipboardSheetDefNum`) USING BTREE,
  INDEX `SheetDefNum`(`SheetDefNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ResubmitInterval`(`ResubmitInterval`) USING BTREE,
  INDEX `PrefillStatusOverride`(`PrefillStatusOverride`) USING BTREE,
  INDEX `EFormDefNum`(`EFormDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eduresource
-- ----------------------------
DROP TABLE IF EXISTS `eduresource`;
CREATE TABLE `eduresource`  (
  `EduResourceNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DiseaseDefNum` bigint(20) NOT NULL,
  `MedicationNum` bigint(20) NOT NULL,
  `LabResultID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LabResultName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LabResultCompare` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ResourceUrl` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SmokingSnoMed` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EduResourceNum`) USING BTREE,
  INDEX `DiseaseDefNum`(`DiseaseDefNum`) USING BTREE,
  INDEX `MedicationNum`(`MedicationNum`) USING BTREE,
  INDEX `LabResultID`(`LabResultID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eform
-- ----------------------------
DROP TABLE IF EXISTS `eform`;
CREATE TABLE `eform`  (
  `EFormNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FormType` tinyint(4) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `DateTimeShown` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTEdited` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `MaxWidth` int(11) NOT NULL,
  `EFormDefNum` bigint(20) NOT NULL,
  `Status` tinyint(4) NOT NULL,
  `RevID` int(11) NOT NULL,
  `ShowLabelsBold` tinyint(4) NOT NULL,
  `SpaceBelowEachField` int(11) NOT NULL,
  `SpaceToRightEachField` int(11) NOT NULL,
  `SaveImageCategory` bigint(20) NOT NULL,
  PRIMARY KEY (`EFormNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `EFormDefNum`(`EFormDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eformdef
-- ----------------------------
DROP TABLE IF EXISTS `eformdef`;
CREATE TABLE `eformdef`  (
  `EFormDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FormType` tinyint(4) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTCreated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `IsInternalHidden` tinyint(4) NOT NULL,
  `MaxWidth` int(11) NOT NULL,
  `RevID` int(11) NOT NULL,
  `ShowLabelsBold` tinyint(4) NOT NULL,
  `SpaceBelowEachField` int(11) NOT NULL,
  `SpaceToRightEachField` int(11) NOT NULL,
  `SaveImageCategory` bigint(20) NOT NULL,
  PRIMARY KEY (`EFormDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eformfield
-- ----------------------------
DROP TABLE IF EXISTS `eformfield`;
CREATE TABLE `eformfield`  (
  `EFormFieldNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EFormNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `FieldType` tinyint(4) NOT NULL,
  `DbLink` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ValueLabel` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ValueString` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `PickListVis` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PickListDb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHorizStacking` tinyint(4) NOT NULL,
  `IsTextWrap` tinyint(4) NOT NULL,
  `Width` int(11) NOT NULL,
  `FontScale` int(11) NOT NULL,
  `IsRequired` tinyint(4) NOT NULL,
  `ConditionalParent` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ConditionalValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LabelAlign` tinyint(4) NOT NULL,
  `SpaceBelow` int(11) NOT NULL,
  `ReportableName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsLocked` tinyint(4) NOT NULL,
  `Border` tinyint(4) NOT NULL,
  `IsWidthPercentage` tinyint(4) NOT NULL,
  `MinWidth` int(11) NOT NULL,
  `WidthLabel` int(11) NOT NULL,
  `SpaceToRight` int(11) NOT NULL,
  `AutoImport` tinyint(4) NOT NULL,
  `PrefillFromGuar` tinyint(4) NOT NULL,
  `ValueLabelEnglish` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PickListVisEnglish` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EFormFieldNum`) USING BTREE,
  INDEX `EFormNum`(`EFormNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eformfielddef
-- ----------------------------
DROP TABLE IF EXISTS `eformfielddef`;
CREATE TABLE `eformfielddef`  (
  `EFormFieldDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EFormDefNum` bigint(20) NOT NULL,
  `FieldType` tinyint(4) NOT NULL,
  `DbLink` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ValueLabel` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `PickListVis` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PickListDb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHorizStacking` tinyint(4) NOT NULL,
  `IsTextWrap` tinyint(4) NOT NULL,
  `Width` int(11) NOT NULL,
  `FontScale` int(11) NOT NULL,
  `IsRequired` tinyint(4) NOT NULL,
  `ConditionalParent` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ConditionalValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LabelAlign` tinyint(4) NOT NULL,
  `SpaceBelow` int(11) NOT NULL,
  `ReportableName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsLocked` tinyint(4) NOT NULL,
  `Border` tinyint(4) NOT NULL,
  `IsWidthPercentage` tinyint(4) NOT NULL,
  `MinWidth` int(11) NOT NULL,
  `WidthLabel` int(11) NOT NULL,
  `SpaceToRight` int(11) NOT NULL,
  `AutoImport` tinyint(4) NOT NULL,
  `PrefillFromGuar` tinyint(4) NOT NULL,
  PRIMARY KEY (`EFormFieldDefNum`) USING BTREE,
  INDEX `EFormDefNum`(`EFormDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eformimportrule
-- ----------------------------
DROP TABLE IF EXISTS `eformimportrule`;
CREATE TABLE `eformimportrule`  (
  `EFormImportRuleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Situation` tinyint(4) NOT NULL,
  `Action` tinyint(4) NOT NULL,
  PRIMARY KEY (`EFormImportRuleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehramendment
-- ----------------------------
DROP TABLE IF EXISTS `ehramendment`;
CREATE TABLE `ehramendment`  (
  `EhrAmendmentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `IsAccepted` tinyint(4) NOT NULL,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Source` tinyint(4) NOT NULL,
  `SourceName` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RawBase64` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTRequest` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTAcceptDeny` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTAppend` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`EhrAmendmentNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehraptobs
-- ----------------------------
DROP TABLE IF EXISTS `ehraptobs`;
CREATE TABLE `ehraptobs`  (
  `EhrAptObsNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AptNum` bigint(20) NOT NULL,
  `IdentifyingCode` tinyint(4) NOT NULL,
  `ValType` tinyint(4) NOT NULL,
  `ValReported` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UcumCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ValCodeSystem` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrAptObsNum`) USING BTREE,
  INDEX `AptNum`(`AptNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrcareplan
-- ----------------------------
DROP TABLE IF EXISTS `ehrcareplan`;
CREATE TABLE `ehrcareplan`  (
  `EhrCarePlanNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `SnomedEducation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Instructions` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DatePlanned` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`EhrCarePlanNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrlab
-- ----------------------------
DROP TABLE IF EXISTS `ehrlab`;
CREATE TABLE `ehrlab`  (
  `EhrLabNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `OrderControlCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PlacerOrderNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PlacerOrderNamespace` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PlacerOrderUniversalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PlacerOrderUniversalIDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FillerOrderNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FillerOrderNamespace` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FillerOrderUniversalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FillerOrderUniversalIDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PlacerGroupNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PlacerGroupNamespace` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PlacerGroupUniversalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PlacerGroupUniversalIDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderLName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderFName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderMiddleNames` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderSuffix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderPrefix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderAssigningAuthorityNamespaceID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderAssigningAuthorityUniversalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderAssigningAuthorityIDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderNameTypeCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProviderIdentifierTypeCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SetIdOBR` bigint(20) NOT NULL,
  `UsiID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UsiText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UsiCodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UsiIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UsiTextAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UsiCodeSystemNameAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UsiTextOriginal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationDateTimeStart` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationDateTimeEnd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenActionCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ResultDateTime` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ResultStatus` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObservationID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObservationText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObservationCodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObservationIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObservationTextAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObservationCodeSystemNameAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObservationTextOriginal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObservationSubID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentPlacerOrderNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentPlacerOrderNamespace` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentPlacerOrderUniversalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentPlacerOrderUniversalIDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentFillerOrderNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentFillerOrderNamespace` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentFillerOrderUniversalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentFillerOrderUniversalIDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ListEhrLabResultsHandlingF` tinyint(4) NOT NULL,
  `ListEhrLabResultsHandlingN` tinyint(4) NOT NULL,
  `TQ1SetId` bigint(20) NOT NULL,
  `TQ1DateTimeStart` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TQ1DateTimeEnd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsCpoe` tinyint(4) NOT NULL,
  `OriginalPIDSegment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrLabNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `SetIdOBR`(`SetIdOBR`) USING BTREE,
  INDEX `TQ1SetId`(`TQ1SetId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrlabclinicalinfo
-- ----------------------------
DROP TABLE IF EXISTS `ehrlabclinicalinfo`;
CREATE TABLE `ehrlabclinicalinfo`  (
  `EhrLabClinicalInfoNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EhrLabNum` bigint(20) NOT NULL,
  `ClinicalInfoID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicalInfoText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicalInfoCodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicalInfoIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicalInfoTextAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicalInfoCodeSystemNameAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicalInfoTextOriginal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrLabClinicalInfoNum`) USING BTREE,
  INDEX `EhrLabNum`(`EhrLabNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrlabimage
-- ----------------------------
DROP TABLE IF EXISTS `ehrlabimage`;
CREATE TABLE `ehrlabimage`  (
  `EhrLabImageNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EhrLabNum` bigint(20) NOT NULL,
  `DocNum` bigint(20) NOT NULL,
  PRIMARY KEY (`EhrLabImageNum`) USING BTREE,
  INDEX `EhrLabNum`(`EhrLabNum`) USING BTREE,
  INDEX `DocNum`(`DocNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for ehrlabnote
-- ----------------------------
DROP TABLE IF EXISTS `ehrlabnote`;
CREATE TABLE `ehrlabnote`  (
  `EhrLabNoteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EhrLabNum` bigint(20) NOT NULL,
  `EhrLabResultNum` bigint(20) NOT NULL,
  `Comments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrLabNoteNum`) USING BTREE,
  INDEX `EhrLabNum`(`EhrLabNum`) USING BTREE,
  INDEX `EhrLabResultNum`(`EhrLabResultNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrlabresult
-- ----------------------------
DROP TABLE IF EXISTS `ehrlabresult`;
CREATE TABLE `ehrlabresult`  (
  `EhrLabResultNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EhrLabNum` bigint(20) NOT NULL,
  `SetIdOBX` bigint(20) NOT NULL,
  `ValueType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationIdentifierID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationIdentifierText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationIdentifierCodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationIdentifierIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationIdentifierTextAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationIdentifierCodeSystemNameAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationIdentifierTextOriginal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationIdentifierSub` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueCodedElementID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueCodedElementText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueCodedElementCodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueCodedElementIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueCodedElementTextAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueCodedElementCodeSystemNameAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueCodedElementTextOriginal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueDateTime` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueTime` time NOT NULL DEFAULT '00:00:00',
  `ObservationValueComparator` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueNumber1` double NOT NULL,
  `ObservationValueSeparatorOrSuffix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationValueNumber2` double NOT NULL,
  `ObservationValueNumeric` double NOT NULL,
  `ObservationValueText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitsID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitsText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitsCodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitsIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitsTextAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitsCodeSystemNameAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitsTextOriginal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `referenceRange` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AbnormalFlags` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationResultStatus` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObservationDateTime` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AnalysisDateTime` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationNameAssigningAuthorityNamespaceId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationNameAssigningAuthorityUniversalId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationNameAssigningAuthorityUniversalIdType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationIdentifierTypeCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationIdentifier` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationAddressStreet` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationAddressOtherDesignation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationAddressCity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationAddressStateOrProvince` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationAddressZipOrPostalCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationAddressCountryCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationAddressAddressType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PerformingOrganizationAddressCountyOrParishCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorLName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorFName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorMiddleNames` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorSuffix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorPrefix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorAssigningAuthorityNamespaceID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorAssigningAuthorityUniversalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorAssigningAuthorityIDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorNameTypeCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalDirectorIdentifierTypeCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrLabResultNum`) USING BTREE,
  INDEX `EhrLabNum`(`EhrLabNum`) USING BTREE,
  INDEX `SetIdOBX`(`SetIdOBX`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrlabresultscopyto
-- ----------------------------
DROP TABLE IF EXISTS `ehrlabresultscopyto`;
CREATE TABLE `ehrlabresultscopyto`  (
  `EhrLabResultsCopyToNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EhrLabNum` bigint(20) NOT NULL,
  `CopyToID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToLName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToFName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToMiddleNames` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToSuffix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToPrefix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToAssigningAuthorityNamespaceID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToAssigningAuthorityUniversalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToAssigningAuthorityIDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToNameTypeCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CopyToIdentifierTypeCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrLabResultsCopyToNum`) USING BTREE,
  INDEX `EhrLabNum`(`EhrLabNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrlabspecimen
-- ----------------------------
DROP TABLE IF EXISTS `ehrlabspecimen`;
CREATE TABLE `ehrlabspecimen`  (
  `EhrLabSpecimenNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EhrLabNum` bigint(20) NOT NULL,
  `SetIdSPM` bigint(20) NOT NULL,
  `SpecimenTypeID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenTypeText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenTypeCodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenTypeIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenTypeTextAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenTypeCodeSystemNameAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenTypeTextOriginal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CollectionDateTimeStart` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CollectionDateTimeEnd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrLabSpecimenNum`) USING BTREE,
  INDEX `EhrLabNum`(`EhrLabNum`) USING BTREE,
  INDEX `SetIdSPM`(`SetIdSPM`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrlabspecimencondition
-- ----------------------------
DROP TABLE IF EXISTS `ehrlabspecimencondition`;
CREATE TABLE `ehrlabspecimencondition`  (
  `EhrLabSpecimenConditionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EhrLabSpecimenNum` bigint(20) NOT NULL,
  `SpecimenConditionID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenConditionText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenConditionCodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenConditionIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenConditionTextAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenConditionCodeSystemNameAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenConditionTextOriginal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrLabSpecimenConditionNum`) USING BTREE,
  INDEX `EhrLabSpecimenNum`(`EhrLabSpecimenNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrlabspecimenrejectreason
-- ----------------------------
DROP TABLE IF EXISTS `ehrlabspecimenrejectreason`;
CREATE TABLE `ehrlabspecimenrejectreason`  (
  `EhrLabSpecimenRejectReasonNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EhrLabSpecimenNum` bigint(20) NOT NULL,
  `SpecimenRejectReasonID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenRejectReasonText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenRejectReasonCodeSystemName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenRejectReasonIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenRejectReasonTextAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenRejectReasonCodeSystemNameAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenRejectReasonTextOriginal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrLabSpecimenRejectReasonNum`) USING BTREE,
  INDEX `EhrLabSpecimenNum`(`EhrLabSpecimenNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrmeasure
-- ----------------------------
DROP TABLE IF EXISTS `ehrmeasure`;
CREATE TABLE `ehrmeasure`  (
  `EhrMeasureNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MeasureType` tinyint(4) NOT NULL,
  `Numerator` smallint(6) NOT NULL,
  `Denominator` smallint(6) NOT NULL,
  PRIMARY KEY (`EhrMeasureNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 37 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for ehrmeasureevent
-- ----------------------------
DROP TABLE IF EXISTS `ehrmeasureevent`;
CREATE TABLE `ehrmeasureevent`  (
  `EhrMeasureEventNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateTEvent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `EventType` tinyint(4) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `MoreInfo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeValueEvent` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeSystemEvent` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeValueResult` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeSystemResult` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `TobaccoCessationDesire` tinyint(3) UNSIGNED NOT NULL,
  `DateStartTobacco` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`EhrMeasureEventNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `CodeValueEvent`(`CodeValueEvent`) USING BTREE,
  INDEX `CodeValueResult`(`CodeValueResult`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrnotperformed
-- ----------------------------
DROP TABLE IF EXISTS `ehrnotperformed`;
CREATE TABLE `ehrnotperformed`  (
  `EhrNotPerformedNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `CodeValue` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeSystem` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeValueReason` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeSystemReason` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateEntry` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`EhrNotPerformedNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `CodeValue`(`CodeValue`) USING BTREE,
  INDEX `CodeValueReason`(`CodeValueReason`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrpatient
-- ----------------------------
DROP TABLE IF EXISTS `ehrpatient`;
CREATE TABLE `ehrpatient`  (
  `PatNum` bigint(20) NOT NULL,
  `MotherMaidenFname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MotherMaidenLname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `VacShareOk` tinyint(4) NOT NULL,
  `MedicaidState` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SexualOrientation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GenderIdentity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SexualOrientationNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GenderIdentityNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DischargeDate` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`PatNum`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrprovkey
-- ----------------------------
DROP TABLE IF EXISTS `ehrprovkey`;
CREATE TABLE `ehrprovkey`  (
  `EhrProvKeyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `LName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvKey` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FullTimeEquiv` float NOT NULL,
  `Notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `YearValue` int(11) NOT NULL,
  PRIMARY KEY (`EhrProvKeyNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrquarterlykey
-- ----------------------------
DROP TABLE IF EXISTS `ehrquarterlykey`;
CREATE TABLE `ehrquarterlykey`  (
  `EhrQuarterlyKeyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `YearValue` int(11) NOT NULL,
  `QuarterValue` int(11) NOT NULL,
  `PracticeName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `KeyValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `Notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EhrQuarterlyKeyNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrsummaryccd
-- ----------------------------
DROP TABLE IF EXISTS `ehrsummaryccd`;
CREATE TABLE `ehrsummaryccd`  (
  `EhrSummaryCcdNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateSummary` date NOT NULL DEFAULT '0001-01-01',
  `ContentSummary` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailAttachNum` bigint(20) NOT NULL,
  PRIMARY KEY (`EhrSummaryCcdNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `EmailAttachNum`(`EmailAttachNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ehrtrigger
-- ----------------------------
DROP TABLE IF EXISTS `ehrtrigger`;
CREATE TABLE `ehrtrigger`  (
  `EhrTriggerNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProblemSnomedList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProblemIcd9List` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProblemIcd10List` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProblemDefNumList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicationNumList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RxCuiList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CvxList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AllergyDefNumList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DemographicsList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LabLoincList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `VitalLoincList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Instructions` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Bibliography` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Cardinality` tinyint(4) NOT NULL,
  PRIMARY KEY (`EhrTriggerNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for electid
-- ----------------------------
DROP TABLE IF EXISTS `electid`;
CREATE TABLE `electid`  (
  `ElectIDNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PayorID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `CarrierName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsMedicaid` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ProviderTypes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Comments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CommBridge` tinyint(4) NOT NULL,
  `Attributes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ElectIDNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 719 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emailaddress
-- ----------------------------
DROP TABLE IF EXISTS `emailaddress`;
CREATE TABLE `emailaddress`  (
  `EmailAddressNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SMTPserver` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailUsername` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailPassword` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ServerPort` int(11) NOT NULL,
  `UseSSL` tinyint(4) NOT NULL,
  `SenderAddress` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Pop3ServerIncoming` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ServerPortIncoming` int(11) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `AccessToken` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RefreshToken` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DownloadInbox` tinyint(4) NOT NULL,
  `QueryString` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AuthenticationType` tinyint(4) NOT NULL,
  PRIMARY KEY (`EmailAddressNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emailattach
-- ----------------------------
DROP TABLE IF EXISTS `emailattach`;
CREATE TABLE `emailattach`  (
  `EmailAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EmailMessageNum` bigint(20) NOT NULL,
  `DisplayedFileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ActualFileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `EmailTemplateNum` bigint(20) NOT NULL,
  PRIMARY KEY (`EmailAttachNum`) USING BTREE,
  INDEX `EmailMessageNum`(`EmailMessageNum`) USING BTREE,
  INDEX `EmailTemplateNum`(`EmailTemplateNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emailautograph
-- ----------------------------
DROP TABLE IF EXISTS `emailautograph`;
CREATE TABLE `emailautograph`  (
  `EmailAutographNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailAddress` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AutographText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EmailAutographNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emailhostingtemplate
-- ----------------------------
DROP TABLE IF EXISTS `emailhostingtemplate`;
CREATE TABLE `emailhostingtemplate`  (
  `EmailHostingTemplateNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TemplateName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Subject` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BodyPlainText` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BodyHTML` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateId` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `EmailTemplateType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EmailHostingTemplateNum`) USING BTREE,
  INDEX `TemplateId`(`TemplateId`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emailmessage
-- ----------------------------
DROP TABLE IF EXISTS `emailmessage`;
CREATE TABLE `emailmessage`  (
  `EmailMessageNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ToAddress` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FromAddress` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Subject` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `BodyText` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MsgDateTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `SentOrReceived` tinyint(3) UNSIGNED NOT NULL,
  `RecipientAddress` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RawEmailIn` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvNumWebMail` bigint(20) NOT NULL,
  `PatNumSubj` bigint(20) NOT NULL,
  `CcAddress` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BccAddress` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HideIn` tinyint(4) NOT NULL,
  `AptNum` bigint(20) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `HtmlType` tinyint(4) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `MsgType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FailReason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EmailMessageNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProvNumWebMail`(`ProvNumWebMail`) USING BTREE,
  INDEX `PatNumSubj`(`PatNumSubj`) USING BTREE,
  INDEX `AptNum`(`AptNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `MsgBoxCompound`(`MsgDateTime`, `SentOrReceived`) USING BTREE,
  INDEX `SentOrReceived`(`SentOrReceived`) USING BTREE,
  INDEX `MsgHistoricAddresses`(`SentOrReceived`, `RecipientAddress`(50), `FromAddress`(50)) USING BTREE,
  INDEX `SecDateTEntry`(`SecDateTEntry`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emailmessageuid
-- ----------------------------
DROP TABLE IF EXISTS `emailmessageuid`;
CREATE TABLE `emailmessageuid`  (
  `EmailMessageUidNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MsgId` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RecipientAddress` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EmailMessageUidNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emailsecure
-- ----------------------------
DROP TABLE IF EXISTS `emailsecure`;
CREATE TABLE `emailsecure`  (
  `EmailSecureNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `EmailMessageNum` bigint(20) NOT NULL,
  `EmailChainFK` bigint(20) NOT NULL,
  `EmailFK` bigint(20) NOT NULL,
  `DateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EmailSecureNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `EmailMessageNum`(`EmailMessageNum`) USING BTREE,
  INDEX `EmailChainFK`(`EmailChainFK`) USING BTREE,
  INDEX `EmailFK`(`EmailFK`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for emailsecureattach
-- ----------------------------
DROP TABLE IF EXISTS `emailsecureattach`;
CREATE TABLE `emailsecureattach`  (
  `EmailSecureAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `EmailAttachNum` bigint(20) NOT NULL,
  `EmailSecureNum` bigint(20) NOT NULL,
  `AttachmentGuid` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DisplayedFileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Extension` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EmailSecureAttachNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `EmailAttachNum`(`EmailAttachNum`) USING BTREE,
  INDEX `EmailSecureNum`(`EmailSecureNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emailtemplate
-- ----------------------------
DROP TABLE IF EXISTS `emailtemplate`;
CREATE TABLE `emailtemplate`  (
  `EmailTemplateNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Subject` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `BodyText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TemplateType` tinyint(4) NOT NULL,
  PRIMARY KEY (`EmailTemplateNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `EmployeeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `MiddleI` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsHidden` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `ClockStatus` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PhoneExt` int(11) NOT NULL,
  `PayrollID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WirelessPhone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailWork` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailPersonal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsFurloughed` tinyint(4) NOT NULL,
  `IsWorkingHome` tinyint(4) NOT NULL,
  `ReportsTo` bigint(20) NOT NULL,
  PRIMARY KEY (`EmployeeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for employer
-- ----------------------------
DROP TABLE IF EXISTS `employer`;
CREATE TABLE `employer`  (
  `EmployerNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EmpName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Address2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `City` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `State` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Zip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`EmployerNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for encounter
-- ----------------------------
DROP TABLE IF EXISTS `encounter`;
CREATE TABLE `encounter`  (
  `EncounterNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `CodeValue` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeSystem` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateEncounter` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`EncounterNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `CodeValue`(`CodeValue`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for entrylog
-- ----------------------------
DROP TABLE IF EXISTS `entrylog`;
CREATE TABLE `entrylog`  (
  `EntryLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `FKeyType` tinyint(4) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `LogSource` tinyint(4) NOT NULL,
  `EntryDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`EntryLogNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `EntryDateTime`(`EntryDateTime`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for eobattach
-- ----------------------------
DROP TABLE IF EXISTS `eobattach`;
CREATE TABLE `eobattach`  (
  `EobAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClaimPaymentNum` bigint(20) NOT NULL,
  `DateTCreated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `FileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RawBase64` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClaimNumPreAuth` bigint(20) NOT NULL,
  PRIMARY KEY (`EobAttachNum`) USING BTREE,
  INDEX `ClaimPaymentNum`(`ClaimPaymentNum`) USING BTREE,
  INDEX `ClaimNumPreAuth`(`ClaimNumPreAuth`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment`  (
  `EquipmentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SerialNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ModelYear` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DatePurchased` date NOT NULL DEFAULT '0001-01-01',
  `DateSold` date NOT NULL DEFAULT '0001-01-01',
  `PurchaseCost` double NOT NULL,
  `MarketValue` double NOT NULL,
  `Location` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateEntry` date NOT NULL DEFAULT '0001-01-01',
  `ProvNumCheckedOut` bigint(20) NOT NULL,
  `DateCheckedOut` date NOT NULL DEFAULT '0001-01-01',
  `DateExpectedBack` date NOT NULL DEFAULT '0001-01-01',
  `DispenseNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Status` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EquipmentNum`) USING BTREE,
  INDEX `ProvNumCheckedOut`(`ProvNumCheckedOut`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for erouting
-- ----------------------------
DROP TABLE IF EXISTS `erouting`;
CREATE TABLE `erouting`  (
  `ERoutingNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `IsComplete` tinyint(4) NOT NULL,
  PRIMARY KEY (`ERoutingNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eroutingaction
-- ----------------------------
DROP TABLE IF EXISTS `eroutingaction`;
CREATE TABLE `eroutingaction`  (
  `ERoutingActionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ERoutingNum` bigint(20) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `ERoutingActionType` tinyint(4) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `IsComplete` tinyint(4) NOT NULL,
  `DateTimeComplete` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ForeignKeyType` tinyint(4) NOT NULL,
  `ForeignKey` bigint(20) NOT NULL,
  `LabelOverride` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ERoutingActionNum`) USING BTREE,
  INDEX `ERoutingNum`(`ERoutingNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eroutingactiondef
-- ----------------------------
DROP TABLE IF EXISTS `eroutingactiondef`;
CREATE TABLE `eroutingactiondef`  (
  `ERoutingActionDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ERoutingDefNum` bigint(20) NOT NULL,
  `ERoutingActionType` tinyint(4) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTLastModified` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ForeignKeyType` tinyint(4) NOT NULL,
  `ForeignKey` bigint(20) NOT NULL,
  `LabelOverride` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ERoutingActionDefNum`) USING BTREE,
  INDEX `ERoutingDefNum`(`ERoutingDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eroutingdef
-- ----------------------------
DROP TABLE IF EXISTS `eroutingdef`;
CREATE TABLE `eroutingdef`  (
  `ERoutingDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserNumCreated` bigint(20) NOT NULL,
  `UserNumModified` bigint(20) NOT NULL,
  `SecDateTEntered` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateLastModified` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`ERoutingDefNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `UserNumCreated`(`UserNumCreated`) USING BTREE,
  INDEX `UserNumModified`(`UserNumModified`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eroutingdeflink
-- ----------------------------
DROP TABLE IF EXISTS `eroutingdeflink`;
CREATE TABLE `eroutingdeflink`  (
  `ERoutingDefLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ERoutingDefNum` bigint(20) NOT NULL,
  `Fkey` bigint(20) NOT NULL,
  `ERoutingType` tinyint(4) NOT NULL,
  PRIMARY KEY (`ERoutingDefLinkNum`) USING BTREE,
  INDEX `ERoutingDefNum`(`ERoutingDefNum`) USING BTREE,
  INDEX `Fkey`(`Fkey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for erxlog
-- ----------------------------
DROP TABLE IF EXISTS `erxlog`;
CREATE TABLE `erxlog`  (
  `ErxLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `MsgText` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `ProvNum` bigint(20) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ErxLogNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eservicelog
-- ----------------------------
DROP TABLE IF EXISTS `eservicelog`;
CREATE TABLE `eservicelog`  (
  `EServiceLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LogDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `PatNum` bigint(20) NOT NULL,
  `EServiceType` tinyint(4) NULL DEFAULT NULL,
  `EServiceAction` smallint(6) NULL DEFAULT NULL,
  `KeyType` smallint(6) NULL DEFAULT NULL,
  `LogGuid` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NULL DEFAULT NULL,
  `FKey` bigint(20) NULL DEFAULT NULL,
  `DateTimeUploaded` datetime NOT NULL DEFAULT '0001-01-01 12:00:00',
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EServiceLogNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `DateTimeUploaded`(`DateTimeUploaded`) USING BTREE,
  INDEX `ClinicDateTime`(`ClinicNum`, `LogDateTime`) USING BTREE,
  INDEX `LogGuid`(`LogGuid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eserviceshortguid
-- ----------------------------
DROP TABLE IF EXISTS `eserviceshortguid`;
CREATE TABLE `eserviceshortguid`  (
  `EServiceShortGuidNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EServiceCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ShortGuid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ShortURL` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `FKeyType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeExpiration` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`EServiceShortGuidNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `ShortGuid`(`ShortGuid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eservicesignal
-- ----------------------------
DROP TABLE IF EXISTS `eservicesignal`;
CREATE TABLE `eservicesignal`  (
  `EServiceSignalNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ServiceCode` int(11) NOT NULL,
  `ReasonCategory` int(11) NOT NULL,
  `ReasonCode` int(11) NOT NULL,
  `Severity` tinyint(4) NOT NULL,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SigDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Tag` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsProcessed` tinyint(4) NOT NULL,
  PRIMARY KEY (`EServiceSignalNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 44 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for etrans
-- ----------------------------
DROP TABLE IF EXISTS `etrans`;
CREATE TABLE `etrans`  (
  `EtransNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateTimeTrans` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ClearingHouseNum` bigint(20) NOT NULL,
  `Etype` tinyint(3) UNSIGNED NOT NULL,
  `ClaimNum` bigint(20) NOT NULL,
  `OfficeSequenceNumber` int(11) NOT NULL,
  `CarrierTransCounter` int(11) NOT NULL,
  `CarrierTransCounter2` int(11) NOT NULL,
  `CarrierNum` bigint(20) NOT NULL,
  `CarrierNum2` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `BatchNumber` int(11) NOT NULL,
  `AckCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `TransSetNum` int(11) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `EtransMessageTextNum` bigint(20) NOT NULL,
  `AckEtransNum` bigint(20) NOT NULL,
  `PlanNum` bigint(20) NOT NULL,
  `InsSubNum` bigint(20) NOT NULL,
  `TranSetId835` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CarrierNameRaw` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatientNameRaw` varchar(133) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  PRIMARY KEY (`EtransNum`) USING BTREE,
  INDEX `ClaimNum`(`ClaimNum`) USING BTREE,
  INDEX `CarrierNum`(`CarrierNum`) USING BTREE,
  INDEX `CarrierNum2`(`CarrierNum2`) USING BTREE,
  INDEX `PlanNum`(`PlanNum`) USING BTREE,
  INDEX `InsSubNum`(`InsSubNum`) USING BTREE,
  INDEX `EtransMessageTextNum`(`EtransMessageTextNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `EtransTypeAndDate`(`Etype`, `DateTimeTrans`) USING BTREE,
  INDEX `ClearingHouseNum`(`ClearingHouseNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `AckEtransNum`(`AckEtransNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for etrans835
-- ----------------------------
DROP TABLE IF EXISTS `etrans835`;
CREATE TABLE `etrans835`  (
  `Etrans835Num` bigint(20) NOT NULL AUTO_INCREMENT,
  `EtransNum` bigint(20) NOT NULL,
  `PayerName` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TransRefNum` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `InsPaid` double NOT NULL,
  `ControlId` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PaymentMethodCode` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatientName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Status` tinyint(4) NOT NULL,
  `AutoProcessed` tinyint(4) NOT NULL,
  `IsApproved` tinyint(4) NOT NULL,
  PRIMARY KEY (`Etrans835Num`) USING BTREE,
  INDEX `EtransNum`(`EtransNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for etrans835attach
-- ----------------------------
DROP TABLE IF EXISTS `etrans835attach`;
CREATE TABLE `etrans835attach`  (
  `Etrans835AttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EtransNum` bigint(20) NOT NULL,
  `ClaimNum` bigint(20) NOT NULL,
  `ClpSegmentIndex` int(11) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`Etrans835AttachNum`) USING BTREE,
  INDEX `EtransNum`(`EtransNum`) USING BTREE,
  INDEX `ClaimNum`(`ClaimNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for etransmessagetext
-- ----------------------------
DROP TABLE IF EXISTS `etransmessagetext`;
CREATE TABLE `etransmessagetext`  (
  `EtransMessageTextNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MessageText` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EtransMessageTextNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for evaluation
-- ----------------------------
DROP TABLE IF EXISTS `evaluation`;
CREATE TABLE `evaluation`  (
  `EvaluationNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `InstructNum` bigint(20) NOT NULL,
  `StudentNum` bigint(20) NOT NULL,
  `SchoolCourseNum` bigint(20) NOT NULL,
  `EvalTitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateEval` date NOT NULL DEFAULT '0001-01-01',
  `GradingScaleNum` bigint(20) NOT NULL,
  `OverallGradeShowing` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OverallGradeNumber` float NOT NULL,
  `Notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EvaluationNum`) USING BTREE,
  INDEX `InstructNum`(`InstructNum`) USING BTREE,
  INDEX `StudentNum`(`StudentNum`) USING BTREE,
  INDEX `SchoolCourseNum`(`SchoolCourseNum`) USING BTREE,
  INDEX `GradingScaleNum`(`GradingScaleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for evaluationcriterion
-- ----------------------------
DROP TABLE IF EXISTS `evaluationcriterion`;
CREATE TABLE `evaluationcriterion`  (
  `EvaluationCriterionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EvaluationNum` bigint(20) NOT NULL,
  `CriterionDescript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsCategoryName` tinyint(4) NOT NULL,
  `GradingScaleNum` bigint(20) NOT NULL,
  `GradeShowing` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GradeNumber` float NOT NULL,
  `Notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `MaxPointsPoss` float NOT NULL,
  PRIMARY KEY (`EvaluationCriterionNum`) USING BTREE,
  INDEX `EvaluationNum`(`EvaluationNum`) USING BTREE,
  INDEX `GradingScaleNum`(`GradingScaleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for evaluationcriteriondef
-- ----------------------------
DROP TABLE IF EXISTS `evaluationcriteriondef`;
CREATE TABLE `evaluationcriteriondef`  (
  `EvaluationCriterionDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EvaluationDefNum` bigint(20) NOT NULL,
  `CriterionDescript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsCategoryName` tinyint(4) NOT NULL,
  `GradingScaleNum` bigint(20) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `MaxPointsPoss` float NOT NULL,
  PRIMARY KEY (`EvaluationCriterionDefNum`) USING BTREE,
  INDEX `EvaluationDefNum`(`EvaluationDefNum`) USING BTREE,
  INDEX `GradingScaleNum`(`GradingScaleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for evaluationdef
-- ----------------------------
DROP TABLE IF EXISTS `evaluationdef`;
CREATE TABLE `evaluationdef`  (
  `EvaluationDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SchoolCourseNum` bigint(20) NOT NULL,
  `EvalTitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GradingScaleNum` bigint(20) NOT NULL,
  PRIMARY KEY (`EvaluationDefNum`) USING BTREE,
  INDEX `SchoolCourseNum`(`SchoolCourseNum`) USING BTREE,
  INDEX `GradingScaleNum`(`GradingScaleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for famaging
-- ----------------------------
DROP TABLE IF EXISTS `famaging`;
CREATE TABLE `famaging`  (
  `PatNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Bal_0_30` double NOT NULL,
  `Bal_31_60` double NOT NULL,
  `Bal_61_90` double NOT NULL,
  `BalOver90` double NOT NULL,
  `InsEst` double NOT NULL,
  `BalTotal` double NOT NULL,
  `PayPlanDue` double NOT NULL,
  PRIMARY KEY (`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for familyhealth
-- ----------------------------
DROP TABLE IF EXISTS `familyhealth`;
CREATE TABLE `familyhealth`  (
  `FamilyHealthNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `Relationship` tinyint(4) NOT NULL,
  `DiseaseDefNum` bigint(20) NOT NULL,
  `PersonName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`FamilyHealthNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `DiseaseDefNum`(`DiseaseDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fee
-- ----------------------------
DROP TABLE IF EXISTS `fee`;
CREATE TABLE `fee`  (
  `FeeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Amount` double NOT NULL DEFAULT 0,
  `OldCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `FeeSched` bigint(20) NOT NULL,
  `UseDefaultFee` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `UseDefaultCov` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `CodeNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DateEffective` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`FeeNum`) USING BTREE,
  INDEX `indexADACode`(`OldCode`) USING BTREE,
  INDEX `CodeNum`(`CodeNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `FeeSchedCodeClinicProv`(`FeeSched`, `CodeNum`, `ClinicNum`, `ProvNum`) USING BTREE,
  INDEX `FeeSchedCodeClinicProvDate`(`FeeSched`, `CodeNum`, `ClinicNum`, `ProvNum`, `DateEffective`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 193 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for feesched
-- ----------------------------
DROP TABLE IF EXISTS `feesched`;
CREATE TABLE `feesched`  (
  `FeeSchedNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FeeSchedType` int(11) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `IsHidden` tinyint(1) NOT NULL,
  `IsGlobal` tinyint(4) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`FeeSchedNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 58 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for feeschedgroup
-- ----------------------------
DROP TABLE IF EXISTS `feeschedgroup`;
CREATE TABLE `feeschedgroup`  (
  `FeeSchedGroupNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FeeSchedNum` bigint(20) NOT NULL,
  `ClinicNums` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`FeeSchedGroupNum`) USING BTREE,
  INDEX `FeeSchedNum`(`FeeSchedNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for feeschednote
-- ----------------------------
DROP TABLE IF EXISTS `feeschednote`;
CREATE TABLE `feeschednote`  (
  `FeeSchedNoteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FeeSchedNum` bigint(20) NOT NULL,
  `ClinicNums` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`FeeSchedNoteNum`) USING BTREE,
  INDEX `FeeSchedNum`(`FeeSchedNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fhircontactpoint
-- ----------------------------
DROP TABLE IF EXISTS `fhircontactpoint`;
CREATE TABLE `fhircontactpoint`  (
  `FHIRContactPointNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FHIRSubscriptionNum` bigint(20) NOT NULL,
  `ContactSystem` tinyint(4) NOT NULL,
  `ContactValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ContactUse` tinyint(4) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `DateStart` date NOT NULL DEFAULT '0001-01-01',
  `DateEnd` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`FHIRContactPointNum`) USING BTREE,
  INDEX `FHIRSubscriptionNum`(`FHIRSubscriptionNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fhirsubscription
-- ----------------------------
DROP TABLE IF EXISTS `fhirsubscription`;
CREATE TABLE `fhirsubscription`  (
  `FHIRSubscriptionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Criteria` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SubStatus` tinyint(4) NOT NULL,
  `ErrorNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ChannelType` tinyint(4) NOT NULL,
  `ChannelEndpoint` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ChannelPayLoad` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ChannelHeader` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateEnd` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `APIKeyHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`FHIRSubscriptionNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fielddeflink
-- ----------------------------
DROP TABLE IF EXISTS `fielddeflink`;
CREATE TABLE `fielddeflink`  (
  `FieldDefLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FieldDefNum` bigint(20) NOT NULL,
  `FieldDefType` tinyint(4) NOT NULL,
  `FieldLocation` tinyint(4) NOT NULL,
  PRIMARY KEY (`FieldDefLinkNum`) USING BTREE,
  INDEX `FieldDefNum`(`FieldDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for formpat
-- ----------------------------
DROP TABLE IF EXISTS `formpat`;
CREATE TABLE `formpat`  (
  `FormPatNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `FormDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`FormPatNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for gradingscale
-- ----------------------------
DROP TABLE IF EXISTS `gradingscale`;
CREATE TABLE `gradingscale`  (
  `GradingScaleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ScaleType` tinyint(4) NOT NULL,
  PRIMARY KEY (`GradingScaleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gradingscaleitem
-- ----------------------------
DROP TABLE IF EXISTS `gradingscaleitem`;
CREATE TABLE `gradingscaleitem`  (
  `GradingScaleItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `GradingScaleNum` bigint(20) NOT NULL,
  `GradeShowing` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GradeNumber` float NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`GradingScaleItemNum`) USING BTREE,
  INDEX `GradingScaleNum`(`GradingScaleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for grouppermission
-- ----------------------------
DROP TABLE IF EXISTS `grouppermission`;
CREATE TABLE `grouppermission`  (
  `GroupPermNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `NewerDate` date NOT NULL DEFAULT '0001-01-01',
  `NewerDays` int(11) NOT NULL,
  `UserGroupNum` bigint(20) NOT NULL,
  `PermType` smallint(6) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  PRIMARY KEY (`GroupPermNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `UserGroupNum`(`UserGroupNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 822 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for guardian
-- ----------------------------
DROP TABLE IF EXISTS `guardian`;
CREATE TABLE `guardian`  (
  `GuardianNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNumChild` bigint(20) NOT NULL,
  `PatNumGuardian` bigint(20) NOT NULL,
  `Relationship` tinyint(4) NOT NULL,
  `IsGuardian` tinyint(4) NOT NULL,
  PRIMARY KEY (`GuardianNum`) USING BTREE,
  INDEX `PatNumChild`(`PatNumChild`) USING BTREE,
  INDEX `PatNumGuardian`(`PatNumGuardian`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for hcpcs
-- ----------------------------
DROP TABLE IF EXISTS `hcpcs`;
CREATE TABLE `hcpcs`  (
  `HcpcsNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `HcpcsCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DescriptionShort` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`HcpcsNum`) USING BTREE,
  INDEX `HcpcsCode`(`HcpcsCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hieclinic
-- ----------------------------
DROP TABLE IF EXISTS `hieclinic`;
CREATE TABLE `hieclinic`  (
  `HieClinicNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `SupportedCarrierFlags` tinyint(4) NOT NULL,
  `PathExportCCD` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TimeOfDayExportCCD` bigint(20) NOT NULL,
  `IsEnabled` tinyint(4) NOT NULL,
  PRIMARY KEY (`HieClinicNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `TimeOfDayExportCCD`(`TimeOfDayExportCCD`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hiequeue
-- ----------------------------
DROP TABLE IF EXISTS `hiequeue`;
CREATE TABLE `hiequeue`  (
  `HieQueueNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  PRIMARY KEY (`HieQueueNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for histappointment
-- ----------------------------
DROP TABLE IF EXISTS `histappointment`;
CREATE TABLE `histappointment`  (
  `HistApptNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `HistUserNum` bigint(20) NOT NULL,
  `HistDateTStamp` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `HistApptAction` tinyint(4) NOT NULL,
  `ApptSource` tinyint(4) NOT NULL,
  `AptNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `AptStatus` tinyint(4) NOT NULL,
  `Pattern` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Confirmed` bigint(20) NOT NULL,
  `TimeLocked` tinyint(4) NOT NULL,
  `Op` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `ProvHyg` bigint(20) NOT NULL,
  `AptDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `NextAptNum` bigint(20) NOT NULL,
  `UnschedStatus` bigint(20) NOT NULL,
  `IsNewPatient` tinyint(4) NOT NULL,
  `ProcDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Assistant` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `IsHygiene` tinyint(4) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DateTimeArrived` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeSeated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeDismissed` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `InsPlan1` bigint(20) NOT NULL,
  `InsPlan2` bigint(20) NOT NULL,
  `DateTimeAskedToArrive` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ProcsColored` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ColorOverride` int(11) NOT NULL,
  `AppointmentTypeNum` bigint(20) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Priority` tinyint(4) NOT NULL,
  `ProvBarText` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatternSecondary` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrderPlanned` int(11) NOT NULL,
  `IsMirrored` tinyint(4) NOT NULL,
  PRIMARY KEY (`HistApptNum`) USING BTREE,
  INDEX `HistUserNum`(`HistUserNum`) USING BTREE,
  INDEX `AptNum`(`AptNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `Confirmed`(`Confirmed`) USING BTREE,
  INDEX `Op`(`Op`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `ProvHyg`(`ProvHyg`) USING BTREE,
  INDEX `NextAptNum`(`NextAptNum`) USING BTREE,
  INDEX `UnschedStatus`(`UnschedStatus`) USING BTREE,
  INDEX `Assistant`(`Assistant`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `InsPlan1`(`InsPlan1`) USING BTREE,
  INDEX `InsPlan2`(`InsPlan2`) USING BTREE,
  INDEX `AppointmentTypeNum`(`AppointmentTypeNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `HistDateTStamp`(`HistDateTStamp`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hl7def
-- ----------------------------
DROP TABLE IF EXISTS `hl7def`;
CREATE TABLE `hl7def`  (
  `HL7DefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ModeTx` tinyint(4) NOT NULL,
  `IncomingFolder` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OutgoingFolder` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IncomingPort` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OutgoingIpPort` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FieldSeparator` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ComponentSeparator` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SubcomponentSeparator` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RepetitionSeparator` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EscapeCharacter` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsInternal` tinyint(4) NOT NULL,
  `InternalType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `InternalTypeVersion` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsEnabled` tinyint(4) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HL7Server` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HL7ServiceName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ShowDemographics` tinyint(4) NOT NULL,
  `ShowAppts` tinyint(4) NOT NULL,
  `ShowAccount` tinyint(4) NOT NULL,
  `IsQuadAsToothNum` tinyint(4) NOT NULL,
  `LabResultImageCat` bigint(20) NOT NULL,
  `SftpUsername` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SftpPassword` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SftpInSocket` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HasLongDCodes` tinyint(4) NOT NULL,
  `IsProcApptEnforced` tinyint(4) NOT NULL,
  PRIMARY KEY (`HL7DefNum`) USING BTREE,
  INDEX `LabResultImageCat`(`LabResultImageCat`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hl7deffield
-- ----------------------------
DROP TABLE IF EXISTS `hl7deffield`;
CREATE TABLE `hl7deffield`  (
  `HL7DefFieldNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `HL7DefSegmentNum` bigint(20) NOT NULL,
  `OrdinalPos` int(11) NOT NULL,
  `TableId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DataType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FixedText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`HL7DefFieldNum`) USING BTREE,
  INDEX `HL7DefSegmentNum`(`HL7DefSegmentNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hl7defmessage
-- ----------------------------
DROP TABLE IF EXISTS `hl7defmessage`;
CREATE TABLE `hl7defmessage`  (
  `HL7DefMessageNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `HL7DefNum` bigint(20) NOT NULL,
  `MessageType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EventType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `InOrOut` tinyint(4) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MessageStructure` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`HL7DefMessageNum`) USING BTREE,
  INDEX `HL7DefNum`(`HL7DefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hl7defsegment
-- ----------------------------
DROP TABLE IF EXISTS `hl7defsegment`;
CREATE TABLE `hl7defsegment`  (
  `HL7DefSegmentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `HL7DefMessageNum` bigint(20) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `CanRepeat` tinyint(4) NOT NULL,
  `IsOptional` tinyint(4) NOT NULL,
  `SegmentName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`HL7DefSegmentNum`) USING BTREE,
  INDEX `HL7DefMessageNum`(`HL7DefMessageNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hl7msg
-- ----------------------------
DROP TABLE IF EXISTS `hl7msg`;
CREATE TABLE `hl7msg`  (
  `HL7MsgNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `HL7Status` int(11) NOT NULL,
  `MsgText` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `AptNum` bigint(20) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `PatNum` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`HL7MsgNum`) USING BTREE,
  INDEX `AptNum`(`AptNum`) USING BTREE,
  INDEX `HL7Status`(`HL7Status`) USING BTREE,
  INDEX `DateTStamp`(`DateTStamp`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `MsgText`(`MsgText`(100)) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hl7procattach
-- ----------------------------
DROP TABLE IF EXISTS `hl7procattach`;
CREATE TABLE `hl7procattach`  (
  `HL7ProcAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `HL7MsgNum` bigint(20) NOT NULL,
  `ProcNum` bigint(20) NOT NULL,
  PRIMARY KEY (`HL7ProcAttachNum`) USING BTREE,
  INDEX `HL7MsgNum`(`HL7MsgNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for icd10
-- ----------------------------
DROP TABLE IF EXISTS `icd10`;
CREATE TABLE `icd10`  (
  `Icd10Num` bigint(20) NOT NULL AUTO_INCREMENT,
  `Icd10Code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`Icd10Num`) USING BTREE,
  INDEX `Icd10Code`(`Icd10Code`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for icd9
-- ----------------------------
DROP TABLE IF EXISTS `icd9`;
CREATE TABLE `icd9`  (
  `ICD9Num` bigint(20) NOT NULL AUTO_INCREMENT,
  `ICD9Code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ICD9Num`) USING BTREE,
  INDEX `ICD9Code`(`ICD9Code`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15652 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for imagedraw
-- ----------------------------
DROP TABLE IF EXISTS `imagedraw`;
CREATE TABLE `imagedraw`  (
  `ImageDrawNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DocNum` bigint(20) NOT NULL,
  `MountNum` bigint(20) NOT NULL,
  `ColorDraw` int(11) NOT NULL,
  `ColorBack` int(11) NOT NULL,
  `DrawingSegment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DrawText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FontSize` float NOT NULL,
  `DrawType` tinyint(4) NOT NULL,
  `ImageAnnotVendor` tinyint(4) NOT NULL,
  `Details` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PearlLayer` tinyint(4) NOT NULL,
  `BetterDiagLayer` tinyint(4) NOT NULL,
  PRIMARY KEY (`ImageDrawNum`) USING BTREE,
  INDEX `DocNum`(`DocNum`) USING BTREE,
  INDEX `MountNum`(`MountNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for imagingdevice
-- ----------------------------
DROP TABLE IF EXISTS `imagingdevice`;
CREATE TABLE `imagingdevice`  (
  `ImagingDeviceNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ComputerName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DeviceType` tinyint(4) NOT NULL,
  `TwainName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `ShowTwainUI` tinyint(4) NOT NULL,
  PRIMARY KEY (`ImagingDeviceNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insbluebook
-- ----------------------------
DROP TABLE IF EXISTS `insbluebook`;
CREATE TABLE `insbluebook`  (
  `InsBlueBookNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProcCodeNum` bigint(20) NOT NULL,
  `CarrierNum` bigint(20) NOT NULL,
  `PlanNum` bigint(20) NOT NULL,
  `GroupNum` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `InsPayAmt` double NOT NULL,
  `AllowedOverride` double NOT NULL,
  `DateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ProcNum` bigint(20) NOT NULL,
  `ProcDate` date NOT NULL DEFAULT '0001-01-01',
  `ClaimType` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClaimNum` bigint(20) NOT NULL,
  PRIMARY KEY (`InsBlueBookNum`) USING BTREE,
  INDEX `ProcCodeNum`(`ProcCodeNum`) USING BTREE,
  INDEX `CarrierNum`(`CarrierNum`) USING BTREE,
  INDEX `PlanNum`(`PlanNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `ClaimNum`(`ClaimNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insbluebooklog
-- ----------------------------
DROP TABLE IF EXISTS `insbluebooklog`;
CREATE TABLE `insbluebooklog`  (
  `InsBlueBookLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClaimProcNum` bigint(20) NOT NULL,
  `AllowedFee` double NOT NULL,
  `DateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`InsBlueBookLogNum`) USING BTREE,
  INDEX `ClaimProcNum`(`ClaimProcNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insbluebookrule
-- ----------------------------
DROP TABLE IF EXISTS `insbluebookrule`;
CREATE TABLE `insbluebookrule`  (
  `InsBlueBookRuleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ItemOrder` smallint(6) NOT NULL,
  `RuleType` tinyint(4) NOT NULL,
  `LimitValue` int(11) NOT NULL,
  `LimitType` tinyint(4) NOT NULL,
  PRIMARY KEY (`InsBlueBookRuleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for inseditlog
-- ----------------------------
DROP TABLE IF EXISTS `inseditlog`;
CREATE TABLE `inseditlog`  (
  `InsEditLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FKey` bigint(20) NOT NULL,
  `LogType` tinyint(4) NOT NULL,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OldValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NewValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `ParentKey` bigint(20) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`InsEditLogNum`) USING BTREE,
  INDEX `FKeyType`(`LogType`, `FKey`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `ParentKey`(`ParentKey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inseditpatlog
-- ----------------------------
DROP TABLE IF EXISTS `inseditpatlog`;
CREATE TABLE `inseditpatlog`  (
  `InsEditPatLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FKey` bigint(20) NOT NULL,
  `LogType` tinyint(4) NOT NULL,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OldValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NewValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `ParentKey` bigint(20) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`InsEditPatLogNum`) USING BTREE,
  INDEX `FkLogType`(`FKey`, `LogType`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `ParentKey`(`ParentKey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insfilingcode
-- ----------------------------
DROP TABLE IF EXISTS `insfilingcode`;
CREATE TABLE `insfilingcode`  (
  `InsFilingCodeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `EclaimCode` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ItemOrder` int(11) NULL DEFAULT NULL,
  `GroupType` bigint(20) NOT NULL,
  `ExcludeOtherCoverageOnPriClaims` tinyint(4) NOT NULL,
  PRIMARY KEY (`InsFilingCodeNum`) USING BTREE,
  INDEX `ItemOrder`(`ItemOrder`) USING BTREE,
  INDEX `GroupType`(`GroupType`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 24 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insfilingcodesubtype
-- ----------------------------
DROP TABLE IF EXISTS `insfilingcodesubtype`;
CREATE TABLE `insfilingcodesubtype`  (
  `InsFilingCodeSubtypeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `InsFilingCodeNum` bigint(20) NOT NULL,
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`InsFilingCodeSubtypeNum`) USING BTREE,
  INDEX `InsFilingCodeNum`(`InsFilingCodeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inspending
-- ----------------------------
DROP TABLE IF EXISTS `inspending`;
CREATE TABLE `inspending`  (
  `InsPendingNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `PatNumSubscriber` bigint(20) NOT NULL,
  `Ordinal` tinyint(3) UNSIGNED NOT NULL,
  `Relationship` tinyint(4) NOT NULL,
  `GroupNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GroupName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Employer` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SubscriberID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CarrierName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`InsPendingNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `PatNumSubscriber`(`PatNumSubscriber`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insplan
-- ----------------------------
DROP TABLE IF EXISTS `insplan`;
CREATE TABLE `insplan`  (
  `PlanNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `GroupName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `GroupNum` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PlanNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FeeSched` bigint(20) NOT NULL,
  `PlanType` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ClaimFormNum` bigint(20) NOT NULL,
  `UseAltCode` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `ClaimsUseUCR` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `CopayFeeSched` bigint(20) NOT NULL,
  `EmployerNum` bigint(20) NOT NULL,
  `CarrierNum` bigint(20) NOT NULL,
  `AllowedFeeSched` bigint(20) NOT NULL,
  `TrojanID` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DivisionNo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsMedical` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `FilingCode` bigint(20) NOT NULL,
  `DentaideCardSequence` tinyint(3) UNSIGNED NOT NULL,
  `ShowBaseUnits` tinyint(1) NOT NULL,
  `CodeSubstNone` tinyint(1) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `MonthRenew` tinyint(4) NOT NULL,
  `FilingCodeSubtype` bigint(20) NOT NULL,
  `CanadianPlanFlag` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanadianDiagnosticCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanadianInstitutionCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RxBIN` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CobRule` tinyint(4) NOT NULL,
  `SopCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `HideFromVerifyList` tinyint(4) NOT NULL,
  `OrthoType` tinyint(4) NOT NULL,
  `OrthoAutoProcFreq` tinyint(4) NOT NULL,
  `OrthoAutoProcCodeNumOverride` bigint(20) NOT NULL,
  `OrthoAutoFeeBilled` double NOT NULL,
  `OrthoAutoClaimDaysWait` int(11) NOT NULL,
  `BillingType` bigint(20) NOT NULL,
  `HasPpoSubstWriteoffs` tinyint(4) NOT NULL,
  `ExclusionFeeRule` tinyint(4) NOT NULL,
  `ManualFeeSchedNum` bigint(20) NOT NULL DEFAULT 0,
  `IsBlueBookEnabled` tinyint(4) NOT NULL DEFAULT 1,
  `InsPlansZeroWriteOffsOnAnnualMaxOverride` tinyint(4) NOT NULL,
  `InsPlansZeroWriteOffsOnFreqOrAgingOverride` tinyint(4) NOT NULL,
  `PerVisitPatAmount` double NOT NULL,
  `PerVisitInsAmount` double NOT NULL,
  PRIMARY KEY (`PlanNum`) USING BTREE,
  INDEX `CarrierNum`(`CarrierNum`) USING BTREE,
  INDEX `FilingCodeSubtype`(`FilingCodeSubtype`) USING BTREE,
  INDEX `TrojanID`(`TrojanID`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `CarrierNumPlanNum`(`CarrierNum`, `PlanNum`) USING BTREE,
  INDEX `OrthoAutoProcCodeNumOverride`(`OrthoAutoProcCodeNumOverride`) USING BTREE,
  INDEX `BillingType`(`BillingType`) USING BTREE,
  INDEX `FeeSched`(`FeeSched`) USING BTREE,
  INDEX `CopayFeeSched`(`CopayFeeSched`) USING BTREE,
  INDEX `ManualFeeSchedNum`(`ManualFeeSchedNum`) USING BTREE,
  INDEX `AllowedFeeSched`(`AllowedFeeSched`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 19 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insplanpreference
-- ----------------------------
DROP TABLE IF EXISTS `insplanpreference`;
CREATE TABLE `insplanpreference`  (
  `InsPlanPrefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PlanNum` bigint(20) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `FKeyType` tinyint(4) NOT NULL,
  `ValueString` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`InsPlanPrefNum`) USING BTREE,
  INDEX `PlanNum`(`PlanNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inssub
-- ----------------------------
DROP TABLE IF EXISTS `inssub`;
CREATE TABLE `inssub`  (
  `InsSubNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PlanNum` bigint(20) NOT NULL,
  `Subscriber` bigint(20) NOT NULL,
  `DateEffective` date NOT NULL DEFAULT '0001-01-01',
  `DateTerm` date NOT NULL DEFAULT '0001-01-01',
  `ReleaseInfo` tinyint(4) NOT NULL,
  `AssignBen` tinyint(4) NOT NULL,
  `SubscriberID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BenefitNotes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SubscNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`InsSubNum`) USING BTREE,
  INDEX `PlanNum`(`PlanNum`) USING BTREE,
  INDEX `Subscriber`(`Subscriber`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for installmentplan
-- ----------------------------
DROP TABLE IF EXISTS `installmentplan`;
CREATE TABLE `installmentplan`  (
  `InstallmentPlanNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateAgreement` date NOT NULL DEFAULT '0001-01-01',
  `DateFirstPayment` date NOT NULL DEFAULT '0001-01-01',
  `MonthlyPayment` double NOT NULL,
  `APR` float NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`InstallmentPlanNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insverify
-- ----------------------------
DROP TABLE IF EXISTS `insverify`;
CREATE TABLE `insverify`  (
  `InsVerifyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateLastVerified` date NOT NULL DEFAULT '0001-01-01',
  `UserNum` bigint(20) NOT NULL,
  `VerifyType` tinyint(4) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `DefNum` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateLastAssigned` date NOT NULL DEFAULT '0001-01-01',
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `HoursAvailableForVerification` double NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`InsVerifyNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `DefNum`(`DefNum`) USING BTREE,
  INDEX `VerifyType`(`VerifyType`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE,
  INDEX `DateTimeEntry`(`DateTimeEntry`) USING BTREE,
  INDEX `DateLastAssigned`(`DateLastAssigned`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insverifyhist
-- ----------------------------
DROP TABLE IF EXISTS `insverifyhist`;
CREATE TABLE `insverifyhist`  (
  `InsVerifyHistNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `InsVerifyNum` bigint(20) NOT NULL,
  `DateLastVerified` date NOT NULL DEFAULT '0001-01-01',
  `UserNum` bigint(20) NOT NULL,
  `VerifyType` tinyint(4) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `DefNum` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateLastAssigned` date NOT NULL DEFAULT '0001-01-01',
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `HoursAvailableForVerification` double NOT NULL,
  `VerifyUserNum` bigint(20) NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`InsVerifyHistNum`) USING BTREE,
  INDEX `InsVerifyNum`(`InsVerifyNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `DefNum`(`DefNum`) USING BTREE,
  INDEX `VerifyUserNum`(`VerifyUserNum`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for intervention
-- ----------------------------
DROP TABLE IF EXISTS `intervention`;
CREATE TABLE `intervention`  (
  `InterventionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `CodeValue` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeSystem` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateEntry` date NOT NULL DEFAULT '0001-01-01',
  `CodeSet` tinyint(4) NOT NULL,
  `IsPatDeclined` tinyint(4) NOT NULL,
  PRIMARY KEY (`InterventionNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `CodeValue`(`CodeValue`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for journalentry
-- ----------------------------
DROP TABLE IF EXISTS `journalentry`;
CREATE TABLE `journalentry`  (
  `JournalEntryNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TransactionNum` bigint(20) NOT NULL,
  `AccountNum` bigint(20) NOT NULL,
  `DateDisplayed` date NOT NULL DEFAULT '0001-01-01',
  `DebitAmt` double NOT NULL DEFAULT 0,
  `CreditAmt` double NOT NULL DEFAULT 0,
  `Memo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Splits` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CheckNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ReconcileNum` bigint(20) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecUserNumEdit` bigint(20) NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`JournalEntryNum`) USING BTREE,
  INDEX `indexAccountNum`(`AccountNum`) USING BTREE,
  INDEX `indexTransactionNum`(`TransactionNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `SecUserNumEdit`(`SecUserNumEdit`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for labcase
-- ----------------------------
DROP TABLE IF EXISTS `labcase`;
CREATE TABLE `labcase`  (
  `LabCaseNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `LaboratoryNum` bigint(20) NOT NULL,
  `AptNum` bigint(20) NOT NULL,
  `PlannedAptNum` bigint(20) NOT NULL,
  `DateTimeDue` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeCreated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeRecd` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeChecked` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ProvNum` bigint(20) NOT NULL,
  `Instructions` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `LabFee` double NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `InvoiceNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`LabCaseNum`) USING BTREE,
  INDEX `indexAptNum`(`AptNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for laboratory
-- ----------------------------
DROP TABLE IF EXISTS `laboratory`;
CREATE TABLE `laboratory`  (
  `LaboratoryNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Slip` bigint(20) NOT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `City` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `State` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Zip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WirelessPhone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  PRIMARY KEY (`LaboratoryNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for labpanel
-- ----------------------------
DROP TABLE IF EXISTS `labpanel`;
CREATE TABLE `labpanel`  (
  `LabPanelNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `RawMessage` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LabNameAddress` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `SpecimenCondition` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenSource` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ServiceId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ServiceName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicalOrderNum` bigint(20) NOT NULL,
  PRIMARY KEY (`LabPanelNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `MedicalOrderNum`(`MedicalOrderNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for labresult
-- ----------------------------
DROP TABLE IF EXISTS `labresult`;
CREATE TABLE `labresult`  (
  `LabResultNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LabPanelNum` bigint(20) NOT NULL,
  `DateTimeTest` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TestName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `TestID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsUnits` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsRange` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AbnormalFlag` tinyint(4) NOT NULL,
  PRIMARY KEY (`LabResultNum`) USING BTREE,
  INDEX `LabPanelNum`(`LabPanelNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for labturnaround
-- ----------------------------
DROP TABLE IF EXISTS `labturnaround`;
CREATE TABLE `labturnaround`  (
  `LabTurnaroundNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LaboratoryNum` bigint(20) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DaysPublished` smallint(6) NOT NULL,
  `DaysActual` smallint(6) NOT NULL,
  PRIMARY KEY (`LabTurnaroundNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for language
-- ----------------------------
DROP TABLE IF EXISTS `language`;
CREATE TABLE `language`  (
  `LanguageNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EnglishComments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ClassType` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `English` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsObsolete` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`LanguageNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 702 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for languageforeign
-- ----------------------------
DROP TABLE IF EXISTS `languageforeign`;
CREATE TABLE `languageforeign`  (
  `LanguageForeignNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClassType` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `English` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Culture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Translation` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Comments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`LanguageForeignNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for languagepat
-- ----------------------------
DROP TABLE IF EXISTS `languagepat`;
CREATE TABLE `languagepat`  (
  `LanguagePatNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PrefName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Language` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Translation` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EFormFieldDefNum` bigint(20) NOT NULL,
  PRIMARY KEY (`LanguagePatNum`) USING BTREE,
  INDEX `PrefName`(`PrefName`) USING BTREE,
  INDEX `EFormFieldDefNum`(`EFormFieldDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for letter
-- ----------------------------
DROP TABLE IF EXISTS `letter`;
CREATE TABLE `letter`  (
  `LetterNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `BodyText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`LetterNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lettermerge
-- ----------------------------
DROP TABLE IF EXISTS `lettermerge`;
CREATE TABLE `lettermerge`  (
  `LetterMergeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `TemplateName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DataFileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Category` bigint(20) NOT NULL,
  `ImageFolder` bigint(20) NOT NULL,
  PRIMARY KEY (`LetterMergeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lettermergefield
-- ----------------------------
DROP TABLE IF EXISTS `lettermergefield`;
CREATE TABLE `lettermergefield`  (
  `FieldNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LetterMergeNum` bigint(20) NOT NULL,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`FieldNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for limitedbetafeature
-- ----------------------------
DROP TABLE IF EXISTS `limitedbetafeature`;
CREATE TABLE `limitedbetafeature`  (
  `LimitedBetaFeatureNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LimitedBetaFeatureTypeNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `IsSignedUp` tinyint(4) NOT NULL,
  PRIMARY KEY (`LimitedBetaFeatureNum`) USING BTREE,
  INDEX `LimitedBetaFeatureTypeNum`(`LimitedBetaFeatureTypeNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for loginattempt
-- ----------------------------
DROP TABLE IF EXISTS `loginattempt`;
CREATE TABLE `loginattempt`  (
  `LoginAttemptNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LoginType` tinyint(4) NOT NULL,
  `DateTFail` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`LoginAttemptNum`) USING BTREE,
  INDEX `UserName`(`UserName`(10)) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for loinc
-- ----------------------------
DROP TABLE IF EXISTS `loinc`;
CREATE TABLE `loinc`  (
  `LoincNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LoincCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Component` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PropertyObserved` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TimeAspct` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SystemMeasured` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ScaleType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MethodType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StatusOfCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NameShort` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClassType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitsRequired` tinyint(4) NOT NULL,
  `OrderObs` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HL7FieldSubfieldID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ExternalCopyrightNotice` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NameLongCommon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UnitsUCUM` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RankCommonTests` int(11) NOT NULL,
  `RankCommonOrders` int(11) NOT NULL,
  PRIMARY KEY (`LoincNum`) USING BTREE,
  INDEX `LoincCode`(`LoincCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for medicalorder
-- ----------------------------
DROP TABLE IF EXISTS `medicalorder`;
CREATE TABLE `medicalorder`  (
  `MedicalOrderNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MedOrderType` tinyint(4) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `DateTimeOrder` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsDiscontinued` tinyint(4) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  PRIMARY KEY (`MedicalOrderNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for medication
-- ----------------------------
DROP TABLE IF EXISTS `medication`;
CREATE TABLE `medication`  (
  `MedicationNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MedName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `GenericNum` bigint(20) NOT NULL,
  `Notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `RxCui` bigint(20) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  PRIMARY KEY (`MedicationNum`) USING BTREE,
  INDEX `RxCui`(`RxCui`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for medicationpat
-- ----------------------------
DROP TABLE IF EXISTS `medicationpat`;
CREATE TABLE `medicationpat`  (
  `MedicationPatNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `MedicationNum` bigint(20) NOT NULL,
  `PatNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DateStart` date NOT NULL DEFAULT '0001-01-01',
  `DateStop` date NOT NULL DEFAULT '0001-01-01',
  `ProvNum` bigint(20) NOT NULL,
  `MedDescript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RxCui` bigint(20) NOT NULL,
  `ErxGuid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsCpoe` tinyint(4) NOT NULL,
  PRIMARY KEY (`MedicationPatNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `RxCui`(`RxCui`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for medlab
-- ----------------------------
DROP TABLE IF EXISTS `medlab`;
CREATE TABLE `medlab`  (
  `MedLabNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SendingApp` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SendingFacility` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `PatIDLab` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatAge` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatAccountNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatFasting` tinyint(4) NOT NULL,
  `SpecimenID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenIDFiller` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsTestID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsTestDescript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsTestLoinc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsTestLoincText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeCollected` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TotalVolume` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ActionCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicalInfo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeEntered` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `OrderingProvNPI` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProvLocalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProvLName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrderingProvFName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenIDAlt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeReported` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ResultStatus` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObsID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ParentObsTestID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NotePat` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NoteLab` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OriginalPIDSegment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`MedLabNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for medlabfacattach
-- ----------------------------
DROP TABLE IF EXISTS `medlabfacattach`;
CREATE TABLE `medlabfacattach`  (
  `MedLabFacAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MedLabNum` bigint(20) NOT NULL,
  `MedLabResultNum` bigint(20) NOT NULL,
  `MedLabFacilityNum` bigint(20) NOT NULL,
  PRIMARY KEY (`MedLabFacAttachNum`) USING BTREE,
  INDEX `MedLabNum`(`MedLabNum`) USING BTREE,
  INDEX `MedLabResultNum`(`MedLabResultNum`) USING BTREE,
  INDEX `MedLabFacilityNum`(`MedLabFacilityNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for medlabfacility
-- ----------------------------
DROP TABLE IF EXISTS `medlabfacility`;
CREATE TABLE `medlabfacility`  (
  `MedLabFacilityNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FacilityName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `City` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `State` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Zip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DirectorTitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DirectorLName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DirectorFName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`MedLabFacilityNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for medlabresult
-- ----------------------------
DROP TABLE IF EXISTS `medlabresult`;
CREATE TABLE `medlabresult`  (
  `MedLabResultNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MedLabNum` bigint(20) NOT NULL,
  `ObsID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsLoinc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsLoincText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsIDSub` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsValue` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsSubType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ObsUnits` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ReferenceRange` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AbnormalFlag` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ResultStatus` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeObs` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `FacilityID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DocNum` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`MedLabResultNum`) USING BTREE,
  INDEX `MedLabNum`(`MedLabNum`) USING BTREE,
  INDEX `DocNum`(`DocNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for medlabspecimen
-- ----------------------------
DROP TABLE IF EXISTS `medlabspecimen`;
CREATE TABLE `medlabspecimen`  (
  `MedLabSpecimenNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MedLabNum` bigint(20) NOT NULL,
  `SpecimenID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpecimenDescript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeCollected` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`MedLabSpecimenNum`) USING BTREE,
  INDEX `MedLabNum`(`MedLabNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mobileappdevice
-- ----------------------------
DROP TABLE IF EXISTS `mobileappdevice`;
CREATE TABLE `mobileappdevice`  (
  `MobileAppDeviceNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `DeviceName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UniqueID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsEclipboardEnabled` tinyint(4) NOT NULL,
  `EclipboardLastAttempt` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `EclipboardLastLogin` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `PatNum` bigint(20) NOT NULL,
  `LastCheckInActivity` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `IsBYODDevice` tinyint(4) NOT NULL,
  `DevicePage` tinyint(4) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `IsODTouchEnabled` tinyint(4) NOT NULL,
  `ODTouchLastLogin` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ODTouchLastAttempt` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`MobileAppDeviceNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mobilebrandingprofile
-- ----------------------------
DROP TABLE IF EXISTS `mobilebrandingprofile`;
CREATE TABLE `mobilebrandingprofile`  (
  `MobileBrandingProfileNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `OfficeDescription` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LogoFilePath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`MobileBrandingProfileNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mobiledatabyte
-- ----------------------------
DROP TABLE IF EXISTS `mobiledatabyte`;
CREATE TABLE `mobiledatabyte`  (
  `MobileDataByteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `RawBase64Data` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RawBase64Code` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RawBase64Tag` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ActionType` tinyint(4) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeExpires` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`MobileDataByteNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `RawBase64Code`(`RawBase64Code`(16)) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mobilenotification
-- ----------------------------
DROP TABLE IF EXISTS `mobilenotification`;
CREATE TABLE `mobilenotification`  (
  `MobileNotificationNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `NotificationType` tinyint(4) NOT NULL,
  `DeviceId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PrimaryKeys` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Tags` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeExpires` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `AppTarget` tinyint(4) NOT NULL,
  PRIMARY KEY (`MobileNotificationNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mount
-- ----------------------------
DROP TABLE IF EXISTS `mount`;
CREATE TABLE `mount`  (
  `MountNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DocCategory` bigint(20) NOT NULL,
  `DateCreated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Width` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  `ColorBack` int(11) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `ColorFore` int(11) NOT NULL,
  `ColorTextBack` int(11) NOT NULL,
  `FlipOnAcquire` tinyint(4) NOT NULL,
  `AdjModeAfterSeries` tinyint(4) NOT NULL,
  PRIMARY KEY (`MountNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mountdef
-- ----------------------------
DROP TABLE IF EXISTS `mountdef`;
CREATE TABLE `mountdef`  (
  `MountDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ItemOrder` int(11) NOT NULL,
  `Width` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  `ColorBack` int(11) NOT NULL,
  `ColorFore` int(11) NOT NULL,
  `ColorTextBack` int(11) NOT NULL,
  `ScaleValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DefaultCat` bigint(20) NOT NULL,
  `FlipOnAcquire` tinyint(4) NOT NULL,
  `AdjModeAfterSeries` tinyint(4) NOT NULL,
  PRIMARY KEY (`MountDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mountitem
-- ----------------------------
DROP TABLE IF EXISTS `mountitem`;
CREATE TABLE `mountitem`  (
  `MountItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MountNum` bigint(20) NOT NULL,
  `Xpos` int(11) NOT NULL,
  `Ypos` int(11) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `Width` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  `RotateOnAcquire` int(11) NOT NULL,
  `ToothNumbers` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TextShowing` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FontSize` float NOT NULL,
  PRIMARY KEY (`MountItemNum`) USING BTREE,
  INDEX `MountNum`(`MountNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mountitemdef
-- ----------------------------
DROP TABLE IF EXISTS `mountitemdef`;
CREATE TABLE `mountitemdef`  (
  `MountItemDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `MountDefNum` bigint(20) NOT NULL,
  `Xpos` int(11) NOT NULL,
  `Ypos` int(11) NOT NULL,
  `Width` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `RotateOnAcquire` int(11) NOT NULL,
  `ToothNumbers` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TextShowing` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FontSize` float NOT NULL,
  PRIMARY KEY (`MountItemDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for msgtopaysent
-- ----------------------------
DROP TABLE IF EXISTS `msgtopaysent`;
CREATE TABLE `msgtopaysent`  (
  `MsgToPaySentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `SendStatus` tinyint(4) NOT NULL,
  `Source` tinyint(4) NOT NULL,
  `MessageType` tinyint(4) NOT NULL,
  `MessageFk` bigint(20) NOT NULL,
  `Subject` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Message` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailType` tinyint(4) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ResponseDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ApptReminderRuleNum` bigint(20) NOT NULL,
  `ShortGUID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeSendFailed` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ApptNum` bigint(20) NOT NULL,
  `ApptDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TSPrior` bigint(20) NOT NULL,
  `StatementNum` bigint(20) NOT NULL,
  PRIMARY KEY (`MsgToPaySentNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `DateTimeSent`(`DateTimeSent`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `MessageFk`(`MessageFk`) USING BTREE,
  INDEX `ApptNum`(`ApptNum`) USING BTREE,
  INDEX `TSPrior`(`TSPrior`) USING BTREE,
  INDEX `StatementNum`(`StatementNum`) USING BTREE,
  INDEX `Source`(`Source`, `DateTimeSent`, `SendStatus`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oidexternal
-- ----------------------------
DROP TABLE IF EXISTS `oidexternal`;
CREATE TABLE `oidexternal`  (
  `OIDExternalNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `IDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IDInternal` bigint(20) NOT NULL,
  `IDExternal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `rootExternal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`OIDExternalNum`) USING BTREE,
  INDEX `IDType`(`IDType`, `IDInternal`) USING BTREE,
  INDEX `rootExternal`(`rootExternal`(62), `IDExternal`(62)) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oidinternal
-- ----------------------------
DROP TABLE IF EXISTS `oidinternal`;
CREATE TABLE `oidinternal`  (
  `OIDInternalNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `IDType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IDRoot` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`OIDInternalNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for operatory
-- ----------------------------
DROP TABLE IF EXISTS `operatory`;
CREATE TABLE `operatory`  (
  `OperatoryNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `OpName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Abbrev` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ItemOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `IsHidden` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ProvDentist` bigint(20) NOT NULL,
  `ProvHygienist` bigint(20) NOT NULL,
  `IsHygiene` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ClinicNum` bigint(20) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `SetProspective` tinyint(4) NOT NULL,
  `IsWebSched` tinyint(4) NOT NULL,
  `IsNewPatAppt` tinyint(4) NOT NULL,
  `OperatoryType` bigint(20) NOT NULL,
  PRIMARY KEY (`OperatoryNum`) USING BTREE,
  INDEX `ProvDentist`(`ProvDentist`) USING BTREE,
  INDEX `ProvHygienist`(`ProvHygienist`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `OperatoryType`(`OperatoryType`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orionproc
-- ----------------------------
DROP TABLE IF EXISTS `orionproc`;
CREATE TABLE `orionproc`  (
  `OrionProcNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProcNum` bigint(20) NOT NULL,
  `DPC` tinyint(4) NOT NULL,
  `DateScheduleBy` date NOT NULL DEFAULT '0001-01-01',
  `DateStopClock` date NOT NULL DEFAULT '0001-01-01',
  `Status2` int(11) NOT NULL,
  `IsOnCall` tinyint(4) NOT NULL,
  `IsEffectiveComm` tinyint(4) NOT NULL,
  `IsRepair` tinyint(4) NOT NULL,
  `DPCpost` tinyint(4) NOT NULL,
  PRIMARY KEY (`OrionProcNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for orthocase
-- ----------------------------
DROP TABLE IF EXISTS `orthocase`;
CREATE TABLE `orthocase`  (
  `OrthoCaseNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `Fee` double NOT NULL,
  `FeeInsPrimary` double NOT NULL,
  `FeePat` double NOT NULL,
  `BandingDate` date NOT NULL DEFAULT '0001-01-01',
  `DebondDate` date NOT NULL DEFAULT '0001-01-01',
  `DebondDateExpected` date NOT NULL DEFAULT '0001-01-01',
  `IsTransfer` tinyint(4) NOT NULL,
  `OrthoType` bigint(20) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` tinyint(4) NOT NULL,
  `FeeInsSecondary` double NOT NULL,
  PRIMARY KEY (`OrthoCaseNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `OrthoType`(`OrthoType`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for orthochart
-- ----------------------------
DROP TABLE IF EXISTS `orthochart`;
CREATE TABLE `orthochart`  (
  `OrthoChartNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateService` date NOT NULL DEFAULT '0001-01-01',
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FieldValue` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `OrthoChartRowNum` bigint(20) NOT NULL,
  PRIMARY KEY (`OrthoChartNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `OrthoChartRowNum`(`OrthoChartRowNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orthochartlog
-- ----------------------------
DROP TABLE IF EXISTS `orthochartlog`;
CREATE TABLE `orthochartlog`  (
  `OrthoChartLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ComputerName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeLog` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeService` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `UserNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `OrthoChartRowNum` bigint(20) NOT NULL,
  `LogData` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`OrthoChartLogNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orthochartrow
-- ----------------------------
DROP TABLE IF EXISTS `orthochartrow`;
CREATE TABLE `orthochartrow`  (
  `OrthoChartRowNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateTimeService` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `UserNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `Signature` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`OrthoChartRowNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orthocharttab
-- ----------------------------
DROP TABLE IF EXISTS `orthocharttab`;
CREATE TABLE `orthocharttab`  (
  `OrthoChartTabNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TabName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  PRIMARY KEY (`OrthoChartTabNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orthocharttablink
-- ----------------------------
DROP TABLE IF EXISTS `orthocharttablink`;
CREATE TABLE `orthocharttablink`  (
  `OrthoChartTabLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ItemOrder` int(11) NOT NULL,
  `OrthoChartTabNum` bigint(20) NOT NULL,
  `DisplayFieldNum` bigint(20) NOT NULL,
  `ColumnWidthOverride` int(11) NOT NULL,
  PRIMARY KEY (`OrthoChartTabLinkNum`) USING BTREE,
  INDEX `OrthoChartTabNum`(`OrthoChartTabNum`) USING BTREE,
  INDEX `DisplayFieldNum`(`DisplayFieldNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for orthohardware
-- ----------------------------
DROP TABLE IF EXISTS `orthohardware`;
CREATE TABLE `orthohardware`  (
  `OrthoHardwareNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateExam` date NOT NULL DEFAULT '0001-01-01',
  `OrthoHardwareType` tinyint(4) NOT NULL,
  `OrthoHardwareSpecNum` bigint(20) NOT NULL,
  `ToothRange` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  PRIMARY KEY (`OrthoHardwareNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orthohardwarespec
-- ----------------------------
DROP TABLE IF EXISTS `orthohardwarespec`;
CREATE TABLE `orthohardwarespec`  (
  `OrthoHardwareSpecNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrthoHardwareType` tinyint(4) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemColor` int(11) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  PRIMARY KEY (`OrthoHardwareSpecNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orthoplanlink
-- ----------------------------
DROP TABLE IF EXISTS `orthoplanlink`;
CREATE TABLE `orthoplanlink`  (
  `OrthoPlanLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrthoCaseNum` bigint(20) NOT NULL,
  `LinkType` tinyint(4) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `IsActive` tinyint(4) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecUserNumEntry` bigint(20) NOT NULL,
  PRIMARY KEY (`OrthoPlanLinkNum`) USING BTREE,
  INDEX `OrthoCaseNum`(`OrthoCaseNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for orthoproclink
-- ----------------------------
DROP TABLE IF EXISTS `orthoproclink`;
CREATE TABLE `orthoproclink`  (
  `OrthoProcLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrthoCaseNum` bigint(20) NOT NULL,
  `ProcNum` bigint(20) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecUserNumEntry` bigint(20) NOT NULL,
  `ProcLinkType` tinyint(4) NOT NULL,
  PRIMARY KEY (`OrthoProcLinkNum`) USING BTREE,
  INDEX `OrthoCaseNum`(`OrthoCaseNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for orthorx
-- ----------------------------
DROP TABLE IF EXISTS `orthorx`;
CREATE TABLE `orthorx`  (
  `OrthoRxNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrthoHardwareSpecNum` bigint(20) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ToothRange` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  PRIMARY KEY (`OrthoRxNum`) USING BTREE,
  INDEX `OrthoHardwareSpecNum`(`OrthoHardwareSpecNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orthoschedule
-- ----------------------------
DROP TABLE IF EXISTS `orthoschedule`;
CREATE TABLE `orthoschedule`  (
  `OrthoScheduleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `BandingDateOverride` date NOT NULL DEFAULT '0001-01-01',
  `DebondDateOverride` date NOT NULL DEFAULT '0001-01-01',
  `BandingAmount` double NOT NULL,
  `VisitAmount` double NOT NULL,
  `DebondAmount` double NOT NULL,
  `IsActive` tinyint(4) NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`OrthoScheduleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for patfield
-- ----------------------------
DROP TABLE IF EXISTS `patfield`;
CREATE TABLE `patfield`  (
  `PatFieldNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FieldValue` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PatFieldNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patfielddef
-- ----------------------------
DROP TABLE IF EXISTS `patfielddef`;
CREATE TABLE `patfielddef`  (
  `PatFieldDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FieldType` tinyint(4) NOT NULL,
  `PickList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  PRIMARY KEY (`PatFieldDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patfieldpickitem
-- ----------------------------
DROP TABLE IF EXISTS `patfieldpickitem`;
CREATE TABLE `patfieldpickitem`  (
  `PatFieldPickItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatFieldDefNum` bigint(20) NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Abbreviation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  PRIMARY KEY (`PatFieldPickItemNum`) USING BTREE,
  INDEX `PatFieldDefNum`(`PatFieldDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patient
-- ----------------------------
DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient`  (
  `PatNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `MiddleI` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Preferred` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PatStatus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Gender` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Position` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Birthdate` date NOT NULL DEFAULT '0001-01-01',
  `SSN` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Address2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `City` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `State` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Zip` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `HmPhone` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `WkPhone` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `WirelessPhone` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Guarantor` bigint(20) NOT NULL,
  `CreditType` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Salutation` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `EstBalance` double NOT NULL DEFAULT 0,
  `PriProv` bigint(20) NOT NULL,
  `SecProv` bigint(20) NOT NULL,
  `FeeSched` bigint(20) NOT NULL,
  `BillingType` bigint(20) NOT NULL,
  `ImageFolder` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `AddrNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FamFinUrgNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MedUrgNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ApptModNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `StudentStatus` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `SchoolName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ChartNumber` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `MedicaidID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Bal_0_30` double NOT NULL DEFAULT 0,
  `Bal_31_60` double NOT NULL DEFAULT 0,
  `Bal_61_90` double NOT NULL DEFAULT 0,
  `BalOver90` double NOT NULL DEFAULT 0,
  `InsEst` double NOT NULL DEFAULT 0,
  `BalTotal` double NOT NULL DEFAULT 0,
  `EmployerNum` bigint(20) NOT NULL,
  `EmploymentNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `County` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `GradeLevel` tinyint(4) NOT NULL DEFAULT 0,
  `Urgency` tinyint(4) NOT NULL DEFAULT 0,
  `DateFirstVisit` date NOT NULL DEFAULT '0001-01-01',
  `ClinicNum` bigint(20) NOT NULL,
  `HasIns` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `TrophyFolder` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PlannedIsDone` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Premed` tinyint(3) UNSIGNED NOT NULL,
  `Ward` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PreferConfirmMethod` tinyint(3) UNSIGNED NOT NULL,
  `PreferContactMethod` tinyint(3) UNSIGNED NOT NULL,
  `PreferRecallMethod` tinyint(3) UNSIGNED NOT NULL,
  `SchedBeforeTime` time NULL DEFAULT NULL,
  `SchedAfterTime` time NULL DEFAULT NULL,
  `SchedDayOfWeek` tinyint(3) UNSIGNED NOT NULL,
  `Language` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `AdmitDate` date NOT NULL DEFAULT '0001-01-01',
  `Title` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PayPlanDue` double NOT NULL,
  `SiteNum` bigint(20) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `ResponsParty` bigint(20) NOT NULL,
  `CanadianEligibilityCode` tinyint(4) NOT NULL,
  `AskToArriveEarly` int(11) NOT NULL,
  `PreferContactConfidential` tinyint(4) NOT NULL,
  `SuperFamily` bigint(20) NOT NULL,
  `TxtMsgOk` tinyint(4) NOT NULL,
  `SmokingSnoMed` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeDeceased` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `BillingCycleDay` int(11) NOT NULL DEFAULT 1,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `HasSuperBilling` tinyint(4) NOT NULL,
  `PatNumCloneFrom` bigint(20) NOT NULL,
  `DiscountPlanNum` bigint(20) NOT NULL,
  `HasSignedTil` tinyint(4) NOT NULL,
  `ShortCodeOptIn` tinyint(4) NOT NULL,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`PatNum`) USING BTREE,
  INDEX `indexLName`(`LName`(10)) USING BTREE,
  INDEX `indexFName`(`FName`(10)) USING BTREE,
  INDEX `indexLFName`(`LName`, `FName`) USING BTREE,
  INDEX `indexGuarantor`(`Guarantor`) USING BTREE,
  INDEX `ResponsParty`(`ResponsParty`) USING BTREE,
  INDEX `SuperFamily`(`SuperFamily`) USING BTREE,
  INDEX `SiteNum`(`SiteNum`) USING BTREE,
  INDEX `PatStatus`(`PatStatus`) USING BTREE,
  INDEX `Email`(`Email`) USING BTREE,
  INDEX `ChartNumber`(`ChartNumber`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `HmPhone`(`HmPhone`) USING BTREE,
  INDEX `WirelessPhone`(`WirelessPhone`) USING BTREE,
  INDEX `WkPhone`(`WkPhone`) USING BTREE,
  INDEX `PatNumCloneFrom`(`PatNumCloneFrom`) USING BTREE,
  INDEX `DiscountPlanNum`(`DiscountPlanNum`) USING BTREE,
  INDEX `FeeSched`(`FeeSched`) USING BTREE,
  INDEX `SecDateEntry`(`SecDateEntry`) USING BTREE,
  INDEX `PriProv`(`PriProv`) USING BTREE,
  INDEX `SecProv`(`SecProv`) USING BTREE,
  INDEX `ClinicPatStatus`(`ClinicNum`, `PatStatus`) USING BTREE,
  INDEX `BirthdateStatus`(`Birthdate`, `PatStatus`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 22 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patientlink
-- ----------------------------
DROP TABLE IF EXISTS `patientlink`;
CREATE TABLE `patientlink`  (
  `PatientLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNumFrom` bigint(20) NOT NULL,
  `PatNumTo` bigint(20) NOT NULL,
  `LinkType` tinyint(4) NOT NULL,
  `DateTimeLink` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`PatientLinkNum`) USING BTREE,
  INDEX `PatNumFrom`(`PatNumFrom`) USING BTREE,
  INDEX `PatNumTo`(`PatNumTo`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for patientnote
-- ----------------------------
DROP TABLE IF EXISTS `patientnote`;
CREATE TABLE `patientnote`  (
  `PatNum` bigint(20) NOT NULL,
  `FamFinancial` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ApptPhone` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Medical` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Service` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `MedicalComp` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Treatment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ICEName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ICEPhone` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OrthoMonthsTreatOverride` int(11) NOT NULL DEFAULT -1,
  `DateOrthoPlacementOverride` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `Consent` tinyint(4) NOT NULL,
  `UserNumOrthoLocked` bigint(20) NOT NULL,
  `Pronoun` tinyint(4) NOT NULL,
  PRIMARY KEY (`PatNum`) USING BTREE,
  INDEX `SecDateTEntry`(`SecDateTEntry`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patientportalinvite
-- ----------------------------
DROP TABLE IF EXISTS `patientportalinvite`;
CREATE TABLE `patientportalinvite`  (
  `PatientPortalInviteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ApptNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TSPrior` bigint(20) NOT NULL,
  `SendStatus` tinyint(4) NOT NULL,
  `MessageFk` bigint(20) NOT NULL,
  `ResponseDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MessageType` tinyint(4) NOT NULL,
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ApptReminderRuleNum` bigint(20) NOT NULL,
  `ApptDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`PatientPortalInviteNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `AptNum`(`ApptNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `EmailMessageNum`(`MessageFk`) USING BTREE,
  INDEX `MessageFk`(`MessageFk`) USING BTREE,
  INDEX `ApptReminderRuleNum`(`ApptReminderRuleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patientrace
-- ----------------------------
DROP TABLE IF EXISTS `patientrace`;
CREATE TABLE `patientrace`  (
  `PatientRaceNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `Race` tinyint(4) NOT NULL,
  `CdcrecCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`PatientRaceNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `CdcrecCode`(`CdcrecCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patplan
-- ----------------------------
DROP TABLE IF EXISTS `patplan`;
CREATE TABLE `patplan`  (
  `PatPlanNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `Ordinal` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `IsPending` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Relationship` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `PatID` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `InsSubNum` bigint(20) NOT NULL,
  `OrthoAutoFeeBilledOverride` double NOT NULL DEFAULT -1,
  `OrthoAutoNextClaimDate` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PatPlanNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `InsSubNum`(`InsSubNum`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE,
  INDEX `SecDateTEntry`(`SecDateTEntry`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 26 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patrestriction
-- ----------------------------
DROP TABLE IF EXISTS `patrestriction`;
CREATE TABLE `patrestriction`  (
  `PatRestrictionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `PatRestrictType` tinyint(4) NOT NULL,
  PRIMARY KEY (`PatRestrictionNum`) USING BTREE,
  INDEX `PatNumRestrictType`(`PatNum`, `PatRestrictType`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for payconnectresponseweb
-- ----------------------------
DROP TABLE IF EXISTS `payconnectresponseweb`;
CREATE TABLE `payconnectresponseweb`  (
  `PayConnectResponseWebNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `PayNum` bigint(20) NOT NULL,
  `AccountToken` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PaymentToken` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProcessingStatus` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimePending` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeCompleted` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeExpired` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeLastError` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `LastResponseStr` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CCSource` tinyint(4) NOT NULL,
  `Amount` double NOT NULL,
  `PayNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsTokenSaved` tinyint(4) NOT NULL,
  `PayToken` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ExpDateToken` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RefNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TransType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailResponse` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LogGuid` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PayConnectResponseWebNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `PayNum`(`PayNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `PayNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PayType` bigint(20) NOT NULL,
  `PayDate` date NOT NULL DEFAULT '0000-00-00',
  `PayAmt` double NOT NULL DEFAULT 0,
  `CheckNum` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `BankBranch` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PayNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsSplit` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `PatNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `DateEntry` date NOT NULL DEFAULT '0001-01-01',
  `DepositNum` bigint(20) NOT NULL,
  `Receipt` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsRecurringCC` tinyint(4) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `PaymentSource` tinyint(4) NOT NULL,
  `ProcessStatus` tinyint(4) NOT NULL,
  `RecurringChargeDate` date NOT NULL DEFAULT '0001-01-01',
  `ExternalId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PaymentStatus` tinyint(4) NOT NULL,
  `IsCcCompleted` tinyint(4) NOT NULL,
  `MerchantFee` double NOT NULL,
  PRIMARY KEY (`PayNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `DepositNum`(`DepositNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PayType`(`PayType`) USING BTREE,
  INDEX `ProcessStatus`(`ProcessStatus`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for payortype
-- ----------------------------
DROP TABLE IF EXISTS `payortype`;
CREATE TABLE `payortype`  (
  `PayorTypeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateStart` date NOT NULL DEFAULT '0001-01-01',
  `SopCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`PayorTypeNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `SopCode`(`SopCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for payperiod
-- ----------------------------
DROP TABLE IF EXISTS `payperiod`;
CREATE TABLE `payperiod`  (
  `PayPeriodNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateStart` date NOT NULL DEFAULT '0001-01-01',
  `DateStop` date NOT NULL DEFAULT '0001-01-01',
  `DatePaycheck` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`PayPeriodNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 516 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for payplan
-- ----------------------------
DROP TABLE IF EXISTS `payplan`;
CREATE TABLE `payplan`  (
  `PayPlanNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `Guarantor` bigint(20) NOT NULL,
  `PayPlanDate` date NOT NULL DEFAULT '0000-00-00',
  `APR` double NOT NULL DEFAULT 0,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PlanNum` bigint(20) NOT NULL,
  `CompletedAmt` double NOT NULL,
  `InsSubNum` bigint(20) NOT NULL,
  `PaySchedule` tinyint(4) NOT NULL,
  `NumberOfPayments` int(11) NOT NULL,
  `PayAmt` double NOT NULL,
  `DownPayment` double NOT NULL,
  `IsClosed` tinyint(4) NOT NULL,
  `Signature` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SigIsTopaz` tinyint(4) NOT NULL,
  `PlanCategory` bigint(20) NOT NULL,
  `IsDynamic` tinyint(4) NOT NULL,
  `ChargeFrequency` tinyint(4) NOT NULL,
  `DatePayPlanStart` date NOT NULL DEFAULT '0001-01-01',
  `IsLocked` tinyint(4) NOT NULL,
  `DateInterestStart` date NOT NULL DEFAULT '0001-01-01',
  `DynamicPayPlanTPOption` tinyint(4) NOT NULL,
  `MobileAppDeviceNum` bigint(20) NOT NULL,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SheetDefNum` bigint(20) NOT NULL,
  PRIMARY KEY (`PayPlanNum`) USING BTREE,
  INDEX `InsSubNum`(`InsSubNum`) USING BTREE,
  INDEX `PlanCategory`(`PlanCategory`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `Guarantor`(`Guarantor`) USING BTREE,
  INDEX `PlanNum`(`PlanNum`) USING BTREE,
  INDEX `MobileAppDeviceNum`(`MobileAppDeviceNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for payplancharge
-- ----------------------------
DROP TABLE IF EXISTS `payplancharge`;
CREATE TABLE `payplancharge`  (
  `PayPlanChargeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PayPlanNum` bigint(20) NOT NULL,
  `Guarantor` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ChargeDate` date NOT NULL DEFAULT '0001-01-01',
  `Principal` double NOT NULL DEFAULT 0,
  `Interest` double NOT NULL DEFAULT 0,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ChargeType` tinyint(4) NOT NULL,
  `ProcNum` bigint(20) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `StatementNum` bigint(20) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `LinkType` tinyint(4) NOT NULL,
  `IsOffset` tinyint(4) NOT NULL,
  `IsDownPayment` tinyint(4) NOT NULL,
  PRIMARY KEY (`PayPlanChargeNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `indexGuarantor`(`Guarantor`) USING BTREE,
  INDEX `indexPayPlanNum`(`PayPlanNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `StatementNum`(`StatementNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `SecDateTEditPN`(`SecDateTEdit`, `PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for payplanlink
-- ----------------------------
DROP TABLE IF EXISTS `payplanlink`;
CREATE TABLE `payplanlink`  (
  `PayPlanLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PayPlanNum` bigint(20) NOT NULL,
  `LinkType` tinyint(4) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `AmountOverride` double NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`PayPlanLinkNum`) USING BTREE,
  INDEX `PayPlanNum`(`PayPlanNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for payplantemplate
-- ----------------------------
DROP TABLE IF EXISTS `payplantemplate`;
CREATE TABLE `payplantemplate`  (
  `PayPlanTemplateNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PayPlanTemplateName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `APR` double NOT NULL,
  `InterestDelay` int(11) NOT NULL,
  `PayAmt` double NOT NULL,
  `NumberOfPayments` int(11) NOT NULL,
  `ChargeFrequency` tinyint(4) NOT NULL,
  `DownPayment` double NOT NULL,
  `DynamicPayPlanTPOption` tinyint(4) NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `SheetDefNum` bigint(20) NOT NULL,
  PRIMARY KEY (`PayPlanTemplateNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for paysplit
-- ----------------------------
DROP TABLE IF EXISTS `paysplit`;
CREATE TABLE `paysplit`  (
  `SplitNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SplitAmt` double NOT NULL DEFAULT 0,
  `PatNum` bigint(20) NOT NULL,
  `ProcDate` date NOT NULL DEFAULT '0000-00-00',
  `PayNum` bigint(20) NOT NULL,
  `IsDiscount` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `DiscountType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ProvNum` bigint(20) NOT NULL,
  `PayPlanNum` bigint(20) NOT NULL,
  `DatePay` date NOT NULL DEFAULT '0001-01-01',
  `ProcNum` bigint(20) NOT NULL,
  `DateEntry` date NOT NULL DEFAULT '0001-01-01',
  `UnearnedType` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `FSplitNum` bigint(20) NOT NULL,
  `AdjNum` bigint(20) NOT NULL,
  `PayPlanChargeNum` bigint(20) NOT NULL,
  `PayPlanDebitType` tinyint(4) NOT NULL,
  `SecurityHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`SplitNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `PayNum`(`PayNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `DatePay`(`DatePay`) USING BTREE,
  INDEX `PayPlanNum`(`PayPlanNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `PrepaymentNum`(`FSplitNum`) USING BTREE,
  INDEX `indexPNAmt`(`ProcNum`, `SplitAmt`) USING BTREE,
  INDEX `AdjNum`(`AdjNum`) USING BTREE,
  INDEX `PayPlanChargeNum`(`PayPlanChargeNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `SecDateTEditPN`(`SecDateTEdit`, `PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for payterminal
-- ----------------------------
DROP TABLE IF EXISTS `payterminal`;
CREATE TABLE `payterminal`  (
  `PayTerminalNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `TerminalID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`PayTerminalNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pearlrequest
-- ----------------------------
DROP TABLE IF EXISTS `pearlrequest`;
CREATE TABLE `pearlrequest`  (
  `PearlRequestNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `RequestId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DocNum` bigint(20) NOT NULL,
  `RequestStatus` tinyint(4) NOT NULL,
  `DateTSent` date NOT NULL DEFAULT '0001-01-01',
  `DateTChecked` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`PearlRequestNum`) USING BTREE,
  INDEX `RequestStatus`(`RequestStatus`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for perioexam
-- ----------------------------
DROP TABLE IF EXISTS `perioexam`;
CREATE TABLE `perioexam`  (
  `PerioExamNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ExamDate` date NOT NULL DEFAULT '0000-00-00',
  `ProvNum` bigint(20) NOT NULL,
  `DateTMeasureEdit` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`PerioExamNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for periomeasure
-- ----------------------------
DROP TABLE IF EXISTS `periomeasure`;
CREATE TABLE `periomeasure`  (
  `PerioMeasureNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PerioExamNum` bigint(20) NOT NULL,
  `SequenceType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `IntTooth` smallint(6) NOT NULL,
  `ToothValue` smallint(6) NOT NULL,
  `MBvalue` smallint(6) NOT NULL,
  `Bvalue` smallint(6) NOT NULL,
  `DBvalue` smallint(6) NOT NULL,
  `MLvalue` smallint(6) NOT NULL,
  `Lvalue` smallint(6) NOT NULL,
  `DLvalue` smallint(6) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PerioMeasureNum`) USING BTREE,
  INDEX `PerioExamNum`(`PerioExamNum`) USING BTREE,
  INDEX `SecDateTEntry`(`SecDateTEntry`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 65 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for pharmacy
-- ----------------------------
DROP TABLE IF EXISTS `pharmacy`;
CREATE TABLE `pharmacy`  (
  `PharmacyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PharmID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `StoreName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Fax` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Address2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `City` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `State` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Zip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PharmacyNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pharmclinic
-- ----------------------------
DROP TABLE IF EXISTS `pharmclinic`;
CREATE TABLE `pharmclinic`  (
  `PharmClinicNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PharmacyNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  PRIMARY KEY (`PharmClinicNum`) USING BTREE,
  INDEX `PharmacyNum`(`PharmacyNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for phonenumber
-- ----------------------------
DROP TABLE IF EXISTS `phonenumber`;
CREATE TABLE `phonenumber`  (
  `PhoneNumberNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `PhoneNumberVal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PhoneNumberDigits` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PhoneType` tinyint(4) NOT NULL,
  PRIMARY KEY (`PhoneNumberNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `PhoneNumberVal`(`PhoneNumberVal`) USING BTREE,
  INDEX `PatPhoneDigits`(`PatNum`, `PhoneNumberDigits`) USING BTREE,
  INDEX `PhoneNumberDigits`(`PhoneNumberDigits`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for popup
-- ----------------------------
DROP TABLE IF EXISTS `popup`;
CREATE TABLE `popup`  (
  `PopupNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsDisabled` tinyint(1) NOT NULL,
  `PopupLevel` tinyint(4) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `IsArchived` tinyint(4) NOT NULL,
  `PopupNumArchive` bigint(20) NOT NULL,
  `DateTimeDisabled` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`PopupNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `PopupNumArchive`(`PopupNumArchive`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for preference
-- ----------------------------
DROP TABLE IF EXISTS `preference`;
CREATE TABLE `preference`  (
  `PrefName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `ValueString` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PrefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Comments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PrefNum`) USING BTREE,
  INDEX `PrefName`(`PrefName`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1204 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for printer
-- ----------------------------
DROP TABLE IF EXISTS `printer`;
CREATE TABLE `printer`  (
  `PrinterNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ComputerNum` bigint(20) NOT NULL,
  `PrintSit` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `PrinterName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DisplayPrompt` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `FileExtension` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsVirtualPrinter` tinyint(4) NOT NULL,
  PRIMARY KEY (`PrinterNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for procapptcolor
-- ----------------------------
DROP TABLE IF EXISTS `procapptcolor`;
CREATE TABLE `procapptcolor`  (
  `ProcApptColorNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CodeRange` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ColorText` int(11) NOT NULL,
  `ShowPreviousDate` tinyint(4) NOT NULL,
  PRIMARY KEY (`ProcApptColorNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for procbutton
-- ----------------------------
DROP TABLE IF EXISTS `procbutton`;
CREATE TABLE `procbutton`  (
  `ProcButtonNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ItemOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Category` bigint(20) NOT NULL,
  `ButtonImage` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsMultiVisit` tinyint(4) NOT NULL,
  PRIMARY KEY (`ProcButtonNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 19 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for procbuttonitem
-- ----------------------------
DROP TABLE IF EXISTS `procbuttonitem`;
CREATE TABLE `procbuttonitem`  (
  `ProcButtonItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProcButtonNum` bigint(20) NOT NULL,
  `OldCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `AutoCodeNum` bigint(20) NOT NULL,
  `CodeNum` bigint(20) NOT NULL,
  `ItemOrder` bigint(20) NOT NULL,
  PRIMARY KEY (`ProcButtonItemNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 55 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for procbuttonquick
-- ----------------------------
DROP TABLE IF EXISTS `procbuttonquick`;
CREATE TABLE `procbuttonquick`  (
  `ProcButtonQuickNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CodeValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Surf` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `YPos` int(11) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `IsLabel` tinyint(4) NOT NULL,
  PRIMARY KEY (`ProcButtonQuickNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 25 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for proccodenote
-- ----------------------------
DROP TABLE IF EXISTS `proccodenote`;
CREATE TABLE `proccodenote`  (
  `ProcCodeNoteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CodeNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ProcTime` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ProcStatus` tinyint(4) NOT NULL,
  PRIMARY KEY (`ProcCodeNoteNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for procedurecode
-- ----------------------------
DROP TABLE IF EXISTS `procedurecode`;
CREATE TABLE `procedurecode`  (
  `CodeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProcCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `AbbrDesc` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ProcTime` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ProcCat` bigint(20) NOT NULL,
  `TreatArea` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `NoBillIns` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `IsProsth` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `DefaultNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsHygiene` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `GTypeNum` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `AlternateCode1` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `MedicalCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  `IsTaxed` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `PaintType` tinyint(4) NOT NULL DEFAULT 0,
  `GraphicColor` int(11) NOT NULL,
  `LaymanTerm` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsCanadianLab` tinyint(3) UNSIGNED NOT NULL,
  `PreExisting` tinyint(1) NOT NULL DEFAULT 0,
  `BaseUnits` int(11) NOT NULL,
  `SubstitutionCode` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SubstOnlyIf` int(11) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `IsMultiVisit` tinyint(4) NOT NULL,
  `DrugNDC` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RevenueCodeDefault` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvNumDefault` bigint(20) NOT NULL,
  `CanadaTimeUnits` double NOT NULL,
  `IsRadiology` tinyint(4) NOT NULL,
  `DefaultClaimNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DefaultTPNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BypassGlobalLock` tinyint(4) NOT NULL,
  `TaxCode` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PaintText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AreaAlsoToothRange` tinyint(4) NOT NULL,
  `DiagnosticCodes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CodeNum`) USING BTREE,
  INDEX `ProcCode`(`ProcCode`) USING BTREE,
  INDEX `ProvNumDefault`(`ProvNumDefault`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 81 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for procedurelog
-- ----------------------------
DROP TABLE IF EXISTS `procedurelog`;
CREATE TABLE `procedurelog`  (
  `ProcNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `AptNum` bigint(20) NOT NULL,
  `OldCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `ProcDate` date NOT NULL DEFAULT '0001-01-01',
  `ProcFee` double NOT NULL DEFAULT 0,
  `Surf` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ToothNum` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ToothRange` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Priority` bigint(20) NOT NULL,
  `ProcStatus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ProvNum` bigint(20) NOT NULL,
  `Dx` bigint(20) NOT NULL,
  `PlannedAptNum` bigint(20) NOT NULL,
  `PlaceService` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Prosthesis` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DateOriginalProsth` date NOT NULL DEFAULT '0001-01-01',
  `ClaimNote` varchar(80) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DateEntryC` date NOT NULL DEFAULT '0001-01-01',
  `ClinicNum` bigint(20) NOT NULL,
  `MedicalCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  `DiagnosticCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsPrincDiag` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ProcNumLab` bigint(20) NOT NULL,
  `BillingTypeOne` bigint(20) NOT NULL,
  `BillingTypeTwo` bigint(20) NOT NULL,
  `CodeNum` bigint(20) NOT NULL,
  `CodeMod1` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CodeMod2` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CodeMod3` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CodeMod4` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RevCode` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UnitQty` int(11) NOT NULL,
  `BaseUnits` int(11) NOT NULL,
  `StartTime` int(11) NOT NULL,
  `StopTime` int(11) NOT NULL,
  `DateTP` date NOT NULL DEFAULT '0001-01-01',
  `SiteNum` bigint(20) NOT NULL,
  `HideGraphics` tinyint(4) NOT NULL,
  `CanadianTypeCodes` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProcTime` time NOT NULL,
  `ProcTimeEnd` time NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `Prognosis` bigint(20) NOT NULL,
  `DrugUnit` tinyint(4) NOT NULL,
  `DrugQty` float NOT NULL,
  `UnitQtyType` tinyint(4) NOT NULL,
  `StatementNum` bigint(20) NOT NULL,
  `IsLocked` tinyint(4) NOT NULL,
  `BillingNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RepeatChargeNum` bigint(20) NOT NULL,
  `SnomedBodySite` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DiagnosticCode2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DiagnosticCode3` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DiagnosticCode4` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvOrderOverride` bigint(20) NOT NULL,
  `Discount` double NOT NULL,
  `IsDateProsthEst` tinyint(4) NOT NULL,
  `IcdVersion` tinyint(3) UNSIGNED NOT NULL,
  `IsCpoe` tinyint(4) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateComplete` date NOT NULL DEFAULT '0001-01-01',
  `OrderingReferralNum` bigint(20) NOT NULL,
  `TaxAmt` double NOT NULL,
  `Urgency` tinyint(4) NOT NULL,
  `DiscountPlanAmt` double NOT NULL,
  PRIMARY KEY (`ProcNum`) USING BTREE,
  INDEX `CodeNum`(`CodeNum`) USING BTREE,
  INDEX `PlannedAptNum`(`PlannedAptNum`) USING BTREE,
  INDEX `BillingTypeOne`(`BillingTypeOne`) USING BTREE,
  INDEX `BillingTypeTwo`(`BillingTypeTwo`) USING BTREE,
  INDEX `Prognosis`(`Prognosis`) USING BTREE,
  INDEX `procedurelog_ProcNumLab`(`ProcNumLab`) USING BTREE,
  INDEX `StatementNum`(`StatementNum`) USING BTREE,
  INDEX `RepeatChargeNum`(`RepeatChargeNum`) USING BTREE,
  INDEX `ProvOrderOverride`(`ProvOrderOverride`) USING BTREE,
  INDEX `indexPNPSCN`(`PatNum`, `ProcStatus`, `ClinicNum`) USING BTREE,
  INDEX `indexPNPD`(`ProvNum`, `ProcDate`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `indexAgingCovering`(`PatNum`, `ProcStatus`, `ProcFee`, `UnitQty`, `BaseUnits`, `ProcDate`) USING BTREE,
  INDEX `OrderingReferralNum`(`OrderingReferralNum`) USING BTREE,
  INDEX `PatStatusCodeDate`(`PatNum`, `ProcStatus`, `CodeNum`, `ProcDate`) USING BTREE,
  INDEX `DateComplete`(`DateComplete`) USING BTREE,
  INDEX `RadiologyProcs`(`AptNum`, `CodeNum`, `ProcStatus`, `IsCpoe`, `ProvNum`) USING BTREE,
  INDEX `Priority`(`Priority`) USING BTREE,
  INDEX `DateClinicStatus`(`ProcDate`, `ClinicNum`, `ProcStatus`) USING BTREE,
  INDEX `DateTStampPN`(`DateTStamp`, `PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 115 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for procgroupitem
-- ----------------------------
DROP TABLE IF EXISTS `procgroupitem`;
CREATE TABLE `procgroupitem`  (
  `ProcGroupItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProcNum` bigint(20) NOT NULL,
  `GroupNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ProcGroupItemNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `GroupNum`(`GroupNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for procmultivisit
-- ----------------------------
DROP TABLE IF EXISTS `procmultivisit`;
CREATE TABLE `procmultivisit`  (
  `ProcMultiVisitNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `GroupProcMultiVisitNum` bigint(20) NOT NULL,
  `ProcNum` bigint(20) NOT NULL,
  `ProcStatus` tinyint(4) NOT NULL,
  `IsInProcess` tinyint(4) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `PatNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ProcMultiVisitNum`) USING BTREE,
  INDEX `GroupProcMultiVisitNum`(`GroupProcMultiVisitNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `IsInProcess`(`IsInProcess`) USING BTREE,
  INDEX `SecDateTEntry`(`SecDateTEntry`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for procnote
-- ----------------------------
DROP TABLE IF EXISTS `procnote`;
CREATE TABLE `procnote`  (
  `ProcNoteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ProcNum` bigint(20) NOT NULL,
  `EntryDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `UserNum` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SigIsTopaz` tinyint(3) UNSIGNED NOT NULL,
  `Signature` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ProcNoteNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 58 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for proctp
-- ----------------------------
DROP TABLE IF EXISTS `proctp`;
CREATE TABLE `proctp`  (
  `ProcTPNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TreatPlanNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ProcNumOrig` bigint(20) NOT NULL,
  `ItemOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Priority` bigint(20) NOT NULL,
  `ToothNumTP` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Surf` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ProcCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FeeAmt` double NOT NULL DEFAULT 0,
  `PriInsAmt` double NOT NULL DEFAULT 0,
  `SecInsAmt` double NOT NULL DEFAULT 0,
  `PatAmt` double NOT NULL DEFAULT 0,
  `Discount` double NOT NULL,
  `Prognosis` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Dx` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProcAbbr` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `FeeAllowed` double NOT NULL,
  `TaxAmt` double NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `DateTP` date NOT NULL DEFAULT '0001-01-01',
  `ClinicNum` bigint(20) NOT NULL,
  `CatPercUCR` double NOT NULL,
  PRIMARY KEY (`ProcTPNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `indexTreatPlanNum`(`TreatPlanNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ProcNumOrig`(`ProcNumOrig`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for program
-- ----------------------------
DROP TABLE IF EXISTS `program`;
CREATE TABLE `program`  (
  `ProgramNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProgName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ProgDesc` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Enabled` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `Path` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `CommandLine` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PluginDllName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ButtonImage` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FileTemplate` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FilePath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsDisabledByHq` tinyint(4) NOT NULL,
  `CustErr` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ProgramNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 144 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for programproperty
-- ----------------------------
DROP TABLE IF EXISTS `programproperty`;
CREATE TABLE `programproperty`  (
  `ProgramPropertyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProgramNum` bigint(20) NOT NULL,
  `PropertyDesc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PropertyValue` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ComputerName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `IsMasked` tinyint(4) NOT NULL,
  `IsHighSecurity` tinyint(4) NOT NULL,
  PRIMARY KEY (`ProgramPropertyNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 339 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for promotion
-- ----------------------------
DROP TABLE IF EXISTS `promotion`;
CREATE TABLE `promotion`  (
  `PromotionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PromotionName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeCreated` date NOT NULL DEFAULT '0001-01-01',
  `ClinicNum` bigint(20) NOT NULL,
  `TypePromotion` tinyint(4) NOT NULL,
  PRIMARY KEY (`PromotionNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for promotionlog
-- ----------------------------
DROP TABLE IF EXISTS `promotionlog`;
CREATE TABLE `promotionlog`  (
  `PromotionLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PromotionNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `MessageFk` bigint(20) NOT NULL,
  `EmailHostingFK` bigint(20) NOT NULL,
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `PromotionStatus` tinyint(4) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `SendStatus` tinyint(4) NOT NULL,
  `MessageType` tinyint(4) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ResponseDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ApptReminderRuleNum` bigint(20) NOT NULL,
  PRIMARY KEY (`PromotionLogNum`) USING BTREE,
  INDEX `PromotionNum`(`PromotionNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `EmailMessageNum`(`MessageFk`) USING BTREE,
  INDEX `EmailHostingFK`(`EmailHostingFK`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `MessageFk`(`MessageFk`) USING BTREE,
  INDEX `ApptReminderRuleNum`(`ApptReminderRuleNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for provider
-- ----------------------------
DROP TABLE IF EXISTS `provider`;
CREATE TABLE `provider`  (
  `ProvNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Abbr` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ItemOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `LName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `MI` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Suffix` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FeeSched` bigint(20) NOT NULL,
  `Specialty` bigint(20) NOT NULL,
  `SSN` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `StateLicense` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DEANum` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsSecondary` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `ProvColor` int(11) NOT NULL DEFAULT 0,
  `IsHidden` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `UsingTIN` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `BlueCrossID` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `SigOnFile` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `MedicaidID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `OutlineColor` int(11) NOT NULL DEFAULT 0,
  `SchoolClassNum` bigint(20) NOT NULL,
  `NationalProvID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `CanadianOfficeNum` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `AnesthProvType` bigint(20) NOT NULL,
  `TaxonomyCodeOverride` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsCDAnet` tinyint(4) NOT NULL,
  `EcwID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StateRxID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsNotPerson` tinyint(4) NOT NULL,
  `StateWhereLicensed` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailAddressNum` bigint(20) NOT NULL,
  `IsInstructor` tinyint(4) NOT NULL,
  `EhrMuStage` int(11) NOT NULL,
  `ProvNumBillingOverride` bigint(20) NOT NULL,
  `CustomID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvStatus` tinyint(4) NOT NULL,
  `IsHiddenReport` tinyint(4) NOT NULL,
  `IsErxEnabled` tinyint(4) NOT NULL,
  `Birthdate` date NOT NULL DEFAULT '0001-01-01',
  `SchedNote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WebSchedDescript` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WebSchedImageLocation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HourlyProdGoalAmt` double NOT NULL,
  `DateTerm` date NOT NULL DEFAULT '0001-01-01',
  `PreferredName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ProvNum`) USING BTREE,
  INDEX `EmailAddressNum`(`EmailAddressNum`) USING BTREE,
  INDEX `ProvNumBillingOverride`(`ProvNumBillingOverride`) USING BTREE,
  INDEX `FeeSched`(`FeeSched`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for providerclinic
-- ----------------------------
DROP TABLE IF EXISTS `providerclinic`;
CREATE TABLE `providerclinic`  (
  `ProviderClinicNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProvNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `DEANum` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StateLicense` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StateRxID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StateWhereLicensed` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CareCreditMerchantId` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ProviderClinicNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for providercliniclink
-- ----------------------------
DROP TABLE IF EXISTS `providercliniclink`;
CREATE TABLE `providercliniclink`  (
  `ProviderClinicLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProvNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ProviderClinicLinkNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for providererx
-- ----------------------------
DROP TABLE IF EXISTS `providererx`;
CREATE TABLE `providererx`  (
  `ProviderErxNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `NationalProviderID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsEnabled` tinyint(4) NOT NULL,
  `IsIdentifyProofed` tinyint(4) NOT NULL,
  `IsSentToHq` tinyint(4) NOT NULL,
  `IsEpcs` tinyint(4) NOT NULL,
  `ErxType` tinyint(4) NOT NULL,
  `UserId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AccountId` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RegistrationKeyNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ProviderErxNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `RegistrationKeyNum`(`RegistrationKeyNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for providerident
-- ----------------------------
DROP TABLE IF EXISTS `providerident`;
CREATE TABLE `providerident`  (
  `ProviderIdentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProvNum` bigint(20) NOT NULL,
  `PayorID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `SuppIDType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `IDNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`ProviderIdentNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for queryfilter
-- ----------------------------
DROP TABLE IF EXISTS `queryfilter`;
CREATE TABLE `queryfilter`  (
  `QueryFilterNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `GroupName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FilterText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`QueryFilterNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `QuestionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ItemOrder` smallint(5) UNSIGNED NOT NULL,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Answer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FormPatNum` bigint(20) NOT NULL,
  PRIMARY KEY (`QuestionNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for questiondef
-- ----------------------------
DROP TABLE IF EXISTS `questiondef`;
CREATE TABLE `questiondef`  (
  `QuestionDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ItemOrder` smallint(5) UNSIGNED NOT NULL,
  `QuestType` tinyint(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`QuestionDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for quickpastecat
-- ----------------------------
DROP TABLE IF EXISTS `quickpastecat`;
CREATE TABLE `quickpastecat`  (
  `QuickPasteCatNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ItemOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `DefaultForTypes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`QuickPasteCatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for quickpastenote
-- ----------------------------
DROP TABLE IF EXISTS `quickpastenote`;
CREATE TABLE `quickpastenote`  (
  `QuickPasteNoteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `QuickPasteCatNum` bigint(20) NOT NULL,
  `ItemOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Abbreviation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`QuickPasteNoteNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 33 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reactivation
-- ----------------------------
DROP TABLE IF EXISTS `reactivation`;
CREATE TABLE `reactivation`  (
  `ReactivationNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ReactivationStatus` bigint(20) NOT NULL,
  `ReactivationNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DoNotContact` tinyint(4) NOT NULL,
  PRIMARY KEY (`ReactivationNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ReactivationStatus`(`ReactivationStatus`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for recall
-- ----------------------------
DROP TABLE IF EXISTS `recall`;
CREATE TABLE `recall`  (
  `RecallNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateDueCalc` date NOT NULL DEFAULT '0001-01-01',
  `DateDue` date NOT NULL DEFAULT '0001-01-01',
  `DatePrevious` date NOT NULL DEFAULT '0001-01-01',
  `RecallInterval` int(11) NOT NULL DEFAULT 0,
  `RecallStatus` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsDisabled` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `RecallTypeNum` bigint(20) NOT NULL,
  `DisableUntilBalance` double NOT NULL,
  `DisableUntilDate` date NOT NULL DEFAULT '0001-01-01',
  `DateScheduled` date NOT NULL DEFAULT '0001-01-01',
  `Priority` tinyint(4) NOT NULL,
  `TimePatternOverride` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`RecallNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `DatePrevious`(`DatePrevious`) USING BTREE,
  INDEX `IsDisabled`(`IsDisabled`) USING BTREE,
  INDEX `RecallTypeNum`(`RecallTypeNum`) USING BTREE,
  INDEX `DateScheduled`(`DateScheduled`) USING BTREE,
  INDEX `DateDisabledType`(`DateDue`, `IsDisabled`, `RecallTypeNum`, `DateScheduled`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for recalltrigger
-- ----------------------------
DROP TABLE IF EXISTS `recalltrigger`;
CREATE TABLE `recalltrigger`  (
  `RecallTriggerNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `RecallTypeNum` bigint(20) NOT NULL,
  `CodeNum` bigint(20) NOT NULL,
  PRIMARY KEY (`RecallTriggerNum`) USING BTREE,
  INDEX `CodeNum`(`CodeNum`) USING BTREE,
  INDEX `RecallTypeNum`(`RecallTypeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for recalltype
-- ----------------------------
DROP TABLE IF EXISTS `recalltype`;
CREATE TABLE `recalltype`  (
  `RecallTypeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DefaultInterval` int(11) NOT NULL,
  `TimePattern` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Procedures` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `AppendToSpecial` tinyint(4) NOT NULL,
  PRIMARY KEY (`RecallTypeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reconcile
-- ----------------------------
DROP TABLE IF EXISTS `reconcile`;
CREATE TABLE `reconcile`  (
  `ReconcileNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `AccountNum` bigint(20) NOT NULL,
  `StartingBal` double NOT NULL DEFAULT 0,
  `EndingBal` double NOT NULL DEFAULT 0,
  `DateReconcile` date NOT NULL DEFAULT '0001-01-01',
  `IsLocked` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`ReconcileNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for recurringcharge
-- ----------------------------
DROP TABLE IF EXISTS `recurringcharge`;
CREATE TABLE `recurringcharge`  (
  `RecurringChargeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `DateTimeCharge` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ChargeStatus` tinyint(4) NOT NULL,
  `FamBal` double NOT NULL,
  `PayPlanDue` double NOT NULL,
  `TotalDue` double NOT NULL,
  `RepeatAmt` double NOT NULL,
  `ChargeAmt` double NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `PayNum` bigint(20) NOT NULL,
  `CreditCardNum` bigint(20) NOT NULL,
  `ErrorMsg` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`RecurringChargeNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `PayNum`(`PayNum`) USING BTREE,
  INDEX `CreditCardNum`(`CreditCardNum`) USING BTREE,
  INDEX `DateTimeCharge`(`DateTimeCharge`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for refattach
-- ----------------------------
DROP TABLE IF EXISTS `refattach`;
CREATE TABLE `refattach`  (
  `RefAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ReferralNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `ItemOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `RefDate` date NOT NULL DEFAULT '0000-00-00',
  `RefType` tinyint(4) NOT NULL,
  `RefToStatus` tinyint(3) UNSIGNED NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsTransitionOfCare` tinyint(4) NOT NULL,
  `ProcNum` bigint(20) NOT NULL,
  `DateProcComplete` date NOT NULL DEFAULT '0001-01-01',
  `ProvNum` bigint(20) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`RefAttachNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `ReferralNum`(`ReferralNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for referral
-- ----------------------------
DROP TABLE IF EXISTS `referral`;
CREATE TABLE `referral`  (
  `ReferralNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `MName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `SSN` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `UsingTIN` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `Specialty` bigint(20) NOT NULL,
  `ST` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Telephone` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Address2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `City` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Zip` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Phone2` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsHidden` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `NotPerson` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `Title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `EMail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PatNum` bigint(20) NOT NULL,
  `NationalProvID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Slip` bigint(20) NOT NULL,
  `IsDoctor` tinyint(4) NOT NULL,
  `IsTrustedDirect` tinyint(4) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `IsPreferred` tinyint(4) NOT NULL,
  `BusinessName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DisplayNote` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ReferralNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for referralcliniclink
-- ----------------------------
DROP TABLE IF EXISTS `referralcliniclink`;
CREATE TABLE `referralcliniclink`  (
  `ReferralClinicLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ReferralNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ReferralClinicLinkNum`) USING BTREE,
  INDEX `ReferralNum`(`ReferralNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for registrationkey
-- ----------------------------
DROP TABLE IF EXISTS `registrationkey`;
CREATE TABLE `registrationkey`  (
  `RegistrationKeyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `RegKey` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DateStarted` date NOT NULL DEFAULT '0001-01-01',
  `DateDisabled` date NOT NULL DEFAULT '0001-01-01',
  `DateEnded` date NOT NULL DEFAULT '0001-01-01',
  `IsForeign` tinyint(1) NOT NULL,
  `UsesServerVersion` tinyint(4) NOT NULL,
  `IsFreeVersion` tinyint(4) NOT NULL,
  `IsOnlyForTesting` tinyint(4) NOT NULL,
  `VotesAllotted` int(11) NOT NULL,
  `IsResellerCustomer` tinyint(4) NOT NULL,
  `HasEarlyAccess` tinyint(4) NOT NULL,
  `DateTBackupScheduled` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `BackupPassCode` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`RegistrationKeyNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reminderrule
-- ----------------------------
DROP TABLE IF EXISTS `reminderrule`;
CREATE TABLE `reminderrule`  (
  `ReminderRuleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ReminderCriterion` tinyint(4) NOT NULL,
  `CriterionFK` bigint(20) NOT NULL,
  `CriterionValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Message` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ReminderRuleNum`) USING BTREE,
  INDEX `CriterionFK`(`CriterionFK`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for repeatcharge
-- ----------------------------
DROP TABLE IF EXISTS `repeatcharge`;
CREATE TABLE `repeatcharge`  (
  `RepeatChargeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ProcCode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ChargeAmt` double NOT NULL DEFAULT 0,
  `DateStart` date NOT NULL DEFAULT '0001-01-01',
  `DateStop` date NOT NULL DEFAULT '0001-01-01',
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CopyNoteToProc` tinyint(4) NOT NULL,
  `CreatesClaim` tinyint(4) NOT NULL,
  `IsEnabled` tinyint(4) NOT NULL,
  `UsePrepay` tinyint(4) NOT NULL,
  `Npi` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ErxAccountId` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProviderName` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ChargeAmtAlt` double NOT NULL,
  `UnearnedTypes` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Frequency` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`RepeatChargeNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for replicationserver
-- ----------------------------
DROP TABLE IF EXISTS `replicationserver`;
CREATE TABLE `replicationserver`  (
  `ReplicationServerNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Descript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ServerId` int(10) UNSIGNED NOT NULL,
  `RangeStart` bigint(20) NOT NULL,
  `RangeEnd` bigint(20) NOT NULL,
  `AtoZpath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UpdateBlocked` tinyint(4) NOT NULL,
  `SlaveMonitor` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ReplicationServerNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reqneeded
-- ----------------------------
DROP TABLE IF EXISTS `reqneeded`;
CREATE TABLE `reqneeded`  (
  `ReqNeededNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SchoolCourseNum` bigint(20) NOT NULL,
  `SchoolClassNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ReqNeededNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reqstudent
-- ----------------------------
DROP TABLE IF EXISTS `reqstudent`;
CREATE TABLE `reqstudent`  (
  `ReqStudentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ReqNeededNum` bigint(20) NOT NULL,
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SchoolCourseNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `AptNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `InstructorNum` bigint(20) NOT NULL,
  `DateCompleted` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`ReqStudentNum`) USING BTREE,
  INDEX `ReqNeededNum`(`ReqNeededNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for requiredfield
-- ----------------------------
DROP TABLE IF EXISTS `requiredfield`;
CREATE TABLE `requiredfield`  (
  `RequiredFieldNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FieldType` tinyint(4) NOT NULL,
  `FieldName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`RequiredFieldNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for requiredfieldcondition
-- ----------------------------
DROP TABLE IF EXISTS `requiredfieldcondition`;
CREATE TABLE `requiredfieldcondition`  (
  `RequiredFieldConditionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `RequiredFieldNum` bigint(20) NOT NULL,
  `ConditionType` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Operator` tinyint(4) NOT NULL,
  `ConditionValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ConditionRelationship` tinyint(4) NOT NULL,
  PRIMARY KEY (`RequiredFieldConditionNum`) USING BTREE,
  INDEX `RequiredFieldNum`(`RequiredFieldNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rxalert
-- ----------------------------
DROP TABLE IF EXISTS `rxalert`;
CREATE TABLE `rxalert`  (
  `RxAlertNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `RxDefNum` bigint(20) NOT NULL,
  `DiseaseDefNum` bigint(20) NOT NULL,
  `AllergyDefNum` bigint(20) NOT NULL,
  `MedicationNum` bigint(20) NOT NULL,
  `NotificationMsg` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHighSignificance` tinyint(4) NOT NULL,
  PRIMARY KEY (`RxAlertNum`) USING BTREE,
  INDEX `AllergyDefNum`(`AllergyDefNum`) USING BTREE,
  INDEX `MedicationNum`(`MedicationNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rxdef
-- ----------------------------
DROP TABLE IF EXISTS `rxdef`;
CREATE TABLE `rxdef`  (
  `RxDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Drug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Sig` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Disp` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Refills` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Notes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsControlled` tinyint(4) NOT NULL,
  `RxCui` bigint(20) NOT NULL,
  `IsProcRequired` tinyint(4) NOT NULL,
  `PatientInstruction` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`RxDefNum`) USING BTREE,
  INDEX `RxCui`(`RxCui`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rxnorm
-- ----------------------------
DROP TABLE IF EXISTS `rxnorm`;
CREATE TABLE `rxnorm`  (
  `RxNormNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `RxCui` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MmslCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`RxNormNum`) USING BTREE,
  INDEX `RxCui`(`RxCui`) USING BTREE,
  INDEX `Description`(`Description`(100)) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rxpat
-- ----------------------------
DROP TABLE IF EXISTS `rxpat`;
CREATE TABLE `rxpat`  (
  `RxNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `RxDate` date NOT NULL DEFAULT '0000-00-00',
  `Drug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Sig` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Disp` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Refills` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ProvNum` bigint(20) NOT NULL,
  `Notes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `PharmacyNum` bigint(20) NOT NULL,
  `IsControlled` tinyint(4) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `SendStatus` tinyint(4) NOT NULL,
  `RxCui` bigint(20) NOT NULL,
  `DosageCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ErxGuid` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsErxOld` tinyint(4) NOT NULL,
  `ErxPharmacyInfo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsProcRequired` tinyint(4) NOT NULL,
  `ProcNum` bigint(20) NOT NULL,
  `DaysOfSupply` double NULL DEFAULT NULL,
  `PatientInstruction` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `RxType` tinyint(4) NOT NULL,
  PRIMARY KEY (`RxNum`) USING BTREE,
  INDEX `RxCui`(`RxCui`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `PatNumRxType`(`PatNum`, `RxType`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule`  (
  `ScheduleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SchedDate` date NOT NULL DEFAULT '0000-00-00',
  `StartTime` time NOT NULL DEFAULT '00:00:00',
  `StopTime` time NOT NULL DEFAULT '00:00:00',
  `SchedType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ProvNum` bigint(20) NOT NULL,
  `BlockoutType` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `EmployeeNum` bigint(20) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `ClinicNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ScheduleNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `SchedDate`(`SchedDate`) USING BTREE,
  INDEX `ClinicNumSchedType`(`ClinicNum`, `SchedType`) USING BTREE,
  INDEX `BlockoutType`(`BlockoutType`) USING BTREE,
  INDEX `EmpDateTypeStopTime`(`EmployeeNum`, `SchedDate`, `SchedType`, `StopTime`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 25880 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for scheduledprocess
-- ----------------------------
DROP TABLE IF EXISTS `scheduledprocess`;
CREATE TABLE `scheduledprocess`  (
  `ScheduledProcessNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ScheduledAction` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TimeToRun` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `FrequencyToRun` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LastRanDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`ScheduledProcessNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for scheduleop
-- ----------------------------
DROP TABLE IF EXISTS `scheduleop`;
CREATE TABLE `scheduleop`  (
  `ScheduleOpNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ScheduleNum` bigint(20) NOT NULL,
  `OperatoryNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ScheduleOpNum`) USING BTREE,
  INDEX `ScheduleNum`(`ScheduleNum`) USING BTREE,
  INDEX `OperatoryNum`(`OperatoryNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 27731 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for schoolclass
-- ----------------------------
DROP TABLE IF EXISTS `schoolclass`;
CREATE TABLE `schoolclass`  (
  `SchoolClassNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `GradYear` int(11) NOT NULL,
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`SchoolClassNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for schoolcourse
-- ----------------------------
DROP TABLE IF EXISTS `schoolcourse`;
CREATE TABLE `schoolcourse`  (
  `SchoolCourseNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CourseID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`SchoolCourseNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for screen
-- ----------------------------
DROP TABLE IF EXISTS `screen`;
CREATE TABLE `screen`  (
  `ScreenNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Gender` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `RaceOld` tinyint(4) NOT NULL,
  `GradeLevel` tinyint(4) NOT NULL DEFAULT 0,
  `Age` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Urgency` tinyint(4) NOT NULL DEFAULT 0,
  `HasCaries` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `NeedsSealants` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `CariesExperience` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `EarlyChildCaries` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ExistingSealants` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `MissingAllTeeth` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Birthdate` date NOT NULL DEFAULT '0000-00-00',
  `ScreenGroupNum` bigint(20) NOT NULL,
  `ScreenGroupOrder` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Comments` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ScreenPatNum` bigint(20) NOT NULL,
  `SheetNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ScreenNum`) USING BTREE,
  INDEX `ScreenPatNum`(`ScreenPatNum`) USING BTREE,
  INDEX `SheetNum`(`SheetNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for screengroup
-- ----------------------------
DROP TABLE IF EXISTS `screengroup`;
CREATE TABLE `screengroup`  (
  `ScreenGroupNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `SGDate` date NOT NULL DEFAULT '0000-00-00',
  `ProvName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `PlaceService` tinyint(4) NOT NULL,
  `County` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GradeSchool` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SheetDefNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ScreenGroupNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `SheetDefNum`(`SheetDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for screenpat
-- ----------------------------
DROP TABLE IF EXISTS `screenpat`;
CREATE TABLE `screenpat`  (
  `ScreenPatNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ScreenGroupNum` bigint(20) NOT NULL,
  `SheetNum` bigint(20) NOT NULL,
  `PatScreenPerm` tinyint(4) NOT NULL,
  PRIMARY KEY (`ScreenPatNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ScreenGroupNum`(`ScreenGroupNum`) USING BTREE,
  INDEX `SheetNum`(`SheetNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for securitylog
-- ----------------------------
DROP TABLE IF EXISTS `securitylog`;
CREATE TABLE `securitylog`  (
  `SecurityLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PermType` smallint(6) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `LogDateTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LogText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PatNum` bigint(20) NOT NULL,
  `CompName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `LogSource` tinyint(4) NOT NULL,
  `DefNum` bigint(20) NOT NULL,
  `DefNumError` bigint(20) NOT NULL,
  `DateTPrevious` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`SecurityLogNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `DefNum`(`DefNum`) USING BTREE,
  INDEX `DefNumError`(`DefNumError`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `LogDateTime`(`LogDateTime`) USING BTREE,
  INDEX `PermType`(`PermType`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 126 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for securityloghash
-- ----------------------------
DROP TABLE IF EXISTS `securityloghash`;
CREATE TABLE `securityloghash`  (
  `SecurityLogHashNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SecurityLogNum` bigint(20) NOT NULL,
  `LogHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`SecurityLogHashNum`) USING BTREE,
  INDEX `SecurityLogNum`(`SecurityLogNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 126 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sessiontoken
-- ----------------------------
DROP TABLE IF EXISTS `sessiontoken`;
CREATE TABLE `sessiontoken`  (
  `SessionTokenNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SessionTokenHash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Expiration` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TokenType` tinyint(4) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  PRIMARY KEY (`SessionTokenNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `SessionTokenHash`(`SessionTokenHash`(20)) USING BTREE,
  INDEX `Expiration`(`Expiration`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sheet
-- ----------------------------
DROP TABLE IF EXISTS `sheet`;
CREATE TABLE `sheet`  (
  `SheetNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SheetType` int(11) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `DateTimeSheet` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `FontSize` float NOT NULL,
  `FontName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Width` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  `IsLandscape` tinyint(4) NOT NULL,
  `InternalNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ShowInTerminal` tinyint(4) NOT NULL,
  `IsWebForm` tinyint(4) NOT NULL,
  `IsMultiPage` tinyint(4) NOT NULL,
  `IsDeleted` tinyint(4) NOT NULL,
  `SheetDefNum` bigint(20) NOT NULL,
  `DocNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `DateTSheetEdited` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `HasMobileLayout` tinyint(4) NOT NULL,
  `RevID` int(11) NOT NULL,
  `WebFormSheetID` bigint(20) NOT NULL,
  PRIMARY KEY (`SheetNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `SheetDefNum`(`SheetDefNum`) USING BTREE,
  INDEX `DocNum`(`DocNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `WebFormSheetID`(`WebFormSheetID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sheetdef
-- ----------------------------
DROP TABLE IF EXISTS `sheetdef`;
CREATE TABLE `sheetdef`  (
  `SheetDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SheetType` int(11) NOT NULL,
  `FontSize` float NOT NULL,
  `FontName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Width` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  `IsLandscape` tinyint(4) NOT NULL,
  `PageCount` int(11) NOT NULL,
  `IsMultiPage` tinyint(4) NOT NULL,
  `BypassGlobalLock` tinyint(4) NOT NULL,
  `HasMobileLayout` tinyint(4) NOT NULL,
  `DateTCreated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `RevID` int(11) NOT NULL,
  `AutoCheckSaveImage` tinyint(4) NOT NULL DEFAULT 1,
  `AutoCheckSaveImageDocCategory` bigint(20) NOT NULL,
  PRIMARY KEY (`SheetDefNum`) USING BTREE,
  INDEX `AutoCheckSaveImageDocCategory`(`AutoCheckSaveImageDocCategory`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sheetfield
-- ----------------------------
DROP TABLE IF EXISTS `sheetfield`;
CREATE TABLE `sheetfield`  (
  `SheetFieldNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SheetNum` bigint(20) NOT NULL,
  `FieldType` int(11) NOT NULL,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FieldValue` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FontSize` float NOT NULL,
  `FontName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FontIsBold` tinyint(4) NOT NULL,
  `XPos` int(11) NOT NULL,
  `YPos` int(11) NOT NULL,
  `Width` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  `GrowthBehavior` int(11) NOT NULL,
  `RadioButtonValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RadioButtonGroup` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsRequired` tinyint(4) NOT NULL,
  `TabOrder` int(11) NOT NULL,
  `ReportableName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `TextAlign` tinyint(4) NOT NULL,
  `ItemColor` int(11) NOT NULL DEFAULT -16777216,
  `DateTimeSig` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `IsLocked` tinyint(4) NOT NULL,
  `TabOrderMobile` int(11) NOT NULL,
  `UiLabelMobile` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UiLabelMobileRadioButton` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SheetFieldDefNum` bigint(20) NOT NULL,
  `CanElectronicallySign` tinyint(4) NOT NULL,
  `IsSigProvRestricted` tinyint(4) NOT NULL,
  `UserSigned` bigint(20) NOT NULL,
  PRIMARY KEY (`SheetFieldNum`) USING BTREE,
  INDEX `SheetNum`(`SheetNum`) USING BTREE,
  INDEX `FieldType`(`FieldType`) USING BTREE,
  INDEX `SheetNumFieldType`(`SheetNum`, `FieldType`) USING BTREE,
  INDEX `SheetFieldDefNum`(`SheetFieldDefNum`) USING BTREE,
  INDEX `UserSigned`(`UserSigned`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sheetfielddef
-- ----------------------------
DROP TABLE IF EXISTS `sheetfielddef`;
CREATE TABLE `sheetfielddef`  (
  `SheetFieldDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SheetDefNum` bigint(20) NOT NULL,
  `FieldType` int(11) NOT NULL,
  `FieldName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FieldValue` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FontSize` float NOT NULL,
  `FontName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FontIsBold` tinyint(4) NOT NULL,
  `XPos` int(11) NOT NULL,
  `YPos` int(11) NOT NULL,
  `Width` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  `GrowthBehavior` int(11) NOT NULL,
  `RadioButtonValue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RadioButtonGroup` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsRequired` tinyint(4) NOT NULL,
  `TabOrder` int(11) NOT NULL,
  `ReportableName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `TextAlign` tinyint(4) NOT NULL,
  `IsPaymentOption` tinyint(4) NOT NULL,
  `ItemColor` int(11) NOT NULL DEFAULT -16777216,
  `IsLocked` tinyint(4) NOT NULL,
  `TabOrderMobile` int(11) NOT NULL,
  `UiLabelMobile` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UiLabelMobileRadioButton` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LayoutMode` tinyint(4) NOT NULL,
  `Language` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CanElectronicallySign` tinyint(4) NOT NULL,
  `IsSigProvRestricted` tinyint(4) NOT NULL,
  PRIMARY KEY (`SheetFieldDefNum`) USING BTREE,
  INDEX `SheetDefNum`(`SheetDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sigbutdef
-- ----------------------------
DROP TABLE IF EXISTS `sigbutdef`;
CREATE TABLE `sigbutdef`  (
  `SigButDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ButtonText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ButtonIndex` smallint(6) NOT NULL,
  `SynchIcon` tinyint(3) UNSIGNED NOT NULL,
  `ComputerName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `SigElementDefNumUser` bigint(20) NOT NULL,
  `SigElementDefNumExtra` bigint(20) NOT NULL,
  `SigElementDefNumMsg` bigint(20) NOT NULL,
  PRIMARY KEY (`SigButDefNum`) USING BTREE,
  INDEX `SigElementDefNumUser`(`SigElementDefNumUser`) USING BTREE,
  INDEX `SigElementDefNumExtra`(`SigElementDefNumExtra`) USING BTREE,
  INDEX `SigElementDefNumMsg`(`SigElementDefNumMsg`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sigelementdef
-- ----------------------------
DROP TABLE IF EXISTS `sigelementdef`;
CREATE TABLE `sigelementdef`  (
  `SigElementDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `LightRow` tinyint(3) UNSIGNED NOT NULL,
  `LightColor` int(11) NOT NULL,
  `SigElementType` tinyint(3) UNSIGNED NOT NULL,
  `SigText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Sound` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ItemOrder` smallint(6) NOT NULL,
  PRIMARY KEY (`SigElementDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 26 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sigmessage
-- ----------------------------
DROP TABLE IF EXISTS `sigmessage`;
CREATE TABLE `sigmessage`  (
  `SigMessageNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ButtonText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ButtonIndex` int(11) NOT NULL,
  `SynchIcon` tinyint(3) UNSIGNED NOT NULL,
  `FromUser` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ToUser` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MessageDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `AckDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SigText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SigElementDefNumUser` bigint(20) NOT NULL,
  `SigElementDefNumExtra` bigint(20) NOT NULL,
  `SigElementDefNumMsg` bigint(20) NOT NULL,
  PRIMARY KEY (`SigMessageNum`) USING BTREE,
  INDEX `SigElementDefNumUser`(`SigElementDefNumUser`) USING BTREE,
  INDEX `SigElementDefNumExtra`(`SigElementDefNumExtra`) USING BTREE,
  INDEX `SigElementDefNumMsg`(`SigElementDefNumMsg`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for signalod
-- ----------------------------
DROP TABLE IF EXISTS `signalod`;
CREATE TABLE `signalod`  (
  `SignalNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateViewing` date NOT NULL DEFAULT '0001-01-01',
  `SigDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `FKey` bigint(20) NOT NULL,
  `FKeyType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IType` tinyint(4) NOT NULL,
  `RemoteRole` tinyint(4) NOT NULL,
  `MsgValue` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`SignalNum`) USING BTREE,
  INDEX `indexSigDateTime`(`SigDateTime`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `IType`(`IType`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12439 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for site
-- ----------------------------
DROP TABLE IF EXISTS `site`;
CREATE TABLE `site`  (
  `SiteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Address2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `City` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `State` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Zip` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `PlaceService` tinyint(4) NOT NULL,
  PRIMARY KEY (`SiteNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for smsblockphone
-- ----------------------------
DROP TABLE IF EXISTS `smsblockphone`;
CREATE TABLE `smsblockphone`  (
  `SmsBlockPhoneNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `BlockWirelessNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`SmsBlockPhoneNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for smsfrommobile
-- ----------------------------
DROP TABLE IF EXISTS `smsfrommobile`;
CREATE TABLE `smsfrommobile`  (
  `SmsFromMobileNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `CommlogNum` bigint(20) NOT NULL,
  `MsgText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeReceived` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SmsPhoneNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MobilePhoneNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MsgPart` int(11) NOT NULL,
  `MsgTotal` int(11) NOT NULL,
  `MsgRefID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SmsStatus` tinyint(4) NOT NULL,
  `Flags` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  `MatchCount` int(11) NOT NULL,
  `GuidMessage` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SmsFromMobileNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `CommlogNum`(`CommlogNum`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE,
  INDEX `StatusHiddenClinic`(`SmsStatus`, `IsHidden`, `ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for smsphone
-- ----------------------------
DROP TABLE IF EXISTS `smsphone`;
CREATE TABLE `smsphone`  (
  `SmsPhoneNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `PhoneNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeActive` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeInactive` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `InactiveCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CountryCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`SmsPhoneNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for smstomobile
-- ----------------------------
DROP TABLE IF EXISTS `smstomobile`;
CREATE TABLE `smstomobile`  (
  `SmsToMobileNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `GuidMessage` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GuidBatch` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SmsPhoneNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MobilePhoneNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsTimeSensitive` tinyint(4) NOT NULL,
  `MsgType` tinyint(4) NOT NULL,
  `MsgText` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SmsStatus` tinyint(4) NOT NULL,
  `MsgParts` int(11) NOT NULL,
  `MsgChargeUSD` float NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `CustErrorText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeTerminated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `IsHidden` tinyint(4) NOT NULL,
  `MsgDiscountUSD` float NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SmsToMobileNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ClinicDTSent`(`ClinicNum`, `DateTimeSent`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE,
  INDEX `GuidMessage`(`GuidMessage`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for snomed
-- ----------------------------
DROP TABLE IF EXISTS `snomed`;
CREATE TABLE `snomed`  (
  `SnomedNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SnomedCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`SnomedNum`) USING BTREE,
  INDEX `SnomedCode`(`SnomedCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sop
-- ----------------------------
DROP TABLE IF EXISTS `sop`;
CREATE TABLE `sop`  (
  `SopNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SopCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`SopNum`) USING BTREE,
  INDEX `SopCode`(`SopCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stateabbr
-- ----------------------------
DROP TABLE IF EXISTS `stateabbr`;
CREATE TABLE `stateabbr`  (
  `StateAbbrNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Abbr` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MedicaidIDLength` int(11) NOT NULL,
  PRIMARY KEY (`StateAbbrNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 52 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for statement
-- ----------------------------
DROP TABLE IF EXISTS `statement`;
CREATE TABLE `statement`  (
  `StatementNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateSent` date NOT NULL DEFAULT '0001-01-01',
  `DateRangeFrom` date NOT NULL DEFAULT '0001-01-01',
  `DateRangeTo` date NOT NULL DEFAULT '0001-01-01',
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NoteBold` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Mode_` tinyint(3) UNSIGNED NOT NULL,
  `HidePayment` tinyint(1) NOT NULL,
  `SinglePatient` tinyint(1) NOT NULL,
  `Intermingled` tinyint(1) NOT NULL,
  `IsSent` tinyint(1) NOT NULL,
  `DocNum` bigint(20) NOT NULL,
  `DateTStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `IsReceipt` tinyint(4) NOT NULL,
  `IsInvoice` tinyint(4) NOT NULL,
  `IsInvoiceCopy` tinyint(4) NOT NULL,
  `EmailSubject` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailBody` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SuperFamily` bigint(20) NOT NULL,
  `IsBalValid` tinyint(4) NOT NULL,
  `InsEst` double NOT NULL,
  `BalTotal` double NOT NULL,
  `StatementType` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ShortGUID` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StatementShortURL` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StatementURL` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SmsSendStatus` tinyint(4) NOT NULL,
  `LimitedCustomFamily` tinyint(4) NOT NULL DEFAULT 0,
  `ShowTransSinceBalZero` tinyint(4) NOT NULL,
  PRIMARY KEY (`StatementNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `DocNum`(`DocNum`) USING BTREE,
  INDEX `SuperFamModeDateSent`(`SuperFamily`, `Mode_`, `DateSent`) USING BTREE,
  INDEX `ShortGUID`(`ShortGUID`) USING BTREE,
  INDEX `IsSent`(`IsSent`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for statementprod
-- ----------------------------
DROP TABLE IF EXISTS `statementprod`;
CREATE TABLE `statementprod`  (
  `StatementProdNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `StatementNum` bigint(20) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `ProdType` tinyint(4) NOT NULL,
  `LateChargeAdjNum` bigint(20) NOT NULL,
  `DocNum` bigint(20) NOT NULL,
  PRIMARY KEY (`StatementProdNum`) USING BTREE,
  INDEX `StatementNum`(`StatementNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE,
  INDEX `ProdType`(`ProdType`) USING BTREE,
  INDEX `LateChargeAdjNum`(`LateChargeAdjNum`) USING BTREE,
  INDEX `DocNum`(`DocNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for stmtlink
-- ----------------------------
DROP TABLE IF EXISTS `stmtlink`;
CREATE TABLE `stmtlink`  (
  `StmtLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `StatementNum` bigint(20) NOT NULL,
  `StmtLinkType` tinyint(4) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  PRIMARY KEY (`StmtLinkNum`) USING BTREE,
  INDEX `StatementNum`(`StatementNum`) USING BTREE,
  INDEX `FKeyAndType`(`StmtLinkType`, `FKey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for substitutionlink
-- ----------------------------
DROP TABLE IF EXISTS `substitutionlink`;
CREATE TABLE `substitutionlink`  (
  `SubstitutionLinkNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PlanNum` bigint(20) NOT NULL,
  `CodeNum` bigint(20) NOT NULL,
  `SubstitutionCode` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SubstOnlyIf` int(11) NOT NULL,
  PRIMARY KEY (`SubstitutionLinkNum`) USING BTREE,
  INDEX `PlanNum`(`PlanNum`) USING BTREE,
  INDEX `CodeNum`(`CodeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `SupplierNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CustomerId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Website` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `UserName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SupplierNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for supply
-- ----------------------------
DROP TABLE IF EXISTS `supply`;
CREATE TABLE `supply`  (
  `SupplyNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SupplierNum` bigint(20) NOT NULL,
  `CatalogNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Category` bigint(20) NOT NULL,
  `ItemOrder` int(11) NOT NULL,
  `LevelDesired` float NOT NULL,
  `IsHidden` tinyint(1) NOT NULL,
  `Price` double NOT NULL,
  `BarCodeOrID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DispDefaultQuant` float NOT NULL,
  `DispUnitsCount` int(11) NOT NULL,
  `DispUnitDesc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LevelOnHand` float NOT NULL,
  `OrderQty` int(11) NOT NULL,
  PRIMARY KEY (`SupplyNum`) USING BTREE,
  INDEX `SupplierNum`(`SupplierNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for supplyneeded
-- ----------------------------
DROP TABLE IF EXISTS `supplyneeded`;
CREATE TABLE `supplyneeded`  (
  `SupplyNeededNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DateAdded` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`SupplyNeededNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for supplyorder
-- ----------------------------
DROP TABLE IF EXISTS `supplyorder`;
CREATE TABLE `supplyorder`  (
  `SupplyOrderNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SupplierNum` bigint(20) NOT NULL,
  `DatePlaced` date NOT NULL DEFAULT '0001-01-01',
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `AmountTotal` double NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `ShippingCharge` double NOT NULL,
  `DateReceived` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`SupplyOrderNum`) USING BTREE,
  INDEX `SupplierNum`(`SupplierNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for supplyorderitem
-- ----------------------------
DROP TABLE IF EXISTS `supplyorderitem`;
CREATE TABLE `supplyorderitem`  (
  `SupplyOrderItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SupplyOrderNum` bigint(20) NOT NULL,
  `SupplyNum` bigint(20) NOT NULL,
  `Qty` int(11) NOT NULL,
  `Price` double NOT NULL,
  `DateReceived` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`SupplyOrderItemNum`) USING BTREE,
  INDEX `SupplyOrderNum`(`SupplyOrderNum`) USING BTREE,
  INDEX `SupplyNum`(`SupplyNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `TaskNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TaskListNum` bigint(20) NOT NULL,
  `DateTask` date NOT NULL DEFAULT '0001-01-01',
  `KeyNum` bigint(20) NOT NULL,
  `Descript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `TaskStatus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `IsRepeating` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `DateType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `FromNum` bigint(20) NOT NULL,
  `ObjectType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `UserNum` bigint(20) NOT NULL,
  `DateTimeFinished` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `PriorityDefNum` bigint(20) NOT NULL,
  `ReminderGroupId` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ReminderType` smallint(6) NOT NULL,
  `ReminderFrequency` int(11) NOT NULL,
  `DateTimeOriginal` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DescriptOverride` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsReadOnly` tinyint(1) NOT NULL DEFAULT 0,
  `Category` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`TaskNum`) USING BTREE,
  INDEX `indexTaskListNum`(`TaskListNum`) USING BTREE,
  INDEX `KeyNum`(`KeyNum`) USING BTREE,
  INDEX `PriorityDefNum`(`PriorityDefNum`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE,
  INDEX `DateTimeOriginal`(`DateTimeOriginal`) USING BTREE,
  INDEX `TaskStatus`(`TaskStatus`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `TriageCategory`(`Category`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for taskancestor
-- ----------------------------
DROP TABLE IF EXISTS `taskancestor`;
CREATE TABLE `taskancestor`  (
  `TaskAncestorNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TaskNum` bigint(20) NOT NULL,
  `TaskListNum` bigint(20) NOT NULL,
  PRIMARY KEY (`TaskAncestorNum`) USING BTREE,
  INDEX `TaskNum`(`TaskNum`) USING BTREE,
  INDEX `TaskListCov`(`TaskListNum`, `TaskNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for taskattachment
-- ----------------------------
DROP TABLE IF EXISTS `taskattachment`;
CREATE TABLE `taskattachment`  (
  `TaskAttachmentNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TaskNum` bigint(20) NOT NULL,
  `DocNum` bigint(20) NOT NULL,
  `TextValue` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`TaskAttachmentNum`) USING BTREE,
  INDEX `TaskNum`(`TaskNum`) USING BTREE,
  INDEX `DocNum`(`DocNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for taskhist
-- ----------------------------
DROP TABLE IF EXISTS `taskhist`;
CREATE TABLE `taskhist`  (
  `TaskHistNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNumHist` bigint(20) NOT NULL,
  `DateTStamp` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `IsNoteChange` tinyint(4) NOT NULL,
  `TaskNum` bigint(20) NOT NULL,
  `TaskListNum` bigint(20) NOT NULL,
  `DateTask` date NOT NULL DEFAULT '0001-01-01',
  `KeyNum` bigint(20) NOT NULL,
  `Descript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TaskStatus` tinyint(4) NOT NULL,
  `IsRepeating` tinyint(4) NOT NULL,
  `DateType` tinyint(4) NOT NULL,
  `FromNum` bigint(20) NOT NULL,
  `ObjectType` tinyint(4) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `UserNum` bigint(20) NOT NULL,
  `DateTimeFinished` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `PriorityDefNum` bigint(20) NOT NULL,
  `ReminderGroupId` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ReminderType` smallint(6) NOT NULL,
  `ReminderFrequency` int(11) NOT NULL,
  `DateTimeOriginal` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DescriptOverride` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsReadOnly` tinyint(1) NOT NULL DEFAULT 0,
  `Category` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`TaskHistNum`) USING BTREE,
  INDEX `TaskNum`(`TaskNum`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE,
  INDEX `DateTStamp`(`DateTStamp`) USING BTREE,
  INDEX `KeyNum`(`KeyNum`) USING BTREE,
  INDEX `TriageCategory`(`Category`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tasklist
-- ----------------------------
DROP TABLE IF EXISTS `tasklist`;
CREATE TABLE `tasklist`  (
  `TaskListNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Descript` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Parent` bigint(20) NOT NULL,
  `DateTL` date NOT NULL DEFAULT '0001-01-01',
  `IsRepeating` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `DateType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `FromNum` bigint(20) NOT NULL,
  `ObjectType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `GlobalTaskFilterType` tinyint(4) NOT NULL,
  `TaskListStatus` tinyint(4) NOT NULL,
  PRIMARY KEY (`TaskListNum`) USING BTREE,
  INDEX `indexParent`(`Parent`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tasknote
-- ----------------------------
DROP TABLE IF EXISTS `tasknote`;
CREATE TABLE `tasknote`  (
  `TaskNoteNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TaskNum` bigint(20) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `DateTimeNote` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`TaskNoteNum`) USING BTREE,
  INDEX `TaskNum`(`TaskNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tasksubscription
-- ----------------------------
DROP TABLE IF EXISTS `tasksubscription`;
CREATE TABLE `tasksubscription`  (
  `TaskSubscriptionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `TaskListNum` bigint(20) NOT NULL,
  `TaskNum` bigint(20) NOT NULL,
  PRIMARY KEY (`TaskSubscriptionNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `TaskNum`(`TaskNum`) USING BTREE,
  INDEX `TaskListNum`(`TaskListNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for taskunread
-- ----------------------------
DROP TABLE IF EXISTS `taskunread`;
CREATE TABLE `taskunread`  (
  `TaskUnreadNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TaskNum` bigint(20) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  PRIMARY KEY (`TaskUnreadNum`) USING BTREE,
  INDEX `TaskNum`(`TaskNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for terminalactive
-- ----------------------------
DROP TABLE IF EXISTS `terminalactive`;
CREATE TABLE `terminalactive`  (
  `TerminalActiveNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ComputerName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `TerminalStatus` tinyint(3) UNSIGNED NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `SessionId` int(11) NOT NULL,
  `ProcessId` int(11) NOT NULL,
  `SessionName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`TerminalActiveNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for timeadjust
-- ----------------------------
DROP TABLE IF EXISTS `timeadjust`;
CREATE TABLE `timeadjust`  (
  `TimeAdjustNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EmployeeNum` bigint(20) NOT NULL,
  `TimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `RegHours` time NOT NULL DEFAULT '00:00:00',
  `OTimeHours` time NOT NULL DEFAULT '00:00:00',
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsAuto` tinyint(4) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `PtoDefNum` bigint(20) NOT NULL DEFAULT 0,
  `PtoHours` time NOT NULL DEFAULT '00:00:00',
  `IsUnpaidProtectedLeave` tinyint(4) NOT NULL DEFAULT 0,
  `SecuUserNumEntry` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`TimeAdjustNum`) USING BTREE,
  INDEX `indexEmployeeNum`(`EmployeeNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PtoDefNum`(`PtoDefNum`) USING BTREE,
  INDEX `SecuUserNumEntry`(`SecuUserNumEntry`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for timecardrule
-- ----------------------------
DROP TABLE IF EXISTS `timecardrule`;
CREATE TABLE `timecardrule`  (
  `TimeCardRuleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `EmployeeNum` bigint(20) NOT NULL,
  `OverHoursPerDay` time NOT NULL,
  `AfterTimeOfDay` time NOT NULL,
  `BeforeTimeOfDay` time NOT NULL,
  `IsOvertimeExempt` tinyint(4) NOT NULL,
  `MinClockInTime` time NOT NULL,
  `HasWeekendRate3` tinyint(4) NOT NULL,
  PRIMARY KEY (`TimeCardRuleNum`) USING BTREE,
  INDEX `EmployeeNum`(`EmployeeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for toolbutitem
-- ----------------------------
DROP TABLE IF EXISTS `toolbutitem`;
CREATE TABLE `toolbutitem`  (
  `ToolButItemNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProgramNum` bigint(20) NOT NULL,
  `ToolBar` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `ButtonText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`ToolButItemNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 117 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for toothgridcell
-- ----------------------------
DROP TABLE IF EXISTS `toothgridcell`;
CREATE TABLE `toothgridcell`  (
  `ToothGridCellNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SheetFieldNum` bigint(20) NOT NULL,
  `ToothGridColNum` bigint(20) NOT NULL,
  `ValueEntered` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ToothNum` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ToothGridCellNum`) USING BTREE,
  INDEX `SheetFieldNum`(`SheetFieldNum`) USING BTREE,
  INDEX `ToothGridColNum`(`ToothGridColNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for toothgridcol
-- ----------------------------
DROP TABLE IF EXISTS `toothgridcol`;
CREATE TABLE `toothgridcol`  (
  `ToothGridColNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `SheetFieldNum` bigint(20) NOT NULL,
  `NameItem` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CellType` tinyint(4) NOT NULL,
  `ItemOrder` smallint(6) NOT NULL,
  `ColumnWidth` smallint(6) NOT NULL,
  `CodeNum` bigint(20) NOT NULL,
  `ProcStatus` tinyint(4) NOT NULL,
  PRIMARY KEY (`ToothGridColNum`) USING BTREE,
  INDEX `SheetFieldNum`(`SheetFieldNum`) USING BTREE,
  INDEX `CodeNum`(`CodeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for toothgriddef
-- ----------------------------
DROP TABLE IF EXISTS `toothgriddef`;
CREATE TABLE `toothgriddef`  (
  `ToothGridDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `NameInternal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NameShowing` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CellType` tinyint(4) NOT NULL,
  `ItemOrder` smallint(6) NOT NULL,
  `ColumnWidth` smallint(6) NOT NULL,
  `CodeNum` bigint(20) NOT NULL,
  `ProcStatus` tinyint(4) NOT NULL,
  `SheetFieldDefNum` bigint(20) NOT NULL,
  PRIMARY KEY (`ToothGridDefNum`) USING BTREE,
  INDEX `CodeNum`(`CodeNum`) USING BTREE,
  INDEX `SheetFieldDefNum`(`SheetFieldDefNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for toothinitial
-- ----------------------------
DROP TABLE IF EXISTS `toothinitial`;
CREATE TABLE `toothinitial`  (
  `ToothInitialNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ToothNum` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `InitialType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Movement` float NOT NULL DEFAULT 0,
  `DrawingSegment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ColorDraw` int(11) NOT NULL,
  `SecDateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `DrawText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ToothInitialNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `SecDateTEntry`(`SecDateTEntry`) USING BTREE,
  INDEX `SecDateTEdit`(`SecDateTEdit`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 190 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction`  (
  `TransactionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `UserNum` bigint(20) NOT NULL,
  `DepositNum` bigint(20) NOT NULL,
  `PayNum` bigint(20) NOT NULL,
  `SecUserNumEdit` bigint(20) NOT NULL,
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `TransactionInvoiceNum` bigint(20) NOT NULL,
  PRIMARY KEY (`TransactionNum`) USING BTREE,
  INDEX `SecUserNumEdit`(`SecUserNumEdit`) USING BTREE,
  INDEX `TransactionInvoiceNum`(`TransactionInvoiceNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for transactioninvoice
-- ----------------------------
DROP TABLE IF EXISTS `transactioninvoice`;
CREATE TABLE `transactioninvoice`  (
  `TransactionInvoiceNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `InvoiceData` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FilePath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`TransactionInvoiceNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for treatplan
-- ----------------------------
DROP TABLE IF EXISTS `treatplan`;
CREATE TABLE `treatplan`  (
  `TreatPlanNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `DateTP` date NOT NULL DEFAULT '0001-01-01',
  `Heading` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Signature` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `SigIsTopaz` tinyint(1) NOT NULL,
  `ResponsParty` bigint(20) NOT NULL,
  `DocNum` bigint(20) NOT NULL,
  `TPStatus` tinyint(4) NOT NULL,
  `SecUserNumEntry` bigint(20) NOT NULL,
  `SecDateEntry` date NOT NULL DEFAULT '0001-01-01',
  `SecDateTEdit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `UserNumPresenter` bigint(20) NOT NULL,
  `TPType` tinyint(4) NOT NULL,
  `SignaturePractice` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTSigned` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTPracticeSigned` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SignatureText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SignaturePracticeText` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MobileAppDeviceNum` bigint(20) NOT NULL,
  PRIMARY KEY (`TreatPlanNum`) USING BTREE,
  INDEX `indexPatNum`(`PatNum`) USING BTREE,
  INDEX `DocNum`(`DocNum`) USING BTREE,
  INDEX `SecUserNumEntry`(`SecUserNumEntry`) USING BTREE,
  INDEX `UserNumPresenter`(`UserNumPresenter`) USING BTREE,
  INDEX `MobileAppDeviceNum`(`MobileAppDeviceNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for treatplanattach
-- ----------------------------
DROP TABLE IF EXISTS `treatplanattach`;
CREATE TABLE `treatplanattach`  (
  `TreatPlanAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TreatPlanNum` bigint(20) NOT NULL,
  `ProcNum` bigint(20) NOT NULL,
  `Priority` bigint(20) NOT NULL,
  PRIMARY KEY (`TreatPlanAttachNum`) USING BTREE,
  INDEX `TreatPlanNum`(`TreatPlanNum`) USING BTREE,
  INDEX `ProcNum`(`ProcNum`) USING BTREE,
  INDEX `Priority`(`Priority`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 29 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for treatplanparam
-- ----------------------------
DROP TABLE IF EXISTS `treatplanparam`;
CREATE TABLE `treatplanparam`  (
  `TreatPlanParamNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `TreatPlanNum` bigint(20) NOT NULL,
  `ShowDiscount` tinyint(4) NOT NULL,
  `ShowMaxDed` tinyint(4) NOT NULL,
  `ShowSubTotals` tinyint(4) NOT NULL,
  `ShowTotals` tinyint(4) NOT NULL,
  `ShowCompleted` tinyint(4) NOT NULL,
  `ShowFees` tinyint(4) NOT NULL,
  `ShowIns` tinyint(4) NOT NULL,
  PRIMARY KEY (`TreatPlanParamNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `TreatPlanNum`(`TreatPlanNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for tsitranslog
-- ----------------------------
DROP TABLE IF EXISTS `tsitranslog`;
CREATE TABLE `tsitranslog`  (
  `TsiTransLogNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `TransType` tinyint(4) NOT NULL,
  `TransDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ServiceType` tinyint(4) NOT NULL,
  `ServiceCode` tinyint(4) NOT NULL,
  `TransAmt` double NOT NULL,
  `AccountBalance` double NOT NULL,
  `FKeyType` tinyint(4) NOT NULL,
  `FKey` bigint(20) NOT NULL,
  `RawMsgText` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClientId` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TransJson` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `AggTransLogNum` bigint(20) NOT NULL,
  PRIMARY KEY (`TsiTransLogNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `FKeyAndType`(`FKey`, `FKeyType`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `AggTransLogNum`(`AggTransLogNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ucum
-- ----------------------------
DROP TABLE IF EXISTS `ucum`;
CREATE TABLE `ucum`  (
  `UcumNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UcumCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsInUse` tinyint(4) NOT NULL,
  PRIMARY KEY (`UcumNum`) USING BTREE,
  INDEX `UcumCode`(`UcumCode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for updatehistory
-- ----------------------------
DROP TABLE IF EXISTS `updatehistory`;
CREATE TABLE `updatehistory`  (
  `UpdateHistoryNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateTimeUpdated` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ProgramVersion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Signature` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`UpdateHistoryNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for userclinic
-- ----------------------------
DROP TABLE IF EXISTS `userclinic`;
CREATE TABLE `userclinic`  (
  `UserClinicNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  PRIMARY KEY (`UserClinicNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for usergroup
-- ----------------------------
DROP TABLE IF EXISTS `usergroup`;
CREATE TABLE `usergroup`  (
  `UserGroupNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `UserGroupNumCEMT` bigint(20) NOT NULL,
  PRIMARY KEY (`UserGroupNum`) USING BTREE,
  INDEX `UserGroupNumCEMT`(`UserGroupNumCEMT`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for usergroupattach
-- ----------------------------
DROP TABLE IF EXISTS `usergroupattach`;
CREATE TABLE `usergroupattach`  (
  `UserGroupAttachNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `UserGroupNum` bigint(20) NOT NULL,
  PRIMARY KEY (`UserGroupAttachNum`) USING BTREE,
  INDEX `UserGroupNum`(`UserGroupNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for userod
-- ----------------------------
DROP TABLE IF EXISTS `userod`;
CREATE TABLE `userod`  (
  `UserNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `Password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `UserGroupNum` bigint(20) NOT NULL,
  `EmployeeNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `IsHidden` tinyint(1) NOT NULL,
  `TaskListInBox` bigint(20) NOT NULL,
  `AnesthProvType` int(2) NOT NULL DEFAULT 3,
  `DefaultHidePopups` tinyint(4) NOT NULL,
  `PasswordIsStrong` tinyint(4) NOT NULL,
  `ClinicIsRestricted` tinyint(4) NOT NULL,
  `InboxHidePopups` tinyint(4) NOT NULL,
  `UserNumCEMT` bigint(20) NOT NULL,
  `DateTFail` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `FailedAttempts` tinyint(3) UNSIGNED NOT NULL,
  `DomainUser` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsPasswordResetRequired` tinyint(4) NOT NULL,
  `MobileWebPin` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MobileWebPinFailedAttempts` tinyint(3) UNSIGNED NOT NULL,
  `DateTLastLogin` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `EClipboardClinicalPin` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BadgeId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`UserNum`) USING BTREE,
  INDEX `UserGroupNum`(`UserGroupNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for userodapptview
-- ----------------------------
DROP TABLE IF EXISTS `userodapptview`;
CREATE TABLE `userodapptview`  (
  `UserodApptViewNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `ApptViewNum` bigint(20) NOT NULL,
  PRIMARY KEY (`UserodApptViewNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `ApptViewNum`(`ApptViewNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for userodpref
-- ----------------------------
DROP TABLE IF EXISTS `userodpref`;
CREATE TABLE `userodpref`  (
  `UserOdPrefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `Fkey` bigint(20) NOT NULL,
  `FkeyType` tinyint(4) NOT NULL,
  `ValueString` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  PRIMARY KEY (`UserOdPrefNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `Fkey`(`Fkey`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for userquery
-- ----------------------------
DROP TABLE IF EXISTS `userquery`;
CREATE TABLE `userquery`  (
  `QueryNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `FileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `QueryText` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsReleased` tinyint(4) NULL DEFAULT 0,
  `IsPromptSetup` tinyint(4) NOT NULL DEFAULT 1,
  `DefaultFormatRaw` tinyint(4) NOT NULL,
  PRIMARY KEY (`QueryNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 49 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for userweb
-- ----------------------------
DROP TABLE IF EXISTS `userweb`;
CREATE TABLE `userweb`  (
  `UserWebNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `FKey` bigint(20) NOT NULL,
  `FKeyType` tinyint(4) NOT NULL,
  `UserName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PasswordResetCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RequireUserNameChange` tinyint(4) NOT NULL,
  `DateTimeLastLogin` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `RequirePasswordChange` tinyint(4) NOT NULL,
  PRIMARY KEY (`UserWebNum`) USING BTREE,
  INDEX `FKey`(`FKey`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for utm
-- ----------------------------
DROP TABLE IF EXISTS `utm`;
CREATE TABLE `utm`  (
  `UtmNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CampaignName` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MediumInfo` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SourceInfo` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`UtmNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for vaccinedef
-- ----------------------------
DROP TABLE IF EXISTS `vaccinedef`;
CREATE TABLE `vaccinedef`  (
  `VaccineDefNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `CVXCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `VaccineName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DrugManufacturerNum` bigint(20) NOT NULL,
  PRIMARY KEY (`VaccineDefNum`) USING BTREE,
  INDEX `DrugManufacturerNum`(`DrugManufacturerNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for vaccineobs
-- ----------------------------
DROP TABLE IF EXISTS `vaccineobs`;
CREATE TABLE `vaccineobs`  (
  `VaccineObsNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `VaccinePatNum` bigint(20) NOT NULL,
  `ValType` tinyint(4) NOT NULL,
  `IdentifyingCode` tinyint(4) NOT NULL,
  `ValReported` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ValCodeSystem` tinyint(4) NOT NULL,
  `VaccineObsNumGroup` bigint(20) NOT NULL,
  `UcumCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateObs` date NOT NULL DEFAULT '0001-01-01',
  `MethodCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`VaccineObsNum`) USING BTREE,
  INDEX `VaccinePatNum`(`VaccinePatNum`) USING BTREE,
  INDEX `VaccineObsNumGroup`(`VaccineObsNumGroup`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for vaccinepat
-- ----------------------------
DROP TABLE IF EXISTS `vaccinepat`;
CREATE TABLE `vaccinepat`  (
  `VaccinePatNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `VaccineDefNum` bigint(20) NOT NULL,
  `DateTimeStart` datetime NULL DEFAULT NULL,
  `DateTimeEnd` datetime NULL DEFAULT NULL,
  `AdministeredAmt` float NOT NULL,
  `DrugUnitNum` bigint(20) NOT NULL,
  `LotNumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `Note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FilledCity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FilledST` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CompletionStatus` tinyint(4) NOT NULL,
  `AdministrationNoteCode` tinyint(4) NOT NULL,
  `UserNum` bigint(20) NOT NULL,
  `ProvNumOrdering` bigint(20) NOT NULL,
  `ProvNumAdminister` bigint(20) NOT NULL,
  `DateExpire` date NOT NULL DEFAULT '0001-01-01',
  `RefusalReason` tinyint(4) NOT NULL,
  `ActionCode` tinyint(4) NOT NULL,
  `AdministrationRoute` tinyint(4) NOT NULL,
  `AdministrationSite` tinyint(4) NOT NULL,
  PRIMARY KEY (`VaccinePatNum`) USING BTREE,
  INDEX `VaccineDefNum`(`VaccineDefNum`) USING BTREE,
  INDEX `DrugUnitNum`(`DrugUnitNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE,
  INDEX `ProvNumOrdering`(`ProvNumOrdering`) USING BTREE,
  INDEX `ProvNumAdminister`(`ProvNumAdminister`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for vitalsign
-- ----------------------------
DROP TABLE IF EXISTS `vitalsign`;
CREATE TABLE `vitalsign`  (
  `VitalsignNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `Height` float NOT NULL,
  `Weight` float NOT NULL,
  `BpSystolic` smallint(6) NOT NULL,
  `BpDiastolic` smallint(6) NOT NULL,
  `DateTaken` date NOT NULL DEFAULT '0001-01-01',
  `HasFollowupPlan` tinyint(4) NOT NULL,
  `IsIneligible` tinyint(4) NOT NULL,
  `Documentation` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ChildGotNutrition` tinyint(4) NOT NULL,
  `ChildGotPhysCouns` tinyint(4) NOT NULL,
  `WeightCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HeightExamCode` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeightExamCode` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BMIExamCode` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EhrNotPerformedNum` bigint(20) NOT NULL,
  `PregDiseaseNum` bigint(20) NOT NULL,
  `BMIPercentile` int(11) NOT NULL,
  `Pulse` int(11) NOT NULL,
  PRIMARY KEY (`VitalsignNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `WeightCode`(`WeightCode`) USING BTREE,
  INDEX `EhrNotPerformedNum`(`EhrNotPerformedNum`) USING BTREE,
  INDEX `PregDiseaseNum`(`PregDiseaseNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for webschedcarrierrule
-- ----------------------------
DROP TABLE IF EXISTS `webschedcarrierrule`;
CREATE TABLE `webschedcarrierrule`  (
  `WebSchedCarrierRuleNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `CarrierName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DisplayName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Message` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Rule` tinyint(4) NOT NULL,
  PRIMARY KEY (`WebSchedCarrierRuleNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for webschedrecall
-- ----------------------------
DROP TABLE IF EXISTS `webschedrecall`;
CREATE TABLE `webschedrecall`  (
  `WebSchedRecallNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClinicNum` bigint(20) NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `RecallNum` bigint(20) NOT NULL,
  `DateTimeEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateDue` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `ReminderCount` int(11) NOT NULL,
  `DateTimeSent` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTimeSendFailed` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `SendStatus` tinyint(4) NOT NULL,
  `ShortGUID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ResponseDescript` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Source` tinyint(4) NOT NULL,
  `CommlogNum` bigint(20) NOT NULL,
  `MessageType` tinyint(4) NOT NULL,
  `MessageFk` bigint(20) NOT NULL,
  `ApptReminderRuleNum` bigint(20) NOT NULL,
  PRIMARY KEY (`WebSchedRecallNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `RecallNum`(`RecallNum`) USING BTREE,
  INDEX `DateTimeReminderSent`(`DateTimeSent`) USING BTREE,
  INDEX `CommlogNum`(`CommlogNum`) USING BTREE,
  INDEX `MessageFk`(`MessageFk`) USING BTREE,
  INDEX `ApptReminderRuleNum`(`ApptReminderRuleNum`) USING BTREE,
  INDEX `DateTimeEntry`(`DateTimeEntry`) USING BTREE,
  INDEX `WebSchedRecallCovering`(`MessageType`, `SendStatus`, `ClinicNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wikilistheaderwidth
-- ----------------------------
DROP TABLE IF EXISTS `wikilistheaderwidth`;
CREATE TABLE `wikilistheaderwidth`  (
  `WikiListHeaderWidthNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ListName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ColName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ColWidth` int(11) NOT NULL,
  `PickList` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `IsHidden` tinyint(4) NOT NULL,
  PRIMARY KEY (`WikiListHeaderWidthNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wikilisthist
-- ----------------------------
DROP TABLE IF EXISTS `wikilisthist`;
CREATE TABLE `wikilisthist`  (
  `WikiListHistNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `ListName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ListHeaders` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ListContent` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeSaved` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  PRIMARY KEY (`WikiListHistNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wikipage
-- ----------------------------
DROP TABLE IF EXISTS `wikipage`;
CREATE TABLE `wikipage`  (
  `WikiPageNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `PageTitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `KeyWords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PageContent` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeSaved` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `IsDraft` tinyint(4) NOT NULL,
  `IsLocked` tinyint(4) NOT NULL,
  `IsDeleted` tinyint(4) NOT NULL DEFAULT 0,
  `PageContentPlainText` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`WikiPageNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wikipagehist
-- ----------------------------
DROP TABLE IF EXISTS `wikipagehist`;
CREATE TABLE `wikipagehist`  (
  `WikiPageNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserNum` bigint(20) NOT NULL,
  `PageTitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PageContent` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DateTimeSaved` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `IsDeleted` tinyint(4) NOT NULL,
  PRIMARY KEY (`WikiPageNum`) USING BTREE,
  INDEX `UserNum`(`UserNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xchargetransaction
-- ----------------------------
DROP TABLE IF EXISTS `xchargetransaction`;
CREATE TABLE `xchargetransaction`  (
  `XChargeTransactionNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TransType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Amount` double NOT NULL,
  `CCEntry` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PatNum` bigint(20) NOT NULL,
  `Result` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ClerkID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ResultCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Expiration` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CCType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CreditCardNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BatchNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ItemNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ApprCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TransactionDateTime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `BatchTotal` double NOT NULL,
  PRIMARY KEY (`XChargeTransactionNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `TransactionDateTime`(`TransactionDateTime`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xwebresponse
-- ----------------------------
DROP TABLE IF EXISTS `xwebresponse`;
CREATE TABLE `xwebresponse`  (
  `XWebResponseNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatNum` bigint(20) NOT NULL,
  `ProvNum` bigint(20) NOT NULL,
  `ClinicNum` bigint(20) NOT NULL,
  `PaymentNum` bigint(20) NOT NULL,
  `DateTEntry` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `DateTUpdate` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TransactionStatus` tinyint(4) NOT NULL,
  `ResponseCode` int(11) NOT NULL,
  `XWebResponseCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ResponseDescription` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OTK` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HpfUrl` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HpfExpiration` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `TransactionID` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TransactionType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Alias` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CardType` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CardBrand` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CardBrandShort` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MaskedAcctNum` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Amount` double NOT NULL,
  `ApprovalCode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CardCodeResponse` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ReceiptID` int(11) NOT NULL,
  `ExpDate` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EntryMethod` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProcessorResponse` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BatchNum` int(11) NOT NULL,
  `BatchAmount` double NOT NULL,
  `AccountExpirationDate` date NOT NULL DEFAULT '0001-01-01',
  `DebugError` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PayNote` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CCSource` tinyint(4) NOT NULL,
  `OrderId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `EmailResponse` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LogGuid` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`XWebResponseNum`) USING BTREE,
  INDEX `PatNum`(`PatNum`) USING BTREE,
  INDEX `ProvNum`(`ProvNum`) USING BTREE,
  INDEX `ClinicNum`(`ClinicNum`) USING BTREE,
  INDEX `PaymentNum`(`PaymentNum`) USING BTREE,
  INDEX `DateTUpdate`(`DateTUpdate`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for zipcode
-- ----------------------------
DROP TABLE IF EXISTS `zipcode`;
CREATE TABLE `zipcode`  (
  `ZipCodeNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `ZipCodeDigits` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `City` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `State` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `IsFrequent` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`ZipCodeNum`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
