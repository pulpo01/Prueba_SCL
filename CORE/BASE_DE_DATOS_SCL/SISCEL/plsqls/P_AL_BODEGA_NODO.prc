CREATE OR REPLACE PROCEDURE P_AL_BODEGA_NODO
(v_num_transaccion              IN      VARCHAR2,
v_bodega_x                      IN      VARCHAR2,
v_oper_scl                      IN      VARCHAR2) IS
v_glosa_error                   VARCHAR2(70);
v_proced                            VARCHAR2(70);
v_bodega                            al_bodegas.cod_bodega%TYPE;
v_nodo                          al_bodegas.cod_bodega%TYPE;

ERROR_PROCESO_GENERAL   EXCEPTION;
begin
insert into GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
values (TO_NUMBER(v_num_transaccion), 0, 'error bodeganodo');
v_proced        :='P_AL_BODEGA_NODO';
v_bodega    := TO_NUMBER(v_bodega_x);
-- selecciona bodega nodo
select cod_bodeganodo
into v_nodo
from ge_operadora_scl
where cod_operadora_scl=v_oper_scl;
-- inseeta bodega nodo
insert into al_bodeganodo(cod_bodega, cod_bodeganodo)
values(v_bodega,v_nodo);
EXCEPTION
        WHEN  ERROR_PROCESO_GENERAL  THEN
            update ga_transacabo
                        set cod_retorno = 1
                        where num_transaccion = TO_NUMBER(v_num_transaccion);
                    RAISE_APPLICATION_ERROR (-20205,v_proced||' '||SQLERRM || ' ' || SQLCODE ||'Error creacion Bodega-Nodo');
    WHEN NO_DATA_FOUND THEN
            update ga_transacabo
                        set cod_retorno = 1
                        where num_transaccion = TO_NUMBER(v_num_transaccion);
            RAISE_APPLICATION_ERROR (-20001,'TMError:' || 'No existe Bodega Nodo para Operadora' );
        WHEN OTHERS THEN
            update ga_transacabo
                        set cod_retorno = 1
                        where num_transaccion = TO_NUMBER(v_num_transaccion);
                    RAISE_APPLICATION_ERROR (-20204,v_proced||' '||SQLERRM || ' ' || SQLCODE);
end P_AL_BODEGA_NODO;
/
SHOW ERRORS
