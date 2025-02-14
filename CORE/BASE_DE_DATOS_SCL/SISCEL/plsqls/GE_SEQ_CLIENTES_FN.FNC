CREATE OR REPLACE FUNCTION GE_SEQ_CLIENTES_FN(EN_NUM_TRANSACCION IN NUMBER) RETURN NUMBER
IS
/*
<documentación tipodoc = "Funcion">
	<elemento nombre = "GE_SEQ_CLIENTES_FN" lenguaje="PL/SQL" fecha="24-10-2005" versión"1.1.0" diseñador"Lidia Ponce" programador="Vladimir Maureira" ambiente="BD">
		<retorno>0</retorno>
		<descripción>"Funcion que retorna un nuevo codigo de cliente" </descripción>
		<parámetros>
			<entrada>
			  <param nom="EN_num_transaccion" Tipo="VARCHAR2">transaccion</param>
			</entrada>
			<salida>
			</salida>
		</parámetros>
	</elemento>
</documentación>
*/
PRAGMA AUTONOMOUS_TRANSACTION;
ERROR_EJECUCION  EXCEPTION;

LN_RETORNO       NUMBER;
LV_CONVIVEELITE  VARCHAR2(1):='N';

LV_COD_MODULO    VARCHAR2(2):='GA';
LN_COD_PRODUCTO  NUMBER:=1;
LV_PARAMELITE    VARCHAR2(20):='IND_CONVIVEELITE_SCL';

LN_INIELITE      NUMBER:=0;
LN_FINELITE      NUMBER:=0;
LN_INISCL        NUMBER:=0;
LN_FINSCL        NUMBER:=0;

LN_INI           NUMBER:=0;
LN_FIN           NUMBER:=0;

LV_INIELITE      VARCHAR2(18):='INI_CLIENTES_ELITE';
LV_FINELITE      VARCHAR2(18):='FIN_CLIENTES_ELITE';
LV_INISCL        VARCHAR2(16):='INI_CLIENTES_SCL';
LV_FINSCL        VARCHAR2(16):='FIN_CLIENTES_SCL';


LN_RESTA         NUMBER:=0;
LV_SQL           VARCHAR2(100):='';

LV_SI            VARCHAR2(1):='S';
LB_ENCONTRADO    BOOLEAN:=FALSE;
LN_CODCLIENTE    GE_CLIENTES_TMP_TD.COD_CLIENTE%TYPE;
LN_COD_RETORNO   NUMBER(1);

BEGIN

	--Obtiene parametro de Elite
	LV_CONVIVEELITE := ge_fn_devvalparam(LV_cod_modulo,LN_cod_producto,LV_PARAMELITE);

	IF LV_CONVIVEELITE = LV_SI THEN

		--Se recuperan los rangos privados
		LN_INIELITE:= TO_NUMBER(ge_fn_devvalparam(LV_cod_modulo,LN_cod_producto,LV_INIELITE));
		LN_FINELITE:= TO_NUMBER(ge_fn_devvalparam(LV_cod_modulo,LN_cod_producto,LV_FINELITE));
		LN_INISCL  := TO_NUMBER(ge_fn_devvalparam(LV_cod_modulo,LN_cod_producto,LV_INISCL));
		LN_FINSCL  := TO_NUMBER(ge_fn_devvalparam(LV_cod_modulo,LN_cod_producto,LV_FINSCL));

		--Ciclo para obtener un codigo cliente nuevo
		WHILE NOT LB_ENCONTRADO	LOOP

			--Obtiene cod cliente
			SELECT GE_SEQ_CLIENTES.NEXTVAL INTO LN_RETORNO FROM DUAL;

			--Verifica que no exista en Tabla temporal de clientes
			BEGIN

				SELECT COD_CLIENTE
				INTO LN_CODCLIENTE
				FROM GE_CLIENTES_TMP_TD
				WHERE COD_CLIENTE = LN_RETORNO;

				--Si existe debe buscar otro codigo
				LB_ENCONTRADO:=FALSE;

			EXCEPTION
				WHEN NO_DATA_FOUND THEN
				    --no existe verificar que no exista en tabla de CLIENTES
					LB_ENCONTRADO := TRUE;

				WHEN OTHERS THEN
					RAISE ERROR_EJECUCION;
			END;


			--No se encontro, verificar en tabla de clientes
			IF LB_ENCONTRADO THEN

		 		LB_ENCONTRADO:=FALSE;

				BEGIN

					SELECT COD_CLIENTE
					INTO LN_CODCLIENTE
					FROM GE_CLIENTES
					WHERE COD_CLIENTE = LN_RETORNO;

					--Si existe debe buscar otro codigo
					LB_ENCONTRADO:=FALSE;

				EXCEPTION
					WHEN NO_DATA_FOUND THEN
				    	--no existe verificar que no exista en tabla de parametros
						LB_ENCONTRADO := TRUE;

					WHEN OTHERS THEN
						RAISE ERROR_EJECUCION;
				END;

			END IF;

			--No se encontro, verificar en tabla de parametros (RANGOS PRIVADOS)
			IF LB_ENCONTRADO THEN

		 		LB_ENCONTRADO:=FALSE;

				IF (LN_RETORNO >= LN_INIELITE and LN_RETORNO <= LN_FINELITE) THEN
				    --encontrado! se debe obtener otro codigo cliente y verificar nuevamente
					LN_FIN := LN_FINELITE;
				ELSIF (LN_RETORNO >= LN_INISCL and LN_RETORNO <= LN_FINSCL) THEN
				    --encontrado! se debe obtener otro codigo cliente y verificar nuevamente
					LN_FIN := LN_FINSCL;
				Else
					--Codigo cliente no existe en los rangos privados, codigo nuevo correcto! sale de loop
					LB_ENCONTRADO:=TRUE;
				END IF;

				--En caso de encontrar codigo dentro de rangos, generar numeracion hasta el final del rango
				--volver a preguntar si existe el nuevo codigo dentro de algun rango.
				IF NOT LB_ENCONTRADO THEN

				   LN_RESTA := LN_FIN - LN_RETORNO;

				   -- Configurar la secuencia para que se incremente de a LN_RESTA
				   LV_SQL := 'alter sequence GE_SEQ_CLIENTES increment by ' || LN_RESTA ;
  				   EXECUTE IMMEDIATE LV_SQL ;

				   -- Hacer que la secuencia tome el valor siguiente
				   select GE_SEQ_CLIENTES.nextval INTO LN_RETORNO from dual ;

				   -- Configurar nuevamente el incremento de la secuencia a 1
				   LV_SQL := 'alter sequence GE_SEQ_CLIENTES increment by 1' ;
				   EXECUTE IMMEDIATE LV_SQL ;

				END IF;

			END IF;

		END LOOP;
		--Fin Ciclo para obtener un codigo cliente nuevo
	Else
		--Obtiene cod cliente
		SELECT GE_SEQ_CLIENTES.NEXTVAL INTO LN_RETORNO FROM DUAL;
	END IF;

        IF EN_NUM_TRANSACCION <> 0 THEN
            IF LN_RETORNO = 0 THEN
               LN_cod_retorno := 1;
            ELSE
               LN_cod_retorno := 0;
            END IF;

             INSERT INTO GA_TRANSACABO
                  (num_transaccion, cod_retorno, des_cadena)
             VALUES
                  (EN_NUM_TRANSACCION,LN_COD_RETORNO,LN_RETORNO);
        END IF;

        COMMIT;

	RETURN LN_RETORNO;

EXCEPTION
WHEN ERROR_EJECUCION THEN
	RAISE_APPLICATION_ERROR(-20100, 'ERROR EN TABLA TEMPORAL CLIENTES' || TO_CHAR(SQLCODE) || ': ' || SQLERRM);
WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR(-20100, 'ERROR EN BUSQUEDA DE CODIGO CLIENTE' || TO_CHAR(SQLCODE) || ': ' || SQLERRM);
END GE_SEQ_CLIENTES_FN;
/
SHOW ERRORS
