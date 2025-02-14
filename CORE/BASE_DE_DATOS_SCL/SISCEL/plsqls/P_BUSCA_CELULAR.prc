CREATE OR REPLACE PROCEDURE        P_BUSCA_CELULAR
  (V_TRANSACCION in varchar2,V_CELULAR in VARCHAR2) IS
V_ENCONTRO NUMBER(1);
VP_CELULAR GA_ABOCEL.NUM_CELULAR%TYPE;
VP_TRANSACCION GA_TRANSACABO.NUM_TRANSACCION%TYPE;
V_SERIE AL_SERIES.NUM_SERIE%TYPE;
V_FECRESER GA_RESNUMCEL.FEC_RESERVA%TYPE;
V_ESTADO NUMBER(1);
VP_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
DES_CADENA VARCHAR2(70);
Procedure Buscar_universo(VP_CELULAR in ga_abocel.num_celular%type,
V_ENCONTRO out number) is
v_siguiente ga_celnum_uso.num_siguiente%type;
v_libres ga_celnum_uso.num_libres%type;
Begin
  Select num_siguiente,num_libres
  Into v_siguiente,v_libres
  from ga_celnum_uso
  where VP_CELULAR between num_desde and num_hasta;
  if (v_libres >0) and (v_siguiente <= VP_CELULAR) then
     V_ENCONTRO:=1;
  else
     V_ENCONTRO:=0;
  end if;
Exception
 When no_data_found then
    -- no es numeracion Startel
    V_ENCONTRO:=2;
end;
Procedure Buscar_Abonado(VP_CELULAR in GA_ABOCEL.NUM_CELULAR%TYPE,
V_ENCONTRO OUT NUMBER) IS
V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
Begin
  Select num_abonado
  Into V_ABONADO
  From Ga_abocel
  Where num_celular =VP_CELULAR
  and cod_situacion not in('BAA','BAP')
  and rownum < 2;
  V_ENCONTRO:=1;
Exception
  When no_data_found then
    V_ENCONTRO:=0;
End;
Procedure Buscar_AboAmist(VP_CELULAR in GA_ABOAMIST.NUM_CELULAR%TYPE,
V_ENCONTRO OUT NUMBER) IS
V_ABONADO GA_ABOAMIST.NUM_ABONADO%TYPE;
Begin
  Select num_abonado
  Into V_ABONADO
  From Ga_aboamist
  Where num_celular =VP_CELULAR
  and cod_situacion not in('BAA','BAP')
  and rownum < 2;
  V_ENCONTRO:=1;
Exception
  When no_data_found then
    V_ENCONTRO:=0;
End;
Procedure Buscar_Reutil(VP_CELULAR in ga_abocel.num_celular%type,
V_ENCONTRO out number) is
FILA ROWID;
begin
  Select rowid
  Into FILA
  From GA_CELNUM_REUTIL
  Where NUM_CELULAR=VP_CELULAR;
  V_ENCONTRO:=1;
exception
 When no_data_found Then
   V_ENCONTRO:=0;
end;
Procedure Buscar_Series(VP_CELULAR IN GA_ABOCEL.NUM_CELULAR%TYPE,
V_ENCONTRO OUT NUMBER,
V_SERIE OUT AL_SERIES.NUM_SERIE%TYPE) is
Begin
   Select NUM_SERIE
   Into V_SERIE
   From al_series
   Where num_telefono=VP_CELULAR;
   V_ENCONTRO:=1;
Exception
  When no_data_found then
    V_ENCONTRo:=0;
end;
Procedure Buscar_Series_Activas(VP_CELULAR IN GA_ABOCEL.NUM_CELULAR%TYPE,
V_ENCONTRO OUT NUMBER,
V_SERIE OUT AL_SERIES.NUM_SERIE%TYPE) IS
Begin
  Select num_serie
  Into V_SERIE
  From AL_SERIES_ACTIVAS
  Where num_telefono=VP_CELULAR;
   V_ENCONTRO:=1;
exception
 When no_data_found then
   V_ENCONTRO:=0;
end;
Procedure Buscar_Fic_Series(VP_CELULAR IN GA_ABOCEL.NUM_CELULAR%type,
V_ENCONTRO OUT NUMBER,
V_SERIE OUT AL_SERIES.NUM_SERIE%TYPE) IS
Begin
  Select num_serie
  Into V_SERIE
  From al_fic_series
  Where num_telefono=VP_CELULAR;
  V_ENCONTRO:=1;
exception
  When no_data_found then
  v_ENCONTRO:=0;
end;
Procedure Buscar_Resnumcel(VP_CELULAR IN GA_ABOCEL.NUM_CELULAR%TYPE,
V_ENCONTRO OUT NUMBER,
V_FECRESER OUT GA_RESNUMCEL.FEC_RESERVA%TYPE) IS
Begin
    Select fec_reserva
    Into V_FECRESER
    From GA_RESNUMCEL
    Where NUM_CELULAR=VP_CELULAR;
    V_ENCONTRO:=1;
Exception
  When no_data_found then
    V_ENCONTRO:=0;
End;
Procedure Buscar_SerExtra(VP_CELULAR IN GA_ABOCEL.NUM_CELULAR%TYPE,
V_ENCONTRO OUT NUMBER,
V_SERIE OUT AL_SERIES.NUM_SERIE%TYPE) IS
vp_entsal al_cab_es_extras.ind_entsal%type := 'E';
vp_estado al_cab_es_extras.cod_estado%type := 'CE';
Begin
    Select b.num_serie
    Into V_SERIE
    From al_cab_es_extras a, al_ser_es_extras b
    Where a.num_extra=b.num_extra
    And b.num_telefono=VP_CELULAR
    And a.ind_entsal= vp_entsal
    And a.cod_estado<> vp_estado;
--  And a.ind_entsal='E'
--  And a.cod_estado<>'CE';
    V_ENCONTRO:=1;
Exception
  When no_data_found then
    V_ENCONTRO:=0;
End;
Procedure Buscar_Ordenes2(VP_CELULAR IN GA_ABOCEL.NUM_CELULAR%TYPE,
V_ENCONTRO OUT NUMBER,
V_SERIE OUT AL_SERIES.NUM_SERIE%TYPE) IS
vp_estado al_cabecera_ordenes2.cod_estado%type := 'CE';
Begin
    Select b.num_serie
    Into V_SERIE
    From al_cabecera_ordenes2 a, al_series_ordenes2 b
    Where a.num_orden=b.num_orden
    And a.cod_estado<> vp_estado
    And b.num_telefono=VP_CELULAR;
--  And a.cod_estado<>'CE'
    V_ENCONTRO:=1;
Exception
  When no_data_found then
    V_ENCONTRO:=0;
End;
Procedure Buscar_Ordenes3(VP_CELULAR IN GA_ABOCEL.NUM_CELULAR%TYPE,
V_ENCONTRO OUT NUMBER,
V_SERIE OUT AL_SERIES.NUM_SERIE%TYPE) IS
vp_estado al_cabecera_ordenes3.cod_estado%type := 'CE';
Begin
    Select b.num_serie
    Into V_SERIE
    From al_cabecera_ordenes3 a, al_series_ordenes3 b
    Where a.num_orden=b.num_orden
    And a.cod_estado<> vp_estado
    And b.num_telefono=VP_CELULAR;
--  And a.cod_estado<>'CE'
    V_ENCONTRO:=1;
Exception
  When no_data_found then
    V_ENCONTRO:=0;
End;
Procedure Buscar_Ord_Numeracion(VP_CELULAR IN GA_ABOCEL.NUM_CELULAR%TYPE,
V_ENCONTRO OUT NUMBER,
V_SERIE OUT AL_SERIES.NUM_SERIE%TYPE) IS
vp_estado al_cab_numeracion.cod_estado%type := 'CE';
vp_numeracion al_cab_numeracion.tip_numeracion%type := 0;
Begin
    Select b.num_serie
    Into V_SERIE
    From al_cab_numeracion a, al_ser_numeracion b
    Where a.num_numeracion=b.num_numeracion
    And a.cod_estado<>vp_estado
    And a.tip_numeracion > vp_numeracion
    And b.num_telefono=VP_CELULAR;
--  And a.cod_estado<>'CE'
--  And a.tip_numeracion > 0
    V_ENCONTRO:=1;
Exception
  When no_data_found then
    V_ENCONTRO:=0;
End;
BEGIN
  VP_CELULAR:=To_number(V_CELULAR);
  VP_TRANSACCION:=To_number(V_TRANSACCION);
  V_ENCONTRO:=0;
  V_ESTADO:=6;
  Buscar_universo(VP_CELULAR,V_ENCONTRO);
  IF V_ENCONTRO=1 THEN
    V_ESTADO:=1;
  ELSIF V_ENCONTRO=2 THEN
    V_ESTADO:=7;
  END IF;
  IF V_ESTADO != 7 THEN
    Buscar_Abonado(VP_CELULAR,V_ENCONTRO);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=3;
    END IF;
    Buscar_Aboamist(VP_CELULAR,V_ENCONTRO);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=3;
    END IF;
    Buscar_Reutil(VP_CELULAR,V_ENCONTRO);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=2;
    END IF;
    Buscar_Series(VP_CELULAR,V_ENCONTRO,V_SERIE);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=4;
      DES_CADENA:=V_SERIE;
    END IF;
    Buscar_Series_Activas(VP_CELULAR,V_ENCONTRO,V_SERIE);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=5;
      DES_CADENA:=V_SERIE;
    END IF;
    Buscar_Fic_Series(VP_CELULAR,V_ENCONTRO,V_SERIE);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=8;
      DES_CADENA:='08'||' '||V_SERIE;
    END IF;
    Buscar_Resnumcel(VP_CELULAR,V_ENCONTRO,V_FECRESER);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=9;
      DES_CADENA:=to_char(V_FECRESER,'dd-mm-yy hh24:mi:ss');
    END IF;
    Buscar_SerExtra(VP_CELULAR,V_ENCONTRO,V_SERIE);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=8;
      DES_CADENA:='10'||' '||V_SERIE;
    END IF;
    Buscar_Ordenes2(VP_CELULAR,V_ENCONTRO,V_SERIE);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=8;
      DES_CADENA:='11'||' '||V_SERIE;
    END IF;
    Buscar_Ordenes3(VP_CELULAR,V_ENCONTRO,V_SERIE);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=8;
      DES_CADENA:='12'||' '||V_SERIE;
    END IF;
    Buscar_Ord_Numeracion(VP_CELULAR,V_ENCONTRO,V_SERIE);
    IF V_ENCONTRO=1 THEN
      V_ESTADO:=8;
      DES_CADENA:='13'||' '||V_SERIE;
    END IF;
  END IF;
  INSERT INTO GA_TRANSACABO
  VALUES (VP_TRANSACCION,V_ESTADO,DES_CADENA);
  COMMIT;
Exception
   WHEN OTHERS THEN
     ROLLBACK;
     V_ESTADO := 10;
     DES_CADENA := 'Error al insertar TRANSACABO';
     INSERT INTO GA_TRANSACABO
     VALUES (VP_TRANSACCION,v_estado,des_cadena);
--   VALUES (VP_TRANSACCION,10,'Error al insertar TRANSACABO');
     COMMIT;
END;
/
SHOW ERRORS
