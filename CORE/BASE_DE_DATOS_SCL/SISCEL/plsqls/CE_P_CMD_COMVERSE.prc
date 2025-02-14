CREATE OR REPLACE PROCEDURE        CE_P_CMD_COMVERSE(
comando IN VARCHAR2,
celular IN NUMBER,
empresa IN VARCHAR2,
serie IN VARCHAR2,
pin IN VARCHAR2,
monto IN OUT NUMBER,
resul IN OUT VARCHAR2,
usuario IN VARCHAR2,
servicio IN VARCHAR2,
secuencia IN OUT NUMBER,
lote IN NUMBER
)IS
/******************************************************************************
   NOMBRE:     CMD_COMVERSE
   OBJETIVO:   INSERTAR EN ICC_MOVIMIENTO PARA EJECUTAR COMANDO PARA ACTIVAR ESTADO DE SERIES EN COMVERSE
   Ver        Fecha        Autor
   ---------  ----------  ---------------
   1.0        27/09/2000  CRISTIAN RETAMAL M.
******************************************************************************/
   psecuencia             SISCEL.ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
   pcod_actuacion         SISCEL.ICC_MOVIMIENTO.COD_ACTUACION%TYPE;
   pcod_central           SISCEL.ICC_MOVIMIENTO.COD_CENTRAL%TYPE;
   pcod_modulo            SISCEL.ICC_MOVIMIENTO.COD_MODULO%TYPE;
   pNumMin				  SISCEL.ICC_MOVIMIENTO.NUM_MIN%TYPE;
   pNumAbonado			  SISCEL.ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
   pTipTerminal			  SISCEL.ICC_MOVIMIENTO.TIP_TERMINAL%TYPE;
   pCelular				  SISCEL.ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
   iDecimal				  NUMBER(2);


BEGIN

  SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
  INTO   iDecimal
  FROM   DUAL;

  pCelular:=celular;

        resul:='OK';
        IF UPPER(comando)='BAJAS' OR UPPER(comando)='ACTSE' THEN
           IF serie IS NULL OR usuario IS NULL OR lote IS NULL then
                  resul:='<Error' || comando ||'> Debe ingresar serie y usuario';
           END IF;
        END IF;
    IF UPPER(comando)='CARGA' THEN
           IF pCelular=0 OR serie IS NULL OR pin IS NULL OR empresa IS NULL OR usuario IS NULL then
                  resul:='<Error Carga> Debe ingresar celular, pin, serie, empresa y usuario';
           END IF;
        END IF;
    IF UPPER(comando)='CAMBA' THEN
           IF pCelular=0 OR monto IS NULL OR usuario IS NULL then
                  resul:='<Error Camba> Debe ingresar celular, monto y usuario';
           END IF;
        END IF;
        IF UPPER(comando)='RDIST' THEN
           IF serie IS NULL OR empresa IS NULL OR usuario IS NULL then
                  resul:='<Error Baja> Debe ingresar serie, empresa y usuario';
           END IF;
        END IF;
IF resul='OK' THEN
        SELECT COD_ACTUACION
        INTO pcod_actuacion
        FROM CED_ACTUACION
        WHERE COD_COMANDO=UPPER(comando);

		SELECT VAL_NUMERICO
        INTO pcod_central
        FROM CED_PARAMETROS
        WHERE COD_PARAMETRO='5';

		SELECT VAL_CARACTER
        INTO pcod_modulo
        FROM CED_PARAMETROS
        WHERE COD_PARAMETRO='14';

		SELECT ICC_SEQ_NUMMOVPIN.NEXTVAL
        INTO psecuencia
        FROM DUAL;

		IF pCelular <> 0 THEN
		   SELECT NUM_ABONADO, TIP_TERMINAL
           INTO pNumAbonado, pTipTerminal
           FROM SISCEL.GA_ABOCEL
           WHERE NUM_CELULAR=celular
		   AND   FEC_BAJA IS NULL;

   	       --pNumMin := AL_FN_PREFIJO_NUMERO(celular);
   	       pNumMin := 730;
		ELSE
		   pCelular:=0;
		   pNumAbonado:=0;
		   pTipTerminal:='D';
		   pNumMin:=730;
		END IF;



    INSERT INTO ICC_MOVIMIENTO
        (NUM_MOVIMIENTO,
		NUM_ABONADO,
		NUM_MIN,
        COD_MODULO,
        COD_ACTUACION,
        COD_ESTADO,
        IND_BLOQUEO,
        NUM_INTENTOS,
        DES_RESPUESTA,
        NOM_USUARORA,
        FEC_INGRESO,
		TIP_TERMINAL,
        COD_CENTRAL,
        NUM_CELULAR,
        DES_ORIGEN_PIN,
        NUM_LOTE_PIN,
        NUM_SERIE_PIN,
        NUM_SERIE,
        COD_PIN,
        CARGA)
        VALUES(
        psecuencia,             --NUM_MOVIMIENTO  NUMBER(9)     NOT NULL,
		pNumAbonado,
		pNumMin,
        pcod_modulo,    --COD_MODULO      VARCHAR2(2)   NOT NULL,
        pcod_actuacion, --COD_ACTUACION   NUMBER(3)     NOT NULL,
        1,              --COD_ESTADO      NUMBER(3)     NOT NULL,
        0,              --IND_BLOQUEO     NUMBER(1)     NOT NULL,
        0,              --NUM_INTENTOS    NUMBER(3)     NOT NULL,
        'PENDIENTE',    --DES_RESPUESTA   VARCHAR2(80)  NOT NULL,
        usuario,        --NOM_USUARIO     VARCHAR2(30)  NOT NULL,
        sysdate,        --FEC_INGRESO     DATE          NOT NULL,
		pTipTerminal,	--TIP_TERMINAL
        pcod_central ,  --COD_CENTRAL     NUMBER(3)     NOT NULL,
        pCelular,        --NUM_CELULAR     NUMBER(8),
        empresa,        --ORIGEN          VARCHAR2(8),
        lote,           --LOTE            NUMBER(9),
        serie,          --SERIE           VARCHAR2(16),
        '0',            --SERIE           VARCHAR2(16),
        pin,            --PIN             VARCHAR2(16),
        GE_PAC_GENERAL.REDONDEA(monto,iDecimal,0));         --BALANCE         NUMBER(6),
--        monto);
        secuencia:=psecuencia;
        COMMIT;
END IF;
        EXCEPTION
		WHEN NO_DATA_FOUND THEN
   	    resul:='NULL';
        WHEN OTHERS THEN
            resul := SQLERRM;
                ROLLBACK;
END CE_P_CMD_COMVERSE;
/
SHOW ERRORS
