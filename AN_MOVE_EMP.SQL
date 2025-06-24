CREATE OR ALTER VIEW AN_MOVE_EMP AS
	SELECT 
		O._Description,
		DATEADD(YEAR, -2000, KPO._Date_Time) AS [ДАТА_ДОКУМЕНТА],
		KPO._Number,
		KPO._Fld2831 AS [КОММЕНТАРИЙ],
		AN_E.[ФИО_СОТРУДНИКА]
	
	





	FROM _Document175 as KPO -- КПО - КАДРОВЫЕ ПЕРЕМЕЩЕНИЯ ОРГАНИЗАЦИИ
	JOIN _Reference80 AS O ON O._IDRRef = KPO._Fld2830RRef
	JOIN _Document175_VT2842 AS KPO_SOTR ON KPO_SOTR._Document175_IDRRef = KPO._IDRRef
	JOIN AN_EMPLOYEES AS AN_E ON AN_E._IDRREF = KPO_SOTR._Fld2844RRef


	where KPO._Marked = 0x00 AND KPO._Posted = 0x01