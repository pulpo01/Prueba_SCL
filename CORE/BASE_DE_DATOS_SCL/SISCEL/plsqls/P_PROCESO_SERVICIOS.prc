CREATE OR REPLACE procedure P_PROCESO_SERVICIOS
(
  VP_PRODUCTO IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_CLASEABO IN VARCHAR2 ,
  VP_FECSYS IN DATE )
IS
--
-- Procedimiento que realiza la carga de servicios suplementarios contratados
-- en el perfil  no incluidos inicial de habilitacion
--
   V_PROCED VARCHAR2(30) := NULL;
   V_CLASESERVICIO GA_ABOCEL.CLASE_SERVICIO%TYPE;
   V_SERVNIVEL VARCHAR2(6);
   V_SERVSUPL GA_SERVSUPLABO.COD_SERVSUPL%TYPE;
   V_NIVEL GA_SERVSUPLABO.COD_NIVEL%TYPE;

   --35941 W.A
   LV_CodOS    pv_iorserv.cod_os%type; --codigo de la ooss
   LV_OOSSCambPlan     varchar2(50); -- Valores del Val parametro




BEGIN
     --INICIO 35941 W.A
      BEGIN
         -- INI COL|61415|29-02-2008|SAQL
         /*
         Select b.cod_os  INTO   LV_CodOS
         from pv_camcom a, pv_iorserv b
         where a.num_abonado = VP_ABONADO
         and a.CLASE_SERVICIO_ACT = VP_CLASEABO   --SS
         and a.num_os = (select max(num_os) from pv_camcom where num_abonado = VP_ABONADO and CLASE_SERVICIO_ACT = VP_CLASEABO) --SS
         and b.num_os = a.num_os;
         */

         SELECT B.COD_OS INTO LV_CODOS
         FROM PV_CAMCOM A, PV_IORSERV B, PV_MOVIMIENTOS C
         WHERE A.NUM_ABONADO = VP_ABONADO
         AND C.COD_SERVICIO = VP_CLASEABO
         AND A.NUM_OS = C.NUM_OS
         AND A.NUM_OS = (SELECT MAX(D.NUM_OS) FROM PV_MOVIMIENTOS D, PV_CAMCOM E  WHERE D.NUM_OS = E.NUM_OS AND D.COD_SERVICIO = VP_CLASEABO and e.NUM_ABONADO = VP_ABONADO)
         AND B.NUM_OS = A.NUM_OS;
         -- FIN COL|61415|29-02-2008|SAQL

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
         LV_CodOS := -1;
      END;

         -- Rescata codigos val parametro OOSS 06/11/2006 W.A 35941
     SELECT a.val_parametro
     INTO   LV_OOSSCambPlan
     FROM   GED_PARAMETROS a
     where  a.nom_parametro  IN('OOSS_CAMB_PLAN_BATCH')
     AND    a.COD_PRODUCTO = 1
     AND    a.COD_MODULO   = 'GA';



   V_PROCED := 'P_PROCESO_SERVICIOS';
   V_CLASESERVICIO := VP_CLASEABO;
   LOOP
      V_SERVNIVEL := SUBSTR (V_CLASESERVICIO, 1, 6);
      EXIT WHEN V_SERVNIVEL IS NULL;
      V_CLASESERVICIO := SUBSTR(V_CLASESERVICIO,
                         INSTR(V_CLASESERVICIO, V_SERVNIVEL) + 6);
      V_SERVSUPL := SUBSTR(V_SERVNIVEL,1,2);
      V_NIVEL    := SUBSTR(V_SERVNIVEL,3,4);
      IF V_NIVEL <> 0 THEN
         -- ACTUALIZA ALTA DE SERVICIO NUEVO
         IF instr(LV_OOSSCambPlan,LV_CodOS) > 0 then --35941 W.A OOSS encontrado 1 = true 0 = false
             UPDATE GA_SERVSUPLABO
              SET FEC_ALTACEN = FEC_ALTABD,
                IND_ESTADO  = 2,
                FEC_BAJABD=NULL,
                FEC_BAJACEN = NULL
                WHERE NUM_ABONADO = VP_ABONADO
                AND COD_SERVSUPL = V_SERVSUPL
                AND COD_NIVEL    = V_NIVEL
                AND IND_ESTADO=1;
         ELSE
               UPDATE GA_SERVSUPLABO
               SET FEC_ALTACEN = VP_FECSYS,
               IND_ESTADO  = 2,
               FEC_BAJABD=NULL,
               FEC_BAJACEN = NULL
               WHERE NUM_ABONADO = VP_ABONADO
               AND COD_SERVSUPL = V_SERVSUPL
               AND COD_NIVEL    = V_NIVEL
               AND IND_ESTADO=1;
         End If;

         -- ACTUALIZA BAJA DE SERVICIO
         IF instr(LV_OOSSCambPlan,LV_CodOS)> 0 then --35941 W.A OOSS encontrado 1 = true 0 = false
            UPDATE GA_SERVSUPLABO
            -- SET FEC_BAJACEN = FEC_ALTABD,  -- INI COL|61415|29-04-2008|SAQL
            SET FEC_BAJACEN = SYSDATE, -- INI COL|61415|29-04-2008|SAQL
            IND_ESTADO  = 4
            WHERE NUM_ABONADO = VP_ABONADO
            AND COD_SERVSUPL = V_SERVSUPL
            AND COD_NIVEL <> V_NIVEL
            AND IND_ESTADO=3;
         ELSE
            UPDATE GA_SERVSUPLABO
            SET FEC_BAJACEN = VP_FECSYS,
            IND_ESTADO  = 4
            WHERE NUM_ABONADO = VP_ABONADO
            AND COD_SERVSUPL = V_SERVSUPL
            AND COD_NIVEL <> V_NIVEL
            AND IND_ESTADO=3;
         END IF;

      ELSE
         -- ACTUALIZA BAJA DE SERVICIO
         IF instr(LV_OOSSCambPlan,LV_CodOS)> 0 then --35941 W.A OOSS encontrado 1 = true 0 = false
                UPDATE GA_SERVSUPLABO
                -- SET FEC_BAJACEN = FEC_ALTABD,  -- COL 61415|29-04-2008|SAQL
           SET FEC_BAJACEN = SYSDATE, -- COL 61415|29-04-2008|SAQL
                IND_ESTADO  = 4
                WHERE NUM_ABONADO = VP_ABONADO
                AND COD_SERVSUPL = V_SERVSUPL
                AND COD_NIVEL <> V_NIVEL
                AND IND_ESTADO=3;
             ELSE
                UPDATE GA_SERVSUPLABO
                SET FEC_BAJACEN = VP_FECSYS,
                IND_ESTADO  = 4
                WHERE NUM_ABONADO = VP_ABONADO
                AND COD_SERVSUPL = V_SERVSUPL
                AND COD_NIVEL <> V_NIVEL
                AND IND_ESTADO=3;
              END IF;

            -- Inicio Modificación - GBM - TM-200408250915 - 14-10-2004
            -- ACTUALIZA BAJA DE ABONADO
          UPDATE GA_SERVSUPLABO
          SET FEC_BAJACEN = VP_FECSYS
          WHERE NUM_ABONADO = VP_ABONADO
          AND COD_SERVSUPL = V_SERVSUPL
          AND IND_ESTADO=5;
            -- Fin Modificación - GBM - TM-200408250915 - 14-10-2004


                        --- P_COL_06066 (MIX_06003_G4)
                        UPDATE GA_SERVSUPLABO
            SET FEC_BAJABD  = VP_FECSYS,
                FEC_BAJACEN = VP_FECSYS,
                IND_ESTADO  = 4
                        WHERE NUM_ABONADO  = VP_ABONADO
            AND COD_SERVSUPL = V_SERVSUPL
            AND COD_SERVICIO IN (
                    SELECT COD_SERVICIO
                                FROM GA_SERVSUP_DEF
                    WHERE TIP_RELACION = 5)
                        AND COD_NIVEL <> 0
            AND IND_ESTADO=2;
            --- P_COL_06066 (MIX_06003_G4)

      END IF;
    END LOOP;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20205,V_PROCED||' '||SQLERRM);
END;
/
SHOW ERRORS