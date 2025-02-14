CREATE OR REPLACE PROCEDURE PV_PRC_EJECUTA_OSPENDIENTES (
--Verifica si existe OoSs pendiente
    	  v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
	 nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------

     vCantidad         NUMBER(3);
	 --n_estado_mensaje  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
     iTIPESTADOA        NUMBER(2);
	 iCODESTADO        NUMBER(3);
	 nestado         NUMBER(3);
	 iTIPESTADOB        NUMBER(2);
	 iCODESTCANCELADA	NUMBER(2);
	 iMAXINTENTOS		NUMBER(2);	 -- 72315|04-11-2008|EFR.

	 V_DES_VALOR       GED_CODIGOS.DES_VALOR%TYPE;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 vACTABO  		:= string(4);
	 nABONADO 		:= -1;
     nABONADO 		:= TO_NUMBER(string(5));
	 nCLIENTE       := -1;
	 nCLIENTE       := TO_NUMBER(string(6));

     bRESULTADO  := 'TRUE';
	 vCantidad   := 0;
	 iTIPESTADOA := 3;
	 iTIPESTADOB := 1;


	 BEGIN

		 SELECT VAL_PARAMETRO
		 INTO iCODESTADO
		 FROM GED_PARAMETROS
		 WHERE NOM_PARAMETRO = 'ESTADO_PV_MENSAJE';

		 EXCEPTION
			 WHEN NO_DATA_FOUND THEN
	             bRESULTADO := 'FALSE';
	             vMENSAJE   := 'NO SE ENCONTRO PARAMETRO ESTADO_PV_MENSAJES EN GED_PARAMETROS.' || SQLERRM || '.';

     END;

	 BEGIN

		 SELECT VAL_PARAMETRO
		 INTO iCODESTCANCELADA
		 FROM GED_PARAMETROS
		 WHERE NOM_PARAMETRO = 'EST_BAJA_CANCELADA';

		 EXCEPTION
			 WHEN NO_DATA_FOUND THEN
	             bRESULTADO := 'FALSE';
	             vMENSAJE   := 'NO SE ENCONTRO PARAMETRO EST_BAJA_CANCELADA EN GED_PARAMETROS.' || SQLERRM || '.';

     END;

	 --INI 72315|04-11-2008|EFR.
	 BEGIN

		 SELECT VAL_PARAMETRO
		 INTO iMAXINTENTOS
		 FROM GED_PARAMETROS
		 WHERE NOM_PARAMETRO = 'MAX_INTENTOS';

		 EXCEPTION
			 WHEN NO_DATA_FOUND THEN
	             bRESULTADO := 'FALSE';
	             vMENSAJE   := 'NO SE ENCONTRO PARAMETRO MAX_INTENTOS EN GED_PARAMETROS.' || SQLERRM || '.';

     END;
	 --FIN 72315|04-11-2008|EFR.



     IF nABONADO <> -1 THEN
     --Si la OOSS es por un abonado

	    --INI 72315|04-11-2008|EFR.
		/*
        SELECT COUNT(*)
		INTO vCantidad
		FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
	    WHERE A.NUM_OS = B.NUM_OS
	   	AND A.NUM_OS = C.NUM_OS
	   	AND B.NUM_OS = C.NUM_OS
	   	AND B.NUM_ABONADO = nABONADO
	   	AND A.COD_ESTADO < iCODESTADO
		AND A.COD_ESTADO <> iCODESTCANCELADA
	   	AND A.COD_ESTADO = C.COD_ESTADO
	  	AND ( C.TIP_ESTADO = iTIPESTADOA OR C.TIP_ESTADO = iTIPESTADOB);

	  	IF vCantidad <> 0 THEN
	  	    nestado:=0;
	  	    begin


		  	    SELECT a.cod_estado
			    INTO nestado
			    FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
			    WHERE A.NUM_OS = B.NUM_OS
			   	AND A.NUM_OS = C.NUM_OS
			   	AND B.NUM_OS = C.NUM_OS
			   	AND B.NUM_ABONADO = nABONADO
                and a.cod_os  in ('10020','10233','10530','10539','10022')
                AND NUM_INTENTOS IS NULL
			   	and rownum= 1;

			    if nestado > 110 then
		               vCantidad:=1;
                elsif nestado>0  then
                       vCantidad:=0;
			    end if;
				*/
				SELECT COUNT(a.cod_estado)
			    INTO vCantidad
			    FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
			    WHERE A.NUM_OS = B.NUM_OS
			   	AND A.NUM_OS = C.NUM_OS
			   	AND B.NUM_OS = C.NUM_OS
			   	AND B.NUM_ABONADO = nABONADO
                and a.cod_os  in ('10020','10233','10530','10539','10022')
                and C.TIP_ESTADO = iTIPESTADOA;

				IF vCantidad = 0 THEN
					SELECT COUNT(a.cod_estado)
					INTO vCantidad
				    FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
				    WHERE A.NUM_OS = B.NUM_OS
				   	AND A.NUM_OS = C.NUM_OS
				   	AND B.NUM_OS = C.NUM_OS
				   	AND B.NUM_ABONADO = nABONADO
	                and a.cod_os  in ('10020','10233','10530','10539','10022')
	                and C.TIP_ESTADO = 4
					and NVL(A.NUM_INTENTOS,0) < iMAXINTENTOS;
				END IF;
/*
		     exception
		        when no_data_found then
		               null;
		     end;

	  	end if;*/
		--FIN 72315|04-11-2008|EFR.

	  ELSIF nCLIENTE <> -1 THEN
	  --Si la OOSS es por un Cliente

		  SELECT COUNT(*)
		  INTO vCantidad
		  FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
	      WHERE A.NUM_OS = B.NUM_OS
    	  AND A.NUM_OS = C.NUM_OS
	   	  AND B.NUM_OS = C.NUM_OS
	   	  AND B.COD_CLIENTE = nCLIENTE
	   	  AND A.COD_ESTADO < iCODESTADO
		  AND A.COD_ESTADO <> iCODESTCANCELADA
	   	  AND A.COD_ESTADO = C.COD_ESTADO
	  	  AND ( C.TIP_ESTADO = iTIPESTADOA OR C.TIP_ESTADO = iTIPESTADOB);

	  	  IF vCantidad <> 0 THEN
	  	    nestado:=0;
	  	    begin

	  	    SELECT a.cod_estado
		    INTO nestado
		    FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
		    WHERE A.NUM_OS = B.NUM_OS
		   	AND A.NUM_OS = C.NUM_OS
		   	AND B.NUM_OS = C.NUM_OS
		   	AND B.cod_cliente =nCLIENTE
		   	and a.cod_os  in ('10020','10233','10530','10539','10022')
                and a.cod_estado > 110
                AND NUM_INTENTOS IS NULL
		        and rownum= 1;

		        if nestado > 110 then
		               vCantidad:=1;
                elsif nestado>0  then
                       vCantidad:=0;
			    end if;

		    exception
		       when no_data_found then
	                   null;
		    end;

	  	end if;
      END IF;

      IF vCantidad <> 0 THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'ABONADO TIENE ORDEN DE SERVICIO PENDIENTE';
      END IF;

EXCEPTION
   WHEN OTHERS THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'ERROR EN PV_PRC_EJECUTA_OSPENDIENTES: NO SE PUEDE VALIDAR OOSS PENDIENTES.' || SQLERRM || '.';

END;
/
SHOW ERRORS
