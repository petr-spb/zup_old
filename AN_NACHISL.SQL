ALTER   VIEW [dbo].[AN_NACHISL] AS
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
    DNZ_NDFL._Fld3154 AS [НАЛОГОВЫЙ_ВЫЧЕТ],
	DNZ_NDFL._Fld3155 AS [НАЛОГОВЫЙ ВЫЧЕТ НА ДЕТЕЙ],
    DNZ_NDFL._Fld3153 AS [НДФЛ],
	UDERZH._Description AS [ВИД_УЖЕРЖАНИЯ],
	DNZ_UDER._Fld3132 AS [УДЕРЖАНИЯ]
	--DNZ_NAC._LineNo3048 DNZ_NAC,
	--DNZ_NDFL._LineNo3151 AS DNZ_NDFL -- НОМЕРА СТРОК В СООТВЕСТВУЮЩИХ ТАБЛИЦАХ
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
    --AND DNZ._Number = '00000000001'
	AND AN_E.[ТАБЕЛЬНЫЙ_НОМЕР] = '45-005'
    
GO


