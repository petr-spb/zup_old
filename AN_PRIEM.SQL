CREATE OR ALTER   view [dbo].[AN_PRIEM] AS
SELECT
PRIEM._Number,
an_e.ТАБЕЛЬНЫЙ_НОМЕР,
AN_E.ФИО_СОТРУДНИКА,
PODR._Description AS [ПОДРАЗДЕЛЕНИЕ],
DOLZHNOST._Description AS [ДОЛЖНОСТЬ],
FIZ_LIC._IDRRef AS IDRREF_FIZ

FROM _Document214 AS PRIEM -- документ приёма на работу

LEFT JOIN _Document214_VT4353 AS PRIEM_SOTR ON PRIEM_SOTR._Document214_IDRRef = PRIEM._IDRRef -- табличная часть сотрудники документа приёма на работу
LEFT JOIN AN_EMPLOYEES AS AN_E ON AN_E._IDRRef = PRIEM_SOTR._Fld4355RRef -- справочник сотрудники
LEFT JOIN _Reference51 AS DOLZHNOST ON DOLZHNOST._IDRRef = PRIEM_SOTR._Fld4358RRef -- справочник должности
LEFT JOIN _Reference135 AS FIZ_LIC ON FIZ_LIC._IDRRef = PRIEM_SOTR._Fld4356RRef -- Справочник Физические лица
left join _Reference93 as PODR ON PODR._IDRRef = PRIEM_SOTR._Fld4357RRef -- Справочник подразделения организации

--where an_e.ТАБЕЛЬНЫЙ_НОМЕР = '40-433'

GO


