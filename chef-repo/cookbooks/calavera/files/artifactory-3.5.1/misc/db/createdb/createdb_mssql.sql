/* Create a new user for artifactory */

USE [master]
GO
/* For security reasons the login is created disabled and with a random password. */
/********** Object: Login [artifactory]   **************/

CREATE LOGIN [artifactory] WITH PASSWORD=N'password', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [artifactory]
GO
USE [artifactory]
GO
CREATE USER [artifactory] FOR LOGIN [artifactory]
GO

/* create the artifactory Database */
CREATE DATABASE artdb
ON PRIMARY
  (NAME='artdb',
  FILENAME=
  'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\artdb_prm.mdf',
  SIZE=40MB,
  MAXSIZE=UNLIMITED,
  FILEGROWTH=200MB)
LOG ON
  ( NAME='artdb_log',
  FILENAME =
  'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\artdb.ldf',
  SIZE=1MB,
  MAXSIZE=10MB,
  FILEGROWTH=1MB)
COLLATE Latin1_General_CS_AI
GO


