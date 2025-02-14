CREATE OR REPLACE PACKAGE BODY        AL_PRO_ALARMA IS
--
--
--
--
--
  --
  -- Retrofitted
  PROCEDURE p_alarma_minmax(
  v_minmax IN al_minimos_maximos%rowtype )
  IS
     v_can_stock   al_stock.can_stock%type;
     v_alarma      al_alarmas_stock%rowtype;
  BEGIN
  --
  -- Procedimiento que sera llamado desde los trigger before insert y
  -- before update de al_minimos_maximos.
  --
  -- En caso de que la fila generada en al_minimos_maximos no tenga equivalencia
  -- en al_stock se considera que el stock existente para el item definido es
  -- igual a cero
  --
     p_lee_stock (v_minmax,v_can_stock);
     if v_can_stock < v_minmax.can_minima then
        p_select_numero (v_alarma.num_alarma);
        v_alarma.fec_alarma   := sysdate;
        v_alarma.cod_bodega   := v_minmax.cod_bodega;
        v_alarma.tip_stock    := v_minmax.tip_stock;
        v_alarma.cod_articulo := v_minmax.cod_articulo;
        v_alarma.cod_uso      := v_minmax.cod_uso;
        v_alarma.cod_estado   := v_minmax.cod_estado;
        v_alarma.can_stock    := v_can_stock;
        v_alarma.can_minima   := v_minmax.can_minima;
        p_crea_alarma (v_alarma);
     end if;
  EXCEPTION
     when others then
          null;
  --
  -- En caso de que hay fallado alguno de los procedimientos llamados el error
  -- sera frenado para que la accion de insert o update de al_minimos_maximos
  -- continue.
  --
  END;
  --
  -- Retrofitted
  PROCEDURE p_alarma_stock(
  v_stock IN al_stock%rowtype )
  IS
     v_can_minima  al_minimos_maximos.can_minima%type;
     v_alarma      al_alarmas_stock%rowtype;
  BEGIN
  --
  -- Procedimiento que sera llamado desde los trigger before insert y
  -- before update de al_stock.
  --
  -- En caso de que la fila tratada en al_stock no tenga definidos minimos y
  -- maximos en al_minimos_maximos no habra posibilidad de generacion de alarma
  --
     p_lee_minmax (v_stock,v_can_minima);
     if v_stock.can_stock < v_can_minima then
        p_select_numero (v_alarma.num_alarma);
        v_alarma.fec_alarma   := sysdate;
        v_alarma.cod_bodega   := v_stock.cod_bodega;
        v_alarma.tip_stock    := v_stock.tip_stock;
        v_alarma.cod_articulo := v_stock.cod_articulo;
        v_alarma.cod_uso      := v_stock.cod_uso;
        v_alarma.cod_estado   := v_stock.cod_estado;
        v_alarma.can_stock    := v_stock.can_stock;
        v_alarma.can_minima   := v_can_minima;
        p_crea_alarma (v_alarma);
     end if;
  EXCEPTION
     when others then
          null;
  --
  -- En caso de que haya fallado alguno de los procedimientos llamados el error
  -- sera frenado para que la accion de insert o update de al_stock continue.
  --
  END;
  --
  -- Retrofitted
  PROCEDURE p_select_numero(
  v_numero IN OUT al_alarmas_stock.num_alarma%type )
  IS
  BEGIN
      select al_seq_alarmas.nextval into v_numero
             from dual;
  EXCEPTION
     when others then
          raise exception_alarma;
  END;
  --
  -- Retrofitted
  PROCEDURE p_lee_minmax(
  v_stock IN al_stock%rowtype ,
  v_can_minima IN OUT al_minimos_maximos.can_minima%type )
  IS
  BEGIN
      select can_minima into v_can_minima
             from al_minimos_maximos
             where cod_bodega   = v_stock.cod_bodega
               and tip_stock    = v_stock.tip_stock
               and cod_articulo = v_stock.cod_articulo
               and cod_uso      = v_stock.cod_uso
               and cod_estado   = v_stock.cod_estado
               and can_minima   > 0;
  EXCEPTION
     when others then
          raise exception_alarma;
  END;
  --
  -- Retrofitted
  PROCEDURE p_lee_stock(
  v_minmax IN al_minimos_maximos%rowtype ,
  v_can_stock IN OUT al_stock.can_stock%type )
  IS
  BEGIN
      select can_stock into v_can_stock
             from al_stock
             where cod_bodega   = v_minmax.cod_bodega
               and tip_stock    = v_minmax.tip_stock
               and cod_articulo = v_minmax.cod_articulo
               and cod_uso      = v_minmax.cod_uso
               and cod_estado   = v_minmax.cod_estado;
  EXCEPTION
     when others then
          v_can_stock := 0;
  END;
  --
  -- Retrofitted
  PROCEDURE p_crea_alarma(
  v_alarma  al_alarmas_stock%rowtype )
  IS
  BEGIN
     insert into al_alarmas_stock (num_alarma,
                                   fec_alarma,
                                   cod_bodega,
                                   tip_stock,
                                   cod_articulo,
                                   cod_uso,
                                   cod_estado,
                                   can_stock,
                                   can_minima)
            values (v_alarma.num_alarma,
                    v_alarma.fec_alarma,
                    v_alarma.cod_bodega,
                    v_alarma.tip_stock,
                    v_alarma.cod_articulo,
                    v_alarma.cod_uso,
                    v_alarma.cod_estado,
                    v_alarma.can_stock,
                    v_alarma.can_minima);
  EXCEPTION
    when others then
         raise exception_alarma;
  END;
END AL_PRO_ALARMA;
/
SHOW ERRORS
