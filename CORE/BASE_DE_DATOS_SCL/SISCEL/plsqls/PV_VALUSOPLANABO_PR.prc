CREATE OR REPLACE PROCEDURE PV_VALUSOPLANABO_PR (
        v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
    )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALUSOPLANABO_PR
-- * Descripcion        : Valida que el plan tarifario sea compatible con el uso del abonado
-- *
-- * Fecha de creacion  : 13-01-2003 12:46
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

    nCodUso                GA_PLANUSO.COD_USO%TYPE;
        nnCodUso                   AL_USOS.COD_USO%TYPE;
        sCodPTarifNuevo        GA_PLANUSO.COD_PLANTARIF%TYPE;
        nIND_RESTPLAN          AL_USOS.IND_RESTPLAN%TYPE;
        sCOD_PLANTARIF         GA_PLANUSO.COD_PLANTARIF%TYPE;

BEGIN
    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
        nnCodUso           := TO_NUMBER(string(13));
        nCodUso            := TO_NUMBER(string(13));
        sCodPTarifNuevo    := string(12);

        dbms_output.PUT_LINE('USO: '||nCodUso);
        dbms_output.PUT_LINE('PLAN TARIFARIO: '||sCodPTarifNuevo );

        bRESULTADO:='TRUE';

    SELECT IND_RESTPLAN
    into
    nIND_RESTPLAN
    FROM AL_USOS
    WHERE COD_USO = nnCodUso;

    If nIND_RESTPLAN = 1 Then
          BEGIN

            SELECT COD_PLANTARIF
                into
                sCOD_PLANTARIF
                        FROM GA_PLANUSO
            WHERE COD_PLANTARIF = sCodPTarifNuevo
            AND COD_PRODUCTO    = 1
            AND COD_USO         = nCodUso;

            EXCEPTION WHEN NO_DATA_FOUND THEN
                                            bRESULTADO:='FALSE';
                                    vMENSAJE :='El plan tarifario seleccionado no es compatible con el uso del Abonado ' ;
                      WHEN OTHERS  THEN
                                                bRESULTADO:='FALSE';
                                    vMENSAJE :='Error de Acceso';

              END;
    END IF;

    EXCEPTION WHEN NO_DATA_FOUND THEN
                                   bRESULTADO:='TRUE';
                           vMENSAJE:='No existe Restriccion de Uso asociado al Abonado';
              WHEN OTHERS  THEN
                                   dbms_output.PUT_LINE('PLAN TARIFARIO:'|| sqlerrm );
                                   bRESULTADO:='FALSE';
                           vMENSAJE:='Error de Acceso ';
END PV_VALUSOPLANABO_PR;
/
SHOW ERRORS
