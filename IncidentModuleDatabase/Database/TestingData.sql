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