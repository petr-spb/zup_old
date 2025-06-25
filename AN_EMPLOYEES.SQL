
ALTER   view [dbo].[AN_EMPLOYEES] AS


SELECT SOTR._IDRRef,
	SOTR._Code AS [ТАБЕЛЬНЫЙ_НОМЕР],
	SOTR._Description AS [ФИО_СОТРУДНИКА],
	FIZ_LIC._IDRRef AS IDRRef_FIZ,
	FIZ_LIC._Description AS [ФИЗИЧЕСКОЕ ЛИЦО],
	SOTR._Fld1532 AS [НОМЕР_ДОГОВОРА],
	DATEADD(YEAR, -2000, SOTR._FLD1533) AS [ДАТА_ДОГОВОРА],
	DOLZHNOST._Description AS [ДОЛЖНОСТЬ],
	SOTR._Fld1536RRef,
	DATEADD(YEAR, -2000, SOTR._Fld1549) AS [ДАТА_ПРИЁМА_НА_РАБОТУ],
	CASE
		WHEN SOTR._Fld1550  = '2001-01-01 00:00:00.000' THEN NULL
		WHEN SOTR._Fld1550 <> '2001-01-01 00:00:00.000' THEN DATEADD(YEAR, -2000, SOTR._Fld1550)
	END AS [ДАТА_УВОЛЬНЕНИЯ],
	CASE
		WHEN SOTR._Fld1550  = '2001-01-01 00:00:00.000' THEN 'РАБОТАЕТ'
		ELSE 'УВОЛЕН'
	END AS 'РАБОТАЕТ/УВОЛЕН',

	--DATEADD(YEAR, -2000, SOTR._Fld1550) AS [ДАТА_УВОЛЬНЕНИЯ],

	SOTR._Fld1550
FROM _Reference114 AS SOTR

LEFT JOIN _Reference51 AS DOLZHNOST ON DOLZHNOST._IDRRef = SOTR._Fld1536RRef
LEFT JOIN _Reference135 AS FIZ_LIC ON FIZ_LIC._IDRRef = SOTR._Fld1526RRef

WHERE SOTR._Marked = 0X00
GO


