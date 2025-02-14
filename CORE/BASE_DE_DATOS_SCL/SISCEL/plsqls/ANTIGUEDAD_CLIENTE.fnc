CREATE OR REPLACE FUNCTION        antiguedad_cliente(id_cli IN number, nom_param varchar2) RETURN number
IS
-- *************************************************************
-- * Funcion        : antiguedad_cliente
-- * Salida     : Antiguedad del cliente expresada en meses
-- * Descripcion    : Funcion que retorna el tiempo de permanencia del ABONADO vigente
-- * mas antiguo en meses.
-- * Fecha de creacion  : Agosto 2000
-- * Responsable    : Rosa Maria ALvarez Diaz (DMR Consulting)
-- *************************************************************
CURSOR C1 IS select distinct min(fec_venta)
        FROM ga_ventas
        WHERE num_venta in
            (   select num_venta
                from ga_abocel
                where cod_cliente=id_cli
                and cod_situacion<>'BAA'
                and cod_situacion<>'BAP'
            );
antiguo DATE;
tiempo NUMBER;
fch_carga date;
BEGIN
    BEGIN
        OPEN C1;
        FETCH C1 INTO antiguo;
        CLOSE C1;
    EXCEPTION
        WHEN no_data_found THEN
            tiempo:=-1;
    END;
    fch_carga:=to_date(obtiene_parametro(nom_param),'DD-MM-YYYY');
    tiempo:=round(MONTHS_BETWEEN(fch_carga,antiguo),0);
    if fch_carga is null then
        raise_application_error(-20101, 'No se ha ingresado la fecha de carga....');
    end if;
    if tiempo < 0 or tiempo is null then
        return -1;
    end if;
    return tiempo;
END;--fin de antiguedad_cliente
/
SHOW ERRORS
