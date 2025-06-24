create view AN_EMPLOYEES AS


SELECT _IDRRef,
	_Code AS [КОД_СОТРУДНИКА],
	_Description AS [ФИО_СОТРУДНИКА],
	_Fld1532 AS [НОМЕР_ДОГОВОРА]

FROM _Reference114

WHERE _Marked = 0X00