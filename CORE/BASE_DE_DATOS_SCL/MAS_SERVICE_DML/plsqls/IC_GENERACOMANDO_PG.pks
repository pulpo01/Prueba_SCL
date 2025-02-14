CREATE OR REPLACE PACKAGE IC_GENERACOMANDO_PG
/*
<Documentación
        TipoDoc = "Package">
        <Elemento
                Nombre = "IC_GENERACOMANDO_PG"
                Lenguaje="PL/SQL"
                Fecha creación="10-2007"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>N/A</Retorno>
                <Descripción> Contiene funciones que rescatan valores de parametros para ser enviados en los Comandos hacia las Plataforma </Descripción>
                <Parámetros>
                        <Entrada>N/A</Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
IS
        CN_Producto CONSTANT NUMBER(1) := 1;
        CV_Modulo_Cen CONSTANT VARCHAR2(2) := 'IC';
        CN_Err_Abo CONSTANT NUMBER(3) := 203;
        CN_Err_Cli CONSTANT NUMBER(3) := 149;
        CN_Err_Usuario CONSTANT NUMBER(7) := 300008;
        CN_Err_Cel CONSTANT NUMBER(3) := 480;
        CV_Err_NoClasif CONSTANT VARCHAR2(25) := 'Error no Clasificado';

        CV_Existe CONSTANT VARCHAR2(2) := '1';
        CV_Ejecuta CONSTANT VARCHAR2(2) := '1';
        CV_NoTiene CONSTANT VARCHAR2(2) := '1';
        CV_NoData CONSTANT VARCHAR2(2) := '0';
        CN_PlanPrep  CONSTANT NUMBER(1) := 1;
        CN_PlanPost  CONSTANT NUMBER(1) := 2;
        CN_PlanHibr  CONSTANT NUMBER(1) := 3;

        CV_CodOperadora CONSTANT VARCHAR2(9) := 'TMCOL';

        CV_CmdAltaBonoSMS CONSTANT VARCHAR2(11) := '<datBonSms>';
        CV_CmdAltaBonoRec CONSTANT VARCHAR2(11) := '<datBonRec>';
        CV_CmdBajaBono CONSTANT VARCHAR2(13)    := '<datBajaBono>';
        CV_CmdAltaListaFrec CONSTANT VARCHAR2(16) := '<datAltaLista>';
        CV_CmdBajaListaFrec CONSTANT VARCHAR2(16) := '<datBajaLista>';

--------------------------------------------------
FUNCTION IC_ALTABONOS_SMS_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
		) RETURN STRING;

--------------------------------------------------
FUNCTION IC_ALTABONOS_REC_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
		) RETURN STRING;

--------------------------------------------------
FUNCTION IC_BAJABONOS_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
		) RETURN STRING;

--------------------------------------------------
FUNCTION IC_ALTALISTA_FREC_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
		) RETURN STRING;

--------------------------------------------------
FUNCTION IC_BAJALISTA_FREC_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
		) RETURN STRING;


FUNCTION IC_INFORMA_PA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
  ) RETURN STRING;
  
END IC_GENERACOMANDO_PG;
/
SHOW ERRORS
