CREATE OR REPLACE PACKAGE BODY        VE_ASIGNA_OFI_PRO IS
/*-- Proceso principal  */
/* -- fin del procedure v_prospecto
---------------------------------
-- Proceso de busqueda del codigo de oficina con la misma comuna*/
/*----------------------------------
-- Proceso que hace un UPDATE en VE_PROSPECTOS poniendo el COD_OFICINA
recuperado
-- de GE_OFICINAS*/
----------------------------------
/*-- Proceso que hace un INSERT en VE_PROSTATUS*/
  --
  -- Retrofitted
  PROCEDURE p_prospecto
  IS
   CURSOR c_prospectos IS
    SELECT A.cod_prospecto,a.cod_tipodirpref,
    B.cod_comuna, b.cod_region, b.cod_provincia, C.cod_direccion
    FROM ve_prospectos A, ge_direcciones B, ve_prodireccion C
    WHERE A.cod_estadopro = 'NA'
    AND   A.cod_prospecto = C.cod_prospecto
    AND   C.cod_tipdireccion = a.cod_tipodirpref
    AND   C.cod_direccion = B.cod_direccion;
   v_codComuna ge_direcciones.cod_comuna%TYPE;
   v_cod_Oficina   ve_ofic_comuna.cod_oficina%TYPE;
   v_cod_region    ge_direcciones.cod_region%TYPE;
   v_cod_provincia ge_direcciones.cod_provincia%TYPE;
   v_cod_prospecto ve_prospectos.cod_prospecto%TYPE;
          c_prospectos_rec ve_prospectos%ROWTYPE;
   v_encofi number;
  /* -- v_prospecto ve_prospectos.*/
   BEGIN
    FOR c_prospectos_rec IN c_prospectos LOOP
     v_codComuna := c_prospectos_rec.cod_comuna;
     v_cod_region := c_prospectos_rec.cod_region;
     v_cod_provincia := c_prospectos_rec.cod_provincia;
     v_cod_prospecto := c_prospectos_rec.cod_prospecto;
   /*--- ahora con la comUna busco la oficina que tiene la misma comuna */
                          dbms_output.put_line('v_cod_prospecto:
  '||v_cod_prospecto);
                          dbms_output.put_line('Comuna:'||v_codComuna);
     p_oficina(v_codComuna, v_cod_region, v_cod_provincia,
        v_cod_Oficina, v_encofi);
                          dbms_output.put_line('v_codcomuna(oficina):
  '||v_codComuna);
                          dbms_output.put_line('v_cod_region:'||v_cod_region);
     dbms_output.put_line('v_cod_oficina:'||v_cod_oficina);
                          dbms_output.put_line('v_encofi: '|| v_encofi );
     if v_encofi = 1 then
     -- encontrado
     -- if v_cod_oficina<> null then
      p_update_Prospectos
       (v_cod_prospecto, v_cod_oficina);
      p_insert_Prospectos(v_cod_prospecto);
                          dbms_output.put_line('dentro del if:'||v_cod_oficina);
     end if;
    END LOOP;
                  commit;
          EXCEPTION
             WHEN OTHERS THEN
                  null;
   END;
  --
  -- Retrofitted
  PROCEDURE p_oficina(
  v_codComuna IN ge_direcciones.cod_comuna%TYPE ,
  v_cod_region IN ge_direcciones.cod_region%TYPE ,
  v_cod_provincia IN ge_direcciones.cod_provincia%TYPE ,
  v_cod_Oficina OUT ge_oficinas.cod_oficina%TYPE ,
  v_encofi IN OUT number )
  IS
   BEGIN
    v_encofi := 1;
    SELECT cod_oficina INTO v_cod_oficina
    FROM  ve_ofic_comuna
    WHERE cod_comuna = v_codComuna
    AND cod_region = v_cod_region
     AND cod_provincia = v_cod_provincia
    AND ROWNUM < 2;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN
       v_encofi := 0;
     --v_cod_oficina:=null;
    END;
  --
  -- Retrofitted
  PROCEDURE p_Update_Prospectos(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE ,
  v_cod_oficina IN ge_oficinas.cod_oficina%TYPE )
  IS
   BEGIN
    UPDATE ve_prospectos set cod_oficina = v_cod_oficina,
     cod_estadopro = 'OF'
     WHERE cod_prospecto = v_cod_prospecto;
   EXCEPTION
    WHEN OTHERS THEN
               null;
   END;
  --
  -- Retrofitted
  PROCEDURE p_insert_Prospectos(
  v_cod_prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
   BEGIN
    INSERT INTO ve_prostatus
     (cod_prospecto, fec_status, cod_estadopro) values
     (v_cod_prospecto, SYSDATE, 'OF');
   EXCEPTION
   WHEN OTHERS THEN
               null;
   END;
END VE_ASIGNA_OFI_PRO;
/
SHOW ERRORS
