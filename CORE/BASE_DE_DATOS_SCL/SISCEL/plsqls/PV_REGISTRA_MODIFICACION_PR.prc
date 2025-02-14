CREATE OR REPLACE PROCEDURE PV_REGISTRA_MODIFICACION_PR(
                                                        pnSujeto                in  number,   -- codigo del sujeto el numero de abonado o el codigo del cliente.
                                                        pvTipSujeto             in  varchar2, -- 'A' si es abonado, 'C' si es cliente.
                                                        pvCodTipmodi    in  varchar2,
                                                        pvCodValor              out varchar2, -- 'TRUE' O 'FALSE'.
                                                        pvErrorAplic    out varchar2, -- '0' EXITO, '4' ERROR.
                                                        pvErrorGlosa    out varchar2, -- Descripcion del error.
                                                        pvErrorOra              out varchar2, -- TO_CHAR(SQLCODE).
                                                        pvErrorOraGlosa out varchar2, -- SQLERRM.
                                                        pvTrace                 out varchar2  -- Traza de depuracion.
                                                        )
IS
   ERROR_PROCESO        EXCEPTION;
-- Inicio modificacion by SAQL/Soporte 26/01/2006 - RA-200601160594
   sNOM_CLIENTE GA_MODCLI.NOM_CLIENTE%TYPE;
   sNOM_APECLIEN1 GA_MODCLI.NOM_APECLIEN1%TYPE;
   sNOM_APECLIEN2 GA_MODCLI.NOM_APECLIEN2%TYPE;
-- Fin modificacion by SAQL/Soporte 26/01/2006 - RA-200601160594

BEGIN
         pvCodValor      := 'TRUE';
         pvErrorAplic    := '0';
         pvErrorGlosa    := ' ';
         pvErrorOra      := '0';
         pvErrorOraGlosa := ' ';
         pvTrace                 := ' ';

         IF pvTipSujeto = 'A' THEN
                BEGIN

                          INSERT INTO GA_MODABOCEL (NUM_ABONADO,
                                                                                COD_TIPMODI,
                                                                                FEC_MODIFICA,
                                                                                NOM_USUARORA)
                                                        VALUES     (pnSujeto,
                                                                            pvCodTipmodi,
                                                                                SYSDATE,
                                                                                USER);
                EXCEPTION
                        WHEN OTHERS
                        THEN
                                pvCodValor              := 'FALSE';
                pvErrorAplic    := '4';
                                pvErrorGlosa    := 'Problemas al Insertar en GA_MODABOCEL';
                                pvErrorOra              := TO_CHAR(SQLCODE);
                                pvErrorOraGlosa := SQLERRM;
                RAISE ERROR_PROCESO;
                END;
         ELSIF pvTipSujeto = 'C' THEN
                BEGIN

                        -- Inicio modificacion by SAQL/Soporte 26/01/2006 - RA-200601160594
                        SELECT NOM_CLIENTE, NOM_APECLIEN1,  NOM_APECLIEN2
                        INTO sNOM_CLIENTE, sNOM_APECLIEN1, sNOM_APECLIEN2
                        FROM GE_CLIENTES
                        WHERE COD_CLIENTE = pnSujeto;
                        -- Fin modificacion by SAQL/Soporte 26/01/2006 - RA-200601160594
                        INSERT INTO GA_MODCLI (COD_CLIENTE,
                                                                   COD_TIPMODI,
                                                                   FEC_MODIFICA,
                        -- Inicio modificacion by SAQL/Soporte 26/01/2006 - RA-200601160594
                        --                                           NOM_USUARORA)
                                                                   NOM_USUARORA,
                                                                   NOM_CLIENTE,
                                                                   NOM_APECLIEN1,
                                                                   NOM_APECLIEN2)
                        -- Fin modificacion by SAQL/Soporte 26/01/2006 - RA-200601160594
                                                VALUES    (pnSujeto,
                                                                   pvCodTipmodi,
                                                                   SYSDATE,
                        -- Inicio modificacion by SAQL/Soporte 26/01/2006 - RA-200601160594
                        --                                           USER);
                                                                   USER,
                                                                   sNOM_CLIENTE,
                                                                   sNOM_APECLIEN1,
                                                                   sNOM_APECLIEN2);
                        -- Fin modificacion by SAQL/Soporte 26/01/2006 - RA-200601160594
                EXCEPTION
                        WHEN OTHERS
                        THEN
                                pvCodValor              := 'FALSE';
                pvErrorAplic    := '4';
                                pvErrorGlosa    := 'Problemas al Insertar en GA_MODCLI';
                                pvErrorOra              := TO_CHAR(SQLCODE);
                                pvErrorOraGlosa := SQLERRM;
                RAISE ERROR_PROCESO;
                END;
         END IF;
EXCEPTION
        WHEN ERROR_PROCESO
    THEN
                DBMS_OUTPUT.PUT_LINE('FIN DEL PROCESO PV_REGISTRA_MODIFICACION_PR');
END;
/
SHOW ERRORS
