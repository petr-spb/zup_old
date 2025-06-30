-- USE [zup_old]
-- GO

-- /****** Object:  View [dbo].[AN_NACHISL]    Script Date: 26.06.2025 16:36:01 ******/
-- SET ANSI_NULLS ON
-- GO

-- SET QUOTED_IDENTIFIER ON
-- GO

-- ALTER   VIEW [dbo].[AN_NACHISL] AS
-- SELECT 
--     DNZ._IDRRef,
-- 	PODR_ORG.[_Description] AS [ПОДРАЗДЕЛЕНИЕ_ОРГАНИЗАЦИИ],
--     DATEADD(YEAR, -2000, DNZ._Date_Time) AS [ДАТА_НАЧИСЛЕНИЯ],
--     DNZ._Number AS [НОМЕР_ДОКУМЕНТА],
--     O._Description AS [НАЗВАНИЕ_ОРГАНИЗАЦИИ],
--     DATEADD(YEAR, -2000, DNZ_NAC._Fld3052) AS [ПЕРИОД_С],
--     DATEADD(YEAR, -2000, DNZ_NAC._Fld3053) AS [ПЕРИОД_ДО],
-- 	AN_E._IDRRef AS IDRREF_SOTR,
--     AN_E._IDRRef _IDRREF_EMP,
--     AN_E.[ТАБЕЛЬНЫЙ_НОМЕР],
--     AN_E.[ФИО_СОТРУДНИКА],
-- 	FIZ_LIC._IDRRef AS _IDRRef_FIZ,
--     FIZ_LIC._Description AS [ФИЗ_ЛИЦО],
--     DNZ_NAC._Fld3054 AS [СТАВКА],
--     DNZ_NAC._Fld3060 AS [НАЧИСЛЕНО],
--     DNZ_NDFL._Fld3154 AS [НАЛОГОВЫЙ_ВЫЧЕТ],
-- 	DNZ_NDFL._Fld3155 AS [НАЛОГОВЫЙ ВЫЧЕТ НА ДЕТЕЙ],
--     DNZ_NDFL._Fld3153 AS [НДФЛ],
-- 	UDERZH._Description AS [ВИД_УДЕРЖАНИЯ],
-- 	DNZ_UDER._Fld3132 AS [УДЕРЖАНИЯ]
-- 	--DNZ_NAC._LineNo3048 DNZ_NAC,
-- 	--DNZ_NDFL._LineNo3151 AS DNZ_NDFL -- НОМЕРА СТРОК В СООТВЕСТВУЮЩИХ ТАБЛИЦАХ
-- FROM _Document181 AS DNZ
-- JOIN _Reference80 AS O ON O._IDRRef = DNZ._Fld3037RRef
-- JOIN _Document181_VT3047 AS DNZ_NAC ON DNZ_NAC._Document181_IDRRef = DNZ._IDRRef
-- JOIN _Reference135 AS FIZ_LIC ON FIZ_LIC._IDRRef = DNZ_NAC._Fld3050RRef
-- LEFT JOIN AN_EMPLOYEES AS AN_E ON AN_E._IDRREF = DNZ_NAC._Fld3049RRef

-- LEFT JOIN _Document181_VT3150 AS DNZ_NDFL 
--     ON DNZ_NDFL._Document181_IDRRef = DNZ._IDRRef 
--     AND DNZ_NDFL._Fld3152RRef = FIZ_LIC._IDRRef
-- LEFT JOIN _Document181_VT3128 AS DNZ_UDER ON DNZ_UDER._Document181_IDRRef = DNZ._IDRRef AND DNZ_UDER._Fld3130RRef = FIZ_LIC._IDRRef
-- LEFT JOIN AN_PODRAZDEL_ORG AS PODR_ORG ON PODR_ORG.[_IDRRef] = DNZ._Fld3038RRef
-- LEFT JOIN _CKinds11 AS UDERZH ON UDERZH._IDRRef = DNZ_UDER._Fld3131RRef

-- WHERE DNZ._Marked = 0x00 
--     AND DNZ._Posted = 0x01 
--     --AND DNZ._Number = '00000000001'
-- 	--AND AN_E.[ТАБЕЛЬНЫЙ_НОМЕР] = '45-005'
    
-- GO



CREATE OR ALTER   VIEW [dbo].[AN_NACHISL] AS
SELECT 
    DNZ._IDRRef,
	PODR_ORG.[_Description] AS [ПОДРАЗДЕЛЕНИЕ_ОРГАНИЗАЦИИ],
    DATEADD(YEAR, -2000, DNZ._Date_Time) AS [ДАТА_НАЧИСЛЕНИЯ],
    DNZ._Number AS [НОМЕР_ДОКУМЕНТА],
    O._Description AS [НАЗВАНИЕ_ОРГАНИЗАЦИИ],
    DATEADD(YEAR, -2000, DNZ_NAC._Fld3052) AS [ПЕРИОД_С],
    DATEADD(YEAR, -2000, DNZ_NAC._Fld3053) AS [ПЕРИОД_ДО],
	AN_E._IDRRef AS IDRREF_SOTR,
    AN_E._IDRRef _IDRREF_EMP,
    AN_E.[ТАБЕЛЬНЫЙ_НОМЕР],
    AN_E.[ФИО_СОТРУДНИКА],
	FIZ_LIC._IDRRef AS _IDRRef_FIZ,
    FIZ_LIC._Description AS [ФИЗ_ЛИЦО],
	DNZ_NAC._Fld3050RRef as IDRREF_FIZ_NAC,
    DNZ_NAC._Fld3054 AS [СТАВКА],
    DNZ_NAC._Fld3060 AS [НАЧИСЛЕНО],
    DNZ_NDFL._Fld3154 AS [НАЛОГОВЫЙ_ВЫЧЕТ],
	DNZ_NDFL._Fld3155 AS [НАЛОГОВЫЙ ВЫЧЕТ НА ДЕТЕЙ],
    DNZ_NDFL._Fld3153 AS [НДФЛ],
	UDERZH._Description AS [ВИД_УДЕРЖАНИЯ],
	DNZ_UDER._Fld3132 AS [УДЕРЖАНИЯ]
	--DNZ_NAC._LineNo3048 DNZ_NAC,
	--DNZ_NDFL._LineNo3151 AS DNZ_NDFL -- НОМЕРА СТРОК В СООТВЕСТВУЮЩИХ ТАБЛИЦАХ
FROM _Document181 AS DNZ -- документ начисления ЗП
JOIN _Reference80 AS O ON O._IDRRef = DNZ._Fld3037RRef -- организация
JOIN _Document181_VT3047 AS DNZ_NAC ON DNZ_NAC._Document181_IDRRef = DNZ._IDRRef -- табличная часть документа начисления ЗП
JOIN _Reference135 AS FIZ_LIC ON FIZ_LIC._IDRRef = DNZ_NAC._Fld3050RRef
LEFT JOIN AN_EMPLOYEES AS AN_E ON AN_E._IDRREF = DNZ_NAC._Fld3049RRef

LEFT JOIN _Document181_VT3150 AS DNZ_NDFL -- НДФЛ
    ON DNZ_NDFL._Document181_IDRRef = DNZ._IDRRef -- соединение табл части НДФЛ и документом
    and DNZ_NAC._Fld3062RRef = DNZ_NDFL._Fld3160RRef -- соединение табл части начисл.подразделение с табл частью ндфл.подразделение
	and DNZ_NAC._Fld3050RRef = DNZ_NDFL._Fld3152RRef -- соед физ лиц табл частей начисл и НДФЛ
LEFT JOIN _Document181_VT3128 AS DNZ_UDER ON DNZ_UDER._Document181_IDRRef = DNZ._IDRRef AND DNZ_UDER._Fld3130RRef = FIZ_LIC._IDRRef -- соед табл частью удержания и документ и по физ лицам
LEFT JOIN AN_PODRAZDEL_ORG AS PODR_ORG ON PODR_ORG.[_IDRRef] = DNZ._Fld3038RRef -- соед представления подразделений и документа начисления
LEFT JOIN _CKinds11 AS UDERZH ON UDERZH._IDRRef = DNZ_UDER._Fld3131RRef -- План видов расчетов Виды удержаний

WHERE DNZ._Marked = 0x00 
    AND DNZ._Posted = 0x01 
    --AND DNZ._Number = '00000000001'
	--AND AN_E.[ТАБЕЛЬНЫЙ_НОМЕР] = '00-295'
    
GO


