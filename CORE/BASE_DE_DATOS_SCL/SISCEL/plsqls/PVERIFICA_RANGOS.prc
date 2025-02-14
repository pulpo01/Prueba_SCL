CREATE OR REPLACE PROCEDURE        PVERIFICA_RANGOS(V_TRANSACCION in varchar2 , prefijo in number, uso in number)  is



    CURSOR  c_prefijo (prefijo  number, uso number) IS
     SELECT a.num_desde, a.num_hasta,(a.num_hasta-a.num_desde) num_dif, b.num_prefijo
     FROM   ga_celnum_uso a, ga_prefijo_uso b
     WHERE  a.cod_uso=b.cod_uso
       and  b.cod_uso=uso
       and  b.num_prefijo=prefijo;


    v_prefijo   c_prefijo%ROWTYPE;
    inicio      NUMBER(5);
    termino     NUMBER(5);
    prefijo_    VARCHAR(4);
    Num_largo   NUMBER(2);
    desde       NUMBER(2);
    retorno     NUMBER(1);



BEGIN
    retorno:=0;
    SELECT val_parametro
    INTO num_largo
    FROM ged_parametros
    WHERE nom_parametro='LARGO_NUMERO'  ;

    desde:=num_largo - 3;

    OPEN c_prefijo(prefijo,uso);
    LOOP
      FETCH c_prefijo INTO v_prefijo;
      EXIT WHEN (c_prefijo%NOTFOUND) OR (retorno=1);

      inicio:=0;
      WHILE (inicio <= v_prefijo.num_dif) LOOP

        prefijo_:=substr( (v_prefijo.num_desde  + inicio), desde, num_largo);
        if to_NUMBER(prefijo_)=v_prefijo.num_prefijo then
          retorno:=1;
        end if;
        inicio:=inicio + 1;
      END LOOP;

    END LOOP;
    CLOSE c_prefijo;



INSERT INTO GA_TRANSACABO
VALUES (V_TRANSACCION,retorno,' ');
COMMIT;
EXCEPTION
when no_data_found then
ROLLBACK;


INSERT INTO GA_TRANSACABO
VALUES (V_TRANSACCION,1,' ');
COMMIT;
null;



END ;
/
SHOW ERRORS
