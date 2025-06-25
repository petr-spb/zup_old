ALTER     VIEW [dbo].[AN_MOVE_EMP] AS
	SELECT 
		O._Description,
		DATEADD(YEAR, -2000, KPO._Date_Time) AS [ДАТА_ДОКУМЕНТА],
		KPO._Number,
		KPO._Fld2831 AS [КОММЕНТАРИЙ],
		AN_E.[ТАБЕЛЬНЫЙ_НОМЕР],
		AN_E.[ФИО_СОТРУДНИКА],
		FIZ_LIC._IDRRef AS IDRREF_FIZ,
		FIZ_LIC._Description AS [ФИЗИЧЕСКОЕ_ЛИЦО],
		DATEADD(YEAR, -2000, KPO_SOTR._Fld2846) as [ПЕРЕМЕСТИТЬ С],
		AN_POD_ORG.[_Description] AS [ПОДРАЗДЕЛЕНИЕ_ОРГАНИЗАЦИИ],
		PO._Description AS [ОТДЕЛ_ОРГАНИЗАЦИИ],
		DOLZHN._Description AS [ДОЛЖНОСТЬ],
		KPO_NACHISL._Fld2867 AS [ЗАРПЛАТА],
		KPO_SOTR._FLD2851 AS [ЗАНИМАЕМЫХ_СТАВОК],
		GR_RAB._Description AS [ГРАФИК_РАБОТЫ]

	FROM _Document175 as KPO -- КПО - КАДРОВЫЕ ПЕРЕМЕЩЕНИЯ ОРГАНИЗАЦИИ
	LEFT JOIN _Reference80 AS O ON O._IDRRef = KPO._Fld2830RRef -- ОРГАНИЗАЦИЯ
	LEFT JOIN _Document175_VT2842 AS KPO_SOTR ON KPO_SOTR._Document175_IDRRef = KPO._IDRRef -- ТАБЛИЧНАЯ ЧАСТЬ СОТРУДНИКИ ДОКУМЕНТА КАДРОВЫЕ ПЕРЕМЕЩЕНИЯ ОРГАНИЗАЦИИ
	LEFT JOIN AN_EMPLOYEES AS AN_E ON AN_E._IDRREF = KPO_SOTR._Fld2844RRef -- ПРЕДСТАВЛЕНИЕ СОТРУДНИКОВ ОРГАНИЗАЦИИ
	LEFT JOIN _Reference93 AS PO ON PO._IDRRef = KPO_SOTR._Fld2849RRef -- ОТДЕЛ ОРГАНИЗАЦИИ
	LEFT JOIN _Reference51 AS DOLZHN ON DOLZHN._IDRRef = KPO_SOTR._Fld2850RRef -- ДОЛЖНОСТИ
	LEFT JOIN _Reference135 AS FIZ_LIC ON FIZ_LIC._IDRRef = KPO_SOTR._Fld2845RRef
	left join _Document175_VT2861 as KPO_NACHISL ON KPO_NACHISL._Document175_IDRRef = KPO._IDRRef AND FIZ_LIC._IDRREF = KPO_NACHISL._Fld2864RRef -- ТАБЛИЧНАЯ ЧАСТЬ НАЧИСЛЕНИЯ ДОКУМЕНТА КАДРОВЫЕ ПЕРЕМЕЩЕНИЯ ОРГАНИЗАЦИИ
	LEFT JOIN _Reference41 AS GR_RAB ON GR_RAB._IDRRef = KPO_SOTR._Fld2854RRef -- ГРАФИК РАБОТЫ
	LEFT JOIN AN_PODRAZDEL_ORG AS AN_POD_ORG ON AN_POD_ORG._IDRREF = PO._ParentIDRRef -- ПОДРАЗДЕЛЕНИЯ
	



where KPO._Marked = 0x00 AND KPO._Posted = 0x01 AND AN_E.[ФИО_СОТРУДНИКА] IS NOT NULL AND AN_E.[ТАБЕЛЬНЫЙ_НОМЕР] = '40-480'

--ORDER BY KPO._NUMBER
GO


