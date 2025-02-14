CREATE OR REPLACE FUNCTION IC_ESTADO_PROVISIONAMIENTO_FN
(p_Num_Movimiento IN Icc_Comproc.Num_Movimiento%TYPE) RETURN VARCHAR2 IS
    /***************************************************************************************************
        Proposito:
        Retornar las respuestas de los comandos (icc_comproc) de un movimiento.

        Entrada:
        Numero de un movimiento de la tabla icc_movmiento

        Salidas:
        - icc_movimiento. num_intentos
        - icg_comando. des_comando
        - icg_codrespuesta.substr(NumeroError)

        El formato de la salida debe ser un string con la

        num_intentos; des_comando1spool off;des_comando2;...des_comandon;

        Casos a comtemplar:
        - El movimiento no existe pq ya paso a historico
        - El movimiento aun tiene comandosque no han recibido respuesta

   REVISIONES:
   Version      Fecha       Autor              Descripcion
   ---------  ----------  ------------------- -------------------------------------------------------
    1.0        05-06-2003  RPORTUGAL-JBUSTOS  CONSTRUCCION DE LA FUNCION DE ACUERDO A ESPECIFICACION
        2.0        02-09-2003  MMORENO-JBUSTOS

   ***************************************************************************************************/
   v_PLSQLBlock1  VARCHAR2(32767);
   v_PLSQLCursor2 VARCHAR2(1023);
   v_PLSQLTable1  VARCHAR2(31);
   v_PLSQLCount1  NUMBER;

   v_PLSQLString1 VARCHAR2(32767):= '';
   v_PLSQLString2 VARCHAR2(63):= TO_CHAR(p_Num_Movimiento) || ';ERROR: EL MOVIMIENTO NO FUE ENCONTRADO;';
   v_PLSQLString3 VARCHAR2(63) :='SIN EJECUCION DE COMANDOS;';
   v_PLSQLFlags1  BOOLEAN:=FALSE;
   v_PLSQLFlags2  BOOLEAN:=TRUE;
   v_num_intentos ICC_MOVIMIENTO.NUM_INTENTOS%TYPE;

   CURSOR c_AllComProc IS
   SELECT 'ICC_COMPROC' Table_Name FROM DUAL
   /************************************************************
   --Activar en caso que se deseee buscar tambiin en histsricos
   UNION
   SELECT Table_Name
   FROM All_Tables
   WHERE Table_Name LIKE 'ICC_HISTCOM%'
   AND SUBSTR(Table_Name,14,2)='20'
   --La siguiente lmnea fui usada solo para pruebas en tabla copiadas
   --de los histsricos verdaderos y llamadas IC_HISTCOMmmyyyy_, dado que
   --para hacer las pruebas no se tenman privilegios de acceso a las
   --histsricas verdaderas.
   --AND SUBSTR(Table_Name,18,1)='_'
   ************************************************************/
   ;
   PROCEDURE pDyn_interno (
      p_Cod_Comando   IN ICC_COMPROC.COD_COMANDO%TYPE,
      p_Cod_Lenguaje  IN ICC_COMPROC.COD_LENGUAJE%TYPE,
      p_Des_Respuesta IN ICC_COMPROC.DES_RESPUESTA%TYPE,
      p_Tip_Respuesta IN ICC_COMPROC.TIP_RESPUESTA%TYPE,
      p_Salida        IN OUT v_PLSQLString1%TYPE
   ) IS
      v_Pos            INTEGER;
      v_Des_Comando    VARCHAR2(255);
      v_Des_Respuesta  VARCHAR2(255);
      v_Cod_Respuesta  Icg_CodRespuesta.Cod_Respuesta%TYPE;
      v2_Des_Respuesta VARCHAR2(255);
      v_CodsLen_Com1   VARCHAR2(255):='ICG_COMANDO.DES_COMANDO NULO PARA COMANDO ';
      v_CodsLen_Com2   VARCHAR2(255):='NO EXISTE ICG_COMANDO.DES_COMANDO PARA COMANDO ';
      v_CodsLen_Com3   VARCHAR2(255):='COMANDO SIN PROCESAR ';
      v_CodsLen_Com4   VARCHAR2(255):='NO EXISTE ICG_CODRESPUESTA.DES_COMANDO PARA NOM_RESPUESTA IN (''';
      v_String10       VARCHAR2(63) :='STATUS=NAK';
      v_String20       VARCHAR2(63) :='SUBERROR=';
      v_String31       VARCHAR2(15) :='0123456789';
      v_String32       VARCHAR2(1) :=',';
      v_String41       VARCHAR2(1) :='(';
      v_String42       VARCHAR2(1) :=')';
      v_String50       VARCHAR2(63) :='0';  --COMANDO EXITOSO[1]
   BEGIN
      BEGIN
         SELECT NVL(Des_Comando, v_CodsLen_Com1)
         INTO v_Des_Comando
         FROM Icg_Comando
         WHERE Cod_Lenguaje=p_Cod_Lenguaje
         AND Cod_Comando=p_Cod_Comando;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN v_Des_Comando:= v_CodsLen_Com2;
         WHEN OTHERS THEN RAISE;
      END;

      p_Salida:= p_Salida || v_Des_Comando || '[' || p_Cod_Comando || ',' || p_Cod_Lenguaje || '];';

      IF p_Tip_Respuesta=0 THEN
         p_Salida:= p_Salida || v_String50 || ';';
      ELSE
         v_Des_Respuesta:=p_Des_Respuesta;
         IF v_Des_Respuesta IS NOT NULL THEN
            v2_Des_Respuesta:=v_Des_Respuesta;
            v_Pos:=INSTR(v_Des_Respuesta,v_String10);
            IF v_Pos>0 THEN
                   v_Des_Respuesta:=SUBSTR(v_Des_Respuesta,v_Pos+LENGTH(v_String10));
                   v_Pos:=INSTR(v_Des_Respuesta,v_String20);
                   IF v_Pos>0 THEN
                          v_Des_Respuesta:=SUBSTR(v_Des_Respuesta,v_Pos+LENGTH(v_String20));
                          IF SUBSTR(v_Des_Respuesta,1,1)=v_String41 THEN
                             v_Des_Respuesta:=SUBSTR(v_Des_Respuesta,2);
                             v_Pos:=INSTR(v_Des_Respuesta,v_String42);
                          ELSIF INSTR(v_String31,SUBSTR(v_Des_Respuesta,1,1))>0 THEN
                             v_Pos:=INSTR(v_Des_Respuesta,v_String32);
                          ELSE
                             v_Pos:=0;
                          END IF;
                          IF v_Pos>1 THEN
                             v2_Des_Respuesta:= LPAD(v_Des_Respuesta,v_Pos-1);
                          END IF;
                   ELSE
                      v2_Des_Respuesta:='';
                   END IF;
            ELSE
               v2_Des_Respuesta:='';
            END IF;
         ELSE
                v2_Des_Respuesta:= v_CodsLen_Com3;
         END IF;
         p_Salida:= p_Salida || v2_Des_Respuesta || ';';
      END IF;

      EXCEPTION
         WHEN OTHERS THEN RAISE;
   END pDyn_interno;

BEGIN
   FOR v_Rec IN c_AllComProc LOOP
          BEGIN
                  v_PLSQLTable1:= v_Rec.table_name;
                  v_PLSQLBlock1:= 'SELECT COUNT(*) ' ||
                                                  '  FROM ' || v_PLSQLTable1 ||
                                          '  WHERE num_movimiento = ' || TO_CHAR(p_Num_Movimiento) ||
                                                  '  AND ROWNUM<2';
                  EXECUTE IMMEDIATE v_PLSQLBlock1
                  INTO v_PLSQLCount1;
                  IF v_PLSQLCount1>0 THEN
                         v_PLSQLFlags1:= TRUE;
                         EXIT;
              END IF;
          EXCEPTION
              WHEN OTHERS THEN NULL;
          END;
   END LOOP;
   BEGIN
      SELECT num_intentos
      INTO v_num_intentos
      FROM icc_movimiento
      WHERE num_movimiento=p_Num_Movimiento;
      v_PLSQLString1:= v_PLSQLString1 || v_num_intentos || ';';
   EXCEPTION
      WHEN NO_DATA_FOUND THEN v_PLSQLFlags2:= FALSE;
      WHEN OTHERS THEN RETURN 'ERROR [' || SQLCODE || ']  ' || SQLERRM;
   END;
   IF NOT v_PLSQLFlags1 AND v_PLSQLFlags2 THEN
      RETURN v_PLSQLString1 || v_PLSQLString3;
   ELSIF v_PLSQLFlags1 AND NOT v_PLSQLFlags2 THEN
      NULL;
   ELSIF NOT v_PLSQLFlags1 AND NOT v_PLSQLFlags2 THEN
      RETURN v_PLSQLString2;
   END IF;
   /********************************************************************************************************************************************************************************
   -- En caso de querer revisar tambiin los archivos histsricos en la busqueda del num_movimiento activar iste bloque y
   -- desactivar el FOR..END LOOP de mas abajo a cambio .
   v_PLSQLCursor2:= 'SELECT Cod_Lenguaje, Cod_Comando, NVL(Des_Respuesta, '''') Des_Respuesta, Tip_Respuesta ' ||
                                        '  FROM ' || v_PLSQLTable1 ||
                                        '  WHERE num_movimiento=' || p_Num_Movimiento;

   v_PLSQLBlock1:=  'BEGIN' ||
                                '  FOR v_Rec IN (' || v_PLSQLCursor2 || ') LOOP' ||
                                        '    pDyn_interno (v_Rec.Cod_Comando, v_Rec.Cod_Lenguaje, v_Rec.Des_Respuesta, v_Rec.Tip_respuesta, :Salida);' ||
                                '  END LOOP;' ||
                                'END;';
   EXECUTE IMMEDIATE v_PLSQLBlock1 USING IN OUT v_PLSQLString1;
  **********************************************************************************************************************************************************************************/
   FOR v_Rec IN (SELECT Cod_Lenguaje, Cod_Comando, NVL(Des_Respuesta,'') Des_Respuesta, Tip_Respuesta FROM icc_comproc WHERE num_movimiento=p_Num_Movimiento) LOOP
      pDyn_interno (v_Rec.Cod_Comando, v_Rec.Cod_Lenguaje, v_Rec.Des_Respuesta, v_Rec.Tip_respuesta, v_PLSQLString1);
   END LOOP;

   IF v_PLSQLTable1<>'ICC_COMPROC' THEN v_PLSQLString1:= v_PLSQLTable1 || ': ' || v_PLSQLString1; END IF;
   RETURN v_PLSQLString1;
   EXCEPTION
      WHEN OTHERS THEN RETURN 'ERROR [' || SQLCODE || ']  ' || SQLERRM;

END IC_ESTADO_PROVISIONAMIENTO_FN;
/
SHOW ERRORS
