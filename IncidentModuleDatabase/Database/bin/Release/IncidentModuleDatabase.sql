﻿/*
Deployment script for IncidentModuleDatabase

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "IncidentModuleDatabase"
:setvar DefaultFilePrefix "IncidentModuleDatabase"
:setvar DefaultDataPath "E:\MSSQL.MSSQLSERVER\DATA\"
:setvar DefaultLogPath "D:\MSSQL.MSSQLSERVER\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating Table [dbo].[Contractor]...';


GO
CREATE TABLE [dbo].[Contractor] (
    [ContractorId]       INT            IDENTITY (1, 1) NOT NULL,
    [Company]            NVARCHAR (50)  NOT NULL,
    [ReasonForEntry]     NVARCHAR (200) NOT NULL,
    [StartDate]          DATETIME       NOT NULL,
    [ExpectedFinishDate] DATETIME       NOT NULL,
    [FinishedDate]       DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([ContractorId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Incident]...';


GO
CREATE TABLE [dbo].[Incident] (
    [IncidentId]       INT             IDENTITY (1, 1) NOT NULL,
    [IncidentType]     NVARCHAR (50)   NOT NULL,
    [Severity]         NVARCHAR (50)   NOT NULL,
    [Internal]         NVARCHAR (1)    NOT NULL,
    [IncidentLocation] NVARCHAR (50)   NOT NULL,
    [PeopleInvolved]   NVARCHAR (4000) NOT NULL,
    [Injuries]         NVARCHAR (4000) NOT NULL,
    [Notes]            NVARCHAR (4000) NULL,
    PRIMARY KEY CLUSTERED ([IncidentId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Person]...';


GO
CREATE TABLE [dbo].[Person] (
    [PersonId]      INT           IDENTITY (1, 1) NOT NULL,
    [LastName]      NVARCHAR (50) NOT NULL,
    [FirstName]     NVARCHAR (50) NOT NULL,
    [DateOfBirth]   DATE          NOT NULL,
    [ContactNumber] NVARCHAR (15) NOT NULL,
    [EmailAddress]  NVARCHAR (50) NOT NULL,
    [Relationship]  NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([PersonId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Staff]...';


GO
CREATE TABLE [dbo].[Staff] (
    [StaffId]        INT      IDENTITY (1, 1) NOT NULL,
    [EmploymentDate] DATETIME NOT NULL,
    PRIMARY KEY CLUSTERED ([StaffId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Student]...';


GO
CREATE TABLE [dbo].[Student] (
    [StudentId]      INT      IDENTITY (1, 1) NOT NULL,
    [EnrollmentDate] DATETIME NOT NULL,
    PRIMARY KEY CLUSTERED ([StudentId] ASC)
);


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------

Cannot use original value of Role, as it is a keyword.
*/
MERGE INTO Person AS Target
USING (VALUES
('Berry', 'Forrest', '1988-02-11', '0433498194', 'forrest@school.wa.edu.au','Teacher'),
('Moody', 'Emile', '1964-12-05', '0488762931', 'emile@school.wa.edu.au', 'Principal'),
('Robinson', 'Esther', '2016-06-15', '0412359234', 'esthers_mother@gmail.com', 'Student'),
('Montoya', 'Kim', '2015-08-12', '0445623623', 'kims_mother@hotmail.com', 'Student'),
('Villarreal', 'Leon', '2000-03-25', '0488762931', 'leon@prune4u.com', 'Contractor')
)
AS SOURCE (LastName, FirstName, DateOfBirth, ContactNumber, EmailAddress, Relationship)
ON Target.LastName = Source.LastName
WHEN NOT MATCHED BY TARGET THEN
INSERT (LastName, FirstName, DateOfBirth, ContactNumber, EmailAddress, Relationship)
VALUES(LastName, FirstName, DateOfBirth, ContactNumber, EmailAddress, Relationship);

MERGE INTO Incident AS Target
USING (VALUES
(1, 'Accident', 'Low' , 'Y', 'SCHOOL' , '{{Esther Robinson;Victim}}', '{{Esther Robinson;Sprained ankle}}', ''),
(2, 'Altercation' , 'Med' , 'N' , 'Road outside school' , '{{Kim Montoya;Victim},{Unknown Girl;Attacker}}', '{{Kim Montoya;Broken laptop}}', 
'Unknown girl has black hair and seemed to know Montoya, shouted that she took something from her before pushing Montoya over.')
)
AS SOURCE (IncidentID, IncidentType, Severity, Internal, IncidentLocation, PeopleInvolved, Injuries, Notes)
ON Target.IncidentID = Source.IncidentID
WHEN NOT MATCHED BY TARGET THEN
INSERT(IncidentType, Severity, Internal, IncidentLocation, PeopleInvolved, Injuries, Notes)
VALUES(IncidentType, Severity, Internal, IncidentLocation, PeopleInvolved, Injuries, Notes);
GO

GO
PRINT N'Update complete.';


GO
