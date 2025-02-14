CREATE OR REPLACE PACKAGE BODY VE_Numeracion_Pg
AS

PROCEDURE VE_NUMERACION_AUTOMATICA_PR(
         EV_CeldNue IN GE_CELDAS.COD_CELDA%TYPE,
 EV_CentNue IN GA_CELNUM_REUTIL.COD_CENTRAL%TYPE,
 EV_CodUsoNue IN GA_CELNUM_REUTIL.COD_USO%TYPE,
 EV_Cod_Actabo     IN GA_ACTABO.COD_ACTABO%TYPE,
 SV_CodSubalmNue      OUT NOCOPY VARCHAR2,
 SV_NumCelular      OUT NOCOPY VARCHAR2,
 SV_Tabla      OUT NOCOPY VARCHAR2,
 SV_CodCatNue      OUT NOCOPY VARCHAR2,
 SV_FecBaja      OUT NOCOPY VARCHAR2,
 SN_COD_RETORNO OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
         SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO OUT NOCOPY GE_ERRORES_PG.EVENTO
 )
/*
<Documentación
 TipoDoc = "Procedimiento">
 <Elemento
 Nombre = "VE_NUMERACION_PR"
 Lenguaje="PL/SQL"
 Fecha="15-09-2008"
 Versión="1.0"
 Diseñador="**"
 Programador="**"
 Ambiente Desarrollo="BD">
 <Retorno>NA</Retorno>
 <Descripción> obtiene numeración automatica </Descripción>
 <Parámetros>
 <Entrada>
 </Entrada>
 <Salida>
 <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
 <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
 <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
 </Salida>
 </Parámetros>
 </Elemento>
</Documentación>
*/
AS PRAGMA AUTONOMOUS_TRANSACTION;

 LV_des_error ge_errores_pg.desevent;
 LV_sSql ge_errores_pg.vQuery;
 ERROR_CONTROLADO EXCEPTION;
 LV_COD_RETORNO VARCHAR2(200);
 LV_NUM_EVENTO VARCHAR2(200);


BEGIN
 SN_cod_retorno := 0;
 SV_mens_retorno := '';
 SN_num_evento := 0;
 LV_COD_RETORNO:='';
 LV_NUM_EVENTO:='';

     LV_sSql := 'VE_CamNum_PG.VE_CNUM_CELNUM_AUTO_ADO ('
     || EV_CeldNue
     ||', ' || EV_CentNue
     ||', ' || EV_CodUsoNue
     ||', ' || EV_Cod_Actabo
     ||', ' || SV_CodSubalmNue
     ||', ' || SV_NumCelular
     ||', ' || SV_Tabla
     ||', ' || SV_CodCatNue
     ||', ' || SV_FecBaja
     ||', ' || LV_COD_RETORNO
     ||', ' || SV_MENS_RETORNO
     ||', ' || LV_NUM_EVENTO
     || ' )';


     PV_CamNum_PG.PV_CNUM_CELNUM_AUTO_ADO (
     EV_CeldNue
     , EV_CentNue
     , EV_CodUsoNue
     , EV_Cod_Actabo
     , SV_CodSubalmNue
     , SV_NumCelular
     , SV_Tabla
     , SV_CodCatNue
     , SV_FecBaja
     , LV_COD_RETORNO
     , SV_MENS_RETORNO
     , LV_NUM_EVENTO);


 --IF SV_FecBaja IS NOT NULL THEN
 -- SELECT TO_CHAR(TO_DATE(SV_FecBaja,'DD-MM-YYYY'))
 -- INTO SV_FecBaja
 -- FROM DUAL;
 --END IF;




 IF LV_COD_RETORNO <> '0' THEN
 SN_COD_RETORNO:=TO_NUMBER(LV_COD_RETORNO);
 RAISE ERROR_CONTROLADO;
 END IF;

EXCEPTION
 WHEN ERROR_CONTROLADO THEN
 SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := gv_error_no_clasif;
 END IF;
 LV_des_error := SUBSTR('SISCEL.VE_NUMERACION_PG.VE_NUMERACION_AUTOMATICA_PR( SC_BLOQ_CAUSAS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_AUTOMATICA_PR', LV_sSql, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
 SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_AUTOMATICA_PR( SC_BLOQ_CAUSAS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_AUTOMATICA_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_AUTOMATICA_PR( SC_BLOQ_CAUSAS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_AUTOMATICA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END VE_NUMERACION_AUTOMATICA_PR;
------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_NUMERACION_DISPONIBLE_PR(
          EV_COD_CAT        IN VARCHAR2,
          EV_COD_USO        IN GA_CELNUM_REUTIL.COD_USO%TYPE,
          EV_CENTRAL        IN GA_CELNUM_REUTIL.COD_CENTRAL%TYPE,
          EV_COD_SUBALM     IN GA_CELNUM_REUTIL.COD_SUBALM%TYPE,
          EV_LIMITE_INF        IN GA_CELNUM_REUTIL.NUM_CELULAR%TYPE,
          EV_LIMITE_MAX        IN GA_CELNUM_REUTIL.NUM_CELULAR%TYPE,
          EN_CANT_NUM_CEL   IN  NUMBER,
          SC_BLOQ_NUMEROS   OUT NOCOPY REFCURSOR,
          SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO   OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO     OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_NUMERACION_DISPONIBLE_PR"
      Lenguaje="PL/SQL"
      Fecha="15-09-2008"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  obtiene numeración disponible </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
  CV_NOM_PARAM            CONSTANT GED_PARAMETROS.NOM_PARAMETRO%TYPE:='USO_SIN_USO';
  CN_IND_EQUIPADO        CONSTANT GA_CELNUM_REUTIL.IND_EQUIPADO%TYPE:=1;

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;

BEGIN

     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

     LV_sSql := 'SELECT A.NUM_CELULAR,A.COD_CAT,TO_CHAR((TO_DATE(A.FEC_BAJA,''DD-MM-YYYY'')))'
     || ' FROM GA_CELNUM_REUTIL A, AL_USOS B'
      || ' WHERE A.COD_SUBALM = '|| EV_COD_SUBALM
      || ' AND A.COD_PRODUCTO = '|| GN_COD_PRODUCTO
      || ' AND A.COD_CENTRAL  = '|| EV_CENTRAL
      || ' AND A.COD_CAT      in (' || EV_COD_CAT || ')';

     IF EV_COD_USO IS NOT NULL THEN
          LV_sSql := LV_sSql || ' AND (A.USO_ANTERIOR = '|| EV_COD_USO
         || ' OR USO_ANTERIOR = (SELECT VAL_PARAMETRO'
         || ' FROM GED_PARAMETROS'
         || ' WHERE NOM_PARAMETRO =''' || CV_NOM_PARAM ||''''
         || ' AND COD_MODULO = '''|| GV_COD_MODULO_GE ||''''
         || ' AND COD_PRODUCTO = '|| GN_COD_PRODUCTO || '))' ;
     END IF;
    LV_sSql := LV_sSql
     || ' AND A.FEC_BAJA + B.NUM_DIAS_HIBERNACION <= SYSDATE'
     || ' AND A.IND_EQUIPADO = '|| CN_IND_EQUIPADO
     || ' AND A.COD_USO = B.COD_USO'
     || ' AND A.NUM_CELULAR <= '|| EV_LIMITE_MAX
     || ' AND A.NUM_CELULAR >= '|| EV_LIMITE_INF
    || ' AND ROWNUM < ' || EN_CANT_NUM_CEL
        || ' ORDER BY A.NUM_CELULAR ASC';

    OPEN SC_BLOQ_NUMEROS FOR LV_sSql;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_DISPONIBLE_PR( ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_DISPONIBLE_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_DISPONIBLE_PR( ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_DISPONIBLE_PR', LV_sSql, SN_cod_retorno, LV_des_error );


END VE_NUMERACION_DISPONIBLE_PR;

--------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_NUMERACION_RANGO_PR(
          EV_COD_CAT        IN VARCHAR2,
          EV_COD_USO        IN GA_CELNUM_USO.COD_USO%TYPE,
          EV_CENTRAL        IN GA_CELNUM_USO.COD_CENTRAL%TYPE,
          EV_COD_SUBALM     IN GA_CELNUM_USO.COD_SUBALM%TYPE,
          EV_LIMITE_INF        IN GA_CELNUM_REUTIL.NUM_CELULAR%TYPE,
          EV_LIMITE_MAX        IN GA_CELNUM_REUTIL.NUM_CELULAR%TYPE,
          EN_CANT_NUM_CEL   IN  NUMBER,
          SC_BLOQ_NUMEROS   OUT NOCOPY REFCURSOR,
          SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO   OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO     OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_NUMERACION_RANGO_PR"
      Lenguaje="PL/SQL"
      Fecha="15-09-2008"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  obtiene numeración por rango </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;

BEGIN
         SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

     LV_sSql := 'SELECT A.NUM_SIGUIENTE, A.NUM_HASTA,A.COD_CAT'
     || ' FROM GA_CELNUM_USO A'
      || ' WHERE A.COD_SUBALM = ' || EV_COD_SUBALM
      || ' AND A.COD_PRODUCTO = ' || GN_COD_PRODUCTO
      || ' AND A.COD_CENTRAL = ' || EV_CENTRAL
      || ' AND A.COD_CAT in (' || EV_COD_CAT || ')';

     IF EV_COD_USO IS NOT NULL THEN
           LV_sSql := LV_sSql || ' AND A.COD_USO = ' || EV_COD_USO ;
     END IF;

      LV_sSql := LV_sSql || ' AND A.NUM_LIBRES > 0'
      || ' AND A.NUM_SIGUIENTE BETWEEN '|| EV_LIMITE_INF || ' AND ' || EV_LIMITE_MAX
     || ' AND ROWNUM < ' || EN_CANT_NUM_CEL
      || ' ORDER BY A.NUM_SIGUIENTE ASC';

     OPEN SC_BLOQ_NUMEROS FOR LV_sSql;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             NULL;
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR( ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR', LV_sSql, SN_cod_retorno, LV_des_error );


END VE_NUMERACION_RANGO_PR;

--------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_NUMERACION_RESERVA_PR(
          EV_COD_CLIENTE        IN GA_RESERVA.COD_CLIENTE%TYPE,
          EV_COD_VENDEDOR        IN GA_RESERVA.COD_VENDEDOR%TYPE,
          EV_COD_USOLINEA       IN GA_RESERVA.COD_USO%TYPE,
          EV_COD_CAT            IN  VARCHAR2,
          EN_CANT_NUM_CEL       IN  NUMBER,
          EN_COD_VENDEALER      IN  VE_VENDEALER.COD_VENDEALER%TYPE,
          EN_COD_CENTRAL        IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
          SC_BLOQ_NUMEROS         OUT NOCOPY REFCURSOR,
          SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_NUMERACION_RESERVA_PR"
      Lenguaje="PL/SQL"
      Fecha="15-09-2008"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  RESERVA DE NUMERO </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;
  LV_Tecnologia         AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE;

BEGIN

     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

    SELECT COD_TECNOLOGIA
    INTO LV_Tecnologia
    FROM ICG_CENTRAL
    WHERE COD_CENTRAL =EN_COD_CENTRAL;

    LV_sSql := 'SELECT A.NUM_CELULAR,COD_CAT'
    || ' FROM GA_RESERVA A'
    || ' WHERE (A.COD_CLIENTE =' || EV_COD_CLIENTE ||'OR (A.COD_VENDEDOR =' || EV_COD_VENDEDOR     ||'AND A.COD_CLIENTE IS NULL))';
    
    IF EV_COD_USOLINEA IS NOT NULL THEN
        LV_sSql := LV_sSql || ' AND A.COD_USO ='|| EV_COD_USOLINEA;
    END IF;
    
    IF EV_COD_CAT IS NOT NULL THEN
        LV_sSql := LV_sSql ||  ' AND A.COD_CAT in (' || EV_COD_CAT || ')';
    END IF;
    
    IF EN_COD_VENDEALER <> 0 THEN
        LV_sSql := LV_sSql ||  ' AND A.COD_VENDEALER =' || EN_COD_VENDEALER ;
    END IF;
    
    LV_sSql := LV_sSql ||  ' AND A.COD_CENTRAL =' || EN_COD_CENTRAL;    
    LV_sSql := LV_sSql || ' AND ROWNUM < ' || EN_CANT_NUM_CEL;
    LV_sSql := LV_sSql || ' ORDER BY A.NUM_CELULAR ASC';
    
    OPEN SC_BLOQ_NUMEROS FOR LV_sSql;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_RESERVA_PR' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_RESERVA_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_RESERVA_PR( ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_RESERVA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END VE_NUMERACION_RESERVA_PR;

PROCEDURE VE_BUSCA_SUBALM_PR(
          EV_COD_CELDA        IN GE_CELDAS.COD_CELDA%TYPE,
          SV_COD_SUBALM        OUT NOCOPY GE_CELDAS.COD_SUBALM%TYPE,
          SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO   OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO     OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_NUMERACION_RANGO_PR"
      Lenguaje="PL/SQL"
      Fecha="15-09-2008"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  obtiene numeración por rango </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

     SELECT COD_SUBALM
     INTO SV_COD_SUBALM
     FROM GE_CELDAS
     WHERE COD_CELDA=EV_COD_CELDA;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR( ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR( ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR', LV_sSql, SN_cod_retorno, LV_des_error );


END VE_BUSCA_SUBALM_PR;

--------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_BUSCA_CENTAL_PR(
          EV_COD_CENTRAL    IN ICG_CENTRAL.COD_CENTRAL%TYPE,
          SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO   OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO     OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_NUMERACION_RANGO_PR"
      Lenguaje="PL/SQL"
      Fecha="15-09-2008"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  obtiene numeración por rango </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;
  LV_CENTRAL            ICG_CENTRAL.COD_CENTRAL%TYPE;

BEGIN

    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

     SELECT COD_CENTRAL
     INTO LV_CENTRAL
     FROM ICG_CENTRAL
     WHERE COD_CENTRAL=EV_COD_CENTRAL;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR( ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR( ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR', LV_sSql, SN_cod_retorno, LV_des_error );


END VE_BUSCA_CENTAL_PR;


--------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_CONS_NUM_CEL_REUTIL_PR(
          EN_NUM_CELULAR        IN GA_CELNUM_REUTIL.NUM_CELULAR%TYPE,
            SV_COD_SUBALM         OUT GA_CELNUM_REUTIL.COD_SUBALM%TYPE,
            SN_COD_PRODUCTO       OUT GA_CELNUM_REUTIL.COD_PRODUCTO%TYPE,
            SN_COD_CENTRAL        OUT GA_CELNUM_REUTIL.COD_CENTRAL%TYPE,
            SN_COD_CAT            OUT GA_CELNUM_REUTIL.COD_CAT%TYPE,
            SN_COD_USO            OUT GA_CELNUM_REUTIL.COD_USO%TYPE,
            SN_IND_EQUIPADO       OUT GA_CELNUM_REUTIL.IND_EQUIPADO%TYPE,
            SN_USO_ANTERIOR       OUT GA_CELNUM_REUTIL.USO_ANTERIOR%TYPE,
            SN_COD_RETORNO           OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO          OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO            OUT NOCOPY GE_ERRORES_PG.EVENTO

  )

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = " VE_CONS_NUM_CEL_REUTIL_PR "
      Lenguaje="PL/SQL"
      Fecha=" 08-10-2008 "
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>   </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;

BEGIN

     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

 LV_sSql :='SELECT COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, IND_EQUIPADO, USO_ANTERIOR, IND_ENVIO_CENTRAL '||
 ' FROM GA_CELNUM_REUTIL WHERE NUM_CELULAR='||EN_NUM_CELULAR;

         SELECT COD_SUBALM
         , COD_PRODUCTO
         , COD_CENTRAL
         , COD_CAT
         , COD_USO
         , IND_EQUIPADO
         , USO_ANTERIOR
         INTO SV_COD_SUBALM
         ,SN_COD_PRODUCTO
         ,SN_COD_CENTRAL
         ,SN_COD_CAT
         ,SN_COD_USO
         ,SN_IND_EQUIPADO
         ,SN_USO_ANTERIOR
         FROM GA_CELNUM_REUTIL
         WHERE NUM_CELULAR = EN_NUM_CELULAR;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_CONS_NUM_CEL_REUTIL_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_CONS_NUM_CEL_REUTIL_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_CONS_NUM_CEL_REUTIL_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_CONS_NUM_CEL_REUTIL_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END VE_CONS_NUM_CEL_REUTIL_PR;

--------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_CONS_NUM_CEL_RESERVADO_PR(
          EN_NUM_CELULAR        IN GA_RESNUMCEL.NUM_CELULAR%TYPE,
            SV_COD_SUBALM         OUT GA_RESNUMCEL.COD_SUBALM%TYPE,
            SN_COD_PRODUCTO       OUT GA_RESNUMCEL.COD_PRODUCTO%TYPE,
            SN_COD_CENTRAL        OUT GA_RESNUMCEL.COD_CENTRAL%TYPE,
            SN_COD_CAT            OUT GA_RESNUMCEL.COD_CAT%TYPE,
            SN_COD_USO            OUT GA_RESNUMCEL.COD_USO%TYPE,
          SV_IND_PROCNUM         OUT GA_RESNUMCEL.IND_PROCNUM%TYPE,
          SN_COD_RETORNO           OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO          OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO            OUT NOCOPY GE_ERRORES_PG.EVENTO

  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = " VE_CONS_NUM_CEL_RESERVADO_PR "
      Lenguaje="PL/SQL"
      Fecha=" 08-10-2008 "
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>   </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;

BEGIN

     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

LV_sSql :='SELECT COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, IND_PROCNUM '||
 ' FROM GA_RESNUMCEL WHERE NUM_CELULAR='||EN_NUM_CELULAR;


 SELECT COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, IND_PROCNUM
 INTO SV_COD_SUBALM,SN_COD_PRODUCTO,SN_COD_CENTRAL,SN_COD_CAT,SN_COD_USO, SV_IND_PROCNUM
 FROM GA_RESNUMCEL WHERE NUM_CELULAR=EN_NUM_CELULAR;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_CONS_NUM_CEL_RESERVADO_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_CONS_NUM_CEL_RESERVADO_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_CONS_NUM_CEL_RESERVADO_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_CONS_NUM_CEL_RESERVADO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END VE_CONS_NUM_CEL_RESERVADO_PR;

--------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_CONS_NUM_CEL_GA_HRESERVA_PR (
          EN_NUM_CELULAR        IN GA_HRESERVA.NUM_CELULAR%TYPE,
          SN_NUM_CELULAR        OUT GA_HRESERVA.NUM_CELULAR%TYPE,
          SN_COD_RETORNO           OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO          OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO            OUT NOCOPY GE_ERRORES_PG.EVENTO

  )
 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = " VE_CONS_NUM_CEL_GA_HRESERVA_PR "
      Lenguaje="PL/SQL"
      Fecha=" 08-10-2008 "
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>   </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;

BEGIN

     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

LV_sSql :='SELECT NUM_CELULAR FROM GA_HRESERVA WHERE NUM_CELULAR='||EN_NUM_CELULAR;

SELECT NUM_CELULAR INTO SN_NUM_CELULAR FROM GA_HRESERVA WHERE NUM_CELULAR=EN_NUM_CELULAR;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_CONS_NUM_CEL_GA_HRESERVA_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_CONS_NUM_CEL_GA_HRESERVA_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_CONS_NUM_CEL_GA_HRESERVA_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_CONS_NUM_CEL_GA_HRESERVA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END VE_CONS_NUM_CEL_GA_HRESERVA_PR;

--------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_DEL_NUM_CEL_RESERVADO_PR (
          EN_NUM_CELULAR        IN GA_RESNUMCEL.NUM_CELULAR%TYPE,
          SN_COD_RETORNO           OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO          OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO            OUT NOCOPY GE_ERRORES_PG.EVENTO

  )
  /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = " VE_DEL_NUM_CEL_RESERVADO_PR "
      Lenguaje="PL/SQL"
      Fecha=" 08-10-2008 "
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>   </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

 LV_sSql := 'DELETE GA_RESNUMCEL WHERE NUM_CELULAR = ' || EN_NUM_CELULAR;

 DELETE GA_RESNUMCEL WHERE NUM_CELULAR = EN_NUM_CELULAR;

EXCEPTION

        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_DEL_NUM_CEL_RESERVADO_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_DEL_NUM_CEL_RESERVADO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END VE_DEL_NUM_CEL_RESERVADO_PR;

--------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_INS_NUM_CEL_RESERVADO_PR(
          EN_NUM_TRANSACCION     IN GA_RESNUMCEL.NUM_TRANSACCION%TYPE,
          EN_NUM_LINEA             IN GA_RESNUMCEL.NUM_LINEA%TYPE,
          EN_NUM_ORDEN             IN GA_RESNUMCEL.NUM_ORDEN%TYPE,
          EN_NUM_CELULAR        IN GA_RESNUMCEL.NUM_CELULAR%TYPE,
            EV_COD_SUBALM         IN GA_RESNUMCEL.COD_SUBALM%TYPE,
            EN_COD_PRODUCTO       IN GA_RESNUMCEL.COD_PRODUCTO%TYPE,
            EN_COD_CENTRAL        IN GA_RESNUMCEL.COD_CENTRAL%TYPE,
            EN_COD_CAT            IN GA_RESNUMCEL.COD_CAT%TYPE,
            EN_COD_USO            IN GA_RESNUMCEL.COD_USO%TYPE,
          EV_NOM_USUARIO         IN GA_RESNUMCEL.NOM_USUARIO%TYPE,
          EV_IND_PROCNUM         IN GA_RESNUMCEL.IND_PROCNUM%TYPE,
          EV_FEC_BAJA           IN VARCHAR2,
          SN_COD_RETORNO           OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO          OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO            OUT NOCOPY GE_ERRORES_PG.EVENTO
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = " VE_INS_NUM_CEL_RESERVADO_PR "
      Lenguaje="PL/SQL"
      Fecha=" 08-10-2008 "
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>   </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS
ERROR_EJECUCION               EXCEPTION;
  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;
  LD_FEC_BAJA           GA_CELNUM_REUTIL.FEC_BAJA%TYPE;

BEGIN
SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;


LV_sSql := 'INSERT INTO GA_RESNUMCEL ( NUM_TRANSACCION, NUM_LINEA, NUM_ORDEN, NUM_CELULAR, COD_SUBALM,' ||
' COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, FEC_RESERVA, NOM_USUARIO, IND_PROCNUM,FEC_BAJA )' ||
' VALUES ( ' || EN_NUM_TRANSACCION || ',' || EN_NUM_LINEA || ',' || EN_NUM_ORDEN || ',' || EN_NUM_CELULAR || ',' || EV_COD_SUBALM || ',' ||
EN_COD_PRODUCTO || ',' || EN_COD_CENTRAL || ',' || EN_COD_CAT || ',' || EN_COD_USO || ',' || SYSDATE || ',' || EV_NOM_USUARIO || ',' || EV_IND_PROCNUM || ',' || EV_FEC_BAJA||')';

INSERT INTO GA_RESNUMCEL ( NUM_TRANSACCION, NUM_LINEA, NUM_ORDEN, NUM_CELULAR, COD_SUBALM,
COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, FEC_RESERVA, NOM_USUARIO, IND_PROCNUM,
FEC_BAJA ) VALUES ( EN_NUM_TRANSACCION,EN_NUM_LINEA,EN_NUM_ORDEN,EN_NUM_CELULAR,EV_COD_SUBALM,
EN_COD_PRODUCTO, EN_COD_CENTRAL, EN_COD_CAT, EN_COD_USO, SYSDATE, EV_NOM_USUARIO,EV_IND_PROCNUM,TO_CHAR(TO_DATE(EV_FEC_BAJA,'DD-MM-YYYY')));

EXCEPTION

  WHEN ERROR_EJECUCION THEN
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1, USER, 'VE_NUMERACION_PG.VE_INS_NUM_CEL_RESERVADO_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_COD_RETORNO := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                    SV_MENS_RETORNO := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_INS_NUM_CEL_RESERVADO_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,gn_largodesc);
             SN_NUM_EVENTO := Ge_Errores_Pg.Grabarpl( SN_NUM_EVENTO, GV_cod_modulo,SV_MENS_RETORNO, '1.0', USER, 'VE_NUMERACION_PG.VE_INS_NUM_CEL_RESERVADO_PR', LV_sSql, SN_COD_RETORNO, LV_des_error );


END VE_INS_NUM_CEL_RESERVADO_PR;
--------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_CONS_GA_TRANSACABO_PR(
     EN_NUM_TRANSACCION                 IN    GA_TRANSACABO.NUM_TRANSACCION%TYPE,
     SN_COD_RETORNO_TRANS  OUT NOCOPY GA_TRANSACABO.COD_RETORNO%TYPE,
     SV_DES_CADENA_TRANS      OUT NOCOPY  GA_TRANSACABO.DES_CADENA%TYPE,
      SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )

 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_CONS_GA_TRANSACABO_PR"
      Lenguaje="PL/SQL"
      Fecha="08-07-2008"
      Versión="1.0"
      Diseñador="Alejandro Díaz C
      Programador="Alejandro Díaz C
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  consultar los datos para la grilla del front end </Descripción>
      <Parámetros>
         <Entrada>
          <param nom=</param>
            <<param nom=" EN_NUM_TRANSACCION    Tipo="nUMBER>NUMERO DE TRANSACCION</param>
         </Entrada>
         <Salida>
            <param nom="SN_COD_RETORNO_TRANS   Tipo="Number">Codigo de Retorno</param>
           <param nom="SV_DES_CADENA_TRANS  Tipo="Varchar2"">DESCRIPCION DE ERROR Tributaria</param>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
           <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;
BEGIN
     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

            LV_sSql:= ' SELECT COD_RETORNO, DES_CADENA'||
                             ' FROM GA_TRANSACABO'||
                           ' WHERE NUM_TRANSACCION ='|| EN_NUM_TRANSACCION;

SELECT COD_RETORNO, DES_CADENA
INTO SN_COD_RETORNO_TRANS, SV_DES_CADENA_TRANS
 FROM GA_TRANSACABO
 WHERE NUM_TRANSACCION = EN_NUM_TRANSACCION ;


             SN_cod_retorno := 0;
             SV_mens_retorno := 'OK';
             SN_num_evento := 0;

EXCEPTION
                WHEN OTHERS THEN
                     SN_cod_retorno := GV_error_others;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('VE_CONS_GA_TRANSACABO_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_BAJA_PUNTUAL_PREPAGO_PG.VE_CONS_GA_TRANSACABO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END  VE_CONS_GA_TRANSACABO_PR;

--------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_P_REPONER_NUMERACION_PR(
           EV_TABLA IN VARCHAR2 ,
           EV_SUBALM IN VARCHAR2 ,
           EV_CENTRAL IN VARCHAR2 ,
           EV_CAT IN VARCHAR2 ,
           EV_USO IN VARCHAR2 ,
           EV_CELULAR IN VARCHAR2 ,
           SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
           SV_MENS_RETORNO   OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
           SN_NUM_EVENTO     OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_NUMERACION_PR"
      Lenguaje="PL/SQL"
      Fecha="15-09-2008"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  Repone Numeración </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS PRAGMA AUTONOMOUS_TRANSACTION;

  ERROR_EJECUCION               EXCEPTION;
  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;
  V_USO_ORIG   NUMBER;
  V_FEC_BAJA   GA_RESNUMCEL.FEC_BAJA%TYPE;
  V_DIAS_HIBER AL_USOS.NUM_DIAS_HIBERNACION%TYPE;
BEGIN

     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

      IF EV_TABLA = 'S' THEN
          DECLARE
                 R_ga_hreserva ga_hreserva%ROWTYPE;
                 BEGIN
                      SELECT * INTO R_ga_hreserva
                      FROM GA_HRESERVA
                      WHERE NUM_CELULAR  = EV_CELULAR
                      FOR UPDATE OF NUM_CELULAR NOWAIT;

                      INSERT INTO GA_RESERVA (COD_CLIENTE, COD_VENDEDOR, ORIGEN, FEC_RESERVA, NUM_CELULAR,
                      COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR,COD_VENDEALER)
                      VALUES ( R_ga_hreserva.COD_CLIENTE, R_ga_hreserva.COD_VENDEDOR, R_ga_hreserva.ORIGEN, R_ga_hreserva.FEC_RESERVA
                     , R_ga_hreserva.NUM_CELULAR, R_ga_hreserva.COD_SUBALM, R_ga_hreserva.COD_PRODUCTO, R_ga_hreserva.COD_CENTRAL
                     , R_ga_hreserva.COD_CAT, R_ga_hreserva.COD_USO, R_ga_hreserva.FEC_BAJA,R_ga_hreserva.IND_EQUIPADO
                     , R_ga_hreserva.USO_ANTERIOR,R_ga_hreserva.COD_VENDEALER);

                      DELETE GA_HRESERVA WHERE NUM_CELULAR  = EV_CELULAR;
                 END;

      ELSE
                 BEGIN

                 SELECT NUM_DIAS_HIBERNACION
                 INTO V_DIAS_HIBER
                 FROM AL_USOS
                 WHERE COD_USO=EV_USO;

                 SELECT FEC_BAJA
                 INTO V_FEC_BAJA
                 FROM GA_RESNUMCEL
                 WHERE NUM_CELULAR=EV_CELULAR;

                 IF V_FEC_BAJA IS NULL THEN
                    V_FEC_BAJA:= SYSDATE - V_DIAS_HIBER;
                 END IF;



                 EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                      V_FEC_BAJA:= SYSDATE - V_DIAS_HIBER;
                 END;

                 INSERT INTO GA_CELNUM_REUTIL
                 (NUM_CELULAR,COD_SUBALM,COD_PRODUCTO,COD_CENTRAL,COD_CAT,COD_USO,
                  FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR)
                  VALUES (EV_CELULAR,EV_SUBALM,1,EV_CENTRAL,EV_CAT,EV_USO,V_FEC_BAJA,1, EV_USO);
      END IF;

      --Eliminamos los Rangos asociados al Numero fijo

      UPDATE GA_RANGOS_FIJOS_TO
      SET ESTADO=1
      WHERE
      NUM_DESDE IN
      (SELECT NUM_DESDE
      FROM GA_NRO_PILOTO_RANGO_TO
      WHERE NUM_PILOTO= EV_CELULAR );

      DELETE FROM
      GA_NRO_PILOTO_RANGO_TO
      WHERE NUM_PILOTO= EV_CELULAR;

      DELETE FROM GA_RESNUMCEL
      WHERE NUM_CELULAR=EV_CELULAR;

      COMMIT;

EXCEPTION
        WHEN ERROR_EJECUCION THEN
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1, USER, 'VE_NUMERACION_PG.VE_P_REPONER_NUMERACION_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_COD_RETORNO := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                    SV_MENS_RETORNO := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_P_REPONER_NUMERACION_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,gn_largodesc);
             SN_NUM_EVENTO := Ge_Errores_Pg.Grabarpl( SN_NUM_EVENTO, GV_cod_modulo,SV_MENS_RETORNO, '1.0', USER, 'VE_NUMERACION_PG.VE_P_REPONER_NUMERACION_PR', LV_sSql, SN_COD_RETORNO, LV_des_error );

END VE_P_REPONER_NUMERACION_PR;
--------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_P_NUMERACION_MANUAL_PR(
           EV_TRANSAC IN VARCHAR2 ,
           EV_TABLA IN VARCHAR2 ,
           EV_SUBALM IN VARCHAR2 ,
           EV_CENTRAL IN VARCHAR2 ,
           EV_CAT IN VARCHAR2 ,
           EV_USO IN VARCHAR2 ,
           EV_CELULAR IN VARCHAR2 ,
           SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
           SV_MENS_RETORNO   OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
           SN_NUM_EVENTO     OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_NUMERACION_PR"
      Lenguaje="PL/SQL"
      Fecha="15-09-2008"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  Repone Numeración </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
  ERROR_EJECUCION               EXCEPTION;
  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;
  V_ERROR CHAR(1) := '0';
   V_NUM_DES GA_CELNUM_USO.NUM_DESDE%TYPE;
   V_NUM_HAS GA_CELNUM_USO.NUM_HASTA%TYPE;
   V_NUM_SIG GA_CELNUM_USO.NUM_SIGUIENTE%TYPE;
   V_ROWID ROWID;
   V_FECBAJA GA_CELNUM_REUTIL.FEC_BAJA%TYPE;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE;
   V_FORMAT_FECHA  GA_TRANSACABO.DES_CADENA%TYPE;
BEGIN
     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;


     -- bug

      IF EV_TABLA = 'R' THEN

            SELECT A.ROWID ,FEC_BAJA
            INTO V_ROWID,V_FECBAJA
            FROM GA_CELNUM_REUTIL A, AL_USOS B
            WHERE NUM_CELULAR   = EV_CELULAR
               AND COD_SUBALM   = EV_SUBALM
               AND COD_CENTRAL  = EV_CENTRAL
               AND COD_CAT      = EV_CAT
               AND USO_ANTERIOR = EV_USO
           AND A.COD_USO    = B.COD_USO
               AND IND_EQUIPADO = 1
               AND FEC_BAJA + B.NUM_DIAS_HIBERNACION <= SYSDATE
               FOR UPDATE OF NUM_CELULAR NOWAIT;
           DELETE GA_CELNUM_REUTIL WHERE ROWID = V_ROWID;

   ELSIF EV_TABLA = 'S' THEN

            SELECT ROWID,FEC_BAJA
              INTO V_ROWID,V_FECBAJA
              FROM GA_RESERVA
             WHERE NUM_CELULAR  = EV_CELULAR
               AND COD_USO      = EV_USO
               FOR UPDATE OF NUM_CELULAR NOWAIT;

               INSERT INTO GA_HRESERVA (COD_CLIENTE, COD_VENDEDOR, ORIGEN, FEC_RESERVA, NUM_CELULAR,
               COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR,
               FECHA_DESRESERVA, CAUSAL_DESRESERVA, NOM_USUARORA,COD_VENDEALER)
               SELECT COD_CLIENTE, COD_VENDEDOR, ORIGEN, FEC_RESERVA, NUM_CELULAR, COD_SUBALM, COD_PRODUCTO,
               COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR, SYSDATE, 1,USER,COD_VENDEALER
               FROM GA_RESERVA
               WHERE ROWID = V_ROWID;

               DELETE GA_RESERVA WHERE ROWID = V_ROWID;

   ELSE

         SELECT NUM_DESDE,NUM_HASTA,NUM_SIGUIENTE,ROWID
           INTO V_NUM_DES,V_NUM_HAS,V_NUM_SIG,V_ROWID
           FROM GA_CELNUM_USO
          WHERE COD_SUBALM  = EV_SUBALM
            AND COD_CENTRAL = EV_CENTRAL
            AND COD_CAT     = EV_CAT
            AND COD_USO     = EV_USO
            AND NUM_LIBRES  > 0
            AND EV_CELULAR BETWEEN NUM_SIGUIENTE AND NUM_HASTA
            FOR UPDATE OF NUM_SIGUIENTE NOWAIT;


         IF EV_CELULAR = V_NUM_SIG THEN
            IF EV_CELULAR = V_NUM_HAS THEN
               UPDATE GA_CELNUM_USO
                  SET NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            ELSE
               UPDATE GA_CELNUM_USO
                  SET NUM_SIGUIENTE = NUM_SIGUIENTE + 1,
                      NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            END IF;
         ELSIF EV_CELULAR = V_NUM_HAS THEN
            UPDATE GA_CELNUM_USO
               SET NUM_HASTA  = NUM_HASTA - 1,
                   NUM_LIBRES = NUM_LIBRES - 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_CELNUM_USO
                   (NUM_DESDE,NUM_HASTA,
                    COD_SUBALM,COD_PRODUCTO,
                    COD_CENTRAL,COD_CAT,
                    COD_USO,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (EV_CELULAR,EV_CELULAR,
                    EV_SUBALM,1,
                    EV_CENTRAL,EV_CAT,
                    EV_USO,0,EV_CELULAR);
         ELSE
            UPDATE GA_CELNUM_USO
               SET NUM_HASTA = EV_CELULAR - 1,
                   NUM_LIBRES = ((EV_CELULAR - 1) - NUM_SIGUIENTE) + 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_CELNUM_USO
                   (NUM_DESDE,NUM_HASTA,
                    COD_SUBALM,COD_PRODUCTO,
                    COD_CENTRAL,COD_CAT,
                    COD_USO,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (EV_CELULAR,EV_CELULAR,
                    EV_SUBALM,1,
                    EV_CENTRAL,EV_CAT,
                    EV_USO,0,EV_CELULAR);
            INSERT INTO GA_CELNUM_USO
                   (NUM_DESDE,NUM_HASTA,
                    COD_SUBALM,COD_PRODUCTO,
                    COD_CENTRAL,COD_CAT,
                    COD_USO,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (EV_CELULAR + 1,V_NUM_HAS,
                    EV_SUBALM,1,
                    EV_CENTRAL,EV_CAT,
                    EV_USO,(V_NUM_HAS - (EV_CELULAR + 1)) + 1,
                    EV_CELULAR + 1);
         END IF;

   END IF;

   /*SELECT VAL_PARAMETRO INTO V_FORMAT_FECHA FROM GED_PARAMETROS
   WHERE COD_PRODUCTO = 1  AND COD_MODULO = 'GE' AND NOM_PARAMETRO = 'FORMATO_SEL2';

   V_CADENA := '/'||TO_CHAR(V_FECBAJA,V_FORMAT_FECHA);*/



        --------------------------------------------------------------------------------------------------------------------------------------------------
    /*
     P_NUMERACION_MANUAL (
       EV_TRANSAC
     , EV_TABLA
     , EV_SUBALM
     , EV_CENTRAL
     , EV_CAT
     , EV_USO
     , EV_CELULAR);    */


EXCEPTION
         WHEN ERROR_EJECUCION THEN
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1, USER, 'VE_NUMERACION_PG.VE_P_NUMERACION_MANUAL_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_COD_RETORNO := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                    SV_MENS_RETORNO := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_P_NUMERACION_MANUAL_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,gn_largodesc);
             SN_NUM_EVENTO := Ge_Errores_Pg.Grabarpl( SN_NUM_EVENTO, GV_cod_modulo,SV_MENS_RETORNO, '1.0', USER, 'VE_NUMERACION_PG.VE_P_NUMERACION_MANUAL_PR', LV_sSql, SN_COD_RETORNO, LV_des_error );

END VE_P_NUMERACION_MANUAL_PR;

--------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_CONS_NUM_CEL_GA_RESERVA_PR (
          EN_NUM_CELULAR        IN GA_RESERVA.NUM_CELULAR%TYPE,
          SN_COD_CLIENTE        OUT NOCOPY GA_RESERVA.COD_CLIENTE%TYPE,
          SN_COD_VENDEDOR        OUT NOCOPY GA_RESERVA.COD_VENDEDOR%TYPE,
          SV_ORIGEN                OUT NOCOPY GA_RESERVA.ORIGEN%TYPE,
          SD_FEC_RESERVA         OUT NOCOPY GA_RESERVA.FEC_RESERVA%TYPE,
          SV_COD_SUBALM            OUT NOCOPY GA_RESERVA.COD_SUBALM%TYPE,
          SN_COD_PRODUCTO        OUT NOCOPY GA_RESERVA.COD_PRODUCTO%TYPE,
          SN_COD_CENTRAL        OUT NOCOPY GA_RESERVA.COD_CENTRAL%TYPE,
          SN_COD_CAT            OUT NOCOPY GA_RESERVA.COD_CAT%TYPE,
          SN_COD_USO            OUT NOCOPY GA_RESERVA.COD_USO%TYPE,
          SD_FEC_BAJA            OUT NOCOPY  GA_RESERVA.FEC_BAJA%TYPE ,
          SN_IND_EQUIPADO        OUT NOCOPY GA_RESERVA.IND_EQUIPADO%TYPE,
          SN_USO_ANTERIOR       OUT NOCOPY GA_RESERVA.USO_ANTERIOR%TYPE,
          SN_COD_VENDEALER      OUT NOCOPY GA_RESERVA.COD_VENDEALER%TYPE,
          SN_COD_RETORNO           OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO          OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO            OUT NOCOPY GE_ERRORES_PG.EVENTO
      )
 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = " VE_CONS_NUM_CEL_GA_HRESERVA_PR "
      Lenguaje="PL/SQL"
      Fecha=" 08-10-2008 "
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>   </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;

BEGIN
     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

LV_sSql := 'SELECT COD_CLIENTE, COD_VENDEDOR, ORIGEN, FEC_RESERVA ,COD_SUBALM , COD_PRODUCTO, COD_CENTRAL,COD_CAT, COD_USO,FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR FROM GA_RESERVA WHERE NUM_CELULAR='||EN_NUM_CELULAR;

SELECT COD_CLIENTE, COD_VENDEDOR, ORIGEN, FEC_RESERVA ,COD_SUBALM , COD_PRODUCTO, COD_CENTRAL,COD_CAT, COD_USO,FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR, COD_VENDEALER
 INTO SN_COD_CLIENTE, SN_COD_VENDEDOR, SV_ORIGEN, SD_FEC_RESERVA ,SV_COD_SUBALM , SN_COD_PRODUCTO, SN_COD_CENTRAL, SN_COD_CAT, SN_COD_USO,SD_FEC_BAJA, SN_IND_EQUIPADO, SN_USO_ANTERIOR, SN_COD_VENDEALER
FROM GA_RESERVA WHERE NUM_CELULAR=EN_NUM_CELULAR;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno:=1;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_CONS_NUM_CEL_GA_RESERVA_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_CONS_NUM_CEL_GA_RESERVA_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('VE_NUMERACION_PG.VE_CONS_NUM_CEL_GA_RESERVA_PR( '', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO ); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_NUMERACION_PG.VE_CONS_NUM_CEL_GA_RESERVA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END VE_CONS_NUM_CEL_GA_RESERVA_PR;

--------------------------------------------------------------------------------------------------------------------

  PROCEDURE VE_CONS_GA_CELNUM_USO_PR (
      EN_NUM_CELULAR                IN  GA_CELNUM_USO.NUM_DESDE%TYPE,
      SV_COD_SUBALM                 OUT NOCOPY GA_CELNUM_USO.COD_SUBALM%TYPE,
      SV_COD_CENTRAL                OUT NOCOPY GA_CELNUM_USO.COD_CENTRAL%TYPE,
      SV_COD_CAT                    OUT NOCOPY GA_CELNUM_USO.COD_CAT%TYPE,
      SV_COD_USO                    OUT NOCOPY GA_CELNUM_USO.COD_USO%TYPE,
      SN_COD_RETORNO                   OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO                  OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO                    OUT NOCOPY GE_ERRORES_PG.EVENTO)
   /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_obst_datos_numero_pr
      Lenguaje="PL/SQL"
      Fecha="08-10-2008"
      Versión="1.0"
      Diseñador="
      Programador="
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  Obtiene los datos de origen con que fue creado un numero celular </Descripción>
      <Parámetros>
         <Entrada>
            <>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
  IS

    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;
  BEGIN
     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

    LV_sSql:=' SELECT COD_SUBALM, COD_CENTRAL, COD_CAT, COD_USO FROM GA_CELNUM_USO ' ||
             ' WHERE  COD_PRODUCTO = 1 AND   '||EN_NUM_CELULAR  ||
             ' BETWEEN NUM_DESDE AND NUM_HASTA ';

    SELECT COD_SUBALM,COD_CENTRAL,COD_CAT,COD_USO
    INTO   SV_COD_SUBALM, SV_COD_CENTRAL, SV_COD_CAT, SV_COD_USO
    FROM   GA_CELNUM_USO
    WHERE  COD_PRODUCTO = 1
    AND    EN_NUM_CELULAR BETWEEN NUM_DESDE AND NUM_HASTA;


     SN_cod_retorno := 0;
     SV_mens_retorno := 'OK';
     SN_num_evento := 0;

     EXCEPTION
        WHEN OTHERS THEN
         SN_cod_retorno := GV_error_others;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := gv_error_no_clasif;
         END IF;
         LV_des_error := SUBSTR('VE_obst_datos_numero_pr(''); - ' || SQLERRM,1,GN_largoerrtec);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'VE_cambio_numero_pg.VE_obst_datos_numero_pr', LV_sSql, SN_cod_retorno, LV_des_error );

  END VE_CONS_GA_CELNUM_USO_PR;

--------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_OBTIENE_CATEGORIA_PR(
          EV_COD_ACTABO              IN GA_ACTABO.COD_ACTABO%TYPE,
          SC_BLOQ_CATEGORIAS       OUT NOCOPY REFCURSOR,
          SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO)


/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENE_CATEGORIA_PR"
      Lenguaje="PL/SQL"
      Fecha="15-09-2008"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Obtiene categorias </Descripción>
      <Parámetros>
         <Entrada>
              <param nom="EV_COD_ACTABO"            Tipo="Varchar2">Actuación comercial        </param>
         /Entrada>
         <Salida>
           <param nom="SN_COD_CATEGORIA"Tipo="Number"    >Codigo de categoria </param>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_COD_CAT    GA_CATACTABO.COD_CAT%TYPE;


BEGIN
     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
     SN_num_evento     := 0;

     SELECT  A.COD_CAT into LV_COD_CAT
     FROM GA_CATACTABO A
     WHERE A.COD_ACTABO = EV_COD_ACTABO
     AND ROWNUM=1;


     LV_sSql:='SELECT A.COD_CAT'
             ||' FROM GA_CATACTABO A'
             ||' WHERE A.COD_ACTABO = ''' || EV_COD_ACTABO || '''';

     OPEN SC_BLOQ_CATEGORIAS FOR LV_sSql;


EXCEPTION
        WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno:=1;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('PV_BAJA_OPTA_PREPAGO_PG.PV_OBTIENE_CATEGORIA_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_BAJA_OPTA_PREPAGO_PG.PV_OBTIENE_CATEGORIA_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
                     SN_cod_retorno := GV_error_others;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('PV_BAJA_OPTA_PREPAGO_PG.PV_OBTIENE_CATEGORIA_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_BAJA_OPTA_PREPAGO_PG.PV_OBTIENE_CATEGORIA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END VE_OBTIENE_CATEGORIA_PR;

PROCEDURE VE_VALIDA_NUMERACION_PR(    EV_NumFrecuente      IN TA_NUMNACIONAL.NUM_TDESDE%TYPE,
                                       EV_CodOperadorMin     IN VARCHAR2,
                                    EV_Procedencia       IN VARCHAR2,--(I,E)
                                    EV_codCliente        IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                    SV_ROWID             OUT NOCOPY VARCHAR,
                                    SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento          OUT NOCOPY ge_errores_pg.Evento)   IS


LV_des_error               GE_ERRORES_PG.DesEvent;
sSql                           GE_ERRORES_PG.vQuery;


BEGIN

    SN_cod_retorno := 0;
    SV_mens_retorno := '';
    SN_num_evento := 0;



     IF EV_PROCEDENCIA ='E' THEN


            SSQL := ' SELECT ROWID';
            SSQL := SSQL || ' FROM TA_NUMNACIONAL ';
            SSQL := SSQL || ' WHERE '||  EV_NumFrecuente||'  BETWEEN TO_NUMBER(NUM_TDESDE) AND TO_NUMBER(NUM_THASTA)';
            SSQL := SSQL || ' AND COD_OPERADOR IN ('||EV_CodOperadorMin|| ') AND ROWNUM=1';
    ELSE
            SSQL:= 'SELECT ROWID';
            SSQL := SSQL || ' FROM GA_ABOCEL ';
            SSQL := SSQL || ' WHERE COD_CLIENTE =' ||  EV_codCliente;
            SSQL := SSQL || ' AND   NUM_CELULAR =' ||  EV_NumFrecuente;
            SSQL := SSQL || ' AND COD_SITUACION NOT IN (''BAA'',''BAP'')';
            SSQL := SSQL || ' AND COD_PRESTACION IN (SELECT COD_PRESTACION FROM GE_PRESTACIONES_TD WHERE GRP_PRESTACION=''TF'' AND IND_SS_INTERNET=1) AND ROWNUM=1';

    END IF;


    EXECUTE IMMEDIATE SSQL INTO SV_ROWID;





EXCEPTION
WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 1;
         SV_mens_retorno := 'Error en ejecución PL-SQL VE_VALIDA_NUMERACION_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'VE_VALIDA_NUMERACION_PR', SSQL, SQLCODE, LV_des_error );

WHEN OTHERS THEN
         SN_cod_retorno := 4;
         SV_mens_retorno := 'Error en ejecución VE_VALIDA_NUMERACION_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'VE_VALIDA_NUMERACION_PR', sSql, SQLCODE, LV_des_error );
END VE_VALIDA_NUMERACION_PR;
PROCEDURE VE_VALIDA_NUMERACION_PR(
                                    EV_NUMTELEFONO       IN GA_REFERCLI_TO.NUM_TELFIJO%TYPE,
                                       EV_TipRed            IN VARCHAR2, --F: FIJO M:MOVIL
                                    SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento          OUT NOCOPY ge_errores_pg.Evento)   IS


LV_des_error               GE_ERRORES_PG.DesEvent;
sSql                        GE_ERRORES_PG.vQuery;
LV_COUNT                  NUMBER(9);
ERROR_VALIDA_NUMERO       EXCEPTION;

BEGIN

    SN_cod_retorno := 0;
    SV_mens_retorno := '';
    SN_num_evento := 0;
    LV_COUNT:=0;


     IF EV_TipRed ='F' THEN
            SSQL := ' SELECT COUNT(1)';
            SSQL := SSQL || ' FROM TA_NUMNACIONAL ';
            SSQL := SSQL || ' WHERE '||  EV_NUMTELEFONO||'  BETWEEN TO_NUMBER(NUM_TDESDE) AND TO_NUMBER(NUM_THASTA)';
            SSQL := SSQL || ' AND COD_DOPE IN (SELECT COD_VALOR FROM  ged_codigos where cod_modulo=''GA'' and nom_columna=''DOPE_FIJO'')';
     ELSE
            SSQL := ' SELECT COUNT(1)';
            SSQL := SSQL || ' FROM TA_NUMNACIONAL ';
            SSQL := SSQL || ' WHERE '||  EV_NUMTELEFONO||'  BETWEEN TO_NUMBER(NUM_TDESDE) AND TO_NUMBER(NUM_THASTA)';
            SSQL := SSQL || ' AND COD_DOPE IN (SELECT COD_VALOR FROM  ged_codigos where cod_modulo=''GA'' and nom_columna=''DOPE_MOVIL'')';
     END IF;


    EXECUTE IMMEDIATE SSQL INTO LV_COUNT;

    IF LV_COUNT =0 THEN
       RAISE ERROR_VALIDA_NUMERO;
    END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN
         SN_cod_retorno := 1;
         SV_mens_retorno := 'Error en ejecución PL-SQL VE_VALIDA_NUMERACION_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'VE_VALIDA_NUMERACION_PR', SSQL, SQLCODE, LV_des_error );

WHEN ERROR_VALIDA_NUMERO THEN
        SN_cod_retorno := 1;
         SV_mens_retorno := 'Número Invalido';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'VE_VALIDA_NUMERACION_PR', SSQL, SQLCODE, LV_des_error );
WHEN OTHERS THEN
         SN_cod_retorno := 4;
         SV_mens_retorno := 'Error en ejecución VE_VALIDA_NUMERACION_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'VE_VALIDA_NUMERACION_PR', sSql, SQLCODE, LV_des_error );

END VE_VALIDA_NUMERACION_PR;


PROCEDURE VE_VALIDA_NUMERACION_LDI_PR(  EV_NUMTELEFONO       IN GA_REFERCLI_TO.NUM_TELFIJO%TYPE,
                                        SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento          OUT NOCOPY ge_errores_pg.Evento)   IS

LV_des_error               GE_ERRORES_PG.DesEvent;
sSql                        GE_ERRORES_PG.vQuery;
LV_COUNT                  NUMBER(9);
ERROR_VALIDA_NUMERO       EXCEPTION;

BEGIN

    SN_cod_retorno := 0;
    SV_mens_retorno := '';
    SN_num_evento := 0;
    LV_COUNT:=0;

    SELECT COUNT(1)
    INTO   LV_COUNT
    FROM   TA_NUMNACIONAL A,
           TA_OPERADORES B,
           GA_TIP_OPERADORES_TD C
    WHERE  EV_NUMTELEFONO BETWEEN TO_NUMBER(NUM_TDESDE) AND TO_NUMBER(NUM_THASTA)
    AND A.COD_OPERADOR = B.COD_OPERADOR
    AND C.COD_DOPE = B.COD_DOPE
    AND C.TIP_LLAM = 1 --OFFNET
    AND C.TIP_RED IN (0,1); -- MOVIL y Fijo


    IF LV_COUNT =0 THEN
       RAISE ERROR_VALIDA_NUMERO;
    END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN
         SN_cod_retorno := 1;
         SV_mens_retorno := 'Error en ejecución PL-SQL VE_VALIDA_NUMERACION_LDI_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'VE_VALIDA_NUMERACION_PR', SSQL, SQLCODE, LV_des_error );

WHEN ERROR_VALIDA_NUMERO THEN
        SN_cod_retorno := 1;
         SV_mens_retorno := 'Número Invalido';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'VE_VALIDA_NUMERACION_PR', SSQL, SQLCODE, LV_des_error );
WHEN OTHERS THEN
         SN_cod_retorno := 4;
         SV_mens_retorno := 'Error en ejecución PL-SQL VE_VALIDA_NUMERACION_LDI_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'VE_VALIDA_NUMERACION_PR', sSql, SQLCODE, LV_des_error );
END VE_VALIDA_NUMERACION_LDI_PR;

-----------------------------------------------------------------------------------------------------------
--P-CSR-11002 JLGN 14-11-2011 
PROCEDURE ve_val_disp_numero_pr(ev_numcelular   IN ga_abocel.num_celular%TYPE,
                                sn_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                sv_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.Evento)   IS

lv_des_error         GE_ERRORES_PG.DesEvent;
ssql                 GE_ERRORES_PG.vQuery;
lv_count             NUMBER;
error_valida_numero  EXCEPTION;

BEGIN

    sn_cod_retorno := 0;
    sv_mens_retorno := '';
    sn_num_evento := 0;
    lv_count :=0;
    
    ssql := 'SELECT COUNT(0) '
          ||'FROM   ga_abocel '
          ||'WHERE  num_celular = '||ev_numcelular||''
          ||'AND    cod_situacion NOT IN (''BAA'',''BAP'')';
    
    SELECT COUNT(0)
    INTO   lv_count
    FROM   ga_abocel
    WHERE  num_celular = ev_numcelular
    AND    cod_situacion NOT IN ('BAA','BAP'); --Situacion debe ser distinto de Baja

    IF lv_count > 0 THEN
       RAISE error_valida_numero;
    ELSE
        ssql := 'SELECT COUNT(0) '
              ||'FROM   ga_aboamist '
              ||'WHERE  num_celular = '||ev_numcelular||''
              ||'AND    cod_situacion NOT IN (''BAA'',''BAP'')';
              
        SELECT COUNT(0)
        INTO   lv_count
        FROM   ga_aboamist
        WHERE  num_celular = ev_numcelular
        AND    cod_situacion NOT IN ('BAA','BAP'); --Situacion debe ser distinto de Baja
        
        IF lv_count > 0 THEN
            RAISE error_valida_numero;
        END IF;        
    END IF;

EXCEPTION
WHEN error_valida_numero THEN
        sn_cod_retorno  := 1;
        sv_mens_retorno := 'Número se encuentra asociado a un abonado. Favor contactarse con el área de Logistica';
        lv_des_error    := SQLERRM;
        sn_num_evento   := Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'VE_VALIDA_NUMERACION_PR', SSQL, SQLCODE, LV_des_error );
WHEN OTHERS THEN
         SN_cod_retorno := 4;
         SV_mens_retorno := 'Error en ejecución PL-SQL ve_val_disp_numero_pr.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'VE_VALIDA_NUMERACION_PR', sSql, SQLCODE, LV_des_error );
END ve_val_disp_numero_pr;

END VE_Numeracion_Pg;
/
