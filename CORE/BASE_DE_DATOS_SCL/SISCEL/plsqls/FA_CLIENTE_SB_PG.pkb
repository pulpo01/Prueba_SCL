CREATE OR REPLACE PACKAGE BODY FA_CLIENTE_SB_PG AS

CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';

  FUNCTION FA_TRASPASO_OBJ_ROWT_FN(oe_cliente IN FA_CLIENTE_DTO_OT) RETURN FA_CLIENTE_TO%ROWTYPE
  AS
/*
<Documentacion
  TipoDoc = funcion">
   <Elemento
      Nombre = "FA_TRASPASO_OBJ_ROWT_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>Traspasa información desde una estrucuta object a una rowtype</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  lo_cliente FA_CLIENTE_TO%ROWTYPE;
  BEGIN
     lo_cliente.cod_cliente := oe_cliente.cod_cliente;
	 lo_cliente.fec_desde := oe_cliente.fec_desde;
	 lo_cliente.cod_despacho := oe_cliente.cod_despacho;
	 lo_cliente.fec_hasta := oe_cliente.fec_hasta;
	 lo_cliente.nom_email := oe_cliente.nom_email;
	 lo_cliente.nom_usuario := oe_cliente.nom_usuario;
	 lo_cliente.fec_ultmod := oe_cliente.fec_ultmod;

	 return lo_cliente;
  END;

  FUNCTION FA_TRASPASO_ROWT_OBJ_FN(oe_cliente IN FA_CLIENTE_TO%ROWTYPE) RETURN FA_CLIENTE_DTO_OT
  AS
/*
<Documentacion
  TipoDoc = funcion">
   <Elemento
      Nombre = "FA_TRASPASO_ROWT_OBJ_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>Traspasa información desde una estrucuta rowtype a una object</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  lo_cliente FA_CLIENTE_DTO_OT := NEW FA_CLIENTE_DTO_OT();
  BEGIN
     IF oe_cliente.cod_cliente IS NOT NULL THEN
	     lo_cliente.cod_cliente := oe_cliente.cod_cliente;
		 lo_cliente.fec_desde := oe_cliente.fec_desde;
		 lo_cliente.cod_despacho := oe_cliente.cod_despacho;
		 lo_cliente.fec_hasta := oe_cliente.fec_hasta;
		 lo_cliente.nom_email := oe_cliente.nom_email;
		 lo_cliente.nom_usuario := oe_cliente.nom_usuario;
		 lo_cliente.fec_ultmod := oe_cliente.fec_ultmod;
	 ELSE
	    lo_cliente := null;
	 END IF;
	 return lo_cliente;
  END;

  PROCEDURE FA_INSERTA_PR (TE_cliente IN FA_CLIENTE_DTO_OT, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
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
            <param nom="te_clietne " Tipo="FA_CLIENTE_DTO_OT">Estructura de cliente</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  ERROR_CONTROLADO EXCEPTION;

  Lv_SQL VARCHAR2(100);
  lv_cliente FA_CLIENTE_TO%ROWTYPE;
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;


     lv_sql := 'FA_CLIENTE_SB_PG.FA_TRASPASO_OBJ_ROWT_FN ();';
     lv_cliente := FA_TRASPASO_OBJ_ROWT_FN (TE_cliente);

	 lv_sql := 'FA_CLIENTE_SP_PG.FA_INSERTA_PR;';
	 fa_cliente_sp_pg.FA_INSERTA_PR( lv_cliente, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	 IF SN_COD_RETORNO != 0 THEN
	    RAISE ERROR_CONTROLADO;
	 END IF;

  EXCEPTION
    WHEN ERROR_CONTROLADO THEN
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_INSERTA_PR', lv_sql, SN_COD_RETORNO, SV_MENS_RETORNO );
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1924; -- -100 Error en el proceso base de registro de datos de cliente
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_INSERTA_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE FA_ACTUALIZA_VIGENCIA_PR (TE_cliente IN FA_CLIENTE_DTO_OT, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
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
            <param nom="te_clietne " Tipo="FA_CLIENTE_DTO_OT">Estructura de cliente</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  ERROR_CONTROLADO EXCEPTION;

  Lv_SQL VARCHAR2(1000);
  lv_cliente FA_CLIENTE_TO%ROWTYPE;
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

     lv_sql := 'FA_CLIENTE_SB_PG.FA_TRASPASO_OBJ_ROWT_FN ();';
     lv_cliente := FA_TRASPASO_OBJ_ROWT_FN (TE_cliente);

	 lv_sql := 'FA_CLIENTE_SP_PG.FA_ACTUALIZA_VIGENCIA_PR;';
     FA_CLIENTE_SP_PG.FA_ACTUALIZA_VIGENCIA_PR( lv_cliente, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	 IF SN_COD_RETORNO != 0 THEN
	    RAISE ERROR_CONTROLADO;
	 END IF;

  EXCEPTION
    WHEN ERROR_CONTROLADO THEN
	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_INSERTA_PR', lv_sql, SN_COD_RETORNO, SV_MENS_RETORNO );
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1925; -- -200 Error en proceso base de actualización de vigencia
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_ACTUALIZA_VIGENCIA_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE FA_RECUPERA_CLIENTE_PR (TE_cliente IN OUT NOCOPY  FA_CLIENTE_DTO_OT, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
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
            <param nom="te_clietne " Tipo="FA_CLIENTE_DTO_OT">Estructura de cliente</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  ERROR_CONTROLADO EXCEPTION;

  Lv_SQL VARCHAR2(1000);
  lv_cliente FA_CLIENTE_TO%ROWTYPE;
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

	 lv_sql := 'FA_CLIENTE_SB_PG.FA_TRASPASO_OBJ_ROWT_FN ();';
     lv_cliente := FA_TRASPASO_OBJ_ROWT_FN (TE_cliente);


	 lv_sql := 'FA_CLIENTE_SP_PG.FA_ACTUALIZA_VIGENCIA_PR;';
     FA_CLIENTE_SP_PG.FA_RECUPERA_CLIENTE_PR( lv_cliente, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	 IF SN_COD_RETORNO != 0 THEN
	    RAISE ERROR_CONTROLADO;
	 END IF;

	 lv_sql := 'FA_CLIENTE_SB_PG.FA_TRASPASO_OBJ_ROWT_FN ();';
     TE_cliente := FA_TRASPASO_ROWT_OBJ_FN (lv_cliente);

  EXCEPTION
    WHEN ERROR_CONTROLADO THEN
	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_INSERTA_PR', lv_sql, SN_COD_RETORNO, SV_MENS_RETORNO );

    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1926; -- -300 Error en proceso de recuperación de datos de cliente de facturación
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_RECUPERA_CLIENTE_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE FA_REC_DESPACHO_NO_ELECT_PR (en_cod_cliente IN NUMBER,
                                         ev_cod_despacho_elect IN VARCHAR2,
										 ld_fec_desde IN DATE,
										 sV_cod_despacho OUT NOCOPY VARCHAR2,
                                         SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)

  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "FA_REC_DESPACHO_NO_ELECT_PR"
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
    ERROR_CONTROLADO EXCEPTION;

    Lv_SQL VARCHAR2(1000);
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

	 lv_sql := 'FA_CLIENTE_SB_PG.FA_REC_DESPACHO_NO_ELECT_PR ();';
     FA_CLIENTE_SP_PG.FA_REC_COD_DESP_NO_ELECT_PR( EN_COD_CLIENTE, EV_COD_DESPACHO_ELECT, LD_FEC_DESDE,
	                                               SV_COD_DESPACHO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	 IF SN_COD_RETORNO != 0 THEN
	    raise ERROR_CONTROLADO;
	 END IF;

  EXCEPTION
    WHEN ERROR_CONTROLADO THEN
  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_REC_DESPACHO_NO_ELECT_PR', lv_sql, SN_COD_RETORNO, SV_MENS_RETORNO );

    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1927; -- -400  Error en proceso de recuperación de código de despacho fisico para el cliente
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_REC_DESPACHO_NO_ELECT_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE FA_RECUPERA_PARAM_PR (ev_nom_param IN varchar2,
                                  Sv_val_param out nocopy VARCHAR2,
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
    ERROR_CONTROLADO EXCEPTION;

    Lv_SQL VARCHAR2(1000);
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

	 lv_sql := 'FA_CLIENTE_SB_PG.FA_REC_DESPACHO_NO_ELECT_PR ();';
     FA_CLIENTE_SP_PG.FA_RECUPERA_PARAM_PR( ev_nom_param, Sv_val_param, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );


	 IF SN_COD_RETORNO != 0 THEN
	    raise ERROR_CONTROLADO;
	 END IF;

  EXCEPTION
    WHEN ERROR_CONTROLADO THEN
  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_RECUPERA_PARAM_PR', lv_sql, SN_COD_RETORNO, SV_MENS_RETORNO );

    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1928; -- -500 Error en proceso base de recuperación del parámetro código de despacho electrónico.
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'FA_CLIENTE_SB_PG.FA_RECUPERA_PARAM_PR', lv_sql, SQLCODE, SQLERRM );
  END;

END;
/
SHOW ERRORS
