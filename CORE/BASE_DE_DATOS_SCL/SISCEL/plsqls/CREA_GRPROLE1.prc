CREATE OR REPLACE PROCEDURE crea_grprole1 IS
   v_usuario all_users.username%TYPE;
   CURSOR usuarios is
         select username from all_users where username like 'TRAIN%';
    Begin
    Open usuarios;
    Loop
          Fetch usuarios INTO v_usuario;
          EXIT WHEN usuarios%NOTFOUND;
          insert into ge_seg_grpusuario
          select cod_grupo, v_usuario from ge_seg_grupo;
          commit;
    End Loop;
    Close usuarios;
End ;
/
SHOW ERRORS
