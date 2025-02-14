CREATE OR REPLACE PROCEDURE PV_VALCUENORIDES_PR(
    v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALCUENORIDES_PR
-- * Descripcion        : Valida segun la actuacion las cuentas origen y destino
-- *
-- * Fecha de creacion  : 13-01-2003 12:42
-- * Responsable        : Area Postventa
-- *************************************************************
        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        nCOD_CUENTAO      GA_ABOCEL.COD_CUENTA%TYPE;
        nCOD_CUENTAD      GA_ABOCEL.COD_CUENTA%TYPE;
        scod_ACTUACI      PV_MOVIMIENTOS.COD_ACTABO%TYPE;

BEGIN

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
    scod_ACTUACI                :=string(4);
        nCOD_CUENTAO            :=TO_NUMBER(string(14));
        nCOD_CUENTAD            :=TO_NUMBER(string(15));
        dbms_output.PUT_LINE('ACTUA:'||scod_ACTUACI);
        dbms_output.PUT_LINE('nCOD_CUENTAO:'||nCOD_CUENTAO);
        dbms_output.PUT_LINE('nCOD_CUENTAD:'||nCOD_CUENTAD);
    bRESULTADO:='TRUE';
                IF  scod_ACTUACI = 'RO' OR scod_ACTUACI = 'R2' THEN
                if nCOD_CUENTAO != nCOD_CUENTAD then
                   bRESULTADO:='FALSE';
                   vMENSAJE :='La Cuenta Destino no es valida para realizar la Solicitud de Reordenamiento';
                end if;
        END IF;

        IF  scod_ACTUACI = 'AE' OR scod_ACTUACI = 'A2' THEN
                if nCOD_CUENTAO != nCOD_CUENTAD then
                                        bRESULTADO:='FALSE';
                                vMENSAJE:='La Cuenta Destino no es valida para realizar la Solicitud de Cambio de Plan';
                end if;
        END IF;

        IF  scod_ACTUACI = 'TP' OR scod_ACTUACI = 'T2' THEN
                if nCOD_CUENTAO = nCOD_CUENTAD then
                      bRESULTADO:='FALSE';
                      vMENSAJE:='La Cuenta Destino no es valida para realizar la Solicitud de Traspaso';
                end if;
        END IF;
END PV_VALCUENORIDES_PR;
/
SHOW ERRORS
