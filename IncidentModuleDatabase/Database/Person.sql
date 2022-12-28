-- This table contains all common information for students, staff, and contractors that will be operating within, or attending the school.
-- May migrate include a table that is just staff and have a field with internal or external to determine contractor or not.

CREATE TABLE [dbo].[Person]
(
	[PersonId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[LastName] NVARCHAR(50) NOT NULL,
	[FirstName] NVARCHAR(50) NOT NULL,
	[DateOfBirth] DATE NOT NULL,
	[ContactNumber] NVARCHAR(15) NOT NULL,
	[EmailAddress] NVARCHAR(50) NOT NULL,
	[Relationship] NVARCHAR(50) NOT NULL
)
