CREATE OR REPLACE PROCEDURE P_LIMPIAR_PERFILABO_PR
(
  VP_PRODUCTO IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_PERFIL IN VARCHAR2 )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : P_LIMPIAR_PERFILABO
-- * Descripción        : Este Procedimiento toma el campo clase_servicio
-- 	 					  y saca todos los servcios con nivel cero (deteccion de niveles 0) y actualiza con
--						  los servicios que quedan el campo PERFIL_ABONADO
-- * Fecha de creación  : 06/05/2004
-- * Responsable        : German Espinoza Z.
-- *************************************************************
   V_PROCED VARCHAR2(2000) := NULL;
   V_PERFIL_ABONADO GA_ABOCEL.PERFIL_ABONADO%TYPE;

   V_SERVNIVEL VARCHAR2(6);
   V_SERVSUPL CHAR(2);
   V_NIVEL CHAR(4);

   V_POS NUMBER(3) := 1;
BEGIN
   V_PROCED := 'P_LIMPIAR_PERFILABO';
   V_PERFIL_ABONADO:='';

   LOOP
      V_SERVNIVEL := SUBSTR (VP_PERFIL, V_POS, 6);

      EXIT WHEN V_SERVNIVEL IS NULL;

	  V_POS := V_POS + 6;
      V_SERVSUPL := SUBSTR(V_SERVNIVEL,1,2);
      V_NIVEL    := SUBSTR(V_SERVNIVEL,3,4);

	  IF V_NIVEL <> '0000' THEN
         V_PERFIL_ABONADO := V_PERFIL_ABONADO||V_SERVSUPL||V_NIVEL;
      END IF;

    END LOOP;
    IF VP_PRODUCTO = 1 THEN
       UPDATE GA_ABOCEL
          SET PERFIL_ABONADO = V_PERFIL_ABONADO
        WHERE NUM_ABONADO = VP_ABONADO;
      UPDATE GA_ABOAMIST
          SET PERFIL_ABONADO = V_PERFIL_ABONADO
        WHERE NUM_ABONADO = VP_ABONADO;
    ELSIF VP_PRODUCTO = 2 THEN
       UPDATE GA_ABOBEEP
          SET PERFIL_ABONADO = V_PERFIL_ABONADO
        WHERE NUM_ABONADO = VP_ABONADO;
    ELSIF VP_PRODUCTO = 3 THEN
       UPDATE GA_ABOTRUNK
          SET PERFIL_ABONADO = V_PERFIL_ABONADO
        WHERE NUM_ABONADO = VP_ABONADO;
    ELSIF VP_PRODUCTO = 4 THEN
       UPDATE GA_ABOTREK
          SET PERFIL_ABONADO = V_PERFIL_ABONADO
        WHERE NUM_ABONADO = VP_ABONADO;
    END IF;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20212,V_PROCED||' '||SQLERRM);
END;
/
SHOW ERRORS
