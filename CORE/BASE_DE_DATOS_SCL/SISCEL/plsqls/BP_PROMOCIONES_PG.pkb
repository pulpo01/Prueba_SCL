CREATE OR REPLACE PACKAGE BODY BP_PROMOCIONES_PG IS
-- *************************************************************
-- * Paquete            : BP_PROMOCIONES_PG
-- * Descripción        : Funciones y procedimientos de Beneficios y Promociones
-- * Fecha de creación  : Enero 2003
-- * F. de Homologacion : Agosto 2003
-- * Responsable        : Beneficios y Promociones SCL
-- *************************************************************
-- Inicio de unidades de PL/SQL
FUNCTION BP_PROMOCION_OMISION_FN (p_nnum_abonado    IN GA_ABOAMIST.NUM_ABONADO%TYPE,
                                  p_vcod_asignacion IN BPD_PLANES.COD_ASIGNACION%TYPE,
                                  p_vcod_tiplan     IN BPD_PLANES.COD_TIPLAN%TYPE) 
RETURN VARCHAR2 IS
--Declaraciones
v_vcod_plan       BPD_PLANES.COD_PLAN%TYPE;
v_dfec_desdeapli  BPD_PLANES.FEC_DESDEAPLI%TYPE;
v_vdes_plan       BPD_PLANES.DES_PLAN%TYPE;
v_nval_beneficio  BPT_BENEFICIARIOS.VAL_BENEFICIO%TYPE;
v_nerror          NUMBER;
v_verror          VARCHAR2(255);
v_vfecha_hast     VARCHAR2(20);
v_vreturn         VARCHAR2(40):='-1';
--
ERROR_PROCESO     EXCEPTION;
--
BEGIN
    v_vfecha_hast := TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL2'));
    IF p_vcod_tiplan = '1' THEN --Prepago
        v_nerror := -20010;
        SELECT  b.cod_plan, 
                b.fec_desdeapli, 
                b.des_plan, 
                b.mto_cargadic
        INTO    v_vcod_plan, 
                v_dfec_desdeapli, 
                v_vdes_plan, 
                v_nval_beneficio
        FROM    bpd_planes b, bpt_beneficios a
        WHERE   b.cod_asignacion = p_vcod_asignacion
        AND     b.ind_plan_omision = 'S'
        AND     b.cod_tiplan = p_vcod_tiplan
        AND     b.cod_estado = 'V'
        AND     b.tip_plan   IN ('A','P')
        AND     a.num_abonado = p_nnum_abonado
        AND     a.cod_plan     =b.cod_plan
        AND     a.fec_desdeapli=b.fec_desdeapli
        AND      SYSDATE BETWEEN b.FEC_DESDEAPLI AND NVL(b.fec_hastaapli, TO_DATE('01-01-3000',v_vfecha_hast));
    END IF;
    v_vreturn := v_nval_beneficio || '/' || v_vdes_plan;
    RETURN v_vreturn;

EXCEPTION
    WHEN OTHERS THEN
        RETURN v_vreturn;
END BP_PROMOCION_OMISION_FN;
--
PROCEDURE BP_INSERTA_GA_ERRORES_PR (p_vcod_actabo    IN GA_ERRORES.COD_ACTABO%TYPE,
                                    p_ncod_cliente   IN GA_ERRORES.CODIGO%TYPE,
                                    p_vcod_producto  IN GA_ERRORES.COD_PRODUCTO%TYPE,
                                    p_vnom_proc      IN GA_ERRORES.NOM_PROC%TYPE,
                                    p_vnom_tabla     IN GA_ERRORES.NOM_TABLA%TYPE,
                                    p_vcod_act       IN GA_ERRORES.COD_ACT%TYPE,
                                    p_vcod_sqlcode   IN GA_ERRORES.COD_SQLCODE%TYPE,
                                    p_vcod_sqlerrm   IN GA_ERRORES.COD_SQLERRM%TYPE) 
IS
BEGIN
    INSERT INTO GA_ERRORES (COD_ACTABO, 
                            CODIGO, 
                            FEC_ERROR, 
                            COD_PRODUCTO,
                            NOM_PROC, 
                            NOM_TABLA, 
                            COD_ACT, 
                            COD_SQLCODE, 
                            COD_SQLERRM)
                VALUES     (P_VCOD_ACTABO, 
                            NVL(P_NCOD_CLIENTE,-1), 
                            SYSDATE,  
                            P_VCOD_PRODUCTO,
                            P_VNOM_PROC, 
                            P_VNOM_TABLA, 
                            P_VCOD_ACT, 
                            P_VCOD_SQLCODE, 
                            P_VCOD_SQLERRM);
END BP_INSERTA_GA_ERRORES_PR;
--
PROCEDURE BP_REGISTRA_CAMPANA_PR   (p_vcod_campana    IN BP_CAMPANAS_TD.COD_CAMPANA%TYPE,
                                    p_ncod_cliente    IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                    p_nnum_abonado    IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                    p_cind_asignacion IN CHAR) 
IS
v_vcod_plan       BPD_PLANES.COD_PLAN%TYPE;
v_dfec_desdeapli  BPD_PLANES.FEC_DESDEAPLI%TYPE;
v_vtip_entidad    BPD_PLANES.TIP_ENTIDAD%TYPE;
v_vcod_tipplan    BPD_PLANES.COD_TIPLAN%TYPE;
v_cind_reevalua   BPD_PLANES.IND_REEVALUA%TYPE;
v_vtip_beneficio  BPD_PLANES.TIP_BENEFICIO%TYPE;
v_vtip_periodo    BPD_PLANES.TIP_PERIODO%TYPE;
v_nval_beneficio  BPT_BENEFICIARIOS.VAL_BENEFICIO%TYPE;
v_nnum_abonado    BPT_BENEFICIARIOS.NUM_ABONADO%TYPE;
v_vnum_ident      GE_CLIENTES.NUM_IDENT%TYPE;
v_vnom_tablaabo   VARCHAR2(30);
v_vfecha_hast     VARCHAR2(20);
v_nerror          NUMBER;
v_nexiste         NUMBER;
v_verror          VARCHAR2(255);
v_vcomando        VARCHAR2(255);
v_ncodigo	      NUMBER;
ERROR_PROCESO     EXCEPTION;
    --
    CURSOR c_planes_de_campanas IS
    SELECT  a.tip_beneficio, NVL(a.mto_cargadic, a.cnt_minadic), a.tip_entidad, a.cod_tiplan,
            a.ind_reevalua, a.cod_plan, a.fec_desdeapli, a.tip_periodo
    FROM    bpd_planes a, bp_planes_camp_td c, bp_campanas_td b
    WHERE   b.cod_campana   = p_vcod_campana
    AND     c.cod_campana   = b.cod_campana
    AND     a.cod_plan      = c.cod_plan
    AND     a.fec_desdeapli = c.fec_desdeapli
    AND     a.cod_estado    = 'V'
    AND     sysdate BETWEEN a.fec_desdeapli AND NVL(a.fec_hastaapli, TO_DATE('01-01-3000',v_vfecha_hast));
    --
BEGIN
    IF p_nnum_abonado = -1 THEN --Asigna el num abonado o codigo cliente segun corresponda
        v_ncodigo := p_ncod_cliente;
    ELSE
        v_ncodigo := p_nnum_abonado;
    END IF;
    
    v_vfecha_hast  := TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL2'));
    v_nnum_abonado := p_nnum_abonado;
    
    IF p_cind_asignacion = 'A' THEN --Asigna Promociones de Campaña
        SELECT COUNT(*) INTO v_nexiste
        FROM    bpd_planes a, bp_campanas_td b, bp_planes_camp_td c
        WHERE   b.cod_campana   = p_vcod_campana
        AND     c.cod_campana   = b.cod_campana
        AND     a.cod_plan      = c.cod_plan
        AND     a.fec_desdeapli = c.fec_desdeapli
        AND     a.cod_estado    = 'V'
        AND     sysdate BETWEEN a.fec_desdeapli AND NVL(a.fec_hastaapli, TO_DATE('01-01-3000',v_vfecha_hast));
        IF v_nexiste = 0 THEN
            v_nerror := -20010;
            RAISE ERROR_PROCESO;
        END IF;

        OPEN c_planes_de_campanas;
        LOOP
            FETCH c_planes_de_campanas INTO v_vtip_beneficio,
                                            v_nval_beneficio,
                                            v_vtip_entidad,
                                            v_vcod_tipplan,
                                            v_cind_reevalua, 
                                            v_vcod_plan, 
                                            v_dfec_desdeapli, 
                                            v_vtip_periodo;
            EXIT WHEN c_planes_de_campanas%NOTFOUND;
        --
            IF v_vcod_tipplan = '1' THEN-- Prepago
                v_vnom_tablaabo := 'ga_aboamist';
            ELSIF v_vcod_tipplan = '2' OR v_vcod_tipplan = '3' THEN -- Postpago e Hibrido
                v_vnom_tablaabo := 'ga_abocel';
            ELSE
                v_nerror := -20015;
                RAISE ERROR_PROCESO;
            END IF;
            --
            IF v_vtip_entidad = 'A' THEN --Abonado
                v_vcomando:= 'SELECT DISTINCT b.num_ident FROM '||v_vnom_tablaabo||' a, ge_clientes b WHERE a.num_abonado = '||v_nnum_abonado||' AND b.cod_cliente = '||p_ncod_cliente||' AND b.cod_cliente = a.cod_cliente';
            ELSIF v_vtip_entidad = 'C' THEN --Cliente
                v_vcomando:= 'SELECT DISTINCT b.num_ident FROM '||v_vnom_tablaabo||' a, ge_clientes b WHERE b.cod_cliente = a.cod_cliente AND b.cod_cliente = '||p_ncod_cliente;
                v_nnum_abonado := -1;
            ELSE
                v_nerror := -20025;
                RAISE ERROR_PROCESO;
            END IF;
        
            v_nerror := -20020;
            EXECUTE IMMEDIATE v_vcomando INTO v_vnum_ident;
            --
            v_nerror := -20030;
            
            SELECT COUNT(*)
            INTO    v_nexiste
            FROM    bpt_beneficiarios
            WHERE   cod_cliente  = p_ncod_cliente
            AND     num_abonado  = v_nnum_abonado
            AND     cod_plan     =  v_vcod_plan
            AND     fec_desdeapli= v_dfec_desdeapli
            AND     cod_estado IN ('V','N','S');

            IF v_nexiste = 0 THEN
                INSERT INTO bpt_beneficiarios  (cod_cliente,
                                                num_abonado,
                                                num_ident,
                                                cod_plan,
                                                num_periodos,
                                                fec_ingreso,
                                                cod_estado,
                                                fec_estado,
                                                nom_usuario,
                                                fec_proxproc,
                                                ind_reevalua,
                                                val_beneficio,
                                                val_acumulado,
                                                fec_desdeapli)
                                    VALUES     (p_ncod_cliente,
                                                v_nnum_abonado,
                                                v_vnum_ident,
                                                v_vcod_plan,
                                                0,
                                                sysdate,
                                                'N',
                                                sysdate,
                                                user,
                                                DECODE(v_vtip_periodo,'D',sysdate+1,'M',add_months(sysdate,1),sysdate),
                                                v_cind_reevalua,
                                                v_nval_beneficio,
                                                v_nval_beneficio,
                                                v_dfec_desdeapli);            
            ELSE
                v_nerror := -20040;
               RAISE ERROR_PROCESO;
            END IF;

        END LOOP;

        CLOSE c_planes_de_campanas;
    ELSIF p_cind_asignacion = 'C' THEN --Cancela Promocion
        UPDATE bpt_beneficiarios a
        SET a.cod_estado='T', --Terminado
            a.fec_estado=sysdate,
            a.nom_usuario = user
        WHERE a.cod_cliente = p_ncod_cliente
        AND   a.num_abonado = v_nnum_abonado
        AND   a.cod_plan    =  (SELECT  b.cod_plan
                                FROM    bp_planes_camp_td b
                                WHERE   b.cod_campana = p_vcod_campana
                                AND     a.cod_plan = b.cod_plan
                                AND     a.fec_desdeapli = b.fec_desdeapli
                                AND     a.cod_estado IN ('V','N'));
        
        UPDATE bpt_beneficios a
        SET a.cod_estado='EXC', --Excluido
            a.fec_estado=sysdate
        WHERE   a.cod_cliente = p_ncod_cliente
        AND     a.num_abonado = v_nnum_abonado
        AND     a.cod_plan = (SELECT b.cod_plan
                              FROM bp_planes_camp_td b
                              WHERE b.cod_campana = p_vcod_campana
                              AND   a.cod_plan = b.cod_plan
                              AND   a.fec_desdeapli = b.fec_desdeapli
                              AND   a.cod_estado = 'EPR');
    ELSE
        v_nerror := -20045;
        RAISE ERROR_PROCESO;
    END IF;
    --
    EXCEPTION
    WHEN ERROR_PROCESO THEN
        IF v_nerror = -20010 THEN
            v_verror := 'No existe esta Promocion o no esta vigente';
        ELSIF v_nerror = -20015 THEN
            v_verror := 'Tipo de Plan Tarifario no corresponde';
        ELSIF v_nerror = -20025 THEN
            v_verror := 'Tipo de Entidad no corresponde';
        ELSIF v_nerror = -20040 THEN
            v_verror := 'Cliente/Abonado ya existe con esta Promocion';
        ELSIF v_nerror = -20045 THEN
            v_verror := 'Indicador de accion invalido';
        END IF;
        BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',v_ncodigo,1,'BP_PROMOCIONES_PG.BP_REGISTRA_CAMPANA_PR.','Campaña='||p_vcod_campana||',cod_plan'||v_vcod_plan||', Abonado='||v_nnum_abonado, 'S', v_nerror,v_verror);
    WHEN NO_DATA_FOUND THEN
        IF v_nerror = -20010 THEN
            v_verror := 'No existe esta Promocion o no esta vigente';
        ELSIF v_nerror = -20020 THEN
            v_verror := 'No existe este Cliente/Abonado';
        END IF;
        BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',v_ncodigo,1,'BP_PROMOCIONES_PG.BP_REGISTRA_CAMPANA_PR.','Campaña='||p_vcod_campana||',cod_plan'||v_vcod_plan||', Abonado='||v_nnum_abonado, 'S', v_nerror,v_verror);
    WHEN OTHERS THEN
        v_verror := 'Error inesperado, codigo:'||TO_CHAR(SQLCODE)||'  Descripcion:'||SQLERRM;
        RAISE_APPLICATION_ERROR(v_nerror, v_verror);
END BP_REGISTRA_CAMPANA_PR;
--
FUNCTION BP_PROMOCIONES_EXISTENTES_FN(  p_vcod_asignacion IN BPD_PLANES.COD_ASIGNACION%TYPE,
                                        p_ncod_cliente    IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                        p_nnum_abonado    IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                        p_cind_existente  IN CHAR,
                                        p_vcod_tiplan     IN BPD_PLANES.COD_TIPLAN%TYPE) RETURN VARCHAR2 IS
                                        v_nerror          NUMBER;
                                        v_verror          VARCHAR2(255);
                                        v_vcomando        VARCHAR2(3000);
                                        v_vfrm_fecha      VARCHAR2(40);
                                        v_vfecha_hast     VARCHAR2(20);
                                        v_vtip_entidad    CHAR(1):='A';
                                        v_nnum_abonado    BPT_BENEFICIARIOS.NUM_ABONADO%TYPE;
BEGIN
    v_vfrm_fecha := TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL2'));
    v_vfecha_hast:= v_vfrm_fecha;
    v_vfrm_fecha := TRIM(v_vfrm_fecha) || ' ' || TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL7'));
    v_nnum_abonado := p_nnum_abonado;

    IF p_nnum_abonado < 0 THEN
        v_nnum_abonado := -1; -- Pregunta por promociones a nivel de cliente
        v_vtip_entidad :='C';
    END IF;

    IF p_cind_existente = 'A' THEN --Promociones asignadas al abonado o al cliente
    v_nerror := -20010;
        v_vcomando := 'SELECT a.cod_plan, a.des_plan, TO_CHAR(a.fec_desdeapli,'''||v_vfrm_fecha||''') fec_desdeapli,';
        v_vcomando := v_vcomando||' c.des_valor tip_beneficio,';
        v_vcomando := v_vcomando||' NVL(a.cnt_minadic, a.mto_cargadic)val_beneficio, a.cnt_periodos,';
        v_vcomando := v_vcomando||' d.des_valor tip_periodo, e.des_valor des_estado, TO_CHAR(b.fec_estado,'''||v_vfrm_fecha||''') fec_estado';
        v_vcomando := v_vcomando||' FROM bpd_planes a, bpt_beneficiarios b, ged_codigos c, ged_codigos d, ged_codigos e';
        v_vcomando := v_vcomando||' WHERE b.cod_cliente = '|| p_ncod_cliente||'';
        v_vcomando := v_vcomando||' AND b.num_abonado = '|| v_nnum_abonado||'';
        v_vcomando := v_vcomando||' AND a.cod_plan = b.cod_plan AND a.fec_desdeapli = b.fec_desdeapli';
        v_vcomando := v_vcomando||' AND a.cod_tiplan = '''||p_vcod_tiplan||'''';
        v_vcomando := v_vcomando||' AND a.tip_entidad = '''||v_vtip_entidad||'''';
        IF p_vcod_asignacion IS NOT NULL OR p_vcod_asignacion <> '' THEN
            v_vcomando := v_vcomando||' AND a.cod_asignacion = '''||p_vcod_asignacion||'''';
        END IF;
        v_vcomando := v_vcomando||' AND c.cod_modulo = ''BP'' AND c.nom_tabla = ''BPD_PLANES'' AND c.nom_columna = ''TIP_BENEFICIO'' AND c.cod_valor = a.tip_beneficio';
        v_vcomando := v_vcomando||' AND d.cod_modulo = ''BP'' AND d.nom_tabla = ''BPD_PLANES'' AND d.nom_columna = ''TIP_PERIODO'' AND d.cod_valor = a.tip_periodo';
        v_vcomando := v_vcomando||' AND e.cod_modulo = ''BP'' AND e.nom_tabla = ''BPT_BENEFICIARIOS'' AND e.nom_columna = ''COD_ESTADO'' AND e.cod_valor = b.cod_estado ORDER BY a.cod_plan';
    ELSIF p_cind_existente = 'D' THEN -- Promociones disponibles
        IF v_nnum_abonado = -1 THEN -- a nivel de clientes
            v_vcomando := 'SELECT a.cod_plan, a.des_plan, TO_CHAR(a.fec_desdeapli,'''||v_vfrm_fecha||''') fec_desdeapli, c.des_valor tip_beneficio,';
            v_vcomando := v_vcomando||' NVL(a.cnt_minadic, a.mto_cargadic)val_beneficio, a.cnt_periodos,';
            v_vcomando := v_vcomando||' d.des_valor tip_periodo,''No asignada'' des_estado, TO_CHAR(sysdate,'''||v_vfrm_fecha||''') fec_estado';
            v_vcomando := v_vcomando||' FROM bpd_planes a, ged_codigos c, ged_codigos d WHERE a.cod_estado=''V'' AND a.tip_entidad = '''||v_vtip_entidad||'''';
            v_vcomando := v_vcomando||' AND a.cod_plan NOT IN (SELECT DISTINCT b.cod_plan FROM bpt_beneficiarios b';
            v_vcomando := v_vcomando||' WHERE b.cod_cliente = '||p_ncod_cliente||'';
            v_vcomando := v_vcomando||' AND b.fec_desdeapli = a.fec_desdeapli)';
            v_vcomando := v_vcomando||' AND a.tip_plan <> ''C'' AND a.ind_plan_omision = ''N''';
            v_vcomando := v_vcomando||' AND a.cod_asignacion = '''||p_vcod_asignacion||'''';
            v_vcomando := v_vcomando||' AND sysdate BETWEEN a.fec_desdeapli AND NVL(a.fec_hastaapli, TO_DATE(''01-01-3000'','''||v_vfecha_hast||'''))';
            v_vcomando := v_vcomando||' AND c.cod_modulo = ''BP'' AND c.nom_tabla = ''BPD_PLANES'' AND c.nom_columna = ''TIP_BENEFICIO'' AND c.cod_valor = a.tip_beneficio';
            v_vcomando := v_vcomando||' AND d.cod_modulo = ''BP'' AND d.nom_tabla = ''BPD_PLANES'' AND d.nom_columna = ''TIP_PERIODO'' AND d.cod_valor = a.tip_periodo ORDER BY a.cod_plan';
        ELSE -- a nivel de abonado
            v_vcomando := 'SELECT a.cod_plan, a.des_plan, TO_CHAR(a.fec_desdeapli,'''||v_vfrm_fecha||''') fec_desdeapli, c.des_valor tip_beneficio,';
            v_vcomando := v_vcomando||' NVL(a.cnt_minadic, a.mto_cargadic)val_beneficio, a.cnt_periodos,';
            v_vcomando := v_vcomando||' d.des_valor tip_periodo,''No asignada'' des_estado, TO_CHAR(sysdate,'''||v_vfrm_fecha||''') fec_estado';
            v_vcomando := v_vcomando||' FROM bpd_planes a, ged_codigos c, ged_codigos d WHERE a.cod_estado=''V'' AND a.tip_entidad = '''||v_vtip_entidad||'''';
            v_vcomando := v_vcomando||' AND a.cod_plan NOT IN (SELECT DISTINCT b.cod_plan FROM bpt_beneficiarios b';
            v_vcomando := v_vcomando||' WHERE b.cod_cliente = '||p_ncod_cliente||'';
            v_vcomando := v_vcomando||' AND b.num_abonado   = '||v_nnum_abonado||'';
            v_vcomando := v_vcomando||' AND b.fec_desdeapli = a.fec_desdeapli)';
            v_vcomando := v_vcomando||' AND a.tip_plan <> ''C'' AND a.cod_tiplan = '''||p_vcod_tiplan||''' AND a.ind_plan_omision = ''N''';
            v_vcomando := v_vcomando||' AND a.cod_asignacion = '''||p_vcod_asignacion||'''';
            v_vcomando := v_vcomando||' AND sysdate BETWEEN a.fec_desdeapli AND NVL(a.fec_hastaapli, TO_DATE(''01-01-3000'','''||v_vfecha_hast||'''))';
            v_vcomando := v_vcomando||' AND c.cod_modulo = ''BP'' AND c.nom_tabla = ''BPD_PLANES'' AND c.nom_columna = ''TIP_BENEFICIO'' AND c.cod_valor = a.tip_beneficio';
            v_vcomando := v_vcomando||' AND d.cod_modulo = ''BP'' AND d.nom_tabla = ''BPD_PLANES'' AND d.nom_columna = ''TIP_PERIODO'' AND d.cod_valor = a.tip_periodo ORDER BY a.cod_plan';
        END IF;
    END IF;
    RETURN v_vcomando;
--
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'ERROR. NO ES POSIBLE OBTENER EL QUERY CON ESTOS PARAMETROS';
END BP_PROMOCIONES_EXISTENTES_FN;
--
FUNCTION BP_PROMOCIONES_EXISTEN_SAC_FN(p_ncod_cliente    IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                        p_nnum_abonado    IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                        p_cind_existente  IN CHAR,
                                        p_vcod_tiplan     IN BPD_PLANES.COD_TIPLAN%TYPE) RETURN VARCHAR2 IS
                                        v_nerror          NUMBER;
                                        v_verror          VARCHAR2(255);
                                        v_vcomando        VARCHAR2(2000);
                                        v_vfrm_fecha      VARCHAR2(40);
                                        v_vfecha_hast     VARCHAR2(20);
                                        v_vtip_entidad    CHAR(1):='A';
                                        v_nnum_abonado    BPT_BENEFICIARIOS.NUM_ABONADO%TYPE;
BEGIN
    v_vfrm_fecha := TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL2'));
    v_vfecha_hast:= v_vfrm_fecha;
    v_vfrm_fecha := TRIM(v_vfrm_fecha) || ' ' || TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL7'));
    v_nnum_abonado := p_nnum_abonado;

    IF p_nnum_abonado < 0 THEN
        v_nnum_abonado := -1; -- Pregunta por promociones a nivel de cliente
        v_vtip_entidad :='C';
    END IF;

    IF p_cind_existente = 'A' THEN --Promociones asignadas al abonado o al cliente
        v_nerror := -20010;
        v_vcomando := 'SELECT a.cod_plan, a.des_plan, TO_CHAR(a.fec_desdeapli,'''||v_vfrm_fecha||''') fec_desdeapli, c.des_valor tip_beneficio,';
        v_vcomando := v_vcomando||' f.des_valor ind_monto, NVL(a.cnt_minadic, a.mto_cargadic)val_beneficio, b.num_periodos,';
        v_vcomando := v_vcomando||' d.des_valor tip_valor,  g.des_valor des_tiplan, e.des_valor des_estado, TO_CHAR(b.fec_estado,'''||v_vfrm_fecha||''') fec_estado,';
        v_vcomando := v_vcomando||' TO_CHAR(b.fec_ingreso,'''||v_vfrm_fecha||''') fec_ingreso';
        v_vcomando := v_vcomando||' FROM bpd_planes a, bpt_beneficiarios b, ged_codigos c, ged_codigos d, ged_codigos e, ged_codigos f, ged_codigos g';
        v_vcomando := v_vcomando||' WHERE b.cod_cliente = '|| p_ncod_cliente||'';
        v_vcomando := v_vcomando||' AND b.num_abonado = '|| v_nnum_abonado||'';
        v_vcomando := v_vcomando||' AND a.cod_plan = b.cod_plan AND a.fec_desdeapli = b.fec_desdeapli';
        v_vcomando := v_vcomando||' AND a.tip_entidad = '''||v_vtip_entidad||'''';
        v_vcomando := v_vcomando||' AND c.cod_modulo = ''BP'' AND c.nom_tabla = ''BPD_PLANES'' AND c.nom_columna = ''TIP_BENEFICIO'' AND c.cod_valor = a.tip_beneficio';
        v_vcomando := v_vcomando||' AND d.cod_modulo = ''BP'' AND d.nom_tabla = ''BPD_PLANES'' AND d.nom_columna = ''TIP_PERIODO'' AND d.cod_valor = a.tip_periodo';
        v_vcomando := v_vcomando||' AND e.cod_modulo = ''BP'' AND e.nom_tabla = ''BPT_BENEFICIARIOS'' AND e.nom_columna = ''COD_ESTADO'' AND e.cod_valor = b.cod_estado';
        v_vcomando := v_vcomando||' AND f.cod_modulo(+) = ''BP'' AND f.nom_tabla(+) = ''BPD_PLANES'' AND f.nom_columna(+) = ''TIP_VALOR'' AND  f.cod_valor(+) = NVL(a.tip_valor,''M'')';
        v_vcomando := v_vcomando||' AND g.cod_modulo = ''GE'' AND g.nom_tabla = ''TA_PLANTARIF'' AND g.nom_columna = ''COD_TIPLAN'' AND  g.cod_valor = a.cod_tiplan ORDER BY a.cod_plan';
    ELSIF p_cind_existente = 'D' THEN -- Promociones disponibles
        IF v_nnum_abonado = -1 THEN -- a nivel de clientes
            v_vcomando := 'SELECT a.cod_plan, a.des_plan, TO_CHAR(a.fec_desdeapli,'''||v_vfrm_fecha||''') fec_desdeapli, c.des_valor tip_beneficio,';            
            v_vcomando := v_vcomando||' e.des_valor tip_valor, NVL(a.cnt_minadic, a.mto_cargadic)val_beneficio, a.cnt_periodos,';
            v_vcomando := v_vcomando||' d.des_valor tip_periodo, f.des_valor des_tiplan, ''No asignada'' des_estado, TO_CHAR(sysdate,'''||v_vfrm_fecha||''') fec_estado,';
            v_vcomando := v_vcomando||' TO_CHAR(sysdate,'''||v_vfrm_fecha||''') fec_ingreso';
            v_vcomando := v_vcomando||' FROM bpd_planes a, ged_codigos c, ged_codigos d, ged_codigos e, ged_codigos f WHERE a.cod_estado=''V'' AND a.tip_entidad = '''||v_vtip_entidad||'''';
            v_vcomando := v_vcomando||' AND a.cod_plan NOT IN (SELECT DISTINCT b.cod_plan FROM bpt_beneficiarios b';
            v_vcomando := v_vcomando||' WHERE b.cod_cliente = '||p_ncod_cliente||'';
            v_vcomando := v_vcomando||' AND b.fec_desdeapli = a.fec_desdeapli)';
            v_vcomando := v_vcomando||' AND sysdate BETWEEN a.fec_desdeapli AND NVL(a.fec_hastaapli, TO_DATE(''01-01-3000'','''||v_vfecha_hast||'''))';
            v_vcomando := v_vcomando||' AND c.cod_modulo = ''BP'' AND c.nom_tabla = ''BPD_PLANES'' AND c.nom_columna = ''TIP_BENEFICIO'' AND c.cod_valor = a.tip_beneficio';
            v_vcomando := v_vcomando||' AND d.cod_modulo = ''BP'' AND d.nom_tabla = ''BPD_PLANES'' AND d.nom_columna = ''TIP_PERIODO'' AND d.cod_valor = a.tip_periodo';
            v_vcomando := v_vcomando||' AND e.cod_modulo(+) = ''BP'' AND e.nom_tabla(+) = ''BPD_PLANES'' AND e.nom_columna(+) = ''TIP_VALOR'' AND  e.cod_valor(+) = NVL(a.tip_valor,''M'')';
            v_vcomando := v_vcomando||' AND f.cod_modulo = ''GE'' AND f.nom_tabla = ''TA_PLANTARIF'' AND f.nom_columna = ''COD_TIPLAN'' AND  f.cod_valor = a.cod_tiplan ORDER BY a.cod_plan';
        ELSE -- a nivel de abonado
            v_vcomando := 'SELECT a.cod_plan, a.des_plan, TO_CHAR(a.fec_desdeapli,'''||v_vfrm_fecha||''') fec_desdeapli, c.des_valor tip_beneficio,';
            v_vcomando := v_vcomando||' e.des_valor tip_valor, NVL(a.cnt_minadic, a.mto_cargadic)val_beneficio, a.cnt_periodos,';
            v_vcomando := v_vcomando||' d.des_valor tip_periodo, f.des_valor des_tiplan, ''No asignada'' des_estado, TO_CHAR(sysdate,'''||v_vfrm_fecha||''') fec_estado,';
            v_vcomando := v_vcomando||' TO_CHAR(sysdate,'''||v_vfrm_fecha||''') fec_ingreso';
            v_vcomando := v_vcomando||' FROM bpd_planes a, ged_codigos c, ged_codigos d, ged_codigos e, ged_codigos f WHERE a.cod_estado=''V'' AND a.tip_entidad = '''||v_vtip_entidad||'''';
            v_vcomando := v_vcomando||' AND a.cod_plan NOT IN (SELECT DISTINCT b.cod_plan FROM bpt_beneficiarios b';
            v_vcomando := v_vcomando||' WHERE b.cod_cliente = '||p_ncod_cliente||'';
            v_vcomando := v_vcomando||' AND b.num_abonado   = '||v_nnum_abonado||'';
            v_vcomando := v_vcomando||' AND b.fec_desdeapli = a.fec_desdeapli)';
            v_vcomando := v_vcomando||' AND a.cod_tiplan = '''||p_vcod_tiplan||'''';
            v_vcomando := v_vcomando||' AND sysdate BETWEEN a.fec_desdeapli AND NVL(a.fec_hastaapli, TO_DATE(''01-01-3000'','''||v_vfecha_hast||'''))';
            v_vcomando := v_vcomando||' AND c.cod_modulo = ''BP'' AND c.nom_tabla = ''BPD_PLANES'' AND c.nom_columna = ''TIP_BENEFICIO'' AND c.cod_valor = a.tip_beneficio';
            v_vcomando := v_vcomando||' AND d.cod_modulo = ''BP'' AND d.nom_tabla = ''BPD_PLANES'' AND d.nom_columna = ''TIP_PERIODO'' AND d.cod_valor = a.tip_periodo';
            v_vcomando := v_vcomando||' AND e.cod_modulo(+) = ''BP'' AND e.nom_tabla(+) = ''BPD_PLANES'' AND e.nom_columna(+) = ''TIP_VALOR'' AND  e.cod_valor(+) = NVL(a.tip_valor,''M'')';
            v_vcomando := v_vcomando||' AND f.cod_modulo = ''GE'' AND f.nom_tabla = ''TA_PLANTARIF'' AND f.nom_columna = ''COD_TIPLAN'' AND  f.cod_valor = a.cod_tiplan ORDER BY a.cod_plan';
        END IF;
    END IF;
    RETURN v_vcomando;
    --
    EXCEPTION
    WHEN OTHERS THEN
    RETURN 'ERROR. NO ES POSIBLE OBTENER EL QUERY CON ESTOS PARAMETROS';
END BP_PROMOCIONES_EXISTEN_SAC_FN;
--
PROCEDURE BP_REGISTRA_PROMOCION_PR (p_nnum_transaccion IN NUMBER,
                                    p_vcod_plan        IN BPD_PLANES.COD_PLAN%TYPE,
                                    p_dfec_desdeapli   IN VARCHAR2,
                                    p_ncod_cliente     IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                    p_nnum_abonado     IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                    p_cind_asignacion  IN CHAR,
                                    p_nnum_movimiento  IN ICC_MOVIMIENTO.num_movimiento%TYPE,
                                    p_cind_recarga_aplicada IN CHAR) 
IS
v_vtip_entidad     BPD_PLANES.TIP_ENTIDAD%TYPE;
v_vcod_tipplan     BPD_PLANES.COD_TIPLAN%TYPE;
v_cind_reevalua    BPD_PLANES.IND_REEVALUA%TYPE;
v_vtip_beneficio   BPD_PLANES.TIP_BENEFICIO%TYPE;
v_vtip_periodo     BPD_PLANES.TIP_PERIODO%TYPE;
v_nval_beneficio   BPT_BENEFICIARIOS.VAL_BENEFICIO%TYPE;
v_nnum_abonado     BPT_BENEFICIARIOS.NUM_ABONADO%TYPE;
v_vnum_ident       GE_CLIENTES.NUM_IDENT%TYPE;
v_vnom_tablaabo    VARCHAR2(30);
v_vfecha_hast      VARCHAR2(20);
v_nerror           NUMBER;
v_nexiste          NUMBER;
v_verror           VARCHAR2(255);
v_vcomando         VARCHAR2(255);
v_vfrm_fecha       VARCHAR2(40);
v_dfec_desdeapli   DATE;
v_dfec_ingreso     DATE;
v_ncnt_periodos    BPD_PLANES.CNT_PERIODOS%TYPE;
v_nnum_transaccion NUMBER;
v_ihNums_Periodo NUMBER;
v_ihSecs_Periodo NUMBER;
ERROR_PROCESO     EXCEPTION;
--
BEGIN
    
    v_vfrm_fecha := TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL2'));
    v_vfecha_hast:= v_vfrm_fecha;
    v_vfrm_fecha := TRIM(v_vfrm_fecha) || ' ' || TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL7'));
    v_nnum_abonado := p_nnum_abonado;
    
    SELECT TO_DATE(p_dfec_desdeapli,v_vfrm_fecha) INTO v_dfec_desdeapli FROM DUAL;
    v_nerror := -20010;
    
    SELECT tip_beneficio, NVL(mto_cargadic, cnt_minadic), tip_entidad, cod_tiplan, ind_reevalua, cnt_periodos, tip_periodo
    INTO v_vtip_beneficio, v_nval_beneficio, v_vtip_entidad, v_vcod_tipplan, v_cind_reevalua, v_ncnt_periodos, v_vtip_periodo
    FROM bpd_planes
    WHERE cod_plan = p_vcod_plan
    AND fec_desdeapli = v_dfec_desdeapli
    AND cod_estado = 'V'
    AND sysdate BETWEEN fec_desdeapli AND NVL(fec_hastaapli, TO_DATE('01-01-3000',v_vfecha_hast));
    --
    IF v_vcod_tipplan = '1' OR v_vcod_tipplan = '3'  THEN --Prepago e Hibrido
        IF  p_cind_recarga_aplicada = 'N' THEN --Aplicación que llama no registra recarga. La registramos aca
                BP_PROMOCIONES_PG.BP_APLICA_RECARGA_ICC_PR (p_vcod_plan, p_dfec_desdeapli, p_nnum_abonado,v_nval_beneficio,v_vcod_tipplan);
        ELSE -- Aplicación que llama SI registra recarga. Solo agendamos el resto aca
            IF p_cind_asignacion = 'A' THEN --Asigna Promocion
                IF v_vcod_tipplan = '1' THEN-- Prepago
                    v_vnom_tablaabo := 'ga_aboamist';
                ELSIF v_vcod_tipplan = '3' THEN
                    v_vnom_tablaabo := 'ga_abocel';
                ELSE
                    v_nerror := -20015;
                    RAISE ERROR_PROCESO;
                END IF;
                
                IF v_vtip_entidad = 'A' THEN --Abonado
                    v_vcomando:= 'SELECT DISTINCT b.num_ident FROM '||v_vnom_tablaabo||' a, ge_clientes b WHERE a.num_abonado = '||v_nnum_abonado||' AND b.cod_cliente = '||p_ncod_cliente||' AND b.cod_cliente = a.cod_cliente';
                ELSE
                    v_nerror := -20025;
                    RAISE ERROR_PROCESO;
                END IF;
                v_nerror := -20020;
                
                EXECUTE IMMEDIATE v_vcomando INTO v_vnum_ident;
                v_nerror := -20030;

                SELECT COUNT(*)
                INTO v_nexiste
                FROM bpt_beneficiarios
                WHERE cod_cliente 	 = p_ncod_cliente
                AND num_abonado 	 = v_nnum_abonado
                AND cod_plan    	 = p_vcod_plan
                AND fec_desdeapli = v_dfec_desdeapli
                AND cod_estado IN ('V','N','S');

                IF v_nexiste = 0 THEN

                    SELECT SYSDATE INTO v_dfec_ingreso FROM dual;

                    INSERT INTO bpt_beneficiarios
                    ( cod_cliente      ,num_abonado           ,num_ident       ,cod_plan,
                    num_periodos     ,fec_ingreso           ,cod_estado      ,fec_estado,
                    nom_usuario      ,fec_proxproc          ,ind_reevalua    ,val_beneficio,
                    val_acumulado    ,fec_desdeapli)
                    SELECT  b.cod_cliente      ,p_nnum_abonado        ,b.num_ident     ,p_vcod_plan,
                            v_ncnt_periodos    ,v_dfec_ingreso        ,'V'             ,sysdate,
                            user               ,DECODE(v_vtip_periodo,'D',sysdate + 1,'M',add_months(sysdate,1),sysdate) ,v_cind_reevalua ,v_nval_beneficio,
                            v_nval_beneficio   ,v_dfec_desdeapli
                    FROM    ga_aboamist a, ge_clientes b
                    WHERE   a.num_abonado = p_nnum_abonado
                    AND     b.cod_cliente = a.cod_cliente;

                    INSERT INTO bpt_beneficios (cod_cliente   , num_secuencia        ,num_abonado,
                                                num_ident     , cod_plan             ,sec_periodo,
                                                cod_estado    , fec_estado           ,cod_ciclfact,
                                                fec_ejecprog  , fec_desdeapli        ,fec_ingreso,
                                                num_movimiento )
                    SELECT  b.cod_cliente ,bp_sec_beneficio.nextval ,a.num_abonado,
                            b.num_ident   ,p_vcod_plan           ,1,
                            'EJE'         ,sysdate               ,to_char(add_months(sysdate,1),'ddmmyy'),
                            sysdate       ,v_dfec_desdeapli      ,v_dfec_ingreso,
                            p_nnum_movimiento
                    FROM    ga_aboamist a, ge_clientes b
                    Where   a.num_abonado = p_nnum_abonado
                    AND     b.cod_cliente = a.cod_cliente;
                    BEGIN
                        SELECT  B.NUM_PERIODOS,
                                MAX( A.SEC_PERIODO )
                                INTO v_ihNums_Periodo,
                                v_ihSecs_Periodo
                        FROM BPT_BENEFICIOS A,BPT_BENEFICIARIOS B
                        WHERE B.NUM_ABONADO     = p_nnum_abonado
                        AND     B.COD_PLAN= p_vcod_plan
                        AND     A.COD_CLIENTE   = B.COD_CLIENTE
                        AND     A.NUM_ABONADO   = B.NUM_ABONADO
                        AND     A.COD_PLAN      = B.COD_PLAN
                        AND     A.FEC_DESDEAPLI = B.FEC_DESDEAPLI
                        GROUP BY B.NUM_PERIODOS;

                        IF v_ihNums_Periodo = v_ihSecs_Periodo THEN		   			
                            UPDATE  BPT_BENEFICIARIOS
                            SET  COD_ESTADO = 'T',
                            FEC_ESTADO = SYSDATE
                            WHERE NUM_ABONADO= p_nnum_abonado
                            AND   COD_PLAN	= p_vcod_plan;		      
                        END IF;			          
                    END; 
                ELSE             	
                    v_nerror := -20040;
                    RAISE ERROR_PROCESO;
                END IF;
            ELSIF p_cind_asignacion = 'C' THEN --Cancela Promocion
                SELECT COUNT(*)
                INTO v_nexiste
                FROM bpt_beneficiarios
                WHERE cod_cliente = p_ncod_cliente
                AND num_abonado = v_nnum_abonado
                AND cod_plan =  p_vcod_plan
                AND fec_desdeapli = v_dfec_desdeapli
                AND cod_estado IN ('V','N');
    
                IF v_nexiste > 0 THEN
                    UPDATE bpt_beneficiarios
                    SET cod_estado='T', --Terminado
                    nom_usuario = user
                    WHERE cod_cliente = p_ncod_cliente
                    AND num_abonado = v_nnum_abonado
                    AND cod_plan =  p_vcod_plan
                    AND fec_desdeapli =v_dfec_desdeapli
                    AND cod_estado IN ('V','N');

                    UPDATE bpt_beneficios
                    SET cod_estado='EXC' --Excluido
                    WHERE cod_cliente = p_ncod_cliente
                    AND num_abonado = v_nnum_abonado
                    AND cod_plan =  p_vcod_plan
                    AND fec_desdeapli = v_dfec_desdeapli
                    AND cod_estado = 'EPR';
                ELSE
                    v_nerror := -20010;
                    RAISE ERROR_PROCESO;
                END IF;
            ELSE
                v_nerror := -20045;
                RAISE ERROR_PROCESO;
            END IF;
        END IF;
    ELSE -- Postpago
        IF p_cind_asignacion = 'A' THEN --Asigna Promocion
            
            IF  v_vcod_tipplan = '2' THEN -- Postpago e Hibrido
                v_vnom_tablaabo := 'ga_abocel';
            ELSE
                v_nerror := -20015;
                RAISE ERROR_PROCESO;
            END IF;
            
            IF v_vtip_entidad = 'A' THEN --Abonado
                v_vcomando:= 'SELECT DISTINCT b.num_ident FROM '||v_vnom_tablaabo||' a, ge_clientes b WHERE a.num_abonado = '||v_nnum_abonado||' AND b.cod_cliente = '||p_ncod_cliente||' AND b.cod_cliente = a.cod_cliente';
            ELSIF v_vtip_entidad = 'C' THEN --Cliente
                v_vcomando:= 'SELECT DISTINCT b.num_ident FROM '||v_vnom_tablaabo||' a, ge_clientes b WHERE b.cod_cliente = a.cod_cliente AND b.cod_cliente = '||p_ncod_cliente;
                v_nnum_abonado := -1;
            ELSE
                v_nerror := -20025;
                RAISE ERROR_PROCESO;
            END IF;
            v_nerror := -20020;
            
            EXECUTE IMMEDIATE v_vcomando INTO v_vnum_ident;
    
            v_nerror := -20030;
            SELECT COUNT(*)
            INTO v_nexiste
            FROM bpt_beneficiarios
            WHERE cod_cliente = p_ncod_cliente
            AND num_abonado = v_nnum_abonado
            AND cod_plan =  p_vcod_plan
            AND fec_desdeapli = v_dfec_desdeapli
            AND cod_estado IN ('V','N','S');

            IF v_nexiste = 0 THEN
                SELECT sysdate INTO v_dfec_ingreso FROM dual;

                IF v_vtip_entidad = 'A' THEN --Abonado
                    INSERT INTO bpt_beneficiarios
                    ( cod_cliente      ,num_abonado           ,num_ident       ,cod_plan,
                    num_periodos     ,fec_ingreso           ,cod_estado      ,fec_estado,
                    nom_usuario      ,fec_proxproc          ,ind_reevalua    ,fec_desdeapli)
                    SELECT
                    b.cod_cliente    ,p_nnum_abonado        ,b.num_ident     ,p_vcod_plan,
                    0                ,v_dfec_ingreso        ,'N'             ,sysdate,
                    user             ,v_dfec_ingreso        ,v_cind_reevalua ,v_dfec_desdeapli
                    FROM ga_abocel a, ge_clientes b
                    Where a.num_abonado  = p_nnum_abonado
                    AND b.cod_cliente    = a.cod_cliente;
                END IF;

                IF v_vtip_entidad = 'C' THEN --Cliente
                    INSERT INTO bpt_beneficiarios
                    ( cod_cliente      ,num_abonado           ,num_ident       ,cod_plan,
                    num_periodos     ,fec_ingreso           ,cod_estado      ,fec_estado,
                    nom_usuario      ,fec_proxproc          ,ind_reevalua    ,fec_desdeapli)
                    SELECT
                    UNIQUE b.cod_cliente    ,p_nnum_abonado        ,b.num_ident     ,p_vcod_plan,
                    0                ,v_dfec_ingreso        ,'N'             , sysdate,
                    user             ,v_dfec_ingreso        ,v_cind_reevalua , v_dfec_desdeapli
                    FROM ga_abocel a, ge_clientes b
                    Where a.cod_cliente  = p_ncod_cliente
                    AND b.cod_cliente = a.cod_cliente;
                END IF;
            ELSE
                v_nerror := -20040;
                RAISE ERROR_PROCESO;
            END IF;
    
        ELSIF p_cind_asignacion = 'C' THEN --Cancela Promocion
            SELECT COUNT(*)
            INTO v_nexiste
            FROM bpt_beneficiarios
            WHERE cod_cliente = p_ncod_cliente
            AND num_abonado = v_nnum_abonado
            AND cod_plan =  p_vcod_plan
            AND fec_desdeapli = v_dfec_desdeapli
            AND cod_estado IN ('V','N');

            IF v_nexiste > 0 THEN
                UPDATE bpt_beneficiarios
                SET cod_estado='T', --Terminado
                nom_usuario = user
                WHERE cod_cliente = p_ncod_cliente
                AND num_abonado = v_nnum_abonado
                AND cod_plan =  p_vcod_plan
                AND fec_desdeapli =v_dfec_desdeapli
                AND cod_estado IN ('V','N');
                
                UPDATE bpt_beneficios
                SET cod_estado='EXC' --Excluido
                WHERE cod_cliente = p_ncod_cliente
                AND num_abonado = v_nnum_abonado
                AND cod_plan =  p_vcod_plan
                AND fec_desdeapli = v_dfec_desdeapli
                AND cod_estado = 'EPR';
            ELSE
                v_nerror := -20010;
                RAISE ERROR_PROCESO;
            END IF;
    
        ELSE
            v_nerror := -20045;
            RAISE ERROR_PROCESO;
        END IF;
    END IF;

    IF p_nnum_transaccion = 0 THEN
        SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO v_nnum_transaccion FROM DUAL;
    ELSE 
        v_nnum_transaccion := p_nnum_transaccion;
    END IF; 

    INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
    VALUES (v_nnum_transaccion,0,NULL);
    
EXCEPTION
    WHEN ERROR_PROCESO THEN
        IF v_nerror = -20015 THEN
            v_verror := 'Tipo de Plan Tarifario no corresponde';
        ELSIF v_nerror = -20025 THEN
            v_verror := 'Tipo de Entidad no corresponde';
        ELSIF v_nerror = -20040 THEN
            v_verror := 'Cliente/Abonado ya existe con esta Promocion';
        ELSIF v_nerror = -20045 THEN
            v_verror := 'Indicador de accion invalido';
        ELSE
            v_verror:=SUBSTR(SQLERRM,1,60);
        END IF;
    
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (v_nnum_transaccion,4,v_verror);

    WHEN NO_DATA_FOUND THEN
        IF  v_nerror = -20010 THEN
            v_verror := 'No existe esta Promocion o no esta vigente';
        ELSIF v_nerror = -20020 THEN
            v_verror := 'No existe este Cliente/Abonado';
        ELSE
            v_verror:=SUBSTR(SQLERRM,1,60);
        END IF;
        
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (v_nnum_transaccion,4,v_verror);
        WHEN OTHERS THEN
        
        IF v_nerror = -20020 THEN
            v_verror := 'Error en el EXECUTE, codigo:'||TO_CHAR(SQLCODE)||'  Descripcion:'||SQLERRM;
        ELSE
            v_verror:=SUBSTR(SQLERRM,1,60);
        END IF;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (v_nnum_transaccion,4,v_verror);

END BP_REGISTRA_PROMOCION_PR;

PROCEDURE BP_PROMOCION_OMISION_PR (p_nnum_transaccion IN NUMBER,
                                    p_nnum_abonado        IN GA_ABOAMIST.NUM_ABONADO%TYPE,
                                    p_vcod_asignacion     IN BPD_PLANES.COD_ASIGNACION%TYPE,
                                    p_vcod_tiplan         IN BPD_PLANES.COD_TIPLAN%TYPE,
                                    p_cind_asignacion     IN CHAR,
                                    p_cind_procequi       IN BP_PARAM_PREPAGO_TD.IND_PROCEQUI%TYPE,
                                    p_ncod_canal          IN BP_PARAM_PREPAGO_TD.COD_CANAL%TYPE,
                                    p_nnum_movimiento     IN ICC_MOVIMIENTO.num_movimiento%TYPE,
                                    p_cind_recarga_aplicada IN CHAR) 
IS

--Declaraciones
v_vcod_tipplan 	  BPD_PLANES.COD_TIPLAN%TYPE;
v_vcod_plan       BPD_PLANES.COD_PLAN%TYPE;
v_dfec_desdeapli  BPD_PLANES.FEC_DESDEAPLI%TYPE;
v_cind_reevalua   BPD_PLANES.IND_REEVALUA%TYPE;
v_dfec_ingreso    BPT_BENEFICIARIOS.FEC_INGRESO%TYPE;
v_ncnt_periodos   BPD_PLANES.CNT_PERIODOS%TYPE;
v_vtip_periodo    BPD_PLANES.TIP_PERIODO%TYPE;
v_ncod_cliente    BPT_BENEFICIARIOS.COD_CLIENTE%TYPE;
v_nval_beneficio  BPT_BENEFICIARIOS.VAL_BENEFICIO%TYPE;
v_cind_procequi   BP_PARAM_PREPAGO_TD.IND_PROCEQUI%TYPE;
v_ncod_canal      BP_PARAM_PREPAGO_TD.COD_CANAL%TYPE;
v_vfecha_hast     VARCHAR2(20);
v_vfrm_fecha      VARCHAR2(40);
v_nerror          NUMBER;
v_nexiste         NUMBER;
v_verror          VARCHAR2(255);
v_ihNums_Periodo NUMBER;
v_ihSecs_Periodo NUMBER;
ERROR_PROCESO     EXCEPTION;
--
BEGIN
    v_vfrm_fecha := TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL2'));
    v_vfecha_hast:= v_vfrm_fecha;
    v_vfrm_fecha := TRIM(v_vfrm_fecha) || ' ' || TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL7'));
    
    IF p_vcod_tiplan = '1' THEN --Prepago
        v_nerror := -20010;
    
        SELECT a.cod_plan, a.fec_desdeapli, a.ind_reevalua, a.mto_cargadic, a.cnt_periodos,
        b.ind_procequi, NVL(b.cod_canal,3), a.tip_periodo, a.cod_tiplan
        INTO   v_vcod_plan, v_dfec_desdeapli, v_cind_reevalua, v_nval_beneficio, v_ncnt_periodos,
        v_cind_procequi, v_ncod_canal, v_vtip_periodo, v_vcod_tipplan
        FROM bpd_planes a, bp_param_prepago_td b
        WHERE a.cod_asignacion = p_vcod_asignacion
        AND a.ind_plan_omision = 'S'
        AND a.cod_tiplan = p_vcod_tiplan
        AND a.cod_estado = 'V'
        AND a.tip_plan IN ('A','P')
        AND sysdate BETWEEN a.fec_desdeapli AND NVL(a.fec_hastaapli, TO_DATE('01-01-3000',v_vfecha_hast))
        AND b.cod_plan = a.cod_plan
        AND b.fec_desdeapli = a.fec_desdeapli;
    
        IF NOT ((p_cind_procequi = v_cind_procequi OR v_cind_procequi = 'A') 
            AND (p_ncod_canal = v_ncod_canal OR v_ncod_canal = 3)) THEN
            v_nerror := -20030;
            RAISE ERROR_PROCESO;
        END IF;

        v_nerror := -20020;
        SELECT  b.cod_cliente
        INTO    v_ncod_cliente
        FROM ga_aboamist a, ge_clientes b
        WHERE a.num_abonado = p_nnum_abonado
        AND b.cod_cliente = a.cod_cliente;
        
        IF p_cind_asignacion = 'A' THEN --Asigna Promocion
            SELECT COUNT(*)
            INTO v_nexiste
            FROM bpt_beneficiarios
            WHERE cod_cliente = v_ncod_cliente
            AND num_abonado = p_nnum_abonado
            AND cod_plan =  v_vcod_plan
            AND fec_desdeapli = v_dfec_desdeapli
            AND cod_estado IN ('V','N','S');
            --
            IF v_nexiste = 0 THEN
                IF p_cind_recarga_aplicada ='S' THEN -- La aplicación que llama a este PL, ya asigno la primera recarga
                    SELECT sysdate INTO v_dfec_ingreso FROM dual;
                    INSERT INTO bpt_beneficiarios
                    ( cod_cliente      ,num_abonado           ,num_ident       ,cod_plan,
                    num_periodos     ,fec_ingreso           ,cod_estado      ,fec_estado,
                    nom_usuario      ,fec_proxproc          ,ind_reevalua    ,val_beneficio,
                    val_acumulado    ,fec_desdeapli)
                    SELECT
                    b.cod_cliente    ,p_nnum_abonado        ,b.num_ident     ,v_vcod_plan,
                    v_ncnt_periodos  ,v_dfec_ingreso        ,'V'             ,sysdate,
                    user             ,DECODE(v_vtip_periodo,'D',sysdate + 1,'M',add_months(sysdate,1),sysdate) ,v_cind_reevalua ,v_nval_beneficio,
                    v_nval_beneficio ,v_dfec_desdeapli
                    FROM ga_aboamist a, ge_clientes b
                    WHERE a.num_abonado = p_nnum_abonado
                    AND b.cod_cliente = a.cod_cliente;

                    INSERT INTO bpt_beneficios
                    ( cod_cliente   , num_secuencia        ,num_abonado,
                    num_ident     , cod_plan             ,sec_periodo,
                    cod_estado    , fec_estado           ,cod_ciclfact,
                    fec_ejecprog  , fec_desdeapli        ,fec_ingreso,
                    num_movimiento )
                    SELECT
                    b.cod_cliente ,bp_sec_beneficio.nextval ,a.num_abonado,
                    b.num_ident   ,v_vcod_plan           ,1,
                    'EJE'         ,sysdate               ,to_char(add_months(sysdate,1),'ddmmyy'),
                    sysdate       ,v_dfec_desdeapli      ,v_dfec_ingreso,
                    p_nnum_movimiento
                    FROM ga_aboamist a, ge_clientes b
                    WHERE a.num_abonado = p_nnum_abonado
                    AND b.cod_cliente = a.cod_cliente;

                    BEGIN
                        SELECT  B.NUM_PERIODOS,
                        MAX( A.SEC_PERIODO )
                        INTO v_ihNums_Periodo,
                            v_ihSecs_Periodo
                        FROM    
                        BPT_BENEFICIOS A,BPT_BENEFICIARIOS B
                        WHERE B.NUM_ABONADO     = p_nnum_abonado
                        AND   B.COD_PLAN= v_vcod_plan
                        AND   A.COD_CLIENTE   = B.COD_CLIENTE
                        AND   A.NUM_ABONADO   = B.NUM_ABONADO
                        AND   A.COD_PLAN      = B.COD_PLAN
                        AND   A.FEC_DESDEAPLI = B.FEC_DESDEAPLI
                        GROUP BY B.NUM_PERIODOS;
                                	        			   
                        IF v_ihNums_Periodo = v_ihSecs_Periodo THEN		   			
                            UPDATE  BPT_BENEFICIARIOS
                            SET  COD_ESTADO = 'T',
                            FEC_ESTADO = SYSDATE
                            WHERE NUM_ABONADO= p_nnum_abonado
                            AND   COD_PLAN	= v_vcod_plan;		      
                        END IF;			          
                    END; 
                ELSIF p_cind_recarga_aplicada ='N' THEN --La aplicación no asigna carga, se llama desde aca
                BP_PROMOCIONES_PG.BP_APLICA_RECARGA_ICC_PR (v_vcod_plan,to_char(v_dfec_desdeapli,v_vfrm_fecha), p_nnum_abonado,v_nval_beneficio,v_vcod_tipplan);
                ELSE
                    v_nerror := -20060;
                    RAISE ERROR_PROCESO;
                END IF;
            ELSE
                v_nerror := -20040;
                RAISE ERROR_PROCESO;
            END IF;
        ELSIF p_cind_asignacion = 'C' THEN -- Cancela Promocion
            SELECT COUNT(*)
            INTO v_nexiste
            FROM bpt_beneficiarios
            WHERE cod_cliente = v_ncod_cliente
            AND num_abonado = p_nnum_abonado
            AND cod_plan =  v_vcod_plan
            AND fec_desdeapli = v_dfec_desdeapli
            AND cod_estado IN ('V','N','S');

            IF v_nexiste > 0 THEN
                UPDATE bpt_beneficiarios
                SET cod_estado='T', --Terminado
                nom_usuario = user
                WHERE cod_cliente = v_ncod_cliente
                AND num_abonado = p_nnum_abonado
                AND cod_plan =  v_vcod_plan
                AND fec_desdeapli = v_dfec_desdeapli
                AND cod_estado IN ('V','N','S');
            --
                UPDATE bpt_beneficios
                SET cod_estado='EXC' --Excluido
                WHERE cod_cliente = v_ncod_cliente
                AND num_abonado = p_nnum_abonado
                AND cod_plan =  v_vcod_plan
                AND fec_desdeapli = v_dfec_desdeapli
                AND cod_estado = 'EPR';
            ELSE
                v_nerror := -20015;
                RAISE ERROR_PROCESO;
            END IF;
        ELSE
            v_nerror := -20055;
            RAISE ERROR_PROCESO;
        END IF;
    ELSE
        v_nerror := -20050;
        RAISE ERROR_PROCESO;
    END IF;
    -- Termino OK del PL
    INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
    VALUES (p_nnum_transaccion,0,NULL);
    --
EXCEPTION
    WHEN ERROR_PROCESO THEN
        IF v_nerror = -20030 THEN
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,0,NULL);
        ELSIF v_nerror = -20040 THEN
            v_verror := 'Cliente/Abonado ya existe con esta Promocion';
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,4,v_verror);
        ELSIF v_nerror = -20015 THEN
            v_verror := 'Cliente/Abonado no tiene esta Promocion';
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,4,v_verror);
        ELSIF v_nerror = -20050 THEN
            v_verror := 'Tipo de Plan Tarifario es incorrecto';
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,4,v_verror);
        ELSIF v_nerror = -20055 THEN
            v_verror := 'Indicador de accion es invalido';
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,4,v_verror);
        ELSIF v_nerror = -20060 THEN
            v_verror := 'Indicador de recarga aplicada es invalido';
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,4,v_verror);
        ELSE
            v_verror:=SUBSTR(SQLERRM,1,60);
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,4,v_verror);
        END IF;
    WHEN NO_DATA_FOUND THEN
        IF v_nerror = -20010 THEN
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,0,NULL);
        ELSIF v_nerror = -20020 THEN
            v_verror := 'No existe este Cliente/Abonado';
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,4,v_verror);
        ELSE
            v_verror:=SUBSTR(SQLERRM,1,60);
            INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
            VALUES (p_nnum_transaccion,4,v_verror);
        END IF;
WHEN OTHERS THEN
    v_verror := 'Error inesperado, Codigo:'||TO_CHAR(SQLCODE)||'  Descripcion:'||SQLERRM;
    INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
    VALUES (p_nnum_transaccion,4,v_verror);
END BP_PROMOCION_OMISION_PR;
--
PROCEDURE BP_INS_CONTROL_PROCESOS_PR (p_vnom_archivolog        IN BP_CONTROL_PROCESOS_TO.NOM_ARCHIVOLOG%TYPE,
                                    p_dfec_iniproceso         IN BP_CONTROL_PROCESOS_TO.FEC_INIPROCESO%TYPE,
                                    p_vnom_funcion            IN BP_CONTROL_PROCESOS_TO.NOM_FUNCION%TYPE,
                                    p_vdes_control            IN BP_CONTROL_PROCESOS_TO.DES_CONTROL%TYPE,
                                    p_dfec_control            IN BP_CONTROL_PROCESOS_TO.FEC_CONTROL%TYPE,
                                    p_nnum_nivellog           IN BP_CONTROL_PROCESOS_TO.NUM_NIVELLOG%TYPE,
                                    p_nnum_registros          IN BP_CONTROL_PROCESOS_TO.NUM_REGISTROS%TYPE,
                                    p_vind_error              IN BP_CONTROL_PROCESOS_TO.IND_ERROR%TYPE,
                                    p_vcod_planpromocion      IN BP_CONTROL_PROCESOS_TO.COD_PLANPROMOCION%TYPE,
                                    p_vnom_usuario            IN BP_CONTROL_PROCESOS_TO.NOM_USUARIO%TYPE) 
IS
BEGIN
    INSERT INTO bp_control_procesos_to (
    nom_archivolog, fec_iniproceso, nom_funcion,
    des_control, fec_control, num_nivellog,
    num_registros, ind_error, cod_planpromocion,
    nom_usuario)
    VALUES (
    p_vnom_archivolog, p_dfec_iniproceso, p_vnom_funcion,
    p_vdes_control, decode(p_dfec_control,null,sysdate,p_dfec_control), p_nnum_nivellog,
    decode(p_nnum_registros,null,0,p_nnum_registros), decode(p_vind_error,null,'N',p_vind_error), p_vcod_planpromocion,
    decode(p_vnom_usuario,null,USER,p_vnom_usuario));
    --
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20010,'Error Insert Control de Procesos Codigo: '
    ||to_char(SQLCODE)||' Descripcion: '||SQLERRM);
END BP_INS_CONTROL_PROCESOS_PR;
--
PROCEDURE BP_UPD_RECARGA_PREPAGO_PR   
IS
v_nDay NUMBER;
BEGIN
    SELECT TO_NUMBER(TO_CHAR(SYSDATE,'DD')) INTO v_nDay FROM DUAL;
    IF v_nDay = 1 THEN
        UPDATE BP_ACUMULA_PREPAGO_MES_TO
        SET MTO_PRIMERA_RECARGA_MES = 0,
        NUM_RECARGAS_MES        = 0,
        MTO_RECARGAS_MES        = 0,
        NUM_LLAMADAS_MES        = 0,
        FEC_ULTMOD              = SYSDATE,
        NOM_USUARIO             = USER;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20010,'Error Update Acumula Prepago: '||to_char(SQLCODE)||' Descripcion: '||SQLERRM);
END BP_UPD_RECARGA_PREPAGO_PR;
--
PROCEDURE BP_APLICA_RECARGA_ICC_PR (p_vcod_plan         IN BPD_PLANES.COD_PLAN%TYPE,
                                    p_dfec_desdeapli    IN VARCHAR2,
                                    p_nnum_abonado      IN BPT_BENEFICIARIOS.NUM_ABONADO%TYPE,
                                    p_nmto_cargadic     IN BPD_PLANES.MTO_CARGADIC%TYPE,
                                    p_ncod_tiplan 		IN BPD_PLANES.COD_TIPLAN%TYPE ) 
IS
v_nnum_movimiento ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
v_vfrm_fecha      VARCHAR2(40);
v_dfec_ingreso    DATE;
v_sretorno        VARCHAR2(10);
v_ncount_num      NUMBER(7);
v_ncount_ben      NUMBER(7);
v_ncount_bcios    NUMBER(7);
v_nerror          NUMBER;
v_verror          VARCHAR2(255);
v_nseq_transacabo NUMBER;
v_nom_tabla	  VARCHAR2(20);
v_nval_beneficio_conImp  BPD_PLANES.MTO_CARGADIC%TYPE;
ERROR_PROCESO     EXCEPTION;
v_ihNums_Periodo  NUMBER;
v_ihSecs_Periodo  NUMBER;

BEGIN
    
    SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO v_nnum_movimiento FROM DUAL;
    
    SELECT SYSDATE INTO v_dfec_ingreso FROM DUAL;

    v_vfrm_fecha := TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL2'));
    v_vfrm_fecha := TRIM(v_vfrm_fecha) || ' ' || TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL7'));
    IF p_ncod_tiplan = 1 THEN
        INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO,		NUM_ABONADO,		COD_ESTADO,		COD_ACTABO,
        COD_MODULO,		NUM_INTENTOS,		DES_RESPUESTA,		COD_ACTUACION,
        NOM_USUARORA,	FEC_INGRESO,		COD_CENTRAL,		NUM_CELULAR,
        NUM_SERIE,		TIP_TERMINAL,		IND_BLOQUEO,		NUM_MIN,
        CARGA,			FEC_EXPIRA,			TIP_TECNOLOGIA)
        SELECT v_nnum_movimiento,	p_nnum_abonado,		1,			   		C.COD_ACTABO,
        D.COD_MODULO,		0,					'PENDIENTE',		D.COD_ACTCEN,
        USER,				SYSDATE,			A.COD_CENTRAL,		A.NUM_CELULAR,
        A.NUM_SERIEHEX,		A.TIP_TERMINAL,		0,					A.NUM_MIN,
        p_nmto_cargadic,	   NVL(sysdate + C.DUR_RECARGA, add_months(sysdate,1)),	  A.COD_TECNOLOGIA
        FROM    TA_PLANTARIF B, GA_ABOAMIST A, BP_PARAM_PREPAGO_TD C, GA_ACTABO D
        WHERE A.NUM_ABONADO    = p_nnum_abonado
        AND A.COD_PLANTARIF  = B.COD_PLANTARIF
        AND B.COD_PRODUCTO   = 1
        AND C.COD_PLAN       = p_vcod_plan
        AND C.FEC_DESDEAPLI  = TO_DATE(p_dfec_desdeapli,v_vfrm_fecha)
        AND D.COD_PRODUCTO   = B.COD_PRODUCTO
        AND D.COD_ACTABO     = C.COD_ACTABO
        AND D.COD_MODULO     = 'BP'
        AND D.COD_TECNOLOGIA = A.COD_TECNOLOGIA;

        v_ncount_num := SQL%ROWCOUNT;
    
        IF v_ncount_num = 1 THEN
            INSERT INTO bpt_beneficiarios
            ( cod_cliente      ,num_abonado           ,num_ident       ,cod_plan,
            num_periodos     ,fec_ingreso           ,cod_estado      ,fec_estado,
            nom_usuario      ,fec_proxproc          ,ind_reevalua    ,val_beneficio,
            val_acumulado    ,fec_desdeapli)
            SELECT
            b.cod_cliente    ,p_nnum_abonado        ,b.num_ident     ,c.cod_plan,
            c.cnt_periodos   ,v_dfec_ingreso        ,'V'             ,v_dfec_ingreso,
            user             ,DECODE(c.tip_periodo,'D',sysdate + 1,'M',add_months(sysdate,1),sysdate) ,c.ind_reevalua  ,p_nmto_cargadic,
            p_nmto_cargadic  ,c.fec_desdeapli
            FROM ga_aboamist a, ge_clientes b, bpd_planes c
            WHERE a.num_abonado = p_nnum_abonado
            AND b.cod_cliente = a.cod_cliente
            AND c.cod_plan = p_vcod_plan
            AND c.fec_desdeapli = TO_DATE(p_dfec_desdeapli,v_vfrm_fecha);
            v_ncount_bcios:= SQL%ROWCOUNT;

            IF v_ncount_bcios = 0 THEN
                v_nerror  := -20030;
                RAISE ERROR_PROCESO;
            END IF;
            --
            INSERT INTO bpt_beneficios
            ( cod_cliente   , num_secuencia        ,num_abonado,
            num_ident     , cod_plan             ,sec_periodo,
            cod_estado    , fec_estado           ,cod_ciclfact,
            fec_ejecprog  , fec_desdeapli        ,fec_ingreso,
            num_movimiento )
            SELECT
            b.cod_cliente ,bp_sec_beneficio.nextval ,a.num_abonado,
            b.num_ident   ,p_vcod_plan           ,1,
            'EJE'         ,sysdate               ,to_char(add_months(sysdate,1),'ddmmyy'),
            sysdate       ,TO_DATE(p_dfec_desdeapli,v_vfrm_fecha)      ,v_dfec_ingreso,
            v_nnum_movimiento
            FROM ga_aboamist a, ge_clientes b
            WHERE a.num_abonado = p_nnum_abonado
            AND b.cod_cliente = a.cod_cliente;
            v_ncount_ben:= SQL%ROWCOUNT;

            IF v_ncount_ben = 0 THEN
                v_nerror  := -20040;
                RAISE ERROR_PROCESO;
            END IF;
        ELSE
        v_nerror := -20020;
            RAISE ERROR_PROCESO;
        END IF;

    ELSIF  p_ncod_tiplan = 3 THEN
        INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO,		NUM_ABONADO,		COD_ESTADO,		COD_ACTABO,
        COD_MODULO,		NUM_INTENTOS,		DES_RESPUESTA,		COD_ACTUACION,
        NOM_USUARORA,	FEC_INGRESO,		COD_CENTRAL,		NUM_CELULAR,
        NUM_SERIE,		TIP_TERMINAL,		IND_BLOQUEO,		NUM_MIN,
        CARGA,			FEC_EXPIRA,			TIP_TECNOLOGIA)
        SELECT v_nnum_movimiento,	p_nnum_abonado,		1,			   		C.COD_ACTABO,
        D.COD_MODULO,		0,					'PENDIENTE',		D.COD_ACTCEN,
        USER,				SYSDATE,			A.COD_CENTRAL,		A.NUM_CELULAR,
        A.NUM_SERIEHEX,		A.TIP_TERMINAL,		0,					A.NUM_MIN,
        p_nmto_cargadic,	   NVL(sysdate + C.DUR_RECARGA, add_months(sysdate,1)),	  A.COD_TECNOLOGIA
        FROM    TA_PLANTARIF B, GA_ABOCEL A, BP_PARAM_PREPAGO_TD C, GA_ACTABO D
        WHERE A.NUM_ABONADO    = p_nnum_abonado
        AND A.COD_PLANTARIF  = B.COD_PLANTARIF
        AND B.COD_PRODUCTO   = 1
        AND C.COD_PLAN       = p_vcod_plan
        AND C.FEC_DESDEAPLI  = TO_DATE(p_dfec_desdeapli,v_vfrm_fecha)
        AND D.COD_PRODUCTO   = B.COD_PRODUCTO
        AND D.COD_ACTABO     = C.COD_ACTABO
        AND D.COD_MODULO     = 'BP'
        AND D.COD_TECNOLOGIA = A.COD_TECNOLOGIA;
        v_ncount_num := SQL%ROWCOUNT;
    
        IF v_ncount_num = 1 THEN
            INSERT INTO bpt_beneficiarios
            ( cod_cliente      ,num_abonado           ,num_ident       ,cod_plan,
            num_periodos     ,fec_ingreso           ,cod_estado      ,fec_estado,
            nom_usuario      ,fec_proxproc          ,ind_reevalua    ,val_beneficio,
            val_acumulado    ,fec_desdeapli)
            SELECT
            b.cod_cliente    ,p_nnum_abonado        ,b.num_ident     ,c.cod_plan,
            c.cnt_periodos   ,v_dfec_ingreso        ,'V'             ,v_dfec_ingreso,
            user             ,sysdate 				,c.ind_reevalua  ,p_nmto_cargadic,
            p_nmto_cargadic  ,c.fec_desdeapli
            FROM ga_abocel a, ge_clientes b, bpd_planes c
            WHERE a.num_abonado = p_nnum_abonado
            AND b.cod_cliente = a.cod_cliente
            AND c.cod_plan = p_vcod_plan
            AND c.fec_desdeapli = TO_DATE(p_dfec_desdeapli,v_vfrm_fecha);

            v_ncount_bcios:= SQL%ROWCOUNT;

            IF v_ncount_bcios = 0 THEN
                v_nerror  := -20030;
                RAISE ERROR_PROCESO;
            END IF;

            INSERT INTO bpt_beneficios
            ( cod_cliente   , num_secuencia        ,num_abonado,
            num_ident     , cod_plan             ,sec_periodo,
            cod_estado    , fec_estado           ,cod_ciclfact,
            fec_ejecprog  , fec_desdeapli        ,fec_ingreso,
            num_movimiento )
            SELECT
            b.cod_cliente ,bp_sec_beneficio.nextval ,a.num_abonado,
            b.num_ident   ,p_vcod_plan           ,1,
            'EJE'         ,sysdate               ,to_char(add_months(sysdate,1),'ddmmyy'),
            sysdate       ,TO_DATE(p_dfec_desdeapli,v_vfrm_fecha)      ,v_dfec_ingreso,
            v_nnum_movimiento
            FROM ga_abocel a, ge_clientes b
            WHERE a.num_abonado = p_nnum_abonado
            AND b.cod_cliente = a.cod_cliente;

            v_ncount_ben:= SQL%ROWCOUNT;

            IF v_ncount_ben = 0 THEN
                RAISE ERROR_PROCESO;
                v_nerror  := -20040;
            END IF;

        ELSE
            v_nerror := -20020;
            RAISE ERROR_PROCESO;
        END IF;
    END IF;

    BEGIN
        SELECT B.NUM_PERIODOS,
        MAX( A.SEC_PERIODO )
        INTO    v_ihNums_Periodo,
        v_ihSecs_Periodo
        FROM	  BPT_BENEFICIOS A,BPT_BENEFICIARIOS B
        WHERE  B.NUM_ABONADO      = p_nnum_abonado
        AND    B.COD_PLAN		 = p_vcod_plan
        AND    A.COD_CLIENTE   	 = B.COD_CLIENTE
        AND    A.NUM_ABONADO   	 = B.NUM_ABONADO
        AND    A.COD_PLAN      	 = B.COD_PLAN
        AND    A.FEC_DESDEAPLI 	 = B.FEC_DESDEAPLI
        GROUP BY B.NUM_PERIODOS;
           
        IF v_ihNums_Periodo = v_ihSecs_Periodo THEN		   			
            UPDATE  BPT_BENEFICIARIOS
            SET  	  COD_ESTADO  = 'T',
            FEC_ESTADO  = SYSDATE
            WHERE   NUM_ABONADO = p_nnum_abonado
            AND     COD_PLAN	  = p_vcod_plan;
        END IF;			          
    END; 		 

    SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO v_nseq_transacabo FROM DUAL;
    PV_INS_RECARGAPREPAGO_PR(v_nseq_transacabo,'',v_nnum_movimiento);
      
EXCEPTION
    WHEN ERROR_PROCESO THEN
        IF v_nerror = -20020 THEN
            v_verror := 'No existe Abonado Para Movimiento';
            RAISE_APPLICATION_ERROR (v_nerror,v_verror);
        ELSIF v_nerror = -20030 THEN
            v_verror := 'No existe Abonado Para Beneficiarios';
            RAISE_APPLICATION_ERROR (v_nerror,v_verror);
        ELSIF v_nerror = -20040 THEN
            v_verror := 'No existe Abonado Para Beneficios';
            RAISE_APPLICATION_ERROR (v_nerror,v_verror);
        END IF;
WHEN OTHERS THEN
    v_verror := 'Error inesperado, Codigo:'||TO_CHAR(SQLCODE)||'  Descripcion:'||SQLERRM;
    RAISE_APPLICATION_ERROR(-20010, v_verror);
END BP_APLICA_RECARGA_ICC_PR;

PROCEDURE BP_CANCELA_PROMOCION_VTA_PR (p_nnum_transaccion IN NUMBER,
                                        p_ncod_cliente     IN BPT_BENEFICIARIOS.COD_CLIENTE%TYPE,
                                        p_nnum_abonado     IN GA_ABOAMIST.NUM_ABONADO%TYPE) 
IS
v_verror          VARCHAR2(255);

BEGIN
    DELETE FROM bpt_beneficiarios
    WHERE cod_cliente = p_ncod_cliente
    AND num_abonado = p_nnum_abonado;
    DELETE FROM bpt_beneficios
    WHERE cod_cliente = p_ncod_cliente
    AND num_abonado = p_nnum_abonado;
    --
    INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
    VALUES (p_nnum_transaccion,0,NULL);
    --
EXCEPTION
    WHEN OTHERS THEN
        v_verror:=SUBSTR(SQLERRM,1,60);
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (p_nnum_transaccion,4,v_verror);
END BP_CANCELA_PROMOCION_VTA_PR;

FUNCTION BP_MTOARTICULO_FN (p_vcod_articulo    IN BP_BENEF_ARTICULO_TD.COD_ARTICULO%TYPE,
                            p_dfec_beneficio   IN BP_BENEF_ARTICULO_TD.FEC_DESDEVIGE%TYPE ) RETURN NUMBER
IS
v_nmto_benef BP_BENEF_ARTICULO_TD.MTO_BENEF%TYPE;

BEGIN
    SELECT NVL(mto_benef,-1) INTO v_nmto_benef
    FROM bp_benef_articulo_td
    WHERE cod_articulo = p_vcod_articulo
    AND p_dfec_beneficio BETWEEN fec_desdevige AND fec_hastavige;
    RETURN v_nmto_benef;
EXCEPTION
    WHEN OTHERS THEN
    RETURN -1;
END BP_MTOARTICULO_FN;

FUNCTION BP_LLENA_NTIP_FN(p_vcod_param IN VARCHAR2) RETURN NUMBER
IS
v_ncod_apli NUMBER(3):=0;
BEGIN
    SELECT COD_APLI
    INTO v_ncod_apli
    FROM SCH_CODIGOS
    WHERE COD_TIPO  ='TIPDCTO'
    AND COD_PARAM =UPPER(p_vcod_param);
    RETURN v_ncod_apli;
    --
EXCEPTION
    WHEN OTHERS THEN
    RETURN v_ncod_apli;
END BP_LLENA_NTIP_FN;
--------------------
PROCEDURE BP_VALIDA_CARGA_PR(p_nnum_celular  IN     GA_ABOCEL.NUM_CELULAR%TYPE,
                            p_vcod_tiplan    IN     BPD_PLANES.COD_TIPLAN%TYPE,
                            p_vtip_beneficio IN     BPD_PLANES.TIP_BENEFICIO%TYPE,
                            p_vcod_plan      IN     BPD_PLANES.COD_PLAN%TYPE,
                            p_dfec_desdeapli IN     BPD_PLANES.FEC_DESDEAPLI%TYPE,
                            p_ncod_cliente   IN OUT GA_ABOCEL.COD_CLIENTE%TYPE,
                            p_nnum_abonado   OUT    GA_ABOCEL.NUM_ABONADO%TYPE,
                            p_nretorno       OUT    BP_CARGA_MASIVA_TO.COD_ERROR%TYPE) 
IS
-- Declaracion de Variables
v_nretorno        NUMBER(1):=-1;
v_ncantbene       NUMBER(5):=0; 
v_nnum_abonado    GA_ABOCEL.NUM_ABONADO%TYPE;
v_ncod_cliente    GA_ABOCEL.COD_CLIENTE%TYPE;
v_vcod_situacion  GA_ABOCEL.COD_SITUACION%TYPE;
v_vcod_tiplan     TA_PLANTARIF.COD_TIPLAN%TYPE;
v_vcomando        VARCHAR2(1200); 
v_vnom_tablaabo   VARCHAR2(30);
BEGIN
    p_nnum_abonado :=-1;
    IF LTRIM(RTRIM(p_vcod_tiplan)) = '2' OR LTRIM(RTRIM(p_vcod_tiplan)) = '3' THEN -- POSTPAGO E HIBRIDO
        v_vnom_tablaabo := 'GA_ABOCEL';
    ELSIF LTRIM(RTRIM(p_vcod_tiplan)) = '1' THEN  --PREPAGO
        v_vnom_tablaabo := 'GA_ABOAMIST';
    END IF;


    IF p_ncod_cliente  <> 0 THEN
        v_vcomando := 'SELECT DISTINCT a.cod_cliente, NULL, -1, ''' || p_vcod_tiplan ||'''';
        v_vcomando := v_vcomando||' FROM '||v_vnom_tablaabo||' a, TA_PLANTARIF t';
        v_vcomando := v_vcomando||' WHERE a.cod_cliente = '|| p_ncod_cliente||'';
    ELSIF p_nnum_celular <> 0 THEN
        v_vcomando := 'SELECT a.cod_cliente, a.cod_situacion, a.num_abonado, t.cod_tiplan ';
        v_vcomando := v_vcomando||' FROM '||v_vnom_tablaabo||' a, TA_PLANTARIF t';
        v_vcomando     := v_vcomando||' WHERE a.num_celular = '|| p_nnum_celular||'';
    END IF;
    v_vcomando := v_vcomando||' AND a.cod_situacion not in ('||'''BAA'''||','||'''BAP'''||')';
    v_vcomando := v_vcomando||' AND t.cod_producto  =a.cod_producto  ';
    v_vcomando := v_vcomando||' AND t.cod_plantarif =a.cod_plantarif ';
    IF  p_vcod_tiplan = '3' THEN
        v_vcomando := v_vcomando||' AND t.cod_tiplan    =''' || p_vcod_tiplan ||'''';
    END IF;

    BEGIN
        EXECUTE IMMEDIATE v_vcomando
        INTO  v_ncod_cliente
            ,v_vcod_situacion
            ,v_nnum_abonado
            ,v_vcod_tiplan;
            IF SQL%FOUND THEN
                v_nretorno   :=0;
                IF LTRIM(RTRIM(p_vcod_tiplan)) = '1' THEN    --PLAN PREPAGO
                    IF LTRIM(RTRIM(p_vcod_tiplan)) <> LTRIM(RTRIM(v_vcod_tiplan)) THEN --Cliente vs PLAN
                    --Retorna 2 Plan Prepago/Cliente Pospago
                        IF LTRIM(RTRIM(v_vcod_tiplan)) = '2' THEN
                            v_nretorno :=2;
                            --Retorna 3 Plan Prepago/Cliente Hibrido
                        ELSIF LTRIM(RTRIM(v_vcod_tiplan)) = '3' THEN
                            v_nretorno :=3;
                        END IF;                 
                    END IF;
                ELSIF LTRIM(RTRIM(p_vcod_tiplan)) = '2' THEN --PLAN POSTPAGO
                    IF LTRIM(RTRIM(p_vcod_tiplan)) <> LTRIM(RTRIM(v_vcod_tiplan)) THEN --Cliente vs PLAN
                        v_nretorno :=4;  --4 - Plan Pospago/Cliente Prepago por Defecto
                        IF LTRIM(RTRIM(v_vcod_tiplan)) = '3' THEN --CLIENTE ES HIBRIDO
                            IF LTRIM(RTRIM(p_vtip_beneficio)) = 'DF' THEN
                                v_nretorno   :=0;
                            ELSIF LTRIM(RTRIM(p_vtip_beneficio)) = 'ML' THEN
                                v_nretorno   :=5;
                            ELSIF LTRIM(RTRIM(p_vtip_beneficio)) = 'CA' THEN
                                v_nretorno   :=0;
                            ELSE
                                v_nretorno   :=5;                        
                            END IF;
                        END IF;
                    END IF;
                ELSIF LTRIM(RTRIM(p_vcod_tiplan)) = '3' THEN --PLAN HIBRIDO
                    IF LTRIM(RTRIM(v_vcod_tiplan)) ='1' THEN
                        v_nretorno   :=6;  --6 - Plan Hibrido/Cliente Prepago
                    ELSIF LTRIM(RTRIM(v_vcod_tiplan)) ='2' THEN
                        v_nretorno   :=7;  --7 - Plan Hibrido/Cliente Pospago                                  
                    END IF;
                END IF;
    
                IF LTRIM(RTRIM(v_vcod_situacion)) ='BAA' THEN --8.- Abonado Esta de Baja
                    v_nretorno   :=8;
                END IF;
    
                IF p_ncod_cliente  <> 0 THEN
                    p_nnum_abonado :=-1;
                ELSE
                    p_nnum_abonado :=v_nnum_abonado;
                    p_ncod_cliente :=v_ncod_cliente;
                END IF;

                IF v_nretorno = 0 THEN
                    BEGIN
                        SELECT COUNT(1)
                        INTO   v_ncantbene
                        FROM   BPT_BENEFICIARIOS
                        WHERE  cod_cliente   = p_ncod_cliente
                        AND  num_abonado   = p_nnum_abonado
                        AND  cod_plan      = p_vcod_plan
                        AND  fec_desdeapli = p_dfec_desdeapli
                        AND  cod_estado <> 'T'; /*Ticket de Problema 205732 16-02-2015*/
            
                        IF v_ncantbene > 0 THEN
                            v_nretorno :=9;  -- 9 Abonado ya tiene el plan asignado
                        ELSE
                            v_nretorno :=0;
                        END IF;
                    END; 
                END IF;
            END IF;
            
            EXCEPTION WHEN NO_DATA_FOUND THEN
            v_nretorno :=1; --No existe en SCL.
    END;
    --Retorno Tipo estado
    p_nretorno := v_nretorno;
EXCEPTION
    WHEN OTHERS THEN
       p_nretorno :=-1; --Retorno Tipo ERROR
END BP_VALIDA_CARGA_PR;
--------------------
FUNCTION BP_UPD_CARGA_MASIVA_FN(p_ncod_transaccion IN BP_CARGA_MASIVA_TO.COD_TRANSACCION%TYPE,
                                p_ncod_cliente     IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                p_nnum_celular     IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                p_nnum_abonado     IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                p_ncod_clicte      IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                p_dfec_desdeapli   IN BPD_PLANES.FEC_DESDEAPLI%TYPE,
                                p_dfec_hastaapli   IN BPD_PLANES.FEC_HASTAAPLI%TYPE,
                                p_ncod_error       IN BP_CARGA_MASIVA_TO.COD_ERROR%TYPE ) RETURN NUMBER 
IS
-- Declaracion de Variables
v_nretorno      NUMBER(1):=-1;
v_ncount_num    NUMBER(1):=0;

BEGIN
    UPDATE BP_CARGA_MASIVA_TO
    SET     num_abonado     =p_nnum_abonado
    ,cod_cliente     =p_ncod_clicte
    ,fec_desdeapli   =p_dfec_desdeapli
    ,fec_hastaapli   =p_dfec_hastaapli
    ,cod_error       =p_ncod_error
    WHERE COD_TRANSACCION   =p_ncod_transaccion
    AND NUM_CELULAR       =p_nnum_celular
    AND COD_CLIENTE       =p_ncod_cliente;
    v_ncount_num := SQL%ROWCOUNT;

    IF v_ncount_num = 1 THEN
        v_nretorno := 0;
    ELSE
        v_nretorno :=-1;
    END IF;

    RETURN v_nretorno;

EXCEPTION
    WHEN OTHERS THEN
    RETURN v_nretorno; --Retorno Tipo ERROR
END BP_UPD_CARGA_MASIVA_FN;
--------------------------
FUNCTION BP_ASIGNA_BENEFICIOS_FN(p_ncod_cliente     IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                p_nnum_abonado     IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                p_nnum_ident       IN GE_CLIENTES.NUM_IDENT%TYPE,
                                p_dfec_desdeapli   IN BPD_PLANES.FEC_DESDEAPLI%TYPE,
                                p_vcind_reevalua   IN BPD_PLANES.IND_REEVALUA%TYPE,
                                p_vcod_plan        IN BPD_PLANES.COD_PLAN%TYPE) RETURN NUMBER 
IS
v_nretorno      NUMBER(1):=-1;
v_ncount_num    NUMBER(1):=0;
BEGIN
    INSERT INTO bpt_beneficiarios
    (cod_cliente   ,num_abonado   ,num_ident    ,cod_plan,
    num_periodos  ,fec_ingreso   ,cod_estado   ,fec_estado,
    nom_usuario   ,fec_proxproc  ,ind_reevalua ,val_beneficio,
    val_acumulado ,fec_desdeapli)
    VALUES
    (p_ncod_cliente   ,p_nnum_abonado ,p_nnum_ident ,p_vcod_plan,
    0                ,sysdate        ,'N'          ,sysdate,
    user             ,sysdate        ,p_vcind_reevalua, Null,
    Null             ,p_dfec_desdeapli );
    v_ncount_num := SQL%ROWCOUNT;

    IF v_ncount_num = 1 THEN
        v_nretorno := 0;
    ELSE
        v_nretorno :=-1;
    END IF;

    RETURN v_nretorno;

EXCEPTION
    WHEN OTHERS THEN
        RETURN v_nretorno; --Retorno Tipo ERROR
END BP_ASIGNA_BENEFICIOS_FN;
----------------------------
PROCEDURE BP_CREAJOB_TMP_PR(p_ntransaccion IN NUMBER)
IS
v_nJob NUMBER;
BEGIN
    DBMS_JOB.SUBMIT( v_nJob , 'BEGIN BP_PROMOCIONES_PG.BP_DEL_TMP_CARGA_MASIVA_PR(' || p_ntransaccion || '); END;' , SYSDATE );
    COMMIT;
END BP_CREAJOB_TMP_PR;
---------------------------
PROCEDURE BP_CARGA_MASIVA_PR(p_ncod_transaccion  IN BP_CARGA_MASIVA_TO.COD_TRANSACCION%TYPE)
IS
-- Declaracion de Variables
v_ncod_transaccion  BP_CARGA_MASIVA_TO.COD_TRANSACCION%TYPE;
v_nnum_celular      BP_CARGA_MASIVA_TO.NUM_CELULAR%TYPE;
v_ncod_cliente      BP_CARGA_MASIVA_TO.COD_CLIENTE%TYPE; 
v_vcod_plan         BP_CARGA_MASIVA_TO.COD_PLAN%TYPE;
v_vtip_beneficio    BPD_PLANES.TIP_BENEFICIO%TYPE;
v_dfec_desdeapli    BPD_PLANES.FEC_DESDEAPLI%TYPE;
v_dfec_hastaapli    BPD_PLANES.FEC_HASTAAPLI%TYPE;
v_vcod_tiplan       BPD_PLANES.COD_TIPLAN%TYPE;
-----------------------------------------------
v_ncod_clicte       BP_CARGA_MASIVA_TO.COD_CLIENTE%TYPE;
v_nnumabonado       GA_ABOCEL.NUM_ABONADO%TYPE;
v_num_abonado       GA_ABOCEL.NUM_ABONADO%TYPE;
v_nretornoval       NUMBER(1):=-1;
v_nretoroupd        NUMBER(1):=-1;
n_nerror            NUMBER;
v_verror            VARCHAR2(255);
ERROR_PROCESO       EXCEPTION;
--------------------------
    CURSOR cur_carmasiva
    IS
    SELECT t.cod_transaccion
    ,t.num_celular
    ,t.cod_cliente
    ,t.cod_plan
    ,p.tip_beneficio
    ,p.fec_desdeapli
    ,p.fec_hastaapli
    ,p.cod_tiplan
    FROM BP_CARGA_MASIVA_TO t, BPD_PLANES p
    WHERE  t.cod_transaccion =p_ncod_transaccion
    AND  p.cod_plan        =t.cod_plan 
    AND  p.cod_estado      ='V';

BEGIN
    n_nerror :=-20010;
    OPEN cur_carmasiva;
    LOOP
        FETCH cur_carmasiva INTO
        v_ncod_transaccion
        ,v_nnum_celular
        ,v_ncod_cliente
        ,v_vcod_plan
        ,v_vtip_beneficio
        ,v_dfec_desdeapli
        ,v_dfec_hastaapli
        ,v_vcod_tiplan;
        EXIT WHEN cur_carmasiva%NOTFOUND;
        BEGIN
            v_ncod_clicte :=v_ncod_cliente;
            BP_PROMOCIONES_PG.BP_VALIDA_CARGA_PR(v_nnum_celular,v_vcod_tiplan,v_vtip_beneficio,v_vcod_plan,v_dfec_desdeapli,v_ncod_clicte,v_nnumabonado,v_nretornoval);
            IF v_nretornoval =-1 THEN
                n_nerror :=-20020;
                RAISE ERROR_PROCESO;
            END IF;
            v_nretoroupd := BP_PROMOCIONES_PG.BP_UPD_CARGA_MASIVA_FN(v_ncod_transaccion,v_ncod_cliente,v_nnum_celular,v_nnumabonado,v_ncod_clicte,v_dfec_desdeapli,v_dfec_hastaapli,v_nretornoval);
            IF v_nretoroupd =-1 THEN
                n_nerror := -20030;
                RAISE ERROR_PROCESO;
            END IF;
        END;
    END LOOP;
    CLOSE cur_carmasiva;
    -------------------
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        IF n_nerror = -20010 THEN
            v_verror  :='No Existe Carga Masiva Para esta Secuencia: '||TO_CHAR(p_ncod_transaccion);
        END IF;
        ROLLBACK;
        BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',-1,1,'BP_PROMOCIONES_PG.BP_CARGA_MASIVA_PR.',
        'transaccion='||p_ncod_transaccion||' BP_CARGA_MASIVA_TO', 'S', n_nerror,v_verror);
        COMMIT;
        RAISE_APPLICATION_ERROR(n_nerror, v_verror);
    WHEN ERROR_PROCESO THEN
        IF n_nerror = -20020 THEN
          v_verror  :='Error en Validar la Carga Masiva Retorna: '||TO_CHAR(v_nretornoval);
            ROLLBACK;
            BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',-1,1,'BP_PROMOCIONES_PG.BP_VALIDA_CARGA_PR.',
            'transaccion='||p_ncod_transaccion||' BP_CARGA_MASIVA_TO', 'S', n_nerror,v_verror);
            COMMIT;
        ELSIF n_nerror = -20030 THEN
            v_verror  :='Error en Actualizar la Carga Masiva Retorna: '||TO_CHAR(v_nretoroupd);
            ROLLBACK;
            BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',-1,1,'BP_PROMOCIONES_PG.BP_UPD_CARGA_MASIVA_FN.',
            'transaccion='||p_ncod_transaccion||' BP_CARGA_MASIVA_TO', 'S', n_nerror,v_verror);
            COMMIT;
        END IF;
        RAISE_APPLICATION_ERROR(n_nerror, v_verror);
    WHEN OTHERS THEN
        n_nerror :=SQLCODE;
        v_verror :='Error inesperado, Descripcion:'||SQLERRM;
        ROLLBACK;
        BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',-1,1,'BP_PROMOCIONES_PG.BP_CARGA_MASIVA_PR.',
        'transaccion='||p_ncod_transaccion||' BP_CARGA_MASIVA_TO', 'S', n_nerror, SUBSTR(v_verror,1,60));
        COMMIT;
        RAISE_APPLICATION_ERROR(n_nerror, v_verror);
END BP_CARGA_MASIVA_PR;
-----------------------
PROCEDURE BP_ASIGNA_BENEFICIOS_PR(p_ncod_transaccion  IN BP_CARGA_MASIVA_TO.COD_TRANSACCION%TYPE)
IS
-- Declaracion de Variables
v_nnum_celular      BP_CARGA_MASIVA_TO.NUM_CELULAR%TYPE;
v_ncod_cliente      GA_ABOCEL.COD_CLIENTE%TYPE;
v_nnum_abonado      GA_ABOCEL.NUM_ABONADO%TYPE;
v_vcod_plan         BPD_PLANES.COD_PLAN%TYPE;
v_dfec_desdeapli    BPD_PLANES.FEC_DESDEAPLI%TYPE;
v_ncod_tiplan       BPD_PLANES.COD_TIPLAN%TYPE;
v_vind_rec_enlinea  BPD_PLANES.IND_REC_ENLINEA%TYPE;
v_vcind_reevalua    BPD_PLANES.IND_REEVALUA%TYPE;
v_nval_beneficio    BPT_BENEFICIARIOS.VAL_BENEFICIO%TYPE;
-----------------------------------------------
v_nnum_ident        GE_CLIENTES.NUM_IDENT%TYPE;
v_nretoroupd        NUMBER(1):=-1;
v_vfrm_fecha        VARCHAR2(40);
v_vfec_desdeapli    VARCHAR2(30);
n_nerror            NUMBER;
v_verror            VARCHAR2(255);
ERROR_PROCESO       EXCEPTION;
--------------------------
    CURSOR cur_asigbenef
    IS
    SELECT  t.num_celular
    ,t.cod_cliente
    ,t.num_abonado
    ,p.cod_plan
    ,p.fec_desdeapli
    ,p.cod_tiplan
    ,p.ind_rec_enlinea
    ,p.ind_reevalua
    ,NVL(p.mto_cargadic, p.cnt_minadic)
    FROM BP_CARGA_MASIVA_TO t, BPD_PLANES p
    WHERE  t.cod_transaccion =p_ncod_transaccion
    AND  p.cod_plan        =t.cod_plan
    AND  p.fec_desdeapli   =t.fec_desdeapli
    AND  p.cod_estado      ='V'
    AND  t.cod_error       =0;
BEGIN
    v_vfrm_fecha := TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL2'));
    v_vfrm_fecha := TRIM(v_vfrm_fecha) || ' ' || TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL7'));
    n_nerror :=-20010;
    
    OPEN cur_asigbenef;
    LOOP
        FETCH cur_asigbenef INTO
        v_nnum_celular
        ,v_ncod_cliente
        ,v_nnum_abonado
        ,v_vcod_plan
        ,v_dfec_desdeapli
        ,v_ncod_tiplan
        ,v_vind_rec_enlinea
        ,v_vcind_reevalua
        ,v_nval_beneficio;
        EXIT WHEN cur_asigbenef%NOTFOUND;
        BEGIN
            n_nerror :=-20040;
            SELECT num_ident 
            INTO   v_nnum_ident
            FROM   GE_CLIENTES
            WHERE  cod_cliente = v_ncod_cliente;
            ------------------------------------
            IF LTRIM(RTRIM(v_vind_rec_enlinea)) ='N' THEN
                v_nretoroupd := BP_PROMOCIONES_PG.BP_ASIGNA_BENEFICIOS_FN(v_ncod_cliente
                                            ,v_nnum_abonado
                                            ,v_nnum_ident
                                            ,v_dfec_desdeapli
                                            ,v_vcind_reevalua
                                            ,v_vcod_plan);
                IF v_nretoroupd =-1 THEN
                    n_nerror := -20030;
                    RAISE ERROR_PROCESO;
                END IF;
            ELSE
                v_vfec_desdeapli := TO_CHAR(v_dfec_desdeapli,v_vfrm_fecha);
                -----------------------------------------------------------
                BP_PROMOCIONES_PG.BP_APLICA_RECARGA_ICC_PR ( v_vcod_plan
                               ,v_vfec_desdeapli
                               ,v_nnum_abonado
                               ,v_nval_beneficio
                               ,v_ncod_tiplan);
            END IF;
        END;
    END LOOP;
    CLOSE cur_asigbenef;
    -------------------
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        IF n_nerror = -20010 THEN
            v_verror  :='No Existe Asignacion de Beneficios Para esta Secuencia: '||TO_CHAR(p_ncod_transaccion);
            ROLLBACK;
            BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',-1,1,'BP_PROMOCIONES_PG.BP_ASIGNA_BENEFICIOS_PR.',
            'transaccion='||p_ncod_transaccion||' BP_CARGA_MASIVA_TO', 'S', n_nerror,v_verror);
            COMMIT;
        ELSIF n_nerror = -20040 THEN
            v_verror  :='No Existe cliente Para Asignacion de Beneficios: '||TO_CHAR(v_ncod_cliente);
            ROLLBACK;
            BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',v_ncod_cliente,1,'BP_PROMOCIONES_PG.BP_ASIGNA_BENEFICIOS_PR.',
            'Cliente='||v_ncod_cliente||' BP_CARGA_MASIVA_TO', 'S', n_nerror,v_verror);
            COMMIT;
        END IF;
        RAISE_APPLICATION_ERROR(n_nerror, v_verror);

    WHEN ERROR_PROCESO THEN
        IF n_nerror = -20030 THEN
            v_verror  :='Error en Asignar Beneficios Retorna: '||TO_CHAR(v_nretoroupd);
        END IF;
    
        ROLLBACK;
        BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',v_ncod_cliente,1,'BP_PROMOCIONES_PG.BP_ASIGNA_BENEFICIOS_FN.',
        'Cliente='||v_ncod_cliente||' BP_CARGA_MASIVA_TO', 'S', n_nerror,v_verror);
        COMMIT;
        RAISE_APPLICATION_ERROR(n_nerror, v_verror);
        WHEN OTHERS THEN
        n_nerror :=SQLCODE;
        v_verror :='Error inesperado, Descripcion:'||SQLERRM;
        ROLLBACK;
        BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',v_ncod_cliente,1,'BP_PROMOCIONES_PG.BP_ASIGNA_BENEFICIOS_PR.',
        'Cliente='||v_ncod_cliente||' BP_CARGA_MASIVA_TO', 'S', n_nerror, SUBSTR(v_verror,1,60));
        COMMIT;
        RAISE_APPLICATION_ERROR(n_nerror, v_verror);
END BP_ASIGNA_BENEFICIOS_PR;
----------------------------
PROCEDURE BP_DEL_TMP_CARGA_MASIVA_PR(p_ncod_transaccion  IN BP_CARGA_MASIVA_TO.COD_TRANSACCION%TYPE)
IS
-- Declaracion de Variables
v_ncount_num    NUMBER(9):=0;
n_nerror        NUMBER;
v_verror        VARCHAR2(255);
--------------------------
BEGIN
    DELETE FROM BP_CARGA_MASIVA_TO
    WHERE cod_transaccion=p_ncod_transaccion;
    ----------------------------------------
    v_ncount_num := SQL%ROWCOUNT;
    IF v_ncount_num = 0 THEN
        NULL;
    ELSE
        COMMIT;        
    END IF;

EXCEPTION
    WHEN OTHERS THEN
    n_nerror :=SQLCODE;
    v_verror :='Error inesperado, Descripcion:'||SQLERRM;
    BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',-1,1,'BP_PROMOCIONES_PG.BP_ASIGNA_BENEFICIOS_PR.',
    'transaccion='||p_ncod_transaccion||' BP_CARGA_MASIVA_TO', 'S', n_nerror, SUBSTR(v_verror,1,60));
    COMMIT;
    RAISE_APPLICATION_ERROR(n_nerror, v_verror);
END BP_DEL_TMP_CARGA_MASIVA_PR;
------------------------------
PROCEDURE BP_MULTIIDIOMA_TOL_DESC_PR(p_vcodcategdcto IN TOL_DESCUENTO_TD.COD_DCTO%TYPE,
                                    p_vdescategdcto IN TOL_DESCUENTO_TD.GLS_DCTO%TYPE,
                                    p_vtipcategdcto IN TOL_DESCUENTO_TD.TIP_DCTO%TYPE)
IS
-- Procedimiento que es llamado desde el Trigger BP_TRG_AFINS_TOLDESCUENTOTD
-- y que ingresa a la ge_multiidioma los registros nuevos en un idioma
-- alternativo.
v_vdescripcion    TOL_DESCUENTO_TD.GLS_DCTO%TYPE;
v_vtipdcto        TOL_DESCUENTO_TD.TIP_DCTO%TYPE;
v_vdescerror      VARCHAR2(250);
v_vidioma         GED_CODIGOS.COD_VALOR%TYPE;

    CURSOR OtrosIdiomas
    IS
    SELECT COD_VALOR
    FROM  GED_CODIGOS
    WHERE COD_MODULO ='GE'
    AND  NOM_TABLA   ='GE_CLIENTES'
    AND  COD_VALOR   <> Ge_Fn_Idioma_Local();
BEGIN
    v_vdescripcion := p_vdescategdcto;
    v_vtipdcto     := p_vtipcategdcto;
    v_vidioma      := Ge_Fn_Idioma_Local();
    --
    INSERT INTO GE_MULTIIDIOMA (
    NOM_TABLA,NOM_CAMPO,COD_PRODUCTO,COD_CONCEPTO,COD_IDIOMA,
    NOM_CAMPO_DES,DES_CONCEPTO,FEC_ULTMOD,NOM_USUARIO)
    VALUES (
    'TOL_DESCUENTO_TD','COD_DCTO',BP_PROMOCIONES_PG.BP_LLENA_NTIP_FN(v_vtipdcto),p_vcodcategdcto,v_vidioma,
    'GLS_DCTO',v_vdescripcion,SYSDATE,USER);
    --
    FOR v_vidioma IN OtrosIdiomas LOOP
        v_vdescripcion:='SIN DESCRIPCIÓN';
        INSERT INTO GE_MULTIIDIOMA (
        NOM_TABLA, NOM_CAMPO, COD_PRODUCTO, COD_CONCEPTO, COD_IDIOMA,
        NOM_CAMPO_DES, DES_CONCEPTO, FEC_ULTMOD, NOM_USUARIO)
        VALUES (
        'TOL_DESCUENTO_TD','COD_DCTO',BP_PROMOCIONES_PG.BP_LLENA_NTIP_FN(v_vtipdcto),p_vcodcategdcto,v_vidioma.COD_VALOR,
        'GLS_DCTO',v_vdescripcion,SYSDATE,USER);
    END LOOP;
    --
    COMMIT;
    --
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        v_vdescerror := 'Registro ya existente en la tabla';
        RAISE_APPLICATION_ERROR(-20002, v_vdescerror);
        WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        v_vdescerror := 'No existe Idioma Local';
        RAISE_APPLICATION_ERROR(-20003, v_vdescerror);
    WHEN OTHERS THEN
        ROLLBACK;
        v_vdescerror := 'Error inesperado en BP_PR_MULTIIDIOMA_TOL_DESCUENTO_TD, Codigo:'||SQLCODE||'  Descripcion:'||SQLERRM;
        RAISE_APPLICATION_ERROR(-20004, v_vdescerror);
END BP_MULTIIDIOMA_TOL_DESC_PR;


PROCEDURE BP_ACTUALIZA_BENEFICIOS_PR (p_nnum_transaccion      IN NUMBER,
                                        p_nnum_abonado          IN GA_ABOAMIST.NUM_ABONADO%TYPE,
                                        p_num_movimiento_alta   IN ICC_MOVIMIENTO.num_movimiento%TYPE,
                                        p_num_movimiento_carga  IN ICC_MOVIMIENTO.num_movimiento%TYPE) 
IS
--Declaraciones
v_ncod_cliente          BPT_BENEFICIARIOS.COD_CLIENTE%TYPE;
v_cod_estado            BPT_BENEFICIARIOS.COD_ESTADO%TYPE;
v_num_movimiento_carga  ICC_MOVIMIENTO.num_movimiento%TYPE;
v_nerror                NUMBER;
v_verror                VARCHAR2(255);
v_ncount_bcios            NUMBER;

BEGIN
    SELECT b.cod_cliente
    INTO   v_ncod_cliente
    FROM   ga_aboamist a, ge_clientes b
    WHERE  a.num_abonado = p_nnum_abonado
    AND  b.cod_cliente = a.cod_cliente;

    IF p_num_movimiento_carga = -1 THEN
        v_num_movimiento_carga := p_num_movimiento_alta;
        v_cod_estado := 'ERR';
    ELSE
        v_cod_estado := 'EJE';
        v_num_movimiento_carga := p_num_movimiento_carga;
    END IF;

    UPDATE BPT_BENEFICIOS
    SET  num_movimiento  = v_num_movimiento_carga
    ,cod_estado      = v_cod_estado
    WHERE num_abonado    = p_nnum_abonado
    AND num_movimiento = p_num_movimiento_alta;
    v_ncount_bcios:= SQL%ROWCOUNT;

    IF v_ncount_bcios = 0 THEN
        v_verror:='no existe abonado para este movimiento';
        v_nerror:=-1;
        BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',v_ncod_cliente,1,'BP_PROMOCIONES_PG.BP_ACTUALIZA_BENEFICIOS_PR.',
        'M_Alta='||p_num_movimiento_alta||',M_Carga='||p_num_movimiento_carga||',Abonado='||p_nnum_abonado,'S',v_nerror,v_verror);

        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (p_nnum_transaccion,4,v_verror);
        ELSE
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (p_nnum_transaccion,0,NULL);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
    v_nerror := -20010;
    v_verror := 'Error, Inesperado Descripcion:'||SQLERRM;
    BP_PROMOCIONES_PG.BP_INSERTA_GA_ERRORES_PR('BP',v_ncod_cliente,1,'BP_PROMOCIONES_PG.BP_ACTUALIZA_BENEFICIOS_PR.',
    'M_Alta='||p_num_movimiento_alta||',M_Carga='||p_num_movimiento_carga||',Abonado='||p_nnum_abonado,'S',v_nerror,v_verror);

    INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
    VALUES (p_nnum_transaccion,4,v_verror);
END BP_ACTUALIZA_BENEFICIOS_PR;

FUNCTION Graba_Error ( NOM_TABLA   IN  VARCHAR2, 
                    NumError    IN  NUMBER,
                    Descripcion IN  VARCHAR2,
                    Usuario     IN  VARCHAR2,
                    EVENTO      OUT NUMBER)  RETURN BOOLEAN 
IS

sNumProceso   VARCHAR2(25);
sTerminal     VARCHAR2(50);

BEGIN

    SELECT NVL(process,'NO PROCESS'), NVL(terminal,'NO TERMINAL')
    INTO   sNumProceso, sTerminal
    FROM   V$SESSION
    WHERE  username = Usuario AND status = 'ACTIVE';
                                       
    EVENTO := GE_ERRORES_PG.GRABAR(0, 'PV', 'Ejecución Procedimiento Recuperar Promociones: BP_RECUPERA_PROMOCIONES_PR', '1', 
    Usuario, sNumProceso, sTerminal, 'PL BP_RECUPERA_PROMOCIONES_PR', NOM_TABLA, NumError, Descripcion);
    RETURN TRUE;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN FALSE;
    WHEN OTHERS THEN              
    RETURN FALSE;                    
END Graba_Error;

PROCEDURE BP_RECUPERA_PROMOCIONES_PR(p_vcod_asignacion IN VARCHAR2,
                                     p_ncod_cliente    IN VARCHAR2,
                                     p_nnum_abonado    IN VARCHAR2,
                                     p_cind_existente  IN CHAR,
                                     p_vcod_tiplan     IN VARCHAR2,
                                     p_vCursor           OUT vCursor,
                                     Error               OUT VARCHAR2) 
IS
Evento      VARCHAR2(1500);
DesError    VARCHAR2(1500);
sQuery      VARCHAR2(1500);
l_vCursor      vCursor;

BEGIN

    sQuery := BP_PROMOCIONES_EXISTENTES_FN(p_vcod_asignacion, p_ncod_cliente,p_nnum_abonado, p_cind_existente, p_vcod_tiplan);

    OPEN  l_vCursor  for sQuery;
    p_vCursor := l_vCursor;
             
    Error := '0';

EXCEPTION
    WHEN OTHERS THEN
        DesError := 'Error, Inesperado Descripcion:'||SQLERRM;
        IF NOT Graba_Error('BP_PROMOCIONES_EXISTENTES_FN', -20010, DesError, user, Evento) THEN
            DesError := DesError||' - No es Posible Grabar el Error DB';
        END IF;
        RAISE_APPLICATION_ERROR(-20098,'EVENTO : ['||Evento||'] Descripcion: '||DesError);    
END BP_RECUPERA_PROMOCIONES_PR;


PROCEDURE bp_asigna_beneficio_pr(   EN_num_abonado   IN NUMBER,
                                    EN_cod_plan      IN VARCHAR2,
                                    SN_cod_retorno   OUT NOCOPY NUMBER,
                                    SV_mens_retorno  OUT NOCOPY VARCHAR2,
                                    SN_num_evento     OUT NOCOPY NUMBER ) 
IS  
error_parametros  EXCEPTION;
error_control     EXCEPTION;
error_ejecucion     EXCEPTION;
error_iSCLDOS     EXCEPTION;
error_iSCLTRES     EXCEPTION;
error_iSCLCUATRO     EXCEPTION;
error_iSCLCINCO     EXCEPTION;
error_iSCLSEIS     EXCEPTION;
error_iSCLSIETE     EXCEPTION;
error_iSCLOCHO     EXCEPTION;
error_iSCLNUEVE     EXCEPTION;               
error_iSCLNOESTA     EXCEPTION; 
error_iSCLNOEXISTE  EXCEPTION;
error_iSCLDIEZ       EXCEPTION;
error_iSCLONCE       EXCEPTION;   
error_Plancliente   EXCEPTION;
error_planCerrado   EXCEPTION;

VTIP_ENTIDAD         BPD_PLANES.TIP_ENTIDAD%TYPE;
VCNT_PERIODOS         BPD_PLANES.CNT_PERIODOS%TYPE;  
VIND_REEVALUA         BPD_PLANES.IND_REEVALUA%TYPE;  
VFEC_DESDEAPLI         BPD_PLANES.FEC_DESDEAPLI%TYPE; 
VCOD_TIPLAN             BPD_PLANES.COD_TIPLAN%TYPE;   
VTIP_BENEFICIO         BPD_PLANES.tip_beneficio%TYPE;
VTIP_PLAN              BPD_PLANES.TIP_PLAN%TYPE;

v_nnum_abonado    GA_ABOCEL.NUM_ABONADO%TYPE;
v_ncod_cliente    GA_ABOCEL.COD_CLIENTE%TYPE;
v_vcod_situacion  GA_ABOCEL.COD_SITUACION%TYPE;
v_vcod_tiplan     TA_PLANTARIF.COD_TIPLAN%TYPE;

GV_sSql        VARCHAR2(50);
GV_des_error   VARCHAR2(200);
CV_cod_modulo  VARCHAR2(50);
GV_version     NUMBER;
v_ncantbene    NUMBER(5):=0; 

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;
    GV_sSql      := '';
    CV_cod_modulo := 'BP';

    BEGIN
        select TIP_ENTIDAD, CNT_PERIODOS, IND_REEVALUA, FEC_DESDEAPLI, COD_TIPLAN, TIP_BENEFICIO, TIP_PLAN
        into VTIP_ENTIDAD, VCNT_PERIODOS, VIND_REEVALUA, VFEC_DESDEAPLI, VCOD_TIPLAN, VTIP_BENEFICIO, VTIP_PLAN 
        from bpd_planes
        where cod_plan = UPPER(EN_cod_plan)
        and COD_ESTADO = 'V';

        IF LTRIM(RTRIM(VTIP_PLAN)) = 'C' THEN 
            RAISE error_planCerrado;
        END IF;
                    
        IF LTRIM(RTRIM(VTIP_ENTIDAD)) <> 'A' THEN 
            RAISE error_Plancliente; 
        END IF;        
            
    EXCEPTION 
        WHEN error_Plancliente  THEN
            RAISE error_iSCLONCE;
        WHEN error_planCerrado  THEN
            RAISE error_iSCLDIEZ;
        WHEN OTHERS  THEN
            RAISE error_iSCLNOESTA;
    END;

    BEGIN
        SELECT A.COD_CLIENTE, A.COD_SITUACION, A.NUM_ABONADO, T.COD_TIPLAN 
        INTO  v_ncod_cliente,v_vcod_situacion,v_nnum_abonado,v_vcod_tiplan 
        FROM GA_ABOCEL A, TA_PLANTARIF T
        WHERE A.NUM_ABONADO = EN_num_abonado
        AND T.cod_producto  = A.cod_producto 
        AND T.cod_plantarif = A.cod_plantarif
        AND A.FEC_ALTA = (SELECT MAX(G.FEC_ALTA) FROM GA_ABOCEL G WHERE G.NUM_ABONADO = EN_num_abonado)         
        AND ROWNUM = 1
        union
        SELECT A.COD_CLIENTE, A.COD_SITUACION, A.NUM_ABONADO, T.COD_TIPLAN
        FROM GA_ABOAMIST A, TA_PLANTARIF T
        WHERE A.NUM_ABONADO =  EN_num_abonado
        AND T.cod_producto  =A.cod_producto 
        AND T.cod_plantarif =A.cod_plantarif 
        AND A.FEC_ALTA = (SELECT MAX(G.FEC_ALTA) FROM GA_ABOAMIST G WHERE G.NUM_ABONADO = EN_num_abonado)
        AND ROWNUM = 1;
    EXCEPTION 
        WHEN OTHERS  THEN
            RAISE error_iSCLNOEXISTE;
    END;        

    IF LTRIM(RTRIM(v_vcod_situacion)) <> 'AAA' THEN 
        RAISE error_iSCLOCHO;
    END IF;    

    IF LTRIM(RTRIM(VCOD_TIPLAN)) = '1' THEN    
        IF LTRIM(RTRIM(VCOD_TIPLAN)) <> LTRIM(RTRIM(v_vcod_tiplan)) THEN 
            IF LTRIM(RTRIM(v_vcod_tiplan)) = '2' THEN
                RAISE  error_iSCLDOS;
            ELSIF LTRIM(RTRIM(v_vcod_tiplan)) = '3' THEN
                RAISE error_iSCLTRES; 
            END IF;                 
        END IF;
    ELSIF LTRIM(RTRIM(VCOD_TIPLAN)) = '2' THEN 
        IF LTRIM(RTRIM(VCOD_TIPLAN)) <> LTRIM(RTRIM(v_vcod_tiplan)) THEN  
            IF LTRIM(RTRIM(v_vcod_tiplan)) = '3' and LTRIM(RTRIM(VTIP_BENEFICIO)) = 'ML' THEN 
                RAISE error_iSCLCINCO;  
            ELSIF LTRIM(RTRIM(v_vcod_tiplan)) = '1' THEN  
                RAISE error_iSCLCUATRO;  
            END IF;
        END IF;
    ELSIF LTRIM(RTRIM(VCOD_TIPLAN)) = '3' THEN 
        IF LTRIM(RTRIM(v_vcod_tiplan)) ='1' THEN
            RAISE error_iSCLSEIS; 
        ELSIF LTRIM(RTRIM(v_vcod_tiplan)) ='2' THEN
            RAISE error_iSCLSIETE;                                   
        END IF;
    END IF;                          


    SELECT COUNT(1)
    INTO   v_ncantbene
    FROM   BPT_BENEFICIARIOS
    WHERE  cod_cliente   = v_ncod_cliente
    AND  num_abonado   = v_nnum_abonado
    AND  cod_plan      = EN_cod_plan
    AND  fec_desdeapli = VFEC_DESDEAPLI;
    
    IF v_ncantbene > 0 THEN
        RAISE  error_iSCLNUEVE;  
    END IF;

    INSERT INTO bpt_beneficiarios
    ( cod_cliente      ,num_abonado           ,cod_plan,
    num_periodos     ,fec_ingreso           ,cod_estado      ,fec_estado,
    nom_usuario      ,fec_proxproc          ,ind_reevalua    ,fec_desdeapli)
    values 
    ( v_ncod_cliente   ,v_nnum_abonado     ,EN_cod_plan,
    0       ,sysdate      ,'N'       ,sysdate,
    user       ,sysdate      ,VIND_REEVALUA   ,VFEC_DESDEAPLI);

    COMMIT;
    SN_cod_retorno := 000;
    SV_mens_retorno := 'Plan de Beneficios asigado al Abonado';

EXCEPTION
    WHEN error_iSCLDOS THEN
        SN_cod_retorno := 902;
        SV_mens_retorno := 'Plan Prepago - Abonado Pospago';
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Plan Prepago - Abonado Pospago- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 902, GV_des_error );
        ROLLBACK;
    WHEN error_iSCLTRES THEN
        SN_cod_retorno := 903;
        SV_mens_retorno := 'Plan Prepago - Abonado Híbrido';
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Plan Prepago - Abonado Híbrido- '; 
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 903, GV_des_error );
        ROLLBACK;
    WHEN error_iSCLCUATRO THEN
        SN_cod_retorno := 904;
        SV_mens_retorno := 'Plan Pospago - Abonado Prepago';
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Plan Pospago - Abonado Prepago- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 904, GV_des_error );
        ROLLBACK;
    WHEN error_iSCLCINCO THEN
        SN_cod_retorno := 905;
        SV_mens_retorno := 'Plan Pospago ML - Abonado Hibrido';
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Plan Pospago ML - Abonado Hibrido- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 905, GV_des_error );
        ROLLBACK;
    WHEN error_iSCLSEIS THEN
        SN_cod_retorno := 906;
        SV_mens_retorno := 'Plan HIbrido - Abonado Prepago';      
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Plan HIbrido - Abonado Prepago- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 906, GV_des_error );
        ROLLBACK;
    WHEN error_iSCLSIETE THEN
        SN_cod_retorno := 907;
        SV_mens_retorno := 'Plan HIbrido - Abonado Pospago';      
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Plan HIbrido - Abonado Pospago- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 907, GV_des_error );
        ROLLBACK;
    WHEN error_iSCLOCHO THEN
        SN_cod_retorno := 908;
        SV_mens_retorno := 'Abonado esta de Baja';      
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Abonado esta de Baja- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 908, GV_des_error );
        ROLLBACK;
    WHEN error_iSCLNUEVE THEN
        SN_cod_retorno := 909;
        SV_mens_retorno := 'Abonado ya tiene el Plan asignado';      
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Abonado ya tiene el Plan asignado- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 909, GV_des_error );
        ROLLBACK;      
    WHEN error_iSCLDIEZ THEN
        SN_cod_retorno := 910;
        SV_mens_retorno := 'Plan es de tipo Cerrado se asignado en forma automatica';
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Plan es de tipo Cerrado se asignado en forma automatica- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 910, GV_des_error );
        ROLLBACK;      
    WHEN error_iSCLONCE THEN
        SN_cod_retorno := 911;
        SV_mens_retorno := 'Plan esta configurado al cliente';      
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); -Plan esta configurado al cliente- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 911, GV_des_error );
        ROLLBACK;            
    WHEN error_iSCLNOESTA THEN
        SN_cod_retorno := 912;
        SV_mens_retorno := 'Plan no esta configurado';
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','|| UPPER(EN_cod_plan) ||'); -Plan no esta configurado- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 912, GV_des_error );
        ROLLBACK;                  
    WHEN error_iSCLNOEXISTE THEN
        SN_cod_retorno := 913;
        SV_mens_retorno := 'No existe abonado en SCL';      
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','|| UPPER(EN_cod_plan) ||'); -No existe abonado en SCL- ';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, 913, GV_des_error );
        ROLLBACK;
    WHEN OTHERS THEN
        SN_cod_retorno := 302;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := 'CV_error_no_clasif';
        END IF;
        GV_des_error    := 'bp_asigna_beneficio_pr('||EN_num_abonado||','||UPPER(EN_cod_plan)||'); - ' || SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'BP_PROMOCIONES_PG.bp_asigna_beneficio_pr', GV_sSql, SQLCODE, GV_des_error );
        ROLLBACK;

END BP_ASIGNA_BENEFICIO_PR;

PROCEDURE BP_VALIDA_CARGA_PUNTUAL_PR(EN_numtransac    IN     GA_TRANSACABO.NUM_TRANSACCION%TYPE,  
                                     p_nnum_celular   IN     GA_ABOCEL.NUM_CELULAR%TYPE,
                                     p_vcod_tiplan    IN     BPD_PLANES.COD_TIPLAN%TYPE,
                                     p_vtip_beneficio IN     BPD_PLANES.TIP_BENEFICIO%TYPE,
                                     p_vcod_plan      IN     BPD_PLANES.COD_PLAN%TYPE,
                                     p_dfec_desdeapli IN     VARCHAR2,
                                     p_ncod_cliente   IN OUT GA_ABOCEL.COD_CLIENTE%TYPE,
                                     p_nnum_abonado   OUT    GA_ABOCEL.NUM_ABONADO%TYPE)
                                
IS                                    
p_nretorno BP_CARGA_MASIVA_TO.COD_ERROR%TYPE;                                    
                               
BEGIN
    p_nretorno:=0;

    BP_VALIDA_CARGA_PR(p_nnum_celular, p_vcod_tiplan, p_vtip_beneficio, p_vcod_plan, 
    to_date(p_dfec_desdeapli, 'DD-MM-YYYY'), p_ncod_cliente, p_nnum_abonado, 
    p_nretorno);
                        
    insert into GA_TRANSACABO (num_transaccion, cod_retorno, des_cadena)
    values (EN_numtransac, p_nretorno, '');                         
END BP_VALIDA_CARGA_PUNTUAL_PR;                                    
END BP_PROMOCIONES_PG;
/
SHOW ERRORS
