ALTER VIEW AN_PODRAZDEL_ORG AS
	select PO._IDRRef, _Code, _Description
	from _Reference93  AS PO -- ПОДРАЗДЕЛЕНИЕ ОРГАНИЗАЦИИ

	WHERE _ParentIDRRef = 0x00000000000000000000000000000000