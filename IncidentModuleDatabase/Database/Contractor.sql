-- This table is a placeholder, intent for this table is to be able to navigate through person to here for all those that are within the school

CREATE TABLE [dbo].[Contractor]
(
	[ContractorId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Company] NVARCHAR(50) NOT NULL,
	[ReasonForEntry] NVARCHAR(200) NOT NULL,
	[StartDate] DATETIME NOT NULL,
	[ExpectedFinishDate] DATETIME NOT NULL,
	[FinishedDate] DATETIME NULL
)
