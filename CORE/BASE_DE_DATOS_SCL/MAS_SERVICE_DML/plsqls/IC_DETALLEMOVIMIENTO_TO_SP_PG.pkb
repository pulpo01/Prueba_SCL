CREATE OR REPLACE PACKAGE BODY IC_DETALLEMOVIMIENTO_TO_SP_PG AS

PROCEDURE IC_INSERTA_DETMOV_PR ( EO_DETMOVTO IN OUT NOCOPY IC_DETALLEMOV_TO_QT,
                                                          SN_ERROR OUT NOCOPY NUMBER,
                                                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                                                          SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_DETALLEMOVIMIENTO_TO_SP_PG"
      Lenguaje="PL/SQL"
      Fecha creación="20-09-2007"
      Creado por="Juan Gonzalez C."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Inserta Datos en tabla IC_DETALLEMOVIMIENTO_TO </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EO_DETMOVTO"         Tipo="OBJETO"> Object Type de la tabla IC_DETALLEMOVIMIENTO_TO </param>
         </Entrada>
         <Salida>
            <param nom="EO_DETMOVTO"         Tipo="OBJETO"> Object Type de la tabla IC_DETALLEMOVIMIENTO_TO </param>
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

LV_Sql := ' INSERT INTO IC_DETALLE_MOVIMIENTO_TO';
LV_Sql := LV_Sql ||' (';
LV_Sql := LV_Sql ||' NUM_MOVIMIENTO,';
LV_Sql := LV_Sql ||' NOM_SUBPARAMETRO,';
LV_Sql := LV_Sql ||' VAL_SUBPARAMETRO';
LV_Sql := LV_Sql ||' )';
LV_Sql := LV_Sql ||' VALUES';
LV_Sql := LV_Sql ||' (';
LV_Sql := LV_Sql ||' '|| EO_DETMOVTO.NUM_MOVIMIENTO;
LV_Sql := LV_Sql ||', '|| EO_DETMOVTO.NOM_SUBPARAMETRO;
LV_Sql := LV_Sql ||', '|| EO_DETMOVTO.VAL_SUBPARAMETRO;
LV_Sql := LV_Sql ||' )';

INSERT INTO IC_DETALLE_MOVIMIENTO_TO
(
        NUM_MOVIMIENTO,
        NOM_SUBPARAMETRO,
        VAL_SUBPARAMETRO
)
VALUES
(
        EO_DETMOVTO.NUM_MOVIMIENTO,
        EO_DETMOVTO.NOM_SUBPARAMETRO,
        EO_DETMOVTO.VAL_SUBPARAMETRO
);

EXCEPTION
        WHEN OTHERS THEN
                SN_ERROR := 1007;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := GE_ERRORES_PG.GRABARPL(0, 'IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR', SQLERRM, CV_version,USER, 'IC_DETALLEMOVIMIENTO_TO_SP_PG', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_INSERTA_DETMOV_PR;

END IC_DETALLEMOVIMIENTO_TO_SP_PG;
/
SHOW ERRORS
