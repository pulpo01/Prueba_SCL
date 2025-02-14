CREATE OR REPLACE PACKAGE BODY NP_DEVOLUCIONSERIES_PG
IS
/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = "NP_DEVOLUCIONSERIES_PG" Lenguaje="PL/SQL" Fecha="05-12-2005" Versión="1.0" Diseñador="****" Programador="Ingrid Cabrera - Zenén MUñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PKG  encargado de realiar los procesos de Devoluciones de pedidos en NPW</Descripción>
<Parámetros>
    <Entrada>    </Entrada>
    <Salida>     </Salida>
</Parámetros>
</Elemento>
</Documentación>

** sólo en case de modificación
 <FECHAMOD> 03-04-2007    </FECHAMOD>
 <AUTORMOD> Zenén MUñoz H.    </AUTORMOD>
 <VERSIONMOD> 1.1  </VERSIONMOD>
 <DESCMOD> Cambio en el PL: NP_VALI_SERIEDEVOLUCION_PR, donde se incorpora la validación de series duplicadas en una devolución </DESCMOD>
 <FECHAMOD> 26-10-2007    </FECHAMOD>
 <AUTORMOD> Zenén MUñoz H.    </AUTORMOD>
 <VERSIONMOD> 1.2  </VERSIONMOD>
 <DESCMOD> Cambio en el PL: NP_VALI_SERIEDEVOLUCION_PR, donde se incorpora la validación de series en estado distinto de 'AAA' para una devolución </DESCMOD>
<DESCMOD>      : Modifica el Procedimiento: NP_DETO_DEVOLTOTALPED_PR, al recuperar el total de series que crearon abonados
                 Incidencia: 45194, además se modifica la forma de validar si una devolución anterior ha tenido un estado rechazado (17),
                 para volver a realizar devoluciones a un pedido
 <VERSIONMOD> 1.3  </VERSIONMOD>
 <FECHAMOD> 27-03-2008    </FECHAMOD>
 <AUTORMOD> Zenén MUñoz H.    </AUTORMOD>
 <DESCMOD> Se agreaga el PL: NP_SEDE_VALIDASERIESDEV_PR, con el onjetivo de validar las devoluciones al momento de aceptar una devolución.
           Incidencia: 63202
 </DESCMOD>
<FECHAMOD >    : 11/08/2009 </FECHAMOD >
<DESCMOD >     : Modificación a PL para: P-MIX-09003-Guatemala-Salvador   </DESCMOD >
<VERSIONMOD>   : 1.4    </VERSIONMOD>
<AUTOR>        : Z.M.H. </AUTORMOD>


*/

  PROCEDURE NP_VALI_SERIEDEVOLUCION_PR
  (v_cod_pedido in npt_detalle_devolucion.cod_pedido%TYPE,
   EV_strError out nocopy varchar) IS
/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = "NP_DEVOLUCIONSERIES_PG" Lenguaje="PL/SQL" Fecha="05-12-2005" Versión="1.0" Diseñador="****" Programador="Ingrid Cabrera - Zenén MUñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PKG  encargado de realiar los procesos de Devoluciones de pedidos en NPW</Descripción>
<Parámetros>
    <Entrada>
            <param nom="v_cod_pedido" Tipo="NUMBER">Código del pedido a devolver </param>
    </Entrada>
    <Salida>
            <param nom="EV_strError" Tipo="NUMBER">Descripción del error de la devolución </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>

** sólo en case de modificación
 <FECHAMOD> 03-04-2007    </FECHAMOD>
 <AUTORMOD> Zenén MUñoz H.    </AUTORMOD>
 <VERSIONMOD> 1.1  </VERSIONMOD>
 <DESCMOD> Cambio en el que se incorpora la validación de series duplicadas en una devolución, incidencia: 38996 </DESCMOD>
*/
  -- v_cod_pedido      npt_serie_pedido.cod_pedido%TYPE;
  strSeries            VARCHAR2(32000);
  v_serie_ind          npt_serie_pedido.cod_serie_pedido%TYPE;
  v_ind                NUMBER;
  v_total              number;
  v_total_serie        NUMBER;
  v_inicio             NUMBER;
  v_cod_devolucion     NPT_DEVOLUCION.cod_devolucion%TYPE;
  v_tip_articulo       AL_ARTICULOS.tip_articulo%TYPE;
  v_num_abonado        GA_ABOAMIST.num_abonado%TYPE;
  v_strSerieAux        NP_SERIESDEVOL_TO.DES_SERIEAUX%type;

  strSW                VARCHAR2(2):= '9';
  v_series             NP_SERIESDEVOL_TO.COD_SERIES%type;
  v_strDevProExi       VARCHAR2(2);
  v_strIndKitAct       VARCHAR2(2);
  v_strSerieNoPedido   NP_SERIESDEVOL_TO.DES_SERIENOPEDIDO%type;
  v_strSerieDevueltas  NP_SERIESDEVOL_TO.DES_SERIEDEVUELTAS%type;
  v_strSerieKITActivo  NP_SERIESDEVOL_TO.DES_SERIEKITACTIVO%type;
  LV_strSerieDuplicada NP_SERIESDEVOL_TO.DES_SERIEDUPLICADA%type;
  v_msgerror           VARCHAR2(200);
  v_marca              VARCHAR2(2) := ' ';
  LN_existe_serie      number(02);
  LN_correlativo       NP_SERIESDEVOL_TO.COD_CORRELATIVO%type := 0;

  LV_strSerieNOAAA     VARCHAR2(32000) := ''; -- 45194  ZMH  26-10-2007
  LN_abo_act           number;    -- 45194  ZMH  26-10-2007
  LN_existe_abo        number;    -- 45194  ZMH  26-10-2007
  LN_num_abonado       GA_ABOAMIST.num_abonado%TYPE;  -- 45194  ZMH  26-10-2007
  LV_cod_situacion     GA_ABOAMIST.cod_situacion%TYPE;  -- 45194  ZMH  26-10-2007
  LV_Indicador         varchar(10):='';   -- 45194  ZMH  26-10-2007
  v_comando_sql        VARCHAR2(3000) := ''; -- 45194  ZMH  26-10-2007
  v_fec_alta           VARCHAR2(20); -- 45194  ZMH  26-10-2007

-- Inicio  38996 03-04-2007
  Cursor leeSeriesDev is
     Select COD_CORRELATIVO, COD_SERIES, COD_DEVPROEXI, COD_INDKITACT
     From NP_SERIESDEVOL_TO
     Where COD_PEDIDO = v_cod_pedido;

-- fin 38996
  BEGIN

-- Inicio  45194 29-10-2007  ZMH
      BEGIN
          SELECT replace(VALOR_PARAMETRO, ' ', ', ')
          into LV_Indicador
        FROM npt_parametro
          WHERE ALIAS_PARAMETRO = 'SER_VALIDA';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            EV_strError := 'Error: Falta Indicador de Serie valido para devolver [SER_VALIDA]';
    END;
-- Fin 45194

-- Inicio  38996 03-04-2007
     Delete from NP_VALIDA_DEVOLSERIES_TO
     Where COD_PEDIDO = v_cod_pedido;

     For vleeSeriesDev in leeSeriesDev Loop

         LN_correlativo := vleeSeriesDev.COD_CORRELATIVO;
         v_series := vleeSeriesDev.COD_SERIES;
         v_strDevProExi := vleeSeriesDev.COD_DEVPROEXI;
         v_strIndKitAct := vleeSeriesDev.COD_INDKITACT;

-- fin 38996

         v_ind := 1;
         v_total := length(v_series);
         strSeries := SUBSTR(v_series, 1, v_total - 1);
         v_total := length(strSeries);

         loop
            exit when v_marca = '*';
            if SUBSTR(strSeries, v_total, 1) = '-' then
               strSeries := SUBSTR(strSeries, 1, v_total - 1);
               v_total := length(strSeries);
            else
               v_marca := '*';
            end if;
         end loop;

            v_strSerieNoPedido := '';
            v_strSerieDevueltas := '';
            v_strSerieKITActivo := '';
            LV_strSerieDuplicada := '';
             v_strSerieAux := '';

         LOOP
            EXIT WHEN v_ind = v_total;

            strSW := '0';
            v_inicio := INSTR(strSeries, '-');
            IF v_inicio  = 0 THEN
               v_serie_ind := strSeries;
               v_total:=  v_ind;
            ELSE
               v_serie_ind := SUBSTR(strSeries, v_ind, v_inicio - 1);
               strSeries := SUBSTR(strSeries, v_inicio + 1, LENGTH(strSeries) - v_inicio);
            END IF;
--            strSW := '01';

            v_total_serie := 0;
            SELECT COUNT(1) INTO v_total_serie FROM npt_serie_pedido
            WHERE cod_pedido = v_cod_pedido
            AND lin_det_pedido > 0
            AND cod_serie_pedido = v_serie_ind;

            IF v_total_serie = 0 THEN
               strSW := '1';
               v_strSerieNoPedido := v_strSerieNoPedido || v_serie_ind || '-';
-- Inicio  38996 03-04-2007
               Begin
                  Insert Into NP_VALIDA_DEVOLSERIES_TO
                  (COD_PEDIDO, NUM_SERIE, COD_ERROR, DES_VALIDACION, FEC_VALIDA)
                  values (v_cod_pedido, v_serie_ind, to_number(strSW), 'No pertenece al pedido', sysdate);
                  EXCEPTION
                    WHEN OTHERS THEN
                        null;
               End;

-- Fin 38996
            ELSE
            -- Valida que las series que no hayan sido devueltas anteriormente
               BEGIN
                  SELECT NVL(max(cod_devolucion), '0') INTO v_cod_devolucion
                  FROM npt_detalle_devolucion
                  WHERE cod_serie_pedido = v_serie_ind;
                  EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                        v_cod_devolucion := 0;
               END;
               IF v_cod_devolucion <> 0 THEN
            -- Valida que este en el estado 91 (devolucion procesada con exito)
                  BEGIN
--                  strSW := '02';
                     SELECT NVL(max(cod_devolucion), 0) INTO v_cod_devolucion
                     FROM npt_estado_devolucion WHERE cod_devolucion = v_cod_devolucion
                     AND cod_estado_flujo in (v_strDevProExi, 17); -- estado_flujo 17 para las devoluciones rechazadas.
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                           strSW := '2';
                           v_strSerieDevueltas := v_strSerieDevueltas || v_serie_ind || '-';
-- Inicio  38996 03-04-2007
                            Begin
                              Insert Into NP_VALIDA_DEVOLSERIES_TO
                              (COD_PEDIDO, NUM_SERIE, COD_ERROR, DES_VALIDACION, FEC_VALIDA)
                              values (v_cod_pedido, v_serie_ind, to_number(strSW), 'Serie ya Devuelta', sysdate);
                              EXCEPTION
                                 WHEN OTHERS THEN
                                     null;
                            End;
-- Fin 38996
                  END;
               END IF;
            -- Rescata tipo de articulo , si es kit (tip articulo = 20) se valida que no este activo.
               BEGIN
                  v_tip_articulo  := 0;
--                  strSW := '03';
                  SELECT NVL(max(c.tip_articulo), '0') INTO v_tip_articulo
                  FROM NPT_DETALLE_DEVOLUCION A, NPT_DETALLE_PEDIDO B, AL_ARTICULOS C
                  WHERE a.cod_pedido       = v_cod_pedido
                    AND a.lin_det_devolucion > 0
                    AND a.cod_pedido       = b.cod_pedido
                    AND a.lin_det_pedido   = b.lin_det_pedido
                    AND a.cod_serie_pedido = v_serie_ind
                    AND b.cod_articulo     = c.cod_articulo;
                  EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                       v_tip_articulo  := 0;
               END;
               IF v_tip_articulo  =  20 THEN
               -- Inicio 45194, zmh 26-10-2007
                   SELECT to_char(max(fec_alta), 'dd-mm-yyyy hh24:mi:ss') into v_fec_alta
                   FROM al_componente_kit a , ga_aboamist b
                   WHERE a.num_kit = v_serie_ind
                   AND a.NUM_SERIE=b.NUM_SERIE;

                   BEGIN
--                       strSW := '04';
                       SELECT count(1) INTO  LN_abo_act
                       FROM al_componente_kit a , ga_aboamist b
                       WHERE a.num_kit = v_serie_ind
                       AND a.NUM_SERIE=b.NUM_SERIE
                       AND nvl(b.cod_situacion,b.cod_situacion) = 'AAA';
                   END;
                   IF LN_abo_act = 0 THEN
                      EV_strError := 'Error:  inconsistencia en tabla GA_ABOAMIST...(Validar situación del abonado)';
                      strSW := '4';
                      BEGIN
--                         strSW := '05';
                         SELECT B.NUM_ABONADO ,b.cod_situacion INTO  LN_num_abonado, LV_cod_situacion
                         FROM al_componente_kit a , ga_aboamist b
                         WHERE a.num_kit = v_serie_ind
                         AND a.NUM_SERIE=b.NUM_SERIE
                         AND fec_alta  = to_date(v_fec_alta, 'dd-mm-yyyy hh24:mi:ss');
                      END;
                      LV_strSerieNOAAA := LV_strSerieNOAAA || v_serie_ind || '(' || 'abonado:' || LN_num_abonado || ' situacion:' || LV_cod_situacion ||')' || '-';
                   END IF;
               -- Fin  45194, zmh 26-10-2007

            -- Validar que el KIT no este activo.
                   BEGIN
                      v_num_abonado := null;
--                      strSW := '06';
                      SELECT  num_abonado INTO v_num_abonado
                        FROM ga_aboamist
                        WHERE num_serie = P_Obtienenumerado_Fn(v_serie_ind)
                        AND ind_telefono > v_strIndKitAct;
                      EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                          strSW := '3';
                          v_strSerieKITActivo := v_strSerieKITActivo || v_serie_ind || '(' || 'abonado:' || v_num_abonado || ')' || '-';
-- Inicio  38996 03-04-2007
                          BEGIN
                              insert into NP_VALIDA_DEVOLSERIES_TO
                             (COD_PEDIDO, NUM_SERIE, COD_ERROR, DES_VALIDACION,  FEC_VALIDA)
                             values (v_cod_pedido, v_serie_ind, to_number(strSW), 'Kit Activo', sysdate);
                             EXCEPTION
                                WHEN OTHERS THEN
                                     null;
                          END;
-- Fin 38996
                   END;
-- inc. 45194, ZMH  26-10-2007
                ELSE
                        BEGIN
                       Select to_char(max(fec_alta), 'dd-mm-yyyy hh24:mi:ss'), count(1)
                              into v_fec_alta, LN_existe_abo
                       From ga_aboamist
                       WHERE NUM_SERIE = v_serie_ind;
--                       strSW := '07';
                       v_comando_sql := 'SELECT count(1) ';
                       v_comando_sql := v_comando_sql || ' FROM ga_aboamist b';
                       v_comando_sql := v_comando_sql || ' WHERE ind_telefono in ('|| LV_Indicador ||')';
                       v_comando_sql := v_comando_sql || ' and NUM_SERIE = ''' || v_serie_ind || '''';
                       v_comando_sql := v_comando_sql || ' AND nvl(cod_situacion,cod_situacion) = ''AAA''';
                       v_comando_sql := v_comando_sql || '    AND fec_alta = to_date(''' || v_fec_alta || ''', ''dd-mm-yyyy HH24:mi:ss'')';
                       EXECUTE IMMEDIATE v_comando_sql INTO LN_abo_act;
                    END;
                    IF LN_abo_act = 0 and LN_existe_abo > 0 THEN
                       EV_strError := 'Error: inconsistencia en tabla GA_ABOAMIST...(Validar situación del abonado)';
                       strSW := '4';
                       BEGIN
--                          strSW := '08';
                             SELECT num_abonado , cod_situacion INTO  LN_num_abonado, LV_cod_situacion
                          FROM ga_aboamist
                           WHERE NUM_SERIE=v_serie_ind
                           AND fec_alta  = to_date(v_fec_alta, 'dd-mm-yyyy hh24:mi:ss');
                       END;
                       LV_strSerieNOAAA := LV_strSerieNOAAA || v_serie_ind || '(' || 'abonado:' || LN_num_abonado || ' situacion:' || LV_cod_situacion ||')' || '-';
                    END IF;
-- fin 45194
                END IF;
            END IF;
-- Inicio  38996 03-04-2007
--            strSW := '09';
            Select count(1) into  LN_existe_serie
            From NP_VALIDA_DEVOLSERIES_TO
            Where COD_PEDIDO = v_cod_pedido
            and NUM_SERIE = v_serie_ind
            and cod_error = 0;

            If LN_existe_serie > 0 Then
               strSW := '4';
               begin
                  insert into NP_VALIDA_DEVOLSERIES_TO
                   (COD_PEDIDO, NUM_SERIE, COD_ERROR, DES_VALIDACION, FEC_VALIDA)
                  values (v_cod_pedido, v_serie_ind, strSW, 'Serie Duplicada', sysdate);
                  LV_strSerieDuplicada := LV_strSerieDuplicada || v_serie_ind || '-';
               EXCEPTION
                  WHEN OTHERS THEN
                       null;
               End;
            ELSIF strSW = '0' THEN
               v_strSerieAux := v_strSerieAux || v_serie_ind || '-';
-- Fin 38996
               insert into NP_VALIDA_DEVOLSERIES_TO
               (COD_PEDIDO, NUM_SERIE, COD_ERROR, DES_VALIDACION, FEC_VALIDA)
               values (v_cod_pedido, v_serie_ind, to_number(strSW), 'OK', sysdate);
            END IF;
            strSW := '9';
         END LOOP;

         begin
            UPDATE NP_SERIESDEVOL_TO SET
               DES_SERIENOPEDIDO  = v_strSerieNoPedido,
               DES_SERIEDEVUELTAS = v_strSerieDevueltas,
               DES_SERIEKITACTIVO = v_strSerieKITActivo,
               DES_SERIEDUPLICADA = LV_strSerieDuplicada,
-- Inicio 45194  ZMH 26-10-2007
               DES_SERABONOACTIVO = LV_strSerieNOAAA,
-- Fin 45194
               DES_SerieAux = v_strSerieAux
            WHERE COD_PEDIDO =  v_cod_pedido
            and   COD_CORRELATIVO = LN_correlativo;
            exception
               when others then
                  UPDATE  NP_SERIESDEVOL_TO SET
                  MSG_ERROR =  'Indice ' || strSW || '  UPDATE  NP_SERIESDEVOL_TO SET Serie:'||v_serie_ind || ' Pedido: ' || v_cod_pedido;
         end;

     End Loop;

     COMMIT;

     v_msgerror := '';

     EXCEPTION

     WHEN OTHERS THEN
       v_msgerror := SUBSTR('Indice  ' || strSW || ' -- ' || SQLCODE||' -ERROR- '||SQLERRM || ' Serie : ' || v_serie_ind, 1, 200) ;
            UPDATE  NP_SERIESDEVOL_TO SET
            MSG_ERROR =  v_msgerror
            WHERE COD_PEDIDO =  v_cod_pedido
            and COD_CORRELATIVO = LN_correlativo;
        commit;
  END NP_VALI_SERIEDEVOLUCION_PR;

  PROCEDURE NP_DETO_DEVOLTOTALPED_PR
  (v_cod_pedido in npt_detalle_devolucion.cod_pedido%type,
  v_DevProExi      in number,
  v_SerieKITActivo in number,
  EV_strError out nocopy varchar) IS

    cuenta number;
    existe number;
    item   number;
    cadena varchar2(20000);
    LN_can_serie     number; -- 45194  ZMH  29-10-2007
    LN_can_aboamist  number; -- 45194  ZMH  29-10-2007
    LN_can_kit       number; -- 45194  ZMH  29-10-2007
    lb_numerada    boolean;
    LN_can_no_numeradas NUMBER;
    LN_can_numeradas NUMBER;

    Cursor cLeeSeriePedido is
      select cod_serie_pedido, cod_devolucion from npt_detalle_devolucion  a
      where cod_devolucion > 0 and cod_pedido = v_cod_pedido
      and cod_serie_pedido in (select cod_serie_pedido
      FROM npt_serie_pedido  b WHERE a.cod_serie_pedido = b.cod_serie_pedido);

    Cursor cLeeSeriePedidokit is
      SELECT b.cod_articulo, c.tip_articulo, a.COD_SERIE_PEDIDO
      FROM NPT_DETALLE_DEVOLUCION A, NPT_DETALLE_PEDIDO B, AL_ARTICULOS C
      WHERE a.cod_pedido = v_cod_pedido AND a.cod_pedido = b.cod_pedido AND a.lin_det_pedido = b.lin_det_pedido
      AND b.cod_articulo = c.cod_articulo AND c.tip_articulo = 20;

    Cursor cLeeSerie is
        select cod_serie_pedido from npt_serie_pedido
        where  cod_pedido = v_cod_pedido;

    Cursor cLeeSerieNa(v_cod_pedido npt_detalle_devolucion.cod_pedido%type) is
        select a.num_serie numserie, a.num_abonado num_abonado, a.cod_situacion
        from ga_aboamist a, npt_serie_pedido b
        where a.num_serie =b.cod_serie_pedido
        and nvl(a.cod_situacion,a.cod_situacion) <>'AAA'
        and a.num_abonado = (select max(c.num_abonado) from ga_aboamist c where  a.num_serie =c.num_serie)
        and b.cod_pedido =v_cod_pedido;

    Cursor cLeeSerieKitNa(v_cod_pedido npt_detalle_devolucion.cod_pedido%type) is
        select b.num_serie numserie ,b.num_abonado num_abonado, b.cod_situacion cod_situacion
        from al_componente_kit a, ga_aboamist b, npt_serie_pedido c
        Where a.num_serie = b.num_serie
        and nvl(b.cod_situacion,b.cod_situacion) <> 'AAA'
        and b.num_abonado = (select max(c.num_abonado) from ga_aboamist c where  a.num_serie =c.num_serie)
        and a.num_kit = c.cod_serie_pedido
        and c.cod_pedido=v_cod_pedido;

  BEGIN

     cuenta := 0;
     cadena := '';
     item := 0;
     lb_numerada:=true;
     EV_strerror :='';
     LN_can_no_numeradas:=0;
     LN_can_numeradas:=0;

-- 45194, ZMH  29-10-2007

    select sum(decode (TIP_TERMINAL, 'G', CAN_DETALLE_PEDIDO, 0) + decode (TIP_ARTICULO, 20, CAN_DETALLE_PEDIDO, 0))
    into LN_can_serie
    from al_articulos a, npt_detalle_pedido b
    where a.cod_articulo = b.cod_articulo
    and b.cod_pedido = v_cod_pedido;

    select count(1) into LN_can_aboamist
    from ga_aboamist
    where num_serie in (select cod_serie_pedido from npt_serie_pedido where cod_pedido= v_cod_pedido)
    and nvl(cod_situacion,cod_situacion) ='AAA';

    if LN_can_aboamist =0 then
        select count(1) into LN_can_kit
        from al_componente_kit a, ga_aboamist b
        Where a.num_kit in (select cod_serie_pedido from npt_SERIE_pedido Where cod_pedido = v_cod_pedido)
        and a.num_serie = b.num_serie
        and nvl(b.cod_situacion,b.cod_situacion) = 'AAA';
        if LN_can_kit =0 then
           EV_strerror := ''; --'Error: no existen abonados creados para Series de la devolución, en la tabla GA_ABOAMIST...';

            SELECT COUNT(1) INTO LN_can_no_numeradas FROM AL_MOVIMIENTOS A,
            (SELECT MAX(NUM_MOVIMIENTO) NUM_MOV, NUM_SERIE FROM AL_MOVIMIENTOS
            WHERE NUM_SERIE IN (SELECT COD_SERIE_PEDIDO FROM NPT_SERIE_PEDIDO
            WHERE COD_PEDIDO=v_cod_pedido) GROUP BY NUM_SERIE) B
            WHERE A.NUM_MOVIMIENTO=B.NUM_MOV AND NUM_TELEFONO IS NULL;

            SELECT COUNT(1) INTO LN_can_numeradas FROM AL_MOVIMIENTOS A,
            (SELECT MAX(NUM_MOVIMIENTO) NUM_MOV, NUM_SERIE FROM AL_MOVIMIENTOS
            WHERE NUM_SERIE IN (SELECT COD_SERIE_PEDIDO FROM NPT_SERIE_PEDIDO
            WHERE COD_PEDIDO=v_cod_pedido) GROUP BY NUM_SERIE) B
            WHERE A.NUM_MOVIMIENTO=B.NUM_MOV AND NUM_TELEFONO IS NOT NULL;

            IF LN_can_no_numeradas>0 then
               lb_numerada:=false;
               if LN_can_no_numeradas <> LN_can_serie then
               ------------------inicio cambio----------------------------------------------------------
                SELECT COUNT(1) INTO LN_can_numeradas FROM AL_MOVIMIENTOS A,
                (SELECT MAX(NUM_MOVIMIENTO) NUM_MOV, NUM_SERIE FROM AL_MOVIMIENTOS
                WHERE NUM_SERIE IN (SELECT COD_SERIE_PEDIDO FROM NPT_SERIE_PEDIDO
                WHERE COD_PEDIDO=v_cod_pedido) GROUP BY NUM_SERIE) B
                WHERE A.NUM_MOVIMIENTO=B.NUM_MOV AND NUM_TELEFONO IS NULL;
                
                 if LN_can_numeradas>0 then
                  cuenta:=0;
                  FOR vLeeSerie IN cLeeSerie
                    LOOP
                     existe := 0;
                     
                        SELECT count(1) into existe
                        FROM npt_estado_devolucion a, npt_detalle_devolucion b
                        WHERE a.cod_devolucion = b.cod_devolucion
                        AND b.COD_SERIE_PEDIDO = vLeeSerie.cod_serie_pedido
                        AND a.cod_estado_flujo in (54, 5, 92)    -- P-MIX-09003-Guatemala-Salvador
                        And a.FEC_CRE_EST_DEVOLUCION = (Select max(FEC_CRE_EST_DEVOLUCION) From npt_estado_devolucion c Where a.cod_devolucion = c.cod_devolucion);   -- P-MIX-09003-Guatemala-Salvador

                    
                        if existe > 0 then
                            cuenta := cuenta + 1;
                            cadena := cadena || vLeeSerie.cod_serie_pedido || '-';
                        end if;
                        
                    end loop;
                    
                     if cuenta >0 then
                                item := item + 1;
                                insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                                values (v_cod_pedido, item, 1, cuenta, cadena);
                                cadena := '';
                                cuenta := 0;
                                existe := 0;
                      end if;
                    
                 else
                   EV_strerror := 'Error: Algunas series se encuentran numeradas.';
                   insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                   values (v_cod_pedido, item, 3, LN_can_aboamist, 'Para el Pedido: ' || v_cod_pedido || '. El total de series es: ' || LN_can_serie || ', total de series No numeradas: ' || LN_can_aboamist||'-');

                 end if;
                -------------------------------fin modificacion----------------------------------------------
                   --EV_strerror := 'Error: Algunas series se encuentran numeradas.';
                   --insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                   --values (v_cod_pedido, item, 3, LN_can_aboamist, 'Para el Pedido: ' || v_cod_pedido || '. El total de series es: ' || LN_can_serie || ', total de series No numeradas: ' || LN_can_aboamist||'-');
               end if;
               LN_can_aboamist:=LN_can_no_numeradas;
            else
               if LN_can_numeradas>0 then
                  lb_numerada:=true;
                   if LN_can_numeradas <> LN_can_serie then
                       EV_strerror := 'Error: Algunas series se encuentran numeradas.';
                       insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                       values (v_cod_pedido, item, 3, LN_can_aboamist, 'Para el Pedido: ' || v_cod_pedido || '. El total de series es: ' || LN_can_serie || ', total de series No numeradas: ' || LN_can_aboamist||'-');
                   end if;
               end if;
               LN_can_aboamist:=LN_can_numeradas;
            end if;
       else
            LN_can_aboamist := LN_can_kit;
        end if;
    end if;


    if  LN_can_serie = LN_can_aboamist then
            FOR vLeeSerie IN cLeeSerie
            LOOP
                existe := 0;

                SELECT count(1) into existe
                FROM npt_estado_devolucion a, npt_detalle_devolucion b
                WHERE a.cod_devolucion = b.cod_devolucion
                AND b.COD_SERIE_PEDIDO = vLeeSerie.cod_serie_pedido
    --            AND a.cod_estado_flujo in (v_DevProExi, 54, 5);  -- P-MIX-09003-Guatemala-Salvador
                AND a.cod_estado_flujo in (54, 5, 92)    -- P-MIX-09003-Guatemala-Salvador
                And a.FEC_CRE_EST_DEVOLUCION = (Select max(FEC_CRE_EST_DEVOLUCION) From npt_estado_devolucion c Where a.cod_devolucion = c.cod_devolucion);   -- P-MIX-09003-Guatemala-Salvador

                if existe > 0 then
                    cuenta := cuenta + 1;
                    cadena := cadena || vLeeSerie.cod_serie_pedido || '-';
                    if cuenta = 150 then
                        item := item + 1;
                        insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                        values (v_cod_pedido, item, 1, cuenta, cadena);
                        cadena := '';
                        cuenta := 0;
                    end if;
                end if;
            end loop;
            if cuenta > 0 then
                item := item + 1;
                insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                values (v_cod_pedido, item, 1, cuenta, cadena);
            end if;
            cadena := '';
            cuenta := 0;

   else
     if trim(EV_strerror)<>'' then
           EV_strerror := 'Error: de inconsistencia de cantidades de series activas para la devolución (No se permite una devolucion Total...)';
            insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
            values (v_cod_pedido, item, 3, LN_can_aboamist, 'Para el Pedido: ' || v_cod_pedido || '. El total de series es: ' || LN_can_serie || ', total de series Activas: ' || LN_can_aboamist||'-');
      end if;
    end if;


    if lb_numerada then
        FOR vLeeSerieNa IN cLeeSerieNa(v_cod_pedido)
            LOOP
                existe := 0;
                select count(1) into existe
                from ga_aboamist where num_serie =vLeeSerieNa.numserie
                and cod_situacion <> 'AAA';
                if existe > 0 then
                    cuenta := cuenta + 1;
                    cadena := cadena || vLeeSerieNa.numserie || ' (' || 'abonado:' || vLeeSerieNa.num_abonado || ' situacion:' || vLeeSerieNa.cod_situacion ||')' || '-';
                    if cuenta = 50 then
                        item := item + 1;
                        insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                        values (v_cod_pedido, item, 3, cuenta, cadena);
                        cadena := '';
                        cuenta := 0;
                    end if;
                end if;

            end loop;
            if cuenta > 0 then
                item := item + 1;
                insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                values (v_cod_pedido, item, 3, cuenta, cadena);
            end if;
            cadena := '';
            cuenta := 0;

            FOR vLeeSerieKitNa IN cLeeSerieKitNa(v_cod_pedido)
            LOOP
                existe := 0;
                select count(1) into existe
                from ga_aboamist where num_serie =vLeeSerieKitNa.numserie
                and cod_situacion <> 'AAA';
                if existe > 0 then
                    cuenta := cuenta + 1;
                    cadena := cadena || vLeeSerieKitNa.numserie || ' (' || 'abonado:' || vLeeSerieKitNa.num_abonado || ' situacion:' || vLeeSerieKitNa.cod_situacion ||')' || '-';
                    if cuenta = 50 then
                        item := item + 1;
                        insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                        values (v_cod_pedido, item, 3, cuenta, cadena);
                        cadena := '';
                        cuenta := 0;
                    end if;
                end if;

            end loop;
            if cuenta > 0 then
                item := item + 1;
                insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                values (v_cod_pedido, item, 3, cuenta, cadena);
            end if;
            cadena := '';
            cuenta := 0;

    -- Fin 45194
    end if;


     FOR vLeeSeriePedido IN cLeeSeriePedido
     LOOP
        existe := 0;
        SELECT count(1) into existe
        FROM npt_estado_devolucion a
        WHERE cod_devolucion = vLeeSeriePedido.cod_devolucion
--        AND cod_estado_flujo in (v_DevProExi, 17); -- estado 17 que representa el que un pedido ya se haya rechazado
--        AND cod_estado_flujo in (v_DevProExi, 54, 5); -- 45194  ZMH   29-10-2007
        AND a.cod_estado_flujo in ( 54, 5, 92)  -- P-MIX-09003-Guatemala-Salvador
        AND a.FEC_CRE_EST_DEVOLUCION = (Select max(FEC_CRE_EST_DEVOLUCION) From npt_estado_devolucion c Where a.cod_devolucion = c.cod_devolucion); --  P-MIX-09003-Guatemala-Salvador
        if existe = 0 then
          cuenta := cuenta + 1;
          cadena := cadena || vLeeSeriePedido.cod_serie_pedido || '-';
          if cuenta = 150 then
             item := item + 1;
             insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
             values (v_cod_pedido, item, 1, cuenta, cadena);
             commit;
             cadena := '';
             cuenta := 0;
          end if;
       end if;
     end loop;
     if cuenta > 0 then
        item := item + 1;
        insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
        values (v_cod_pedido, item, 1, cuenta, cadena);
        commit;
     end if;
     cadena := '';
     cuenta := 0;

     if lb_numerada then
         FOR vLeeSeriePedidokit IN cLeeSeriePedidokit
         LOOP
             existe := 0;
             select count(1) into existe from ga_aboamist
             where num_serie = P_OBTIENENUMERADO_FN(vLeeSeriePedidokit.COD_SERIE_PEDIDO)
             and ind_telefono > v_SerieKITActivo;
             if existe > 0 then
                cuenta := cuenta + 1;
                cadena := cadena || vLeeSeriePedidokit.cod_serie_pedido || '-';
                if cuenta = 130 then
                   item := item + 1;
                   insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
                   values (v_cod_pedido, item, 2, cuenta, cadena);
                   commit;
                   cadena := '';
                   cuenta := 0;
                end if;
             end if;
         end loop;
         if cuenta > 0 then
            item := item + 1;
             insert into NP_SERIESACEPTA_TO (COD_PEDIDO, COD_DEVOLUCION, LIN_DETALLE, TOT_SERIES, DET_SERIE)
             values (v_cod_pedido, item, 2, cuenta, cadena);
            commit;
         end if;
    end if;

  END NP_DETO_DEVOLTOTALPED_PR;

  PROCEDURE NP_ALDE_DEVOLTOTAL_PR (
    v_cod_Devolucion in npt_detalle_devolucion.cod_devolucion%type,
    v_cod_pedido     in npt_detalle_devolucion.cod_pedido%TYPE,
    v_cod_TipoDev    in npt_detalle_devolucion.cod_tipo_devolucion%type) IS

    Cursor cLeeSeriePedido is
      select lin_det_pedido, cod_serie_pedido, ind_telefono
      from npt_serie_pedido
      where cod_pedido = v_cod_pedido;

    Cursor cLeedetPedido is
      select lin_det_pedido, can_asig_detalle_pedido
      from npt_detalle_pedido
      where cod_pedido = v_cod_pedido
      and lin_det_pedido not in
          (select lin_det_pedido from npt_serie_pedido
           where cod_pedido = v_cod_pedido);


    linDetDev number;
    indSeriad number;

  BEGIN
     linDetDev := 1;
     begin
        select count(*) + 1 into linDetDev
        from npt_detalle_devolucion
        where cod_devolucion = v_cod_devolucion;
           exception
              when others then
                   linDetDev := 1;
     end;
     indSeriad := 1;

     FOR vLeeSeriePedido IN cLeeSeriePedido
     LOOP
           Select IND_SERIADO into indSeriad
        From al_articulos
        where cod_articulo = (Select cod_articulo from npt_detalle_pedido
                               Where cod_pedido = v_cod_pedido
                               and   lin_det_pedido = vLeeSeriePedido.lin_det_pedido);


        insert into npt_detalle_devolucion (cod_devolucion, lin_det_devolucion, cod_pedido, lin_det_pedido,
          ind_seriado, can_det_devolucion, cod_serie_pedido, cod_tipo_devolucion, ind_telefono)
        values (v_cod_devolucion, linDetDev, v_cod_pedido, vLeeSeriePedido.lin_det_pedido, indSeriad,
                '', vLeeSeriePedido.cod_serie_pedido, v_cod_TipoDev, vLeeSeriePedido.ind_telefono);
        commit;
        linDetDev := linDetDev + 1;
     End Loop;

     FOR vLeedetPedido IN cLeedetPedido
     LOOP

        Select IND_SERIADO into indSeriad
        From al_articulos
        where cod_articulo = (Select cod_articulo from npt_detalle_pedido
                               Where cod_pedido = v_cod_pedido
                               and   lin_det_pedido = vLeedetPedido.lin_det_pedido);


        insert into npt_detalle_devolucion
          (cod_devolucion, lin_det_devolucion, cod_pedido, lin_det_pedido, ind_seriado, can_det_devolucion,
           cod_serie_pedido, cod_tipo_devolucion, ind_telefono)
        values
          (v_cod_devolucion, linDetDev, v_cod_pedido, vLeedetPedido.lin_det_pedido, indSeriad, vLeedetPedido.can_asig_detalle_pedido,
           '', v_cod_TipoDev, '');
        commit;
        linDetDev := linDetDev + 1;
     End Loop;
  END NP_ALDE_DEVOLTOTAL_PR;

  PROCEDURE NP_ALDE_DEVOLPARCIAL_PR (
    v_cod_Devolucion in npt_detalle_devolucion.cod_devolucion%type,
    v_cod_pedido    in npt_detalle_devolucion.cod_pedido%TYPE,
    v_cod_TipoDev   in npt_detalle_devolucion.cod_tipo_devolucion%type) IS

    indSeriad number;
    inpos     number;
    v_lin_det_pedido npt_serie_pedido.lin_det_pedido%type;
    v_ind_telefono   npt_serie_pedido.ind_telefono%type;
    v_LIN_DETALLE    NP_SERIESACEPTA_TO.LIN_DETALLE%type;
    v_DET_SERIE      NP_SERIESACEPTA_TO.DET_SERIE%type;
    v_cod_Serie      npt_serie_pedido.cod_serie_pedido%type;

    Cursor cLeeSeriePedido is
      select *      from NP_SERIESACEPTA_TO
      where COD_PEDIDO =  v_cod_pedido
      order by COD_PEDIDO, COD_DEVOLUCION;
  BEGIN

     FOR vLeeSeriePedido IN cLeeSeriePedido
     LOOP

        indSeriad := 1;
        inpos := 1;
        begin
           v_LIN_DETALLE := 1;
           select count(*) + 1 into v_LIN_DETALLE
           from npt_detalle_devolucion
           where cod_devolucion = v_cod_devolucion;
              exception
                 when others then
                      v_LIN_DETALLE := 1;
        end;

        v_DET_SERIE   := vLeeSeriePedido.DET_SERIE;

        if '|' = substr(v_DET_SERIE, length(v_DET_SERIE), 1) then
           v_DET_SERIE := substr(v_DET_SERIE, 1, length(v_DET_SERIE)- 1);
        end if;

        loop
           exit when inpos = 0;

           inpos := instr(v_DET_SERIE, '|');
           if inpos > 0 then
              v_cod_Serie := substr(v_DET_SERIE, 1, inpos-1);
              v_DET_SERIE := substr(v_DET_SERIE, inpos + 1, length(v_DET_SERIE) - inpos);
           else
              v_cod_Serie := v_DET_SERIE;
              v_DET_SERIE := '';
              inpos := 0;
           end if;

           begin
              select lin_det_pedido, ind_telefono into v_lin_det_pedido, v_ind_telefono
              from npt_serie_pedido
              where cod_pedido = v_cod_pedido
                and cod_serie_pedido = v_cod_Serie;
              exception
                 when no_data_found then
                    v_lin_det_pedido := 0;
                    v_ind_telefono := '';
           end;

            Select IND_SERIADO into indSeriad
            From al_articulos
            where cod_articulo = (Select cod_articulo from npt_detalle_pedido
                  Where cod_pedido = v_cod_pedido
                  and   lin_det_pedido = v_lin_det_pedido);

           insert into npt_detalle_devolucion
              (cod_devolucion, lin_det_devolucion, cod_pedido, lin_det_pedido, ind_seriado, can_det_devolucion,
               cod_serie_pedido, cod_tipo_devolucion, ind_telefono)
           values
              (v_cod_devolucion, v_LIN_DETALLE, v_cod_pedido, v_lin_det_pedido, indSeriad, '',
               v_cod_Serie, v_cod_TipoDev, v_ind_telefono );
           commit;

           v_LIN_DETALLE := v_LIN_DETALLE + 1;

        end loop;
     end loop;

END NP_ALDE_DEVOLPARCIAL_PR;

PROCEDURE NP_SEDE_VALIDASERIESDEV_PR
(EN_cod_devolucion in NPT_DEVOLUCION.cod_devolucion%TYPE) IS
/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "NP_SEDE_VALIDASERIESDEV_PR" Lenguaje="PL/SQL" Fecha="18-08-2006" Versión="1.0.0" Diseñador="Ingrid Cabrera" Programador="Ingrid Cabrera" Ambiente="BD">
<Retorno>EV_strError </Retorno>
<Descripción>Procedimiento encargado de validar las series para el ingreso de devoluciones web </Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_cod_devolucion" Tipo="Number">Código de Devolución</param>
    </Entrada>
    <Salida>
        <param nom="EV_strError" Tipo="STRING">Descripción del error en el procedimiento</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/


Cursor LEESERIES_KIT (LN_Devolucion in NPT_DEVOLUCION.cod_devolucion%TYPE)
   IS
-- Inicio: 35803, Descipción: Actualización de series kit en estado distinto de 'AAA', fecha: 29-11-2006, resp: Zenén Muñoz H.
    SELECT b.cod_serie_pedido, c.num_serie
    FROM npt_detalle_devolucion b, al_componente_kit c
    where b.cod_devolucion=LN_Devolucion
    and b.COD_SERIE_PEDIDO = c.num_kit
    and nvl(b.cod_devolucion, b.cod_devolucion) > 0
    and c.cod_articulo in (select cod_articulo from al_articulos
    where IND_SERIADO = 1 and TIP_TERMINAL = 'G');
-- Fin 35803

Cursor LEESERIES (LN_Devolucion in NPT_DEVOLUCION.cod_devolucion%TYPE)
   IS
      SELECT num_serie, num_abonado ,cod_situacion FROM ga_aboamist
      where num_serie in (select COD_SERIE_PEDIDO from npt_detalle_devolucion
                          where cod_devolucion = LN_Devolucion)
      and cod_situacion <> 'AAA';

-- Inicio 42002, 05-07-2007  Z.M.H.
Cursor SERIENOPEDIDO (LN_Devolucion in NPT_DEVOLUCION.cod_devolucion%TYPE)
   IS
SELECT a.cod_serie_pedido
FROM npt_detalle_devolucion a
where not exists (select 1 from npt_serie_pedido b
                  where a.cod_pedido = b.cod_pedido
      and a.cod_serie_pedido = b.cod_serie_pedido)
and a.cod_serie_pedido is not null
and cod_devolucion = LN_Devolucion;
-- fin 42002


Cursor PEDIDOENDEVOLUCION (LN_Devolucion in NPT_DEVOLUCION.cod_devolucion%TYPE)
   IS
SELECT distinct a.cod_pedido
FROM npt_detalle_devolucion a
where cod_devolucion = LN_Devolucion;


Cursor SERIEENPEDIDO (LN_Devolucion in NPT_DEVOLUCION.cod_devolucion%TYPE, LN_Pedido in NPT_DETALLE_DEVOLUCION.cod_pedido%TYPE)
   IS
SELECT a.cod_serie_pedido, a.cod_pedido
FROM npt_detalle_devolucion a
where cod_devolucion = LN_Devolucion
and   cod_pedido = LN_Pedido;


LV_SeriesAbo     NP_SERIESDEVOL_TO.DES_SERABONOACTIVO%type;
LN_CORRELATIVO   number := 0;
LN_EXISTE        number := 0;
LN_Abonado       GA_ABOAMIST.NUM_ABONADO%TYPE;
LN_CLIENTE       npt_pedido.COD_CLIENTE%type;
TN_TIP_MOVIMIENTO    AL_MOVIMIENTOS.TIP_MOVIMIENTO%type;
LN_MAYORISTA      number := 0;
LN_IND_TELEFONO    ga_abocel.IND_TELEFONO%TYPE := '0';
LV_strError      varchar2(200);

BEGIN

   LV_SeriesAbo := '';
   LV_strError := '';

   select count(1) + 1 into LN_CORRELATIVO
   from NP_SERIESDEVOL_TO
   where cod_pedido = EN_cod_devolucion;

   for vLEESERIES in LEESERIES_KIT(EN_cod_devolucion) loop
-- Inicio: 35803, Descipción: Actualización de series kit en estado distinto de 'AAA', fecha: 29-11-2006, resp: Zenén Muñoz H.
      select count(1) into LN_EXISTE
      from ga_aboamist
      where num_serie = vLEESERIES.num_serie
      and   cod_situacion = 'AAA';
      if LN_EXISTE = 0 then
-- Fin: 35803
         select max(num_abonado) into LN_Abonado
         from ga_aboamist
         where num_serie = vLEESERIES.num_serie
         and   cod_situacion <> 'AAA';

         LV_SeriesAbo := LV_SeriesAbo || vLEESERIES.num_serie || '(' || 'abonado:' || LN_Abonado || ' situación <> AAA)' || '-';
         if length(LV_SeriesAbo) > 3000 then
            LN_CORRELATIVO := LN_CORRELATIVO + 1;
            insert into NP_SERIESDEVOL_TO
               (cod_pedido, COD_CORRELATIVO, DES_SERABONOACTIVO, MSG_ERROR)
            values (EN_cod_devolucion, LN_CORRELATIVO, LV_SeriesAbo, 'Error de serie que existe en tabla Ga_aboamist');
            LV_SeriesAbo := '';
         end if;
      end if;
   end loop;

   for vLEESERIES in LEESERIES(EN_cod_devolucion) loop
-- Inicio: 35803, Descipción: Actualización de series kit en estado distinto de 'AAA', fecha: 29-11-2006, resp: Zenén Muñoz H.
      select count(1) into LN_EXISTE
      from ga_aboamist
      where num_serie = vLEESERIES.num_serie
      and   cod_situacion = 'AAA';
      if LN_EXISTE = 0 then
-- Fin: 35803
         LV_SeriesAbo := LV_SeriesAbo || vLEESERIES.num_serie || '(' || 'abonado:' || vLEESERIES.num_abonado || ' situación:' || vLEESERIES.cod_situacion || ')' || '-';
         if length(LV_SeriesAbo) > 3000 then
            LN_CORRELATIVO := LN_CORRELATIVO + 1;
            insert into NP_SERIESDEVOL_TO
               (cod_pedido, COD_CORRELATIVO, DES_SERABONOACTIVO, MSG_ERROR)
            values (EN_cod_devolucion, LN_CORRELATIVO, LV_SeriesAbo, 'Error de serie que existe en tabla Ga_aboamist');
            LV_SeriesAbo := '';
         end if;
      end if;
   end loop;

   if length(LV_SeriesAbo) > 0 then
      LN_CORRELATIVO := LN_CORRELATIVO + 1 ;

      insert into NP_SERIESDEVOL_TO
         (cod_pedido, COD_CORRELATIVO, DES_SERABONOACTIVO, MSG_ERROR)
      values (EN_cod_devolucion, LN_CORRELATIVO, LV_SeriesAbo, 'Error de serie que existe en tabla Ga_aboamist');
      LV_SeriesAbo := '';
   end if;

-- Inicio 42002  06-0/-2007 Z.M.H.
   LV_SeriesAbo := '';
   For vSERIENOPEDIDO in SERIENOPEDIDO(EN_cod_devolucion) loop
         LV_SeriesAbo := LV_SeriesAbo || vSERIENOPEDIDO.cod_serie_pedido || '(Serie no existe en el pedido)-';
         if length(LV_SeriesAbo) > 3000 then
            LN_CORRELATIVO := LN_CORRELATIVO + 1;
            insert into NP_SERIESDEVOL_TO
               (cod_pedido, COD_CORRELATIVO, DES_SERABONOACTIVO, MSG_ERROR)
            values (EN_cod_devolucion, LN_CORRELATIVO, LV_SeriesAbo, 'Error de serie que no existe');
            LV_SeriesAbo := '';
         end if;
   End loop;

   If length(LV_SeriesAbo) > 0 then
      LN_CORRELATIVO := LN_CORRELATIVO + 1 ;
      insert into NP_SERIESDEVOL_TO
         (cod_pedido, COD_CORRELATIVO, DES_SERABONOACTIVO, MSG_ERROR)
      values (EN_cod_devolucion, LN_CORRELATIVO, LV_SeriesAbo, 'Error de serie que no existe');
   End if;
-- fin 42002
   LV_SeriesAbo := '';
   for vPEDIDOENDEVOLUCION in PEDIDOENDEVOLUCION(EN_cod_devolucion) loop
      select cod_cliente into LN_CLIENTE from npt_pedido
      where cod_pedido = vPEDIDOENDEVOLUCION.cod_pedido;
-- valida si Cliente es un Mayorista.
      NP_GESTOR_MAYORISTAS_PG.NP_CLIENTE_MAYORISTA_PR (LN_CLIENTE, LN_MAYORISTA, LV_strError);
      if LN_MAYORISTA = 1 then
         for vSERIEENPEDIDO in SERIEENPEDIDO(EN_cod_devolucion, vPEDIDOENDEVOLUCION.cod_pedido) loop
             begin
                Select nvl(ind_telefono, 0) into LN_IND_TELEFONO from ga_aboamist
                where num_serie = vSERIEENPEDIDO.COD_SERIE_PEDIDO
                union
                Select nvl(ind_telefono, 0)  from ga_aboamist
                where num_serie  in (Select num_serie  from al_componente_kit
                where Num_kit = vSERIEENPEDIDO.COD_SERIE_PEDIDO
                and IND_TELEFONO > 0);

                SELECT count(1) into LN_IND_TELEFONO FROM npt_parametro
                WHERE ALIAS_PARAMETRO = 'SER_VALIDA'
                and VALOR_PARAMETRO like '%' || trim(to_char(LN_IND_TELEFONO)) || '%';

                if LN_IND_TELEFONO = 0 then
                   LV_SeriesAbo := LV_SeriesAbo || vSERIEENPEDIDO.COD_SERIE_PEDIDO || '( Serie, con indicador de telefono no valido )' || '-';
                end if;
                LN_IND_TELEFONO := 1;
             exception
               when others then
                  null;
                  LN_IND_TELEFONO := 0;
             end;
             if LN_IND_TELEFONO = 0 then
                 SELECT MIN(TIP_MOVIMIENTO) INTO TN_TIP_MOVIMIENTO
                FROM AL_MOVIMIENTOS
                   WHERE NUM_SERIE = vSERIEENPEDIDO.COD_SERIE_PEDIDO
                   AND FEC_MOVIMIENTO  = (SELECT MAX (FEC_MOVIMIENTO) FROM AL_MOVIMIENTOS
                WHERE NUM_SERIE = vSERIEENPEDIDO.COD_SERIE_PEDIDO);
                   if TN_TIP_MOVIMIENTO = 3 then
                   LV_SeriesAbo := LV_SeriesAbo || vSERIEENPEDIDO.COD_SERIE_PEDIDO || '( Serie posee Salida Definitiva )' || '-';
                   end if;
             end if;
             if length(LV_SeriesAbo) > 3000 then
                LN_CORRELATIVO := LN_CORRELATIVO + 1 ;
                insert into NP_SERIESDEVOL_TO
                      (cod_pedido, COD_CORRELATIVO, DES_SERABONOACTIVO, MSG_ERROR)
                values (EN_cod_devolucion, LN_CORRELATIVO, LV_SeriesAbo, 'Error de serie que no existe');
                LV_SeriesAbo := '';
             end if;
         end loop;
         If length(LV_SeriesAbo) > 0 then
            LN_CORRELATIVO := LN_CORRELATIVO + 1 ;
            insert into NP_SERIESDEVOL_TO
                (cod_pedido, COD_CORRELATIVO, DES_SERABONOACTIVO, MSG_ERROR)
            values (EN_cod_devolucion, LN_CORRELATIVO, LV_SeriesAbo, 'Error de serie que no existe');
            LV_SeriesAbo := '';
         End if;
      end if;
   end loop;


 EXCEPTION
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-28199,to_char(SQLCODE) ||' ' ||SQLERRM || ' ' || LV_strError);

END NP_SEDE_VALIDASERIESDEV_PR;

END NP_DEVOLUCIONSERIES_PG;
