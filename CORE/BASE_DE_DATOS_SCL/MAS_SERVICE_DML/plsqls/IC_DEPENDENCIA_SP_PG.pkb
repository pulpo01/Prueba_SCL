CREATE OR REPLACE PACKAGE BODY IC_DEPENDENCIA_SP_PG AS

------------------------------------------------------------
PROCEDURE IC_INSERTA_DEPENDENCIA_PR ( EN_NUM_MOVIMIENTO IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                      EN_NUM_MOVANT IN ICC_MOVIMIENTO.NUM_MOVANT%TYPE,
                                      SN_ERROR OUT NOCOPY NUMBER,
                                      SV_MENSAJE OUT NOCOPY VARCHAR2,
                                      SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_INSERTA_DEPENDENCIA_PG"
      Lenguaje="PL/SQL"
      Fecha creación="ENE-2008"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Inserta Datos en tabla IC_MOVIMIENTO_DEPENDIENTE_TO </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_MOVIMIENTO"         Tipo="NUMERICO"> Numero de Movimiento </param>
            <param nom="EN_NUM_MOVANT"         Tipo="NUMERICO"> Numero de Movimiento Anterior </param>
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

LV_Sql := 'INSERT INTO IC_MOVIMIENTO_DEPENDIENTE_TO (...) VALUES(...)';

INSERT INTO IC_MOVIMIENTO_DEPENDIENTE_TO
(
        NUM_MOVIMIENTO,
        NUM_MOVANT
)
VALUES
(
        EN_NUM_MOVIMIENTO,
        EN_NUM_MOVANT
);

EXCEPTION
        WHEN OTHERS THEN
                SN_ERROR := 775;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := GE_ERRORES_PG.GRABARPL(0, 'IC_SECTRANSACCION_SP_PG.IC_INSERTA_DEPENDENCIA_PR', SQLERRM, CV_version,USER, 'IC_SECTRANSACCION_SP_PG', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_INSERTA_DEPENDENCIA_PR;

------------------------------------------------------------
PROCEDURE IC_ACTIVA_DEPENDIENTE_PR (
                                    SN_LEIDOS OUT NOCOPY NUMBER,
                                    SN_ACTIVADOS OUT NOCOPY NUMBER,
                                    SN_ERROR OUT NOCOPY NUMBER,
                                    SV_MENSAJE OUT NOCOPY VARCHAR2,
                                    SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_ACTIVA_DEPENDIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha creación="04-01-2008"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Busca los movimientos a activar de acuerdo al movimiento del cual es dependiente y luego elimina el registro de movimiento dependiente</Descripción>
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
sSql GE_Errores_PG.vQuery;
LV_Tabla VARCHAR2(1000);
LN_Activados number := 0;
LN_Leidos number := 0;
LN_Found  number := 0;
ST_cont  number := 0;
ERROR_CONTROLADO EXCEPTION;

CURSOR c_dep IS
        SELECT a.num_movimiento, a.num_movant
        FROM  ic_movimiento_dependiente_to a;

r_dep c_dep%ROWTYPE;

BEGIN
        SN_ERROR := 0;
        SV_MENSAJE := NULL;
        SN_EVENTO := 0;

        OPEN c_dep;

		LOOP
              FETCH c_dep INTO r_dep;
			  EXIT WHEN c_dep%NOTFOUND; -- Último registro.

		      ST_cont := 0;

              SELECT COUNT(1) INTO ST_cont
              FROM icc_movimiento
              WHERE num_movimiento = r_dep.num_movant;

              IF ST_cont = 0 THEN

                   LV_Tabla := 'ICC_HISTMOV' || TO_CHAR(SYSDATE,'MMYYYY');

                   -- Busca otros abonados del cliente que tengan efectivamente activo un servicio de Atlantida.
                   sSql := 'SELECT COUNT(1) FROM ' || LV_Tabla;
                   sSql := sSql || ' WHERE  num_movimiento = ' || r_dep.num_movant;

                   EXECUTE IMMEDIATE sSql INTO ST_cont;

                   IF ST_cont = 0 THEN

                       LV_Tabla := 'ICC_HISTMOV' || TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MMYYYY');

                       -- Busca otros abonados del cliente que tengan efectivamente activo un servicio de Atlantida.
                       sSql := 'SELECT COUNT(1) FROM ' || LV_Tabla;
                       sSql := sSql || ' WHERE  num_movimiento = ' || r_dep.num_movant;

                       EXECUTE IMMEDIATE sSql INTO ST_cont;

    		           IF ST_cont = 0 THEN
                            -- FIN Sin desbloqueo.
							LN_Found := 0;
					   ELSE
					      LN_Found := 1;
                       END IF;
                   ELSE
				      LN_Found := 1;
				   END IF;

              ELSE
			      LN_Found := 1;
              END IF;

			  IF LN_Found = 1 THEN

                  UPDATE icc_movimiento
                  SET cod_estado = 1, ind_bloqueo = 0
                  WHERE num_movimiento = r_dep.num_movimiento
                  AND   cod_estado = CN_EstPendActivacion
                  AND   ind_bloqueo <> CN_desbloqueado;

                  LN_Activados := LN_Activados + sql%rowcount;

                  DELETE ic_movimiento_dependiente_to
                  WHERE num_movimiento = r_dep.num_movimiento;
              END IF;

		      --EXIT WHEN c_dep%NOTFOUND; -- Último registro.
        END LOOP;

		LN_Leidos := c_dep%ROWCOUNT;
        CLOSE c_dep;

        SV_MENSAJE := 'OK';
		SN_LEIDOS := LN_Leidos;
		SN_ACTIVADOS := LN_Activados;

EXCEPTION
        WHEN ERROR_CONTROLADO THEN
           IF NOT Ge_Errores_Pg.MensajeError(SN_ERROR,SV_MENSAJE) THEN
              SV_MENSAJE := CV_error_no_clasif||' ( '||SV_MENSAJE||' )';
		   END IF;
	       SN_EVENTO := Ge_Errores_Pg.GrabarPL( SN_EVENTO, CV_cod_modulo, SN_ERROR || ' ' || SV_MENSAJE, CV_version, USER, 'IC_PROVISION_PG.IC_ACTIVA_DEPENDIENTE_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
        WHEN OTHERS THEN
                SN_LEIDOS := LN_Leidos;
                SN_ACTIVADOS := LN_Activados;
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SV_MENSAJE || SQLERRM;
                SN_EVENTO := Ge_Errores_Pg.GrabarPL(0, 'IC_PROVISION_PG.IC_ACTIVA_DEPENDIENTE_PR', SQLERRM, CV_version,USER, 'IC_PROVISION_PG', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_ACTIVA_DEPENDIENTE_PR;

--------------------------------------------------
FUNCTION IC_VALIDA_DEPENDENCIA_FN(
        EN_num_movant IN icc_movimiento.num_movant%TYPE
		) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_VALIDA_DEPENDENCIA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="02-2008"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción> Funcion para obtener la cadena de comando asociada a un movimiento de Alta de Bonos Dinero </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO"> Numero del Movimiento </param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_cod_retorno ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.msgerror;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);

        sSql GE_Errores_PG.vQuery;

        LV_Sql VARCHAR2(1000);
        LV_Tabla VARCHAR2(1000);
        ST_cont  number := 0;

BEGIN

              sSql := 'SELECT COUNT(1) FROM icc_movimiento';
              sSql := sSql || ' WHERE  num_movimiento = ' || EN_num_movant;

		      ST_cont := 0;

              SELECT COUNT(1) INTO ST_cont
              FROM icc_movimiento
              WHERE num_movimiento = EN_num_movant;

              IF ST_cont = 0 THEN

                   LV_Tabla := 'ICC_HISTMOV' || TO_CHAR(SYSDATE,'MMYYYY');

                   -- Busca otros abonados del cliente que tengan efectivamente activo un servicio de Atlantida.
                   sSql := 'SELECT COUNT(1) FROM ' || LV_Tabla;
                   sSql := sSql || ' WHERE  num_movimiento = ' || EN_num_movant;

                   EXECUTE IMMEDIATE sSql INTO ST_cont;

                   IF ST_cont = 0 THEN

                       LV_Tabla := 'ICC_HISTMOV' || TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MMYYYY');

                       -- Busca otros abonados del cliente que tengan efectivamente activo un servicio de Atlantida.
                       sSql := 'SELECT COUNT(1) FROM ' || LV_Tabla;
                       sSql := sSql || ' WHERE  num_movimiento = ' || EN_num_movant;

                       EXECUTE IMMEDIATE sSql INTO ST_cont;

    		           IF ST_cont = 0 THEN
                            -- FIN Sin desbloqueo.
							return 'FALSE';
					   ELSE
					      return 'TRUE';
                       END IF;
                   ELSE
				      return 'TRUE';
				   END IF;
              ELSE
			      return 'TRUE';
              END IF;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Error_No_Clasif;
                END IF;
                LV_des_error := 'IC_GENERACOMANDO_PG.IC_VALIDA_DEPENDENCIA_FN('||EN_num_movant||'); - ' || SQLERRM;
                LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_GENERACOMANDO_PG.IC_VALIDA_DEPENDENCIA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END IC_VALIDA_DEPENDENCIA_FN;


END IC_DEPENDENCIA_SP_PG;
/
SHOW ERRORS
