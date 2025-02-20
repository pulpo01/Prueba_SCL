CREATE OR REPLACE procedure P_CAMBIO_CICLO_MASIVO (

V_CICLO_OLD	IN VARCHAR2,
V_CICLO_NUE	IN VARCHAR2,
V_CLIENTE 	IN VARCHAR2) is

V_TRANSAC	PV_CAMCOM.NUM_TRANSACCION%TYPE;
V_NUM_OS	PV_CAMCOM.NUM_OS%TYPE;

BEGIN

INSERT INTO GA_MODCLI (COD_CLIENTE, COD_TIPMODI, FEC_MODIFICA, NOM_USUARORA, COD_CICLO )
VALUES (V_CLIENTE, 'CL', SYSDATE, 'SISCEL', V_CICLO_OLD);

SELECT GA_SEQ_TRANSACABO.NEXTVAL
INTO V_TRANSAC
FROM DUAL;

BEGIN P_INTERFASES_ABONADOS(V_TRANSAC,'CL','5',V_CLIENTE,V_CICLO_NUE,V_CICLO_OLD,NULL); END;

SELECT ci_seq_numos.nextval
INTO V_NUM_OS
FROM dual;

INSERT INTO CI_ORSERV(NUM_OS, COD_OS, PRODUCTO, TIP_INTER, COD_INTER, USUARIO, FECHA, COMENTARIO)
VALUES(V_NUM_OS, 10025, 1, 8, V_CLIENTE, 'SISCEL', SYSDATE, 'MASIVO');

END;
/
SHOW ERRORS
