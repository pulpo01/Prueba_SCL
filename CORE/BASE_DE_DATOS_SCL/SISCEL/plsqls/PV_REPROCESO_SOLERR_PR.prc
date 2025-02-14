CREATE OR REPLACE PROCEDURE PV_REPROCESO_SOLERR_PR (pNum_os 		in pv_iorserv.num_os%type,
	   	  		  								    pCod_estado		in pv_iorserv.cod_estado%type,
												    pCod_modgener	in pv_iorserv.cod_modgener%type,
												    sError			Out varchar2
) IS

vEst_Ant      pv_arcos.est_inicial%type;
vTip_Estado   pv_erecorrido.tip_estado%type := 3;
vCod_modgener pv_iorserv.cod_modgener%type;
vEstado       boolean;
cCod_estado   pv_iorserv.cod_estado%type := 15;
cCod_estado_f pv_iorserv.cod_estado%type := 110;

BEGIN
	 vEstado := true;

	 if pCod_estado = cCod_estado then
	 	 vCod_modgener :='OSF';
		 vEstado := false;
	 else
	 	  vCod_modgener := pCod_modgener;
	 end if;

	 if pCod_estado <> cCod_estado_f then
      	SELECT est_inicial into vEst_Ant
	  	FROM   pv_arcos
	    WHERE  est_final    = pCod_estado
	      AND  cod_modgener = vCod_modgener;
	 else
	 	  vEst_Ant := cCod_estado;
	 end if;

	 if vEstado then
		 UPDATE pv_iorserv SET
		 num_intentos =  (SELECT NVL(num_intentos,0) + 1  FROM pv_iorserv
		 			  	  WHERE  num_os= pNum_os),
		 cod_estado   = vEst_Ant
		 WHERE num_os= pNum_os;
	else
		 UPDATE pv_iorserv SET
		 num_intentos =  (SELECT NVL(num_intentos,0) + 1  FROM pv_iorserv
		 			  	  WHERE  num_os= pNum_os),
		 cod_estado   = vEst_Ant,
		 num_ospadre  = NULL,
		 num_osf	  = 0,
		 num_osftotal = NULL
		 WHERE num_os= pNum_os;
	end if;

	 delete from pv_erecorrido
	 WHERE num_os     = pNum_os
	 AND   cod_estado = pCod_estado;


	 sError := 'PROCESO FINALIZO OK';

EXCEPTION
     WHEN NO_DATA_FOUND THEN
       sError := 'Error en consulta en tabla PV_ARCOS';
     WHEN OTHERS THEN
       sError := SQLCODE||substr(SQLERRM,1,255);

END PV_REPROCESO_SOLERR_PR;
/
SHOW ERRORS
