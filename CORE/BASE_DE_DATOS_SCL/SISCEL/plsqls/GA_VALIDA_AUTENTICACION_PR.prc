CREATE OR REPLACE PROCEDURE        GA_VALIDA_AUTENTICACION_PR (
          v_secuencia      IN  ga_transacabo.NUM_TRANSACCION%type,
              v_actuacion      IN  VARCHAR2,
          v_numserie       IN  VARCHAR2,
          v_procedencia    IN  VARCHAR2,
              v_codsistema         IN  VARCHAR2,
              v_coduso             IN  ga_abocel.COD_USO%type
) IS
-- Procedimiento que llama a otras rutinas de posventa o venta, dependiendo de la actuacion
-- la cual cada una de ellas se encargada de validar la autenticacion de la serie.
-- Creacion     : 09-septiembre de 2002
-- Modificacion :
-- Autor        : Karem Fernandez Ayala


BEGIN
---- Selecciona rutina a ejecutar y valida su existencia

        IF v_actuacion = 'PV' THEN
           BEGIN
               PV_VALIDA_AUTENTICACION_PR(v_secuencia, v_numserie,v_procedencia, v_coduso);
           END;
        END IF;

        IF v_actuacion = 'VT' THEN
           BEGIN
               VT_VALIDA_AUTENTICACION_PR(v_secuencia, v_numserie, v_procedencia, v_coduso);
           END;
        END IF;
END;
/
SHOW ERRORS
