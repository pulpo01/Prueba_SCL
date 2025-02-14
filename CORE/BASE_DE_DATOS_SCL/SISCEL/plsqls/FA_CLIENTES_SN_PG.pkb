CREATE OR REPLACE PACKAGE BODY Fa_Clientes_Sn_Pg AS

 CN_TIPO_DISTRIB_ELECTRONICA NUMBER(1) := 1;
 CN_TIPO_DISTRIB_FISICA NUMBER(1) := 0;
 CV_NOM_PARAM_DESP_ELECT VARCHAR2(20) := 'COD_DESPACHO_ELECTR';
 CV_NOM_PARAM_DESP_FISICO VARCHAR2(20) := 'COD_DESPACHO_FISICO';
 CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';


  PROCEDURE FA_REGISTRA_CAMBIOS_ODBC_PR ( NUMTRANSACCION   IN VARCHAR2,
                                          COD_CLIENTE      IN VARCHAR2,
										  FEC_DESDE        IN VARCHAR2,
										  TIP_DISTRIBUCION IN VARCHAR2,
										  NOM_EMAIL        IN VARCHAR2,
										  NOM_USUARIO      IN VARCHAR2) AS

  sOraGlosa   VARCHAR2(255);
  nNUMTRANSACCION   GA_TRANSACABO.NUM_TRANSACCION%TYPE;
  nCOD_CLIENTE      GE_CLIENTES.COD_CLIENTE%TYPE;
  dFEC_DESDE        DATE;
  nTIP_DISTRIBUCION NUMBER(1);

  SN_COD_RETORNO   NUMBER(10);
  SV_MENS_RETORNO  VARCHAR2(255);
  SN_NUM_EVENTO    NUMBER(10);

  BEGIN

    nNUMTRANSACCION := TO_NUMBER(NUMTRANSACCION);
    --DBMS_OUTPUT.PUT_LINE ( 'nNUMTRANSACCION = ' || nNUMTRANSACCION );
    nCOD_CLIENTE :=TO_NUMBER(COD_CLIENTE);
    --DBMS_OUTPUT.PUT_LINE ( 'nCOD_CLIENTE = ' || nCOD_CLIENTE );
    dFEC_DESDE := TO_DATE(FEC_DESDE,'DD-MM-YYYY HH24:MI:SS');
    --DBMS_OUTPUT.PUT_LINE ( 'dFEC_DESDE = ' || dFEC_DESDE );
    nTIP_DISTRIBUCION:= TO_NUMBER(TIP_DISTRIBUCION);
    --DBMS_OUTPUT.PUT_LINE ( 'nTIP_DISTRIBUCION = ' || nTIP_DISTRIBUCION );

    FA_REGISTRA_CAMBIOS_PR ( nCOD_CLIENTE ,dFEC_DESDE , nTIP_DISTRIBUCION , NOM_EMAIL, NOM_USUARIO  ,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);

	IF SN_COD_RETORNO <> 0 THEN
	  SN_COD_RETORNO := 1;
	END IF;

    INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
    VALUES (
           nNUMTRANSACCION,
           SN_COD_RETORNO,
           SUBSTR('/' || COD_CLIENTE || '/' || SV_MENS_RETORNO,1,255)
          );
   EXCEPTION
   WHEN OTHERS THEN
      sOraGlosa := SUBSTR(SQLERRM,1,255);
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
      VALUES (
              nNUMTRANSACCION,
              1,
              SUBSTR('/' || COD_CLIENTE || '/' || sOraGlosa,1,255)
             );
  END;


 PROCEDURE FA_REGISTRA_CAMBIOS_PR ( COD_CLIENTE NUMBER,FEC_DESDE DATE, TIP_DISTRIBUCION NUMBER, NOM_EMAIL  VARCHAR2, NOM_USUARIO VARCHAR2,SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER) AS

    TE_cliente  FA_CLIENTE_DTO_OT;


  BEGIN
    TE_cliente := NEW FA_CLIENTE_DTO_OT();
	TE_cliente.COD_CLIENTE := COD_CLIENTE;
    TE_cliente.FEC_DESDE := FEC_DESDE;
    TE_cliente.TIP_DISTRIBUCION := TIP_DISTRIBUCION;
    TE_cliente.NOM_EMAIL := NOM_EMAIL;
    TE_cliente.NOM_USUARIO:= NOM_USUARIO;
    FA_REGISTRA_CAMBIOS_PR (TE_cliente , SN_COD_RETORNO , SV_MENS_RETORNO, SN_NUM_EVENTO);
  END;

 PROCEDURE FA_REGISTRA_CAMBIOS_PR (TE_cliente IN FA_CLIENTE_DTO_OT, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER) AS
 /*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "FA_REGISTRA_CAMBIOS_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera parametro desde fa_parametros simples</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="te_clietne " Tipo="FA_CLIENTE_DTO_OT">Estructura de cliente</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 ERROR_VALIDACION EXCEPTION;
 ERROR_CONTROLADO EXCEPTION;

 lo_cliente FA_CLIENTE_DTO_OT;
 lo_cliente_aux FA_CLIENTE_DTO_OT;
 ld_fecha_sist DATE;
 lv_cod_despacho_elect VARCHAR2(100);
 lv_cod_despacho VARCHAR2(100);

 LV_sql VARCHAR2(1000);
 BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

	 lo_cliente_aux  := te_cliente;

	---- validaciones preliminares

	IF lo_cliente_aux.cod_cliente IS NULL THEN
	   sn_cod_retorno := 1820;
	   RAISE error_validacion;
	END IF;

	IF lo_cliente_aux.fec_desde IS NULL THEN
	   sn_cod_retorno := 1975; --
	   RAISE error_validacion;
	END IF;

	IF lo_cliente_aux.tip_distribucion IS NULL AND
	   lo_cliente_aux.cod_despacho IS NULL AND
	   lo_cliente_aux.nom_email IS NULL THEN
	    --SALIR CON ESTADO OK, NO HAY DATOS QUE MODIFICAR
        RETURN;
	END IF;

	IF lo_cliente_aux.tip_distribucion NOT IN (CN_TIPO_DISTRIB_FISICA,CN_TIPO_DISTRIB_ELECTRONICA) THEN
	   sn_cod_retorno := 1930; -- -1000 Tipo de distribución informada debe ser 0 o 1
	   RAISE error_validacion;
	END IF;

	--inicializar instancia de FA_CLIENTE_DTO_OT
	lo_cliente := NEW FA_CLIENTE_DTO_OT();
	-- recuperar datos del cliente
	-- Inc 72847 PPV 12/11/2008 aqui se cambio de lugar para ir a buscar si existe en la tabla FA_CLIENTE_TO
	ld_fecha_sist := SYSDATE;
	lo_cliente.fec_desde := ld_fecha_sist;
	-- Fin Inc 72847 PPV 12/11/2008
	lo_cliente.cod_cliente := lo_cliente_aux.cod_cliente;
	Fa_Cliente_Sb_Pg.FA_RECUPERA_CLIENTE_PR( lo_cliente, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	IF sn_cod_retorno !=0 THEN
	   RAISE error_controlado;
	END IF;

	Fa_Cliente_Sb_Pg.FA_RECUPERA_PARAM_PR(CV_NOM_PARAM_DESP_ELECT, lv_cod_despacho_elect, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	IF sn_cod_retorno != 0 THEN
	   RAISE error_controlado;
	END IF;


	IF lo_cliente_aux.cod_despacho != lv_cod_despacho_elect	AND
	   lo_cliente_aux.tip_distribucion = CN_TIPO_DISTRIB_ELECTRONICA
	  THEN
	    --si informaron tip_distribucion electronica entonces cod_despacho no debe ser != electronico
	    sn_cod_retorno := 1931; -- -1100 Código de despacho informado no corresponde a un código de despacho electrónico
	    RAISE error_validacion;
	END IF;

	--Validar cod_despacho enviado (val 3.2)
	IF lo_cliente_aux.cod_despacho = lv_cod_despacho_elect	AND
	   (lo_cliente_aux.tip_distribucion != CN_TIPO_DISTRIB_ELECTRONICA  )
	  THEN
	    --si informaron cod_despacho electronico entonces explicitamente tip_distribucion debe ser electronica
	    sn_cod_retorno := 1933; -- -1400 Se informó un código de despacho electrónico pero no coincide con el tipo de distribución informado
	    RAISE error_validacion;
	END IF;

	-- Inc 72847 PPV 12/11/2008 se cambia de lugar para ir a buscar si existe en la tabla FA_CLIENTE_TO
	--ld_fecha_sist := SYSDATE;

	IF lo_cliente IS NOT NULL THEN

	   IF lo_cliente_aux.fec_desde > ld_fecha_sist THEN
	       sn_cod_retorno := 1974;
	       RAISE error_validacion;
	   END IF;

	   IF lo_cliente_aux.fec_desde < lo_cliente.FEC_DESDE THEN
	       sn_cod_retorno := 1974;
	       RAISE error_validacion;
	   END IF;


	   IF lo_cliente.cod_despacho = lv_cod_despacho_elect THEN
	      lo_cliente.tip_distribucion := CN_TIPO_DISTRIB_ELECTRONICA;
	   ELSE
	      lo_cliente.tip_distribucion := CN_TIPO_DISTRIB_FISICA;
	   END IF;

	   IF lo_cliente.tip_distribucion =  CN_TIPO_DISTRIB_FISICA
	      AND lo_cliente_aux.tip_distribucion = CN_TIPO_DISTRIB_ELECTRONICA THEN
		  --si es tip_distrib. elect entonces asignamos el codigo de despacho electronico
		  lo_cliente_aux.cod_despacho := lv_cod_despacho_elect;
	   ELSIF lo_cliente.tip_distribucion = CN_TIPO_DISTRIB_ELECTRONICA
	      AND lo_cliente_aux.tip_distribucion =  CN_TIPO_DISTRIB_FISICA THEN
	      --si es tipo de distribución FISICA
		  IF lo_cliente_aux.cod_despacho = lv_cod_despacho_elect THEN
			 --si es tipo distrib. FISICA no puede haberse enviado el cod.despacho electronico
			 sn_cod_retorno := 1932; -- -1200 Código de despacho informado no puede ser despacho electrónico
			 RAISE error_validacion;
		  END IF;

		  IF lo_cliente_aux.cod_despacho IS NULL THEN
			     --RECUPERAR EL ÚLTIMO CODIGO DESPACHO NO ELECTRONICO
				 Fa_Cliente_Sp_Pg.FA_REC_COD_DESP_NO_ELECT_PR( lo_cliente_aux.cod_cliente,
				                                               lv_cod_despacho_elect,
															   lo_cliente.fec_desde,
															   lv_cod_despacho,
															   sn_cod_retorno, sv_mens_retorno, sn_num_evento );

                IF SN_COD_RETORNO = 1920 THEN
			       Fa_Cliente_Sb_Pg.FA_RECUPERA_PARAM_PR(CV_NOM_PARAM_DESP_FISICO, lv_cod_despacho, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

             	   IF sn_cod_retorno != 0 THEN
                      RAISE error_controlado;
            	   END IF;
			    END IF;

				IF sn_cod_retorno <> 0 THEN
				   RAISE ERROR_CONTROLADO;
				END IF;
				lo_cliente_aux.cod_despacho := lv_cod_despacho;
		   END IF;
		END IF;

		--Validar cod_despacho enviado (val 3.2)
    	IF lo_cliente_aux.cod_despacho = lv_cod_despacho_elect	AND lo_cliente.cod_despacho != lv_cod_despacho_elect
		  AND lo_cliente_aux.tip_distribucion IS NULL
		 THEN
	       --si informaron cod_despacho electronico entonces explicitamente tip_distribucion debe ser electronica
	        sn_cod_retorno := 1935; -- -1400 Se informó un código de despacho electrónico pero no coincide con el tipo de distribución informado
	        RAISE error_validacion;
	    END IF;

	ELSE

	   IF lo_cliente_aux.tip_distribucion = CN_TIPO_DISTRIB_ELECTRONICA THEN
		  --si es tip_distrib. elect entonces asignamos el codigo de despacho electronico
		  lo_cliente_aux.cod_despacho := lv_cod_despacho_elect;
	   ELSIF lo_cliente_aux.tip_distribucion =  CN_TIPO_DISTRIB_FISICA THEN
	      --si es tipo de distribución FISICA
		  IF lo_cliente_aux.cod_despacho = lv_cod_despacho_elect THEN
			 --si es tipo distrib. FISICA no puede haberse enviado el cod.despacho electronico
			 sn_cod_retorno := 1932;-- -1200 Código de despacho informado no puede ser despacho electrónico
			 RAISE error_validacion;
		  END IF;

		  IF lo_cliente_aux.cod_despacho IS NULL THEN
			  --RECUPERAR EL ÚLTIMO CODIGO DESPACHO NO ELECTRONICO
			  Fa_Cliente_Sp_Pg.FA_REC_COD_DESP_NO_ELECT_PR( lo_cliente_aux.cod_cliente,
				                                            lv_cod_despacho_elect,
															lo_cliente.fec_desde,
															lv_cod_despacho,
															sn_cod_retorno, sv_mens_retorno, sn_num_evento );


              IF SN_COD_RETORNO = 1920 THEN
			     Fa_Cliente_Sb_Pg.FA_RECUPERA_PARAM_PR(CV_NOM_PARAM_DESP_FISICO, lv_cod_despacho, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

             	 IF sn_cod_retorno != 0 THEN
                   RAISE error_controlado;
            	 END IF;


			  END IF;

			  IF sn_cod_retorno <> 0 THEN
				   RAISE ERROR_CONTROLADO;
			  END IF;
			  lo_cliente_aux.cod_despacho := lv_cod_despacho;
		   END IF;
		END IF;
	END IF;

	--------------------------

	IF lo_cliente IS NULL THEN
	   ---no está el cliente y se inserta con los datos que viene
	   lo_cliente:= lo_cliente_aux;

	   IF lo_cliente_aux.nom_usuario IS NULL THEN
	     lo_cliente.nom_usuario := USER;
	   ELSE
	     lo_cliente.nom_usuario := lo_cliente_aux.nom_usuario;
	   END IF;

	   lo_cliente.fec_desde := ld_fecha_sist;

	   lo_cliente.fec_ultmod := ld_fecha_sist;
	   lo_cliente.fec_hasta := NULL;

	   LV_sql := 'fa_cliente_sb_pg.fa_inserta_pr';
	   Fa_Cliente_Sb_Pg.fa_inserta_pr( lo_cliente, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	   IF SN_COD_RETORNO != 0 THEN
		   RAISE error_controlado;
	   END IF;

	ELSIF nvl(lo_cliente.cod_despacho,'*') != nvl(lo_cliente_aux.cod_despacho,'*') OR
	      nvl(lo_cliente.nom_email,'*') != nvl(lo_cliente_aux.nom_email,'*') THEN
	   IF lo_cliente_aux.nom_usuario IS NULL THEN
	     lo_cliente.nom_usuario := USER;
	   ELSE
	     lo_cliente.nom_usuario := lo_cliente_aux.nom_usuario;
	   END IF;

	   lo_cliente.fec_ultmod := ld_fecha_sist;

	   --colocar termino de vigencia al registro
	   lo_cliente.fec_hasta := lo_cliente_aux.fec_desde - (1/24/60/60); --LA FECHA MENOS 1 SEGUNDO

	   Fa_Cliente_Sb_Pg.FA_ACTUALIZA_VIGENCIA_PR( lo_cliente, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	   IF SN_COD_RETORNO != 0 THEN
	      RAISE error_controlado;
	   END IF;

	   --agregar nuevo registro
	   lo_cliente.fec_desde := lo_cliente_aux.fec_desde;

	   IF lo_cliente_aux.cod_despacho IS NOT NULL THEN
	      lo_cliente.cod_despacho:= lo_cliente_aux.cod_despacho;
	   END IF;

	   IF lo_cliente_aux.nom_email IS NOT NULL THEN
	   	  lo_cliente.nom_email := lo_cliente_aux.nom_email;
	   END IF;

	   lo_cliente.fec_hasta := NULL;

	   LV_sql := 'fa_cliente_sb_pg.fa_inserta_pr';
	   Fa_Cliente_Sb_Pg.fa_inserta_pr( lo_cliente, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	   IF SN_COD_RETORNO != 0 THEN
		  RAISE error_controlado;
	   END IF;
	END IF;

 EXCEPTION
   WHEN ERROR_CONTROLADO THEN
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTES_SN_PG.FA_REGISTRA_CAMBIOS_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );

   WHEN ERROR_VALIDACION THEN
  	   IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	     SV_mens_retorno := CV_error_no_clasif;
 	   END IF;
  	   SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTES_SN_PG.FA_REGISTRA_CAMBIOS_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );

   WHEN OTHERS THEN
       SN_COD_RETORNO := 1934; -- -1500 Error en proceso de registro de los cambios de información del cliente en facturación.
  	   IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	     SV_mens_retorno := CV_error_no_clasif;
 	   END IF;
  	   SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTES_SN_PG.FA_REGISTRA_CAMBIOS_PR', lv_sql, SQLCODE, SQLERRM );

 END;

END;
/
SHOW ERRORS
