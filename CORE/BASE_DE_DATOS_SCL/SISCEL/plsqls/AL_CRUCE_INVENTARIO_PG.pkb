CREATE OR REPLACE PACKAGE BODY AL_CRUCE_INVENTARIO_PG IS
------------------------------------------------------------------------------------------------------
PROCEDURE AL_INSERTA_SERIESART_INV_PR
(EN_numcruce    IN AL_CRUCE_TO.num_cruce%TYPE,
EN_bodega       IN AL_CRUCE_TO.cod_bodega%TYPE,
EV_stock        IN VARCHAR2)
is

le_salir            exception;
le_salir1           exception;
LV_mensaje          VARCHAR2(3000);
v_articulos_stock   t_articulos_stock;
v_series            t_articulos_stock;
c_series            CUR_TYP;
cur_articulos       CUR_TYP;
v_query             VARCHAR2(500);

PRAGMA AUTONOMOUS_TRANSACTION;

begin
   LV_mensaje:=NULL;
  --series de la bodega en inventario...
    v_series  :=t_articulos_stock(null);
    v_query := 'select '||EN_numcruce ||' as num_cruce,a.cod_bodega as cod_bodega,a.cod_articulo,num_serie,1  from  al_series a where a.cod_bodega = '|| EN_bodega;
    v_query := v_query || ' and tip_stock in ('||EV_stock||')';
    OPEN c_series FOR v_query;
    LOOP
          FETCH c_series BULK COLLECT INTO v_series  LIMIT 100;
          EXIT WHEN v_series.COUNT = 0;

         begin
         FORALL   iInd  IN 1 .. v_series.count
            INSERT INTO al_cruce_series_inv_tt VALUES v_series(iInd);
         EXCEPTION
         WHEN OTHERS THEN
            LV_mensaje:='Error al obtener series en inventario.';
            v_series.delete;
            exit;
         end;
         commit;
         v_series.delete;

    END LOOP;
    CLOSE c_series;
    v_series.delete;

    ---articulos no seriados en inventario....
    v_articulos_stock:=t_articulos_stock(null);
    v_query := 'select '||EN_numcruce ||' as num_cruce,b.cod_bodega,b.cod_articulo,null,b.can_stock from al_articulos a, al_stock b, al_datos_generales c ';
    v_query := v_query ||' where b.cod_bodega = '|| EN_bodega;
    v_query := v_query ||'  and a.cod_articulo=b.cod_articulo and a.ind_seriado=0 ';
    v_query := v_query ||'  and a.tip_articulo<>c.tip_articulo_doc ';
    v_query := v_query || ' and b.tip_stock in ('||EV_stock||')';
    OPEN cur_articulos FOR v_query;
    LOOP
         FETCH cur_articulos BULK COLLECT INTO v_articulos_stock LIMIT 100;
         EXIT WHEN v_articulos_stock.COUNT = 0;
         begin
         FORALL   iInd  IN 1 .. v_articulos_stock.count
            INSERT INTO al_cruce_series_inv_tt VALUES v_articulos_stock (iInd);
         EXCEPTION
         WHEN OTHERS THEN
             LV_mensaje:='Error al obtener articulos no seriados en inventario.';
             exit;
         end;
         commit;
    END LOOP;
    CLOSE cur_articulos;
    v_articulos_stock.delete;

    if LV_mensaje is not null then
       raise le_salir;
    end if;


exception
when le_salir then
     rollback;
     LV_mensaje:=LV_mensaje||' '||SQLERRM;
     raise_application_error(-20100, 'Error: '||LV_mensaje);
when others then
     rollback;
     LV_mensaje:=SQLERRM;
     raise_application_error(-20100, 'Error: '||LV_mensaje);
end  AL_INSERTA_SERIESART_INV_PR;
-----------------------------------------------------------------------------------------------------
PROCEDURE AL_INSERTA_SERIESARTMAS_INV_PR
(EN_numcruce    IN AL_CRUCE_TO.num_cruce%TYPE,
EN_bodega       IN AL_CRUCE_TO.cod_bodega%TYPE,
EV_stock        IN VARCHAR2,
EN_IND_SERIADO  IN AL_ARTICULOS.ind_seriado%TYPE)
is

le_salir            exception;
le_salir1           exception;
LV_mensaje          VARCHAR2(3000);
v_articulos_stock   t_articulos_stock;
v_series            t_articulos_stock;
c_series            CUR_TYP;
cur_articulos       CUR_TYP;
v_query             VARCHAR2(500);

PRAGMA AUTONOMOUS_TRANSACTION;

begin
   LV_mensaje:=NULL;
   
   
   IF EN_IND_SERIADO = 1 THEN
   
          --series de la bodega en inventario...
            v_series  :=t_articulos_stock(null);
            v_query := 'select '||EN_numcruce ||' as num_cruce,a.cod_bodega as cod_bodega,a.cod_articulo,num_serie,1  from  al_series a, al_articulos b where a.cod_bodega = '|| EN_bodega;
            v_query := v_query || ' and  a.cod_articulo = b.cod_articulo ';
            v_query := v_query || ' and  a.tip_stock in ('||EV_stock||')';
            v_query := v_query || ' and  b.ind_seriado = '||EN_IND_SERIADO;
            OPEN c_series FOR v_query;
            LOOP
                  FETCH c_series BULK COLLECT INTO v_series  LIMIT 100;
                  EXIT WHEN v_series.COUNT = 0;

                 begin
                 FORALL   iInd  IN 1 .. v_series.count
                    INSERT INTO al_cruce_series_inv_tt VALUES v_series(iInd);
                 EXCEPTION
                 WHEN OTHERS THEN
                    LV_mensaje:='Error al obtener series en inventario.';
                    v_series.delete;
                    exit;
                 end;
                 commit;
                 v_series.delete;

            END LOOP;
            CLOSE c_series;
            v_series.delete;

   ELSE
   
            ---articulos no seriados en inventario....
            v_articulos_stock:=t_articulos_stock(null);
            v_query := 'select '||EN_numcruce ||' as num_cruce,b.cod_bodega,b.cod_articulo,null,b.can_stock from al_articulos a, al_stock b, al_datos_generales c ';
            v_query := v_query ||' where b.cod_bodega = '|| EN_bodega;
            v_query := v_query ||'  and a.cod_articulo=b.cod_articulo and a.ind_seriado=0 ';
            v_query := v_query ||'  and a.tip_articulo<>c.tip_articulo_doc ';
            v_query := v_query || ' and b.tip_stock in ('||EV_stock||')';
            OPEN cur_articulos FOR v_query;
            LOOP
                 FETCH cur_articulos BULK COLLECT INTO v_articulos_stock LIMIT 100;
                 EXIT WHEN v_articulos_stock.COUNT = 0;
                 begin
                 FORALL   iInd  IN 1 .. v_articulos_stock.count
                    INSERT INTO al_cruce_series_inv_tt VALUES v_articulos_stock (iInd);
                 EXCEPTION
                 WHEN OTHERS THEN
                     LV_mensaje:='Error al obtener articulos no seriados en inventario.';
                     exit;
                 end;
                 commit;
            END LOOP;
            CLOSE cur_articulos;
            v_articulos_stock.delete;
    END IF;
    

    if LV_mensaje is not null then
       raise le_salir;
    end if;


exception
when le_salir then
     rollback;
     LV_mensaje:=LV_mensaje||' '||SQLERRM;
     raise_application_error(-20100, 'Error: '||LV_mensaje);
when others then
     rollback;
     LV_mensaje:=SQLERRM;
     raise_application_error(-20100, 'Error: '||LV_mensaje);
end  AL_INSERTA_SERIESARTMAS_INV_PR;
PROCEDURE AL_VALIDA_SERIES_CRUCE_PR (EN_numcruce    IN AL_CRUCE_TO.num_cruce%TYPE,
EV_stock        IN VARCHAR2)
IS

CURSOR Series (LN_Numcruce AL_CRUCE_TO.num_cruce%TYPE) IS
SELECT  * FROM  AL_CRUCE_SERIES_TO WHERE NUM_CRUCE=LN_Numcruce and det_cruce like '%.OK.';

CURSOR Fisico (LN_Numcruce AL_CRUCE_TO.num_cruce%TYPE) IS
SELECT  * FROM  AL_CRUCE_SERIES_INV_TT WHERE NUM_CRUCE=LN_Numcruce AND NUM_SERIE IS NOT NULL;

LN_cantidad             al_Cruce_series_inv_tt.CANTIDAD%TYPE;
ln_existe               number(1);
LN_bodega               al_cruce_series_inv_tt.cod_bodega%TYPE;
LN_articulo             al_cruce_series_inv_tt.cod_articulo%TYPE;
le_lee_otro             exception;
LV_mensaje              al_cruce_series_to.det_cruce%TYPE;
LV_des_articulo         al_Articulos.des_articulo%TYPE;
LV_des_bodega           al_bodegas.des_bodega%TYPE;
LV_mensaje_pr           VARCHAR2(3000);
TYPE                    t_AL_CRUCE_SERIES_INV_TT IS TABLE OF AL_CRUCE_SERIES_INV_TT%ROWTYPE index by binary_integer;
v_series_inv_tt         t_AL_CRUCE_SERIES_INV_TT;
j                       binary_integer;
TYPE                    t_AL_CRUCE_SERIES_TO IS TABLE OF AL_CRUCE_SERIES_TO%ROWTYPE index by binary_integer;
v_series_to             t_AL_CRUCE_SERIES_TO;
ln_tip_stock            al_tipos_stock.tip_stock%TYPE;
lv_desstock             al_tipos_stock.DES_STOCK%TYPE;
lv_sql2                 varchar2(1000);
ln_nostock              number(11);

PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    LV_mensaje_pr:=null;
     --Cursor de series
    v_series_inv_tt.delete;
    OPEN Series(EN_numcruce);
    LOOP
          j:=0;
          v_series_to.DELETE;
          FETCH Series BULK COLLECT INTO v_series_to  LIMIT 100;
          EXIT WHEN v_series_to.COUNT = 0;

          FOR i  IN 1 ..v_series_to.count loop
              begin
              --  DBMS_OUTPUT.PUT_LINE(' v_series_to(i).NUM_SERIE: '|| v_series_to(i).NUM_SERIE);
                if  v_series_to(i).NUM_SERIE is not null then
                    ln_existe:=1;
                    LN_bodega:=NULL;
                    LN_articulo:=NULL;
                    LV_des_articulo:=NULL;
                    BEGIN
                        SELECT a.cod_bodega,a.cod_articulo,b.des_articulo into LN_bodega, LN_articulo,LV_des_articulo
                          FROM AL_CRUCE_SERIES_INV_TT a, al_articulos b
                         WHERE a.NUM_CRUCE=EN_numcruce and a.NUM_SERIE=v_series_to(i).NUM_SERIE and
                               a.cod_articulo=b.cod_articulo(+);
                    EXCEPTION
                    WHEN others THEN
                         ln_existe:=0;
                    END;
                    if ln_existe=1 then
                       if v_series_to(i).cod_articulo is not null then
                          if v_series_to(i).cod_articulo=LN_articulo then
                             LV_mensaje:='Cruzado';
                             v_series_to(i).cantidad:=1;
                          else
                              LV_mensaje:='Sistema Faltante con artículo '||LN_articulo||' '||LV_des_articulo;
                          end if;
                       else
                           v_series_to(i).cod_articulo:=LN_articulo;
                           v_series_to(i).cantidad:=1;
                           LV_mensaje:='Cruzado';
                       end if;
                    else
                        ln_existe:=1;
                        LN_bodega:=NULL;
                        LN_articulo:=NULL;
                        LV_des_bodega:=NULL;
                        LV_des_articulo:=NULL;
                        lv_desstock:=null;
                        ln_tip_stock:=null;
                        BEGIN
                            SELECT a.cod_bodega,a.cod_articulo,b.des_bodega,c.des_articulo,a.tip_stock,d.des_stock
                              into LN_bodega, LN_articulo,LV_des_bodega,LV_des_articulo,ln_tip_stock,lv_desstock
                              FROM AL_SERIES a, al_bodegas b, al_articulos c, al_tipos_stock d
                             WHERE a.NUM_SERIE=v_series_to(i).NUM_SERIE and
                                   a.cod_bodega=b.cod_bodega(+) and
                                   a.cod_articulo=c.cod_articulo(+) and
                                   a.tip_stock=d.tip_stock(+);
                        EXCEPTION
                        WHEN others THEN
                             ln_existe:=0;
                        END;
                        if ln_existe=1 then
                            if lv_desstock is null then
                               lv_desstock:=ln_tip_stock;
                            end if;
                            if v_series_to(i).cod_articulo is not null then
                                  if v_series_to(i).cod_articulo=LN_articulo then
                                     LV_mensaje:='Sistema Faltante (existe en bodega '||LN_bodega||' '||LV_des_bodega||', con stock='||lv_desstock||')';
                                  else
                                     LV_mensaje:='Sistema Faltante (existe en bodega '||LN_bodega||' '||LV_des_bodega||', con articulo '||LN_articulo||' '||LV_des_articulo||', con stock='||lv_desstock||')';
                                  end if;
                           else
                                    LV_mensaje:='Sistema Faltante (existe en bodega '||LN_bodega||' '||LV_des_bodega||' y con articulo '||LN_articulo||' '||LV_des_articulo||', con stock='||lv_desstock||')';
                           end if;
                        else
                           LV_mensaje:='Sistema Faltante';
                        end if;

                    end if;
                else --dado que la serie es nula entonces es un articulo....
                    ln_existe:=1;
                    LN_cantidad:=0;
                    begin
                        select nvl(sum(a.cantidad),0) into LN_cantidad from al_Cruce_series_inv_tt a
                         where  a.num_cruce=EN_numcruce and a.cod_articulo=v_series_to(i).cod_articulo;
                    exception
                    when others then
                         ln_existe:=0;
                    end;
                    if LN_cantidad=0 then
                       ln_existe:=0;
                    end if;
                    if ln_existe=1 then
                       if LN_cantidad = v_series_to(i).cantidad then
                          LV_mensaje:='Cruzado';
                       else
                          if LN_cantidad > v_series_to(i).cantidad then
                             LV_mensaje:='Fisico faltante. Cantidad en inventario:'||LN_cantidad||', stock:'||EV_stock;
                          else
                             LV_mensaje:='Sistema faltante. Cantidad en inventario:'||LN_cantidad||', stock:'||EV_stock;
                          end if;
                       end if;
                    else
                       lv_sql2:=' select nvl(sum(a.can_stock),0)  from al_stock a ';
                       lv_sql2:= lv_sql2 ||' where a.cod_bodega='||v_series_to(i).cod_bodega;
                       lv_sql2:= lv_sql2 ||' and  a.cod_articulo='||v_series_to(i).cod_articulo;
                       lv_sql2:= lv_sql2 ||' AND a.tip_stock not in ('|| ev_stock||')';
                                   
                       EXECUTE IMMEDIATE lv_sql2 INTO ln_nostock;     
                       if ln_nostock>0 then
                           LV_mensaje:='Sistema faltante  Cantidad en inventario (otros stocks).:'||ln_nostock;
                       else
                          LV_mensaje:='Sistema faltante';
                       end if;
                    
                    end if;
                end if;
                v_series_to(i).det_cruce:=LV_mensaje;
             EXCEPTION
             WHEN OTHERS THEN
                 null;
             end;
         end loop;


          FOR i  IN 1 ..v_series_to.count loop
          begin
              if  v_series_to(i).NUM_SERIE is not null then
                  update al_cruce_series_to set det_cruce=v_series_to(i).det_cruce,
                                          cod_articulo=v_series_to(i).cod_articulo
                      WHERE NUM_CRUCE=EN_numcruce and NUM_SERIE=v_series_to(i).NUM_SERIE;

              else
                  update al_cruce_series_to set det_cruce=v_series_to(i).det_cruce
                  WHERE NUM_CRUCE=EN_numcruce and cod_articulo=v_series_to(i).cod_articulo;
              end if;
          exception
          when others then
               null;
          end;
          end loop;

   END LOOP;
   CLOSE Series;



    OPEN Fisico(EN_numcruce);
    LOOP
          j:=0;
          v_series_to.delete;
          v_series_inv_tt.delete;
          FETCH Fisico BULK COLLECT INTO v_series_inv_tt  LIMIT 100;
          EXIT WHEN v_series_inv_tt.COUNT = 0;
          FOR i  IN 1 ..v_series_inv_tt.count loop
              begin
                    begin
                      SELECT a.NUM_CRUCE into LN_cantidad
                        FROM AL_CRUCE_SERIES_TO a
                       WHERE a.NUM_CRUCE=EN_numcruce and a.NUM_SERIE=v_series_inv_tt(i).NUM_SERIE;
                    exception
                    when others then
                       j:=j+1;
                       v_series_to(j).num_cruce:=v_series_inv_tt(i).num_cruce;
                       v_series_to(j).cod_bodega:=v_series_inv_tt(i).cod_bodega;
                       v_series_to(j).cod_bodega:=v_series_inv_tt(i).cod_bodega;
                       v_series_to(j).cod_articulo:=v_series_inv_tt(i).cod_articulo;
                       v_series_to(j).num_serie:=v_series_inv_tt(i).num_serie;
                       v_series_to(j).cantidad:=v_series_inv_tt(i).cantidad;
                       v_series_to(j).det_cruce:='Fisico Faltante';
                    end;
             EXCEPTION
             WHEN OTHERS THEN
                null;
             end;
         end loop;

        IF J>0 THEN
            begin
             FORALL   i  IN 1 ..v_series_to.count
                INSERT INTO AL_CRUCE_SERIES_TO VALUES v_series_to(i);
             EXCEPTION
             WHEN OTHERS THEN
                null;
             end;
        END IF;


  END LOOP;
  CLOSE Fisico;
  v_series_to.delete;
  v_series_inv_tt.delete;
  v_series_inv_tt.delete;
   commit;

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        LV_mensaje_pr:=SQLERRM;
        raise_application_error(-20100, 'Error: '|| LV_mensaje_pr);
END AL_VALIDA_SERIES_CRUCE_PR;
-----------------------------------------------------------------------------------------------------
PROCEDURE AL_FINALIZA_CRUCE_PR
(EN_numcruce    IN AL_CRUCE_TO.num_cruce%TYPE,
EV_estado       IN AL_CRUCE_TO.EST_CRUCE%TYPE)
is
begin

          IF EV_estado='CAN' THEN
             DELETE FROM AL_CRUCE_SERIES_TO  WHERE NUM_CRUCE=EN_numcruce;
          END IF;

         DELETE FROM AL_CRUCE_SERIES_INV_TT WHERE NUM_CRUCE=EN_numcruce;

         UPDATE AL_CRUCE_TO SET EST_CRUCE=EV_estado WHERE num_cruce=EN_numcruce;


exception
when others then
     raise_application_error(-20100, 'Error: '||SQLERRM);
end  AL_FINALIZA_CRUCE_PR;

------------------------------------------------------------------------------------------------------
procedure Al_GENERA_RANGOS_TRASPASOS_pr
(EN_num_traspaso IN AL_TRASPASOS.num_traspaso%TYPE,
EN_tipo_articulo in al_articulos.tip_articulo%TYPE,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError) is

ln_existe  number(10);
le_salir   exception;

GV_rango_inicial   AL_SER_TRASPASO.num_serie%TYPE;
GV_rango_final     AL_SER_TRASPASO.num_serie%TYPE;
GV_serie_anterior  AL_SER_TRASPASO.num_serie%TYPE;
Ind PLS_INTEGER := 0;
TYPE TYP_RANGO_INI IS TABLE OF AL_SER_TRASPASO.num_serie%TYPE  INDEX BY BINARY_INTEGER;
TYPE TYP_RANGO_FIN IS TABLE OF AL_SER_TRASPASO.num_serie%TYPE  INDEX BY BINARY_INTEGER;

RANGO_INI TYP_RANGO_INI;
RANGO_FIN TYP_RANGO_FIN;

CURSOR LIN_TRASPASO (EN_num_traspaso IN AL_TRASPASOS.num_traspaso%TYPE,EN_tip_articulo in AL_TIPOS_ARTICULOS.TIP_ARTICULO%type) IS
SELECT a.NUM_TRASPASO, a.lin_TRASPASO, A.cod_articulo
  FROM AL_LIN_TRASPASO a, al_articulos b
 WHERE a.num_traspaso = EN_num_traspaso
  AND a.cod_articulo = b.cod_articulo
  and b.tip_articulo  = EN_tip_articulo;

CURSOR SERIES(EN_num_traspaso IN AL_TRASPASOS.num_traspaso%TYPE, EN_lin_traspaso IN AL_LIN_TRASPASO.lin_traspaso%TYPE) IS
SELECT a.num_serie serie FROM AL_SER_TRASPASO a
WHERE a.num_traspaso = EN_num_traspaso
AND a.lin_traspaso = EN_lin_traspaso
ORDER BY a.num_serie;

PRAGMA AUTONOMOUS_TRANSACTION;

begin
    SV_mens_retorno:='';
    --verifica si existen rangos para el traspaso....
    select count(1) into LN_existe from al_rango_series_to  where num_traspaso=EN_num_traspaso;
    if ln_existe>0 then
       raise le_salir;
    end if;



    FOR C_LIN_TRASPASO IN LIN_TRASPASO(EN_num_traspaso,EN_tipo_articulo) LOOP

          FOR C_SERIES IN SERIES(EN_num_traspaso,C_LIN_TRASPASO.lin_TRASPASO) LOOP
                   IF GV_rango_inicial IS NULL THEN
                      GV_rango_inicial := GV_serie_anterior;
                   END IF;
                   IF GV_serie_anterior IS NOT NULL THEN
                           IF TO_number(substr(GV_serie_anterior,1,length(GV_serie_anterior)-1)) + 1 < TO_NUMBER(substr(C_SERIES.serie,1,length(C_SERIES.serie)-1)) THEN
                                  Ind := Ind + 1;
                                  GV_rango_final := GV_serie_anterior;

                                  RANGO_INI(Ind):= GV_RANGO_INICIAL;
                                  RANGO_FIN(Ind):= GV_RANGO_FINAL;
                                  GV_rango_inicial := NULL;
                                  GV_rango_final := NULL;
                           END IF;
                   END IF;
                   GV_serie_anterior:=C_SERIES.serie;
           END LOOP;

           Ind := Ind + 1;
           IF GV_rango_inicial IS NOT NULL THEN
                  IF GV_serie_anterior IS NULL THEN
                          GV_rango_final := GV_rango_inicial;
                  ELSE
                          GV_rango_final := GV_serie_anterior;
                  END IF;
           ELSE
                  GV_rango_inicial:= GV_serie_anterior;
                  GV_rango_final:= GV_serie_anterior;
           END IF;
                  RANGO_INI(Ind):= GV_rango_inicial;
                  RANGO_FIN(Ind):= GV_rango_final;


           FORALL v_j IN 1..Ind
                 INSERT INTO AL_RANGO_SERIES_TO
                 (num_traspaso,lin_traspaso,serie_inicial,serie_final,cod_articulo)
                  VALUES (EN_num_traspaso,C_LIN_TRASPASO.lin_TRASPASO,RANGO_INI(v_j),RANGO_FIN(v_j),C_LIN_TRASPASO.cod_articulo);

    END LOOP;

     SV_mens_retorno:='OK';
     commit;
exception
when le_salir then
     SV_mens_retorno:='OK';
when others then
    rollback;
    SV_mens_retorno:=sqlerrm;
end  AL_GENERA_RANGOS_TRASPASOS_pr;
END AL_CRUCE_INVENTARIO_PG;
/
SHOW ERRORS

