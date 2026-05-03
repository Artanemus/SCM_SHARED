-- Source - https://stackoverflow.com/a/52325761
-- Posted by Mahesh Thorat , modified by community. See post 'Timeline' for change history
-- Retrieved 2026-05-03, License - CC BY-SA 4.0

ALTER DATABASE [SwimClubMeet] SET EMERGENCY;
GO

ALTER DATABASE [SwimClubMeet] set single_user
GO

DBCC CHECKDB ([SwimClubMeet], REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS;
GO 

ALTER DATABASE [SwimClubMeet] set multi_user
GO
