CREATE OR REPLACE PACKAGE BODY VE_PROCESO_SERVICIO_PG
AS
CV_error_no_clasif CONSTANT VARCHAR2(20) := 'Error no clasificado';

PROCEDURE ve_bajaabonados_pr (EV_actabo         IN icc_movimiento.cod_actabo%TYPE,
                              EN_producto       IN NUMBER,
                              EN_num_abonado    IN icc_movimiento.num_abonado%TYPE,
                              EV_perfil         IN ga_abocel.perfil_abonado%TYPE,
                              EN_rent           IN NUMBER,
                              ED_fecsys         IN DATE,
                              EN_indsusp        IN NUMBER,
                              EV_modulo         IN icc_movimiento.cod_modulo%TYPE,
                              EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                              EV_cod_servicios  IN icc_movimiento.cod_servicios%TYPE,
                              EV_cod_actuacion  IN icc_movimiento.cod_actuacion%TYPE,
                              EV_num_serie      IN icc_movimiento.num_serie_nue%TYPE,
                              EV_num_serie_old  IN icc_movimiento.num_serie%TYPE,
                              EV_nom_usuarora   IN icc_movimiento.nom_usuarora%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_BAJAABONADOS_PR"
          Lenguaje="PL/SQL"
          Fecha="11/11/2005"
          Versión="1.0.0"
          Diseñador="Vladimir Maureira"
          Programador="vladimir maureira"
          Ambiente="DEIMOS_ANDINA">
 <Retorno>NA</Retorno>
 <Descripción></Descripción>
 <Parámetros>
   <Entrada>
    <param nom="EV_actabo     " Tipo="VARCHAR2"></param>
    <param nom="EN_producto   " Tipo="NUMBER"></param>
    <param nom="EN_num_abonado" Tipo="NUMBER"></param>
    <param nom="EV_perfil     " Tipo="VARCHAR2"></param>
    <param nom="EN_rent       " Tipo="NUMBER"></param>
    <param nom="ED_fecsys     " Tipo="DATE"></param>
    <param nom="EN_indsusp    " Tipo="NUMBER"></param>
    <param nom="EV_modulo     " Tipo="VARCHAR2"></param>
    <param nom="EN_num_movimiento" Tipo="NUMBER"></param>
   </Entrada>
  <Salida>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
ERROR_PROCESO     EXCEPTION;
LN_num_secuencia  NUMBER(10);
TN_cod_retorno    ga_transacabo.cod_retorno%TYPE;
TV_des_cadena     ga_transacabo.des_cadena%TYPE;
LV_proceso        VARCHAR2(1000);
LV_abonado_char   VARCHAR2(8);
LV_actuacion_char VARCHAR2(5);
LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno   ge_errores_td.det_msgerror%TYPE;
LN_num_evento     ge_errores_pg.Evento;
LV_des_error      ge_errores_pg.DesEvent;
BEGIN
         LV_des_error :='ve_bajaabonados_pr('||','||EV_actabo||','||EN_producto||','||EN_num_abonado||','||EV_perfil||','||EN_rent||','||ED_fecsys||','||EN_indsusp||','||EV_modulo||','||EN_num_movimiento||','||
                         EV_cod_servicios||','||EV_cod_actuacion||','||EV_num_serie||','||EV_num_serie_old||','||EV_nom_usuarora||')';

         LV_proceso :='ge_fn_devvalparam(GA, 1,RESP_BAJA_ALTAMIRA)';
     IF ge_fn_devvalparam('GA', 1,'RESP_BAJA_ALTAMIRA') = 0 and EV_actabo = 'BH' THEN
         UPDATE ga_abocel
         SET cod_situacion = 'BAA'
         WHERE num_abonado = EN_num_abonado;
     ELSE
         LV_proceso :='p_modifica_estadoabo('||EN_producto||','||EN_num_abonado||','||EN_indsusp||','||EN_rent||','||ED_fecsys||')';
         p_modifica_estadoabo (EN_producto,EN_num_abonado,EN_indsusp,EN_rent,ED_fecsys);
     END IF;

         LV_proceso :='p_modifica_estadoabo('||EN_producto||','||EN_num_abonado||','||EN_indsusp||','||EN_rent||','||ED_fecsys||',1,'||EV_modulo||')';
         p_modifica_estadoabo(EN_producto,EN_num_abonado,EN_indsusp,EN_rent,ED_fecsys,1,EV_modulo);
         LV_proceso :='pv_pr_resp_central('||EN_num_movimiento||')';
         pv_pr_resp_central(EN_num_movimiento);
         LV_proceso :='p_proceso_servicios('||EN_producto||','||EN_num_abonado||','||EV_cod_servicios||','||ED_fecsys||')';
         p_proceso_servicios(EN_producto,EN_num_abonado,EV_cod_servicios,ED_fecsys);

         BEGIN
               SELECT ga_seq_transacabo.NEXTVAL
               INTO LN_num_secuencia
               FROM DUAL;

               LV_proceso := 'co_bajas_abo( ' || LN_num_secuencia ||','||EN_num_abonado||',BAJA )';
               co_bajas_abo(LN_num_secuencia,EN_num_abonado,'BAJA');

               SELECT ga.cod_retorno, GA.des_cadena
               INTO TN_cod_retorno, TV_des_cadena
               FROM ga_transacabo ga
               WHERE ga.num_transaccion = LN_num_secuencia;

               DELETE ga_transacabo
               WHERE num_transaccion = LN_num_secuencia;

               IF TN_cod_retorno <> 0 THEN
                  RAISE ERROR_PROCESO;
               END IF;
        END;

        BEGIN
               LV_actuacion_char := TO_CHAR(EV_cod_actuacion);
               LV_abonado_char   := TO_CHAR(EN_num_abonado);
               p_al_interfaz_club(LV_abonado_char,EV_nom_usuarora,NULL,LV_actuacion_char,EV_actabo);

               EXCEPTION
                    WHEN OTHERS THEN
                         NULL;
        END;

        LV_proceso :='p_ic_actualiza_akeys('||EN_num_movimiento||','||EV_actabo||',2,'||EV_cod_servicios||','||EV_num_serie_old||','||EV_num_serie||')';
        p_ic_actualiza_akeys(EN_num_movimiento,EV_actabo,2,EV_cod_servicios,EV_num_serie_old,EV_num_serie);

EXCEPTION
       WHEN ERROR_PROCESO THEN
         LN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_proceso_servicio_pg.ve_bajaabonados_pr', LV_proceso, SQLCODE, TV_des_cadena );


       WHEN OTHERS THEN
         LN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_proceso_servicio_pg.ve_bajaabonados_pr', LV_proceso, SQLCODE, LV_des_error );

END ve_bajaabonados_pr ;

PROCEDURE ve_bloqueaabonado_pr (EV_actabo         IN icc_movimiento.cod_actabo%TYPE,
                                EN_producto       IN NUMBER,
                                EN_num_abonado        IN icc_movimiento.num_abonado%TYPE,
                                EV_modulo         IN icc_movimiento.cod_modulo%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_BLOQUEAABONADO_PR"
          Lenguaje="PL/SQL"
          Fecha="11/11/2005"
          Versión="1.0.0"
          Diseñador="Vladimir Maureira"
          Programador="vladimir maureira"
          Ambiente="DEIMOS_ANDINA">
 <Retorno>NA</Retorno>
 <Descripción></Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EV_actabo     " Tipo="VARCHAR2"></param>
   <param nom="EN_producto   " Tipo="NUMBER"></param>
   <param nom="EN_num_abonado" Tipo="NUMBER"></param>
   <param nom="EV_modulo     " Tipo="VARCHAR2"></param>
  </Entrada>
  <Salida>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
LV_proceso        VARCHAR2(1000);
LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno   ge_errores_td.det_msgerror%TYPE;
LN_num_evento     ge_errores_pg.Evento;
LV_des_error      ge_errores_pg.DesEvent;
BEGIN
        LV_des_error:='ve_bloqueaabonado_pr('||EV_actabo||','||EN_producto||','||EN_num_abonado||','||EV_modulo||')';

        IF EN_num_abonado <> 0 THEN
           LV_proceso :='p_bloquea_abonado('||EV_modulo||','||EN_producto||','||EV_actabo||','||EN_num_abonado||')';
           p_bloquea_abonado (EV_modulo, EN_producto, EV_actabo, EN_num_abonado);
        END IF;
EXCEPTION
       WHEN OTHERS THEN
         LN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_proceso_servicio_pg.ve_bloqueaabonado_pr', LV_proceso, SQLCODE, LV_des_error );
END ve_bloqueaabonado_pr ;

PROCEDURE ve_actualiza_akeys1_pr (EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                                  EV_actabo         IN icc_movimiento.cod_actabo%TYPE,
                                  EV_cod_servicios  IN icc_movimiento.cod_servicios%TYPE,
                                  EV_num_serie      IN icc_movimiento.num_serie_nue%TYPE,
                                  EV_num_serie_old  IN icc_movimiento.num_serie%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_ACTUALIZA_AKEYS1_PR"
          Lenguaje="PL/SQL"
          Fecha="11/11/2005"
          Versión="1.0.0"
          Diseñador="Vladimir Maureira"
          Programador="vladimir maureira"
          Ambiente="DEIMOS_ANDINA">
 <Retorno>NA</Retorno>
 <Descripción></Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EN_num_movimiento" Tipo="NUMBER"></param>
   <param nom="EV_actabo        " Tipo="VARCHAR2"></param>
   <param nom="EV_cod_servicios " Tipo="VARCHAR2"></param>
   <param nom="EV_num_serie     " Tipo="VARCHAR2"></param>
   <param nom="EV_num_serie_old " Tipo="VARCHAR2"></param>
  </Entrada>
  <Salida>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
LV_proceso        VARCHAR2(1000);
LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno   ge_errores_td.det_msgerror%TYPE;
LN_num_evento     ge_errores_pg.Evento;
LV_des_error      ge_errores_pg.DesEvent;
BEGIN
     LV_des_error:='ve_actualiza_akeys1_pr';
     LV_proceso :='p_ic_actualiza_akeys('||EN_num_movimiento||','||EV_actabo||',1,'||EV_cod_servicios||','||EV_num_serie_old||','||EV_num_serie||')';
     p_ic_actualiza_akeys(EN_num_movimiento,EV_actabo,1,EV_cod_servicios,EV_num_serie_old,EV_num_serie );
EXCEPTION
       WHEN OTHERS THEN
         LN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_proceso_servicio_pg.ve_actualiza_akeys1_pr', LV_proceso, SQLCODE, LV_des_error );
END ve_actualiza_akeys1_pr ;

PROCEDURE ve_actualiza_akeys0_pr (EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                                  EV_actabo         IN icc_movimiento.cod_actabo%TYPE,
                                  EV_cod_servicios  IN icc_movimiento.cod_servicios%TYPE,
                                  EV_num_serie      IN icc_movimiento.num_serie_nue%TYPE,
                                  EV_num_serie_old  IN icc_movimiento.num_serie%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_ACTUALIZA_AKEYS0_PR"
          Lenguaje="PL/SQL"
          Fecha="11/11/2005"
          Versión="1.0.0"
          Diseñador="Vladimir Maureira"
          Programador="vladimir maureira"
          Ambiente="DEIMOS_ANDINA">
 <Retorno>NA</Retorno>
 <Descripción></Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EN_num_movimiento" Tipo="NUMBER"></param>
   <param nom="EV_actabo        " Tipo="VARCHAR2"></param>
   <param nom="EV_cod_servicios " Tipo="VARCHAR2"></param>
   <param nom="EV_num_serie     " Tipo="VARCHAR2"></param>
   <param nom="EV_num_serie_old " Tipo="VARCHAR2"></param>
  </Entrada>
  <Salida>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
LV_proceso        VARCHAR2(1000);
LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno   ge_errores_td.det_msgerror%TYPE;
LN_num_evento     ge_errores_pg.Evento;
LV_des_error      ge_errores_pg.DesEvent;
BEGIN
     LV_des_error:='ve_actualiza_akeys0_pr';
     LV_proceso :='p_ic_actualiza_akeys('||EN_num_movimiento||','||EV_actabo||',0,'||EV_cod_servicios||','||EV_num_serie_old||','||EV_num_serie||')';
     p_ic_actualiza_akeys(EN_num_movimiento,EV_actabo,0,EV_cod_servicios,EV_num_serie_old,EV_num_serie );

EXCEPTION
       WHEN OTHERS THEN
         LN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_proceso_servicio_pg.ve_actualiza_akeys0_pr', LV_proceso, SQLCODE, LV_des_error );
END ve_actualiza_akeys0_pr ;

PROCEDURE ve_cambionumero_pr (EN_producto        IN NUMBER,
                              EN_num_abonado     IN icc_movimiento.num_abonado%TYPE,
                              EV_cod_servicios   IN icc_movimiento.cod_servicios%TYPE,
                              SV_perfil          IN OUT NOCOPY ga_abocel.perfil_abonado%TYPE,
                              EN_rent            IN NUMBER,
                              ED_fecsys          IN DATE,
                              SV_clase_servicio  IN OUT NOCOPY ga_abocel.clase_servicio%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "ve_cambionumero_pr"
          Lenguaje="PL/SQL"
          Fecha="11/11/2005"
          Versión="1.0.0"
          Diseñador="Vladimir Maureira"
          Programador="vladimir maureira"
          Ambiente="DEIMOS_ANDINA">
 <Retorno>NA</Retorno>
 <Descripción></Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EN_producto      " Tipo="NUMBER"></param>
   <param nom="EN_num_abonado   " Tipo="NUMBER"></param>
   <param nom="EV_cod_servicios " Tipo="VARCHAR2"></param>
   <param nom="SV_perfil        " Tipo="VARCHAR2"></param>
   <param nom="EN_rent          " Tipo="NUMBER"></param>
   <param nom="ED_fecsys        " Tipo="DATE"></param>
   <param nom="SV_clase_servicio" Tipo="DATE"></param>
  </Entrada>
  <Salida>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
LV_proceso        VARCHAR2(1000);
LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno   ge_errores_td.det_msgerror%TYPE;
LN_num_evento     ge_errores_pg.Evento;
LV_des_error      ge_errores_pg.DesEvent;
BEGIN
        LV_des_error:='ve_cambionumero_pr('||','||EN_producto||','||EN_num_abonado||','||EV_cod_servicios||','||SV_perfil||','||EN_rent||','||ED_fecsys||','||SV_clase_servicio||')';
        IF EV_cod_servicios IS NOT NULL THEN
           LV_proceso := 'p_recupera_perfilabo('||EN_producto||','||EN_num_abonado||','||SV_perfil||','||SV_clase_servicio||','||EN_rent||','||ED_fecsys||')';
           p_recupera_perfilabo(EN_producto,EN_num_abonado,SV_perfil,SV_clase_servicio,EN_rent,ED_fecsys);
           LV_proceso :='p_actualiza_perfil('||EN_producto||','||EN_num_abonado||','||EV_cod_servicios||','||SV_perfil||','||EN_rent||','||ED_fecsys||')';
           p_actualiza_perfil (EN_producto,EN_num_abonado,EV_cod_servicios,SV_perfil,EN_rent,ED_fecsys);
        END IF;

EXCEPTION
       WHEN OTHERS THEN
         LN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_proceso_servicio_pg.ve_cambionumero_pr', LV_proceso, SQLCODE, LV_des_error );
END ve_cambionumero_pr ;

PROCEDURE ve_fact_hibridos_pr (EN_num_abonado   IN icc_movimiento.num_abonado%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "ve_fact_hibridos_pr"
          Lenguaje="PL/SQL"
          Fecha="11/11/2005"
          Versión="1.0.0"
          Diseñador="Vladimir Maureira"
          Programador="vladimir maureira"
          Ambiente="DEIMOS_ANDINA">
 <Retorno>NA</Retorno>
 <Descripción></Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EN_num_abonado " Tipo="NUMBER"></param>
  </Entrada>
  <Salida>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
ERROR_PROCESO     EXCEPTION;
TV_val_parametro  ged_parametros.val_parametro%TYPE;
LV_abonado_char   VARCHAR2(8);
LV_num_secuencia  VARCHAR(9);
LV_proceso        VARCHAR2(1000);
LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno   ge_errores_td.det_msgerror%TYPE;
LN_num_evento     ge_errores_pg.Evento;
LV_des_error      ge_errores_pg.DesEvent;
BEGIN
           LV_des_error:='ve_fact_hibridos_pr('||EN_num_abonado||')';
           BEGIN
                SELECT ged.val_parametro
                INTO   TV_val_parametro
                FROM  ged_parametros ged
                WHERE ged.nom_parametro = 'COD_TIPLAN'
                AND ged.cod_modulo = 'GE'
                AND ged.cod_producto = 1;

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     TV_val_parametro := 'FALSE';
                WHEN OTHERS THEN
                     RAISE ERROR_PROCESO;
           END;

           IF  TV_val_parametro = 'TRUE' THEN
               LV_abonado_char := TO_CHAR(EN_num_abonado);
               p_limconsumo_cliabo(LV_abonado_char);
           END IF;

           BEGIN
               LV_abonado_char := TO_CHAR(EN_num_abonado);
               SELECT TO_CHAR(GA_SEQ_TRANSACABO.NEXTVAL)
               INTO LV_num_secuencia
               FROM DUAL;

               LV_proceso :='p_interfases_abonados('|| LV_num_secuencia ||',AV,1,'||LV_abonado_char||',null,null,null,GA)';
               p_interfases_abonados(LV_num_secuencia,'AV','1',LV_abonado_char,'','','','GA');

               EXCEPTION
                 WHEN OTHERS THEN
                    RAISE ERROR_PROCESO;
           END;

EXCEPTION
    WHEN ERROR_PROCESO THEN
         LN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_proceso_servicio_pg.ve_fact_hibridos_pr', LV_proceso, SQLCODE, LV_des_error );

    WHEN OTHERS THEN
     LN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_proceso_servicio_pg.ve_fact_hibridos_pr', LV_proceso, SQLCODE, LV_des_error );
END ve_fact_hibridos_pr ;

END VE_PROCESO_SERVICIO_PG;
/
SHOW ERRORS
