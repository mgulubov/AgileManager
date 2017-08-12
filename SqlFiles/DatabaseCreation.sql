------------------------------
-- Create database if it doesn't exist
------------
USE master;
GO
------------
IF NOT EXISTS (
	SELECT
		name
	FROM
		sys.databases
	WHERE
		name = 'AgileManager'
)
	BEGIN
		CREATE DATABASE AgileManager
	END
GO
------------
------------------------------
-- Drop constraints
------------
USE AgileManager
GO
------------
IF OBJECT_ID('ProductBacklogEntries', 'U') IS NOT NULL
BEGIN
	ALTER TABLE
		ProductBacklogEntries
	DROP CONSTRAINT IF EXISTS
		DEF_product_backlog_entries_product_backlog_entry_status_id,
		DEF_product_backlog_entries_created_datetime,
		DEF_product_backlog_entries_last_modified_datetime,
		DEF_product_backlog_entries_is_active,
		PK_product_backlog_entries,
		CHK_product_backlog_entries_not_null_user_story_id,
		CHK_product_backlog_entries_not_null_created_by_user_id,
		CHK_product_backlog_entries_not_null_last_modified_by_user_id,
		CHK_product_backlog_entries_not_null_product_backlog_entry_status_id,
		CHK_product_backlog_entries_not_null_created_datetime,
		CHK_product_backlog_entries_not_null_last_modified_datetime,
		CHK_product_backlog_entries_not_null_user_is_active,
		CHK_product_backlog_entries_not_null_user_stitle,
		CHK_product_backlog_entries_not_null_user_description,
		FK_product_backlog_entries_product_backlog_entry_status_id_product_backlog_entry_statuses_id,
		FK_product_backlog_entries_user_story_id_user_stories_id,
		FK_product_backlog_entries_created_by_user_id_users_id,
		FK_product_backlog_entries_last_modified_by_user_id_users_id,
		FK_product_backlog_entries_assigned_to_user_id_users_id
END
GO
------------
IF OBJECT_ID('ProductBacklogEntryStatuses', 'U') IS NOT NULL
BEGIN
	ALTER TABLE
		ProductBacklogEntryStatuses
	DROP CONSTRAINT IF EXISTS
		PK_product_backlog_entry_statuses,
		CHK_product_backlog_entry_statuses_not_null_name
END
GO
------------
IF OBJECT_ID('UserStories', 'U') IS NOT NULL
BEGIN
	ALTER TABLE
		UserStories
	DROP CONSTRAINT IF EXISTS
		DEF_user_stories_created_datetime,
		DEF_user_stories_last_modified_datetime,
		DEF_user_stories_is_active,
		PK_user_stories,
		CHK_user_stories_not_null_epic_id,
		CHK_user_stories_not_null_created_by_user_id,
		CHK_user_stories_not_null_last_modified_by_user_id,
		CHK_user_stories_not_null_created_datetime,
		CHK_user_stories_not_null_last_modified_datetime,
		CHK_user_stories_not_null_is_active,
		CHK_user_stories_not_null_title,
		CHK_user_stories_not_null_description,
		FK_user_stories_epic_id_epics_id,
		FK_user_stories_created_by_user_id_users_id,
		FK_user_stories_lasty_modified_by_user_id_users_id
END
GO
------------
IF OBJECT_ID('ProductBacklogs', 'U') IS NOT NULL
BEGIN
	ALTER TABLE
		ProductBacklogs
	DROP CONSTRAINT IF EXISTS
		PK_product_backlogs,
		DEF_product_backlogs_created_datetime,
		DEF_product_backlogs_last_modified_datetime,
		DEF_product_backlogs_is_active,
		CHK_product_backlogs_not_null_project_id,
		CHK_product_backlogs_not_null_created_by_user_id,
		CHK_product_backlogs_not_null_last_modified_by_user_id,
		CHK_product_backlogs_not_null_created_datetime,
		CHK_product_backlogs_not_null_last_modified_datetime,
		CHK_product_backlogs_not_null_is_active,
		FK_product_backlogs_project_id_projects_id,
		FK_product_backlogs_created_by_user_id_users_id,
		FK_product_backlogs_last_modified_by_user_id
END
GO
------------
IF OBJECT_ID('Epics', 'U') IS NOT NULL
BEGIN
	ALTER TABLE
		Epics
	DROP CONSTRAINT IF EXISTS
		DEF_epics_is_active,
		DEF_epics_created_datetime,
		DEF_epics_last_modified_datetime,
		PK_epics,
		CHK_epics_not_null_project_id,
		CHK_epics_not_null_created_by_user_id,
		CHK_epics_not_null_last_modified_by_user_id,
		CHK_epics_not_null_created_datetime,
		CHK_epics_not_null_last_modified_datetime,
		CHK_epics_not_null_title,
		CHK_epics_not_null_description,
		CHK_epics_not_null_is_active,
		FK_epics_project_id_projects_id,
		FK_epics_created_by_user_id_users_id,
		FK_epics_last_modified_by_user_id_users_id
END
GO
------------
IF OBJECT_ID('TeamMembers', 'U') IS NOT NULL
BEGIN
	ALTER TABLE
		TeamMembers
	DROP CONSTRAINT IF EXISTS
		PK_team_members,
		CHK_team_members_not_null_user_id,
		CHK_team_members_not_null_project_id,
		FK_team_members_user_id_users_id,
		FK_team_members_project_id_projects_id
END
GO
------------
IF OBJECT_ID('Projects', 'U') IS NOT NULL
BEGIN
	ALTER TABLE 
		Projects
	DROP CONSTRAINT IF EXISTS
		PK_projects,
		CHK_projects_not_null_name,
		CHK_projects_not_null_created_time,
		CHK_projects_not_null_is_active,
		CHK_projects_not_null_product_owner_user_id,
		CHK_projects_not_null_scrum_master_user_id,
		DEF_projects_created_date_time,
		DEF_projects_is_active,
		FK_projects_product_owner_user_id_users_id,
		FK_projects_scrum_master_user_id_users_id
END
GO
------------
IF OBJECT_ID('Users', 'U') IS NOT NULL
BEGIN
	ALTER TABLE
		Users
	DROP CONSTRAINT IF EXISTS 
		PK_users,
		CHK_users_not_null_username,
		CHK_users_not_null_password,
		CHK_users_not_null_firstname,
		CHK_users_not_null_lastname,
		CHK_users_not_null_email,
		UNQ_users_username,
		UNQ_users_email
END
GO
------------
------------------------------
-- Drop tables
------------
DROP TABLE IF EXISTS Users
GO
------------
DROP TABLE IF EXISTS Projects
GO
------------
DROP TABLE IF EXISTS TeamMembers
GO
------------
DROP TABLE IF EXISTS ProductBacklogs
GO
------------
DROP TABLE IF EXISTS Epics
GO
------------
DROP TABLE IF EXISTS UserStories
GO
------------
DROP TABLE IF EXISTS ProductBacklogEntries
GO
------------
DROP TABLE IF EXISTS ProductBacklogEntryStatuses
GO
------------
------------------------------
-- Create tables
------------
CREATE TABLE Users(
	Id INT IDENTITY(1,1),
	Username VARCHAR(50),
	Password VARCHAR(300),
	FirstName VARCHAR(100),
	LastName VARCHAR(100),
	Email VARCHAR(100),
	Address VARCHAR(300),
	Phone VARCHAR(100),

	CONSTRAINT PK_users PRIMARY KEY(Id),

	CONSTRAINT CHK_users_not_null_username 
		CHECK(Username IS NOT NULL),
	CONSTRAINT CHK_users_not_null_password 
		CHECK(Password IS NOT NULL),
	CONSTRAINT CHK_users_not_null_firstname 
		CHECK(FirstName IS NOT NULL),
	CONSTRAINT CHK_users_not_null_lastname 
		CHECK(LastName IS NOT NULL),
	CONSTRAINT CHK_users_not_null_email 
		CHECK(Email IS NOT NULL),

	CONSTRAINT UNQ_users_username UNIQUE(Username),
	CONSTRAINT UNQ_users_email UNIQUE(Email) 
)
------------
CREATE TABLE Projects(
	Id INT IDENTITY(1,1),
	Name VARCHAR(100),
	Description VARCHAR(500),
	CreatedDateTime DATETIME
		CONSTRAINT DEF_projects_created_date_time DEFAULT FORMAT(
			GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss'
		),
	EstimatedDeadLine DATETIME,
	CompletedDate DATETIME,
	IsActive BIT
		CONSTRAINT DEF_projects_is_active DEFAULT(1),
	ProductOwnerUserId INT,
	ScrumMasterUserId INT,

	CONSTRAINT PK_projects PRIMARY KEY(Id),

	CONSTRAINT CHK_projects_not_null_name 
		CHECK(Name IS NOT NULL),
	CONSTRAINT CHK_projects_not_null_created_time 
		CHECK(CreatedDateTime IS NOT NULL),
	CONSTRAINT CHK_projects_not_null_is_active 
		CHECK(IsActive IS NOT NULL),
	CONSTRAINT CHK_projects_not_null_product_owner_user_id 
		CHECK(ProductOwnerUserId IS NOT NULL),
	CONSTRAINT CHK_projects_not_null_scrum_master_user_id 
		CHECK(ScrumMasterUserId IS NOT NULL),

	CONSTRAINT FK_projects_product_owner_user_id_users_id
		FOREIGN KEY(ProductOwnerUserId)
		REFERENCES Users(Id),
	CONSTRAINT FK_projects_scrum_master_user_id_users_id
		FOREIGN KEY(ScrumMasterUserId)
		REFERENCES Users(Id)
)
------------
CREATE TABLE TeamMembers(
	UserId INT,
	ProjectId INT,

	CONSTRAINT PK_team_members PRIMARY KEY(UserId, ProjectId),

	CONSTRAINT CHK_team_members_not_null_user_id 
		CHECK(UserId IS NOT NULL),
	CONSTRAINT CHK_team_members_not_null_project_id 
		CHECK(ProjectId IS NOT NULL),

	CONSTRAINT FK_team_members_user_id_users_id 
		FOREIGN KEY(UserId) 
		REFERENCES Users(Id),
	CONSTRAINT FK_team_members_project_id_projects_id 
		FOREIGN KEY (ProjectId) 
		REFERENCES Projects(Id)
)
------------
CREATE TABLE ProductBacklogs(
	Id INT IDENTITY(1,1),
	ProjectId INT,
	CreatedByUserId INT,
	LastModifiedByUserId INT,
	CreatedDateTime DATETIME
		CONSTRAINT DEF_product_backlogs_created_datetime DEFAULT(
			FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss')
		),
	LastModifiedDatetime DATETIME
		CONSTRAINT DEF_product_backlogs_last_modified_datetime DEFAULT(
			FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss')
		),
	IsActive BIT
		CONSTRAINT DEF_product_backlogs_is_active DEFAULT(1),

	CONSTRAINT PK_product_backlogs PRIMARY KEY(Id),

	CONSTRAINT CHK_product_backlogs_not_null_project_id CHECK(
		ProjectId IS NOT NULL
	),
	CONSTRAINT CHK_product_backlogs_not_null_created_by_user_id CHECK(
		CreatedByUserId IS NOT NULL
	),
	CONSTRAINT CHK_product_backlogs_not_null_last_modified_by_user_id CHECK(
		LastModifiedByUserId IS NOT NULL
	),
	CONSTRAINT CHK_product_backlogs_not_null_created_datetime CHECK(
		CreatedDatetime IS NOT NULL
	),
	CONSTRAINT CHK_product_backlogs_not_null_last_modified_datetime CHECK(
		LastModifiedDatetime IS NOT NULL
	),
	CONSTRAINT CHK_product_backlogs_not_null_is_active CHECK(
		IsActive IS NOT NULL
	),

	CONSTRAINT FK_product_backlogs_project_id_projects_id
		FOREIGN KEY(ProjectId)
		REFERENCES Projects(Id),
	CONSTRAINT FK_product_backlogs_created_by_user_id_users_id
		FOREIGN KEY(CreatedByUserId)
		REFERENCES Users(Id),
	CONSTRAINT FK_product_backlogs_last_modified_by_user_id
		FOREIGN KEY(LastModifiedByUserId)
		REFERENCES Users(Id)
)
------------
CREATE TABLE Epics(
	Id INT IDENTITY(1,1),
	ProjectId INT,
	CreatedByUserId INT,
	LastModifiedByUserId INT,
	CreatedDatetime DATETIME
		CONSTRAINT DEF_epics_created_datetime DEFAULT(
			FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss')
		),
	LastModifiedDatetime DATETIME
		CONSTRAINT DEF_epics_last_modified_datetime DEFAULT(
			FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss')
		),
	Title VARCHAR(150),
	Description VARCHAR(500),
	IsActive BIT
		CONSTRAINT DEF_epics_is_active DEFAULT(1),

	CONSTRAINT PK_epics PRIMARY KEY(Id),

	CONSTRAINT CHK_epics_not_null_project_id CHECK(
		ProjectId IS NOT NULL
	),
	CONSTRAINT CHK_epics_not_null_created_by_user_id CHECK(
		CreatedByUserId IS NOT NULL
	),
	CONSTRAINT CHK_epics_not_null_last_modified_by_user_id CHECK(
		LastModifiedByUserId IS NOT NULL
	),
	CONSTRAINT CHK_epics_not_null_created_datetime CHECK(
		CreatedDatetime IS NOT NULL
	),
	CONSTRAINT CHK_epics_not_null_last_modified_datetime CHECK(
		LastModifiedDatetime IS NOT NULL
	),
	CONSTRAINT CHK_epics_not_null_title CHECK(
		Title IS NOT NULL
	),
	CONSTRAINT CHK_epics_not_null_description CHECK(
		Description IS NOT NULL
	),
	CONSTRAINT CHK_epics_not_null_is_active CHECK(
		IsActive IS NOT NULL
	),

	CONSTRAINT FK_epics_project_id_projects_id
		FOREIGN KEY(ProjectId)
		REFERENCES Projects(Id),
	CONSTRAINT FK_epics_created_by_user_id_users_id
		FOREIGN KEY(CreatedByUserId)
		REFERENCES Users(Id),
	CONSTRAINT FK_epics_last_modified_by_user_id_users_id
		FOREIGN KEY(LastModifiedByUserId)
		REFERENCES Users(Id)
)
------------
CREATE TABLE UserStories(
	Id INT IDENTITY(1,1),
	EpicId INT,
	CreatedByUserId INT,
	LastModifiedByUserId INT,
	CreatedDatetime DATETIME
		CONSTRAINT DEF_user_stories_created_datetime DEFAULT(
			FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss')
		),
	LastModifiedDatetime DATETIME
		CONSTRAINT DEF_user_stories_last_modified_datetime DEFAULT(
			FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss')
		),
	IsActive BIT
		CONSTRAINT DEF_user_stories_is_active DEFAULT 1,
	Title VARCHAR(150),
	Description VARCHAR(500),

	CONSTRAINT PK_user_stories PRIMARY KEY(Id),

	CONSTRAINT CHK_user_stories_not_null_epic_id CHECK(
		EpicId IS NOT NULL
	),
	CONSTRAINT CHK_user_stories_not_null_created_by_user_id CHECK(
		CreatedByUserId IS NOT NULL
	),
	CONSTRAINT CHK_user_stories_not_null_last_modified_by_user_id CHECK(
		LastModifiedByUserId IS NOT NULL
	),
	CONSTRAINT CHK_user_stories_not_null_created_datetime CHECK(
		CreatedDatetime IS NOT NULL
	),
	CONSTRAINT CHK_user_stories_not_null_last_modified_datetime CHECK(
		LastModifiedDatetime IS NOT NULL
	),
	CONSTRAINT CHK_user_stories_not_null_is_active CHECK(
		IsActive IS NOT NULL
	),
	CONSTRAINT CHK_user_stories_not_null_title CHECK(
		Title IS NOT NULL
	),
	CONSTRAINT CHK_user_stories_not_null_description CHECK(
		Description IS NOT NULL
	),

	CONSTRAINT FK_user_stories_epic_id_epics_id
		FOREIGN KEY(EpicId)
		REFERENCES Epics(Id),
	CONSTRAINT FK_user_stories_created_by_user_id_users_id
		FOREIGN KEY(CreatedByUserId)
		REFERENCES Users(Id),
	CONSTRAINT FK_user_stories_lasty_modified_by_user_id_users_id
		FOREIGN KEY(LastModifiedByUserId)
		REFERENCES Users(Id)
)
------------
CREATE TABLE ProductBacklogEntryStatuses(
	Id INT IDENTITY(1,1),
	Name VARCHAR(30),

	CONSTRAINT PK_product_backlog_entry_statuses PRIMARY KEY(Id),
	CONSTRAINT CHK_product_backlog_entry_statuses_not_null_name CHECK(
		Name IS NOT NULL
	)
)
------------
CREATE TABLE ProductBacklogEntries(
	Id INT IDENTITY(1,1),
	UserStoryId INT,
	CreatedByUserId INT,
	LastModifiedByUserId INT,
	AssignedToUserId INT,
	StoryPoints INT,
	ProductBacklogEntryStatusId INT
		CONSTRAINT DEF_product_backlog_entries_product_backlog_entry_status_id DEFAULT 1,
	CreatedDatetime DATETIME
		CONSTRAINT DEF_product_backlog_entries_created_datetime DEFAULT(
			FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss')
		),
	LastModifiedDatetime DATETIME
		CONSTRAINT DEF_product_backlog_entries_last_modified_datetime DEFAULT(
			FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss')
		),
	IsActive BIT
		CONSTRAINT DEF_product_backlog_entries_is_active DEFAULT 1,
	Title VARCHAR(150),
	Description VARCHAR(500),

	CONSTRAINT PK_product_backlog_entries PRIMARY KEY(Id),

	CONSTRAINT CHK_product_backlog_entries_not_null_user_story_id CHECK(
		UserStoryId IS NOT NULL
	),
	CONSTRAINT CHK_product_backlog_entries_not_null_created_by_user_id CHECK(
		CreatedByUserId IS NOT NULL
	),
	CONSTRAINT CHK_product_backlog_entries_not_null_last_modified_by_user_id CHECK(
		LastModifiedByUserId IS NOT NULL
	),
	CONSTRAINT CHK_product_backlog_entries_not_null_product_backlog_entry_status_id CHECK(
		ProductBacklogEntryStatusId IS NOT NULL
	),
	CONSTRAINT CHK_product_backlog_entries_not_null_created_datetime CHECK(
		CreatedDatetime IS NOT NULL
	),
	CONSTRAINT CHK_product_backlog_entries_not_null_last_modified_datetime CHECK(
		LastModifiedDatetime IS NOT NULL
	),
	CONSTRAINT CHK_product_backlog_entries_not_null_user_is_active CHECK(
		IsActive IS NOT NULL
	),
	CONSTRAINT CHK_product_backlog_entries_not_null_user_stitle CHECK(
		Title IS NOT NULL
	),
	CONSTRAINT CHK_product_backlog_entries_not_null_user_description CHECK(
		Description IS NOT NULL
	),

	CONSTRAINT FK_product_backlog_entries_product_backlog_entry_status_id_product_backlog_entry_statuses_id
		FOREIGN KEY(ProductBacklogEntryStatusId)
		REFERENCES ProductBacklogEntryStatuses(Id),
	CONSTRAINT FK_product_backlog_entries_user_story_id_user_stories_id
		FOREIGN KEY(UserStoryId)
		REFERENCES UserStories(Id),
	CONSTRAINT FK_product_backlog_entries_created_by_user_id_users_id
		FOREIGN KEY(CreatedByUserId)
		REFERENCES Users(Id),
	CONSTRAINT FK_product_backlog_entries_last_modified_by_user_id_users_id
		FOREIGN KEY(LastModifiedByUserId)
		REFERENCES Users(Id),
	CONSTRAINT FK_product_backlog_entries_assigned_to_user_id_users_id
		FOREIGN KEY(AssignedToUserId)
		REFERENCES Users(Id)
)
------------