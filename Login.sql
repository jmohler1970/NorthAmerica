-- This patches in login functionality. It must be ran after Users.sql


USE [UserManager]

-- Users with null passhash cannot login
ALTER TABLE dbo.Users ADD passhash varchar(96) NULL 
GO

ALTER TABLE dbo.Users ADD loginToken varchar(96) NULL
GO

ALTER TABLE dbo.Users ADD TokenCreateDate smalldatetime NULL
GO

-- We need to make sure we have a good user

USE [UserManager]

INSERT
INTO dbo.Users (FirstName, LastName, StateProvinceID, Email, Passhash)
VALUES ('George', 'Washington', 'NV', 'gwash@wh.org',
     'C074939395DAFE35E464821D8A2B32B6DEBE387F8BF3C90CD4DA42D6E6E79C8CD9AE83EF365AF6AD0EA619DE789714AC')
GO    


SELECT *
FROM dbo.Users
