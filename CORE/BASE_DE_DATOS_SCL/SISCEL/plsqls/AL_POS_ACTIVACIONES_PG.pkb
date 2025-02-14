CREATE OR REPLACE PACKAGE BODY AL_POS_ACTIVACIONES_PG AS
-- Servicio de posactivación  - Logística - Guatemala.
-- Junio 2010 - Ulises Uribe.
LV_des_error varchar2(1000);
LV_sql varchar2(1000);
--
FUNCTION P_VALIDA_DATOS_FN(        EV_serie         IN   al_series.num_serie%type,
                                    EN_cliente       IN   ge_clientes.cod_cliente%type,                              
                                    SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE
                                    ) RETURN BOOLEAN 
  IS
--                                    
v_val integer;
--                                    
BEGIN
--
--
    begin
        select 1 into v_val 
        from ga_aboamist a where a.num_serie = EV_serie
        and cod_situacion not in('BAA','BAP');
        SN_cod_retorno :=2946;-- serie pertenece a un abonado activo.
        return false; 
    exception
    when no_data_found then
        null;
    end; 
--
begin
        select 1 into v_val 
        from al_series a where a.num_serie = EV_serie;        
        SN_cod_retorno :=2948;-- serie existe en inventario SCL
        return false; 
    exception
    when no_data_found then
        null;
    end; 
--
    begin
        select 1 into v_val 
        from ge_clientes a, npt_usuario_cliente b
        where a.cod_cliente = EN_cliente
        and a.cod_cliente = b.cod_cliente;
    exception
    when no_data_found then
        SN_cod_retorno :=222; -- Cliente ingresado no es un distribuidor válido
        return false;
    end;
--
     
    begin
        select 1 into v_val 
        from npt_serie_pedido a, npt_pedido b where a.cod_serie_pedido = EV_serie
        and b.cod_pedido = a.cod_pedido
        and b.cod_cliente = EN_cliente
        and exists (select 1 from npt_estado_pedido b 
                    where a.cod_pedido = b.cod_pedido and b.cod_estado_flujo = 23); 
    exception
    when no_data_found then
        SN_cod_retorno :=2945; -- Serie no pertenece a un pedido facturado al distribuidor.
        return false;
    end;
    
    return true;       
--    
--exception
--    when others then
--        raise;
end P_VALIDA_DATOS_FN;                                    

PROCEDURE P_ACTIVACION_PUNTUAL_PR(  EV_serie         IN   al_series.num_serie%type,
                                    EN_cliente       IN   ge_clientes.cod_cliente%type,
                                    SN_numero        OUT  NOCOPY ga_aboamist.num_celular%type,
                                    SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento    OUT  NOCOPY ge_errores_pg.Evento) IS
                          
-- VARIABLES GENERALES PARA CREAR LA ESTRUCTURA DEL ABONADO
v_num_abonado     ga_aboamist.num_abonado%TYPE;
v_cod_producto    al_cargos.cod_producto%TYPE:=1;
v_cod_servicios   icg_actuaciontercen.cod_servicios%TYPE;
v_cod_tipident  ge_clientes.cod_tipident%TYPE;
v_num_ident     ge_clientes.num_ident%TYPE;
v_cod_usuario   ga_usuarios.cod_usuario%TYPE;
v_cod_pedido npt_pedido.cod_pedido%type;
v_num_venta  number(29);
v_cod_articulo number(10);
--
reg_ventas              ga_ventas%ROWTYPE;
reg_cliente             ge_clientes%ROWTYPE;
--
v_num_terminal          ga_celnum_reutil.num_celular%type;
v_cod_central           ga_celnum_reutil.cod_central%type;
v_cod_uso               ga_celnum_reutil.cod_uso%type;
v_cod_cat               ga_celnum_reutil.cod_cat%type;
v_cod_cuenta            ge_clientes.cod_cuenta%type;
v_cod_vendedor_aux      number(25);
v_ind_telefono          al_series.ind_telefono%type;
v_cod_ami_plantarif     ga_abocel.cod_plantarif%TYPE;
v_tip_ami_plantarif     ga_abocel.tip_plantarif%TYPE;
v_plan                  al_series.plan%type;
v_carga                 al_series.carga%type;
v_cod_tecnologia        al_tecnoarticulo_td.cod_tecnologia%type;
v_cod_bodega_det        npt_detalle_pedido.cod_bodega%TYPE;
v_min_mdn               ga_aboamist.NUM_MIN_MDN%TYPE;
v_cod_subalm            al_series.cod_subalm%type;
v_des_cadena            ga_transacabo.des_cadena%TYPE;
v_cod_estado            al_series.cod_estado%type;
v_actuacion_aux         icc_movimiento.cod_actuacion%type;
v_error                 number;
v_prefijo               al_usos_min.num_min%TYPE;
v_paso Varchar2(2000);
v_codactabo_chip ged_parametros.val_parametro%type;
err_val exception;
--
BEGIN
    SN_cod_retorno :=0;
    SN_num_evento :=0;

--    v_cod_uso :=3;
--    v_cod_subalm :='2020';
--    v_cod_central :=40;
--    v_cod_cat :=5; 
--    v_cod_tecnologia:='GSM';
--    v_ind_telefono:=7;
    begin
        v_cod_tecnologia:='GSM';
        LV_sql :='PV_PR_DEVVALPARAM(''GA'', 1, ''USO_POS'', v_cod_uso)';
        PV_PR_DEVVALPARAM('GA', 1, 'USO_POS', v_cod_uso);
        LV_sql :='PV_PR_DEVVALPARAM(''GA'', 1, ''CENTRAL_POS'', v_cod_central)';
        PV_PR_DEVVALPARAM('GA', 1, 'CENTRAL_POS', v_cod_central);
        LV_sql :='PV_PR_DEVVALPARAM(''GA'', 1, ''CAT_POS'', v_cod_cat)';
        PV_PR_DEVVALPARAM('GA', 1, 'CAT_POS', v_cod_cat);
        LV_sql :='PV_PR_DEVVALPARAM(''GA'', 1, ''IND_TEL_POS'', v_ind_telefono)';
        PV_PR_DEVVALPARAM('GA', 1, 'IND_TEL_POS', v_ind_telefono);
        LV_sql :='PV_PR_DEVVALPARAM(''GA'', 1, ''SUBALM_POS'', v_cod_subalm)';
        PV_PR_DEVVALPARAM('GA', 1, 'SUBALM_POS', v_cod_subalm);
    exception
    when others then
        SN_cod_retorno :=1362;
        raise err_val;
    end;    
    

    --
    --
    --***************************************************************
    --              INICIO PROCESO            
    --**************************************************************
    --
    LV_sql :='IF NOT P_VALIDA_DATOS_FN('||EV_serie||','|| EN_cliente||',SN_cod_retorno ) then';
    IF NOT P_VALIDA_DATOS_FN(EV_serie, EN_cliente,SN_cod_retorno ) then
       if SN_cod_retorno > 0 then   
            raise err_val;
       end if;
    END IF;
    --
    LV_sql :='select a.cod_pedido, a.num_doc_pedido, b.cod_articulo, a.cod_vendedor, a.cod_bodega '
               ||' from npt_pedido a, npt_detalle_pedido b, npt_serie_pedido c '
               ||' where c.cod_serie_pedido ='|| EV_serie 
               ||' and  c.cod_pedido = b.cod_pedido'
               ||' and  c.lin_det_pedido = b.lin_det_pedido'
               ||' and  b.cod_pedido = a.cod_pedido';
    --
    select a.cod_pedido, a.num_doc_pedido, b.cod_articulo, a.cod_vendedor, a.cod_bodega
    into v_cod_pedido, v_num_venta, v_cod_articulo, v_cod_vendedor_aux, v_cod_bodega_det
    from npt_pedido a, npt_detalle_pedido b, npt_serie_pedido c
    where c.cod_serie_pedido = EV_serie
    and  c.cod_pedido = b.cod_pedido
    and  c.lin_det_pedido = b.lin_det_pedido
    and  b.cod_pedido = a.cod_pedido;
    --
    LV_sql :='select * from ga_ventas where num_venta ='|| v_num_venta;
    select * into reg_ventas  from ga_ventas where num_venta = v_num_venta;      
    -- OBTENER SECUENCIAL DE ABONADO 
    LV_sql :='SELECT ga_seq_numabo.NEXTVAL  FROM DUAL';
    SELECT ga_seq_numabo.NEXTVAL
    INTO v_num_abonado
    FROM DUAL;
    --
    LV_sql :='select * from ge_clientes where cod_cliente ='|| EN_cliente;
    select * into reg_cliente from ge_clientes where cod_cliente = EN_cliente;
    --
    LV_sql :='SELECT ga_seq_usuarios.NEXTVAL FROM DUAL';
    SELECT ga_seq_usuarios.NEXTVAL
    INTO v_cod_usuario
    FROM DUAL;
    --
    LV_sql :='SELECT cod_ami_plantarif FROM ga_datosgener';
    SELECT cod_ami_plantarif
    INTO v_cod_ami_plantarif
    FROM ga_datosgener;
    --
    LV_sql :='SELECT tip_plantarif FROM ta_plantarif '; 
    SELECT tip_plantarif
    INTO v_tip_ami_plantarif
    FROM ta_plantarif
    WHERE cod_plantarif = v_cod_ami_plantarif;
    --
    BEGIN
        LV_sql := 'select cod_estado, num_movimiento'     
               ||' from al_movimientos' 
               ||' where num_serie ='|| EV_serie 
               ||' and tip_movimiento = 3' 
               ||' and num_transaccion ='|| reg_ventas.num_venta;    
        select cod_estado, num_movimiento
        into v_cod_estado, v_des_cadena 
        from al_movimientos 
        where num_serie =EV_serie 
        and tip_movimiento = 3 
        and num_transaccion = reg_ventas.num_venta;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        v_cod_estado := 7;
        v_des_cadena :=null;
    END;
    --end;
    v_plan :='P1';
    v_carga :=0;
--                                                                
    --***********************************************************************
    --inicio, primero numero.
    LV_sql:= 'al_pac_numeracion.p_asigna_un_numero('||v_cod_subalm||','|| v_cod_central ||','|| v_cod_uso ||','|| v_cod_cat||', v_num_terminal)';
    BEGIN
        al_pac_numeracion.p_asigna_un_numero(v_cod_subalm, v_cod_central, V_cod_uso, v_cod_cat, v_num_terminal);
    EXCEPTION WHEN OTHERS THEN
        SN_cod_retorno := 2947;
        raise err_val;    
    END;
    -- obtengo prefijo
    SN_numero :=v_num_terminal;    
    
    LV_sql:= 'v_min_mdn:=ge_fn_min_de_mdn ('||v_num_terminal||')';
    v_min_mdn:=ge_fn_min_de_mdn (v_num_terminal);
    
    
    LV_sql:= 'v_prefijo := al_fn_prefijo_numero('||v_num_terminal||')';
    v_prefijo := al_fn_prefijo_numero(v_num_terminal);
    
    
    -- activo central
    LV_sql:= 'SELECT cod_actcen FROM ga_actabo WHERE cod_modulo     = ''AL'' AND cod_producto   = 1    AND cod_tecnologia = ''GSM''  AND cod_actabo     = ''GA''';
    SELECT cod_actcen
    INTO v_actuacion_aux
    FROM ga_actabo
    WHERE cod_modulo     = 'AL'
    AND cod_producto   = 1
    AND cod_tecnologia = 'GSM'                
    AND cod_actabo     = 'GA';
    --
    LV_sql:= 'Al_Pac_Numeracion.p_activar_central ('||v_actuacion_aux ||','
                                                            ||  v_prefijo||','
                                                            ||  v_cod_central||','
                                                            ||  v_num_terminal||','
                                                            ||  '0,'
                                                            ||  'G,'
                                                            ||  'v_error,'
                                                            ||  v_plan||','  
                                                            ||  v_carga||','
                                                            ||  EV_serie||','
                                                            ||  'v_codactabo_chip)';    
    
    Al_Pac_Numeracion.p_activar_central (v_actuacion_aux,
                                                              v_prefijo,
                                                              v_cod_central,
                                                              v_num_terminal,
                                                              0,
                                                              'G',
                                                              v_error,
                                                              v_plan,  
                                                              v_carga, 
                                                              EV_serie,
                                                              v_codactabo_chip);
    
    al_pac_ven_dis.insertar_ga_aboamist (
                                              v_num_abonado, -- ok 
                                              v_cod_articulo, -- ok 
                                              v_num_terminal,--  ok 
                                              reg_ventas.cod_producto, -- ok 
                                              reg_ventas.cod_cliente,-- ok 
                                              reg_cliente.cod_cuenta, -- 
                                              v_cod_central,
                                              v_cod_uso,
                                              NVL (v_cod_vendedor_aux, reg_ventas.cod_vendedor),
                                              reg_ventas.cod_vendedor_agente,
                                              EV_serie,
                                              reg_ventas.num_venta,
                                              reg_ventas.cod_modventa,
                                              v_cod_servicios,
                                              v_ind_telefono,
                                              v_cod_ami_plantarif,
                                              v_tip_ami_plantarif,
                                              v_cod_usuario,
                                              v_ind_telefono,
                                              v_plan,
                                              v_carga,
                                              v_cod_tecnologia,                                 /* GSM  */
                                              NULL,
                                              v_cod_bodega_det, /*GSM  */
                                              v_min_mdn,
                                              v_cod_subalm
                                           );
     al_pac_ven_dis.insertar_ga_equipaboser (
                                              v_num_abonado,
                                              EV_serie,
                                              v_cod_producto,
                                              v_cod_bodega_det,
                                              2, --v_tip_stock
                                              v_cod_articulo,
                                              reg_ventas.cod_modventa,
                                              3, --v_cod_uso,
                                              v_cod_estado,
                                              v_des_cadena,
                                              NULL ,/* GSM  Serie terminal GSM */
                                              'GSM'
                                           );                                   
                                           -- OBTENER SERVICIOS SUPLEMENTARIOS                                      
    --
    dbms_output.put_line('v_cod_servicios ='||v_cod_servicios);
    dbms_output.put_line('v_num_abonado ='||v_num_abonado);
    dbms_output.put_line('v_num_terminal ='||v_num_terminal);
    al_pac_ven_dis.insertar_ga_servsuplabo (v_num_abonado,
                                              1,
                                              v_num_terminal,
                                              v_cod_servicios
                                           );
    --                                       
    -- OBTENER SERVICIOS SUPLEMENTARIOS                                       
    al_pac_ven_dis.insertar_ga_usuamist (
                                              v_num_abonado,
                                              reg_cliente.cod_tipident,
                                              reg_cliente.num_ident,
                                              v_cod_usuario
                                           );
    --
exception
when err_val then
     
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := 'Erro no clasificado';
     END IF;
     LV_des_error :='P_ACTIVACION_PUNTUAL_PR - ' || SUBSTR(SQLERRM,1,120);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, 'AL',SV_mens_retorno, 1, USER, 'P_ACTIVACION_PUNTUAL_PR', LV_sql, SQLCODE, LV_des_error );
when others then
         
     SN_cod_retorno :=156; 
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := 'Erro no clasificado';
     END IF;
     LV_des_error :='P_ACTIVACION_PUNTUAL_PR - ' || SUBSTR(SQLERRM,1,120);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, 'AL',SV_mens_retorno, 1, USER, 'P_ACTIVACION_PUNTUAL_PR', LV_sql, SQLCODE, LV_des_error );     
END P_ACTIVACION_PUNTUAL_PR;
--
END;
/
SHOW ERRORS