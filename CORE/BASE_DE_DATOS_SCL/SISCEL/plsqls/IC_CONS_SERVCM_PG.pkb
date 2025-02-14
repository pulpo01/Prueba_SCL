CREATE OR REPLACE PACKAGE BODY IC_CONS_SERVCM_PG AS

------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION IC_CONS_BLACKBERRY_FN (V_Num_Movimiento  IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2

/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_CONS_BLACKBERRY_PR"
      Lenguaje="PL/SQL"
      Fecha creación="10-09-2007"
      Creado por="Juan Gonzalez C."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Consulta si el Abonado tiene el Servicio Blackberry </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_ABONADO"         Tipo="NUMERICO"> Numero del Abonado </param>
            <param nom="SN_TIENE_SERV"         Tipo="CARACTER"> Indicador de Servicio (Tiene = '1' - No Tiene = 'FALSE' ) </param>
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
LN_Cod_ServSupl ga_servsuplabo.cod_servsupl%TYPE;
LN_Cod_Nivel ga_servsuplabo.cod_nivel%TYPE;
LN_Can_Filas NUMBER;
LN_num_abonado icc_movimiento.NUM_ABONADO%TYPE;
SV_IND_SERVICIO VARCHAR2(10);
SN_ERROR NUMBER;
SV_MENSAJE ge_errores_td.det_msgerror%TYPE;
SN_EVENTO NUMBER;


CURSOR c_abon (n_abonado icc_movimiento.NUM_ABONADO%TYPE)IS
        SELECT a.cod_servsupl, a.cod_nivel
        FROM ga_servsuplabo a
        WHERE a.num_abonado = n_abonado;

BEGIN
        SV_IND_SERVICIO := 'FALSE';
        SN_ERROR := 0;
        SV_MENSAJE := NULL;
        SN_EVENTO := 0;

        LV_Sql := 'OPEN c_abon; LOOP FETCH c_abon';

		SELECT NUM_ABONADO
		INTO LN_num_abonado
		FROM ICC_MOVIMIENTO
		WHERE NUM_MOVIMIENTO = V_Num_Movimiento;

        OPEN c_abon(LN_num_abonado);
        LOOP
                FETCH c_abon INTO LN_Cod_ServSupl, LN_Cod_Nivel;

                SELECT COUNT(1)
                INTO LN_Can_Filas
                FROM ged_codigos
                WHERE cod_modulo = CV_Cod_Modulo
                AND nom_tabla = CV_Tab_Blackberry
                AND nom_columna = TO_CHAR(LN_Cod_ServSupl)
                AND cod_valor = TO_CHAR(LN_Cod_Nivel);

                IF LN_Can_Filas > 0 THEN
                        SV_IND_SERVICIO := '1';
                        EXIT;
                END IF;

                EXIT WHEN c_abon%NOTFOUND;
        END LOOP;
		RETURN SV_IND_SERVICIO;

EXCEPTION
        WHEN OTHERS THEN
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := GE_ERRORES_PG.GRABARPL(0, 'IC_CONS_SERVCM_PG.IC_CONS_BLACKBERRY_PR', SQLERRM, CV_Version,USER, 'IC_CONS_SERVCM_PG', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_CONS_BLACKBERRY_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION IC_CONS_CORREOMOVIL_FN (V_Num_Movimiento  IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_CONS_CORREOMOVIL_PR"
      Lenguaje="PL/SQL"
      Fecha creación="10-09-2007"
      Creado por="Juan Gonzalez C."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Consulta si el Abonado tiene el Correo Movil </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_ABONADO"         Tipo="NUMERICO"> Numero del Abonado </param>
            <param nom="SN_TIENE_SERV"         Tipo="CARACTER"> Indicador de Servicio (Tiene = '1' - No Tiene = 'FALSE' ) </param>
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
LN_Cod_ServSupl ga_servsuplabo.cod_servsupl%TYPE;
LN_Cod_Nivel ga_servsuplabo.cod_nivel%TYPE;
LN_Can_Filas NUMBER;
LN_num_abonado icc_movimiento.NUM_ABONADO%TYPE;
SV_IND_SERVICIO VARCHAR2(10);
SN_ERROR NUMBER;
SV_MENSAJE ge_errores_td.det_msgerror%TYPE;
SN_EVENTO NUMBER;


CURSOR c_abon (n_abonado icc_movimiento.NUM_ABONADO%TYPE)IS
        SELECT a.cod_servsupl, a.cod_nivel
        FROM ga_servsuplabo a
        WHERE a.num_abonado = n_abonado;

BEGIN
        SV_IND_SERVICIO := 'FALSE';
        SN_ERROR := 0;
        SV_MENSAJE := NULL;
        SN_EVENTO := 0;

        LV_Sql := 'OPEN c_abon; LOOP FETCH c_abon';

		SELECT NUM_ABONADO
		INTO LN_num_abonado
		FROM ICC_MOVIMIENTO
		WHERE NUM_MOVIMIENTO = V_Num_Movimiento;

        OPEN c_abon(LN_num_abonado);
        LOOP
                FETCH c_abon INTO LN_Cod_ServSupl, LN_Cod_Nivel;

                SELECT COUNT(1)
                INTO LN_Can_Filas
                FROM ged_codigos
                WHERE cod_modulo = CV_Cod_Modulo
                AND nom_tabla = CV_Tab_CorreoMov
                AND nom_columna = TO_CHAR(LN_Cod_ServSupl)
                AND cod_valor = TO_CHAR(LN_Cod_Nivel);

                IF LN_Can_Filas > 0 THEN
                        SV_IND_SERVICIO := '1';
                        EXIT;
                END IF;

                EXIT WHEN c_abon%NOTFOUND;
        END LOOP;
		RETURN SV_IND_SERVICIO;

EXCEPTION
        WHEN OTHERS THEN
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := GE_ERRORES_PG.GRABARPL(0, 'IC_CONS_SERVCM_PG.IC_CONS_CORREOMOVIL_PR', SQLERRM, CV_Version,USER, 'IC_CONS_SERVCM_PG', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_CONS_CORREOMOVIL_FN;

END IC_CONS_SERVCM_PG;
/
SHOW ERRORS
