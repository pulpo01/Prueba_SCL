CREATE OR REPLACE PACKAGE BODY        VE_PAC_UPDPROSP_BA IS
/*-- Proceso principal  */
-- fin del procedure p_prospecto
/*---------------------------------
-- Proceso de alta de ese prospecto en VE_PROSTATUS antes de
-- eliminar el prospecto*/
/*----------------------------------*/
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
       dbms_output.put_line('bien');
       dbms_output.put_line('v_fechafinal ='||
                              to_char(v_fechafinal,'dd-mm-yyyy hh24:mi:ss'));
     if (v_fechafinal < sysdate) then
           dbms_output.put_line('v_fechafinal ='||
                              to_char(v_fechafinal,'dd-mm-yyyy hh24:mi:ss'));
             ve_pac_updprosp_ba.p_insert_prostatus(v_cod_prospecto);
          ve_pac_delprosp.p_principal(v_cod_prospecto,
                                                           'VE');
     end if;
    END LOOP;
  END;
  --
  -- Retrofitted
  PROCEDURE p_insert_prostatus(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
  IS
   BEGIN
     dbms_output.put_line('Dentro p_inserst_prostatus');
     dbms_output.put_line('v_cod_prospecto ='||to_char(v_cod_prospecto));
    INSERT INTO VE_PROSTATUS (cod_prospecto, cod_estadopro,
        fec_status)
    VALUES (v_cod_prospecto, 'BA', sysdate);
    COMMIT;
     dbms_output.put_line('SQLCODE ='||to_char(sqlcode));
   EXCEPTION
   WHEN OTHERS THEN
     dbms_output.put_line('SQLERRM ='||SQLERRM);
                null;
    END;
END VE_PAC_UPDPROSP_BA;
/
SHOW ERRORS
