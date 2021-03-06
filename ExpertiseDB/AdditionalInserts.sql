﻿-- -----------------------------------------------------
-- Data for table `expertisedb`.`ArtifactTypes`
-- -----------------------------------------------------
START TRANSACTION;
USE `expertisedb`;
INSERT INTO `expertisedb`.`ArtifactTypes` (`ArtifactTypeId`, `Name`) VALUES (1, 'File');

COMMIT;

-- -----------------------------------------------------
-- stored procedure GetDeveloperExpertiseSum(int)
-- -----------------------------------------------------
START TRANSACTION;
USE `expertisedb`;

CREATE PROCEDURE `GetDeveloperExpertiseSum`(IN repoId INT)
SELECT developerexpertises.DeveloperId, RepositoryId, sum(developerexpertisevalues.Value) AS ExSum 
FROM developerexpertises
JOIN developers
ON developerexpertises.DeveloperId = developers.DeveloperId
JOIN developerexpertisevalues
ON developerexpertises.DeveloperExpertiseId = developerexpertisevalues.DeveloperExpertiseId
WHERE RepositoryId = repoId
GROUP BY DeveloperId ORDER BY ExSum DESC;

COMMIT;

-- -----------------------------------------------------
-- stored procedure GetDevelopersForPath(varchar(255))
-- -----------------------------------------------------

START TRANSACTION;
USE `expertisedb`;

CREATE PROCEDURE `GetDevelopersForPath`(IN path VARCHAR(255))
SELECT DeveloperId, sum(IsFirstAuthor) as IsFirstAuthorCount, sum(DeliveriesCount) as DeliveriesCount FROM expertisedb.developerexpertises
JOIN expertisedb.artifacts
ON artifacts.artifactId = developerexpertises.artifactId
WHERE artifacts.Name LIKE path
GROUP BY DeveloperId;

COMMIT;

-- -----------------------------------------------------
-- stored procedure GetDevelopersWOPath()
-- -----------------------------------------------------

START TRANSACTION;
USE `expertisedb`;

CREATE PROCEDURE `GetDevelopersWOPath`()
SELECT DeveloperId, sum(IsFirstAuthor) as IsFirstAuthorCount, sum(DeliveriesCount) as DeliveriesCount FROM expertisedb.developerexpertises
JOIN expertisedb.artifacts
ON artifacts.artifactId = developerexpertises.artifactId
WHERE artifacts.Name NOT LIKE '%/%'
GROUP BY DeveloperId;

COMMIT;

-- -----------------------------------------------------
-- stored procedure GetUserForLastRevisionOfBefore(int, datetime)
-- -----------------------------------------------------

START TRANSACTION;
USE `expertisedb`;

CREATE PROCEDURE `GetUserForLastRevisionOfBefore`(IN filenameid int, IN beforeDatetime DATETIME)
SELECT User FROM filerevisions
JOIN revisions
ON revisions.revisionid = filerevisions.revisionid
WHERE filerevisions.filenameid = filenameid and time <= beforeDatetime
ORDER BY time DESC
LIMIT 1;

COMMIT;

-- -----------------------------------------------------
-- stored procedure GetUsersOfRevisionsOfBefore(int, datetime)
-- -----------------------------------------------------


START TRANSACTION;
USE `expertisedb`;

CREATE PROCEDURE `GetUsersOfRevisionsOfBefore`(IN filenameid int, IN beforeDatetime DATETIME)
SELECT User FROM filerevisions
JOIN revisions
ON revisions.revisionid = filerevisions.revisionid
WHERE filerevisions.filenameid = filenameid and time <= beforeDatetime
ORDER BY time DESC;

COMMIT;


-- -----------------------------------------------------
-- stored procedure GetActualReviewersGrouped()
-- -----------------------------------------------------


START TRANSACTION;
USE `expertisedb`;

CREATE PROCEDURE `GetActualReviewersGrouped`()
SELECT BugId, count(bugid) as Count
FROM expertisedb.actualreviewers
GROUP BY BugId

COMMIT;

-- -----------------------------------------------------
-- constraint for developerexpertisevalues
-- -----------------------------------------------------

ALTER TABLE expertisedb.developerexpertisevalues
ADD CONSTRAINT uc_identity UNIQUE (DeveloperExpertiseId,AlgorithmId);