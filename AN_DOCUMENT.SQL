--ALTER VIEW AN_DOCUMENT AS

SELECT
PER.ТАБЕЛЬНЫЙ_НОМЕР,
PER.ФИО_СОТРУДНИКА,
PER.[ПЕРЕМЕСТИТЬ С],
PER.ПОДРАЗДЕЛЕНИЕ_ОРГАНИЗАЦИИ,
PER.ОТДЕЛ_ОРГАНИЗАЦИИ,
NACHSL.НОМЕР_ДОКУМЕНТА,
NACHSL.ПЕРИОД_С,
NACHSL.ПЕРИОД_ДО,
NACHSL.СТАВКА,
NACHSL.НАЧИСЛЕНО,
NACHSL.НДФЛ,
NACHSL.НАЛОГОВЫЙ_ВЫЧЕТ,
NACHSL.[НАЛОГОВЫЙ ВЫЧЕТ НА ДЕТЕЙ],
NACHSL.УДЕРЖАНИЯ


FROM AN_MOVE_EMP AS PER
LEFT JOIN AN_NACHISL AS NACHSL ON NACHSL._IDRRef_FIZ = PER.IDRREF_FIZ

WHERE PER.ТАБЕЛЬНЫЙ_НОМЕР = '40-480'

--ORDER BY NACHSL.НОМЕР_ДОКУМЕНТА