unit SCMDefines;

interface

uses
  Winapi.Messages;
// Winapi.Windows, Winapi.Messages;

const
   SCM_NOMINATESCROLL = WM_USER + 1;
   SCM_SESSIONSCROLL = WM_USER + 2;
   SCM_ENTRANTSCROLL = WM_USER + 3;
   SCM_EVENTSCROLL = WM_USER + 4;
   SCM_HEATSCROLL = WM_USER + 5;
   SCM_TABSHEETDISPLAYSTATE = WM_USER + 6;
   SCM_EVENTASSERTSTATUSSTATE = WM_USER + 7;
   SCM_SESSIONASSERTSTATUSSTATE = WM_USER + 8;
   SCM_PROGRESSBARBEGIN = WM_USER + 9;
   SCM_PROGRESSBARUPDATE = WM_USER + 10;
   SCM_PROGRESSBAREND = WM_USER + 11;

  {
    L e a d e r B o a r d .
    (Depreciated? CHECK)
    SCMDefines may be referenced in SCM_LEADERBOARD
  }
   SCM_INITIALISE = WM_USER + 12;
   SCM_EMPTYENTRANTS = WM_USER + 13;
   SCM_UPDATEENTRANTS = WM_USER + 14;
   SCM_EMPTYEVENTS = WM_USER + 15;
   SCM_UPDATEMEMBERSAGE = WM_USER + 16;
   SCM_UPDATESESSION = WM_USER + 17;
   SCM_UPDATEMEMBERSSCORE = WM_USER + 18;
  // LB_PROGRESSBARBEGIN = WM_USER + 19;
  // LB_PROGRESSBARUPDATE = WM_USER + 20;
  // LB_PROGRESSBAREND = WM_USER + 21;
   SCM_UPDATEENTRANTSSCORE = WM_USER + 22;
   SCM_OPTIONS = WM_USER + 23;

   SCM_EVENTASSERTSTATE = WM_USER +24; // SCM version 1.5.5.1
   SCM_AFTERPOST = WM_USER +25; // SCM version 1.5.5.1

  // Messages used in Manage Members form.
   SCM_AFTERSCROLL =  WM_USER + 26;
   SCM_UPDATE = WM_USER + 27;

  // Messages sent by dmSCMNom
   SCM_LANEWASCLEANED = WM_USER + 28;  // refresh of entrant grid required.

   SCM_REQUERY = WM_USER + 29;

   // Messages MEMBERS : used by dmManageMemberData
   // When the Standard TCalendarPicker changes : this call syncro' data.
   SCM_DOBUPDATED = WM_USER + 30;
   SCM_ELECTEDONUPDATED = WM_USER + 31;
   SCM_RETIREDONUPDATED = WM_USER + 32;

   // Updates the visibility of the grids (INDV/TEAM) on tab sheet 3
   SCM_UPDATEINDVTEAM = WM_USER + 33;
   SCM_RENUMBERHEATS = WM_USER + 34;
   SCM_TEAMSCROLL = WM_USER + 35;
   SCM_RENUMBEREVENTS = WM_USER + 36;
   SCM_TEAMENTRANTSCROLL = WM_USER + 37;
   SCM_FILTERDEACTIVATED = WM_USER + 38;
   SCM_FILTERUPDATED = WM_USER + 39;

   SCM_UPDATESTATUSBAR = WM_USER + 40;
   SCM_UPDATEENTRANTCOUNT = WM_USER + 41;

   SCM_LOCATEMEMBER = WM_USER + 42;
   SCM_CHANGESWIMCLUB = WM_USER + 43;
   SCM_FILTERCLUBDEACTIVATED = WM_USER + 44;
   SCM_AUTOBUILDRELAYSFIN = WM_USER + 45;

   // Update Non-Data-Aware UI labels.
   SCM_UPDATEUI_SCM = WM_USER + 46;   // SwimClubMeet display
   SCM_UPDATEUI_TDS = WM_USER + 47;   // TimeDrops display
   SCM_CONNECT = WM_USER + 48;  // Displays Connect DLG.

  { SCM_DolphinTiming specific windows message ....}
   SCM_CALL_DOLPHIN_TIMING = WM_USER + 49;

   SCM_CLEAR_TIMEDROPS = WM_USER + 50;
   SCM_CLEARANDSCAN_TIMEDROPS = WM_USER + 51;
   SCM_PUSH_TIMEDROPS = WM_USER + 52;
   SCM_SCAN_TIMEDROPS = WM_USER + 53;
   SCM_UPDATE_NOODLES = WM_USER + 54;


   type
   scmSendToFileType = (sftPDF, sftXLS, sftHTML, sftNA);
   scmSendToMode = (stmSendToPrinter, stmSendToFile);
   scmRptType = (rtMarshall, rtTimeKeeper);

    seedMethod = (
    // *********************************
    // U S E R   S E L E C T I O N . . .
    // *********************************
    // times used = TTB algorithym
    smSCMSeeding = 0,
    // times used = TTB algorithym,
    // circle for depth count then switch to smSCMSeeding
    smCircleSeeding,
    // *********************************
    // I N T E R N A L . . . S Y S T E M
    // *********************************
    // times used originate from events held in current session
    // must be semi-finals race-times else ...
    smTimedFinalsSeeding,
    // times used originate from events held in current session
    // must be quarter-finals race-times
    smCircleSeedingTimed,
    // times used originate from events held in current session
    // Event must be built using the Team-Event utility
    // Used for relays
    smDualSeeding,
    // times used originate from events held in current session
    smMastersChampionSeeding);

   scmEventFinalsType = (ftFinals, ftSemi, ftQuarter);

   scmHRType = (hrCoach = 1 , hrContact = 2, hrSwimmer = 3);

	 scmDTFileType = (ftUnknown, ftDO3, ftDO4); // Dolphin Timing file type.
	 scmDTUseFileType = (uftBoth,  uftDO3, uftDO4); // Dolphin Timing file types to use.
	 scmDTPrecedence = (precUnknown, precDO3, precDO4); // DO3 use header info, DO4 use filename DEPRECIATED.
	 scmEventType = (etUnknown = 0, etINDV = 1, etTEAM = 2);

  //  dtFileType = (dtUnknown, dtDO4, dtDO3, dtALL);
  // 5 x modes m-enabled, m-disabled, a-enabled, a-disabled, unknown (err or nil).
  //  dtTimeModeErr = (tmeUnknow, tmeBadTime, tmeExceedsDeviation, tmeEmpty);
  //  dtPrecedence = (dtPrecHeader, dtPrecFileName);
  scmActiveRT = (artAutomatic, artFinalTime, artManual, artUser, artSplit, artPadTime, artNone);


   var
	 scmSendToFileTypes: scmSendToFileType;
	 scmSendToModes: scmSendToMode;
	 scmRptTypes: scmRptType;
   scmSagFactor: single = 0.5; // Sag in patch noodles - default 0.5. (50%).
   scmNumOfSegments: integer = 20; // Patch Noodle line segments.


  implementation


end.
