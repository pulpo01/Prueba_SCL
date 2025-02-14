CREATE OR REPLACE PACKAGE BODY        VE_BUSCAR_PROSPECTOS IS
  --
  -- Retrofitted
  PROCEDURE p_Buscar_Prospectos(
  v_Cod_Ident IN ve_prospectos.cod_tipident%TYPE ,
  v_Num_Ident IN ve_prospectos.num_ident%TYPE ,
  v_IdUsr IN ve_prospectos.nom_usuario%TYPE ,
  v_result OUT number ,
  v_err OUT char )
  IS
          v_prospecto ve_prospectos.cod_prospecto%TYPE;
          BEGIN
                  SELECT COD_PROSPECTO INTO v_prospecto FROM VE_PROSPECTOS
                  WHERE COD_TIPIDENT = v_Cod_Ident
                  AND   NUM_IDENT    = v_Num_Ident
                  AND   NOM_USUARIO  = v_IdUsr
                  AND   ROWNUM       = 1;
                  v_result := 0; /* Todo ha ido bien, encontrs el registro */
    p_delete_Proasign(v_prospecto);
           p_delete_proEntrev(v_prospecto);
                  p_delete_prospectos(v_prospecto);
  EXCEPTION
  WHEN OTHERS THEN
          v_result := SQLCODE;    /* Se ha producido un error Oracle */
          v_err := SUBSTR(SQLERRM, 1, 100);
  END;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proasign(
  v_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
  BEGIN
   DELETE ve_proasign WHERE cod_prospecto = v_prospecto;
   COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    null;
  END;
  --
  -- Retrofitted
  PROCEDURE p_delete_ProEntrev(
  v_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
  BEGIN
   DELETE ve_ProEntrev WHERE cod_prospecto = v_prospecto;
   COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    null;
  END;
  --
  -- Retrofitted
  PROCEDURE p_delete_Prospectos(
  v_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
  BEGIN
   DELETE ve_Prospectos WHERE cod_prospecto = v_prospecto;
   COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
     null;
  END;
END VE_BUSCAR_PROSPECTOS;
/
SHOW ERRORS
