CREATE OR REPLACE PROCEDURE PV_CAPTURA_SOLERR_PR (sError Out varchar2
) IS

vnum_os       pv_iorserv.num_os%type;
vcod_estado   pv_iorserv.cod_estado%type;
vcod_modgener pv_iorserv.cod_modgener%type;


CURSOR vCursor IS
	SELECT    a.num_os, a.cod_estado,  a.cod_modgener
	FROM    pv_iorserv a,  pv_erecorrido d
	WHERE   d.tip_estado = 4
	AND     d.cod_estado >= 15
	AND     a.num_os = d.num_os
	AND     d.cod_estado = a.cod_estado
	AND 	a.num_os = a.num_ospadre
	AND     nvl(a.num_intentos,0) < (Select VAL_PARAMETRO  From GED_PARAMETROS
	 						  	  	 Where nom_parametro= 'MAX_INTENTOS'
	 							 	 And   cod_modulo='GA'
	 							 	 And   cod_producto=1)
	union
	SELECT    a.num_os, a.cod_estado,  a.cod_modgener
	FROM    pv_iorserv a,  pv_erecorrido d
	WHERE   d.tip_estado = 4
	AND     d.cod_estado > 15
	AND     a.num_os = d.num_os
	AND     d.cod_estado = a.cod_estado
	AND 	a.num_os != a.num_ospadre
	AND     nvl(a.num_intentos,0) < (Select VAL_PARAMETRO  From GED_PARAMETROS
	 						  	  	 Where nom_parametro= 'MAX_INTENTOS'
	 							 	 And   cod_modulo='GA'
	 							 	 And   cod_producto=1);

BEGIN

	 sError:= 'Inicio Reproceso...';

 	 OPEN vCursor;
	 LOOP
	 	 FETCH vCursor 	 INTO vnum_os, vcod_estado, vcod_modgener;
	  	 EXIT WHEN vCursor%NOTFOUND;
		 PV_REPROCESO_SOLERR_PR(vnum_os, vcod_estado, vcod_modgener,sError);
	 END LOOP;

	 sError:= 'Reseteo de Cola OSR';

	 UPDATE fa_intqueueproc
	 SET Cod_Estado = 1  /* Inicializo la Cola */
	 WHERE cod_aplic = 'PVA'
	 AND cod_modgener = 'OSR'
	 AND cod_proceso = 777;

	 sError:= 'REPROCESO TERMINO OK';
EXCEPTION
     WHEN NO_DATA_FOUND THEN
	    sError :='NO HAY OOSS PARA REPROCESAR';
     WHEN OTHERS THEN
        sError := SQLCODE||substr(SQLERRM,1,255);
END PV_CAPTURA_SOLERR_PR;
/
SHOW ERRORS
