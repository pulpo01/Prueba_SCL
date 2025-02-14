CREATE OR REPLACE PACKAGE BODY        VE_DEL_PROS_AUT IS
  --
  -- Retrofitted
  PROCEDURE p_prospecto
  IS
   CURSOR c_prospectos IS
    SELECT A.cod_prospecto, A.fec_entrada, B.num_diasdel
    FROM ve_prospectos A, ve_origenpro B
    WHERE A.cod_origenpro = B.cod_origenpro;
   v_num_diasdel   ve_origenpro.num_diasdel%TYPE;
   v_cod_prospecto ve_prospectos.cod_prospecto%TYPE;
   V_fechafinal    ve_prospectos.fec_entrada%TYPE;
   BEGIN
    FOR c_prospectos_rec IN c_prospectos LOOP
     v_cod_prospecto := c_prospectos_rec.cod_prospecto;
     v_num_diasdel   := c_prospectos_rec.num_diasdel;
     v_fechafinal    := c_prospectos_rec.fec_entrada;
     -- Ahora comprobamos si la fecha + num_diasdel > sysdate
     v_fechafinal    := (v_fechafinal  + v_num_diasdel);
     if (v_fechafinal < sysdate) then
      p_insert_prostatus(v_cod_prospecto);
      p_delete_Proasign(v_cod_prospecto);
      p_delete_Proentrev(v_cod_prospecto);
             p_leer_Prodireccion(v_cod_prospecto);
      p_delete_Prodireccion(v_cod_prospecto);
      p_delete_prospecto(v_cod_prospecto);
     end if;
    END LOOP;
  END;
  --
  -- Retrofitted
  PROCEDURE p_insert_prostatus(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
   BEGIN
    INSERT INTO VE_PROSTATUS (cod_prospecto, cod_estadopro, fec_status)
   VALUES (v_cod_prospecto, 'BA', sysdate);
   COMMIT;
   EXCEPTION
   WHEN OTHERS THEN
                null;
    END;
  --
  -- Retrofitted
  PROCEDURE p_delete_prospecto(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
   BEGIN
    DELETE ve_prospectos WHERE cod_prospecto = v_cod_prospecto;
                  COMMIT;
   EXCEPTION
   WHEN OTHERS THEN
    null;
   END;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proasign(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
          BEGIN
                  DELETE ve_Proasign WHERE cod_prospecto = v_cod_prospecto;
                  COMMIT;
          EXCEPTION
          WHEN OTHERS THEN
                  null;
          END;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proentrev(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
   BEGIN
    DELETE ve_proentrev WHERE cod_prospecto = v_cod_prospecto;
    COMMIT;
   EXCEPTION
   WHEN OTHERS THEN
    null;
   END;
  --
  -- Retrofitted
  PROCEDURE p_leer_Prodireccion(
  v_cod_prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
   CURSOR c_prodireccion IS
     SELECT cod_direccion FROM VE_PRODIRECCION WHERE
     COD_PROSPECTO = v_cod_prospecto;
   v_cod_direccion ve_Prodireccion.cod_direccion%TYPE;
   BEGIN
    FOR c_prodireccion_rec IN c_prodireccion LOOP
     v_cod_direccion := c_prodireccion_rec.cod_direccion;
     p_delete_GeDirecciones(v_cod_direccion);
    END LOOP;
   END;
  --
  -- Retrofitted
  PROCEDURE p_delete_Prodireccion(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
          BEGIN
                  DELETE ve_prodireccion WHERE cod_prospecto = v_cod_prospecto;
                  COMMIT;
          EXCEPTION
          WHEN OTHERS THEN
                  null;
  end;
  --
  -- Retrofitted
  PROCEDURE p_delete_Gedirecciones(
  v_cod_Direccion IN ge_direcciones.cod_direccion%TYPE )
  IS
          BEGIN
                  DELETE Ge_direcciones WHERE cod_direccion = v_cod_direccion;
                  COMMIT;
          EXCEPTION
          WHEN OTHERS THEN
                  null;
   END;
END VE_DEL_PROS_AUT;
/
SHOW ERRORS
