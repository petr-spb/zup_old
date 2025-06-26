ALTER VIEW AN_DOCUMENT AS

SELECT
PER.ТАБЕЛЬНЫЙ_НОМЕР,
PER.ФИО_СОТРУДНИКА,
AN_PRIEM.[ДОЛЖНОСТЬ] AS [ДОЛЖНОСТЬ_ПРИ_ТРУДОУСТРОЙСТВЕ],
PER._Number AS [НОМЕР_ДОКУМЕНТА_ПЕРЕМЕЩЕНИЯ],
PER.[ПЕРЕМЕСТИТЬ С],
PER.ПОДРАЗДЕЛЕНИЕ_ОРГАНИЗАЦИИ,
PER.ОТДЕЛ_ОРГАНИЗАЦИИ,
per.ДОЛЖНОСТЬ,
NACHSL.НОМЕР_ДОКУМЕНТА AS [НОМЕР_ДОКУМЕНТА_НАЧИСЛЕНИЯ],
NACHSL.ПЕРИОД_С [НАЧИСЛЕНИЕ_С],
NACHSL.ПЕРИОД_ДО [НАЧИСЛЕНИЕ_ДО],
NACHSL.СТАВКА,
NACHSL.НАЧИСЛЕНО,
NACHSL.НДФЛ,
NACHSL.НАЛОГОВЫЙ_ВЫЧЕТ,
NACHSL.[НАЛОГОВЫЙ ВЫЧЕТ НА ДЕТЕЙ],
NACHSL.УДЕРЖАНИЯ,
AN_E.[РАБОТАЕТ/УВОЛЕН]


FROM AN_MOVE_EMP AS PER
LEFT JOIN AN_NACHISL AS NACHSL ON NACHSL._IDRRef_FIZ = PER.IDRREF_FIZ
--left join AN_MOVE_EMP on AN_MOVE_EMP.IDRREF_FIZ = 
left join AN_EMPLOYEES as AN_E ON AN_E.IDRREF_FIZ = PER.IDRREF_FIZ
LEFT JOIN AN_PRIEM ON AN_PRIEM.IDRREF_FIZ = PER.IDRREF_FIZ

WHERE PER.ТАБЕЛЬНЫЙ_НОМЕР = '45-005    '

--ORDER BY NACHSL.НОМЕР_ДОКУМЕНТА
--order by PER.ТАБЕЛЬНЫЙ_НОМЕР