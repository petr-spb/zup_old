ALTER VIEW [dbo].[AN_DOCUMENT] AS
WITH RankedMoves AS (
    SELECT 
        PER.*,
        LEAD([ПЕРЕМЕСТИТЬ С]) OVER (
            PARTITION BY IDRREF_FIZ 
            ORDER BY [ПЕРЕМЕСТИТЬ С]
        ) AS NextMoveDate
    FROM AN_MOVE_EMP AS PER
)
SELECT
    NACHSL.ТАБЕЛЬНЫЙ_НОМЕР,
    NACHSL.ФИО_СОТРУДНИКА,
	AN_PRIEM.[ПОДРАЗДЕЛЕНИЕ] AS [ПОДРАЗДЕЛЕНИЕ_ПРИ_ТРУДОУСТРОЙСТВЕ],
    AN_PRIEM.[ДОЛЖНОСТЬ] AS [ДОЛЖНОСТЬ_ПРИ_ТРУДОУСТРОЙСТВЕ],
    PER._Number AS [НОМЕР_ДОКУМЕНТА_ПЕРЕМЕЩЕНИЯ],
    PER.[ПЕРЕМЕСТИТЬ С],
    PER.[КОММЕНТАРИЙ],
    PER.ПОДРАЗДЕЛЕНИЕ_ОРГАНИЗАЦИИ,
    PER.ОТДЕЛ_ОРГАНИЗАЦИИ,
    PER.ДОЛЖНОСТЬ,
    NACHSL.НОМЕР_ДОКУМЕНТА AS [НОМЕР_ДОКУМЕНТА_НАЧИСЛЕНИЯ],
    NACHSL.ПЕРИОД_С [НАЧИСЛЕНИЕ_С],
    NACHSL.ПЕРИОД_ДО [НАЧИСЛЕНИЕ_ДО],
    NACHSL.СТАВКА,
    NACHSL.НАЧИСЛЕНО,
    NACHSL.НДФЛ,
    NACHSL.НАЛОГОВЫЙ_ВЫЧЕТ,
    NACHSL.[НАЛОГОВЫЙ ВЫЧЕТ НА ДЕТЕЙ],
    NACHSL.[ВИД_УДЕРЖАНИЯ],
    NACHSL.УДЕРЖАНИЯ,
    AN_E.[РАБОТАЕТ/УВОЛЕН]
FROM AN_NACHISL AS NACHSL
LEFT JOIN RankedMoves AS PER 
    ON NACHSL._IDRRef_FIZ = PER.IDRREF_FIZ
    AND NACHSL.ПЕРИОД_С >= PER.[ПЕРЕМЕСТИТЬ С]
    AND (NACHSL.ПЕРИОД_С < PER.NextMoveDate OR PER.NextMoveDate IS NULL)
LEFT JOIN AN_EMPLOYEES AS AN_E 
    ON AN_E.IDRREF_FIZ = NACHSL._IDRRef_FIZ
LEFT JOIN AN_PRIEM 
    ON AN_PRIEM.IDRREF_FIZ = NACHSL._IDRRef_FIZ
--WHERE NACHSL.ТАБЕЛЬНЫЙ_НОМЕР = '00-150    '
--ORDER BY NACHSL.ТАБЕЛЬНЫЙ_НОМЕР, NACHSL.НОМЕР_ДОКУМЕНТА
GO