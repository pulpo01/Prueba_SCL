CREATE OR REPLACE PACKAGE BODY FA_OBTIENE_DIRCLIE_PG AS


FUNCTION FA_OBTIENE_DIRCLIE_FN ( v_cod_sujeto VARCHAR2, 
                                 v_tip_sujeto NUMBER, 
                                 v_cod_tipdireccion NUMBER, 
                                 v_cod_display NUMBER, 
                                 v_val_fac VARCHAR2 := '1' )
RETURN VARCHAR2 IS
   error_proceso  EXCEPTION;
   palabra        VARCHAR2(300);
   valor_param    VARCHAR2(300);
   frase          VARCHAR2(2000);
   v_cod_operad   VARCHAR2(256);
   v_dir_para     VARCHAR2(2000);
   v_dir_para_CD  VARCHAR2(2000);
   v_dir_para_CT  VARCHAR2(2000);
   v_dir_para_fin VARCHAR2(2000);
   v_direccion    VARCHAR2(800);
   v_cant_param   INTEGER;
   v_dir_largo    NUMBER(3);
   v_cod_paramdir FA_PARAMDIR_TO.COD_PARAMDIR%TYPE;
   sql_stmt       VARCHAR2(2000);
   p_cod_sujeto   VARCHAR2(20):=v_cod_sujeto;
   p_cod_tipdir   NUMBER:=v_cod_tipdireccion;
   v_cod_mensaje  INTEGER:=0;
   nom_col        VARCHAR2(100);
   valor_col      VARCHAR2(300);
   v_nom_columna  VARCHAR2(100);
   salida         INTEGER;
   i              INTEGER;
   z              INTEGER;
   pos            INTEGER;
   desPos         INTEGER;
   hasPos         INTEGER;
   sww            INTEGER;
   cadArr         VARCHAR2(100);
   cadVar         VARCHAR2(100);

  TYPE NomCol_record IS RECORD (nombre VARCHAR2(30),posc integer);
  TYPE NomCol_tab IS TABLE OF NomCol_record INDEX BY BINARY_INTEGER;
  v_nobre_col NomCol_tab;
  
  TYPE ValorCol_record IS RECORD (nmb_valor VARCHAR2(300));
  TYPE ValorCol_tab IS TABLE OF ValorCol_record INDEX BY BINARY_INTEGER;
  v_valor_col ValorCol_tab;

-- *******************Cursores*************************
   CURSOR Codparamdir IS
          SELECT cod_paramdir
          FROM FA_PARAMDIROPERAD_TO
          WHERE cod_operad = v_cod_operad
          ORDER BY orden;
-- ****************************************************

BEGIN
      v_cod_operad := Ge_Fn_Operadora_Scl;
      --
      SELECT DIR_PARA INTO v_dir_para
      FROM   FA_DIRPARAOPERAD_TO
      WHERE  COD_OPERAD = v_cod_operad
      AND    TIP_SUJETO = v_tip_sujeto
      AND    COD_DISPLAY= v_cod_display;      
      
      IF SQLCODE <> 0 THEN
         RAISE error_proceso;
      END IF;
      --
      sql_stmt:=v_dir_para;
      Begin
         IF p_cod_tipdir=0 THEN
            EXECUTE IMMEDIATE sql_stmt INTO v_dir_para_fin USING p_cod_sujeto;
         ELSE                                                                                                            
            EXECUTE IMMEDIATE sql_stmt INTO v_dir_para_fin USING p_cod_sujeto,p_cod_tipdir;            
         END IF;
         EXCEPTION
         WHEN OTHERS THEN
         frase := ' ';
         v_cod_operad := '';
      End;
 
      sql_stmt:= SUBSTR(sql_stmt,7);
      z:=1;
      salida:=0;

      WHILE salida>=0 LOOP

            desPos:=INSTR(sql_stmt,'.')+1;
            hasPos:= INSTR(sql_stmt,'|');

            nom_col:= SUBSTR(sql_stmt,desPos,((hasPos-1) - desPos));
            sql_stmt:= SUBSTR(sql_stmt,hasPos + 14);

            v_nobre_col(z).nombre:= nom_col;
            v_nobre_col(z).posc:= z;

            z:=z+1;
            salida:=hasPos-1;
      END LOOP;

      i:=1;

      WHILE v_dir_para_fin is not NULL LOOP
            desPos:=INSTR(v_dir_para_fin,'!"#$%');

            valor_col:= SUBSTR(v_dir_para_fin,1,desPos-1);
            v_dir_para_fin:= SUBSTR(v_dir_para_fin,desPos+5);
            v_valor_col(i).nmb_valor:= valor_col;
            i:=i+1;
      END LOOP;

      OPEN Codparamdir;
         LOOP
            FETCH Codparamdir INTO v_cod_paramdir;
            EXIT WHEN Codparamdir%NOTFOUND;
            BEGIN

                     SELECT NOM_COLUMN INTO v_nom_columna 
                     FROM   FA_PARAMDIR_TO
                     WHERE  COD_PARAMDIR = v_cod_paramdir;

                     i:=1;

                     WHILE i<z LOOP
                        cadArr:=SUBSTR(v_nobre_col(i).nombre,1,4);
                        cadVar:=SUBSTR(v_nom_columna,1,4);

                        IF cadArr ='DES_' and cadVar ='COD_' THEN
                           v_nom_columna:= REPLACE (v_nom_columna,'COD','DES');
                        END IF;                       

                        IF v_nobre_col(i).nombre = v_nom_columna THEN
                           pos := v_nobre_col(i).posc;
                           sww :=0;
                           EXIT;
                        END IF;
                        i:=i+1;
                     END LOOP;

                     IF sww = 1 THEN
                        valor_param:= '';
                     ELSE
                        valor_param:= v_valor_col(pos).nmb_valor;
                        sww:=1;
                     END IF;

                     palabra := REPLACE (valor_param,':',' ');
                     valor_param := REPLACE (palabra,';',' ');

                     IF v_cod_display = 2 THEN
                        frase:=frase||v_cod_paramdir||':'||valor_param||';';
                     ELSIF v_cod_display = 3 THEN
                        SELECT LARGO INTO v_dir_largo
                        FROM   FA_PARAMDIR_TO
                        WHERE  COD_PARAMDIR = v_cod_paramdir;

                        frase:=frase||v_cod_paramdir||':'||TO_CHAR(v_dir_largo)||':'||valor_param||';';
                     ELSE
                        frase:=frase||valor_param|| ' ' ;
                     END IF;
                END;
         END LOOP;
      CLOSE Codparamdir;

      --*********************************************************      
      v_direccion := frase;
      RETURN v_direccion;
      --*********************************************************
      EXCEPTION
      WHEN error_proceso THEN      
         RETURN 'ERROR fa_fn_obtiene_dirclie, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20101, 'No se encontro Direcci�n');         
         RETURN 'ERROR fa_fn_obtiene_dirclie, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
      WHEN OTHERS THEN      
         RETURN 'ERROR fa_fn_obtiene_dirclie, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;

END FA_OBTIENE_DIRCLIE_PG ;
/
SHOW ERRORS