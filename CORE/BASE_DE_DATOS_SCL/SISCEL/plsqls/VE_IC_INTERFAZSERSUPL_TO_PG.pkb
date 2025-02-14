CREATE OR REPLACE PACKAGE BODY VE_IC_INTERFAZSERSUPL_TO_PG
AS

CV_error_no_clasif CONSTANT VARCHAR2(20) := 'Error no clasificado';

PROCEDURE ve_agregar_pr (EN_num_abonado      IN ic_interfazsersupl_to.num_abonado%TYPE,
                         EN_num_trx          IN ic_interfazsersupl_to.num_trx%TYPE,
                         EV_cod_periocidad   IN ic_interfazsersupl_to.cod_periocidad%TYPE,
                         EV_cod_servicios    IN ic_interfazsersupl_to.cod_servicios%TYPE, --Inc. 76664 RAB 04-04-2009
                         SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                         SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_AGREGAR_PR"
 Lenguaje="PL/SQL"
 Fecha="11/11/2005"
 Versión="1.0.0"
 Diseñador="Vladimir Maureira"
 Programador="vladimir maureira"
 Ambiente="DEIMOS_ANDINA">
 <Retorno>NA</Retorno>
 <Descripción>Inserta en tabla IC_INTERFAZSERSUPL_TO</Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EN_num_abonado   " Tipo="NUMBER"></param>
   <param nom="EN_num_trx       " Tipo="NUMBER"></param>
   <param nom="EV_cod_periocidad  " Tipo="VARCHAR2"></param>
  </Entrada>
  <Salida>
      <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de Retorno</param>
      <param nom="SN_num_evento"   Tipo="NUMBER">Numero de Evento</param>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sql           ge_errores_pg.vQuery;
BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '0';

     LV_sql := 'INSERT INTO IC_INTERFAZSERSUPL_TO (num_abonado,num_trx,cod_periocidad,cod_servicios)';
     LV_sql := LV_sql || '(' || EN_num_abonado || ',' || EN_num_trx || ',' || EV_cod_periocidad || ',' || EV_cod_servicios || ')';

    BEGIN

       INSERT INTO ic_interfazsersupl_to
               (num_abonado,num_trx,cod_periocidad,cod_servicios)
       VALUES
               (EN_num_abonado,EN_num_trx,EV_cod_periocidad,EV_cod_servicios);

      EXCEPTION
          WHEN OTHERS THEN
             SN_cod_retorno := 4; --No se pudo agregar datos
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
             END IF;
          LV_des_error  := 've_ic_interfazsersupl_to_pg.ve_agregar_pr(' || EN_num_abonado || ',' || EN_num_trx || ',' || EV_cod_periocidad || ',' || EV_cod_servicios || ',' || '); - ' || SQLERRM;
          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', 'Error no clasificado', '1.0', USER,'ve_ic_interfazsersupl_to_pg.ve_agregar_pr', LV_sql, SQLCODE, LV_des_error );
   END;
END ve_agregar_pr ;

PROCEDURE ve_eliminar_pr (EN_num_abonado      IN ic_interfazsersupl_to.num_abonado%TYPE,
                          EV_cod_periocidad   IN ic_interfazsersupl_to.cod_periocidad%TYPE,
                          EV_cod_servicios    IN ic_interfazsersupl_to.cod_servicios%TYPE, --Inc. 76664 RAB 04-04-2009
                          SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                          SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_ELIMINAR_PR"
 Lenguaje="PL/SQL"
 Fecha="11/11/2005"
 Versión="1.0.0"
 Diseñador="Vladimir mauriera"
 Programador="vladimir maureira"
 Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Elimina de tabla IC_INTERFAZSERSUPL_TO</Descripción>
 <Parámetros>
  <Entrada>
     <param nom="EN_num_abonado   " Tipo="NUMBER"></param>
     <param nom="EV_cod_periocidad  " Tipo="VARCHAR2"></param>
  </Entrada>
  <Salida>
      <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de Retorno</param>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sql           ge_errores_pg.vQuery;
LV_query         VARCHAR2(2000);
LN_num_evento    ge_errores_pg.Evento;
-- Ini. Inc. 76664 RAB 04-04-2009
LN_count         number(5);
LN_cod_servsupl  ga_servsuplabo.cod_servsupl%type;
LN_cod_nivel     ga_servsuplabo.cod_nivel%type;
-- Fin Inc. 76664 RAB 04-04-2009

BEGIN
     SN_cod_retorno := 0;
     LN_num_evento  := 0;
     SV_mens_retorno:= '0';

   BEGIN
   	-- Ini. Inc. 76664 RAB 04-04-2009
   	LN_count := 0;
   	IF EV_cod_servicios IS NOT NULL THEN
	    LN_cod_servsupl := substr(EV_cod_servicios,1,2);
	    LN_cod_nivel := substr(EV_cod_servicios,3,4);

	    select count(1) into LN_count
	    from ga_servsuplabo
	    where num_abonado = EN_num_abonado
	    and   cod_servsupl = LN_cod_servsupl
	    and   cod_nivel = LN_cod_nivel
	    and   ind_estado > 2;
	END IF;
   	-- Fin Inc. 76664 RAB 04-04-2009

   	IF (LN_count > 0) THEN --Inc. 76664 RAB 04-04-2009

            LV_sql := 'DELETE FROM ic_interfazsersupl_to ';
            LV_sql := LV_sql || ' WHERE num_abonado = ' || EN_num_abonado;

            LV_query := 'DELETE FROM ic_interfazsersupl_to ';
            LV_query := LV_query || ' WHERE num_abonado = :num_abonado';

           IF EV_cod_periocidad IS NOT NULL THEN
              LV_query := LV_query || ' AND  cod_periocidad= :cod_periocidad';
              LV_sql   := LV_sql || ' AND cod_periocidad= ' || EV_cod_periocidad;
           END IF;

           -- Ini. Inc. 76664 RAB 04-04-2009
           IF EV_cod_servicios IS NOT NULL THEN
              LV_query := LV_query || ' AND  cod_servicios= :cod_servicios';
              LV_sql   := LV_sql || ' AND cod_servicios= ' || EV_cod_servicios;
           END IF;

           IF (EV_cod_periocidad IS NOT NULL) AND (EV_cod_servicios IS NOT NULL) THEN
            EXECUTE IMMEDIATE LV_query USING EN_num_abonado,EV_cod_periocidad,EV_cod_servicios;
           -- Fin Inc. 76664 RAB 04-04-2009
           ELSIF EV_cod_periocidad IS NOT NULL THEN
            EXECUTE IMMEDIATE LV_query USING EN_num_abonado,EV_cod_periocidad;
           ELSE
            EXECUTE IMMEDIATE LV_query USING EN_num_abonado;
           END IF;

        END IF; --Inc. 76664 RAB 04-04-2009

      EXCEPTION
          WHEN OTHERS THEN
             SN_cod_retorno := 3; --No se pudo eliminar datos
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
             END IF;
          LV_des_error  := 've_ic_interfazsersupl_to_pg.ve_eliminar_pr(' || EN_num_abonado || ',' || EV_cod_periocidad || '); - ' || SQLERRM;
          LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, 'GA', 'Error no clasificado', '1.0', USER,'ve_ic_interfazsersupl_to_pg.ve_eliminar_pr', LV_sql, SQLCODE, LV_des_error );
   END;

END ve_eliminar_pr;

PROCEDURE ve_buscar_pr (EN_num_abonado      IN ic_interfazsersupl_to.num_abonado%TYPE,
                        EV_cod_periocidad   IN ic_interfazsersupl_to.cod_periocidad%TYPE,
                        SN_num_trx          OUT NOCOPY NUMBER,
                        SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                        SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_BUSCAR_PR"
 Lenguaje="PL/SQL"
 Fecha="11/11/2005"
 Versión="1.0.0"
 Diseñador="Vladimir mauriera"
 Programador="vladimir maureira"
 Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Buscar ID en tabla IC_INTERFAZSERSUPL_TO</Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EN_num_abonado  " Tipo="NUMBER"></param>
   <param nom="EV_cod_periocidad " Tipo="VARCHAR2"></param>

  </Entrada>
  <Salida>
      <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de Retorno</param>
      <param nom="SN_num_evento"   Tipo="NUMBER">Numero de Evento</param>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sql           ge_errores_pg.vQuery;
LV_query         VARCHAR2(2000);

BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '0';

     LV_sql := 'SELECT ic.num_trx ';
     LV_sql := LV_sql || ' FROM   ic_interfazsersupl_to ic ';
     LV_sql := LV_sql || ' WHERE  ic.num_abonado = ' || EN_num_abonado;
     LV_sql := LV_sql || ' AND    ic.cod_periocidad  = ' || EV_cod_periocidad;

   BEGIN

       SELECT ic.num_trx
       INTO   SN_num_trx
       FROM   ic_interfazsersupl_to ic
       WHERE  ic.num_abonado  = EN_num_abonado
       AND    ic.cod_periocidad = EV_cod_periocidad;

      EXCEPTION
          WHEN OTHERS THEN
             SN_cod_retorno := 1; --No se pudo recuperar datos
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
             END IF;

          SN_num_trx := NULL;
          LV_des_error  := 've_ic_interfazsersupl_to_pg.ve_buscar_pr(' || EN_num_abonado || ',' || EV_cod_periocidad || '); - ' || SQLERRM;
          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', 'Error no clasificado', '1.0', USER,'ve_ic_interfazsersupl_to_pg.ve_buscar_pr', LV_sql, SQLCODE, LV_des_error );
   END;
END ve_buscar_pr;

PROCEDURE ve_modificar_pr (EN_num_abonado      IN ic_interfazsersupl_to.num_abonado%TYPE,
                           EN_num_trx          IN ic_interfazsersupl_to.num_trx%TYPE,
                           EV_cod_periocidad   IN ic_interfazsersupl_to.cod_periocidad%TYPE,
                           EV_cod_servicios    IN ic_interfazsersupl_to.cod_servicios%TYPE, --Inc. 76664 RAB 04-04-2009
                           SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                           SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                           SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_MODIFICAR_PR"
 Lenguaje="PL/SQL"
 Fecha="11/11/2005"
 Versión="1.0.0"
 Diseñador="Vladimir mauriera"
 Programador="vladimir maureira"
 Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción>Actualización ID en tabla IC_INTERFAZSERSUPL_TO</Descripción>
 <Parámetros>
  <Entrada>
   <param nom="EN_num_abonado    " Tipo="NUMBER"></param>
   <param nom="EN_num_trx        " Tipo="NUMBER"></param>
   <param nom="EV_cod_periocidad " Tipo="VARCHAR2"></param>
  </Entrada>
  <Salida>
      <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de Retorno</param>
      <param nom="SN_num_evento"   Tipo="NUMBER">Numero de Evento</param>
  </Salida>
 </Parámetros>
</Elemento>
</Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sql           ge_errores_pg.vQuery;
BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '0';

     LV_sql := 'UPDATE ic_interfazsersupl_to ';
     LV_sql := LV_sql || ' SET    num_trx = ' || EN_num_trx;
     LV_sql := LV_sql || ' WHERE  num_abonado = ' || EN_num_abonado;
     LV_sql := LV_sql || '   AND  cod_periocidad= ' || EV_cod_periocidad;
     LV_sql := LV_sql || '   AND  cod_servicios= ' || EV_cod_servicios; --Inc. 76664 RAB 04-04-2009

     UPDATE ic_interfazsersupl_to
     SET    num_trx = EN_num_trx
     WHERE  num_abonado = EN_num_abonado
     AND    cod_periocidad= EV_cod_periocidad
     AND    cod_servicios = EV_cod_servicios; --Inc. 76664 RAB 04-04-2009

     EXCEPTION
          WHEN OTHERS THEN
             SN_cod_retorno := 156; --ERROR GENERAL
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
             END IF;

          LV_des_error  := 've_ic_interfazsersupl_to_pg.ve_modificar_pr(' || EN_num_abonado || ',' || EN_num_trx || ',' || EV_cod_periocidad || '); - ' || SQLERRM;
          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', 'Error no clasificado', '1.0', USER,'ve_ic_interfazsersupl_to_pg.ve_modificar_pr', LV_sql, SQLCODE, LV_des_error );
END ve_modificar_pr;

END VE_IC_INTERFAZSERSUPL_TO_PG;
/
SHOW ERRORS
