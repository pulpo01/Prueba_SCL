CREATE OR REPLACE PROCEDURE        P_ACTUALIZA_PERFILABO(
  VP_PRODUCTO IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_CLASEABO IN VARCHAR2 ,
  VP_PERFIL IN VARCHAR2 ,
  VP_RENT IN NUMBER ,
  VP_FECSYS IN DATE ,
  VP_PERFILABO IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de carga de servicios suplementarios incluidos en el perfil
-- inicial de habilitacion
--
   V_PROCED VARCHAR2(30) := NULL;
   V_CLASESERVICIO GA_ABOCEL.CLASE_SERVICIO%TYPE;
   V_AUX GA_ABOCEL.CLASE_SERVICIO%TYPE;
   V_PERFILABO GA_ABOCEL.PERFIL_ABONADO%TYPE;
   V_SERVNIVEL VARCHAR2(6);
   V_SERVPERFIL VARCHAR2(6);
   V_CADNEW VARCHAR2(6);
   V_SERVSUPL VARCHAR2(2);
   V_SERVSUPLPER VARCHAR2(2);
   V_NIVEL VARCHAR2(4);
   V_NIVELPER VARCHAR2(4);
   V_IND VARCHAR2(1);
   V_POS NUMBER(3) := 1;
   V_POS2 NUMBER(3) := 1;
   TUPU GA_ABOCEL.PERFIL_ABONADO%TYPE;
   V_FIN NUMBER(1) := 0;
BEGIN
   dbms_output.put_line  ('ENTRAMOS=');
   V_PROCED := 'P_ACTUALIZA_PERFIL';
   dbms_output.put_line  ('prime=');
   V_CLASESERVICIO := VP_CLASEABO;
   dbms_output.put_line  ('segu=');
   TUPU := VP_PERFIL;
   dbms_output.put_line  ('PERFIL ORIGINAL='||VP_PERFIL);
   dbms_output.put_line  ('CAMBIOS='||V_CLASESERVICIO);
   LOOP
      dbms_output.put_line  ('ENTRA LOOP PERFIL');
      V_SERVPERFIL := SUBSTR (TUPU, V_POS, 6);
      dbms_output.put_line  ('CADENA PERFIL='||V_SERVPERFIL);
      EXIT WHEN V_SERVPERFIL IS NULL;
      V_POS := V_POS + 6;
      V_SERVSUPLPER := SUBSTR(V_SERVPERFIL,1,2);
      dbms_output.put_line  ('SERVICIO PERFIL='||V_SERVSUPLPER);
      V_NIVELPER    := SUBSTR(V_SERVPERFIL,3,4);
      dbms_output.put_line  ('NIVEL PERFIL='||V_NIVELPER);
      V_IND := 'N';
      V_AUX := NULL;
      LOOP
         dbms_output.put_line  ('ENTRA LOOP CAMBIOS');
         V_SERVNIVEL := SUBSTR (V_CLASESERVICIO, V_POS2, 6);
         dbms_output.put_line  ('CADENA CAMBIO='||V_SERVNIVEL);
         EXIT WHEN V_SERVNIVEL IS NULL;
  V_POS2 := V_POS2 + 6;
         V_SERVSUPL := SUBSTR(V_SERVNIVEL,1,2);
         dbms_output.put_line  ('SERVICIO CAMBIO='||V_SERVSUPL);
         V_NIVEL    := SUBSTR(V_SERVNIVEL,3,4);
         dbms_output.put_line  ('NIVEL CAMBIO='||V_NIVEL);
         IF V_SERVSUPL = V_SERVSUPLPER THEN
         dbms_output.put_line  ('SERVICIO PERFIL = SERVICIO CAMBIO');
            IF V_NIVEL <> '0000' THEN
         dbms_output.put_line  ('EL NIVEL ES <> 0000');
               V_IND := 'S';
        V_CADNEW := V_SERVSUPL||V_NIVEL;
            ELSE
         dbms_output.put_line  ('EL NIVEL ES = 0000');
               V_IND := '0';
            END IF;
         ELSE
         dbms_output.put_line  ('SERVICIO PERFIL <> SERVICIO CAMBIO');
            V_AUX := V_AUX||V_SERVSUPL||V_NIVEL;
         END IF;
       END LOOP;
       V_CLASESERVICIO := V_AUX;
       V_POS2 := 1;
       dbms_output.put_line  ('SALE DEL LOOP DE CAMBIOS');
       IF V_IND = 'S' THEN
          V_PERFILABO := V_PERFILABO||V_CADNEW;
         dbms_output.put_line  ('PERFIL ACTUALIZADO='||V_PERFILABO);
       ELSIF V_IND = 'N' THEN
          V_PERFILABO := V_PERFILABO||V_SERVSUPLPER||V_NIVELPER;
         dbms_output.put_line  ('PERFIL ACTUALIZADO='||V_PERFILABO);
       END IF;
   END LOOP;
   V_PERFILABO := V_PERFILABO||V_CLASESERVICIO;
   VP_PERFILABO := RTRIM(V_PERFILABO);
   dbms_output.put_line  ('PERFIL DEFINITIVO='||V_PERFILABO);
   dbms_output.put_line  ('SALE DEL LOOP DEL PERFIL');
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
