
--CREATE OR ALTER   VIEW [dbo].[AN_DOCUMENT3] AS

SELECT
    NACHSL.ТАБЕЛЬНЫЙ_НОМЕР,
    NACHSL.ФИО_СОТРУДНИКА,
	NACHSL.НОМЕР_ДОКУМЕНТА AS [НОМЕР_ДОКУМЕНТА_НАЧИСЛЕНИЯ],
	NACHSL.НАЧИСЛЕНО,
	NACHSL.ПЕРИОД_С AS [НАЧИСЛЕНИЕ_С],
    NACHSL.ПЕРИОД_ДО AS [НАЧИСЛЕНИЕ_ДО],
    /*AN_PRIEM.[ПОДРАЗДЕЛЕНИЕ] AS [ПОДРАЗДЕЛЕНИЕ_ПРИ_ТРУДОУСТРОЙСТВЕ],
    AN_PRIEM.[ДОЛЖНОСТЬ] AS [ДОЛЖНОСТЬ_ПРИ_ТРУДОУСТРОЙСТВЕ],
    PER._Number AS [НОМЕР_ДОКУМЕНТА_ПЕРЕМЕЩЕНИЯ],
    PER.[ПЕРЕМЕСТИТЬ С],
    PER.[КОММЕНТАРИЙ],*/
    NACHSL.[ПОДРАЗДЕЛЕНИЕ_ОРГАНИЗАЦИИ],
    NACHSL.[ПОДРАЗДЕЛЕНИЕ],
    CASE
		WHEN
			PER.ДОЛЖНОСТЬ IS NULL THEN AN_PRIEM.ДОЛЖНОСТЬ
			ELSE PER.ДОЛЖНОСТЬ
	END AS [ДОЛЖНОСТЬ],
    NACHSL.НДФЛ,
    NACHSL.НАЛОГОВЫЙ_ВЫЧЕТ,
    NACHSL.[НАЛОГОВЫЙ ВЫЧЕТ НА ДЕТЕЙ],
    --NACHSL.[ВИД_УДЕРЖАНИЯ],
    sum(NACHSL.УДЕРЖАНИЯ) as 'УДЕРЖАНИЯ',
	--NACHSL.УДЕРЖАНИЯ,
    AN_E.[РАБОТАЕТ/УВОЛЕН]
FROM AN_NACHISL AS NACHSL
LEFT JOIN (
    SELECT 
        PER.*,
        (SELECT MIN(PER2.[ПЕРЕМЕСТИТЬ С])
         FROM AN_MOVE_EMP AS PER2
         WHERE PER2.IDRREF_FIZ = PER.IDRREF_FIZ
         AND PER2.[ПЕРЕМЕСТИТЬ С] > PER.[ПЕРЕМЕСТИТЬ С]) AS NextMoveDate
    FROM AN_MOVE_EMP AS PER
) AS PER -- КАКАЯ-ТО МАГИЯ
    ON NACHSL._IDRRef_FIZ = PER.IDRREF_FIZ
    AND NACHSL.ПЕРИОД_С >= PER.[ПЕРЕМЕСТИТЬ С]
    AND (NACHSL.ПЕРИОД_С < PER.NextMoveDate OR PER.NextMoveDate IS NULL) -- ПРОДОЛЖЕНИЕ МАГИИ
LEFT JOIN AN_EMPLOYEES AS AN_E 
    ON AN_E.IDRREF_FIZ = NACHSL._IDRRef_FIZ
LEFT JOIN AN_PRIEM 
    ON AN_PRIEM.IDRREF_FIZ = NACHSL._IDRRef_FIZ
--WHERE NACHSL.ТАБЕЛЬНЫЙ_НОМЕР = '00-295'

GROUP BY NACHSL.ТАБЕЛЬНЫЙ_НОМЕР,
NACHSL.ФИО_СОТРУДНИКА,
NACHSL.НОМЕР_ДОКУМЕНТА,
	NACHSL.НАЧИСЛЕНО,
	NACHSL.ПЕРИОД_С,
    NACHSL.ПЕРИОД_ДО,
    /*AN_PRIEM.[ПОДРАЗДЕЛЕНИЕ] AS [ПОДРАЗДЕЛЕНИЕ_ПРИ_ТРУДОУСТРОЙСТВЕ],
    AN_PRIEM.[ДОЛЖНОСТЬ] AS [ДОЛЖНОСТЬ_ПРИ_ТРУДОУСТРОЙСТВЕ],
    PER._Number AS [НОМЕР_ДОКУМЕНТА_ПЕРЕМЕЩЕНИЯ],
    PER.[ПЕРЕМЕСТИТЬ С],
    PER.[КОММЕНТАРИЙ],*/
    NACHSL.[ПОДРАЗДЕЛЕНИЕ_ОРГАНИЗАЦИИ],
    NACHSL.[ПОДРАЗДЕЛЕНИЕ],
    PER.ДОЛЖНОСТЬ,
    NACHSL.НДФЛ,
    NACHSL.НАЛОГОВЫЙ_ВЫЧЕТ,
    NACHSL.[НАЛОГОВЫЙ ВЫЧЕТ НА ДЕТЕЙ],
    AN_PRIEM.ДОЛЖНОСТЬ,
	AN_E.[РАБОТАЕТ/УВОЛЕН]

--ORDER BY NACHSL.ТАБЕЛЬНЫЙ_НОМЕР
GO
