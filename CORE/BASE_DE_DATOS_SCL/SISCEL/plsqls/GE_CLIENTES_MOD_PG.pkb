CREATE OR REPLACE PACKAGE BODY GE_CLIENTES_MOD_PG AS

CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';

  PROCEDURE GE_ACTUALIZA_MAIL_FACT_ELEC_PR (TE_cliente IN GE_CLIENTES%ROWTYPE, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GE_ACTUALIZA_MAIL_FACT_ELEC_PR"
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
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(100);
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;

     lv_sql := 'UPDATE GE_CLIENTES SET ind_facturaelectronica =' || te_cliente.ind_facturaelectronica || ',  nom_email =' || te_cliente.nom_email;
	 lv_sql := ' WHERE cod_cliente ='|| te_cliente.cod_cliente;
	 UPDATE GE_CLIENTES
	    SET ind_facturaelectronica = te_cliente.ind_facturaelectronica,
	        nom_email = te_cliente.nom_email,
			fec_ultmod = te_cliente.fec_ultmod
	  WHERE cod_cliente = te_cliente.cod_cliente;


  EXCEPTION
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1949; -- -60 Error al actualizar datos del cliente.
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GE', SV_mens_retorno, 1.0, USER, 'GE_CLIENTES_MOD_PG.GE_ACTUALIZA_MAIL_FACT_ELEC_PR', lv_sql, SQLCODE, SQLERRM );
  END;



  PROCEDURE GE_RECUPERA_PR (TE_cliente IN OUT NOCOPY  GE_CLIENTES%ROWTYPE, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GE_RECUPERA_PR"
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

     lv_sql := 'SELECT COD_CLIENTE, NOM_CLIENTE, COD_TIPIDENT, NUM_IDENT,  IND_FACTURAELECTRONICA';
	 lv_sql := LV_SQL || ' FROM FA_CLIENTE_TO A';
	 lv_sql := LV_SQL || ' WHERE A.cod_cliente =' ||  te_cliente.cod_cliente;
	 lv_sql := LV_SQL || ' AND a.fec_hasta IS NULL;';

     SELECT COD_CLIENTE, NOM_CLIENTE, COD_TIPIDENT,
       NUM_IDENT,  IND_FACTURAELECTRONICA, nom_email
	 INTO te_cliente.cod_cliente, te_cliente.nom_cliente, te_cliente.cod_tipident,
	     te_cliente.num_ident, te_cliente.ind_facturaelectronica, te_cliente.nom_email
	  FROM GE_CLIENTES A
	 WHERE A.cod_cliente = te_cliente.cod_cliente;


  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	   te_cliente:= null;
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1950; -- -70 Error al recuperar datos del cliente.
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GE', SV_mens_retorno, 1.0, USER, 'GE_CLIENTES_MOD_PG.GE_RECUPERA_PR', lv_sql, SQLCODE, SQLERRM );
  END;


END;
/
SHOW ERRORS
