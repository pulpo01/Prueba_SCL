CREATE OR REPLACE FUNCTION IC_CADENA_PLANES_ADIC(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
/************************************************************/
/* Programado por: Carlos Molina                            */
/* Empresa: TELEFONICA                                      */
/* Fecha :  07/03/2011                                      */
/************************************************************/
/* Retorna una cadena de planes adicionales                 */
/************************************************************/

v_imei VARCHAR2(25) := null;
v_pa VARCHAR2(10) := null;
v_cadena VARCHAR2(128) := '_';

CURSOR CURSOR_PLANES IS
select distinct(d.cod_espec_prov) from PR_PRODUCTOS_CONTRATADOS_TO a, PF_PRODUCTOS_OFERTADOS_TD b, SE_DETALLES_ESPECIFICACION_TO c, SE_DETALLE_PROVISIONAMIENTO_TD d, icc_movimiento e 
where a.cod_prod_ofertado = b.cod_prod_ofertado
and c.cod_servicio_base = b.id_prod_ofertado
and c.cod_prov_serv = d.cod_prov_serv 
and c.cod_prov_serv is not null
and d.tipo_accion = '1'
and a.num_abonado_beneficiario = e.num_abonado 
and e.num_movimiento = EN_num_mov;


begin


    OPEN CURSOR_PLANES;
    LOOP
        FETCH CURSOR_PLANES INTO  v_pa;
        EXIT WHEN CURSOR_PLANES%NOTFOUND;
    v_cadena := v_cadena || v_pa || '_' ;
    END LOOP;
    CLOSE CURSOR_PLANES;

RETURN v_cadena;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
                RETURN '|';

end;
/
SHOW ERRORS
