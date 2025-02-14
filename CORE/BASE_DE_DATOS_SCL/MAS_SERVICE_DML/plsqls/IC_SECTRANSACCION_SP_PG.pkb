CREATE OR REPLACE PACKAGE BODY IC_SECTRANSACCION_SP_PG AS

PROCEDURE IC_INSERTA_SEC_PR ( EN_COD_PROD_CONTRATADO IN IC_SECTRANSACCION_TO.COD_PROD_CONTRATADO%TYPE,
                                                  EN_NUM_CELULAR IN IC_SECTRANSACCION_TO.NUM_CELULAR%TYPE,
                                                  EN_NUM_MOV_ORIGEN IN IC_SECTRANSACCION_TO.NUM_MOV_ORIGEN%TYPE,
                                                  SN_ERROR OUT NOCOPY NUMBER,
                                                  SV_MENSAJE OUT NOCOPY VARCHAR2,
                                                  SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_SECTRANSACCION_SP_PG"
      Lenguaje="PL/SQL"
      Fecha creación="ENE-2008"
      Creado por="Juan Gonzalez C."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Inserta Datos en tabla IC_SECTRANSACCION_TO </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_COD_PROD_CONTRATADO"         Tipo="NUMERICO"> Codigo de Producto Contratado </param>
            <param nom="EN_NUM_CELULAR"         Tipo="NUMERICO"> Numero de Celular </param>
            <param nom="EN_NUM_MOV_ORIGEN"         Tipo="NUMERICO"> Numero de Movimiento Asociado </param>
         </Entrada>
         <Salida>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql VARCHAR2(1000);

BEGIN
SN_ERROR := 0;
SV_MENSAJE := NULL;
SN_EVENTO := 0;

LV_Sql := 'INSERT INTO IC_SECTRANSACCION_TO (...) VALUES(...)';

INSERT INTO IC_SECTRANSACCION_TO
(
        COD_PROD_CONTRATADO,
        NUM_CELULAR,
        ID_SECUENCIA,
        NUM_MOV_ORIGEN,
        FEC_INGRESO
)
VALUES
(
        EN_COD_PROD_CONTRATADO,
        EN_NUM_CELULAR,
        0,
        EN_NUM_MOV_ORIGEN,
        SYSDATE
);

EXCEPTION
        WHEN OTHERS THEN
                SN_ERROR := 1006;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := GE_ERRORES_PG.GRABARPL(0, 'IC_SECTRANSACCION_SP_PG.IC_INSERTA_SEC_PR', SQLERRM, CV_version,USER, 'IC_SECTRANSACCION_SP_PG', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_INSERTA_SEC_PR;

END IC_SECTRANSACCION_SP_PG;
/
SHOW ERRORS
