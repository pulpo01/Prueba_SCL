CREATE OR REPLACE PACKAGE BODY Fa_Cargos_Sn_Pg AS
-------------------------------------------------------------------------------

   FUNCTION pv_rec_plan_comercial_fn (
      fa_cargos          IN  OUT         FA_CARGOS_QT,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_VAL_TIPO_SINIESTRO_FN"
	      Lenguaje="PL/SQL"
	      Fecha="20-11-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="CAGV"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna val tipo siniestro</Descripción>>
	      <Parámetros>
	         <Entrada>
			    <param nom="eo_dat_abo" Tipo="OBJETO ">Datos abonado</param>>
	            <param nom="en_tipo_terminal" Tipo="NUMERICO">Tipo terminal</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
IS

	LN_contador	 NUMBER;
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;

	BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

	LV_sSql:= ' SELECT cod_plancom'
	       || ' FROM GA_CLIENTE_PCOM'
 	       || ' WHERE cod_cliente = '||fa_cargos.cod_cliente;

    SELECT cod_plancom
	  INTO fa_cargos.cod_plancom
	  FROM GA_CLIENTE_PCOM
	 WHERE cod_cliente = fa_cargos.cod_cliente;

	 RETURN TRUE;

	EXCEPTION
    	WHEN NO_DATA_FOUND THEN
           SN_cod_retorno := 999;
           SV_mens_retorno := 'No se encontro el plan comercial para el cliente - ['||fa_cargos.cod_cliente||']';
           LV_des_error   := 'PV_VAL_TIPO_SINIESTRO_FN(); - ' || SQLERRM;
           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,'FA', SV_mens_retorno, CV_version, USER,'FA_CARGOS_SN_PG.PV_VAL_TIPO_SINIESTRO_FN',LV_sSQL, SN_cod_retorno, LV_des_error );
           RETURN FALSE;
    	WHEN OTHERS THEN
     	   SN_cod_retorno := 999;
     	   IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
     	      SV_mens_retorno := CV_error_no_clasif;
     	   END IF;
           LV_des_error   := 'PV_VAL_TIPO_SINIESTRO_FN(); - ' || SQLERRM;
           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,'FA', SV_mens_retorno, CV_version, USER,'FA_CARGOS_SN_PG.PV_VAL_TIPO_SINIESTRO_FN',LV_sSQL, SN_cod_retorno, LV_des_error );
           RETURN FALSE;
END pv_rec_plan_comercial_fn;

-------------------------------------------------------------------------------
PROCEDURE FA_CARGOS_ALTA_PR (REGISTRO        IN   FA_CARGOS_QT,
 	                        SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                        SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                        SN_num_evento       OUT NOCOPY ge_errores_pg.evento
) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_ALTA_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado de hacer el alta de los cargos ocacionales</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LS_RegGeCargos	  GE_CARGOS_QT:=Pv_Inicia_Estructuras_Pg.GE_CARGOS_QT_FN;

ERR_CLIENTE_ERRONEO		   EXCEPTION;
ERR_CLIENTEABONADO_ERRONEO EXCEPTION;
ERR_FECHA_ANTERIOR         EXCEPTION;
ERR_CARGO_ERRONEO          EXCEPTION;
ERR_CONCEPTO_ERRONEO       EXCEPTION;
ERR_PRODUCTO_ERRONEO	   EXCEPTION;
ERR_CARGO_REC_ALTA_ERROR   EXCEPTION;
ERR_CICLFACT_ERRONEO	   EXCEPTION;
ERR_INSERTA_CARGOS		   EXCEPTION;
ERR_IMPORTE_ERRONEO		   EXCEPTION;
ERR_MONEDA_ERRONEO		   EXCEPTION;
ERR_VENTA_TRANS_ERRONEO	   EXCEPTION;
ERR_TRAS_CARGOS			   EXCEPTION;
ERR_PLANCOM_ERROR		   EXCEPTION;
error_ejecucion            EXCEPTION;
REGISTRO_TMP FA_CARGOS_QT:=REGISTRO;

BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    ---------------------------------------------------------------------------
	-- Recupera Plan Comercial del Cliente
	---------------------------------------------------------------------------

	IF NOT pv_rec_plan_comercial_fn(REGISTRO_TMP,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
	   RAISE error_ejecucion;
	END IF;
	---------------------------------------------------------------------------
	-- VALIDACIONES GENERALES
	---------------------------------------------------------------------------



    SELECT  DECODE(TRIM(REGISTRO.NUM_GUIA),'',NULL,REGISTRO.NUM_GUIA) INTO REGISTRO_TMP.NUM_GUIA FROM DUAL;


    SELECT  DECODE(TRIM(REGISTRO.NUM_PREGUIA),'',NULL,REGISTRO.NUM_PREGUIA) INTO REGISTRO_TMP.NUM_PREGUIA FROM DUAL;


    IF  REGISTRO.COD_CLIENTE IS NULL THEN
		RAISE ERR_CLIENTE_ERRONEO;
	END IF;

    -- Valida fecha de alta
    IF REGISTRO.FEC_ALTA IS NULL THEN
        REGISTRO_TMP.FEC_ALTA := SYSDATE;
    END IF;

    IF TO_DATE (TO_CHAR(REGISTRO.FEC_ALTA,'YYYYMMDD'),'YYYYMMDD') < TO_DATE (TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') THEN
        RAISE ERR_FECHA_ANTERIOR;
    END IF;
    LV_sSql := 'FA_CARGOS_SB_PG.FA_VALIDA_CONCEPTO_FN('||REGISTRO_TMP.cod_concepto||')';
    IF REGISTRO.COD_CONCEPTO IS NULL OR
	   NOT Fa_Cargos_Sb_Pg.FA_VALIDA_CONCEPTO_FN (REGISTRO_TMP.cod_concepto ,
				                                  SN_cod_retorno  ,
				                                  SV_mens_retorno ,
				                                  SN_num_evento   ) THEN
        RAISE ERR_CONCEPTO_ERRONEO;
    END IF;
    LV_sSql := 'SELECT GE_SEQ_CARGOS.NEXTVAL';
	IF REGISTRO.SEQ_CARGO IS NULL THEN
		SELECT GE_SEQ_CARGOS.NEXTVAL
		  INTO REGISTRO_TMP.SEQ_CARGO
		  FROM DUAL;
    END IF;

    LV_sSql := 'FA_CARGOS_SB_PG.FA_VALIDA_CODMONEDA_FN('||REGISTRO_TMP.COD_MONEDA||')';
	IF REGISTRO.COD_MONEDA IS NULL OR
	   NOT Fa_Cargos_Sb_Pg.FA_VALIDA_CODMONEDA_FN (REGISTRO_TMP.COD_MONEDA ,
				                                   SN_cod_retorno  ,
				                                   SV_mens_retorno ,
				                                   SN_num_evento   ) THEN
	    RAISE ERR_MONEDA_ERRONEO;
	END IF;

	IF REGISTRO.Imp_CARGO IS NULL THEN
	    RAISE ERR_IMPORTE_ERRONEO;
	END IF;

    IF REGISTRO.COLUMNA IS NULL THEN
        REGISTRO_TMP.COLUMNA := 1;
    END IF;

    IF REGISTRO.NUM_UNIDADES IS NULL THEN
        REGISTRO_TMP.NUM_UNIDADES := 1;
    END IF;

    IF REGISTRO.IND_FACTUR IS NULL THEN
        REGISTRO_TMP.IND_FACTUR := 1;
    END IF;

    IF REGISTRO.NUM_FACTURA IS NULL THEN
        REGISTRO_TMP.NUM_FACTURA := 0;
    END IF;


    -- (+) EV 26-03-2010, Se quita abonado cero y se reemplaza por el primer abonado activo
    IF (REGISTRO.NUM_ABONADO = 0) THEN

        SELECT MAX(ABONADO) INTO REGISTRO_TMP.NUM_ABONADO 
        FROM (
                SELECT MIN(NUM_ABONADO) AS ABONADO 
                    FROM GA_ABOCEL   
                    WHERE COD_CLIENTE = REGISTRO.COD_CLIENTE 
                    AND COD_SITUACION NOT IN ('BAA','BAP')
                UNION
                SELECT MIN(NUM_ABONADO) AS ABONADO
                    FROM GA_ABOAMIST   
                    WHERE COD_CLIENTE = REGISTRO.COD_CLIENTE
                    AND COD_SITUACION NOT IN ('BAA','BAP')
             );
        
    END IF;   
    -- (-) EV 26-03-2010, Se quita abonado cero y se reemplaza por el primer abonado activo

	IF REGISTRO.COD_CICLFACT IS NULL THEN
	---------------------------------------------------------------------------
	-- CARGOS OCACIONALES NO CICLO
	---------------------------------------------------------------------------
		IF REGISTRO.NUM_VENTA IS NULL AND
		   REGISTRO.NUM_TRANSACCION IS NULL THEN
			RAISE ERR_VENTA_TRANS_ERRONEO;
		END IF;

		REGISTRO_TMP.NUM_VENTA := NVL(REGISTRO_TMP.NUM_VENTA,0);
		REGISTRO_TMP.NUM_TRANSACCION := NVL(REGISTRO_TMP.NUM_TRANSACCION,0);
	    IF REGISTRO.COD_PLANCOM IS NULL THEN
	        RAISE ERR_PLANCOM_ERROR;
	    END IF;

		-- TRASPASA LA INFORMACION AL REGISTRO DE GE_CARGOS


   		LV_sSql := 'FA_CARGOS_SB_PG.FA_TRAS_REGS_CARGOS_FN';
		IF NOT Fa_Cargos_Sb_Pg.FA_TRAS_REGS_CARGOS_FN ( REGISTRO_TMP,
								  LS_RegGeCargos,
	                              SN_cod_retorno,
	                              SV_mens_retorno,
	                              SN_num_evento) THEN
			RAISE ERR_TRAS_CARGOS;
		END IF;

		-- Insert del cargo ocacional NO ciclo
		BEGIN
   			LV_sSql := 'GE_CARGOS_SP_PG.GE_CARGOS_I_PR';
			Ge_Cargos_Sp_Pg.GE_CARGOS_I_PR ( LS_RegGeCargos,
					                         SN_cod_retorno ,
						                     SV_mens_retorno,
						                     SN_num_evento );
		EXCEPTION
			WHEN OTHERS THEN
				RAISE ERR_INSERTA_CARGOS;
		END;
	ELSE
		---------------------------------------------------------------------------
		-- CARGOS OCACIONALES CICLO
		---------------------------------------------------------------------------
    	LV_sSql := 'FA_CARGOS_SB_PG.FA_VALIDA_CLIENTE_ABONADO_FN('||REGISTRO_TMP.COD_CLIENTE||', '||REGISTRO.NUM_ABONADO||')';

	    IF  REGISTRO.NUM_ABONADO IS NULL OR
	    	NOT Fa_Cargos_Sb_Pg.FA_VALIDA_CLIENTE_ABONADO_FN (REGISTRO_TMP.COD_CLIENTE,
						                                      REGISTRO.NUM_ABONADO,
						                                      SN_cod_retorno  ,
						                                      SV_mens_retorno ,
						                                      SN_num_evento   ) THEN
	        RAISE ERR_CLIENTEABONADO_ERRONEO;
	    END IF;

	    /*IF REGISTRO.ID_CARGO IS NULL THEN
	        RAISE ERR_CARGO_ERRONEO;
	    END IF;*/

/*	    IF REGISTRO.COD_PROD_CONTRATADO IS NULL THEN
	        RAISE ERR_PRODUCTO_ERRONEO;
	    END IF;*/

    	LV_sSql := 'FA_CARGOS_SB_PG.FA_VALIDA_CICLOFACT_FN('||REGISTRO_TMP.COD_CICLFACT||')';
		IF NOT Fa_Cargos_Sb_Pg.FA_VALIDA_CICLOFACT_FN ( REGISTRO_TMP.COD_CICLFACT,
					                                 	SN_cod_retorno  ,
					                                    SV_mens_retorno ,
					                                    SN_num_evento   ) THEN
	        RAISE ERR_CICLFACT_ERRONEO;
	    END IF;

		REGISTRO_TMP.NUM_VENTA := NVL(REGISTRO_TMP.NUM_VENTA,0);
		REGISTRO_TMP.NUM_TRANSACCION := NVL(REGISTRO_TMP.NUM_TRANSACCION,0);
	    IF REGISTRO.COD_PLANCOM IS NULL THEN
	        RAISE ERR_PLANCOM_ERROR;
	    END IF;

/*
		-- TRASPASA LA INFORMACION AL REGISTRO DE GE_CARGOS

   		LV_sSql := 'FA_CARGOS_SB_PG.FA_TRAS_REGS_CARGOS_FN';
		IF NOT Fa_Cargos_Sb_Pg.FA_TRAS_REGS_CARGOS_FN ( REGISTRO_TMP,
								  LS_RegGeCargos,
	                              SN_cod_retorno,
	                              SV_mens_retorno,
	                              SN_num_evento) THEN
			RAISE ERR_TRAS_CARGOS;
		END IF;

		-- Insert del cargo ocacional ciclo
		BEGIN
   			LV_sSql := 'GE_CARGOS_SP_PG.GE_CARGOS_I_PR';
			Ge_Cargos_Sp_Pg.GE_CARGOS_I_PR ( LS_RegGeCargos,
					                         SN_cod_retorno ,
						                     SV_mens_retorno,
						                     SN_num_evento );
		EXCEPTION
			WHEN OTHERS THEN
				RAISE ERR_INSERTA_CARGOS;
		END;*/
        -- INICIO INC 189196 23/10/2012
        IF      REGISTRO_TMP.IND_FACTUR <> 9 THEN
                -- Insert del cargo ocacional ciclo
                BEGIN
                
                        LV_sSql := 'FA_CARGOS_SB_PG.FA_TRAS_REGS_CARGOS_FN';
                        IF NOT Fa_Cargos_Sb_Pg.FA_TRAS_REGS_CARGOS_FN ( REGISTRO_TMP,
                                                  LS_RegGeCargos,
                                                  SN_cod_retorno,
                                                  SV_mens_retorno,
                                                  SN_num_evento) THEN
                            RAISE ERR_TRAS_CARGOS;
                        END IF;
                        
                        LV_sSql := 'GE_CARGOS_SP_PG.GE_CARGOS_I_PR';
                        Ge_Cargos_Sp_Pg.GE_CARGOS_I_PR ( LS_RegGeCargos,
                                                                                        SN_cod_retorno ,
                                                                                        SV_mens_retorno,
                                                                                        SN_num_evento );
                EXCEPTION
                        WHEN OTHERS THEN
                                RAISE ERR_INSERTA_CARGOS;
                END;
        ELSE
                -- Insert del cargo ocacional ciclo
                BEGIN
                        LV_sSql := 'FA_CARGOS_SP_PG.FA_CARGOS_TO_I_PR';
                        Fa_Cargos_Sp_Pg.FA_CARGOS_TO_I_PR ( REGISTRO_TMP,
                                                                                                SN_cod_retorno ,
                                                                                                SV_mens_retorno,
                                                                                                SN_num_evento );
                EXCEPTION
                        WHEN OTHERS THEN
                                RAISE ERR_INSERTA_CARGOS;
                END;
        END IF;
           
		-- Insert del cargo ocacional ciclo
		--BEGIN
    	--	LV_sSql := 'FA_CARGOS_SP_PG.FA_CARGOS_TO_I_PR';
		--	Fa_Cargos_Sp_Pg.FA_CARGOS_TO_I_PR ( REGISTRO_TMP,
					                         --SN_cod_retorno ,
						                     -- SV_mens_retorno,
						                     --SN_num_evento );
		--EXCEPTION
		--	WHEN OTHERS THEN
		--		RAISE ERR_INSERTA_CARGOS;
		--END;
        -- FIN INC 189196 23/10/2012    

	END IF;

	IF SN_cod_retorno <> 0 THEN
		RAISE ERR_CARGO_REC_ALTA_ERROR;
	END IF;

	LV_sSql := 'FA_CARGOS_INFACCEL_PR('||REGISTRO_TMP.COD_CLIENTE||', '||REGISTRO.NUM_ABONADO||', '||REGISTRO_TMP.COD_CICLFACT||')';
    FA_CARGOS_INFACCEL_PR (REGISTRO_TMP.COD_CLIENTE,
                                   REGISTRO.NUM_ABONADO,
                                   REGISTRO_TMP.COD_CICLFACT,
                                       SN_cod_retorno  ,
                                       SV_mens_retorno ,
                                       SN_num_evento   ) ;


    IF SN_cod_retorno <> 0 THEN
            RAISE ERR_CARGO_REC_ALTA_ERROR;
    END IF;



EXCEPTION
  WHEN ERR_TRAS_CARGOS THEN
      SN_cod_retorno := 1 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CLIENTE_ERRONEO THEN
      SN_cod_retorno := 2 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );
  WHEN ERR_IMPORTE_ERRONEO THEN
      SN_cod_retorno := 3 ; -- Generar otro codigo

      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_MONEDA_ERRONEO THEN
      SN_cod_retorno := 4 ; -- Generar otro codigo
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_INSERTA_CARGOS THEN
      SN_cod_retorno := 5 ; -- Generar otro codigo
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CICLFACT_ERRONEO THEN
      SN_cod_retorno := 6 ; -- Generar otro codigo
	  LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CLIENTEABONADO_ERRONEO THEN
      SN_cod_retorno := 7 ; -- Generar otro codigo
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CARGO_ERRONEO THEN
      SN_cod_retorno := 8 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_PRODUCTO_ERRONEO THEN
      SN_cod_retorno := 9 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CONCEPTO_ERRONEO THEN
      SN_cod_retorno := 10 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CARGO_REC_ALTA_ERROR THEN
      SN_cod_retorno := 11 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_VENTA_TRANS_ERRONEO THEN
      SN_cod_retorno := 12 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_PLANCOM_ERROR THEN
      SN_cod_retorno := 13 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );
  WHEN OTHERS THEN
      SN_cod_retorno := 14 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_ALTA_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_ALTA_PR;

-------------------------------------------------------------------------------
PROCEDURE FA_CARGOS_BAJA_PR (REGISTRO        IN   FA_CARGOS_QT,
	                         SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                         SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                         SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
	                         ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_BAJA_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado registrar la baja de cargos ocacionales</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error    ge_errores_pg.DesEvent;
LV_sSql         ge_errores_pg.vQuery;
LS_RegGeCargos	GE_CARGOS_QT;

ERR_PARAM_ERROR 	EXCEPTION;
ERR_CARGO_BAJA_ERROR	EXCEPTION;

BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;


	-- SE DEBE INFORMAR PRODUCTO O VENTA
	IF ((REGISTRO.COD_PROD_CONTRATADO IS NULL OR REGISTRO.COD_PROD_CONTRATADO = 0 ) AND
	   (REGISTRO.NUM_VENTA IS NULL OR REGISTRO.NUM_VENTA = 0 )) OR
	   (REGISTRO.COD_CLIENTE IS NULL OR REGISTRO.COD_CLIENTE = 0 )
	THEN
		RAISE ERR_PARAM_ERROR;
	END IF;

	IF REGISTRO.NUM_VENTA IS NULL OR
	   REGISTRO.NUM_VENTA = 0     THEN
	   	-- BORRA CARGOS OCACIONALES CICLO
		Fa_Cargos_Sp_Pg.FA_CARGOS_TO_D_PR (REGISTRO ,
			                               SN_Cod_retorno ,
			                               SV_Mens_retorno,
			                               SN_Num_evento  );
	ELSE
		-- BORRA CARGOS OCACIONALES NO CICLO
		LS_RegGeCargos.NUM_VENTA := REGISTRO.NUM_VENTA;
		Ge_Cargos_Sp_Pg.GE_CARGOS_D_PR (LS_RegGeCargos ,
			                               SN_Cod_retorno ,
			                               SV_Mens_retorno,
			                               SN_Num_evento  );
	END IF;
	IF SN_cod_retorno <> 0 THEN
		RAISE ERR_CARGO_BAJA_ERROR;
	END IF;

EXCEPTION
  WHEN ERR_PARAM_ERROR THEN
      SN_cod_retorno := 1 ; -- Generar otro codigo
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CARGO_BAJA_ERROR THEN
      SN_cod_retorno := 1 ; -- Generar otro codigo
      LV_des_error   := 'FA_CARGOS_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 1 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_TO_BAJA_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_TO_BAJA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_BAJA_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_CARGOS_INFACCEL_PR (EN_cod_cliente   IN GA_ABOCEL.cod_cliente%TYPE,
                                 EN_num_abonado   IN GA_ABOCEL.num_abonado%TYPE,
                                 EN_COD_CICLFACT  IN FA_CICLFACT.COD_CICLFACT%TYPE,
                             SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                             ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_INFACCEL_PR"
      Fecha modificacion=" "
      Fecha creacion="01-08-2008"
      Programador="OCB"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado registrar la baja de cargos ocacionales</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error    ge_errores_pg.DesEvent;
LV_sSql         ge_errores_pg.vQuery;


ERR_PARAM_ERROR     EXCEPTION;
ERR_CARGO_BAJA_ERROR    EXCEPTION;

BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;


    LV_sSQL := 'Update Ga_infaccel Set IND_CARGOS=[1] ';
    LV_sSQL := LV_sSQL || ' Where cod_cliente = [' || EN_cod_cliente  || ']';
    LV_sSQL := LV_sSQL || ' AND NUM_ABONADO = [' || EN_num_abonado || ']';
    LV_sSQL := LV_sSQL || ' AND COD_CICLFACT = [' || EN_COD_CICLFACT || ']';

    UPDATE GA_INFACCEL SET IND_CARGOS=1
    WHERE COD_CLIENTE =  EN_COD_CLIENTE
    AND NUM_ABONADO  =   EN_NUM_ABONADO
    AND COD_CICLFACT =   EN_COD_CICLFACT;


EXCEPTION

  WHEN no_data_found THEN
      SN_cod_retorno := 0 ; -- Generar otro codigo
      SV_Mens_retorno := NULL;
      SN_Num_evento   := 0;



  WHEN OTHERS THEN
      SN_cod_retorno := 1 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_INFACCEL_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SN_PG.FA_CARGOS_INFACCEL_PR',
                                                 LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_INFACCEL_PR;
END Fa_Cargos_Sn_Pg;
/
SHOW ERRORS