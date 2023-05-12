/*
Bing.com/Chat 

“Using the FINA swimming DisqualifyCode-Codes as the source for input data.
Can you provide me with SQL scripts to create two tables named DisqualifyType and DisqualifyCode? The DisqualifyType table should have two columns: DisqualifyTypeID and DisqualifyTypeName. The DisqualifyTypeID field should be an IDENTITY column and the DisqualifyTypeName field should contain the name of the category. The DisqualifyCode table should have four columns: DisqualifyCodeID, Caption, ABREV, and DisqualifyTypeID. The DisqualifyCodeID field should be an IDENTITY column, the Caption field should contain the description of the disqualification, the ABREV field should contain the FINA abbreviation, and the DisqualifyTypeID field should be a foreign key that references the DisqualifyTypeID field in the DisqualifyType table. Can you also include SQL scripts to insert all records for all categories into both tables and use the SET IDENTITY_INSERT statement to insert explicit values into the IDENTITY columns of both tables?” 
*/

USE SwimClubMeet GO

SET IDENTITY_INSERT  [dbo].[DisqualifyType] ON;
INSERT INTO DisqualifyType
(
[DisqualifyTypeID], [Caption]
)
VALUES
(1, N'General')
,(2, N'Freestyle')
,(3, N'Breaststroke')
,(4, N'Backstroke')
,(4, N'Butterfly')
,(5, N'IndividualMedley')
,(6, N'Relays')

SET IDENTITY_INSERT  [dbo].[DisqualifyType] OFF;



SET IDENTITY_INSERT  [dbo].[DisqualifyCode] ON;

-- Insert rows into tableN'DisqualifyCodeCodes'
INSERT INTO DisqualifyCode
( -- columns to insert data into
 [DisqualifyCodeID], [Caption], [ABREV], [DisqualifyTypeID]
)
VALUES
(1,N'False start', N'GA', 1),
(2,N'Delay of meet', N'GB', 1),
(3,N'Unsportsmanlike manner', N'GC', 1),
(4,N'Interference with another swimmer', N'GD', 1),
(5,N'Did not swim stroke specified', N'GE', 1),
(6,N'Did not swim distance specified', N'GF', 1),
(7,N'Did not finish in same lane', N'GG', 1),
(8,N'Standing on bottom during any stroke but freestyle', N'GH', 1),
(9,N'Swimmer swam in wrong lane', N'GI', 1),
(10,N'Swimmer made use of aids', N'GJ', 1),
(11,N'Swimmer did not finish', N'GK', 1),
(12,N'Pulled on lane ropes', N'GL', 1),
(13,N'Use of not FINA approved swim suit', N'GM', 1),
(14,N'Use of more than one swim suit', N'GN', 1),
(15,N'Use of tape on the body', N'GO', 1),

-- Freestyle
(16, N'No touch at turn or finish', N'FrA' ,2),
(17, N'Swam under water more than 15 meters after start or turn', N'FrB' ,2),
(18, N'Walked on pool bottom and/or pushed off bottom', N'FrC' ,2),

-- Backstroke
(19, N'Toes over the gutter', N'BaA' ,3),
(20, N'Head did not break surface by 15 meters after start or turn', N'BaB' ,3),
(21, N'Shoulders past vertical', N'BaC' ,3),
(22, N'No touch at turn and/or finish', N'BaD' ,3),
(23, N'Not on back off wall', N'BaE' ,3),
(24, N'Did not finish on back', N'BaF' ,3),
(25, N'Past vertical at turn: non continuous turning action', N'BaG' ,3),
(26, N'Past vertical at turn: independent kicks', N'BaH' ,3),
(27, N'Past vertical at turn: independent strokes', N'BaI' ,3),
(28, N'Sub-merged at the finish', N'BaJ' ,3),

-- Breaststroke
(29, N'Head did not break surface before hands turned inside at widest part of second stroke', N'BrA' ,4),
(30, N'Head did not break surface of water during each complete stroke cycle', N'BrB' ,4),
(31, N'Arm movements not always simultaneous and in horizontal plane', N'BrC' ,4),
(32, N'Leg Movements not always simultaneous and in horizontal plane', N'BrD' ,4),
(33, N'Hands not pushed forward on, under or over water', N'BrE' ,4),

-- Individual Medley
(34, N'Freestyle swum as backstroke, breaststroke or butterfly', N'IMA' ,5),
(35, N'Not swum in right order', N'IMB' ,5),
(36, N'Stroke infraction - use stroke codes', N'IMC' ,5),

-- Relay
(37, N'Early swimmer take-off # (RA#)', N'RA#' ,6),
(38, N'Medley not swum in right order', N'RB' ,6),
(39, N'Changed order of swimmers',N'RC',6),
(40, N'Non listed swimmer swam',N'RD',6),
(41, N'Stroke infraction - use stroke codes and swimmer',N'RE',6),
(42, N'Swimmer other than the swimmer designated to swim entered race area before finished',N'Rf',6)

GO

SET IDENTITY_INSERT [dbo].[DisqualifyCode]  OFF;