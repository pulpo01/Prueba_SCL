CREATE OR REPLACE PROCEDURE        PV_PRC_EJEC_OSPENDBATCH_INMED(
--Verifica si existe OoSs pendiente
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
     nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------

         vCantidad         NUMBER(3);
         vCantidad2        NUMBER(3);

         iTIPESTADOA       NUMBER(2);
     iCODESTADO        NUMBER(3);
     nestado           NUMBER(3);
     iTIPESTADOB       NUMBER(2);
     iCODESTCANCELADA  NUMBER(2);
     iMAX_INTENTOS     NUMBER(3);
     V_DES_VALOR       GED_CODIGOS.DES_VALOR%TYPE;


BEGIN

         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     vACTABO          := string(4);
     nABONADO         := -1;
         nABONADO         := TO_NUMBER(string(5));
     nCLIENTE               := -1;
     nCLIENTE               := TO_NUMBER(string(6));

         bRESULTADO  := 'TRUE';
     vCantidad   := 0;
     iTIPESTADOA := 3;
     iTIPESTADOB := 1;

     SELECT trim(val_parametro)
     INTO  iMAX_INTENTOS
     FROM  ged_parametros
     WHERE nom_parametro = 'MAX_INTENTOS'
     AND   cod_modulo    = 'GA'
     AND   cod_producto  = 1;


     IF nABONADO <> -1 THEN
     --Si la OOSS es por un abonado

                SELECT COUNT(*)
        INTO vCantidad
        FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
            WHERE A.NUM_OS    = B.NUM_OS
           AND A.NUM_OS      = C.NUM_OS
           AND B.NUM_OS      = C.NUM_OS
           AND B.NUM_ABONADO = nABONADO
           AND C.TIP_ESTADO <> '4'
        and a.cod_os  in ('10233');

          IF vCantidad <> 0 THEN
              vCantidad2 :=0;
                     SELECT COUNT(1)
                INTO vCantidad2
                FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
                WHERE A.NUM_OS = B.NUM_OS
                AND A.NUM_OS = C.NUM_OS
                AND B.NUM_OS = C.NUM_OS
                AND B.NUM_ABONADO = nABONADO
                AND C.TIP_ESTADO <> '4'
                            and a.cod_os  in ('10233')
                            AND (NUM_INTENTOS IS NULL or NUM_INTENTOS<iMAX_INTENTOS)
                            AND TRUNC(FECHA_ING) = TRUNC(FH_EJECUCION);

                            IF vCantidad2 >0 THEN
                               vCantidad :=vCantidad2;
                            ELSE
                               vCantidad :=0;
                            END IF;
          end if;

      ELSIF nCLIENTE <> -1 THEN
      --Si la OOSS es por un Cliente

          SELECT COUNT(*)
          INTO vCantidad
          FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
              WHERE A.NUM_OS = B.NUM_OS
                  AND A.NUM_OS = C.NUM_OS
             AND B.NUM_OS = C.NUM_OS
             AND B.COD_CLIENTE = nCLIENTE
             AND C.TIP_ESTADO <> '4'
          AND a.cod_os  in ('10233');

            IF vCantidad <> 0 THEN
              vCantidad2 :=0;

              SELECT COUNT(1)
            INTO vCantidad2
            FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
            WHERE A.NUM_OS = B.NUM_OS
               AND A.NUM_OS = C.NUM_OS
               AND B.NUM_OS = C.NUM_OS
               AND B.cod_cliente =nCLIENTE
               AND C.TIP_ESTADO <> '4'
                        and a.cod_os  in ('10233')
                        AND (NUM_INTENTOS IS NULL or NUM_INTENTOS<iMAX_INTENTOS)
                        AND TRUNC(FECHA_ING) = TRUNC(FH_EJECUCION);

             IF vCantidad2 >0 THEN
                               vCantidad :=vCantidad2;
             ELSE
                                                 vCantidad :=0;
                     END IF;

          end if;
      END IF;

      IF vCantidad <> 0 THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'ABONADO TIENE ORDEN DE SERVICIO PENDIENTE';
      END IF;

EXCEPTION
   WHEN OTHERS THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'ERROR EN PV_PRC_EJEC_OSPENDBATCH_INMED: NO SE PUEDE VALIDAR OOSS PENDIENTES.' || SQLERRM || '.';

END;
/
SHOW ERRORS
