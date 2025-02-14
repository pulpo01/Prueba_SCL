CREATE OR REPLACE PACKAGE IC_PKG_RESCATA_CADSERV IS

        FUNCTION FN_RESCATA_CADSERVICIO (v_Num_Abondo IN number, v_Num_Movimiento IN number, v_Cod_Accion IN number, v_cod_comando IN number, v_num_orden IN number, v_num_ooss IN number) RETURN STRING;

END IC_PKG_RESCATA_CADSERV;
/
SHOW ERRORS