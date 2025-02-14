CREATE OR REPLACE PROCEDURE        P_COMP_TODO IS
  v_sentencia   varchar2(1024) := null;
  v_filas       integer;
  v_cursor      integer;
  v_tipo        user_objects.object_type%type;
  v_invalidos   user_objects.object_name%type;
  CURSOR c_invalidos  IS
         SELECT OBJECT_NAME
                FROM USER_OBJECTS
                WHERE OBJECT_TYPE = v_tipo
                  AND STATUS = 'INVALID';
BEGIN
--dbms_output.enable(1000000);
  v_cursor := dbms_sql.open_cursor;
  v_tipo := 'PACKAGE';
  LOOP
    /* dbms_output.put_line ('---------------------------------------------');
    dbms_output.put_line ('- Compilando '|| v_tipo);
    dbms_output.put_line ('---------------------------------------------'); */
    open c_invalidos;
    LOOP
      fetch c_invalidos into v_invalidos;
            exit when c_invalidos%NOTFOUND;
            v_sentencia := 'ALTER ';
            if v_tipo = 'PACKAGE BODY' then
               v_sentencia := v_sentencia || 'PACKAGE ';
            else
               v_sentencia := v_sentencia || v_tipo || ' ';
            end if;
            v_sentencia := v_sentencia || v_invalidos;
            v_sentencia := v_sentencia || ' compile';
            dbms_sql.parse (v_cursor,v_sentencia,dbms_sql.v7);
           --  dbms_output.put_line (v_sentencia);
            v_filas := dbms_sql.execute(v_cursor);
    end LOOP;
    close c_invalidos;
    if v_tipo = 'PACKAGE' then
       v_tipo := 'PACKAGE BODY';
    elsif v_tipo = 'PACKAGE BODY' then
          v_tipo := 'PROCEDURE';
    elsif v_tipo = 'PROCEDURE' then
          v_tipo := 'TRIGGER';
    elsif v_tipo = 'TRIGGER' then
          v_tipo := 'VIEW';
    else
        exit;
    end if;
  end LOOP;
  dbms_sql.close_cursor(v_cursor);
exception
  when others then
       if dbms_sql.is_open(v_cursor) then
          dbms_sql.close_cursor(v_cursor);
       end if;
       if c_invalidos%ISOPEN then
          close c_invalidos;
       end if;
       --  dbms_output.put_line(SQLERRM);
END P_COMP_TODO;
/
SHOW ERRORS
