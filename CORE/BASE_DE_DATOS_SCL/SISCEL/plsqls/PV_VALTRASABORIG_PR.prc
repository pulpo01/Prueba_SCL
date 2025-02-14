CREATE OR REPLACE PROCEDURE PV_VALTRASABORIG_PR (
v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALTRASABORIG_PR
-- * Descripcion        : Verificar si el cliente es valido en la base de datos.
-- *
-- * Fecha de creacion  : 13-01-2003 12:46
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        nCOD_CLIENTE             GA_ABOCEL.COD_CLIENTE%TYPE;

        -- Variables de Error, para procediemientos.

        sind_acepvent             GE_CLIENTES.IND_ACEPVENT%TYPE;
        sind_traspaso             GE_CLIENTES.IND_TRASPASO%TYPE;
        ncod_ciclo                GE_CLIENTES.COD_CICLO%TYPE;

BEGIN

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
        nCOD_CLIENTE        := TO_NUMBER(string(6));
    bRESULTADO          :='TRUE';
        vMENSAJE            := '';
    BEGIN
        SELECT IND_ACEPVENT, IND_TRASPASO,COD_CICLO
        INTO
            sind_acepvent,sind_traspaso,ncod_ciclo
        FROM GE_CLIENTES
        WHERE COD_CLIENTE = nCOD_CLIENTE;

        If LTrim(sind_acepvent) = '0' Then
                     bRESULTADO :=  'FALSE';
             vMENSAJE   := 'El cliente no esta aceptado por el sistema.';
        else
            If LTrim(sind_traspaso) = 'N' Then
                        bRESULTADO := 'FALSE';
                        vMENSAJE   := 'No se pueden realizar traspasos de celulares para el cliente.';
        else
                    if  ncod_ciclo = 25 Then
                        bRESULTADO := 'FALSE';
                vMENSAJE   := 'No se pueden realizar traspasos de abonados prepago.';
            end if;
                end if;
        end if;

EXCEPTION
          WHEN NO_DATA_FOUND THEN
            bRESULTADO := 'FALSE';
            vMENSAJE   := 'Clientes no encontrado';
          WHEN OTHERS            THEN
                    bRESULTADO := 'FALSE';
            vMENSAJE   := 'Error al recuperar datos del cliente.';
    END;

END PV_VALTRASABORIG_PR;
/
SHOW ERRORS
