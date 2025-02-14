CREATE OR REPLACE PACKAGE BODY PV_PAREO_CODIGOS_PG
IS


FUNCTION fPareoCodigos(sCodInterno VARCHAR2, sCodExterno VARCHAR2)
RETURN VARCHAR2 IS

	sTipoCodigo VARCHAR2(20);
	sCodSalida VARCHAR2(20);

BEGIN

	select val_parametro into sTipoCodigo
	from ged_parametros
	where nom_parametro = 'SS_TUXEDO_10005';

	 if (sCodInterno is null) and (sCodExterno is not null) then
--	 	busca por cod_externo
		select codigo_interno into sCodSalida
		from al_codigo_externo
		where
		TIP_CODIGO = ltrim(rtrim(sTipoCodigo)) and
		CODIGO_EXTERNO = ltrim(rtrim(sCodExterno));
	 elsif (sCodInterno is not null) and (sCodExterno is null) then
--	 	busca por cod_interno
		select codigo_externo into sCodSalida
		from al_codigo_externo
		where
		TIP_CODIGO = ltrim(rtrim(sTipoCodigo)) and
		CODIGO_INTERNO = ltrim(rtrim(sCodInterno));
	 end if;

RETURN sCodSalida;
END fPareoCodigos;

END PV_PAREO_CODIGOS_PG;
/
SHOW ERRORS
