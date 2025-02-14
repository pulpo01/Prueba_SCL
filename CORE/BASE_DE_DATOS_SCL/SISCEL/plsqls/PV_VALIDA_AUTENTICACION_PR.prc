CREATE OR REPLACE PROCEDURE PV_VALIDA_AUTENTICACION_PR (
          v_secuencia      IN  ga_transacabo.NUM_TRANSACCION%type,
          v_numserie       IN  VARCHAR2,
          v_procedencia    IN  VARCHAR2,
          v_coduso         IN  ga_abocel.COD_USO%TYPE
) IS

-- Procedimiento que  valida la autenticacion de posvetna, en las distintas operadoras.
-- Creacion     : 09-septiembre de 2002
-- Modificacion :
-- Autor        : Karem Fernandez Ayala


v_contakeys          NUMBER;
v_contservsupl       NUMBER;
v_cod_operadora      ge_operadora_scl.cod_operadora_scl%type;

v_cod_retorno        ga_transacabo.cod_retorno%type;
v_des_cadena         ga_transacabo.des_cadena%type;
v_cod_uso            ga_abocel.cod_uso%type;
v_ind_usoventa       al_usos.ind_usoventa%type;
v_cod_estado         ict_akeys.cod_estado%type;
v_num_abonado        ga_abocel.num_abonado%type;
v_cod_servsupl       ga_servsupl.cod_servsupl%type;
v_cod_servicio       ga_servsupl.cod_servicio%type;
v_cod_sqlcode        ga_errores.cod_sqlcode%type;
v_cod_sqlerrm        ga_errores.cod_sqlerrm%type;
v_val_parametro      ged_parametros.VAL_PARAMETRO%type;

c_retorno0           CONSTANT ga_transacabo.cod_retorno%type := 0; /*  Continua con la PosVenta en MPR-TMC*/
c_retorno1           CONSTANT ga_transacabo.cod_retorno%type := 1; /*  No continua la operacion en Posventa-MPR */
c_retorno2           CONSTANT ga_transacabo.cod_retorno%type := 2; /*  TMC=Inserta Akeys con estado -1 / Act-Des Servicio Suplementario'*/
c_retorno3           CONSTANT ga_transacabo.cod_retorno%type := 3; /*  TMC=Actualiza Akeys en estado 1 / Act-Des Servicio Suplementario'*/
c_retorno4           CONSTANT ga_transacabo.cod_retorno%type := 4; /*  Error Others - No Data Found -- etc */
c_retorno5           CONSTANT ga_transacabo.cod_retorno%type := 5; /*  TMC='Act-Des Servicio Suplementario'*/



BEGIN


         /* Obtenemos operadora */

          v_cod_retorno := c_retorno0;
          v_des_cadena  := 'Obteniendo Codigo de Operadora';

		  BEGIN
			  SELECT VAL_PARAMETRO
			    INTO  v_val_parametro
			    FROM  GED_PARAMETROS
			   WHERE NOM_PARAMETRO = 'OPER_AUTENTICACION'
			     AND COD_MODULO = 'GA'
				 AND COD_PRODUCTO = 1;
		  EXCEPTION
 	           WHEN NO_DATA_FOUND THEN
			        v_val_parametro := 0;
		  END;


          SELECT ge_fn_operadora_scl
          INTO   v_cod_operadora
          FROM   DUAL;

		  IF v_val_parametro <> 1 then
             v_cod_operadora:= '';
		  end if;


          /* Operadora de Puerto Rico */
          /*------------------------------------------------------------------------------------*/
          IF v_cod_operadora = 'MPR' THEN

             v_cod_retorno := c_retorno4;
             v_des_cadena  := 'Buscando Akeys del numero de serie';

             BEGIN
                SELECT  cod_estado
                  INTO    v_cod_estado
                  FROM    ict_akeys
                  WHERE   num_esn = v_numserie;

             EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                      v_cod_retorno := c_retorno1;  -- No continua la operacion en MPR
                      v_des_cadena  := 'No tiene autenticacion el numero de serie';
             END;

             IF (v_cod_estado is not null) THEN
                    v_cod_retorno := c_retorno0;  -- Continua operacion en MPR
                    v_des_cadena  := 'Continua operacion en Posventa';
             END IF;

             INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES                    (v_secuencia, v_cod_retorno, v_des_cadena);

             COMMIT;


          END IF;


          /* Operadora de Chile */
          /*-------------------------------------------------------------------------------------*/
          IF v_cod_operadora = 'TMC' and v_procedencia = 'I' THEN

             v_cod_retorno := c_retorno4;
             v_des_cadena  := 'Asignando Uso del Abonado';


             v_cod_uso:= v_coduso;

             v_cod_retorno := c_retorno4;
             v_des_cadena  := 'Buscando indicador de uso de venta';

             SELECT  ind_usoventa
               INTO  v_ind_usoventa
               FROM  al_usos
			  WHERE  cod_uso = v_cod_uso;


             IF v_ind_usoventa != 1 THEN

                v_cod_retorno := c_retorno0; -- Indica que segun el uso continua la autenticacion (Si es <> 1 no debe validar nada)
                v_des_cadena  := 'Continua operacion en Posventa';

             END IF;


             IF v_ind_usoventa = 1 THEN /*Equipo habilitados para autenticar*/

                v_cod_retorno := c_retorno4;
                v_des_cadena  := 'Buscando Codigo Estado en Tabla Akeys';

                BEGIN
                    SELECT  cod_estado
                    INTO    v_cod_estado
                    FROM    ict_akeys
                    WHERE   num_esn = v_numserie;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
 	                     IF v_procedencia = 'I' THEN
	                        v_cod_retorno := c_retorno2; -- Inserta Akeys en la tabla
	                        v_des_cadena  := 'Inserta Akeys con estado -1 / Act-Des Servicio Suplementario';
	                     END IF;
                END;


                IF (v_cod_estado = 2) or (v_cod_estado = 0) or (v_cod_estado = 1) THEN
                       v_cod_retorno := c_retorno3; -- 'Actualiza Akeys en estado 1 / Act-Des Servicio Suplementario'
                       v_des_cadena  := 'Actualiza Akeys en estado 1 / Act-Des Servicio Suplementario';
                END IF;

                IF (v_cod_estado = -1) THEN
                       v_cod_retorno := c_retorno5; -- / Act-Des Servicio Suplementario
                       v_des_cadena  := 'Act-Des Servicio Suplementario';
                END IF;

             END IF;

             INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES                    (v_secuencia, v_cod_retorno, v_des_cadena);

             COMMIT;


         END IF;

         IF v_cod_operadora = 'TMC' and v_procedencia = 'E' THEN

			v_cod_retorno := c_retorno0; -- Indica que segun el uso continua la autenticacion (Si es <> 1 no debe validar nada)
            v_des_cadena  := 'Continua operacion en Posventa';

	        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
	        VALUES                    (v_secuencia, v_cod_retorno, v_des_cadena);

		    COMMIT;

         END IF;


EXCEPTION

      WHEN OTHERS THEN

           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES                                    (v_secuencia    , v_cod_retorno, v_des_cadena);

           v_cod_sqlcode := SQLCODE;
           v_cod_sqlerrm := SQLERRM;

           INSERT INTO GA_ERRORES
           (COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
           VALUES
           ('AA', v_secuencia, SYSDATE, 1, 'PV_VALIDA_AUTENTICACION_PR', 'Null', 'N', v_cod_sqlcode, v_cod_sqlerrm);

           COMMIT;

END;
/
SHOW ERRORS
