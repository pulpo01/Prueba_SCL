CREATE OR REPLACE PACKAGE BODY RA_EXTRAE_AUDITORIA_PG
AS

-- INICIO: Funciones y procedimientos internos.

FUNCTION RA_INSERT_AUDIT_TRIBUTARIA_FN (
        ED_fec_audit            IN ra_auditoria_tributaria_to.fec_audit%TYPE
,       EV_nom_usuario          IN ra_auditoria_tributaria_to.nom_usuario%TYPE
,       EN_tip_audit            IN ra_auditoria_tributaria_to.tip_audit%TYPE
,       EV_valor_ant            IN ra_auditoria_tributaria_to.valor_ant%TYPE
,       EV_valor_nue            IN ra_auditoria_tributaria_to.valor_nue%TYPE
,       EV_proceso_audit        IN ra_auditoria_tributaria_to.proceso_audit%TYPE
,       EN_proc_audit           IN ra_auditoria_tributaria_to.proc_audit%TYPE,
    EN_correlativo       IN ra_auditoria_tributaria_to.correlativo%TYPE
)
RETURN NUMBER
IS
BEGIN

        INSERT INTO ra_auditoria_tributaria_to
                  (
                                id_audit
                        ,       fec_audit
                        ,       nom_usuario
                        ,       tip_audit
                        ,       valor_ant
                        ,       valor_nue
                        ,       proceso_audit
                        ,       proc_audit
                        ,   correlativo
                   )
        VALUES (
                                ra_reporte_auditoria_sq.NEXTVAL
                        ,       ED_fec_audit
                        ,       EV_nom_usuario
                        ,       EN_tip_audit
                        ,       EV_valor_ant
                        ,       EV_valor_nue
                        ,       EV_proceso_audit
                        ,       EN_proc_audit
                        ,   EN_correlativo
                   );

        RETURN 0;

END RA_INSERT_AUDIT_TRIBUTARIA_FN;

FUNCTION RA_CAMPOS_PK_FN (EV_pk IN VARCHAR2,EN_Campo NUMBER) RETURN VARCHAR2
IS
LVresto  varchar2(2000);
LNpos_campo number(6);
LNpos_campo_ant number(6);
LVseparador varchar2(1):=',';
CN_uno PLS_INTEGER :=1;
CN_cero PLS_INTEGER :=0;

BEGIN
         LNpos_campo:=INSTR(EV_pk,LVseparador,CN_uno,EN_Campo);
         IF EN_Campo=CN_uno THEN
                LVresto:=substr(EV_pk,CN_uno,LNpos_campo-CN_uno);
                IF LNpos_campo=CN_cero THEN
                  LVresto:=EV_pk;
                END IF;
         ELSIF LNpos_campo<>CN_cero THEN
                   LNpos_campo_ant:=INSTR(EV_pk,LVseparador,CN_uno,EN_Campo-CN_uno);
                   LVresto:=substr(EV_pk,LNpos_campo_ant+CN_uno,(LNpos_campo-LNpos_campo_ant-CN_uno));
         ELSE
                 LNpos_campo_ant:=INSTR(EV_pk,LVseparador,CN_uno,EN_Campo-CN_uno);
                 IF LNpos_campo_ant<>CN_cero THEN
                        LVresto:=substr(EV_pk,LNpos_campo_ant+CN_uno,length(EV_pk) - LNpos_campo_ant);
                 ELSE
                         LVresto:=null;
                 END IF;
     END IF;

         RETURN LVresto;

END RA_CAMPOS_PK_FN;


FUNCTION RA_CAMPOS_FN (EV_valor_ant IN VARCHAR2,EV_valor_nue IN VARCHAR2,EN_Campo NUMBER,EN_sep VARCHAR2 DEFAULT null) RETURN VARCHAR2
IS
LV_campo_ant VARCHAR2(200);
LV_campo_nue VARCHAR2(200);
LV_retorno   VARCHAR2(200);
LV_separador  VARCHAR2(5);
BEGIN
   LV_separador:=' '||nvl(EN_sep, '->')||' ';
   LV_campo_ant:=ra_campos_pk_fn(EV_valor_ant,En_Campo);
   LV_campo_nue:=ra_campos_pk_fn(EV_valor_nue,En_Campo);

   IF LV_campo_ant is null THEN
          LV_retorno:= LV_campo_nue;
   ELSIF  LV_campo_ant=LV_campo_nue THEN
          LV_retorno:= LV_campo_ant;
   ELSIF LV_campo_nue is null THEN
      LV_retorno:= LV_campo_ant;
   ELSE
     LV_retorno:= LV_campo_ant||LV_separador||LV_campo_nue;
   END IF;

   RETURN       LV_retorno ;

END RA_CAMPOS_FN;

FUNCTION RA_FORMATO_FECHA RETURN VARCHAR2
IS
  LV_FormatoFecha VARCHAR2(45);
BEGIN
         SELECT a.val_parametro||' '||b.val_parametro
         INTO  LV_FormatoFecha
         FROM ged_parametros a,  ged_parametros b
         WHERE a.nom_parametro='FORMATO_SEL2'
         AND a.cod_modulo='GE'
         AND a.cod_producto=1
         AND b.nom_parametro='FORMATO_SEL7'
         AND b.cod_modulo='GE'
         AND b.cod_producto=1  ;

     RETURN LV_FormatoFecha;
        EXCEPTION
        WHEN OTHERS THEN
           RETURN null;
END;


FUNCTION RA_DATOS_DE_CO_INTERESES_FN (
        LV_pk           IN VARCHAR2
)
RETURN VARCHAR
IS
LV_detalle      aud_registro_auditoria_to.detalle%type;
LV_FormatoFecha VARCHAR2(45);
BEGIN
    LV_FormatoFecha:=ra_formato_fecha;
        BEGIN
                SELECT                          cod_tasa
                        || ',' ||   num_secuencia
                        || ',' ||   TO_CHAR(factor_int)
                                || ',' ||       TO_CHAR(factor_dia)
                                || ',' ||   ind_fec_cobro
                                || ',' ||       TO_CHAR(dias_aplicacion)
                                || ',' ||       TO_CHAR(fec_vigencia_dd_dh,LV_FormatoFecha)
                                || ',' ||       TO_CHAR(fec_vigencia_hh_dh,LV_FormatoFecha)
                                || ',' ||       TO_CHAR(fec_creacion_dh,LV_FormatoFecha)
                                || ',' ||       nom_usuario
                INTO    LV_detalle
                FROM    co_intereses
                WHERE   cod_tasa                = RA_CAMPOS_PK_FN(LV_pk,1)
                AND             num_secuencia   = RA_CAMPOS_PK_FN(LV_pk,2) ;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        LV_detalle := NULL;
        END;

        RETURN LV_detalle;

END RA_DATOS_DE_CO_INTERESES_FN;

FUNCTION RA_DATOS_DE_GE_IMPUESTOS_FN (
        LV_pk           IN VARCHAR2
)
RETURN VARCHAR
IS
LV_detalle      aud_registro_auditoria_to.detalle%type;
LN_cod_catimpos ge_impuestos.cod_catimpos%type;
LN_cod_zonaimpo ge_impuestos.cod_zonaimpo%type;
LN_cod_zonaabon ge_impuestos.cod_zonaabon%type;
LN_cod_tipimpues ge_impuestos.cod_tipimpues%type;
LN_cod_grpservi ge_impuestos.cod_grpservi%type;
--LN_fec_desde ge_impuestos.fec_desde%type;
LN_fec_desde varchar2(30);
LV_FormatoFecha VARCHAR2(45);

BEGIN
     LV_FormatoFecha:=RA_FORMATO_FECHA;
         LN_cod_catimpos := RA_CAMPOS_PK_FN(LV_pk,1);
         LN_cod_zonaimpo := RA_CAMPOS_PK_FN(LV_pk,2);
         LN_cod_zonaabon :=  RA_CAMPOS_PK_FN(LV_pk,3);
         LN_cod_tipimpues := RA_CAMPOS_PK_FN(LV_pk,4);
         LN_cod_grpservi:=  RA_CAMPOS_PK_FN(LV_pk,5);
         LN_fec_desde :=  RA_CAMPOS_PK_FN(LV_pk,6);

        BEGIN

                SELECT  cod_catimpos|| ',' ||cod_zonaimpo|| ',' || cod_zonaabon|| ',' ||
                        cod_tipimpues || ',' ||cod_grpservi|| ',' ||
                                to_char(fec_desde,LV_FormatoFecha)|| ',' ||
                                cod_concgene||','||
                                to_char(fec_hasta,LV_FormatoFecha)|| ',' ||prc_impuesto
                INTO    LV_detalle
                FROM    ge_impuestos
                WHERE   cod_catimpos=LN_cod_catimpos
                AND             cod_zonaabon=LN_cod_zonaabon
                AND             cod_zonaimpo=LN_cod_zonaimpo
                AND             cod_tipimpues=LN_cod_tipimpues
                AND             cod_grpservi=LN_cod_grpservi
                AND             fec_desde=TO_DATE(LN_fec_desde,LV_FormatoFecha);
      RETURN LV_detalle;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RETURN NULL;
        END;

END RA_DATOS_DE_GE_IMPUESTOS_FN;


FUNCTION RA_DATOS_DE_CO_CATEGORIAS_FN (
        LV_pk           IN VARCHAR2
)
RETURN VARCHAR
IS
LV_detalle      aud_registro_auditoria_to.detalle%type;
LV_cod_categoria VARCHAR2(5);

BEGIN
         LV_cod_categoria:= RA_CAMPOS_PK_FN(LV_pk,1);
        BEGIN

                SELECT  cod_categoria||','||des_categoria||','||cod_tasa||','||nro_dgracia
                INTO    LV_detalle
                FROM    co_categorias_td
                WHERE   cod_categoria=LV_cod_categoria;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        LV_detalle := null;
        END;

        RETURN LV_detalle;

END RA_DATOS_DE_CO_CATEGORIAS_FN;



-- FIN : Funciones y procedimientos internos.



-- INICIO : Funciones y procedimientos externos.

PROCEDURE RA_EXTRAE_CO_INTERESES_PR IS

-- Cusor para obtención de los registros de auditoría de una tabla auditada ordenado por pk Y ROWID.
--      Explicación: orden PK para analizar la historia de un registro y rowid para asegurar el fiel orden en la secuencia de los sucesos.

CURSOR  c_records_aud IS
SELECT  a.correlativo
,               a.owner
,               a.tabla
,               a.hora
,               a.pk
,               a.operacion
,               a.detalle
,               a.usuario_ora
                --  USUARIO_SO
                --  MAQUINA
                --  TERMINAL
                --  PROGRAMA
                --  MODULO
FROM    aud_registro_auditoria_to a
WHERE   a.owner = 'SISCEL'
AND             a.tabla = 'CO_INTERESES'
AND  not exists (SELECT 1 FROM ra_auditoria_tributaria_to b WHERE a.correlativo=b.correlativo)
ORDER   BY pk, correlativo;

LD_hora            aud_registro_auditoria_to.hora%type;
LV_pk              aud_registro_auditoria_to.pk%type;
LV_operacion   aud_registro_auditoria_to.operacion%type;
LV_detalle         aud_registro_auditoria_to.detalle%type;
LV_usuario_ora aud_registro_auditoria_to.usuario_ora%type;
LV_valor_ant   aud_registro_auditoria_to.detalle%type;
LV_valor_nue   aud_registro_auditoria_to.detalle%type;
LV_correlativo_old aud_registro_auditoria_to.correlativo%type;
LV_correlativo_new aud_registro_auditoria_to.correlativo%type;

TYPE rec IS RECORD (
                                                correlativo aud_registro_auditoria_to.correlativo%type
                                        ,       owner           aud_registro_auditoria_to.owner%type
                                        ,       tabla           aud_registro_auditoria_to.tabla%type
                                        ,       hora            aud_registro_auditoria_to.hora%type
                                        ,       pk                      aud_registro_auditoria_to.pk%type
                                        ,       operacion       aud_registro_auditoria_to.operacion%type
                                        ,       detalle         aud_registro_auditoria_to.detalle%type
                                        ,       usuario_ora aud_registro_auditoria_to.usuario_ora%type
                                        );

 reg rec;

 LD_hora_old                    aud_registro_auditoria_to.hora%type;
 LV_pk_old                      aud_registro_auditoria_to.pk%type;
 LV_operacion_old       aud_registro_auditoria_to.operacion%type;
 LV_detalle_old         aud_registro_auditoria_to.detalle%type;
 LV_usuario_ora_old     aud_registro_auditoria_to.usuario_ora%type;

 LD_hora_new                    aud_registro_auditoria_to.hora%type;
 LV_pk_new                      aud_registro_auditoria_to.pk%type;
 LV_operacion_new       aud_registro_auditoria_to.operacion%type;
 LV_detalle_new         aud_registro_auditoria_to.detalle%type;
 LV_usuario_ora_new     aud_registro_auditoria_to.usuario_ora%type;
 LV_detalle_aux         aud_registro_auditoria_to.detalle%type;



 --Constantes de auditoría del modelo mas_auditorias
 LC_insert                              CONSTANT  VARCHAR2(10) := 'INSERT';
 LC_update                              CONSTANT  VARCHAR2(10) := 'UPDATE';
 LC_delete                              CONSTANT  VARCHAR2(10) := 'DELETE';


  --Constantes de auditoría tributaría (mas_reportes)
 LC_ingresar                            CONSTANT  NUMBER := 0;
 LC_eliminar                            CONSTANT  NUMBER := 1;
 LC_modificar                   CONSTANT  NUMBER := 2;

 -- Constantes de auditoría tributaría (mas_reportes)
 LC_proceso_intereses   CONSTANT  NUMBER := 0;

 LN_tipo_auditoria              ra_auditoria_tributaria_to.tip_audit%TYPE;

 LV_columnas_tabla              VARCHAR2(1000) := 'COD_TASA,NUM_SECUENCIA,FACTOR_INT,FACTOR_DIA,IND_FEC_COBRO,DIAS_APLICACION,FEC_VIGENCIA_DD_DH,FEC_VIGENCIA_HH_DH,FEC_CREACION_DH,NOM_USUARIO' ;

 LV_ret                                 NUMBER;
 LB_tiene_auditoria             BOOLEAN := TRUE;


 BEGIN

        OPEN c_records_aud;

        FETCH c_records_aud INTO reg;

        IF c_records_aud%NOTFOUND THEN
                LB_tiene_auditoria := FALSE;
        END IF;

        LD_hora_old                     := reg.hora;
        LV_pk_old                       := reg.pk;
        LV_operacion_old        := reg.operacion;
        LV_detalle_old          := reg.detalle;
        LV_usuario_ora_old      := reg.usuario_ora;
        LV_correlativo_old  :=reg.correlativo;


        LOOP

                FETCH c_records_aud INTO reg;

                EXIT WHEN c_records_aud%NOTFOUND;

                LD_hora_new                     := reg.hora;
                LV_pk_new                       := reg.pk;
                LV_operacion_new        := reg.operacion;
                LV_detalle_new          := reg.detalle;
                LV_usuario_ora_new      := reg.usuario_ora;
                LV_correlativo_new  :=reg.correlativo;

                -- LN_tipo_auditoria: variable de equivalencia entre el tipo de auditoría tributaria y el tipo de operación DML de Mas_auditoriA.

                IF LV_operacion_old = LC_insert THEN
                        LN_tipo_auditoria := LC_ingresar;
                ELSIF LV_operacion_old = LC_delete THEN
                        LN_tipo_auditoria := LC_eliminar;
                ELSIF LV_operacion_old = LC_update THEN
                        LN_tipo_auditoria := LC_modificar;
                END IF;



                 --Cuando la pk cambia (LV_pk_old <> LV_pk_new), es porque viene otra secuencia.
                 --Y Sólo en la operación update los datos nuevos serán obtenidos desde la tabla auditada.

                IF LV_pk_old <> LV_pk_new THEN
                        LV_detalle_new := NULL;
                END IF;

                IF  LV_pk_old <> LV_pk_new AND LV_operacion_old = LC_update THEN
                        LV_detalle_new := RA_DATOS_DE_CO_INTERESES_FN ( LV_pk_old );
                END IF;

                IF LV_operacion_old = LC_insert THEN
                   LV_detalle_aux:=null;
                   LV_detalle_new := LV_detalle_old;
                 ELSE
                  LV_detalle_aux:= LV_detalle_old;
                END IF;

                LV_ret := RA_INSERT_AUDIT_TRIBUTARIA_FN (
                                        LD_hora_old
                                ,       LV_usuario_ora_old
                                ,       LN_tipo_auditoria
                                ,       LV_detalle_aux
                                ,       LV_detalle_new
                                ,       LV_columnas_tabla
                                ,       LC_proceso_intereses
                                ,   LV_correlativo_old
                           );


                LD_hora_old                     := reg.hora;
                LV_pk_old                       := reg.pk;
                LV_operacion_old        := reg.operacion;
                LV_detalle_old          := reg.detalle;
                LV_usuario_ora_old      := reg.usuario_ora;
                LV_correlativo_old  := reg.correlativo;


        END LOOP;


        -- Cargando último registro de auditoría.

        IF LB_tiene_auditoria THEN

                LV_detalle_new := NULL;

                IF  LV_operacion_old = LC_update THEN
                        LV_detalle_new := RA_DATOS_DE_CO_INTERESES_FN (LV_pk_old);
                END IF;

                -- LN_tipo_auditoria: variable de equivalencia entre el tipo de auditoría tributaria y el tipo de operación DML de Mas_auditoriA.

                IF LV_operacion_old = LC_insert THEN
                        LN_tipo_auditoria := LC_ingresar;
                ELSIF LV_operacion_old = LC_delete THEN
                        LN_tipo_auditoria := LC_eliminar;
                ELSIF LV_operacion_old = LC_update THEN
                        LN_tipo_auditoria := LC_modificar;
                END IF;

                IF LV_operacion_old = LC_insert THEN
                   LV_detalle_aux:=null;
                   LV_detalle_new:=LV_detalle_old;
                 ELSE
                  LV_detalle_aux:= LV_detalle_old;
                END IF;

                LV_ret := RA_INSERT_AUDIT_TRIBUTARIA_FN (
                                                LD_hora_old
                                        ,       LV_usuario_ora_old
                                        ,       LN_tipo_auditoria
                                        ,       LV_detalle_aux
                                        ,       LV_detalle_new
                                        ,       LV_columnas_tabla
                                        ,       LC_proceso_intereses
                                        ,   LV_correlativo_old
                                   );

        END IF;
END RA_EXTRAE_CO_INTERESES_PR ;

PROCEDURE RA_EXTRAE_CO_CATEGORIAS_PR IS

-- Cusor para obtención de los registros de auditoría de una tabla auditada ordenado por pk Y ROWID.
--      Explicación: orden PK para analizar la historia de un registro y rowid para asegurar el fiel orden en la secuencia de los sucesos.

CURSOR  c_records_aud IS
SELECT  a.correlativo
,               a.owner
,               a.tabla
,               a.hora
,               a.pk
,               a.operacion
,               a.detalle
,               a.usuario_ora
                --  USUARIO_SO
                --  MAQUINA
                --  TERMINAL
                --  PROGRAMA
                --  MODULO
FROM    aud_registro_auditoria_to a
WHERE   a.owner = 'SISCEL'
AND             a.tabla = 'CO_CATEGORIAS_TD'
AND  not exists (SELECT 1 FROM ra_auditoria_tributaria_to b WHERE a.correlativo=b.correlativo)
ORDER   BY pk, correlativo;

LD_hora            aud_registro_auditoria_to.hora%type;
LV_pk              aud_registro_auditoria_to.pk%type;
LV_operacion   aud_registro_auditoria_to.operacion%type;
LV_detalle         aud_registro_auditoria_to.detalle%type;
LV_usuario_ora aud_registro_auditoria_to.usuario_ora%type;
LV_valor_ant   aud_registro_auditoria_to.detalle%type;
LV_valor_nue   aud_registro_auditoria_to.detalle%type;
LV_correlativo_old aud_registro_auditoria_to.correlativo%type;
LV_correlativo_new aud_registro_auditoria_to.correlativo%type;

TYPE rec IS RECORD (
                                                correlativo aud_registro_auditoria_to.correlativo%type
                                        ,       owner           aud_registro_auditoria_to.owner%type
                                        ,       tabla           aud_registro_auditoria_to.tabla%type
                                        ,       hora            aud_registro_auditoria_to.hora%type
                                        ,       pk                      aud_registro_auditoria_to.pk%type
                                        ,       operacion       aud_registro_auditoria_to.operacion%type
                                        ,       detalle         aud_registro_auditoria_to.detalle%type
                                        ,       usuario_ora aud_registro_auditoria_to.usuario_ora%type
                                        );

 reg rec;

 LD_hora_old                    aud_registro_auditoria_to.hora%type;
 LV_pk_old                      aud_registro_auditoria_to.pk%type;
 LV_operacion_old       aud_registro_auditoria_to.operacion%type;
 LV_detalle_old         aud_registro_auditoria_to.detalle%type;
 LV_usuario_ora_old     aud_registro_auditoria_to.usuario_ora%type;

 LD_hora_new                    aud_registro_auditoria_to.hora%type;
 LV_pk_new                      aud_registro_auditoria_to.pk%type;
 LV_operacion_new       aud_registro_auditoria_to.operacion%type;
 LV_detalle_new         aud_registro_auditoria_to.detalle%type;
 LV_usuario_ora_new     aud_registro_auditoria_to.usuario_ora%type;
 LV_detalle_aux         aud_registro_auditoria_to.detalle%type;



 --Constantes de auditoría del modelo mas_auditorias
 LC_insert                              CONSTANT  VARCHAR2(10) := 'INSERT';
 LC_update                              CONSTANT  VARCHAR2(10) := 'UPDATE';
 LC_delete                              CONSTANT  VARCHAR2(10) := 'DELETE';


  --Constantes de auditoría tributaría (mas_reportes)
 LC_ingresar                            CONSTANT  NUMBER := 0;
 LC_eliminar                            CONSTANT  NUMBER := 1;
 LC_modificar                   CONSTANT  NUMBER := 2;

 -- Constantes de auditoría tributaría (mas_reportes)
 LC_proceso_categorias  CONSTANT  NUMBER := 11;

 LN_tipo_auditoria              ra_auditoria_tributaria_to.tip_audit%TYPE;

 LV_columnas_tabla              VARCHAR2(1000) := 'COD_TASA,NUM_SECUENCIA,FACTOR_INT,FACTOR_DIA,IND_FEC_COBRO,DIAS_APLICACION,FEC_VIGENCIA_DD_DH,FEC_VIGENCIA_HH_DH,FEC_CREACION_DH,NOM_USUARIO' ;

 LV_ret                                 NUMBER;
 LB_tiene_auditoria             BOOLEAN := TRUE;


 BEGIN

        OPEN c_records_aud;

        FETCH c_records_aud INTO reg;

        IF c_records_aud%NOTFOUND THEN
                LB_tiene_auditoria := FALSE;
        END IF;

        LD_hora_old                     := reg.hora;
        LV_pk_old                       := reg.pk;
        LV_operacion_old        := reg.operacion;
        LV_detalle_old          := reg.detalle;
        LV_usuario_ora_old      := reg.usuario_ora;
        LV_correlativo_old  :=reg.correlativo;


        LOOP

                FETCH c_records_aud INTO reg;

                EXIT WHEN c_records_aud%NOTFOUND;

                LD_hora_new                     := reg.hora;
                LV_pk_new                       := reg.pk;
                LV_operacion_new        := reg.operacion;
                LV_detalle_new          := reg.detalle;
                LV_usuario_ora_new      := reg.usuario_ora;
                LV_correlativo_new  :=reg.correlativo;

                -- LN_tipo_auditoria: variable de equivalencia entre el tipo de auditoría tributaria y el tipo de operación DML de Mas_auditoriA.

                IF LV_operacion_old = LC_insert THEN
                        LN_tipo_auditoria := LC_ingresar;
                ELSIF LV_operacion_old = LC_delete THEN
                        LN_tipo_auditoria := LC_eliminar;
                ELSIF LV_operacion_old = LC_update THEN
                        LN_tipo_auditoria := LC_modificar;
                END IF;



                 --Cuando la pk cambia (LV_pk_old <> LV_pk_new), es porque viene otra secuencia.
                 --Y Sólo en la operación update los datos nuevos serán obtenidos desde la tabla auditada.

                IF LV_pk_old <> LV_pk_new THEN
                        LV_detalle_new := NULL;
                END IF;

                IF  LV_pk_old <> LV_pk_new AND LV_operacion_old = LC_update THEN
                        LV_detalle_new := RA_DATOS_DE_CO_CATEGORIAS_FN ( LV_pk_old );
                END IF;

                IF LV_operacion_old = LC_insert THEN
                   LV_detalle_aux:=null;
                   LV_detalle_new := LV_detalle_old;
                 ELSE
                  LV_detalle_aux:= LV_detalle_old;
                END IF;

                LV_ret := RA_INSERT_AUDIT_TRIBUTARIA_FN (
                                        LD_hora_old
                                ,       LV_usuario_ora_old
                                ,       LN_tipo_auditoria
                                ,       LV_detalle_aux
                                ,       LV_detalle_new
                                ,       LV_columnas_tabla
                                ,       LC_proceso_categorias
                                ,   LV_correlativo_old
                           );


                LD_hora_old                     := reg.hora;
                LV_pk_old                       := reg.pk;
                LV_operacion_old        := reg.operacion;
                LV_detalle_old          := reg.detalle;
                LV_usuario_ora_old      := reg.usuario_ora;
                LV_correlativo_old  := reg.correlativo;


        END LOOP;


        -- Cargando último registro de auditoría.

        IF LB_tiene_auditoria THEN

                LV_detalle_new := NULL;

                IF  LV_operacion_old = LC_update THEN
                        LV_detalle_new := RA_DATOS_DE_CO_CATEGORIAS_FN (LV_pk_old);
                END IF;

                -- LN_tipo_auditoria: variable de equivalencia entre el tipo de auditoría tributaria y el tipo de operación DML de Mas_auditoriA.

                IF LV_operacion_old = LC_insert THEN
                        LN_tipo_auditoria := LC_ingresar;
                ELSIF LV_operacion_old = LC_delete THEN
                        LN_tipo_auditoria := LC_eliminar;
                ELSIF LV_operacion_old = LC_update THEN
                        LN_tipo_auditoria := LC_modificar;
                END IF;

                IF LV_operacion_old = LC_insert THEN
                   LV_detalle_aux:=null;
                   LV_detalle_new:=LV_detalle_old;
                 ELSE
                  LV_detalle_aux:= LV_detalle_old;
                END IF;

                LV_ret := RA_INSERT_AUDIT_TRIBUTARIA_FN (
                                                LD_hora_old
                                        ,       LV_usuario_ora_old
                                        ,       LN_tipo_auditoria
                                        ,       LV_detalle_aux
                                        ,       LV_detalle_new
                                        ,       LV_columnas_tabla
                                        ,       LC_proceso_categorias
                                        ,   LV_correlativo_old
                                   );

        END IF;
END RA_EXTRAE_CO_CATEGORIAS_PR ;

PROCEDURE RA_EXTRAE_GE_IMPUESTOS_PR IS

-- Cusor para obtención de los registros de auditoría de una tabla auditada ordenado por pk Y ROWID.
--      Explicación: orden PK para analizar la historia de un registro y rowid para asegurar el fiel orden en la secuencia de los sucesos.

CURSOR  c_records_aud IS
SELECT  a.correlativo
,               a.owner
,               a.tabla
,               a.hora
,               a.pk
,               a.operacion
,               a.detalle
,               a.usuario_ora
                --  USUARIO_SO
                --  MAQUINA
                --  TERMINAL
                --  PROGRAMA
                --  MODULO
FROM    aud_registro_auditoria_to a
WHERE   a.owner = 'SISCEL'
AND             a.tabla = 'GE_IMPUESTOS'
AND  not exists (SELECT 1 FROM ra_auditoria_tributaria_to b WHERE a.correlativo=b.correlativo)
ORDER   BY pk, correlativo;

LD_hora            aud_registro_auditoria_to.hora%type;
LV_pk              aud_registro_auditoria_to.pk%type;
LV_operacion   aud_registro_auditoria_to.operacion%type;
LV_detalle         aud_registro_auditoria_to.detalle%type;
LV_usuario_ora aud_registro_auditoria_to.usuario_ora%type;
LV_valor_ant   aud_registro_auditoria_to.detalle%type;
LV_valor_nue   aud_registro_auditoria_to.detalle%type;
LV_correlativo_old aud_registro_auditoria_to.correlativo%type;
LV_correlativo_new aud_registro_auditoria_to.correlativo%type;


TYPE rec IS RECORD (
                                                correlativo aud_registro_auditoria_to.correlativo%type
                                        ,       owner           aud_registro_auditoria_to.owner%type
                                        ,       tabla           aud_registro_auditoria_to.tabla%type
                                        ,       hora            aud_registro_auditoria_to.hora%type
                                        ,       pk                      aud_registro_auditoria_to.pk%type
                                        ,       operacion       aud_registro_auditoria_to.operacion%type
                                        ,       detalle         aud_registro_auditoria_to.detalle%type
                                        ,       usuario_ora aud_registro_auditoria_to.usuario_ora%type
                                        );

 reg rec;

 LD_hora_old                    aud_registro_auditoria_to.hora%type;
 LV_pk_old                      aud_registro_auditoria_to.pk%type;
 LV_operacion_old       aud_registro_auditoria_to.operacion%type;
 LV_detalle_old         aud_registro_auditoria_to.detalle%type;
 LV_usuario_ora_old     aud_registro_auditoria_to.usuario_ora%type;

 LD_hora_new                    aud_registro_auditoria_to.hora%type;
 LV_pk_new                      aud_registro_auditoria_to.pk%type;
 LV_operacion_new       aud_registro_auditoria_to.operacion%type;
 LV_detalle_new         aud_registro_auditoria_to.detalle%type;
 LV_usuario_ora_new     aud_registro_auditoria_to.usuario_ora%type;
 LV_detalle_aux         aud_registro_auditoria_to.detalle%type;



 --Constantes de auditoría del modelo mas_auditorias
 LC_insert                              CONSTANT  VARCHAR2(10) := 'INSERT';
 LC_update                              CONSTANT  VARCHAR2(10) := 'UPDATE';
 LC_delete                              CONSTANT  VARCHAR2(10) := 'DELETE';


  --Constantes de auditoría tributaría (mas_reportes)
 LC_ingresar                            CONSTANT  NUMBER := 0;
 LC_eliminar                            CONSTANT  NUMBER := 1;
 LC_modificar                   CONSTANT  NUMBER := 2;

 LC_proceso_impuestos   CONSTANT  NUMBER := 1;


 LN_tipo_auditoria              ra_auditoria_tributaria_to.tip_audit%TYPE;

 LV_columnas_tabla              VARCHAR2(1000) := 'COD_CATIMPOS, COD_ZONAIMPO, COD_ZONAABON, COD_TIPIMPUES, COD_GRPSERVI, FEC_DESDE, COD_CONCGENE, FEC_HASTA, PRC_IMPUESTO' ;

 LV_ret                                 NUMBER;



 LB_tiene_auditoria             BOOLEAN := TRUE;


 BEGIN

        OPEN c_records_aud;

        FETCH c_records_aud INTO reg;

        IF c_records_aud%NOTFOUND THEN
                LB_tiene_auditoria := FALSE;
        END IF;

        LD_hora_old                     := reg.hora;
        LV_pk_old                       := reg.pk;
        LV_operacion_old        := reg.operacion;
        LV_detalle_old          := reg.detalle;
        LV_usuario_ora_old      := reg.usuario_ora;
        LV_correlativo_old  :=reg.correlativo;


        LOOP

                FETCH c_records_aud INTO reg;

                EXIT WHEN c_records_aud%NOTFOUND;

                LD_hora_new                     := reg.hora;
                LV_pk_new                       := reg.pk;
                LV_operacion_new        := reg.operacion;
                LV_detalle_new          := reg.detalle;
                LV_usuario_ora_new      := reg.usuario_ora;
                LV_correlativo_new  :=reg.correlativo;

                -- LN_tipo_auditoria: variable de equivalencia entre el tipo de auditoría tributaria y el tipo de operación DML de Mas_auditoriA.

                IF LV_operacion_old = LC_insert THEN
                        LN_tipo_auditoria := LC_ingresar;
                ELSIF LV_operacion_old = LC_delete THEN
                        LN_tipo_auditoria := LC_eliminar;
                ELSIF LV_operacion_old = LC_update THEN
                        LN_tipo_auditoria := LC_modificar;
                END IF;



                 --Cuando la pk cambia (LV_pk_old <> LV_pk_new), es porque viene otra secuencia.
                 --Y Sólo en la operación update los datos nuevos serán obtenidos desde la tabla auditada.

                IF LV_pk_old <> LV_pk_new THEN
                        LV_detalle_new := NULL;
                END IF;

                IF  LV_pk_old <> LV_pk_new AND LV_operacion_old = LC_update THEN
                        LV_detalle_new := RA_DATOS_DE_GE_IMPUESTOS_FN ( LV_pk_old );
                END IF;

                IF LV_operacion_old = LC_insert THEN
                   LV_detalle_aux:=null;
                   LV_detalle_new := LV_detalle_old;
                 ELSE
                  LV_detalle_aux:= LV_detalle_old;
                END IF;

                LV_ret := RA_INSERT_AUDIT_TRIBUTARIA_FN (
                                        LD_hora_old
                                ,       LV_usuario_ora_old
                                ,       LN_tipo_auditoria
                                ,       LV_detalle_aux
                                ,       LV_detalle_new
                                ,       LV_columnas_tabla
                                ,       LC_proceso_impuestos
                                ,   LV_correlativo_old
                           );


                LD_hora_old                     := reg.hora;
                LV_pk_old                       := reg.pk;
                LV_operacion_old        := reg.operacion;
                LV_detalle_old          := reg.detalle;
                LV_usuario_ora_old      := reg.usuario_ora;
                LV_correlativo_old  := reg.correlativo;


        END LOOP;


        -- Cargando último registro de auditoría.

        IF LB_tiene_auditoria THEN

                LV_detalle_new := NULL;

                IF  LV_operacion_old = LC_update THEN
                        LV_detalle_new := RA_DATOS_DE_GE_IMPUESTOS_FN (LV_pk_old);
                END IF;

                -- LN_tipo_auditoria: variable de equivalencia entre el tipo de auditoría tributaria y el tipo de operación DML de Mas_auditoriA.

                IF LV_operacion_old = LC_insert THEN
                        LN_tipo_auditoria := LC_ingresar;
                ELSIF LV_operacion_old = LC_delete THEN
                        LN_tipo_auditoria := LC_eliminar;
                ELSIF LV_operacion_old = LC_update THEN
                        LN_tipo_auditoria := LC_modificar;
                END IF;

                IF LV_operacion_old = LC_insert THEN
                   LV_detalle_aux:=null;
                   LV_detalle_new:=LV_detalle_old;
                 ELSE
                  LV_detalle_aux:= LV_detalle_old;
                END IF;

                LV_ret := RA_INSERT_AUDIT_TRIBUTARIA_FN (
                                                LD_hora_old
                                        ,       LV_usuario_ora_old
                                        ,       LN_tipo_auditoria
                                        ,       LV_detalle_aux
                                        ,       LV_detalle_new
                                        ,       LV_columnas_tabla
                                        ,       LC_proceso_impuestos
                                        ,   LV_correlativo_old
                                   );

        END IF;
END RA_EXTRAE_GE_IMPUESTOS_PR ;






PROCEDURE RA_EXTRAE_AUDITORIA_PR
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  RA_EXTRAE_CO_INTERESES_PR;
  RA_EXTRAE_CO_CATEGORIAS_PR;
  RA_EXTRAE_GE_IMPUESTOS_PR;
  COMMIT;
  GE_SCHEDULER_PG.GE_CIERRECOLASCH_PR( 500, 'LYP', 'LYP' );
  EXCEPTION
     WHEN OTHERS THEN
             GE_SCHEDULER_PG.GE_CIERRECOLASCH_PR( 500, 'LYP', 'LYP' );
                  ROLLBACK;
END;

-- FIN : Funciones y procedimientos externos.


END RA_EXTRAE_AUDITORIA_PG;
/
SHOW ERRORS