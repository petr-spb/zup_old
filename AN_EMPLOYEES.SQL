ALTER view AN_EMPLOYEES AS


SELECT SOTR._IDRRef,
	SOTR._Code AS [КОД_СОТРУДНИКА],
	SOTR._Description AS [ФИО_СОТРУДНИКА],
	SOTR._Fld1532 AS [НОМЕР_ДОГОВОРА],
	DATEADD(YEAR, -2000, SOTR._FLD1533) AS [ДАТА_ДОГОВОРА],
	DOLZHNOST._Description,
	DATEADD(YEAR, -2000, SOTR._Fld1549) AS [ДАТА_ПРИЁМА_НА_РАБОТУ],
	CASE
		WHEN SOTR._Fld1550  = '2001-01-01 00:00:00.000' THEN DATEADD(YEAR, -2000, SOTR._FLD1533)
		WHEN SOTR._Fld1550 <> '2001-01-01 00:00:00.000' THEN DATEADD(YEAR, -2000, SOTR._Fld1550)
	END AS [ДАТА_УВОЛЬНЕНИЯ],

	--	--DATEADD(YEAR, -2000, SOTR._Fld1550) AS [ДАТА_УВОЛЬНЕНИЯ]

	SOTR._Fld1550
FROM _Reference114 AS SOTR

JOIN _Reference51 AS DOLZHNOST ON DOLZHNOST._IDRRef = SOTR._Fld1536RRef

WHERE SOTR._Marked = 0X00