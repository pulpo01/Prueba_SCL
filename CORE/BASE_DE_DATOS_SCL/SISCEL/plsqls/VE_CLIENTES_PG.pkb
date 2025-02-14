CREATE OR REPLACE PACKAGE BODY ve_clientes_pg AS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_datos_cliente_fn(
                             en_num_celular    IN ga_aboamist.num_celular%TYPE,
                             sv_cod_tipident   OUT NOCOPY ge_clientes.cod_tipident%TYPE,
                             sv_num_ident      OUT NOCOPY ge_clientes.num_ident%TYPE,
                             sv_nom_cliente    OUT NOCOPY ge_clientes.nom_cliente%TYPE,
                             sv_nom_apeclien1  OUT NOCOPY ge_clientes.nom_apeclien1%TYPE,
                             sv_nom_apeclien2  OUT NOCOPY ge_clientes.nom_apeclien2%TYPE,
                             sn_cod_categoria  OUT NOCOPY ge_clientes.cod_categoria%TYPE,
                             sn_cod_direccion  OUT NOCOPY ga_direccli.cod_direccion%TYPE,
                             sn_cod_cliente    OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                             sn_cod_cuenta     OUT NOCOPY ge_clientes.cod_cuenta%TYPE,
                             SV_COD_CREDITICIA OUT NOCOPY ge_clientes.COD_CREDITICIA%TYPE, --CSR-11002
                             sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN

IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN


     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

     lv_sql := 'SELECT a.cod_tipident, a.num_ident, a.nom_cliente, a.nom_apeclien1,a.nom_apeclien2, a.cod_categoria, c.cod_direccion,a.cod_cliente,a.cod_cuenta,a.cod_crediticia '
             ||'FROM   ge_clientes a, ga_aboamist b, ga_direccli c '
             ||'WHERE  a.cod_cliente = b.cod_cliente '
             ||'AND    b.num_celular = '||en_num_celular||' '
             ||'AND    b.cod_situacion NOT IN ("BAA","BAP") '
             ||'AND    a.cod_cliente = c.cod_cliente '
             ||'AND    c.cod_tipdireccion = '||cn_tip_direccion||'';

     SELECT a.cod_tipident,a.num_ident, a.nom_cliente, a.nom_apeclien1,a.nom_apeclien2, a.cod_categoria, c.cod_direccion,a.cod_cliente,a.cod_cuenta,a.cod_crediticia
     INTO   sv_cod_tipident,sv_num_ident,sv_nom_cliente,sv_nom_apeclien1,sv_nom_apeclien2,sn_cod_categoria,sn_cod_direccion,sn_cod_cliente,sn_cod_cuenta,SV_COD_CREDITICIA
     FROM   ge_clientes a, ga_aboamist b, ga_direccli c, ge_tipident d
     WHERE  a.cod_cliente = b.cod_cliente
     AND    b.num_celular = en_num_celular
     AND    b.cod_situacion NOT IN ('BAA','BAP')
     AND    a.cod_cliente = c.cod_cliente
     AND    c.cod_tipdireccion = cn_tip_direccion
     AND    a.cod_tipident = d.cod_tipident;

     RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
     sn_cod_retorno  := 30005;
   	 sv_mens_retorno := 'No existen datos del cliente';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_cliente_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_cliente_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

WHEN OTHERS THEN
     sn_cod_retorno  := 30004;
   	 sv_mens_retorno := 'No es posible ejecutar este servicio';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_cliente_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_cliente_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

END ve_datos_cliente_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_datos_direccion_fn (
                                en_cod_direccion  IN ga_direccli.cod_direccion%TYPE,
                                sv_cod_region     OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                --sv_des_region     OUT NOCOPY ge_regiones.des_region%TYPE, CSR-11002
                                sv_cod_provincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                --sv_des_provincia  OUT NOCOPY ge_provincias.des_provincia%TYPE, CSR-11002
                                sv_cod_ciudad     OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                --sv_des_ciudad     OUT NOCOPY ge_ciudades.des_ciudad%TYPE, CSR-11002
                                sv_cod_comuna     OUT NOCOPY ge_direcciones.cod_comuna%TYPE,
                                --sv_des_comuna     OUT NOCOPY ge_ciudades.des_ciudad%TYPE, CSR-11002
                                sv_nom_calle      OUT NOCOPY ge_direcciones.nom_calle%TYPE,
                                sv_num_calle      OUT NOCOPY ge_direcciones.num_calle%TYPE,
                                sv_num_piso       OUT NOCOPY ge_direcciones.num_piso%TYPE,
                                sv_num_casilla    OUT NOCOPY ge_direcciones.num_casilla%TYPE,
                                sv_obs_direccion  OUT NOCOPY ge_direcciones.obs_direccion%TYPE,
                                sv_des_direc1     OUT NOCOPY ge_direcciones.des_direc1%TYPE,
                                sv_des_direc2     OUT NOCOPY ge_direcciones.des_direc2%TYPE,
                                sv_cod_pueblo     OUT NOCOPY ge_direcciones.cod_pueblo%TYPE,
                                sv_cod_estado     OUT NOCOPY ge_direcciones.cod_estado%TYPE,
                                sv_cod_tipocalle  OUT NOCOPY ge_direcciones.cod_tipocalle%TYPE,
                                sv_zip            OUT NOCOPY ge_direcciones.zip%TYPE,
                                sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN

IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

     /*lv_sql := 'SELECT a.cod_region,b.des_region,a.cod_provincia,c.des_provincia,a.cod_ciudad,d.des_ciudad,a.cod_comuna,e.des_comuna,a.nom_calle,a.num_calle,a.zip '
             ||'FROM   ge_direcciones a, ge_regiones b , ge_provincias c , ge_ciudades d, ge_comunas e '
             ||'WHERE  a.cod_direccion = '||en_cod_direccion||' '
             ||'AND    a.cod_region = b.cod_region '
             ||'AND    a.cod_region = c.cod_region '
             ||'AND    a.cod_provincia = c.cod_provincia '
             ||'AND    a.cod_region = d.cod_region '
             ||'AND    a.cod_provincia = d.cod_provincia '
             ||'AND    a.cod_ciudad = d.cod_ciudad '
             ||'AND    a.cod_region = e.cod_region '
             ||'AND    a.cod_provincia = e.cod_provincia '
             ||'AND    a.cod_comuna = e.cod_comuna';*/

     lv_sql := ' SELECT a.cod_region, ' ||
               ' a.cod_provincia, ' ||
               ' a.cod_ciudad, ' ||
               ' a.cod_comuna, ' ||
               ' a.nom_calle, ' ||
               ' a.num_calle, ' ||
               ' a.num_piso, ' ||
               ' a.num_casilla, ' ||
               ' a.obs_direccion, ' || 
               ' a.des_direc1, ' || 
               ' a.des_direc2, ' || 
               ' a.cod_pueblo, ' ||
               ' a.cod_estado, ' ||
               ' a.cod_tipocalle, ' ||
               ' a.zip ' ||
               ' FROM   ge_direcciones a ' ||
               ' WHERE  a.cod_direccion = ' || en_cod_direccion;
     
     SELECT a.cod_region,
            a.cod_provincia,
            a.cod_ciudad,
            a.cod_comuna,
            a.nom_calle,
            a.num_calle,
            a.num_piso, --INICIO CSR-11002
            a.num_casilla,
            a.obs_direccion, 
            a.des_direc1, 
            a.des_direc2, 
            a.cod_pueblo,
            a.cod_estado,
            a.cod_tipocalle,--FIN CSR-11002
            a.zip
     INTO   sv_cod_region,
            --sv_des_region, CSR-11002
            sv_cod_provincia,
            --sv_des_provincia, CSR-11002
            sv_cod_ciudad,
            --sv_des_ciudad, CSR-11002
            sv_cod_comuna,
            --sv_des_comuna, CSR-11002
            sv_nom_calle,
            sv_num_calle,
            sv_num_piso, --INICIO CSR-11002
            sv_num_casilla,
            sv_obs_direccion,
            sv_des_direc1,
            sv_des_direc2,
            sv_cod_pueblo,
            sv_cod_estado,
            sv_cod_tipocalle, --FIN CSR-11002
            sv_zip
     FROM   ge_direcciones a
     WHERE  a.cod_direccion = en_cod_direccion;

     RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
     sn_cod_retorno  := 30006;
   	 sv_mens_retorno := 'No existe direccion en la tabla GE_DIRECCIONES';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_direccion_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_direccion_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

WHEN OTHERS THEN
     sn_cod_retorno  := 30004;
   	 sv_mens_retorno := 'No es posible ejecutar este servicio';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_direccion_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_direccion_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

END ve_datos_direccion_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_datos_identificacion_fn(
                                    ev_cod_tipident   IN ge_clientes.cod_tipident%TYPE,
                                    sv_des_identifi   OUT NOCOPY ge_tipident.des_tipident%TYPE,
                                    sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN

IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

     SELECT des_tipident
     INTO   sv_des_identifi
     FROM   ge_tipident
     WHERE  cod_tipident = ev_cod_tipident;


     RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
     sn_cod_retorno  := 30007;
   	 sv_mens_retorno := 'No existe categoria en la GE_CATEGORIAS';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_identificacion_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_identificacion_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

WHEN OTHERS THEN
     sn_cod_retorno  := 30004;
   	 sv_mens_retorno := 'No es posible ejecutar este servicio';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_identificacion_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_identificacion_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

END ve_datos_identificacion_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_datos_categoria_fn (
                                en_cod_categoria  IN ge_clientes.cod_categoria%TYPE,
                                sv_des_categoria  OUT NOCOPY ge_categorias.des_categoria%TYPE,
                                sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN

IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

     lv_sql := 'SELECT des_categoria '
             ||'FROM   ge_categorias '
             ||'WHERE  cod_categoria = '||en_cod_categoria||'';

     SELECT des_categoria
     INTO   sv_des_categoria
     FROM   ge_categorias
     WHERE  cod_categoria = en_cod_categoria;


     RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
     sn_cod_retorno  := 30008;
   	 sv_mens_retorno := 'No existe categoria en la GE_CATEGORIAS';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_categoria_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_categoria_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

WHEN OTHERS THEN
     sn_cod_retorno  := 30004;
   	 sv_mens_retorno := 'No es posible ejecutar este servicio';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_categoria_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_categoria_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

END ve_datos_categoria_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ve_datos_categoria_cambio_fn (
                                en_cod_cliente    IN ge_clientes.cod_cliente%TYPE,
                                sn_cod_categocam  OUT NOCOPY fa_tasa_cambio_td.cod_categoria_cambio%TYPE,
                                sv_des_categocam  OUT NOCOPY fa_tasa_cambio_td.des_categoria_cambio%TYPE,
                                sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN

IS

lv_des_error            VARCHAR2(300);
lv_sql                  VARCHAR2(1000);

BEGIN

     sn_cod_retorno := 0;
	   sv_mens_retorno := '';
	   sn_num_evento := 0;


     lv_sql := 'SELECT COD_CATEGORIA_CAMBIO '
               || 'FROM GE_CLIENTE_TASA_TO '
               || 'WHERE COD_CLIENTE = ' || en_cod_cliente ||'';

     SELECT COD_CATEGORIA_CAMBIO 
     INTO sn_cod_categocam
     FROM GE_CLIENTE_TASA_TO 
     WHERE COD_CLIENTE = en_cod_cliente;
               
     lv_sql := 'SELECT DES_CATEGORIA_CAMBIO '
             ||'FROM   FA_TASA_CAMBIO_TD '
             ||'WHERE  COD_CATEGORIA_CAMBIO = '||sn_cod_categocam||'';

     SELECT DES_CATEGORIA_CAMBIO
     INTO   sv_des_categocam
     FROM   FA_TASA_CAMBIO_TD
     WHERE  COD_CATEGORIA_CAMBIO = sn_cod_categocam;


     RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
     --sn_cod_retorno  := 30009;
   	 --sv_mens_retorno := 'No existe categoria de cambio valida asociada al cliente';
   	 --lv_des_error 	 := 've_clientes_pg.ve_datos_categoria_cambio_fn() - ' || SQLERRM;
 	   --sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_categoria_cambio_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN TRUE;

WHEN OTHERS THEN
     sn_cod_retorno  := 30004;
   	 sv_mens_retorno := 'No es posible ejecutar este servicio';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_categoria_cambio_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_categoria_cambio_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

END ve_datos_categoria_cambio_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_datos_crediticia_fn (
                                EV_COD_CREDITICIA  IN GE_CREDITICIA_TD.COD_CREDITICIA%TYPE,
                                SV_DES_CREDITICIA  OUT NOCOPY GE_CREDITICIA_TD.DES_CREDITICIA%TYPE,
                                sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN

IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;

     lv_sql := ' SELECT DES_CREDITICIA ' || 
               ' FROM GE_CREDITICIA_TD ' ||
               ' WHERE COD_CREDITICIA = ' || EV_COD_CREDITICIA;
    
     SELECT DES_CREDITICIA 
     INTO SV_DES_CREDITICIA
     FROM GE_CREDITICIA_TD
     WHERE COD_CREDITICIA = EV_COD_CREDITICIA;

     RETURN TRUE;

EXCEPTION

WHEN OTHERS THEN
     sn_cod_retorno  := 30004;
   	 sv_mens_retorno := 'No es posible ejecutar este servicio';
   	 lv_des_error 	 := 've_clientes_pg.ve_datos_crediticia_fn() - ' || SQLERRM;
 	 sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_crediticia_fn()', lv_sql, SQLCODE, SQLERRM);

     RETURN FALSE;

END ve_datos_crediticia_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ve_rec_datos_cliente_pr(
                                  en_num_celular    IN ga_aboamist.num_celular%TYPE,
                                  sv_cod_tipident   OUT NOCOPY ge_clientes.cod_tipident%TYPE,
                                  sv_des_identifi   OUT NOCOPY ge_tipident.des_tipident%TYPE,
                                  sv_num_ident      OUT NOCOPY ge_clientes.num_ident%TYPE,
                                  sv_nom_cliente    OUT NOCOPY ge_clientes.nom_cliente%TYPE,
                                  sv_nom_apeclien1  OUT NOCOPY ge_clientes.nom_apeclien1%TYPE,
                                  sv_nom_apeclien2  OUT NOCOPY ge_clientes.nom_apeclien2%TYPE,
                                  sn_cod_categoria  OUT NOCOPY ge_clientes.cod_categoria%TYPE,
                                  sv_des_categoria  OUT NOCOPY ge_categorias.des_categoria%TYPE,
                                  sv_cod_region     OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                  --sv_des_region     OUT NOCOPY ge_regiones.des_region%TYPE, CSR-11002
                                  sv_cod_provincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                  --sv_des_provincia  OUT NOCOPY ge_provincias.des_provincia%TYPE, CSR-11002
                                  sv_cod_ciudad     OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                  --sv_des_ciudad     OUT NOCOPY ge_ciudades.des_ciudad%TYPE, CSR-11002
                                  sv_cod_comuna     OUT NOCOPY ge_direcciones.cod_comuna%TYPE,
                                  --sv_des_comuna     OUT NOCOPY ge_ciudades.des_ciudad%TYPE, CSR-11002
                                  sv_nom_calle      OUT NOCOPY ge_direcciones.nom_calle%TYPE,
                                  sv_num_calle      OUT NOCOPY ge_direcciones.num_calle%TYPE,
                                  sv_num_piso       OUT NOCOPY ge_direcciones.num_piso%TYPE, --INICIO CSR-11002
                                  sv_num_casilla    OUT NOCOPY ge_direcciones.num_casilla%TYPE,
                                  sv_obs_direccion  OUT NOCOPY ge_direcciones.obs_direccion%TYPE,
                                  sv_des_direc1     OUT NOCOPY ge_direcciones.des_direc1%TYPE,
                                  sv_des_direc2     OUT NOCOPY ge_direcciones.des_direc2%TYPE,
                                  sv_cod_pueblo     OUT NOCOPY ge_direcciones.cod_pueblo%TYPE,
                                  sv_cod_estado     OUT NOCOPY ge_direcciones.cod_estado%TYPE,
                                  sv_cod_tipocalle  OUT NOCOPY ge_direcciones.cod_tipocalle%TYPE, --FIN CSR-11002
                                  sv_zip            OUT NOCOPY ge_direcciones.zip%TYPE,
                                  sn_cod_cliente    OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                  sn_cod_cuenta     OUT NOCOPY ge_clientes.cod_cuenta%TYPE,
                                  sn_cod_categocam  OUT NOCOPY fa_tasa_cambio_td.cod_categoria_cambio%TYPE,
                                  sv_des_categocam  OUT NOCOPY fa_tasa_cambio_td.des_categoria_cambio%TYPE,
                                  SV_COD_CREDITICIA OUT NOCOPY ge_clientes.COD_CREDITICIA%TYPE,
                                  SV_DES_CREDITICIA OUT NOCOPY GE_CREDITICIA_TD.DES_CREDITICIA%TYPE,
                                  sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      				          sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	   						      sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error     VARCHAR2(300);
lv_sql           VARCHAR2(1000);
ln_cod_direccion ga_direccli.cod_direccion%TYPE;

error_ejecucion EXCEPTION;

BEGIN

     sn_cod_retorno := 0;
	 sv_mens_retorno := '';
	 sn_num_evento := 0;


     IF NOT ve_datos_cliente_fn(en_num_celular,sv_cod_tipident,sv_num_ident,sv_nom_cliente,sv_nom_apeclien1,sv_nom_apeclien2,sn_cod_categoria,
                                ln_cod_direccion,sn_cod_cliente,sn_cod_cuenta,SV_COD_CREDITICIA,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
            RAISE error_ejecucion;
     END IF;

     /*IF NOT ve_datos_direccion_fn(ln_cod_direccion,sv_cod_region,sv_des_region,sv_cod_provincia,sv_des_provincia,sv_cod_ciudad,sv_des_ciudad,
                                  sv_cod_comuna,sv_des_comuna,sv_nom_calle,sv_num_calle,sv_zip,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
            RAISE error_ejecucion;
     END IF;*/
     IF NOT ve_datos_direccion_fn(ln_cod_direccion, sv_cod_region, sv_cod_provincia, sv_cod_ciudad, sv_cod_comuna,
                                  sv_nom_calle, sv_num_calle, sv_num_piso, sv_num_casilla, sv_obs_direccion, sv_des_direc1,
                                  sv_des_direc2, sv_cod_pueblo, sv_cod_estado, sv_cod_tipocalle, sv_zip,sn_cod_retorno,
                                  sv_mens_retorno,sn_num_evento) THEN
            RAISE error_ejecucion;
     END IF;
     
     IF NOT ve_datos_identificacion_fn(sv_cod_tipident,sv_des_identifi,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
            RAISE error_ejecucion;
     END IF;

     IF NOT ve_datos_categoria_fn(sn_cod_categoria,sv_des_categoria,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
            RAISE error_ejecucion;
     END IF;
     
     IF NOT ve_datos_categoria_cambio_fn(sn_cod_cliente, sn_cod_categocam, sv_des_categocam,sn_cod_retorno,sv_mens_retorno, sn_num_evento)THEN
            RAISE error_ejecucion;
     END IF;
     
     IF NOT ve_datos_crediticia_fn (SV_COD_CREDITICIA, SV_DES_CREDITICIA, sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN
            RAISE error_ejecucion;
     END IF;                    

EXCEPTION

WHEN error_ejecucion THEN
         lv_des_error    := 've_clientes_pg.ve_rec_datos_cliente_pr() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,cv_modulove,sv_mens_retorno,cv_version , USER, 've_clientes_pg.ve_rec_datos_cliente_pr()', lv_sql, SQLCODE, lv_des_error );

WHEN OTHERS THEN
		 sn_cod_retorno  := 30004;
   	     sv_mens_retorno := 'No es posible ejecutar este servicio';
   	     lv_des_error 	 := 've_clientes_pg.ve_datos_direccion_fn() - ' || SQLERRM;
 	     sn_num_evento 	 := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_clientes_pg.ve_datos_direccion_fn()', lv_sql, SQLCODE, SQLERRM);

END ve_rec_datos_cliente_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ve_clientes_pg; 
/
SHOW ERRORS
