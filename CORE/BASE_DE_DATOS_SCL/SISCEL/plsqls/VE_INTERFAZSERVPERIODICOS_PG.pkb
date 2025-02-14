CREATE OR REPLACE PACKAGE BODY VE_INTERFAZSERVPERIODICOS_PG
AS

CV_error_no_clasif CONSTANT VARCHAR2(20) := 'Error no clasificado';
CN_cod_retorno     CONSTANT NUMBER(6) := 0;
CV_insertar        CONSTANT icc_interfaz_consultas_to.tip_actividad%TYPE :='I';
CV_borrar          CONSTANT icc_interfaz_consultas_to.tip_actividad%TYPE :='D';

PROCEDURE ve_servperiodico_pr (EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                               EN_num_abonado    IN icc_movimiento.num_abonado%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_SERVPERIODICO_PR"
 Lenguaje="PL/SQL"
 Fecha="11/11/2005"
 Versión="1.0.0"
 Diseñador="Vladimir Maureira"
 Programador="vladimir maureira"
 Ambiente="DEIMOS_ANDINA">
 <Retorno>NA</Retorno>
 <Descripción>Ingresa los servicios de los prepagos hibridos (servicios periodicos)</Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EN_num_movimiento" Tipo="NUMBER"></param>
   <param nom="EN_num_abonado" Tipo="NUMBER"></param>
  </Entrada>
  <Salida>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/

error_           EXCEPTION;
exit_            EXCEPTION;
LV_des_error     ge_errores_pg.DesEvent;
LV_sql           ge_errores_pg.vQuery:='';

LN_cod_retorno   ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno  ge_errores_td.det_msgerror%TYPE;
LN_num_evento    ge_errores_pg.Evento;

TV_cod_plantarif ga_abocel.cod_plantarif%TYPE;
TV_cod_tiplan    ta_plantarif.cod_tiplan%TYPE;
TV_cod_hibrido   ta_plantarif.cod_tiplan%TYPE;
TV_cod_periocidad  icc_interfaz_consultas_to.cod_periocidad%TYPE;
TN_num_trx       icc_interfaz_consultas_to.num_trx%TYPE;
TV_cod_servicios icc_interfaz_consultas_to.cod_servicios%TYPE; --Inc. 76664 RAB 04-04-2009

CURSOR cursor_interfaz IS
SELECT ic.num_trx,
       ic.cod_periocidad,
       ic.cod_servicios --Inc. 76664 RAB 04-04-2009
FROM   icc_interfaz_consultas_to ic
WHERE  ic.num_movimiento= EN_num_movimiento
  AND  ic.cod_periocidad IS NOT NULL;

BEGIN
     LN_cod_retorno := 0;
     LN_num_evento  := 0;
     LV_mens_retorno:= '0';

     IF EN_num_movimiento IS NULL THEN
        LN_cod_retorno := 98; --Error en los parámetros de entrada al ejecutar servicio
        LV_des_error := 'Parametro num_movimiento es null';
        RAISE error_;
     END IF;

     IF EN_num_abonado IS NULL THEN
        LN_cod_retorno := 98; --Error en los parámetros de entrada al ejecutar servicio
        LV_des_error := 'Parametro num_abonado es null';
        RAISE error_;
     END IF;


     -- Obtener Plan Abonado
     BEGIN
          LV_sql := 'SELECT ga.cod_plantarif ';
          LV_sql := LV_sql || 'FROM   ga_abocel ga ';
          LV_sql := LV_sql || 'WHERE  num_abonado = ' || EN_num_abonado;

          SELECT ga.cod_plantarif
          INTO   TV_cod_plantarif
          FROM   ga_abocel ga
          WHERE  ga.num_abonado = EN_num_abonado;

          EXCEPTION
            WHEN OTHERS THEN
                LN_cod_retorno := 219; --No es posible recuperar el plan del abonado
                LV_des_error  := 've_interfazservperiodico_pg.ve_servperiodico_pr(' || EN_num_movimiento || EN_num_abonado || '); - ' || SQLERRM;
                RAISE error_;
     END;

          LV_sql := 'GE_FN_DEVVALPARAM(GA, 1, TIPOHIBRIDO)';
          TV_cod_hibrido :=GE_FN_DEVVALPARAM('GA', 1, 'TIPOHIBRIDO');

          IF TV_cod_hibrido IS NULL THEN
              LV_des_error  := 've_interfazservperiodico_pg.ve_servperiodico_pr() Error Obtener Codigo Hibrido';
              RAISE error_;
          END IF;

          LV_sql := 'SELECT ta.cod_tiplan ';
          LV_sql := LV_sql || 'FROM  ta_plantarif ta  ';
          LV_sql := LV_sql || 'WHERE ta.cod_plantarif = ' || TV_cod_plantarif;

     BEGIN
          SELECT ta.cod_tiplan
          INTO   TV_cod_tiplan
          FROM   ta_plantarif ta
          WHERE  ta.cod_plantarif = TV_cod_plantarif;

          IF  TV_cod_hibrido <> TV_cod_tiplan THEN
              RAISE exit_; -- no es hibrido debe salir
          END IF;

          EXCEPTION
            WHEN OTHERS THEN
                LN_cod_retorno := 282; --No es posible recuperar el código de tipo del plan tarifario
                LV_des_error  := 've_interfazservperiodico_pg.ve_servperiodico_pr(' || EN_num_movimiento || EN_num_abonado || '); - ' || SQLERRM;
                RAISE error_;
     END;

     -- Buscar el servicio supl. intrefaz_consulta deba ser generado en forma periodica
          LV_sql := 'SELECT ic.num_trx,int.cod_periocidad ';
          LV_sql := LV_sql || 'FROM   icc_interfaz_consultas_to ic ';
          LV_sql := LV_sql || 'WHERE ic.num_movimiento= ' || EN_num_movimiento;
     -- Abrir cursor interfaz_consulta
         OPEN cursor_interfaz;
    LOOP
     BEGIN
          FETCH cursor_interfaz INTO TN_num_trx,TV_cod_periocidad,
                TV_cod_servicios; --Inc. 76664 RAB 04-04-2009
          EXIT WHEN cursor_interfaz%NOTFOUND;

          -- Insertamos la actuacion
          ve_ic_interfazsersupl_to_pg.ve_agregar_pr(EN_num_abonado,TN_num_trx,TV_cod_periocidad, TV_cod_servicios,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
          IF LN_cod_retorno <> CN_cod_retorno THEN
             LN_cod_retorno := 4; --No se pudo agregar datos
             LV_des_error  := 've_interfazservperiodico_pg.ve_servperiodico_pr(' || EN_num_movimiento || EN_num_abonado || '); - error al invocar ve_ic_interfazsersupl_to_pg.ve_agregar_pr';
             RAISE error_;
          END IF;

          EXCEPTION
            WHEN OTHERS THEN
                LN_cod_retorno := 156;
                LV_des_error  := 've_interfazservperiodico_pg.ve_servperiodico_pr(' || EN_num_movimiento || EN_num_abonado || '); - ' || SQLERRM;
                RAISE error_;
     END;
    END LOOP;
      CLOSE cursor_interfaz;

    EXCEPTION
      WHEN error_ THEN
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_interfazservperiodico_pg.ve_servperiodico_pr', LV_sql, SQLCODE, LV_des_error );

      WHEN exit_ THEN
         NULL;
END ve_servperiodico_pr;

PROCEDURE ve_actualizacargo_pr(EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                               EN_num_abonado    IN icc_movimiento.num_abonado%TYPE,
                               EV_actabo         IN icc_movimiento.cod_actabo%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_ACTUALIZACARGO_PR"
 Lenguaje="PL/SQL"
 Fecha="11/11/2005"
 Versión="1.0.0"
 Diseñador="Vladimir mauriera"
 Programador="vladimir maureira"
 Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Actualización cargos periodicos en tabla IC_INTERFAZSERSUPL_TO</Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EN_num_movimiento  " Tipo="NUMBER"></param>
   <param nom="EN_num_abonado     " Tipo="NUMBER"></param>
   <param nom="EV_actabo          " Tipo="VARCHAR2"></param>
  </Entrada>
  <Salida>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
error_           EXCEPTION;
LV_des_error     ge_errores_pg.DesEvent;
LV_sql           ge_errores_pg.vQuery;

LN_cod_retorno     ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno    ge_errores_td.det_msgerror%TYPE;
LN_num_evento      ge_errores_pg.Evento;
TV_cod_periocidad  icc_interfaz_consultas_to.cod_periocidad%TYPE;
TN_num_trx         icc_interfaz_consultas_to.num_trx%TYPE;
TV_tip_actividad   icc_interfaz_consultas_to.tip_actividad%TYPE;
TV_cod_servicios   icc_interfaz_consultas_to.cod_servicios%TYPE; --Inc. 76664 RAB 04-04-2009

CURSOR cursor_interfaz IS
SELECT ic.num_trx,
       ic.cod_periocidad,
       ic.tip_actividad,
       ic.cod_servicios --Inc. 76664 RAB 04-04-2009
FROM   icc_interfaz_consultas_to ic
WHERE  ic.num_movimiento= EN_num_movimiento
  AND  ic.cod_periocidad IS NOT NULL;
BEGIN
     LN_cod_retorno := 0;
     LN_num_evento  := 0;
     LV_mens_retorno:= '0';

     IF EN_num_movimiento IS NULL THEN
        LN_cod_retorno := 98; --Error en los parámetros de entrada al ejecutar servicio
        LV_des_error := 'Parametro num_movimiento es null';
        RAISE error_;
     END IF;

     IF EN_num_abonado IS NULL THEN
        LN_cod_retorno := 98; --Error en los parámetros de entrada al ejecutar servicio
        LV_des_error := 'Parametro num_abonado es null';
        RAISE error_;
     END IF;


     LV_sql := 'SELECT ic.num_trx, ';
     LV_sql := LV_sql || ' ic.cod_periocidad,ic.tip_actividad, ic.cod_servicios ';
     LV_sql := LV_sql || ' FROM   icc_interfaz_consultas_to ic ';
     LV_sql := LV_sql || ' WHERE  ic.num_movimiento= ' || EN_num_movimiento;
     LV_sql := LV_sql || ' AND  ic.cod_periocidad IS NOT NULL';

     OPEN cursor_interfaz;
     LOOP
          FETCH cursor_interfaz INTO TN_num_trx,TV_cod_periocidad,TV_tip_actividad,
                TV_cod_servicios; --Inc. 76664 RAB 04-04-2009
          EXIT WHEN cursor_interfaz%NOTFOUND;

          IF TV_tip_actividad = CV_borrar THEN
             ve_ic_interfazsersupl_to_pg.ve_eliminar_pr(EN_num_abonado,TV_cod_periocidad,TV_cod_servicios,LN_cod_retorno,LV_mens_retorno);
          ELSIF TV_tip_actividad = CV_insertar THEN
             ve_ic_interfazsersupl_to_pg.ve_eliminar_pr(EN_num_abonado,TV_cod_periocidad,TV_cod_servicios,LN_cod_retorno,LV_mens_retorno);
             ve_ic_interfazsersupl_to_pg.ve_agregar_pr(EN_num_abonado,TN_num_trx,TV_cod_periocidad,TV_cod_servicios,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
          ELSE
             ve_ic_interfazsersupl_to_pg.ve_modificar_pr(EN_num_abonado,TN_num_trx,TV_cod_periocidad,TV_cod_servicios,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
          END IF;

          IF LN_cod_retorno <> CN_cod_retorno THEN
             LN_cod_retorno := 156;
             LV_des_error  := 've_interfazservperiodico_pg.ve_actualizacargo_pr(' || EN_num_movimiento || ',' || EN_num_abonado || '); - ' || SQLERRM;
             RAISE error_;
          END IF;
     END LOOP;

     CLOSE cursor_interfaz;

       DELETE  icc_interfaz_consultas_to
       WHERE   num_movimiento= EN_num_movimiento
       AND     tip_actividad = CV_borrar;


     EXCEPTION
      WHEN error_ THEN
         IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
            LV_mens_retorno := CV_error_no_clasif;
         END IF;
         LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', LV_mens_retorno, '1.0', USER, 've_interfazservperiodico_pg.ve_actualizacargo_pr', LV_sql, SQLCODE, LV_des_error );

      WHEN OTHERS THEN
          LN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                LV_mens_retorno := CV_error_no_clasif;
          END IF;

          LV_des_error  := 've_interfazservperiodico_pg.ve_actualizacargo_pr(' || EN_num_movimiento || ',' || EN_num_abonado || '); - ' || SQLERRM;
          LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', 'Error no clasificado', '1.0', USER,'ve_interfazservperiodico_pg.ve_actualizacargo_pr', LV_sql, SQLCODE, LV_des_error );
END ve_actualizacargo_pr;

END VE_INTERFAZSERVPERIODICOS_PG;
/
SHOW ERRORS
