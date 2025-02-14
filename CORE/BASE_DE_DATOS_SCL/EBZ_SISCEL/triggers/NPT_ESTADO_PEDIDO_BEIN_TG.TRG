CREATE OR REPLACE TRIGGER "EBZ_SISCEL".npt_estado_pedido_BEIN_TG
/*
<Documentación TipoDoc = "TRIGGER">
<Elemento Nombre = "npt_estado_pedido_BEIN_TG" Lenguaje="PL/SQL" Fecha="10-11-2004" Versión="1.0.0" Diseñador="****" Programador="****" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Trigger encargado de validar las cantidades de series y totales de los pedidos npw</Descripción>
<Parámetros>
<Entrada> </Entrada>
<Salida></Salida>
</Parámetros>
<FechaMod>22-03-2007</FechaMod>
<DesMod>Incoporacion de validación de cantidad de accesorios no se seriados</DesMod>
<VersionMod>1.1.0   Inc. 38808</VersionMod>
</Elemento>
</Documentación>
*/
before INSERT
ON NPT_ESTADO_PEDIDO
FOR EACH ROW
DECLARE
        estado_invalido exception;
        cantidad_inconsistente1 exception;
        cantidad_inconsistente2 exception;
        v_cod_est_flujo NUMBER(2);
        v_can_pedido    number(8);
        v_can_series    number(8);
        v_det_series    number(8);
BEGIN
    if :new.cod_estado_flujo = 9 then
            select nvl(can_total_pedido,0) into v_can_pedido
                from   npt_pedido
                where  cod_pedido = :new.cod_pedido;
                if v_can_pedido = 0 then
                raise cantidad_inconsistente1;
                end if;

--              Inicio Inc. 38808
                select nvl(sum(CAN_DETALLE_PEDIDO),0) into v_det_series
                from   npt_detalle_pedido a
                where  cod_pedido = :new.cod_pedido
                and cod_articulo in (select cod_articulo from al_articulos
        where ind_seriado = 0
        and ind_equiacc = 'A');
--              Fin Inc. 38808
            select nvl(count(1), 0) into v_can_series
                from   npt_serie_pedido
                where  cod_pedido = :new.cod_pedido
        and substr(cod_serie_pedido, 1, 10) = 'NO SERIADO';

             if v_can_series = 0 then
                        select nvl(count(1), 0) into v_can_series
                        from   npt_serie_pedido
                        where  cod_pedido = :new.cod_pedido;

--                  if v_can_series <> v_can_pedido then
             if (v_can_series <> v_can_pedido) and (v_can_pedido <> (v_can_series + v_det_series)) then --              Inicio Inc. 33818
--                 DBMS_OUTPUT.PUT_LINE('Cantidad de series a insertar no corresponde al pedido');
                   raise cantidad_inconsistente2;
                end if;
                 end if;

        end if;
        exception
                when cantidad_inconsistente1 then
                    raise_application_error (-20141,'Cantidad inconsistente en NPT_PEDIDO');
                when cantidad_inconsistente2 then
                    raise_application_error (-20141,'Cantidad de series a insertar no corresponde al pedido');
end;
/
SHOW ERRORS
