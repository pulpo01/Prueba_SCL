CREATE OR REPLACE PACKAGE BODY PV_IMPORTE_CAUSAGARANTIA_PG IS

PROCEDURE PV_IMPORTE_CAUSAGARANTIA_PR (TN_NumAbonado           IN    GA_ABOCEL.num_abonado%TYPE,
                                                             TV_NumSerie              IN    GA_ABOCEL.num_serie%TYPE,
                                                             TN_NumCargo              IN     GE_CARGOS.num_cargo%TYPE,
                                                      TN_IMPORTE              OUT    NOCOPY VARCHAR2,--GE_CARGOS.IMP_CARGO%TYPE,
                                                      TN_TIPDTO                  OUT    NOCOPY VARCHAR2,
                                                      TN_VALDTO                  OUT    NOCOPY VARCHAR2,
                                                      SV_CODERROR              OUT    NOCOPY VARCHAR2,
                                                      SV_MESERROR              OUT    NOCOPY VARCHAR2
                                                   )
--RETURN BOOLEAN
/*
<NOMBRE>        : PV_IMPORTE_CAUSAGARANTIA</NOMBRE>
<FECHACREA>        : 01-06-2005<FECHACREA/>
<MODULO >        : Posventa </MODULO >
<AUTOR >        : Patricio Gallegos C. </AUTOR >
<VERSION >        : 1.0</VERSION >
<DESCRIPCION>     : Devuelve el importe y descuento total, cuando se está realizando un cambio de serie con garantía  del
                proveedor y se necesita sumar el cargo por el equipo anterior al cargo por garantia </DESCRIPCION>
<FECHAMOD >        :  </FECHAMOD >
<DESCMOD >         :  </DESCMOD >
<ParamEntr>     : TN_NumAbonado,TV_NumSerie    ,TN_NumCargo </ParamEntr>
<ParamSal >     : TN_IMPORTE,TN_TIPDTO,TN_VALDTO , SV_CODERROR,SV_MESERROR</ParamEntr>
*/
IS

  GN_IMPORTE_EQ        GA_EQUIPABOSER.IMP_CARGO%TYPE;
  GV_TIPDTO_EQ        GA_EQUIPABOSER.TIP_DTO%TYPE;
  GN_VALDTO_EQ        GA_EQUIPABOSER.VAL_DTO%TYPE;

  GN_IMPORTE_CG        GE_CARGOS.IMP_CARGO%TYPE;
  GV_TIPDTO_CG        GE_CARGOS.TIP_DTO%TYPE;
  GN_VALDTO_CG        GE_CARGOS.VAL_DTO%TYPE;


BEGIN
        GN_IMPORTE_EQ:=NULL;
        GV_TIPDTO_EQ:=NULL;
        GN_VALDTO_EQ:=NULL;

        BEGIN
             SELECT imp_cargo,tip_dto,val_dto
            INTO   GN_IMPORTE_EQ,GV_TIPDTO_EQ,GN_VALDTO_EQ
            FROM ga_equipaboser
            WHERE num_abonado =  TN_NumAbonado
            AND num_serie = TV_NumSerie
            AND fec_alta = (SELECT MAX(fec_alta) FROM ga_equipaboser
                               WHERE num_abonado =  TN_NumAbonado
                            AND num_serie = TV_NumSerie);
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                   begin
                     SELECT imp_cargo,tip_dto,val_dto
                       INTO   GN_IMPORTE_EQ,GV_TIPDTO_EQ,GN_VALDTO_EQ
                       FROM ga_hequipaboser
                      WHERE num_abonado =  TN_NumAbonado
                        AND num_serie = TV_NumSerie
                        AND fec_alta = (SELECT MAX(fec_alta) FROM ga_hequipaboser
                                         WHERE num_abonado =  TN_NumAbonado
                                           AND num_serie = TV_NumSerie);
                   exception
                   when others then
                         TN_IMPORTE := NULL;
                         TN_TIPDTO  := NULL;
                         TN_VALDTO  := NULL;
                   end;

        END;

        IF TN_NumCargo>0 THEN
               --    TIP_DTO =1 PORCENTAJE
            -- TIP_DTO = 0 IMPORTE
          begin
            SELECT imp_cargo,tip_dto,val_dto
            INTO   GN_IMPORTE_CG,GV_TIPDTO_CG,  GN_VALDTO_CG
            FROM ge_cargos
            WHERE num_cargo = TN_NumCargo;

            IF GV_TIPDTO_CG IS NULL AND GV_TIPDTO_EQ IS NULL THEN
                   TN_IMPORTE := NVL(GN_IMPORTE_EQ,0) +  NVL(GN_IMPORTE_CG,0);
            ELSE
                IF GV_TIPDTO_EQ IS NULL OR GV_TIPDTO_EQ NOT IN (1,0) THEN
                   GN_VALDTO_EQ := 0;
                   GV_TIPDTO_EQ := 0;
                END IF;

                IF GV_TIPDTO_CG IS NULL OR GV_TIPDTO_CG NOT IN (1,0) THEN
                   GN_VALDTO_CG := 0;
                   GV_TIPDTO_CG := 0;
                END IF;

                IF GV_TIPDTO_EQ = 1 THEN -- Tipo descuento porcentaje
                   GN_VALDTO_EQ := (nvl(GN_IMPORTE_EQ,0)*nvl(GN_VALDTO_EQ,0))/100;
                END IF;

                IF GV_TIPDTO_CG = 1 THEN -- Tipo descuento porcentaje
                   GN_VALDTO_CG := (nvl(GN_IMPORTE_CG,0) * nvl(GN_VALDTO_CG,0))/100;
                END IF;

                TN_IMPORTE := NVL(GN_IMPORTE_EQ,0) + nvl(GN_IMPORTE_CG,0);
                TN_VALDTO :=  nvl(GN_VALDTO_EQ,0) + nvl(GN_VALDTO_CG,0);
                TN_TIPDTO := 0;
            END IF;

            exception
            when others then
                 TN_IMPORTE := NULL;
                 TN_TIPDTO  := NULL;
                 TN_VALDTO  := NULL;
            end;

        ELSE
          TN_IMPORTE := GN_IMPORTE_EQ;
          TN_TIPDTO  := GV_TIPDTO_EQ;
          TN_VALDTO  := GN_VALDTO_EQ;
        END IF;

        TN_IMPORTE := NVL(TN_IMPORTE,'');
        TN_TIPDTO  := NVL(TN_TIPDTO,'');
        TN_VALDTO  := NVL(TN_VALDTO,'');

        SV_CODERROR:='0';
        SV_MESERROR := 'OK';
EXCEPTION
          WHEN OTHERS THEN
                 SV_CODERROR:='4';
                  SV_MESERROR := SQLERRM;
END PV_IMPORTE_CAUSAGARANTIA_PR;

END PV_IMPORTE_CAUSAGARANTIA_PG;
/
SHOW ERRORS
