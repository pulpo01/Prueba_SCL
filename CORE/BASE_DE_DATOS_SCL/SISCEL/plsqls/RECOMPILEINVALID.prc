CREATE OR REPLACE PROCEDURE RecompileInvalid IS
   errores number(1):=0;
 CURSOR getlist IS SELECT object_type, object_name FROM
     user_objects WHERE status = 'INVALID' AND
     object_type IN ('PROCEDURE', 'FUNCTION', 'PACKAGE',
     'PACKAGE BODY', 'TRIGGER' )
     ORDER BY object_type;
   schemaname VARCHAR2(100);
   CURSOR geterr ( objname VARCHAR2, objtype VARCHAR2 ) IS
     SELECT text, line, position FROM user_errors WHERE
     name = objname AND type = objtype;
   SEGUIR_BUCLE EXCEPTION;
  BEGIN
   dbms_output.enable(24000);
   SELECT username INTO schemaname FROM user_users;
   FOR getlistrec IN getlist LOOP
        BEGIN
                dbms_output.put_line( 'Intentando compilar el objeto ' ||
         getlistrec.object_name ||' de tipo '||getlistrec.object_type);
       BEGIN
         dbms_ddl.alter_compile( getlistrec.object_type,
           schemaname, getlistrec.object_name );
         EXCEPTION
           WHEN OTHERS THEN
            errores:=1;
            RAISE SEGUIR_BUCLE;
       END;
       EXCEPTION
         WHEN SEGUIR_BUCLE THEN null;
     END;
   END LOOP;

   IF errores=0 THEN
             dbms_output.put_line( '===================SIN ERRORES DE COMPILACION===============');
   END IF;
   FOR getlistrec IN getlist LOOP
     dbms_output.put_line( '------------------DESCRIPCION ERRORES COMPILACION---------------------' );
     dbms_output.put_line('');
     dbms_output.put_line( 'Compilacion fallida en: ' ||
       getlistrec.object_name );
     FOR geterrrec IN geterr( getlistrec.object_name,
         getlistrec.object_type ) LOOP
       dbms_output.put_line( 'line: ' || geterrrec.line ||
         ' col: ' || geterrrec.position );
       dbms_output.put_line( substr( geterrrec.text, 1, 100 ));
     END LOOP;
   END LOOP;
  END;
/
SHOW ERRORS
