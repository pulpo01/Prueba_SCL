CREATE OR REPLACE PROCEDURE P_AL_COMPSERIES(
    v_serie IN al_compseries.num_serie%type,
    v_nomform IN al_compseries.nom_form%type
)
IS
/*
<NOMBRE>       : P_AL_COMPSERIES   .</NOMBRE>
<FECHACREA>       : 16/12/2005<FECHACREA/>
<MODULO >       : AL </MODULO >
<AUTOR >       :  </AUTOR >
<VERSION >     : 1.1</VERSION >
<DESCRIPCION>  : Procedimiento encargado de validar estados de series a ingresar por medio de Entradas Extras</DESCRIPCION>
<FECHAMOD >    : 29-05-2006 </FECHAMOD >
<DESCMOD >     : Se incorpora validacion de simcar en tabla ga_abocel . Inc CO-200605240161  IPCT . Además se optimisan los queris de busqueda y validación </DESCMOD >
<FECHAMOD >    : 23/06/2006 </FECHAMOD > 
<DESCMOD >     : Optimizar los accesos que se realizan a la tabla NPT_ESTADO_PEDIDO Inc MA-200606190940  </DESCMOD >  
<VERSIONMOD>     : 1.2</VERSIONMOD> 
*/

    SERIE_EXISTENTE EXCEPTION;
      v_encbod NUMBER;
BEGIN
    v_encbod := 0;
 -- INICIO INCIDENCIA TM-081220030423
    if v_nomform = 'FRMMANSALIDASEXTRAS' then
        BEGIN
           SELECT count(1)
           INTO v_encbod
           FROM AL_SERIES A, GA_RESERVFOL B
           WHERE A.NUM_SERIE = v_serie  AND
           A.NUM_SERIE = B.NUM_SERIE  AND
           B.NUM_SERIE > 0  AND
           A.IND_TELEFONO <>  (SELECT VAL_PARAMETRO
                               FROM GED_PARAMETROS
                               WHERE COD_MODULO = 'GE' AND COD_PRODUCTO = 1 AND
                               NOM_PARAMETRO = 'IND_TEL_OUT');
           if v_encbod <> 0 then
        v_encbod := 11;
                   RAISE SERIE_EXISTENTE;
           end if;
        END;
        BEGIN
           SELECT count(1)
           INTO v_encbod
           FROM NPT_SERIE_PEDIDO A
           WHERE A.COD_SERIE_PEDIDO = v_serie  AND
           49 <> (SELECT COD_ESTADO_FLUJO FROM NPT_ESTADO_PEDIDO B
           WHERE B.COD_PEDIDO = A.COD_PEDIDO  AND
           FEC_CRE_EST_PEDIDO=(SELECT MAX(FEC_CRE_EST_PEDIDO)
                               FROM NPT_ESTADO_PEDIDO
                               WHERE COD_PEDIDO=B.COD_PEDIDO AND NVL(COD_PEDIDO,COD_PEDIDO) > 0));  --Inc MA-200606190940 ipct 
           if v_encbod <> 0 then
        v_encbod := 12;
                   RAISE SERIE_EXISTENTE;
           end if;
        END;
        RETURN;
     end if;
  if v_nomform = 'FRMMANENTRADASEXTRAS' or v_nomform = 'FRMCREAORDING' then
      SELECT count(1) into v_encbod
      FROM AL_COMPONENTE_KIT
      WHERE NUM_SERIE = v_serie
      AND NUM_KIT IN(SELECT NUM_SERIE FROM AL_SERIES);
      if v_encbod <> 0 then
         v_encbod := 8;
            RAISE SERIE_EXISTENTE;
      end if;
  end if;
 -- FIN INCIDENCIA TM-081220030423
    SELECT count(1) INTO v_encbod FROM AL_SERIES WHERE NUM_SERIE = v_serie;
    if v_encbod <> 0 then
        v_encbod := 1;
        RAISE SERIE_EXISTENTE;
    end if;
    if v_nomform = 'FRMSERIEORD' then
         SELECT count(1) into v_encbod FROM AL_VSERIES_ORDENES a, AL_VCABECERA_ORDENES b
              WHERE a.NUM_SERIE = v_serie AND a.TIP_ORDEN = 2
            AND b.NUM_ORDEN = a.NUM_ORDEN AND b.TIP_ORDEN = a.TIP_ORDEN
            AND b.COD_ESTADO <> 'CE';
        if v_encbod <> 0 then
            v_encbod := 2;
            RAISE SERIE_EXISTENTE;
         end if;
    end if;
    if v_nomform = 'FRMCREAORDING' then
        SELECT count(1) into v_encbod FROM AL_VSERIES_ORDENES a, AL_VCABECERA_ORDENES b
              WHERE a.NUM_SERIE = v_serie AND a.TIP_ORDEN = 2
            AND b.NUM_ORDEN = a.NUM_ORDEN AND b.TIP_ORDEN = a.TIP_ORDEN
            AND b.COD_ESTADO = 'NU';
        if v_encbod <> 0 then
            v_encbod := 2;
            RAISE SERIE_EXISTENTE;
         end if;
    end if;
    if v_nomform = 'FRMMANENTRADASEXTRAS' or v_nomform = 'FRMENTREGAREEM' then
        SELECT count(1) into v_encbod FROM AL_FIC_SERIES
              WHERE NUM_SERIE = v_serie;
                              if v_encbod <> 0 then
            v_encbod := 2;
                         RAISE SERIE_EXISTENTE;
         end if;
    end if;
    IF  LENGTH(v_serie) = 15 then
        -- Si es IMEI verifica que no este con abonado.. pero con campo NUM_IMEI ....
        -- Inicio Inc CO-200605240161    ipct
        SELECT count(1) into v_encbod FROM GA_ABOAMIST WHERE NUM_IMEI = v_serie
        AND cod_situacion not in ('BAA','BAP');
        if v_encbod <> 0 then
           v_encbod := 3;
           RAISE SERIE_EXISTENTE;
        end if;
        SELECT count(1) into v_encbod FROM GA_ABOCEL WHERE NUM_IMEI = v_serie
        AND cod_situacion not in ('BAA','BAP');
        if v_encbod <> 0 then
           v_encbod := 4;
           RAISE SERIE_EXISTENTE;
        end if;
    else
        SELECT count(1) into v_encbod FROM GA_ABOAMIST WHERE NUM_SERIE = v_serie
        AND cod_situacion not in ('BAA','BAP');
        if v_encbod <> 0 then
           v_encbod := 3;
           RAISE SERIE_EXISTENTE;
        end if;
        SELECT count(1) into v_encbod FROM GA_ABOCEL WHERE NUM_SERIE = v_serie
        AND cod_situacion not in ('BAA','BAP');
        if v_encbod <> 0 then
            v_encbod := 4;
            RAISE SERIE_EXISTENTE;
        end if;
        -- Fin Inc CO-200605240161    ipct
    end if;
       if LENGTH(v_serie) = 11 then
           -- Celulares
          SELECT count(1) into v_encbod FROM GA_ABOCEL WHERE NUM_SERIE = v_serie AND COD_SITUACION <> 'BAA';
        if v_encbod <> 0 then
            v_encbod := 4;
            RAISE SERIE_EXISTENTE;
        end if;
        SELECT count(1) into v_encbod FROM GA_ABORENT WHERE NUM_SERIE = v_serie AND COD_SITUACION <> 'BAA';
        if v_encbod <> 0 then
            v_encbod := 5;
            RAISE SERIE_EXISTENTE;
        end if;
           SELECT count(1) into v_encbod FROM GA_ABOROAVIS WHERE NUM_SERIE = v_serie AND COD_SITUACION <> 'BAA';
        if v_encbod <> 0 then
            v_encbod := 6;
            RAISE SERIE_EXISTENTE;
        end if;
           SELECT count(1) into v_encbod FROM GA_LNCELU WHERE NUM_SERIE = v_serie;
        if v_encbod <> 0 then
            v_encbod := 7;
            RAISE SERIE_EXISTENTE;
        end if;
    elsif LENGTH(v_serie) = 14 then
        -- Beeper
        SELECT count(1) into v_encbod FROM GA_ABOBEEP WHERE NUM_SERIE = v_serie AND COD_SITUACION <> 'BAA';
        if v_encbod <> 0 then
            v_encbod := 8;
            RAISE SERIE_EXISTENTE;
        end if;
          SELECT count(1) into v_encbod FROM GA_LNBEEP WHERE NUM_SERIE = v_serie;
        if v_encbod <> 0 then
            v_encbod := 7;
            RAISE SERIE_EXISTENTE;
        end if;
    elsif LENGTH(v_serie) = 12 then
        -- Trek o Trunking
        SELECT count(1) into v_encbod FROM GA_ABOTREK WHERE NUM_SERIE = v_serie AND COD_SITUACION <> 'BAA';
        if v_encbod <> 0 then
            v_encbod := 9;
            RAISE SERIE_EXISTENTE;
        end if;
            SELECT count(1) into v_encbod FROM GA_LNTREK WHERE NUM_SERIE = v_serie;
        if v_encbod <> 0 then
            v_encbod := 7;
            RAISE SERIE_EXISTENTE;
        end if;
        SELECT count(1) into v_encbod FROM GA_ABOTRUNK WHERE NUM_SERIE = v_serie AND COD_SITUACION <> 'BAA';
        if v_encbod <> 0 then
            v_encbod := 10;
            RAISE SERIE_EXISTENTE;
        end if;
          SELECT count(1) into v_encbod FROM GA_LNTRUNK WHERE NUM_SERIE = v_serie;
        if v_encbod <> 0 then
            v_encbod := 7;
            RAISE SERIE_EXISTENTE;
        end if;
    end if;
   EXCEPTION
          when SERIE_EXISTENTE then
        if v_encbod = 1 then
            raise_application_error (-20141,'<ALM> Serie '|| v_serie ||' Existe en AL_SERIES.');
                                elsif v_encbod = 2 then
            raise_application_error (-20142,'<ALM> Serie '|| v_serie ||' Existe en Ordenes de Ingreso.');
        elsif v_encbod = 3 then
            raise_application_error (-20143,'<ALM> Serie '|| v_serie ||' Existe en GA_ABOAMIST.');
        elsif v_encbod = 4 then
            raise_application_error (-20144,'<ALM> Serie '|| v_serie ||' Existe en GA_ABOCEL.');
        elsif v_encbod = 5 then
            raise_application_error (-20145,'<ALM> Serie '|| v_serie ||' Existe en GA_ABORENT.');
        elsif v_encbod = 6 then
            raise_application_error (-20146,'<ALM> Serie '|| v_serie ||' Existe en GA_ABOROAVIS.');
        elsif v_encbod = 7 then
            raise_application_error (-20147,'<ALM> Serie '|| v_serie ||' Existe en GA_LNCELU.');
        elsif v_encbod = 8 then
            raise_application_error (-20148,'<ALM> Serie '|| v_serie ||' Existe en GA_ABOBEEP.');
        elsif v_encbod = 9 then
            raise_application_error (-20149,'<ALM> Serie '|| v_serie ||' Existe en GA_ABOTREK.');
        elsif v_encbod = 10 then
            raise_application_error (-20150,'<ALM> Serie '|| v_serie ||' Existe en GA_ABOTRUNK.');
        elsif v_encbod = 11 then
            raise_application_error (-20151,'<ALM> Serie '|| v_serie ||' Existe en GA_RESERVFOL.');
        elsif v_encbod = 12 then
            raise_application_error (-20152,'<ALM> Serie '|| v_serie ||' Existe en NPT_SERIE_PEDIDO');
        end if;
        when OTHERS then
         raise;
END p_al_compseries;
/
SHOW ERRORS