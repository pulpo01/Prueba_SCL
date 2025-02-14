CREATE OR REPLACE PACKAGE PV_DATOS_CLIENTES2_PG
IS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CN_cod_ret_no_found       CONSTANT NUMBER(4)  := 1162;

    CN_LISTA_NULA constant number:=1;


--------------------------------------------------------------------------------------------------------
--1.- Metodo obtenerDatos   (PL nueva)
    PROCEDURE PV_OBTIENE_DATOS_CLIENTE_PR(
                   SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE2_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------

END PV_DATOS_CLIENTES2_PG;
/
SHOW ERRORS
