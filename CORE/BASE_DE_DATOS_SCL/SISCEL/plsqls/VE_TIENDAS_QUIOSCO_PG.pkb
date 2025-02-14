CREATE OR REPLACE PACKAGE BODY ve_tiendas_quiosco_pg AS

PROCEDURE ve_get_tiendas_pr(sc_tiendas  	  OUT NOCOPY RefCursor,
							sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      					sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	      					sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

	 sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

	 lv_sql:='select  a.COD_TIENDA, a.DES_TIENDA, a.NOM_USUARIO_VENDEDOR, a.NOM_USUARIO_CAJERO, a.NOM_USUARIO, a.COD_CLIENTE, a.COD_CAJA, b.DES_CAJA . A.IND_APLI_PAGO'
           ||'from VE_TIENDA_TD a, co_cajas b '
           ||'where a.cod_caja = b.cod_caja '     
           ||'and cod_oficina = '||cv_ofi_caja||''
           ||'AND fec_fin_vigencia > SYSDATE';		   

	 open sc_tiendas for
	 select  a.COD_TIENDA, a.DES_TIENDA, a.NOM_USUARIO_VENDEDOR, a.NOM_USUARIO_CAJERO, a.NOM_USUARIO, a.COD_CLIENTE, a.COD_CAJA, b.DES_CAJA, A.IND_APLI_PAGO
     from VE_TIENDA_TD a, co_cajas b
     where a.cod_caja = b.cod_caja     
     and cod_oficina = cv_ofi_caja
	 AND fec_fin_vigencia > SYSDATE;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      sn_cod_retorno  := 2001;
    	 sv_mens_retorno := 'No existen tiendas configuradas';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_get_tiendas_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_get_tiendas_pr()', lv_sql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
		 sn_cod_retorno  := 2000;
    	 sv_mens_retorno := 'No es posible ejecutar este servicio';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_get_tiendas_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_get_tiendas_pr()', lv_sql, SQLCODE, SQLERRM);

END ve_get_tiendas_pr;

--------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ve_get_infoVend_tienda_pr(EV_COD_TIENDA IN VE_TIENDA_TD.COD_TIENDA%TYPE,
							SV_DES_TIENDA     OUT NOCOPY VE_TIENDA_TD.DES_TIENDA%TYPE,
							SV_NOM_USUARIO    OUT NOCOPY GE_SEG_USUARIO.NOM_USUARIO%TYPE,
							SV_DES_BODEGA     OUT NOCOPY AL_BODEGAS.DES_BODEGA%TYPE,
							SV_NOM_VENDEDOR   OUT NOCOPY VE_VENDEDORES.NOM_VENDEDOR%TYPE,
							SV_COD_CAJA       OUT NOCOPY CO_CAJAS.COD_CAJA%TYPE,
							SV_DES_CAJA       OUT NOCOPY CO_CAJAS.DES_CAJA%TYPE,
                            SV_COD_VENDEDOR   OUT NOCOPY VE_VENDEDORES.COD_VENDEDOR%TYPE,
  							SV_COD_OFICINA    OUT NOCOPY VE_VENDEDORES.COD_OFICINA%TYPE,
							SV_NUM_IDENTCLI   OUT NOCOPY GE_CLIENTES.NUM_IDENT%TYPE,
							SV_COD_CLIENTE    OUT NOCOPY GE_CLIENTES.COD_CLIENTE%TYPE,
							SV_COD_CUENTA     OUT NOCOPY GE_CLIENTES.COD_CUENTA%TYPE,
							SV_COD_DIRECCION  OUT NOCOPY GA_DIRECCLI.COD_DIRECCION%TYPE,
							sn_cod_bodega     OUT NOCOPY al_bodegas.COD_BODEGA%TYPE,
							SN_IND_APLI_PAGO  OUT NOCOPY VE_TIENDA_TD.IND_APLI_PAGO%TYPE,
							sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      					sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	      					sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS

   /* Modificacion
    * Descripcion: Se agrega parametro de salida SV_COD_VENDEDOR
    * Developer: Gabriel Moraga L.
    * Fecha: 09/06/2010
    */

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
ln_cod_cliente  NUMBER;

BEGIN

	 sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

	 lv_sql := 'SELECT e.des_tienda, a.nom_usuario, d.des_bodega, b.nom_vendedor,f.cod_caja, f.des_caja, b.cod_vendedor, b.cod_oficina,g.num_ident, g.cod_cliente, g.cod_cuenta, h.cod_direccion'
            || ' FROM ge_seg_usuario a,ve_vendedores b,ve_vendalmac c,al_bodegas d,ve_tienda_td e,co_cajas f,ge_clientes g,ga_direccli h'
            || ' WHERE e.cod_tienda = '||ev_cod_tienda
            || ' AND e.nom_usuario_vendedor = a.nom_usuario'
            || ' AND a.cod_vendedor = b.cod_vendedor'
            || ' AND b.cod_vendedor = c.cod_vendedor'
            || ' AND c.cod_bodega = d.cod_bodega'
            || ' AND c.fec_desasignac IS NULL'
            || ' AND e.cod_caja = f.cod_caja'
            || ' AND f.cod_oficina = '||cv_ofi_caja
            || ' AND g.cod_cliente = e.cod_cliente'
            || ' AND h.cod_cliente = g.cod_cliente'
            || ' AND h.cod_tipdireccion = 1'
            || ' AND ROWNUM < 2';

		
      SELECT e.des_tienda, a.nom_usuario, d.des_bodega, b.nom_vendedor,f.cod_caja, f.des_caja, b.cod_vendedor, b.cod_oficina,g.num_ident, g.cod_cliente, g.cod_cuenta, h.cod_direccion, d.cod_bodega, E.IND_APLI_PAGO
        INTO sv_des_tienda, sv_nom_usuario, sv_des_bodega, sv_nom_vendedor,sv_cod_caja, sv_des_caja, sv_cod_vendedor, sv_cod_oficina,sv_num_identcli, sv_cod_cliente, sv_cod_cuenta, sv_cod_direccion, sn_cod_bodega, SN_IND_APLI_PAGO 
        FROM ge_seg_usuario a,ve_vendedores b,ve_vendalmac c,al_bodegas d,ve_tienda_td e,co_cajas f,ge_clientes g,ga_direccli h
       WHERE e.cod_tienda = ev_cod_tienda
         AND e.nom_usuario_vendedor = a.nom_usuario
         AND a.cod_vendedor = b.cod_vendedor
         AND b.cod_vendedor = c.cod_vendedor
         AND c.cod_bodega = d.cod_bodega
         AND c.fec_desasignac IS NULL
         AND e.cod_caja = f.cod_caja
         AND f.cod_oficina = cv_ofi_caja
         AND g.cod_cliente = e.cod_cliente
         AND h.cod_cliente = g.cod_cliente
         AND h.cod_tipdireccion = 1
         AND ROWNUM < 2;



EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      sn_cod_retorno  := 2002;
    	 sv_mens_retorno := 'No es posible recuperar datos de la tienda y el vendedor';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_get_infoVend_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_get_infoVend_tienda_pr()', lv_sql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
		 sn_cod_retorno  := 2000;
    	 sv_mens_retorno := 'No es posible ejecutar este servicio';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_get_infoVend_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_get_infoVend_tienda_pr()', lv_sql, SQLCODE, SQLERRM);

END ve_get_infoVend_tienda_pr;

PROCEDURE ve_insert_tienda_pr(
                                    sv_des_tienda           IN VE_TIENDA_TD.DES_TIENDA%TYPE,
                                    sv_nom_usuario_vendedor IN VE_TIENDA_TD.NOM_USUARIO_VENDEDOR%TYPE,
                                    sv_nom_usuario_cajero   IN VE_TIENDA_TD.NOM_USUARIO_CAJERO%TYPE,
                                    sv_nom_usuario          IN VE_TIENDA_TD.NOM_USUARIO%TYPE,
                                    sv_cod_cliente          IN VE_TIENDA_TD.COD_CLIENTE%TYPE,
                                    sv_cod_caja             IN VE_TIENDA_TD.COD_CAJA%TYPE,
									sn_ind_apli_pago        IN VE_TIENDA_TD.IND_APLI_PAGO%TYPE,
                                    sn_cod_tienda           OUT NOCOPY VE_TIENDA_TD.COD_TIENDA%TYPE,
                                    sn_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento           OUT NOCOPY ge_errores_pg.evento)
IS

/*
<Documentación
Tipodoc = "PROCEDIMIENTO">
<Elemento Nombre = "ve_insert_tienda_pr"
Lenguaje="PL/SQL" Fecha="10-06-2010" Versión="1.0.0"
Diseñador="Gabriel Moraga L."
Programador="Gabriel Moraga L."
Ambiente="BD">
<Retorno></Retorno>
<Descripción>Crea un registro en la tabla VE_TIENDA_TD</Descripción>
<Parámetros>
<Entrada>
<param nom="sv_des_tienda" Tipo="VARCHAR2"> Descripcion de la tienda </param>
<param nom="sv_nom_usuario_vendedor" Tipo="VARCHAR2"> Nombre de usuario vendedor </param>
<param nom="sv_nom_usuario_cajero" Tipo="VARCHAR2"> Nombre de usuario cajero </param>
<param nom="sv_nom_usuario" Tipo="VARCHAR2"> Nombre usuario </param>
<param nom="sd_fec_desde" Tipo="DATE"> Fecha de inicio </param>
<param nom="sd_fec_hasta" Tipo="DATE"> Fecha de fin </param>
<param nom="sv_cod_cliente " Tipo="VARCHAR2"> Codigo de cliente </param>
</Entrada>
<Salida>
<param nom="sn_cod_tienda" Tipo="NUMBER"> Codigo de sequencia de la tienda </param>
<param nom="sn_cod_retorno" Tipo="NUMBER"> Codigo de error </param>
<param nom="sv_mens_retorno" Tipo="STRING"> Mensaje de error </param>
<param nom="sn_num_evento" Tipo="NUMBER"> Numero de evento </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

error_usuario   EXCEPTION;
error_cliente   EXCEPTION;
error_cajero   EXCEPTION;
error_tienda   EXCEPTION;


BEGIN

	 sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

	 	 --VALIDACIONES
		 lv_cont:=0;
		 ---	Validar Existencia del usuario (ge_seg_usuario)
      lv_sql := 'SELECT COUNT (1) FROM ge_seg_usuario'
             || ' WHERE nom_usuario = sv_nom_usuario_vendedor' 
	         || ' AND cod_vendedor IS NOT NULL';
	  
	  SELECT COUNT (1)
        INTO lv_cont
        FROM ge_seg_usuario
       WHERE nom_usuario = sv_nom_usuario_vendedor 
	   AND cod_vendedor IS NOT NULL;
		 
		 if lv_cont = 0 then
		 	RAISE error_usuario;
		 end if;

		 	 
		 -- Validar Existencia del cliente
		 lv_cont:=0;
		 
		 select count(1) into lv_cont from GE_CLIENTES where cod_cliente = sv_cod_cliente;
		 
		 if lv_cont = 0 then
		 	RAISE error_cliente;
		 end if;
		 

		 -- Validar Existencia del cajero
		 lv_cont:=0;
		 
		 select count(3) into lv_cont from CO_CAJEROS where NOM_USUARORA = sv_nom_usuario_cajero;
		 
		 if lv_cont = 0 then
		 	RAISE error_cajero;
		 end if;
		 
		 
		  -- Validar Que no se repita la tienda
		 lv_cont:=0;
		 
		 select count(2) into lv_cont from VE_TIENDA_TD a where DES_TIENDA = sv_des_tienda AND fec_fin_vigencia > SYSDATE;
		 
		 if lv_cont > 0 then
		 	RAISE error_tienda;
		 end if;
		 

     SELECT SEQ_COD_TIENDA.NEXTVAL INTO sn_cod_tienda from dual;

     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0; 

     lv_sql := 'INSERT INTO VE_TIENDA_TD (COD_TIENDA, DES_TIENDA, NOM_USUARIO_VENDEDOR, NOM_USUARIO_CAJERO, NOM_USUARIO, FEC_DESDE, FEC_HASTA, COD_CLIENTE, COD_CAJA, FEC_INI_VIGENCIA, FEC_FIN_VIGENCIA,IND_APLI_PAGO) '
             ||'VALUES   ('||sn_cod_tienda||','||sv_des_tienda||','||sv_nom_usuario_vendedor||','||sv_nom_usuario_cajero||','||sv_nom_usuario||','||sv_cod_cliente||','||sv_cod_caja||',SYSDATE, TO_DATE('''||'31/12/3000 23:59:59,'''||'dd-mm-yyyy'||''','||sn_ind_apli_pago||'))';

     INSERT INTO VE_TIENDA_TD (COD_TIENDA, DES_TIENDA, NOM_USUARIO_VENDEDOR, NOM_USUARIO_CAJERO, NOM_USUARIO, COD_CLIENTE, COD_CAJA, FEC_INI_VIGENCIA, FEC_FIN_VIGENCIA,IND_APLI_PAGO)
     VALUES   (sn_cod_tienda, sv_des_tienda, sv_nom_usuario_vendedor, sv_nom_usuario_cajero, sv_nom_usuario, sv_cod_cliente, sv_cod_caja, SYSDATE, TO_DATE('31-12-3000','dd-mm-yyyy'),sn_ind_apli_pago);

EXCEPTION
	WHEN error_usuario THEN
		 sn_cod_retorno  := 33334;
    	 sv_mens_retorno := 'El Usuario Ingresado No se encuentra Configurado ó no tiene vendedor asociado';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_insert_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_insert_tienda_pr()', lv_sql, SQLCODE, SQLERRM);
		 
	WHEN error_cliente THEN
		 sn_cod_retorno  := 33335;
    	 sv_mens_retorno := 'El Código de cliente que está Ingresado No se encuentra Configurado';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_insert_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_insert_tienda_pr()', lv_sql, SQLCODE, SQLERRM);
		 		 
	WHEN error_cajero THEN
		 sn_cod_retorno  := 33336;
    	 sv_mens_retorno := 'El Cajero Ingresado no se encuentra configurado.';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_insert_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_insert_tienda_pr()', lv_sql, SQLCODE, SQLERRM);
		 	 
	WHEN error_tienda THEN
		 sn_cod_retorno  := 33337;
    	 sv_mens_retorno := 'La tienda ya existe configurada.';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_insert_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_insert_tienda_pr()', lv_sql, SQLCODE, SQLERRM);
		 		
		 						 
	WHEN OTHERS THEN
		 sn_cod_retorno  := 33333;
    	 sv_mens_retorno := 'No es posible ejecutar este servicio';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_insert_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_insert_tienda_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_insert_tienda_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_selec_curs_tienda_pr(
                                    sc_tienda            OUT NOCOPY refcursor,
                                    sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento        OUT NOCOPY ge_errores_pg.evento)
IS

/*
<Documentación
Tipodoc = "PROCEDIMIENTO">
<Elemento Nombre = "ve_selec_curs_tienda_pr"
Lenguaje="PL/SQL" Fecha="10-06-2010" Versión="1.0.0"
Diseñador="Gabriel Moraga L."
Programador="Gabriel Moraga L."
Ambiente="BD">
<Retorno></Retorno>
<Descripción>Obtiene los datos de las tiendas</Descripción>
<Parámetros>
<Entrada>
</Entrada>
<Salida>
<param nom="sc_tienda" Tipo="CURSOR"> Cursor con los datos por tienda </param>
<param nom="sn_cod_retorno" Tipo="NUMBER"> Codigo de error </param>
<param nom="sv_mens_retorno" Tipo="STRING"> Mensaje de error </param>
<param nom="sn_num_evento" Tipo="NUMBER"> Numero de evento </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

BEGIN

     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

     lv_sql := 'SELECT COD_TIENDA, DES_TIENDA, NOM_USUARIO_VENDEDOR, NOM_USUARIO_CAJERO, NOM_USUARIO, FEC_DESDE, FEC_HASTA, COD_CLIENTE ,COD_CAJA,IND_APLI_PAGO from VE_TIENDA_TD';

     OPEN sc_tienda FOR
     select  a.COD_TIENDA, a.DES_TIENDA, a.NOM_USUARIO_VENDEDOR, a.NOM_USUARIO_CAJERO, a.NOM_USUARIO, a.COD_CLIENTE, a.COD_CAJA, b.DES_CAJA, a.IND_APLI_PAGO
     from VE_TIENDA_TD a, co_cajas b
     where a.cod_caja = b.cod_caja     
     and cod_oficina = cv_ofi_caja
	 AND fec_fin_vigencia > SYSDATE;

EXCEPTION
	WHEN OTHERS THEN
		 sn_cod_retorno  := 33333;
    	 sv_mens_retorno := 'No es posible ejecutar este servicio';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_selec_curs_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_selec_curs_tienda_pr', lv_sql, SQLCODE, SQLERRM);
END ve_selec_curs_tienda_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_update_tienda_pr(
                                sn_cod_tienda           IN VE_TIENDA_TD.COD_TIENDA%TYPE,
                                sv_des_tienda           IN VE_TIENDA_TD.DES_TIENDA%TYPE,
                                sv_nom_usuario_vendedor IN VE_TIENDA_TD.NOM_USUARIO_VENDEDOR%TYPE,
                                sv_nom_usuario_cajero   IN VE_TIENDA_TD.NOM_USUARIO_CAJERO%TYPE,
                                sv_nom_usuario          IN VE_TIENDA_TD.NOM_USUARIO%TYPE,
                                sv_cod_cliente          IN VE_TIENDA_TD.COD_CLIENTE%TYPE,
                                sv_cod_caja             IN VE_TIENDA_TD.COD_CAJA%TYPE,
     							en_ind_apli_pago        IN VE_TIENDA_TD.IND_APLI_PAGO%TYPE,
                                sn_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento           OUT NOCOPY ge_errores_pg.evento)
IS

/*
<Documentación
Tipodoc = "PROCEDIMIENTO">
<Elemento Nombre = "ve_update_tienda_pr"
Lenguaje="PL/SQL" Fecha="10-06-2010" Versión="1.0.0"
Diseñador="Gabriel Moraga L."
Programador="Gabriel Moraga L."
Ambiente="BD">
<Retorno></Retorno>
<Descripción>Actualiza los datos de un tienda</Descripción>
<Parámetros>
<Entrada>
<param nom="sn_cod_tienda" Tipo="NUMBER"> Codigo de sequencia de la tienda </param>
<param nom="sv_des_tienda" Tipo="VARCHAR2"> Descripcion de la tienda </param>
<param nom="sv_nom_usuario_vendedor" Tipo="VARCHAR2"> Nombre de usuario vendedor </param>
<param nom="sv_nom_usuario_cajero" Tipo="VARCHAR2"> Nombre de usuario cajero </param>
<param nom="sv_nom_usuario" Tipo="VARCHAR2"> Nombre usuario </param>
<param nom="sd_fec_desde" Tipo="DATE"> Fecha de inicio </param>
<param nom="sd_fec_hasta" Tipo="DATE"> Fecha de fin </param>
<param nom="sv_cod_cliente " Tipo="VARCHAR2"> Codigo de cliente </param>
</Entrada>
<Salida>
<param nom="sn_cod_retorno" Tipo="NUMBER"> Codigo de error </param>
<param nom="sv_mens_retorno" Tipo="STRING"> Mensaje de error </param>
<param nom="sn_num_evento" Tipo="NUMBER"> Numero de evento </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;
ln_cod_tienda   NUMBER;
BEGIN

     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;


			 
			 
        /* UPDATE VE_TIENDA_TD SET 
		 FEC_FIN_VIGENCIA = SYSDATE
		 WHERE COD_TIENDA = sn_cod_tienda;*/

         UPDATE VE_TIENDA_TD SET
         --DES_TIENDA = sv_des_tienda,
         NOM_USUARIO_VENDEDOR = sv_nom_usuario_vendedor,
         NOM_USUARIO_CAJERO = sv_nom_usuario_cajero,
         NOM_USUARIO = sv_nom_usuario,
         COD_CLIENTE = sv_cod_cliente,
         COD_CAJA = sv_cod_caja,
		 IND_APLI_PAGO=en_ind_apli_pago
         WHERE COD_TIENDA = sn_cod_tienda;
		 
		 
		/*  SELECT SEQ_COD_TIENDA.NEXTVAL INTO ln_cod_tienda from dual;


    	  lv_sql := 'INSERT INTO VE_TIENDA_TD (COD_TIENDA, DES_TIENDA, NOM_USUARIO_VENDEDOR, NOM_USUARIO_CAJERO, NOM_USUARIO, FEC_DESDE, FEC_HASTA, COD_CLIENTE, COD_CAJA, FEC_INI_VIGENCIA, FEC_FIN_VIGENCIA) '
             ||'VALUES   ('||ln_cod_tienda||','||sv_des_tienda||','||sv_nom_usuario_vendedor||','||sv_nom_usuario_cajero||','||sv_nom_usuario||','||sv_cod_cliente||','||sv_cod_caja||',SYSDATE, TO_DATE('''||'31/12/3000 23:59:59,'''||'dd-mm-yyyy'||'''))';
			 
		  INSERT INTO VE_TIENDA_TD (COD_TIENDA, DES_TIENDA, NOM_USUARIO_VENDEDOR, NOM_USUARIO_CAJERO, NOM_USUARIO, COD_CLIENTE, COD_CAJA, FEC_INI_VIGENCIA, FEC_FIN_VIGENCIA)
     VALUES   (ln_cod_tienda, sv_des_tienda, sv_nom_usuario_vendedor, sv_nom_usuario_cajero, sv_nom_usuario, sv_cod_cliente, sv_cod_caja, SYSDATE, TO_DATE('31-12-3000','dd-mm-yyyy'));*/

EXCEPTION
    WHEN OTHERS THEN
		 sn_cod_retorno  := 33333;
    	 sv_mens_retorno := 'No es posible ejecutar este servicio';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_update_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_update_tienda_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_update_tienda_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_delete_tienda_pr(
                                sn_cod_tienda     IN VE_TIENDA_TD.COD_TIENDA%TYPE,
                                sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS

/*
<Documentación
Tipodoc = "PROCEDIMIENTO">
<Elemento Nombre = "ve_delete_tipifica_pr"
Lenguaje="PL/SQL" Fecha="10-06-2010" Versión="1.0.0"
Diseñador="Gabriel Moraga L."
Programador="Gabriel Moraga L."
Ambiente="BD">
<Retorno></Retorno>
<Descripción>Elimina una tipificacion</Descripción>
<Parámetros>
<Entrada>
<param nom="sn_cod_tienda" Tipo="NUMBER"> Numero de la tienda </param>
</Entrada>
<Salida>
<param nom="sn_cod_retorno" Tipo="NUMBER"> Codigo de error </param>
<param nom="sv_mens_retorno" Tipo="STRING"> Mensaje de error </param>
<param nom="sn_num_evento" Tipo="NUMBER"> Numero de evento </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/


lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

BEGIN

     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

    /* lv_sql :=   'DELETE VE_TIENDA_TD'
               ||'WHERE COD_TIENDA ='||sn_cod_tienda||'';*/
			   
      lv_sql := 'UPDATE VE_TIENDA_TD SET '
             ||'FEC_FIN_VIGENCIA = SYSDATE'
             ||'WHERE COD_TIENDA = '||sn_cod_tienda||'';
			   
			   
      UPDATE VE_TIENDA_TD SET 
		 FEC_FIN_VIGENCIA = SYSDATE
		 WHERE COD_TIENDA = sn_cod_tienda;			   

    /* DELETE FROM VE_TIENDA_TD
     WHERE COD_TIENDA = sn_cod_tienda*/

EXCEPTION
    WHEN OTHERS THEN
		 sn_cod_retorno  := 33333;
    	 sv_mens_retorno := 'No es posible ejecutar este servicio';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_delete_tienda_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_delete_tienda_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_delete_tienda_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_get_cajas_pr(ev_oficina        IN  co_cajas.cod_oficina%TYPE,  
                          sc_caja     	    OUT NOCOPY RefCursor,
						  sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      				  sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	      			      sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

	 sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

	 lv_sql:='SELECT a.cod_caja, a.des_caja FROM co_cajas a WHERE a.cod_oficina = '||ev_oficina||'';
     
	 OPEN sc_caja FOR
	 SELECT a.cod_caja, a.des_caja
     FROM   co_cajas a 
     WHERE  a.cod_oficina = ev_oficina;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
	     sn_cod_retorno  := 2003;
    	 sv_mens_retorno := 'No existen cajas configuradas';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_get_cajas_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_get_cajas_pr()', lv_sql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
		 sn_cod_retorno  := 2000;
    	 sv_mens_retorno := 'No es posible ejecutar este servicio';
    	 lv_des_error 	 := 've_tiendas_quiosco_pg.ve_get_cajas_pr() - ' || SQLERRM;
  		 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_tiendas_quiosco_pg.ve_get_cajas_pr()', lv_sql, SQLCODE, SQLERRM);

END ve_get_cajas_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_tiendas_quiosco_pg;
/
SHOW ERRORS
