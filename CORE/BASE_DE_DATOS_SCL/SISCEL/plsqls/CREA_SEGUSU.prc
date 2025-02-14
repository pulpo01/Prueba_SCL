CREATE OR REPLACE PROCEDURE crea_segusu IS
   v_usuario all_users.username%TYPE;
   v_num_vendedor number;
   v_contador number;
   CURSOR usuarios is
         select username from all_users where username like 'TRAIN%';
Begin
    v_num_vendedor := 107500;
    v_contador := 0;
    Open usuarios;
    Loop
          Fetch usuarios INTO v_usuario;
          EXIT WHEN usuarios%NOTFOUND;
          v_contador := v_contador + 1;
          insert into ge_seg_usuario(NOM_USUARIO,NOM_OPERADOR,IND_ADM,COD_OFICINA,COD_TIPCOMIS,COD_VENDEDOR,IND_EXCEP_ERIESGO)
          values(v_usuario,'FORMADOR TRAIN-'||to_char(v_contador),'Y','3','5',v_num_vendedor,'N');
          v_num_vendedor := v_num_vendedor + 1;
      End Loop;
      commit;
    Close usuarios;
End ;
/
SHOW ERRORS
