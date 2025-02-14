CREATE OR REPLACE PACKAGE BODY FA_CLIENTE_SP_PG AS

CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';

  PROCEDURE FA_INSERTA_PR (TE_cliente IN FA_CLIENTE_TO%ROWTYPE, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "FA_INSERTA_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>inserta en fa_cliente_to</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="te_clietne " Tipo="fa_cliente_ot">Estructura de cliente</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(100);

  -- Inc 72847 PPV 12/11/2008
  TE2_cliente FA_CLIENTE_TO%ROWTYPE;

  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

     lv_sql := 'INSERT INTO FA_CLIENTE_TO VALUES(' || ')';
     INSERT INTO FA_CLIENTE_TO VALUES TE_cliente;

  EXCEPTION
    -- Inc 72847 PPV 12/11/2008 Se maneja las claves duplicadas
	WHEN DUP_VAL_ON_INDEX THEN
		 BEGIN
			TE2_cliente  := TE_cliente;
			TE2_cliente.fec_desde :=  TE_cliente.fec_desde + (1/24/60/60); --LA FECHA MAS 1 SEGUNDO
			lv_sql := 'INSERT INTO FA_CLIENTE_TO VALUES(' || ')';
			INSERT INTO FA_CLIENTE_TO VALUES TE2_cliente;
		 EXCEPTION
			WHEN OTHERS THEN
				SN_COD_RETORNO := 1917; -- -10 No se pudo registrar información del cliente en facturación.
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
					SV_mens_retorno := CV_error_no_clasif;
				END IF;
				SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SP_PG.FA_INSERTA_PR', lv_sql, SQLCODE, SQLERRM );
		 END;
	-- Fin Inc 72847 PPV 12/11/2008
	WHEN OTHERS THEN
	    SN_COD_RETORNO := 1917; -- -10 No se pudo registrar información del cliente en facturación.
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SP_PG.FA_INSERTA_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE FA_ACTUALIZA_VIGENCIA_PR (TE_cliente IN FA_CLIENTE_TO%ROWTYPE, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "FA_ACTUALIZA_VIGENCIA_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>actualiz vigencia</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="te_clietne " Tipo="fa_cliente_ot">Estructura de cliente</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;
     lv_sql := 'UPDATE FA_CLIENTE_TO WHERE COD_CLIENTE = (' || te_cliente.cod_cliente || ' AND FEC_DESDE = ' || te_cliente.fec_desde;

	 UPDATE FA_CLIENTE_TO
	    SET fec_hasta = te_cliente.fec_hasta,
		    fec_ultmod = te_cliente.fec_ultmod
	  WHERE cod_cliente = te_cliente.cod_cliente
	    AND fec_desde = te_cliente.fec_desde;

  EXCEPTION
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1918; -- -20 No se pudo actualizar vigencia del cliente en facturación
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SP_PG.FA_ACTUALIZA_VIGENCIA_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE FA_RECUPERA_CLIENTE_PR (TE_cliente IN OUT NOCOPY  FA_CLIENTE_TO%ROWTYPE, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "FA_RECUPERA_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera datos de cliente en facturacion</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="te_clietne " Tipo="fa_cliente_ot">Estructura de cliente</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

     lv_sql := 'SELECT COD_CLIENTE, FEC_DESDE, FEC_HASTA, COD_DESPACHO, NOM_EMAIL';
	 lv_sql := LV_SQL || ' FROM FA_CLIENTE_TO A';
	 lv_sql := LV_SQL || ' WHERE A.cod_cliente =' ||  te_cliente.cod_cliente;
	 lv_sql := LV_SQL || ' AND a.fec_hasta IS NULL;';


	SELECT cod_cliente, fec_desde, fec_hasta, cod_despacho, nom_email
	INTO  te_cliente.cod_cliente, te_cliente.fec_desde, te_cliente.fec_hasta, te_cliente.cod_despacho, te_cliente.nom_email
	  FROM FA_CLIENTE_TO A
	 WHERE A.cod_cliente = te_cliente.cod_cliente
	   AND a.fec_hasta IS NULL;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	   te_cliente:= null;
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1919; -- -30 No se pudo recuperar información del cliente desde facturación
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SP_PG.FA_RECUPERA_CLIENTE_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE FA_REC_COD_DESP_NO_ELECT_PR (en_cod_cliente IN NUMBER,
                                         ev_cod_despacho_elect IN VARCHAR2,
										 ld_fec_desde IN DATE,
										 sV_cod_despacho OUT NOCOPY VARCHAR2,
                                         SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "FA_REC_COD_DESP_NO_ELECT_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera datos de cliente en facturacion</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="en_cod_cliente " Tipo="number">Código de cliente</param>
            <param nom="ev_cod_despacho_elect " Tipo="varchar">Codigo de despacho electrónico</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

     lv_sql := 'SELECT COD_DESPACHO FROM FA_CLIENTE_TO B WHERE B.COD_CLIENTE = ' || en_cod_cliente;
	 lv_sql := LV_SQL || ' AND FEC_DESDE = (SELECT MAX(FEC_DESDE) FROM FA_CLIENTE_TO A WHERE A.cod_cliente = ' || en_cod_cliente;
	 lv_sql := LV_SQL || ' AND cod_despacho != ' || ev_cod_despacho_elect;
	 lv_sql := LV_SQL || ' AND AND fec_desde <=' || ld_fec_desde;

	 SELECT COD_DESPACHO
	 INTO sV_cod_despacho
     FROM FA_CLIENTE_TO B
     WHERE B.COD_CLIENTE = en_cod_cliente
     AND FEC_DESDE = (
                 SELECT MAX(FEC_DESDE)
                   FROM FA_CLIENTE_TO A
                  WHERE A.cod_cliente = en_cod_cliente
                    AND cod_despacho != ev_cod_despacho_elect
					AND fec_desde <= ld_fec_desde
                );

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	    SN_COD_RETORNO := 1920; -- -40 No se encontró ningun código de despacho físico para el cliente
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SP_PG.FA_REC_COD_DESP_NO_ELECT_PR', lv_sql, SQLCODE, SQLERRM );

    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1921; -- -41 No se pudo obtener código de despacho físico
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SP_PG.FA_REC_COD_DESP_NO_ELECT_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE FA_RECUPERA_PARAM_PR (ev_nom_param IN varchar2,
                                  ev_val_param out nocopy VARCHAR2,
                                  sn_cod_retorno out nocopy number,
								  sv_mens_retorno out nocopy varchar2,
								  sn_num_evento out nocopy number)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "FA_RECUPERA_PARAM_PR"
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
            <param nom="ev_nom_param " Tipo="varchar">nombre del parámetro</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

     lv_sql := 'SELECT VALOR_TEXTO FROM FA_PARAMETROS_SIMPLES_VW WHERE NOM_PARAMETRO =' || ev_nom_param;

	 SELECT VALOR_TEXTO
	 INTO ev_val_param
	 FROM FA_PARAMETROS_SIMPLES_VW
	 WHERE NOM_PARAMETRO = ev_nom_param;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	    SN_COD_RETORNO := 1922; -- -50 No se encontró parámetro del codigo de despacho electrónico
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SP_PG.FA_RECUPERA_PARAM_PR', lv_sql, SQLCODE, SQLERRM );

    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1923;-- -51 No se pudo obtener parámetro del código de despacho electrónico
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SP_PG.FA_RECUPERA_PARAM_PR', lv_sql, SQLCODE, SQLERRM );
  END;
END;
/
SHOW ERRORS
