CREATE OR REPLACE PACKAGE BODY IC_PROGRAMACION_SP_PG AS

------------------------------------------------------------
PROCEDURE IC_INSERTA_PROGRAMADO_PR ( EN_NUM_MOVIMIENTO IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                      EN_FEC_ACTIVACION IN DATE,
                                      SN_ERROR OUT NOCOPY NUMBER,
                                      SV_MENSAJE OUT NOCOPY VARCHAR2,
                                      SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_INSERTA_PROGRAMADO_PG"
      Lenguaje="PL/SQL"
      Fecha creación="ENE-2008"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Inserta Datos en tabla IC_PROGRAMACION_MOVIMIENTO_TO </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_MOVIMIENTO"         Tipo="NUMERICO"> Numero de Movimiento </param>
            <param nom="EN_FEC_ACTIVACION"         Tipo="DATE"> Fecha de activacion </param>
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

LV_Sql := 'INSERT INTO IC_PROGRAMACION_MOVIMIENTO_TO (...) VALUES(...)';

INSERT INTO IC_PROGRAMACION_MOVIMIENTO_TO
(
        NUM_MOVIMIENTO,
        FEC_ACTIVACION
)
VALUES
(
        EN_NUM_MOVIMIENTO,
        EN_FEC_ACTIVACION
);

EXCEPTION
        WHEN OTHERS THEN
                SN_ERROR := 775;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := GE_ERRORES_PG.GRABARPL(0, 'IC_SECTRANSACCION_SP_PG.IC_INSERTA_PROGRAMADO_PR', SQLERRM, CV_version,USER, 'IC_SECTRANSACCION_SP_PG', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_INSERTA_PROGRAMADO_PR;


------------------------------------------------------------
PROCEDURE IC_ACTIVA_MOVPROGRAMADO_PR (
                                    SN_LEIDOS OUT NOCOPY NUMBER,
                                    SN_ACTIVADOS OUT NOCOPY NUMBER,
                                    SN_ERROR OUT NOCOPY NUMBER,
                                    SV_MENSAJE OUT NOCOPY VARCHAR2,
                                    SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_ACTIVA_MOVPROGRAMADO_PR"
      Lenguaje="PL/SQL"
      Fecha creación="04-01-2008"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Busca los movimientos a activar de acuerdo a la fecha, los activa y luego elimina el registro de las fechas</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type </param>
         </Entrada>
         <Salida>
            <param nom="SN_LEIDOS"       Tipo="NUMERICO">Numero de Registros leidos</param>
            <param nom="SN_ACTIVADOS"    Tipo="NUMERICO">Numero de Movimientos activados</param>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"      Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql VARCHAR2(1000);
LN_Activados number := 0;
LN_Leidos number := 0;

ERROR_CONTROLADO EXCEPTION;

CURSOR c_act IS
        SELECT a.num_movimiento, a.fec_activacion
        FROM  ic_programacion_movimiento_to a
        WHERE a.fec_activacion <= SYSDATE;

r_act c_act%ROWTYPE;

BEGIN
        SN_ERROR := 0;
        SV_MENSAJE := NULL;
        SN_EVENTO := 0;

        OPEN c_act;

        LOOP
                FETCH c_act INTO r_act;
                EXIT WHEN c_act%NOTFOUND; -- Último registro.

				UPDATE icc_movimiento
				SET cod_estado = 1, des_respuesta = CV_DescEstado, ind_bloqueo = 0
				WHERE num_movimiento = r_act.num_movimiento
				AND   cod_estado = CN_EstPendActivacion
				AND   ind_bloqueo <> CN_desbloqueado;

                LN_Activados := LN_Activados + sql%rowcount;

                DELETE ic_programacion_movimiento_to
				WHERE num_movimiento = r_act.num_movimiento;

		        EXIT WHEN c_act%NOTFOUND; -- Último registro.
        END LOOP;

		LN_Leidos := c_act%ROWCOUNT;
        CLOSE c_act;

        SV_MENSAJE := 'OK';
		SN_LEIDOS := LN_Leidos;
		SN_ACTIVADOS := LN_Activados;

EXCEPTION
        WHEN ERROR_CONTROLADO THEN
           IF NOT Ge_Errores_Pg.MensajeError(SN_ERROR,SV_MENSAJE) THEN
              SV_MENSAJE := CV_error_no_clasif||' ( '||SV_MENSAJE||' )';
		   END IF;
	       SN_EVENTO := Ge_Errores_Pg.GrabarPL( SN_EVENTO, CV_cod_modulo, SN_ERROR || ' ' || SV_MENSAJE, CV_version, USER, 'IC_PROVISION_PG.IC_ACTIVA_MOVPROGRAMADO_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
        WHEN OTHERS THEN
                SN_LEIDOS := LN_Leidos;
                SN_ACTIVADOS := LN_Activados;
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SV_MENSAJE || SQLERRM;
                SN_EVENTO := Ge_Errores_Pg.GrabarPL(0, 'IC_PROVISION_PG.IC_ACTIVA_MOVPROGRAMADO_PR', SQLERRM, CV_version,USER, 'IC_PROVISION_PG', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_ACTIVA_MOVPROGRAMADO_PR;

END IC_PROGRAMACION_SP_PG;
/
SHOW ERRORS
