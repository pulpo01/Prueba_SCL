CREATE OR REPLACE PACKAGE BODY FA_BALANCE_CLI_PG
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_BALANCE_CLI_PR (EN_num_celular    IN   ga_abocel.num_celular%TYPE,
	                              SN_folio      	 OUT NOCOPY   NUMBER,
								  SN_saldo   		 OUT NOCOPY   NUMBER,
	                              SC_cargos_nuevos	 OUT NOCOPY   refcursor,
								  SV_fec_emision     OUT NOCOPY   VARCHAR2,
								  SV_fec_vcto		 OUT NOCOPY   VARCHAR2,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "FA_BALANCE_CLI_PR"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta balance de la cuenta CU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_folio" Tipo="NUMERICO">Numero de la ultima factura</param>
            <param nom="SN_saldo" Tipo="NUMERICO">Monto total de la deuda</param>
            <param nom="SC_cargos_nuevos" Tipo="CURSOR>Cargos nuevos<param>
            <param nom="SD_fec_emision" Tipo="Fecha"> Fecha de emision de la ultima factura<param>
            <param nom="SD_fec_vcto" Tipo="Fecha"> Fecha vencimiento de la ultima factura<param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS


        error_ejecucion      EXCEPTION;
		V_des_error		 	 ge_errores_pg.DesEvent;
        sSql             	 ge_errores_pg.vQuery;
		SV_deserror 		 ge_errores_pg.DesEvent;
   		EV_formato_fec       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
		SC_FACT_CLIE		 refcursor;
		LD_fec_pago			 DATE;
		LN_tot_pagar		 fa_histdocu.tot_pagar%TYPE;
		LV_des_tipdocum		 ge_tipdocumen.DES_TIPDOCUM%TYPE;
		LV_estado			 VARCHAR2(100);
	  	LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;
		SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_num_min          ga_abocel.num_min%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec	    ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
		SV_val_parametro    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
		LV_ejec_rest	   VARCHAR2(500);
		LV_fec_pago		   VARCHAR2(20);
		SN_COD_CICLFACT	   fa_ciclfact.cod_ciclfact%TYPE;

    BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;

		--Inicializa cursor....
		sSql:='OPEN SC_cargos_nuevos FOR'||
		      ' SELECT NULL cod_concepto, NULL des_concepto, NULL monto_sin_impuesto'||
		      ' FROM DUAL'||
              ' WHERE ROWNUM = 0;';

		OPEN SC_cargos_nuevos FOR
		SELECT NULL cod_concepto, NULL des_concepto, NULL monto_sin_impuesto
		FROM DUAL
        WHERE ROWNUM = 0;

		--Inicializar variables....
 	    SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
 		SV_tip_plantarif:=NULL;
		SV_cod_plantarif:=NULL;
		SV_num_serie:=NULL;
		SN_cod_ciclo:=NULL;
		SV_tecnologia:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_tip_terminal:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		SN_folio:=NULL;
		SV_fec_emision:=NULL;
		SV_fec_vcto:=NULL;
		LD_fec_pago:=NULL;
		LN_tot_pagar:=NULL;
		LV_des_tipdocum:=NULL;
		LV_estado:=NULL;
		EV_formato_fec:=NULL;

       --Validar si numero celular cumple con el largo definido...
		sSql:=SUBSTR('ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||');- '||SQLERRM,1,CN_largoquery);
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	       SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'') - '||SQLERRM,1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

	    --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||'); - '||SQLERRM,1,CN_largoquery);
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 then
		   SN_cod_retorno := '314';
		   sSql:=LV_des_cadena;
		   RAISE error_ejecucion;
		END IF;

        sSql:='GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn(FORMATO_SEL2,GE,1,'||SV_val_parametro||','||
             SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
	    IF GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn('FORMATO_SEL2','GE',1,SV_val_parametro,
          SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		  EV_formato_fec:= SV_val_parametro;
	    ELSE
           SN_cod_retorno := '302';
    	   RAISE  error_ejecucion;
		END IF;


   		-- Ejecutar procedimiento que obtiene datos del abonado, entre ellos el cod_cliente
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||'); - '||SQLERRM,1,CN_largoquery);
	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN
    	   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL THEN
           SN_cod_retorno := '146';
    	   RAISE  error_ejecucion;
		END IF;

		--Obtener datos de factura....
		sSql:='GA_CONS_PG.GA_CONS_FACTURAS_PR('||EN_NUM_CELULAR||','||EV_FORMATO_FEC||',1)';
	    GA_CONS_PG.GA_CONS_FACTURAS_PR(EN_NUM_CELULAR,
	  											   EV_FORMATO_FEC,
												   1,
												   SC_FACT_CLIE,
												   SN_COD_RETORNO,
												   SV_MENS_RETORNO,
												   SN_NUM_EVENTO);

		sSql:='FETCH SC_FACT_CLIE INTO SN_folio,LV_fec_emision,LV_fec_vcto,LV_fec_pago,'||
			  'LN_tot_pagar,LV_des_tipdocum,LV_estado';

 	    FETCH SC_FACT_CLIE INTO SN_folio,SV_fec_emision,SV_fec_vcto,LV_fec_pago,
	  		         	 	  LN_tot_pagar,LV_des_tipdocum,LV_estado;
        IF SC_FACT_CLIE%NOTFOUND THEN
	  	   NULL;
	    END IF;

		--Obtener saldo de la cuenta... ....
		sSql:='SN_saldo:=co_saldo_fn( '||SN_cod_cliente||')';
		SN_saldo:=co_saldo_fn(SN_cod_cliente);

		sSql:='GE_VALIDACIONES_PG.GE_OBTIENE_CICLOFACT_FN('||SN_cod_ciclo||')';
		SN_COD_CICLFACT:=0;
		IF NOT GE_VALIDACIONES_PG.GE_OBTIENE_CICLOFACT_FN(SN_cod_ciclo,SN_COD_CICLFACT,
		       SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO ) THEN
           SN_cod_retorno := '310';
		   RAISE error_ejecucion;
		END IF;

		--Obtener datos de los cargos ....
		sSql:=SUBSTR('OPEN SC_cargos_nuevos FOR '||
		      ' SELECT cargo.cod_concepto, conce.des_concepto, SUM(cargo.imp_cargo) AS monto_sin_impuesto '||
	    	  ' FROM ge_cargos cargo, fa_conceptos conce '||
			  ' WHERE cargo.cod_cliente ='||SN_cod_cliente||
			  ' AND cargo.cod_ciclfact='||SN_COD_CICLFACT||
			  ' AND cargo.cod_producto = 1'||
			  ' AND cargo.ind_factur=1'||
			  ' AND cargo.num_venta=0 '||
			  ' AND cargo.imp_cargo > 0 '||
			  ' AND cargo.cod_concepto = conce.cod_concepto '||
			  ' GROUP BY cargo.cod_cliente,  cargo.cod_producto, cargo.cod_concepto, conce.des_concepto; - '||SQLERRM,1,CN_largoquery);

        OPEN SC_cargos_nuevos FOR
		SELECT cargo.cod_concepto, conce.des_concepto, SUM(cargo.imp_cargo) AS monto_sin_impuesto
  		  FROM ge_cargos cargo, fa_conceptos conce
		  WHERE cargo.cod_cliente=SN_cod_cliente
		  AND cargo.cod_ciclfact=SN_COD_CICLFACT
		  AND cargo.cod_producto=1
		  AND cargo.ind_factur=1
		  AND cargo.num_venta=0
		  AND cargo.imp_cargo>0
		  AND cargo.cod_concepto=conce.cod_concepto
		  GROUP BY cargo.cod_cliente,cargo.cod_producto,cargo.cod_concepto,conce.des_concepto;


EXCEPTION
WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion: FA_BALANCE_CLI_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'FA_BALANCE_CLI_PR', sSql, SQLCODE, V_des_error );
WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('Others: FA_BALANCE_CLI_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'FA_BALANCE_CLI_PR', sSql, SQLCODE, V_des_error );
END FA_BALANCE_CLI_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END FA_BALANCE_CLI_PG;
/
SHOW ERRORS
