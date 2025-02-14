CREATE OR REPLACE PACKAGE BODY        VE_PAC_DELPROSP IS
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  PROCEDURE p_principal(
  V_CODPROSPECTO IN NUMBER ,
  V_MODULO IN GE_MODULOS.COD_MODULO%TYPE )
  IS
    BEGIN
         p_delete_Proasign(V_CODPROSPECTO);
         p_delete_Proentrev(V_CODPROSPECTO);
         p_leer_Prodireccion(V_CODPROSPECTO);
         p_delete_Prodireccion(V_CODPROSPECTO);
         p_delete_Prospecto(V_CODPROSPECTO);
         if V_MODULO = 'VE' then
            commit;
         end if;
    END;
  --
  -- Retrofitted
  PROCEDURE p_delete_prospecto(
  V_CODPROSPECTO IN NUMBER )
  IS
    BEGIN
       DELETE ve_prospectos WHERE cod_prospecto = V_CODPROSPECTO;
    EXCEPTION
       WHEN OTHERS THEN
            null;
    END;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proasign(
  V_CODPROSPECTO IN NUMBER )
  IS
    BEGIN
       DELETE ve_Proasign WHERE cod_prospecto = V_CODPROSPECTO;
    EXCEPTION
       WHEN OTHERS THEN
            null;
    END;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proentrev(
  V_CODPROSPECTO IN NUMBER )
  IS
    BEGIN
       DELETE ve_proentrev WHERE cod_prospecto = V_CODPROSPECTO;
    EXCEPTION
       WHEN OTHERS THEN
            null;
    END;
  --
  -- Retrofitted
  PROCEDURE p_leer_Prodireccion(
  V_CODPROSPECTO IN NUMBER )
  IS
       CURSOR c_prodireccion IS
              SELECT cod_direccion FROM VE_PRODIRECCION WHERE
                     COD_PROSPECTO = V_CODPROSPECTO;
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
  V_CODPROSPECTO IN NUMBER )
  IS
    BEGIN
       DELETE ve_prodireccion WHERE cod_prospecto = V_CODPROSPECTO;
    EXCEPTION
       WHEN OTHERS THEN
            null;
    END;
  --
  -- Retrofitted
  PROCEDURE p_delete_Gedirecciones(
  v_cod_Direccion IN ge_direcciones.cod_direccion%TYPE )
  IS
    BEGIN
       DELETE Ge_direcciones WHERE cod_direccion = v_cod_direccion;
    EXCEPTION
       WHEN OTHERS THEN
            null;
    END;
END VE_PAC_DELPROSP;
/
SHOW ERRORS
