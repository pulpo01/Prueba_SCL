CREATE OR REPLACE PROCEDURE        CE_P_CIERRE_TRANS_OK(
        num_atm IN NUMBER,
        num_oper IN NUMBER,
        monto IN NUMBER,
        ci_numreci IN NUMBER,
        ci_fecontab IN VARCHAR2,
        ci_codtip IN VARCHAR2,
        resul IN OUT VARCHAR2,
    empresa IN VARCHAR2,
        cod_autoriz IN VARCHAR2,-- opcional
        serie IN VARCHAR2,      -- opcional
        num_celular IN VARCHAR2,-- opcional
        mot_rechazo IN VARCHAR2, -- opcional
        cod_trans IN VARCHAR2,
        empresa_fin IN VARCHAR2
        ) IS
        ci_numventa number(8);
        pnum_celular CET_TRANSACCION.NUM_CELULAR%TYPE;
        pnum_clave       CET_CLAVEDISP.NUM_CLAVE%TYPE;
        pnum_serie       CET_CLAVEDISP.NUM_SERIE%TYPE;
        pexpi varchar(11);
        marca number(2);
        INS_O_UPD number(2);
        modalidad    CED_PARAMETROS.VAL_CARACTER%TYPE;
        fecha_hoy CET_CTRSTOCKDIA.COD_TIPCLAVE%TYPE;
        pcod_estado CET_CLAVEDISP.COD_ESTADO%TYPE;
        CURSOR COD_CLAVE IS
        SELECT COD_TIPCLAVE FROM CET_CTRSTOCKDIA
        WHERE COD_TIPCLAVE =ci_codtip
        AND to_char(FEC_VENTA,'dd/mm/yyyy')=to_char(sysdate,'dd/mm/yyyy');
        CURSOR DATOS IS
        SELECT NUM_CLAVE, NUM_SERIE, TO_CHAR(FEC_EXPIRACION,'dd-mm-yyyy')
    FROM CET_CLAVEDISP WHERE NUM_OPERACION =num_oper
        AND NUM_ATMOPER=num_atm;
        CURSOR DATOSNK IS
        SELECT NUM_CLAVE
        FROM CET_CLAVEDISP WHERE NUM_OPERACION=num_oper
        AND NUM_ATMOPER=num_atm;
        ERROR_PROCESO EXCEPTION;
        BEGIN
        -- ESTO DEBE SER MODIFICADO UNA VEZ QUE QUEDEN DEFINIDOS LOS CODIGOS DE EMPRESA
        -- Y CODIGO SERVICIO CON REDBANC
        --empresa:='REDBN';
SELECT VAL_CARACTER INTO modalidad FROM CED_PARAMETROS WHERE COD_PARAMETRO='3';
IF cod_trans='NK' THEN
        OPEN DATOSNK;
        marca :=1;
        resul:='0003';
        LOOP
                FETCH DATOSNK INTO pnum_clave;
                IF NOT DATOSNK%NOTFOUND THEN --si encontro el registro
                        resul := '0000';
                END IF;
                EXIT WHEN DATOSNK%NOTFOUND;
        END LOOP;
        marca :=2;
  IF resul='0003' THEN
        marca :=3;
        --Marca clave como rechazada en cet_transaccion
        UPDATE CET_TRANSACCION
        SET COD_ESTADO='B'
    WHERE
            NUM_TRANSACCION=num_oper
        AND NUM_TERMINAL=num_atm
        AND FEC_CONTABLE=to_date(ci_fecontab,'dd/mm/yyyy');
        --Modifica en Historica cuando ha sido reversada la transaccion
        --despues que ha terminado toda la operacin
        UPDATE CEH_CLAVEDISP
        SET COD_ESTADO='B',
            COD_MOTRECHA='RR', FEC_RECHAZO=SYSDATE
        WHERE
            NUM_OPERACION=num_oper
        AND NUM_ATMOPER=num_atm
        AND FEC_TRANSACCION=to_date(ci_fecontab,'dd/mm/yyyy');
  ELSE
        --Prepara el Insert1 si transaccisn es incorrecta, agrega la
        --clave a tabla que contiene el historial
        INSERT INTO CEH_CLAVEDISP
        (NUM_CLAVE,
        NUM_SERIE,
        FEC_EXPIRACION,
        NUM_VIGENCIA,
        COD_TIPCLAVE,
        MTO_CLAVE,
        COD_ESTADO,
        NUM_ATMOPER,
        NUM_OPERACION,
        COD_SCRIPT,
        NUM_LOTE,
        FEC_ACTIVA,
        FEC_RECHAZO,
        COD_MOTRECHA,
        NUM_OPACTIVA)
        SELECT NUM_CLAVE, NUM_SERIE, FEC_EXPIRACION,
               NUM_VIGENCIA, COD_TIPCLAVE, MTO_CLAVE, 'B',
               NUM_ATMOPER, NUM_OPERACION, COD_SCRIPT, NUM_LOTE,
               FEC_ACTIVA, SYSDATE, mot_rechazo, NUM_OPACTIVA
        FROM   CET_CLAVEDISP
        WHERE  NUM_OPERACION=num_oper
        AND    NUM_ATMOPER=num_atm;
        --Prepara Delete para Eliminar clave rechazada
        IF mot_rechazo='TO' THEN
           pcod_estado:='PB';
        ELSE
           pcod_estado:='VP';
        END IF;
        DELETE CET_CLAVEDISP
        WHERE COD_ESTADO=pcod_estado
        AND   NUM_ATMOPER=num_atm
        AND   NUM_OPERACION=num_oper;
        --Rebaja en uno cantidad de claves disponibles
        IF modalidad='I' THEN
                UPDATE CED_CTRSTOCK SET
                NUM_DISPONIBLES = NUM_DISPONIBLES - 1
                WHERE
                COD_TIPCLAVE =ci_codtip;
        END IF;
        IF modalidad='A' THEN
                UPDATE CED_CTRSTOCK SET
                NUM_ACTIVOS = NUM_ACTIVOS - 1
                WHERE
                COD_TIPCLAVE =ci_codtip;
        END IF;
  END IF;
  CLOSE DATOSNK;
        --Hasta aqui llega NK
END IF;
IF cod_trans='OK' THEN
        pnum_celular:=num_celular;
        IF num_celular IS NULL OR num_celular='' THEN
           pnum_celular:='0';
        END IF;
        OPEN DATOS;
        marca :=1;
        resul:='0002';
        LOOP
                FETCH DATOS INTO pnum_clave, pnum_serie, pexpi;
                IF NOT DATOS%NOTFOUND THEN --encontro el registro
                   resul := '0000';
                END IF;
                EXIT WHEN DATOS%NOTFOUND;
        END LOOP;
        marca :=2;
        SELECT CES_NUMVENTA.NEXTVAL INTO ci_numventa FROM DUAL;
 IF resul='0000' THEN
        marca :=3;
        --Cuando transaccisn es correcta...
        INSERT INTO CET_TRANSACCION
        (COD_CLIENTE,
        NUM_CELULAR,
        FEC_MOVIMIENTO,
        COD_SERVICIO,
        MTO_SERVICIO,
        NUM_CLAVE,
        NUM_SERIE,
        NUM_VENTA,
        FEC_EXPIRACION,
        NUM_TERMINAL,
        NUM_RECIBO,
        NUM_TRANSACCION,
        COD_ESTADO,
        FEC_VALIDA,
        NUM_CTACTE,
        NUM_TARJETA,
        COD_TIPTARJETA,
        NUM_PROCVAL,
        NUM_PROCONC,
        COD_EMPRFIN,
        COD_EMPRSERV,
        FEC_CONTABLE,
        IND_FACTURACION,
        NUM_PROCFACT,
        IND_COMISION,
        IND_CONCILIACION,
        IND_PAGO
        )
        VALUES(
        0,
        pnum_celular,
        sysdate,
        'VTA04',
        monto,
        pnum_clave,
        pnum_serie,
        ci_numventa,
        to_date(pexpi,'dd-mm-yyyy'),
    num_atm,
        ci_numreci,
        num_oper,
        'V',
        NULL,
        NULL,
        NULL,
        NULL,
        0,
        0,
        empresa_fin,
        'REDBN', -- Esto se debe cambiar por empresa una vez que este definido el csdigo
        to_date(ci_fecontab,'dd/mm/yyyy'),
        '0',
        0,
        '0',
        '0',
        '0');
        --Prepara el Insert si transaccisn es correcta, agrega la
        --clave a tabla historica
        INSERT INTO CEH_CLAVEDISP
        (NUM_CLAVE,
        NUM_SERIE,
        FEC_EXPIRACION,
        COD_TIPCLAVE,
        MTO_CLAVE,
        COD_ESTADO,
        NUM_ATMOPER,
        NUM_OPERACION,
        COD_SCRIPT,
        NUM_LOTE,
        FEC_ACTIVA,
        FEC_RECHAZO,
        COD_MOTRECHA,
        NUM_OPACTIVA,
        FEC_TRANSACCION)
        SELECT NUM_CLAVE, NUM_SERIE, FEC_EXPIRACION,
        COD_TIPCLAVE, MTO_CLAVE, 'V', num_atm, num_oper,COD_SCRIPT, NUM_LOTE,
        sysdate, '', '', 0, to_date(ci_fecontab,'dd/mm/yyyy')
        FROM CET_CLAVEDISP
        WHERE
            NUM_OPERACION=num_oper
        AND NUM_ATMOPER=num_atm
        AND COD_ESTADO='VP';
        --Prepara Delete para Eliminar clave asignada
        DELETE CET_CLAVEDISP
        WHERE
            NUM_OPERACION=num_oper
        AND NUM_ATMOPER=num_atm
        AND COD_ESTADO='VP';
        --Rebaja en uno cantidad de claves disponibles
        IF modalidad='I' THEN
                UPDATE CED_CTRSTOCK SET
                NUM_DISPONIBLES = NUM_DISPONIBLES - 1
                WHERE
                COD_TIPCLAVE =ci_codtip;
        END IF;
        IF modalidad='A' THEN
                UPDATE CED_CTRSTOCK SET
                NUM_ACTIVOS = NUM_ACTIVOS - 1
                WHERE
                COD_TIPCLAVE =ci_codtip;
        END IF;
        OPEN COD_CLAVE;
        marca :=1;
        INS_O_UPD:=1;
        LOOP
                FETCH COD_CLAVE INTO fecha_hoy;
                IF NOT COD_CLAVE%NOTFOUND THEN
                           INS_O_UPD:=2;
                END IF;
                EXIT WHEN COD_CLAVE%NOTFOUND;
        END LOOP;
        --Agrega uno a el numero de claves vendidas en el dia si esto
        --no se cumple se ejecuta el insert "3"
        IF INS_O_UPD = 2 THEN
           UPDATE CET_CTRSTOCKDIA SET
           NUM_UNIDADES = NUM_UNIDADES + 1
           WHERE
           TO_CHAR(FEC_VENTA,'dd/mm/yyyy') = TO_CHAR(sysdate,'dd/mm/yyyy')
           AND COD_TIPCLAVE=ci_codtip;
        ELSE
                --Prepara Insert "3" si es que no existen registros para el dia
                INSERT INTO CET_CTRSTOCKDIA
                (NUM_UNIDADES, FEC_VENTA, COD_TIPCLAVE)
                VALUES('1', sysdate, ci_codtip);
        END IF;
        CLOSE COD_CLAVE;
  END IF;
  CLOSE DATOS;
END IF;
        COMMIT;
        marca := 0;
        EXCEPTION
        WHEN ERROR_PROCESO THEN
         if marca !=0 then
            resul := SQLERRM;
                ROLLBACK;
         end if;
END CE_P_CIERRE_TRANS_OK;
/
SHOW ERRORS
