CREATE OR REPLACE PROCEDURE          "CARGA_PUNTAJES_INICIALES" IS
-- *************************************************************
-- * Funcion        : carga_puntajes iniciales
-- * Salida         : N/A
-- * Descripcion    : calcula el puntaje inicial para los clientes
-- *                  de TelefonicaMovil, usando criterios duiversos.
-- * Fecha de creacion  : Agosto 2000
-- * Responsable    : Thomas Armstrong (DMR Consulting)
-- *************************************************************
 antiguedad  number;
 facturado   number;
 puntaje     number;
 cliente number;
 cuenta number;
-- cursor que busca todos los documentos de FA_HISTDOCU
 CURSOR C1 IS
select cod_cliente
from ge_clientes b,re_tmp_amistar a
where a.num_seried=b.num_ident and cod_tipident='01';
BEGIN
    OPEN C1;
    LOOP
        FETCH C1 INTO cliente;
        EXIT WHEN C1%NOTFOUND;
        BEGIN
            --obtiene codigo de cuenta del cliente
            select distinct cod_cuenta
            into cuenta
            from ga_abocel where cod_cliente=cliente;
        EXCEPTION
            WHEN no_data_found THEN
                dbms_output.put_line('No se encuentra cod_cuenta de cod_cliente='||cliente);
                cuenta:=0;
        END;
        --antiguedad del cliente en meses
        antiguedad := ANTIGUEDAD_CLIENTE(cliente,'fch_carga_ini');
        --si tiene un mes o mas, asigna puntaje inicial
        IF antiguedad >0 THEN
            --calcula monto facturado en ultimos meses, segun la antiguedad
            facturado  := MONTO_FACTURACION(cliente,antiguedad,'fch_carga_ini');
            IF  facturado > 0 THEN
                --calcula el puntaje segun la antiguedad y el monto facturado
                puntaje    := CALCULA_PUNTAJE(facturado,antiguedad);
             --si tiene puntaje, lo almacena
                IF puntaje>0 THEN
                    INSERT INTO GEH_PUNTAJE_CLIENTES_HIST
                    (COD_CLIENTE,COD_CUENTA,COD_MOTIVO,FEC_REGISTRO_DH,PJE_POSITIVO,PJE_NEGATIVO)
                    VALUES (cliente,cuenta,0,sysdate,puntaje,0);
                    commit;
                END IF;
             END IF;
       END IF;
    END LOOP;--busca siguiente cliente
END;
/
SHOW ERRORS
