﻿CREATE TABLE [dbo].[Incident]
(
	[IncidentId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Type] NVARCHAR(50) NOT NULL,
	[Severity] NVARCHAR(50) NOT NULL,
	[Internal] NVARCHAR(1) NOT NULL,
	[Location] NVARCHAR(50) NOT NULL,
	[PeopleInvolved] NVARCHAR(MAX) NOT NULL,
	[Injuries] NVARCHAR(MAX) NOT NULL,
	[Notes] NVARCHAR(MAX) NULL
)