CREATE OR REPLACE FUNCTION IC_SERVICIO_MOVIMIENTO_FN (p_Num_Movimiento IN icc_movimiento.num_movimiento%TYPE,p_Servicio IN NUMBER) RETURN VARCHAR2 IS
/***************************************************************************************************
   NOMBRE:        IC_SERVICIO_MOVIMIENTO_FN()
   PROPOSITO:

    Funcion que permita realizar ciertas operaciones sobre un movimiento en icc_movimiento (servicios).

 Entrada: (Num_movmiento, Servicio). Donde Servicio es:

 1 -> El movimiento pasa a historico (Cod_estado del movmiento a 0)

 2 -> Se actualiza el campo num_intentos a valor 0 (esto para que el movimiento, que supuestamente llego al max_intentos, pueda seguir   ejecutandose)

 Salida :
 OK -> si la accione es exitosa
 NAK ; ERROR = <error> -> si fallo accion

   REVISIONES:
   Version      Fecha       Autor              Descripcion
   ---------  ----------  ------------------  ------------------------------------
    1.0        05-06-2003  RPORTUGAL-JBUSTOS  CONSTRUCCION DE LA FUNCION DE ACUERDO A ESPECIFICACION
****************************************************************************************************/
VAROK    VARCHAR2(100);
VARERROR VARCHAR2(32767);
BEGIN
   IF p_Servicio=0 THEN
      UPDATE icc_movimiento SET cod_estado=0 WHERE num_movimiento=p_Num_Movimiento AND cod_estado NOT IN (2,11);
      VAROK:='OK';
   RETURN VAROK;
   ELSIF p_Servicio=1 THEN
      UPDATE icc_movimiento SET num_intentos=0 WHERE num_movimiento=p_Num_Movimiento;
      VAROK:='OK';
   RETURN VAROK;
   ELSE
      VARERROR:='NAK : ERROR = Segundo argumento de la funcisn Cod_Servicio no valido';
      RETURN VARERROR;
   END IF;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
    VARERROR:='NAK : ERROR = Num_Movimiento no encontrado';
       RETURN VARERROR;
     WHEN OTHERS THEN
       VARERROR:='NAK : ERROR = <' || SQLCODE || '> EN TRIGGER';
       RETURN VARERROR;
END  IC_SERVICIO_MOVIMIENTO_FN;
/
SHOW ERRORS
