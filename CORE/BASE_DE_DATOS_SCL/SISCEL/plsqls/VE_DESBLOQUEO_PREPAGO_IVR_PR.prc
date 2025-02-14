CREATE OR REPLACE PROCEDURE ve_desbloqueo_prepago_ivr_pr(ev_num_ident    IN VARCHAR2,
                                                                en_num_celular  IN NUMBER, 
                                                                sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                                                sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentaci¿n TipoDoc = "Procedimiento">
    Elemento Nombre = "VE_DESBLOQUEO_PR"
    Lenguaje="PL/SQL"
    Fecha="16-01-2012"
    Versi¿n="1.0.0"
    Dise±ador="Jorge Gonzalez Navarrete"
    Programador="Jorge Gonzalez Navarrete"
    Ambiente="BD"
<Retorno></Retorno>
<Descripci¿n>
    Activa las lineas prepago en IVR
</Descripci¿n>
<Parametros>
    <Entrada>  NA    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
</Parametros>
</Elemento>
</Documentaci¿n>
*/

lv_sql            ge_errores_pg.vquery;
lv_nombre         ga_datoscliente_tse_td.nom_cliente%TYPE;
lv_apellido1      ga_datoscliente_tse_td.nom_apellido1%TYPE;
lv_apellido2      ga_datoscliente_tse_td.nom_apellido2%TYPE;
lv_cod_region     ga_datoscliente_tse_td.cod_region%TYPE;
lv_cod_provincia  ga_datoscliente_tse_td.cod_provincia%TYPE;
lv_cod_ciudad     ga_datoscliente_tse_td.cod_ciudad%TYPE;
lv_icc            ga_aboamist.num_serie%TYPE;
ln_secuencia      NUMBER;
lv_term_dummy     VARCHAR(20);      
lv_plantarif      ga_aboamist.cod_plantarif%TYPE;
lv_canal_vendedor ged_parametros.val_parametro%TYPE;
lv_procedencia    ged_parametros.val_parametro%TYPE; 
lv_num_telefono   ged_parametros.val_parametro%TYPE;
sn_codcliente     ge_clientes.cod_cliente%TYPE; 
sn_numventa       ga_ventas.num_venta%TYPE; 
sn_numcelular     ga_aboamist.num_celular%TYPE; 
sd_fecalta        ga_aboamist.fec_alta%TYPE;
lv_nom_calle      ged_parametros.val_parametro%TYPE;
ln_num_abonado    ga_aboamist.num_abonado%TYPE;
ln_cod_articulo   ged_parametros.val_parametro%TYPE;
lv_tip_ident      ged_parametros.val_parametro%TYPE;
lv_cod_comuna     ge_comunas.cod_comuna%TYPE;
ln_cod_clie_dist  ga_aboamist.cod_cliente_dist%TYPE;
ln_cod_vendedor   ve_vendedores.cod_vendedor%TYPE;
le_comuna         EXCEPTION;
le_error          EXCEPTION;
lv_des_error      VARCHAR2(300);
ln_cuenta_largo   NUMBER;  
resultadoFinal    VARCHAR2(15);
contadorfor       NUMBER;
ln_kit            NUMBER;

BEGIN 
    
    sn_cod_retorno  := '0';
    sv_mens_retorno := 'OK';
    sn_num_evento   := '0';
    -- Se obtiene los datos del cliente al cual se le realizara el desbloqueo
    -- desde la tabla GA_DATOSCLIENTE_TSE_TD    

    lv_sql := 'SELECT nom_cliente, nom_apellido1, nom_apellido2, cod_region, cod_provincia, cod_ciudad'
            ||'FROM   ga_datoscliente_tse_td '
            ||'WHERE  num_ident = '||ev_num_ident;

    SELECT nom_cliente, nom_apellido1, nom_apellido2, cod_region, cod_provincia, cod_ciudad
    INTO   lv_nombre, lv_apellido1, lv_apellido2, lv_cod_region, lv_cod_provincia,lv_cod_ciudad
    FROM   ga_datoscliente_tse_td
    WHERE  num_ident = ev_num_ident;
    
    -- Se obtiene los datos de la linea que se va a desbloquear    
    lv_sql := 'SELECT num_serie, cod_plantarif, num_abonado, cod_cliente_dist ' 
            ||'FROM   ga_aboamist '
            ||'WHERE  num_celular = '||en_num_celular||' ' 
            ||'AND    cod_situacion NOT IN (''BAA'',''BAP'')';
    
    SELECT num_serie, cod_plantarif, num_abonado, cod_cliente_dist
    INTO   lv_icc, lv_plantarif, ln_num_abonado, ln_cod_clie_dist
    FROM   ga_aboamist
    WHERE  num_celular = en_num_celular
    AND    cod_situacion NOT IN ('BAA','BAP'); 
    
    --Inicio Inc. - 26/03/2012 - FADL
    --Se obtiene el codigo vendedor asociado al cod_cliente_dist
    BEGIN
        lv_sql := 'SELECT cod_vendedor '
                ||'INTO   ln_cod_vendedor '
                ||'FROM GAC_CR.INGRESO_PREPAGO@DB_PROGAC_SCL'
                ||'WHERE  cod_clientedist = ln_cod_clie_dist '
                ||'AND num_telefono = en_num_celular '
                ||'AND ROWNUM < 2';
    
        SELECT cod_vendedor 
        INTO   ln_cod_vendedor
        FROM GAC_CR.INGRESO_PREPAGO@DB_PROGAC_SCL
        WHERE  cod_clietedist = ln_cod_clie_dist
        AND num_telefono = en_num_celular
        AND ROWNUM < 2;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                NULL;
    END;
    
    IF(ln_cod_vendedor IS NULL OR ln_cod_vendedor = '') THEN
        lv_sql := 'SELECT cod_vendedor '
            ||'FROM   ve_vendedores '
            ||'WHERE  cod_cliente = '||ln_cod_clie_dist||' '
            ||'AND ROWNUM < 2';
    
        SELECT cod_vendedor
        INTO   ln_cod_vendedor
        FROM   ve_vendedores 
        WHERE  cod_cliente = ln_cod_clie_dist
        AND ROWNUM < 2;  
    END IF;
    
    
    --Fin Inc. - 26/03/2012 - FADL
    
    --Se obtiene el codigo de la comuna por defecto
    lv_sql := 'SELECT a.cod_comuna '
            ||'FROM   ge_ciucom a, ge_comunas b '
            ||'WHERE  a.cod_region = '||lv_cod_region||' '
            ||'AND    a.cod_provincia = '||lv_cod_provincia||'' 
            ||'AND    a.cod_ciudad = '||lv_cod_ciudad||''
            ||'AND    a.cod_comuna = b.cod_comuna '
            ||'AND    b.des_comuna = ''SIN BARRIO''';
      
    SELECT a.cod_comuna
    INTO   lv_cod_comuna
    FROM   ge_ciucom a, ge_comunas b
    WHERE  a.cod_region = lv_cod_region
    AND    a.cod_provincia = lv_cod_provincia
    AND    a.cod_ciudad = lv_cod_ciudad
    AND    a.cod_comuna = b.cod_comuna
    AND    b.des_comuna = 'SIN BARRIO'; 
    
    -- Se genera num_imei usando la secuencia VE_SEQ_DUMMY_TER  y se le asigna el articulo por defecto asociado al terminal  
    /*SELECT ve_seq_dummy_ter.NEXTVAL INTO ln_secuencia FROM dual;
    
    lv_term_dummy := 'A'||ln_secuencia;*/
    
    SELECT SISCEL.ve_seq_dummy_ter.NEXTVAL INTO ln_secuencia FROM dual;
                    
    lv_term_dummy := 'A'||ln_secuencia;
                    
    SELECT LENGTH(lv_term_dummy) INTO ln_cuenta_largo FROM dual;
                    
    resultadoFinal := NULL;
                    
    IF ln_cuenta_largo < 15 THEN                     
        contadorfor := 15 - ln_cuenta_largo;
                    
        FOR counter IN 1..contadorfor LOOP                    
            resultadoFinal := resultadoFinal || '0';                    
        END LOOP;                    
        lv_term_dummy := 'A'||resultadoFinal||ln_secuencia;
    END IF;
    
    --Se obtiene articulo debloqueo prepago por defecto    
    lv_sql := 'SELECT val_parametro '
            ||'FROM   ged_parametros '
            ||'WHERE  nom_parametro = ''ARTIC_DESB_PRE'''
            ||'AND    cod_modulo = ''VE'''
            ||'AND    cod_producto = 1'; 
    
    SELECT val_parametro
    INTO   ln_cod_articulo 
    FROM   ged_parametros
    WHERE  nom_parametro = 'ARTIC_DESB_PRE'
    AND    cod_modulo = 'VE'
    AND    cod_producto = 1; 
    
    
    --Se obtiene parametro del Canal del Vendedor    
    lv_sql := 'SELECT val_parametro '
            ||'FROM   ged_parametros '
            ||'WHERE  nom_parametro = ''CANAL_VEND_DESB_PRE'''
            ||'AND    cod_modulo = ''VE'''
            ||'AND    cod_producto = 1';
     
    SELECT val_parametro
    INTO   lv_canal_vendedor 
    FROM   ged_parametros
    WHERE  nom_parametro = 'CANAL_VEND_DESB_PRE'
    AND    cod_modulo = 'VE'
    AND    cod_producto = 1; 
    
    --Se obtiene parametro de la Procedencia de Equipo
    lv_sql := 'SELECT val_parametro ' 
            ||'FROM   ged_parametros '
            ||'WHERE  nom_parametro = ''PROC_EQUI_DESB_PRE'''
            ||'AND    cod_modulo = ''VE'''
            ||'AND    cod_producto = 1';
     
    SELECT val_parametro
    INTO   lv_procedencia 
    FROM   ged_parametros
    WHERE  nom_parametro = 'PROC_EQUI_DESB_PRE'
    AND    cod_modulo = 'VE'
    AND    cod_producto = 1;
    
    --Se obtiene parametro de la numero de telefono
    lv_sql := 'SELECT val_parametro ' 
            ||'FROM   ged_parametros '
            ||'WHERE  nom_parametro = ''NUMERO_DESB_PRE'''
            ||'AND    cod_modulo = ''VE'''
            ||'AND    cod_producto = 1';
     
    SELECT val_parametro
    INTO   lv_num_telefono 
    FROM   ged_parametros
    WHERE  nom_parametro = 'NUMERO_DESB_PRE'
    AND    cod_modulo = 'VE'
    AND    cod_producto = 1;
    
    --Se obtiene parametro del nombre de la calle
    lv_sql := 'SELECT val_parametro '
            ||'FROM   ged_parametros '
            ||'WHERE  nom_parametro = ''CALLE_DESB_PRE'''
            ||'AND    cod_modulo = ''VE'''
            ||'AND    cod_producto = 1';
     
    SELECT val_parametro
    INTO   lv_nom_calle 
    FROM   ged_parametros
    WHERE  nom_parametro = 'CALLE_DESB_PRE'
    AND    cod_modulo = 'VE'
    AND    cod_producto = 1;
    
    --Se obtiene parametro del tipo de identificacion
    lv_sql := 'SELECT val_parametro '
            ||'FROM   ged_parametros '
            ||'WHERE  nom_parametro = ''TIP_IDENT_DESB_PRE'''
            ||'AND    cod_modulo = ''VE'''
            ||'AND    cod_producto = 1';
     
    SELECT val_parametro
    INTO   lv_tip_ident 
    FROM   ged_parametros
    WHERE  nom_parametro = 'TIP_IDENT_DESB_PRE'
    AND    cod_modulo = 'VE'
    AND    cod_producto = 1;
    
    --Inicio MA-184444 JLGN 15-05-2012
    --Se valida si serie obtenida del Abonado pertenece a un KIT
    
    lv_sql := 'SELECT COUNT(0) '
            ||'FROM   al_componente_kit '
            ||'WHERE  num_serie = '||lv_icc;
    
    SELECT COUNT(0)
    INTO   ln_kit 
    FROM   al_componente_kit
    WHERE  num_serie = lv_icc;
    
    IF ln_kit > 0 THEN
        --Serie pertenece a un kit
        --Se obtiene IMEI y cod_articulo del imei asociado al KIT
        
        lv_sql := 'SELECT num_serie, cod_articulo '  
                ||'FROM   ga_equipaboser '
                ||'WHERE  num_abonado = '||ln_num_abonado||' '
                ||'AND    tip_terminal = ''T''';
        
        SELECT num_serie, cod_articulo 
        INTO   lv_term_dummy, ln_cod_articulo 
        FROM   ga_equipaboser 
        WHERE  num_abonado = ln_num_abonado
        AND    tip_terminal = 'T';
        
        --Cuando es KIT la procedencia del equipo es Interna
        lv_procedencia := 'I';
        
    END IF;     
    --Fin MA-184444 JLGN 15-05-2012
    
    --Se llama al pl que desbloque Prepago
    lv_sql := 've_desbloqueaprepago_sms_pg.ve_desbloqueo_pr ('||ln_cod_vendedor||','||lv_tip_ident||','||ev_num_ident||','||lv_icc||','||lv_term_dummy||',' 
             ||lv_nombre||','||lv_apellido1||','||lv_apellido2||','||lv_plantarif||','||lv_canal_vendedor||','||lv_procedencia||','||ln_cod_articulo||','
             ||lv_num_telefono||','||lv_cod_provincia||','||lv_cod_ciudad||','||lv_cod_comuna||','||lv_nom_calle||','||'IVR, NULL)';
    
    ve_desbloqueaprepago_sms_pg.ve_desbloqueo_pr ( 
    ln_cod_vendedor,
    lv_tip_ident, 
    ev_num_ident, 
    lv_icc, 
    lv_term_dummy, 
    lv_nombre, 
    lv_apellido1, 
    lv_apellido2, 
    lv_plantarif, 
    lv_canal_vendedor,
    lv_procedencia, 
    ln_cod_articulo,
    lv_num_telefono, 
    lv_cod_provincia, 
    lv_cod_ciudad, 
    lv_cod_comuna,
    lv_nom_calle,
    'IVR', 
    NULL,
    sn_codcliente, 
    sn_numventa, 
    sn_numcelular, 
    sd_fecalta, 
    sn_cod_retorno, 
    sv_mens_retorno, 
    sn_num_evento);
    
    IF sn_cod_retorno <> 0 THEN 
        RAISE le_error;
    END IF;

EXCEPTION
    WHEN le_error THEN
        IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
            sv_mens_retorno := 'Error no clasificado';
        END IF;
        lv_des_error := 'OTHERS:ve_desbloqueo_prepago_ivr_pr();- ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento, 'VE',sv_mens_retorno, '1.0', USER,'ve_desbloqueo_prepago_ivr_pr()', lv_sql, SQLCODE, lv_des_error);
        
    WHEN le_comuna THEN
        sn_cod_retorno := 156;
        IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
            sv_mens_retorno := 'Error no clasificado';
        END IF;
        lv_des_error := 'OTHERS:ve_desbloqueo_prepago_ivr_pr;- ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento, 'VE',sv_mens_retorno, '1.0', USER,'ve_desbloqueo_prepago_ivr_pr()', lv_sql, SQLCODE, lv_des_error);
        
    WHEN NO_DATA_FOUND THEN
        sn_cod_retorno := 156;
        IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
            sv_mens_retorno := 'Error no clasificado';
        END IF;
        lv_des_error := 'OTHERS:ve_desbloqueo_prepago_ivr_pr();- ' || SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento, 'VE',sv_mens_retorno, '1.0', USER,'ve_desbloqueo_prepago_ivr_pr()', lv_sql, SQLCODE, lv_des_error);
    

END ve_desbloqueo_prepago_ivr_pr; 
/
SHOW ERRORS