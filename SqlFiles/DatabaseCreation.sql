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
		CHK_projects_not_null_scrum_master_user_id
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
	Phone VARCHAR(100)

	CONSTRAINT PK_users PRIMARY KEY(Id),

	CONSTRAINT CHK_users_not_null_username CHECK(Username IS NOT NULL),
	CONSTRAINT CHK_users_not_null_password CHECK(Password IS NOT NULL),
	CONSTRAINT CHK_users_not_null_firstname CHECK(FirstName IS NOT NULL),
	CONSTRAINT CHK_users_not_null_lastname CHECK(LastName IS NOT NULL),
	CONSTRAINT CHK_users_not_null_email CHECK(Email IS NOT NULL),

	CONSTRAINT UNQ_users_username UNIQUE(Username),
	CONSTRAINT UNQ_users_email UNIQUE(Email) 
)
------------
CREATE TABLE Projects(
	Id INT IDENTITY(1,1),
	Name VARCHAR(100),
	Description VARCHAR(500),
	CreatedDate DATETIME,
	CompletedDate DATETIME,
	IsActive BIT,
	ProductOwnerUserId INT,
	ScrumMasterUserId INT

	CONSTRAINT PK_projects PRIMARY KEY(Id),

	CONSTRAINT CHK_projects_not_null_name CHECK(Name IS NOT NULL),
	CONSTRAINT CHK_projects_not_null_created_time CHECK(CreatedDate IS NOT NULL),
	CONSTRAINT CHK_projects_not_null_is_active CHECK(IsActive IS NOT NULL),
	CONSTRAINT CHK_projects_not_null_product_owner_user_id CHECK(ProductOwnerUserId IS NOT NULL),
	CONSTRAINT CHK_projects_not_null_scrum_master_user_id CHECK(ScrumMasterUserId IS NOT NULL)
)
------------
CREATE TABLE TeamMembers(
	UserId INT,
	ProjectId INT

	CONSTRAINT PK_team_members PRIMARY KEY(UserId, ProjectId),

	CONSTRAINT CHK_team_members_not_null_user_id CHECK(UserId IS NOT NULL),
	CONSTRAINT CHK_team_members_not_null_project_id CHECK(ProjectId IS NOT NULL),

	CONSTRAINT FK_team_members_user_id_users_id FOREIGN KEY(UserId) REFERENCES Users(Id),
	CONSTRAINT FK_team_members_project_id_projects_id FOREIGN KEY (ProjectId) REFERENCES Projects(Id)
)
------------