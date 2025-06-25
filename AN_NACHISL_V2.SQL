USE [zup_old]
GO

/****** Object:  View [dbo].[AN_NACHISL_V2]    Script Date: 25.06.2025 11:28:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[AN_NACHISL_V2] AS
SELECT 
    DNZ._IDRRef,
    PODR_ORG.[_Description] AS [ПОДРАЗДЕЛЕНИЕ_ОРГАНИЗАЦИИ],
    DATEADD(YEAR, -2000, DNZ._Date_Time) AS [ДАТА_НАЧИСЛЕНИЯ],
    DNZ._Number AS [НОМЕР_ДОКУМЕНТА],
    O._Description AS [НАЗВАНИЕ_ОРГАНИЗАЦИИ],
    DATEADD(YEAR, -2000, DNZ_NAC._Fld3052) AS [ПЕРИОД_С],
    DATEADD(YEAR, -2000, DNZ_NAC._Fld3053) AS [ПЕРИОД_ДО],
    AN_E._IDRRef _IDRREF_EMP,
    AN_E.[ТАБЕЛЬНЫЙ_НОМЕР],
    AN_E.[ФИО_СОТРУДНИКА],
    FIZ_LIC._IDRRef AS _IDRRef_FIZ,
    FIZ_LIC._Description AS [ФИЗ_ЛИЦО],
    DNZ_NAC._Fld3054 AS [СТАВКА],
    DNZ_NAC._Fld3060 AS [НАЧИСЛЕНО],
    SUM(DNZ_NDFL._Fld3154) AS [НАЛОГОВЫЙ_ВЫЧЕТ], -- Суммируем для устранения дублирования
    SUM(DNZ_NDFL._Fld3155) AS [НАЛОГОВЫЙ_ВЫЧЕТ_НА_ДЕТЕЙ], -- Суммируем для устранения дублирования
    SUM(DNZ_NDFL._Fld3153) AS [НДФЛ], -- Суммируем для устранения дублирования
    UDERZH._Description AS [УДЕРЖАНИЕ], -- Оставляем описание как есть, если одно на сотрудника
    SUM(DNZ_UDER._Fld3132) AS [УДЕРЖАНИЯ] -- Суммируем для устранения дублирования
FROM _Document181 AS DNZ
JOIN _Reference80 AS O ON O._IDRRef = DNZ._Fld3037RRef
JOIN _Document181_VT3047 AS DNZ_NAC ON DNZ_NAC._Document181_IDRRef = DNZ._IDRRef
JOIN _Reference135 AS FIZ_LIC ON FIZ_LIC._IDRRef = DNZ_NAC._Fld3050RRef
LEFT JOIN AN_EMPLOYEES AS AN_E ON AN_E._IDRREF = DNZ_NAC._Fld3049RRef
LEFT JOIN _Document181_VT3150 AS DNZ_NDFL 
    ON DNZ_NDFL._Document181_IDRRef = DNZ._IDRRef 
    AND DNZ_NDFL._Fld3152RRef = FIZ_LIC._IDRRef
LEFT JOIN _Document181_VT3128 AS DNZ_UDER ON DNZ_UDER._Document181_IDRRef = DNZ._IDRRef AND DNZ_UDER._Fld3130RRef = FIZ_LIC._IDRRef
LEFT JOIN AN_PODRAZDEL_ORG AS PODR_ORG ON PODR_ORG.[_IDRRef] = DNZ._Fld3038RRef
LEFT JOIN _CKinds11 AS UDERZH ON UDERZH._IDRRef = DNZ_UDER._Fld3131RRef
WHERE DNZ._Marked = 0x00 
    AND DNZ._Posted = 0x01 
    --AND DNZ._Number = '00000000001' -- Оставил фильтр закомментированным для общего случая
GROUP BY 
    DNZ._IDRRef,
    PODR_ORG.[_Description],
    DATEADD(YEAR, -2000, DNZ._Date_Time),
    DNZ._Number,
    O._Description,
    DATEADD(YEAR, -2000, DNZ_NAC._Fld3052),
    DATEADD(YEAR, -2000, DNZ_NAC._Fld3053),
    AN_E._IDRRef,
    AN_E.[ТАБЕЛЬНЫЙ_НОМЕР],
    AN_E.[ФИО_СОТРУДНИКА],
    FIZ_LIC._IDRRef,
    FIZ_LIC._Description,
    DNZ_NAC._Fld3054,
    DNZ_NAC._Fld3060,
    UDERZH._Description
GO