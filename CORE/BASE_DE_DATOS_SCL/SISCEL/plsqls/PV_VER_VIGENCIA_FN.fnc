CREATE OR REPLACE FUNCTION PV_VER_VIGENCIA_FN(
        pplantarifa     IN   VARCHAR2,
        pcodservicio    IN   VARCHAR2,
        ptiporelacion   IN   VARCHAR2,
        vFecDesde       IN   DATE,
        vFecHasta       IN   DATE,
        nCodMensaje     IN   NUMBER,
        fnInd_accion    IN   NUMBER
)
RETURN VARCHAR2 -- datos que vienen de la llamada por VB
IS
        vfecsys          DATE;
        vResp            VARCHAR2(100);
        vpplantarifa     gad_servsup_plan.cod_plantarif%TYPE; -- datos que se asignan desde la base de datos
        vpcodservicio    gad_servsup_plan.cod_servicio%TYPE;
        vptiporelacion   gad_servsup_plan.tip_relacion%TYPE;
        dAFecDesde       GAD_SERVSUP_PLAN.FEC_DESDE%TYPE;
        dAFecHasta       GAD_SERVSUP_PLAN.FEC_HASTA%TYPE;
        vFormato2        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormato7        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vExiste          VARCHAR2(6);
/*
        CURSOR cr_ssplanes IS
        SELECT fec_desde, fec_hasta
          FROM gad_servsup_plan
         WHERE cod_producto = 1
           AND cod_plantarif = pplantarifa
           AND cod_servicio = pcodservicio
           AND tip_relacion = ptiporelacion;
*/
        CURSOR CR_SSPLAN_VIGENTE IS
        SELECT FEC_DESDE, FEC_HASTA
          FROM GAD_SERVSUP_PLAN
         WHERE COD_PRODUCTO = 1
           AND COD_PLANTARIF = pPlanTarifa
           AND COD_SERVICIO = pCodServicio
           AND TIP_RELACION = pTipoRelacion
           AND FEC_DESDE <= SYSDATE;

        CURSOR CR_SSPLAN_FUTURO IS
        SELECT FEC_DESDE, FEC_HASTA
          FROM GAD_SERVSUP_PLAN
         WHERE COD_PRODUCTO = 1
           AND COD_PLANTARIF = pPlanTarifa
           AND COD_SERVICIO = pCodServicio
           AND TIP_RELACION = pTipoRelacion
           AND FEC_DESDE > SYSDATE;

        FIN_PROCESO EXCEPTION;
        vAccion         VARCHAR2(10);
BEGIN
/* INI COL|36787|07/03/2007|SAQL */
--        vFormato2 := GE_FN_DEVVALPARAM('GA', 1, 'FORMATO_SEL2');
--        vFormato7 := GE_FN_DEVVALPARAM('GA', 1, 'FORMATO_SEL7');
        vFormato2 := GE_FN_DEVVALPARAM('GE', 1, 'FORMATO_SEL2');
        vFormato7 := GE_FN_DEVVALPARAM('GE', 1, 'FORMATO_SEL7');
/* INI COL|36787|07/03/2007|SAQL */
        vResp := 'TRUE';
        vExiste := 'FALSE';
        vAccion := NULL;

        SELECT SYSDATE
          INTO vFecSys
          FROM DUAL; -- ASIGNO FECHA

        OPEN CR_SSPLAN_VIGENTE;
        LOOP
                FETCH CR_SSPLAN_VIGENTE
                 INTO dAFecDesde, dAFecHasta;
                EXIT WHEN CR_SSPLAN_VIGENTE%NOTFOUND;

                vExiste := 'TRUE';

                IF vFecDesde < dAFecHasta --Hay traslape de Registros
                THEN
                        IF fnInd_accion = 1
                        THEN
                                BEGIN
                                        IF vFecDesde = dAFecDesde THEN
                                                UPDATE GAD_SERVSUP_PLAN
                                                   SET FEC_HASTA = SYSDATE
                                                 WHERE COD_PRODUCTO = 1
                                                   AND COD_PLANTARIF = pPlanTarifa
                                                   AND COD_SERVICIO = pCodServicio
                                                   AND TIP_RELACION = pTipoRelacion
                                                   AND FEC_DESDE = dAFecDesde;
                                                vAccion := 'MODIFICAR';
                                        ELSE
                                                -- Damos de Baja el Antiguo
                                                UPDATE GAD_SERVSUP_PLAN
                                                   SET FEC_HASTA = vFecDesde
                                                 WHERE COD_PRODUCTO = 1
                                                   AND COD_PLANTARIF = pPlanTarifa
                                                   AND COD_SERVICIO = pCodServicio
                                                   AND TIP_RELACION = pTipoRelacion
                                                   AND FEC_DESDE = dAFecDesde;
                                                IF vAccion IS NULL THEN
                                                        vAccion := 'INSERTAR';
                                                END IF;
                                        END IF;
                                        vResp := 'TRUE|07|modificar registro con fecha '||TO_CHAR(dAFecDesde,vformato2||' '||vformato7);
                                EXCEPTION
                                        WHEN OTHERS
                                        THEN
                                                CLOSE CR_SSPLAN_VIGENTE;
                                                vResp := 'ERROR|'||SQLERRM;
                                                RAISE FIN_PROCESO;
                                END;
                        ELSE
                                CLOSE CR_SSPLAN_VIGENTE;
                                vResp := 'FALSE|07|modificar registro con fecha '||TO_CHAR(dAFecDesde,vformato2||' '||vformato7);
                                RAISE FIN_PROCESO;
                        END IF;
                END IF;
        END LOOP;
        CLOSE CR_SSPLAN_VIGENTE;

        OPEN CR_SSPLAN_FUTURO;
        LOOP
                FETCH CR_SSPLAN_FUTURO
                 INTO dAFecDesde, dAFecHasta;
                EXIT WHEN CR_SSPLAN_FUTURO%NOTFOUND;

                vExiste := 'TRUE';

                IF (dAFecDesde >= vFecDesde AND --Hay traslape de Registros
                    dAFecDesde <  vFecHasta) OR
                   (dAFecDesde <= vFecDesde AND
                    dAFecHasta >  vFecDesde)
                THEN
                        IF fnInd_accion = 1
                        THEN
                                BEGIN
                                        -- Damos de Baja el Antiguo Borrando
                                        DELETE GAD_SERVSUP_PLAN
                                         WHERE COD_PRODUCTO = 1
                                           AND COD_PLANTARIF = pPlanTarifa
                                           AND COD_SERVICIO = pCodServicio
                                           AND TIP_RELACION = pTipoRelacion
                                           AND FEC_DESDE = dAFecDesde;
                                        vResp := 'TRUE|08|eliminar registro';
                                        IF vAccion IS NULL THEN
                                                vAccion := 'INSERTAR';
                                        END IF;
                                EXCEPTION
                                        WHEN OTHERS
                                        THEN
                                                CLOSE CR_SSPLAN_FUTURO;
                                                vResp := 'ERROR|'||SQLERRM;
                                                RAISE FIN_PROCESO;
                                END;
                        ELSE
                                CLOSE CR_SSPLAN_FUTURO;
                                vResp := 'FALSE|08|eliminar registro';
                                RAISE FIN_PROCESO;
                        END IF;
                END IF;
        END LOOP;
        CLOSE CR_SSPLAN_FUTURO;

        IF fnInd_accion = 1
        THEN
                BEGIN
                        IF vAccion = 'INSERTAR' OR vAccion IS NULL THEN
                                INSERT INTO GAD_SERVSUP_PLAN
                                (COD_PRODUCTO, COD_PLANTARIF, COD_SERVICIO,
                                         TIP_RELACION, FEC_DESDE, FEC_HASTA,
                                         COD_MENSAJE, NOM_USUARIO, FEC_ULTMOD)
                                VALUES
                                        (1, pPlanTarifa, pCodServicio,
                                         pTipoRelacion, vFecDesde, vFecHasta,
                                         nCodMensaje, USER, SYSDATE);
                        ELSIF vAccion = 'MODIFICAR' THEN
                                INSERT INTO GAD_SERVSUP_PLAN
                                (COD_PRODUCTO, COD_PLANTARIF, COD_SERVICIO,
                                         TIP_RELACION, FEC_DESDE, FEC_HASTA,
                                         COD_MENSAJE, NOM_USUARIO, FEC_ULTMOD)
                                VALUES
                                        (1, pPlanTarifa, pCodServicio,
                                         pTipoRelacion, SYSDATE, vFecHasta,
                                         nCodMensaje, USER, SYSDATE);
                        END IF;
                EXCEPTION
                        WHEN OTHERS
                        THEN
                                vResp := 'ERROR|'||SQLERRM;
                                RAISE FIN_PROCESO;
                END;
        END IF;

        RAISE FIN_PROCESO;

EXCEPTION
        WHEN FIN_PROCESO
        THEN

        /*
        OPEN cr_ssplanes;

        LOOP
                FETCH cr_ssplanes
                 INTO vvfecdesde, vvfechasta; -- VARIABLES DE ENTRADA
                EXIT WHEN cr_ssplanes%NOTFOUND;

                vExiste := 'TRUE';

                IF vfecdesde < vvfecdesde AND vfechasta <= vvfechasta AND vfecsys < vfecdesde
                THEN -- ? por los rangos
                        BEGIN
                                IF fnind_accion = 0
                                THEN
                                        vResp := 'FALSE|07|'||TO_CHAR(vvfechasta, vformato2);
                                ELSE
                                        vResp := 'TRUE';

                                        DELETE gad_servsup_plan
                                         WHERE cod_producto = 1
                                           AND cod_plantarif = vpplantarifa
                                           AND cod_servicio = vpcodservicio
                                           AND tip_relacion = TO_NUMBER(vptiporelacion)
                                           AND fec_desde = vvfecdesde;

                                        INSERT INTO gad_servsup_plan
                                        (cod_producto, cod_plantarif, cod_servicio,
                                         tip_relacion, fec_desde, fec_hasta,
                                         NOM_USUARIO, FEC_ULTMOD)
                                        VALUES
                                        (1, pplantarifa, pcodservicio,
                                         ptiporelacion, vfecdesde, vfechasta,
                                         USER, SYSDATE);
                                END IF;
                        EXCEPTION
                                WHEN OTHERS
                                THEN
                                        vResp := 'ERROR|'|| SQLERRM;
                        END;
                ELSIF vfechasta <= vvfecdesde AND vfecsys <= vfecdesde
                THEN
                        BEGIN
                                IF fnind_accion = 0
                                THEN
                                        vResp := 'TRUE|00|'||TO_CHAR(vvfechasta, vformato2); -- AQUI VA LA ESTRUCTURA DE  FALSE/01/FECHA_DESDE =VvFecHastaDESDE DE LA BASE
                                ELSE
                                        vResp := 'FALSE';

                                        INSERT INTO gad_servsup_plan
                                        (cod_producto, cod_plantarif, cod_servicio,
                                        tip_relacion, fec_desde, fec_hasta,
                                        NOM_USUARIO, FEC_ULTMOD)
                                        VALUES (1, pplantarifa, pcodservicio,
                                        ptiporelacion, vfecdesde, vfechasta,
                                        USER, SYSDATE);
                                END IF;
                        EXCEPTION
                                WHEN OTHERS
                                THEN
                                        vResp := 'ERROR|'||SQLERRM;
                        END;
      ELSIF      vvfecdesde < vfecdesde
             AND vvfechasta <= vfechasta
             AND vfecsys <= vvfecdesde
      THEN
         BEGIN
            IF fnind_accion = 0
            THEN
               vResp := 'FALSE|08|'||TO_CHAR (vvfechasta, vformato2); -- AQUI VA LA ESTRUCTURA DE  FALSE/01/FECHA_DESDE =VvFecHastaDESDE DE LA BASE
            ELSE
               vResp := 'FALSE';

               DELETE      gad_servsup_plan
                     WHERE cod_producto = 1
                       AND cod_plantarif = vpplantarifa
                       AND cod_servicio = vpcodservicio
                       AND tip_relacion = TO_NUMBER(vptiporelacion)
                       AND fec_desde = vvfecdesde;

               INSERT INTO gad_servsup_plan
                           (cod_producto, cod_plantarif, cod_servicio,
                            tip_relacion, fec_desde, fec_hasta,
                            NOM_USUARIO, FEC_ULTMOD)
                    VALUES (1, pplantarifa, pcodservicio,
                            ptiporelacion, vfecdesde, vfechasta,
                            USER, SYSDATE);
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               vResp :=    'ERROR|'|| SQLERRM;
         END;
              ELSIF      vfecdesde >= vvfechasta
                     AND vfecsys <= vvfecdesde
              THEN
                 BEGIN
                    IF fnind_accion = 0
                    THEN
                       vResp :=
                              'TRUE|00|'||TO_CHAR(vvfechasta, vformato2); -- AQUI VA LA ESTRUCTURA DE  FALSE/01/FECHA_DESDE =VvFecHastaDESDE DE LA BASE
                    ELSE
                       vResp := 'FALSE';

                       INSERT INTO gad_servsup_plan
                                   (cod_producto, cod_plantarif, cod_servicio,
                                    tip_relacion, fec_desde, fec_hasta,
                                    NOM_USUARIO, FEC_ULTMOD)
                            VALUES (1, pplantarifa, pcodservicio,
                                    ptiporelacion, vfecdesde, vfechasta,
                                    USER, SYSDATE);
                    END IF;
                 EXCEPTION
                    WHEN OTHERS
                    THEN
                       vResp := 'ERROR|'||SQLERRM;
                 END;
              ELSIF      vfecdesde > vvfechasta
                     AND vfecsys < vfecdesde
              THEN
                 BEGIN
                    IF fnind_accion = 0
                    THEN
                       vResp :=
                             'FALSE|09|'||TO_CHAR(vvfechasta, vformato2); -- AQUI VA LA ESTRUCTURA DE  FALSE/01/FECHA_DESDE =VvFecHastaDESDE DE LA BASE
                    ELSE
                       vResp := 'TRUE';

                       INSERT INTO gad_servsup_plan
                                   (cod_producto, cod_plantarif, cod_servicio,
                                    tip_relacion, fec_desde, fec_hasta,
                                    NOM_USUARIO, FEC_ULTMOD)
                            VALUES (1, pplantarifa, pcodservicio,
                                    ptiporelacion, vfecdesde, vfechasta,
                                    USER, SYSDATE);
                    END IF;
                 EXCEPTION
                    WHEN OTHERS
                    THEN
                       vResp :=    'ERROR|'|| SQLERRM;
                 END;
              ELSIF      vfecdesde >= vvfecdesde
                     AND vvfechasta <= vfechasta
                     AND --vFecSys < vvFecDesde and
                        vfecsys < vfecdesde
              THEN
                        BEGIN
                                IF fnind_accion = 0
                                THEN
                                        -- AQUI VA LA ESTRUCTURA DE  FALSE/01/FECHA_DESDE =VvFecHastaDESDE DE LA BASE
                                        vResp := 'FALSE|00|'||TO_CHAR(vvfechasta, vformato2);
                                ELSE
                                        vResp := 'TRUE';
                                END IF;
                        EXCEPTION
                                WHEN OTHERS
                                THEN
                                        vResp := 'ERROR|'|| SQLERRM;
                        END;

                ELSIF vvFecDesde <= vFecDesde AND vvFecHasta > vFecHasta
                THEN
                        BEGIN
                                IF fnInd_Accion = 1
                                THEN
                                        UPDATE gad_servsup_plan
                                           SET FEC_HASTA = vFecHasta,
                                               COD_MENSAJE = nCodMensaje,
                                               NOM_USUARIO = USER,
                                               FEC_ULTMOD = SYSDATE
                                         WHERE COD_PRODUCTO = 1
                                           AND COD_PLANTARIF = pplantarifa
                                           AND COD_SERVICIO = pcodservicio
                                           AND TIP_RELACION = ptiporelacion
                                           AND FEC_DESDE = vvFecDesde;
                                END IF;
                        EXCEPTION
                                WHEN OTHERS
                                THEN
                                        vResp := 'ERROR|'|| SQLERRM;
                        END;
                ELSIF vFecDesde <= vvFecDesde AND vFecHasta >= vvFecHasta
                THEN
                        BEGIN
                                IF fnInd_Accion = 1
                                THEN
                                        DELETE GAD_SERVSUP_PLAN
                                         WHERE COD_PRODUCTO = 1
                                           AND COD_PLANTARIF = pplantarifa
                                           AND COD_SERVICIO = pcodservicio
                                           AND TIP_RELACION = ptiporelacion
                                           AND FEC_DESDE = vvFecDesde;

                                        INSERT INTO GAD_SERVSUP_PLAN
                                        (COD_PRODUCTO, COD_PLANTARIF, COD_SERVICIO,
                                         TIP_RELACION, FEC_DESDE, FEC_HASTA,
                                         NOM_USUARIO, COD_MENSAJE, FEC_ULTMOD)
                                        VALUES
                                        (1, pplantarifa, pcodservicio,
                                         ptiporelacion, vFecDesde, vFecHasta,
                                         USER, nCodMensaje, SYSDATE);
                                        vResp := 'TRUE|00|DELETE-INSERT';
                                ELSE
                                        vResp := 'TRUE|00|DELETE-INSERT';
                                END IF;
                        EXCEPTION
                                WHEN OTHERS
                                THEN
                                        vResp := 'ERROR|'||SQLERRM;
                        END;
                END IF;
        END LOOP;

        CLOSE cr_ssplanes;

        IF vExiste = 'FALSE' AND fnInd_accion = 1 THEN
                BEGIN
                        INSERT INTO gad_servsup_plan
                        (cod_producto, cod_plantarif, cod_servicio, tip_relacion,
                        fec_desde, fec_hasta, COD_MENSAJE,
                        NOM_USUARIO, FEC_ULTMOD)
                        VALUES (1, pplantarifa, pcodservicio, ptiporelacion,
                        vfecdesde, vfechasta, nCodMensaje,
                        USER, SYSDATE);
                EXCEPTION
                        WHEN OTHERS THEN
                                vResp :='ERROR|'|| SQLERRM;
                END;
        END IF; */
        RETURN vResp;
END;
/
SHOW ERRORS
