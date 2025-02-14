CREATE OR REPLACE FUNCTION        MONTO_FACTURACION  ( id_cliente IN number, antiguedad number, fch_carga_ini varchar2)
RETURN  number IS
-- *************************************************************
-- * Funcion        : MONTO_FACTURACION
-- * Entrada        : Id-cliente= codigo del cliente, antiguedad= Antiguedad en meses del cliente
-- *                    fch_carga_ini= Fecha de carga inicial.
-- * Salida         : Monto faturado
-- * Descripcion    : Funcion que retorna el monto facturado por cliente
-- * Fecha de creacion  : Agosto 2000
-- * Responsable    : Rosa Maria ALvarez Diaz (DMR Consulting)
-- *************************************************************
v_monto number(8);
v_ciclo number(8);
v_mes number(2);
v_orden number(8);
v_concepto varchar2(40);
v_fecha date;
v_total number(8):=0;
fch_carga date;
dsql varchar2(500);
dsql_cursor integer;
ignore integer;
CURSOR C1 IS
    select ind_ordentotal, cod_ciclfact,fec_emision
    from fa_histdocu
    where cod_cliente=id_cliente and
    cod_tipdocum in (2,3,6,40,43);
BEGIN
    v_total:=0;
    fch_carga:=to_date(OBTIENE_PARAMETRO(fch_carga_ini),'DD-MM-YYYY');
    OPEN C1;
    LOOP
        FETCH C1 INTO v_orden,v_ciclo,v_fecha;
        EXIT WHEN C1%NOTFOUND;
        v_monto:=0;
        --saca numero de mes de la fecha
        v_mes:=to_number(to_char(v_fecha,'mm'));
        --obtiene nombre de la tabla desde tabla de enlace
        select fa_histconc
        into v_concepto
        from  fa_enlacehist
        where cod_ciclfact=v_ciclo;
        --si cae en primer rango
        IF antiguedad < to_number(obtiene_parametro('rango_ant_1')) THEN
            IF v_fecha<fch_carga and months_between(v_fecha,fch_carga)<3 THEN
                BEGIN
                    dsql_cursor:=dbms_sql.open_cursor;
                    dsql:= 'select sum(imp_facturable)' ||
                        ' from ' || v_concepto || ' where cod_concepto in' ||
                        ' (1,2,3,4,22,25,3448,3449,5521,5543,5600,5886)' ||
                        ' and ind_ordentotal=' || v_orden;
                    dbms_sql.parse(dsql_cursor,dsql,dbms_sql.v7);
                    dbms_sql.define_column(dsql_cursor,1,v_monto);
                    ignore:=dbms_sql.execute(dsql_cursor);
                    IF dbms_sql.fetch_rows(dsql_cursor)>0 THEN
                        dbms_sql.column_value(dsql_cursor,1,v_monto);
                    END IF;
                    dbms_sql.close_cursor(dsql_cursor);
                EXCEPTION
                    WHEN no_data_found THEN
                        v_monto:=0;
                END;
                IF v_monto is null THEN
                    v_monto:=0;
                END IF;
            END IF;
        --si cae en segundo rango
        ELSIF antiguedad < to_number(obtiene_parametro('rango_ant_2')) THEN
            IF v_fecha<fch_carga and months_between(v_fecha,fch_carga)<4 THEN
                BEGIN
                    dsql_cursor:=dbms_sql.open_cursor;
                    dsql:= 'select sum(imp_facturable)' ||
                        ' from ' || v_concepto || ' where cod_concepto in' ||
                        ' (1,2,3,4,22,25,3448,3449,5521,5543,5600,5886)' ||
                        ' and ind_ordentotal=' || v_orden;
                    dbms_sql.parse(dsql_cursor,dsql,dbms_sql.v7);
                    dbms_sql.define_column(dsql_cursor,1,v_monto);
                    ignore:=dbms_sql.execute(dsql_cursor);
                    IF dbms_sql.fetch_rows(dsql_cursor)>0 THEN
                        dbms_sql.column_value(dsql_cursor,1,v_monto);
                    END IF;
                    dbms_sql.close_cursor(dsql_cursor);
                EXCEPTION
                    WHEN no_data_found THEN
                        v_monto:=0;
                END;
                IF v_monto is null THEN
                    v_monto:=0;
                END IF;
            END IF;
        --si cae en tercer rango
        ELSIF antiguedad < to_number(obtiene_parametro('rango_ant_3')) THEN
            IF v_fecha<fch_carga and months_between(v_fecha,fch_carga)<5 THEN
                BEGIN
                    dsql_cursor:=dbms_sql.open_cursor;
                    dsql:= 'select sum(imp_facturable)' ||
                        ' from ' || v_concepto || ' where cod_concepto in' ||
                        ' (1,2,3,4,22,25,3448,3449,5521,5543,5600,5886)' ||
                        ' and ind_ordentotal=' || v_orden;
                    dbms_sql.parse(dsql_cursor,dsql,dbms_sql.v7);
                    dbms_sql.define_column(dsql_cursor,1,v_monto);
                    ignore:=dbms_sql.execute(dsql_cursor);
                    IF dbms_sql.fetch_rows(dsql_cursor)>0 THEN
                        dbms_sql.column_value(dsql_cursor,1,v_monto);
                    END IF;
                    dbms_sql.close_cursor(dsql_cursor);
                EXCEPTION
                    WHEN no_data_found THEN
                        v_monto:=0;
                END;
                IF v_monto is null THEN
                    v_monto:=0;
                END IF;
            END IF;
        --si no cayo en ningun rango
        ELSE
             dbms_output.put_line('cliente '|| id_cliente ||' es demasiado antiguo');
        END IF;
        v_total:=v_total+v_monto;
    END LOOP;
    CLOSE C1;
    RETURN round(v_total,0);
END;
/
SHOW ERRORS
