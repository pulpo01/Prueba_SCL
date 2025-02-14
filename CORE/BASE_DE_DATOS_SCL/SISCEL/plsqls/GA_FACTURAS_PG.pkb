CREATE OR REPLACE PACKAGE BODY ga_facturas_pg

AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_recupera_tablaenlace_fn (
   EN_cod_ciclfact	   IN    fa_enlacehist.cod_ciclfact%TYPE,
   SV_fa_histconc	   OUT   NOCOPY fa_enlacehist.fa_histconc%TYPE,
   SN_cod_retorno      OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno     OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento       OUT   NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_TABLAENLACE_FN"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera Tabla de Almacenamiento Historico</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_ciclfact" Tipo="CARACTER">Ciclo de Facturacion</param>
         </Entrada>
			<param nom="SV_fa_histconc" Tipo="CARACTER">Tabla FA_HISTCONC</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql			   ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

	LV_sSql := 'SELECT a.fa_histconc';
	LV_sSql := LV_sSql || ' FROM fa_enlacehist a';
	LV_sSql := LV_sSql || ' WHERE a.cod_ciclfact = '||EN_cod_ciclfact;

	SELECT a.fa_histconc
	INTO   SV_fa_histconc
	FROM   fa_enlacehist a
	WHERE  a.cod_ciclfact = EN_cod_ciclfact;

	RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 890037;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_recupera_tablaenlace_fn('||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_recupera_tablaenlace_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_recupera_tablaenlace_fn('||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_recupera_tablaenlace_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_recupera_tablaenlace_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_montoconcepto_fn (
   EN_ind_ordentotal   IN   fa_histdocu.ind_ordentotal%TYPE,
   EN_cod_ciclfact	   IN	fa_histdocu.cod_ciclfact%TYPE,
   EN_tip_concepto	   IN   NUMBER,
   SN_monto_concepto  OUT   NOCOPY NUMBER,
   SN_cod_retorno     OUT	NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno    OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento      OUT   NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_MONTOCONCEPTO_FN"
      Lenguaje="PL/SQL"
      Fecha="16-06-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera el Monto de un tipo de concepto</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_ind_ordentotal" Tipo="NUMERICO">Indicador de Orden Total</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Ciclo de Facturacion</param>
            <param nom="EN_tip_concepto" Tipo="NUMERICO">Tipo de Concepto (1-Impuestos, 2-Descuentos, 3-Cargos)</param>
         </Entrada>
         <Salida>
            <param nom="SN_monto_concepto" Tipo="NUMERICO">Monto del Concepto</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
	LV_qry            ge_errores_pg.vQuery;
	LV_fa_histconc    fa_enlacehist.fa_histconc%TYPE;

	error_ejecucion  EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

	-- Se recupera la tabla de conceptos dependiendo del ciclo de facturacion
	IF NOT ga_recupera_tablaenlace_fn(EN_cod_ciclfact,LV_fa_histconc,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
	    RAISE error_ejecucion;
	END IF;

	-- Se obtiene el monto del concepto
    LV_sSql := 'SELECT ROUND(SUM(a.imp_facturable)) monto';
    LV_sSql := LV_sSql || ' FROM '||LV_fa_histconc||' a';
    LV_sSql := LV_sSql || ' WHERE a.ind_ordentotal = '||EN_ind_ordentotal;
    LV_sSql := LV_sSql || ' AND a.cod_tipconce = '||EN_tip_concepto;

	LV_qry := 'SELECT ROUND(SUM(a.imp_facturable)) monto';
    LV_qry := LV_qry || ' FROM '||LV_fa_histconc||' a';
    LV_qry := LV_qry || ' WHERE a.ind_ordentotal = :indorden';
    LV_qry := LV_qry || ' AND a.cod_tipconce = :tipconcepto';

	EXECUTE IMMEDIATE LV_qry
	INTO SN_monto_concepto
	USING EN_ind_ordentotal, EN_tip_concepto;

	RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      LV_des_error := 'ga_recupera_montoconcepto_fn('||EN_ind_ordentotal||','||EN_cod_ciclfact||','||EN_tip_concepto||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_recupera_montoconcepto_fn', LV_sSql, SN_cod_retorno, LV_des_error );
	  RETURN FALSE;

   WHEN NO_DATA_FOUND THEN
      SN_monto_concepto := 0;
	  RETURN TRUE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_recupera_montoconcepto_fn('||EN_ind_ordentotal||','||EN_cod_ciclfact||','||EN_tip_concepto||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_recupera_montoconcepto_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_recupera_montoconcepto_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_saldocliente_fn (
   EN_cod_cliente	   IN   co_cartera.cod_cliente%TYPE,
   SN_saldo_actual	  OUT   NOCOPY co_cartera.importe_debe%TYPE,
   SN_cod_retorno     OUT	NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno    OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento      OUT   NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_SALDOCLIENTE_FN"
      Lenguaje="PL/SQL"
      Fecha="16-06-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera el Saldo de un Cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SN_saldo_actual" Tipo="NUMERICO">Saldo Actual</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql				ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

	LV_sSql := 'SELECT NVL (SUM (a.importe_debe - a.importe_haber), 0) saldo_actual INTO SN_saldo_actual';
    LV_sSql := LV_sSql || ' FROM co_cartera a';
    LV_sSql := LV_sSql || ' WHERE a.cod_cliente = '||EN_cod_cliente;
    LV_sSql := LV_sSql || ' AND a.ind_facturado = 1';
    LV_sSql := LV_sSql || ' AND a.cod_tipdocum NOT IN (SELECT TO_NUMBER (b.cod_valor)';
    LV_sSql := LV_sSql || '                            FROM co_codigos b';
    LV_sSql := LV_sSql || '                           WHERE b.nom_tabla = ''CO_CARTERA''';
    LV_sSql := LV_sSql || '                             AND b.nom_columna = ''COD_TIPDOCUM'');';

    SELECT NVL (SUM (a.importe_debe - a.importe_haber), 0) saldo_actual
	  INTO SN_saldo_actual
      FROM co_cartera a
     WHERE a.cod_cliente = EN_cod_cliente
       AND a.ind_facturado = 1
       AND a.cod_tipdocum NOT IN (SELECT TO_NUMBER (b.cod_valor)
                                  FROM co_codigos b
                                 WHERE b.nom_tabla = 'CO_CARTERA'
                                   AND b.nom_columna = 'COD_TIPDOCUM');

	RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
      SN_saldo_actual := 0;
	  RETURN TRUE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_recupera_saldocliente_fn('||EN_cod_cliente||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_recupera_saldocliente_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_recupera_saldocliente_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_fecsuspension_fn (
   EN_cod_cliente	   IN   ga_abocel.cod_cliente%TYPE,
   SV_fec_suspencion  OUT   NOCOPY VARCHAR2,
   SN_cod_retorno     OUT	NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno    OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento      OUT   NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_FECSUSPENSION_FN"
      Lenguaje="PL/SQL"
      Fecha="16-06-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera el Saldo de un Cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SV_fec_suspencion" Tipo="CARACTER">Fecha de Suspencion</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
    LV_des_error         ge_errores_pg.DesEvent;
    LV_sSql         	 ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

	LV_sSql := 'SELECT TO_CHAR(fec_susp, ''YYYYMMDD'') fec_suspension INTO SV_fec_suspencion';
    LV_sSql := LV_sSql || ' FROM (SELECT a.fec_suspension fec_susp';
    LV_sSql := LV_sSql || '         FROM co_susplimcred a';
    LV_sSql := LV_sSql || '        WHERE a.cod_cliente = '||EN_cod_cliente;
    LV_sSql := LV_sSql || '        UNION';
    LV_sSql := LV_sSql || '       SELECT a.fecha_suspension fec_susp';
    LV_sSql := LV_sSql || '         FROM co_suspespecial a';
    LV_sSql := LV_sSql || '        WHERE a.cod_cliente = '||EN_cod_cliente;
    LV_sSql := LV_sSql || '     ORDER BY fec_susp)';
    LV_sSql := LV_sSql || ' WHERE  ROWNUM = 1;';

    SELECT TO_CHAR(fec_susp, 'YYYYMMDD') fec_suspension
	  INTO SV_fec_suspencion
      FROM (SELECT a.fec_suspension fec_susp
              FROM co_susplimcred a
             WHERE a.cod_cliente = EN_cod_cliente
             UNION
            SELECT a.fecha_suspension fec_susp
              FROM co_suspespecial a
             WHERE a.cod_cliente = EN_cod_cliente
			 ORDER BY fec_susp)
     WHERE  ROWNUM = 1;

	RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
      SV_fec_suspencion := '';
	  RETURN TRUE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_recupera_fecsuspension_fn('||EN_cod_cliente||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_recupera_fecsuspension_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_recupera_fecsuspension_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_ultimopago_fn (
   EN_cod_cliente	   IN   co_pagos.cod_cliente%TYPE,
   SN_imp_pago		  OUT   NOCOPY co_pagos.imp_pago%TYPE,
   SN_cod_retorno     OUT	NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno    OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento      OUT   NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_ULTIMOPAGO_FN"
      Lenguaje="PL/SQL"
      Fecha="16-06-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera informacion basica de un Pago</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SN_imp_pago" Tipo="NUMERICO">Pago realizado</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql         	   ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

	LV_sSql := 'SELECT imp_pago INTO SN_imp_pago';
    LV_sSql := LV_sSql || ' FROM (SELECT a.imp_pago';
    LV_sSql := LV_sSql || '         FROM co_pagos a';
    LV_sSql := LV_sSql || '        WHERE a.cod_cliente = '||EN_cod_cliente;
    LV_sSql := LV_sSql || '        ORDER BY a.fec_efectividad DESC)';
    LV_sSql := LV_sSql || ' WHERE ROWNUM = 1';

    SELECT imp_pago
	  INTO SN_imp_pago
      FROM (SELECT a.imp_pago
              FROM co_pagos a
             WHERE a.cod_cliente = EN_cod_cliente
            ORDER BY a.fec_efectividad DESC)
     WHERE ROWNUM = 1;

	RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
      SN_imp_pago := 0;
	  RETURN TRUE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_recupera_ultimopago_fn('||EN_cod_cliente||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_recupera_ultimopago_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_recupera_ultimopago_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_datos_basicosciclo_fn (
   EN_cod_ciclfact	   IN    fa_ciclfact.cod_ciclfact%TYPE,
   SV_fec_ini		  OUT	 NOCOPY VARCHAR2,
   SV_fec_fin		  OUT	 NOCOPY VARCHAR2,
   SN_cod_ciclo		  OUT	 NOCOPY fa_ciclfact.cod_ciclo%TYPE,
   SN_dia_periodo	  OUT	 NOCOPY fa_ciclfact.dia_periodo%TYPE,
   SN_ind_tasador	  OUT	 NOCOPY fa_ciclfact.ind_tasador%TYPE,
   SN_cod_retorno     OUT	 NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno    OUT    NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento      OUT    NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_DATOS_BASICOSCICLO_FN"
      Lenguaje="PL/SQL"
      Fecha="16-06-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera informacion basica de un ciclo</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Ciclo de Facturacion</param>
         </Entrada>
         <Salida>
            <param nom="SV_fec_ini" Tipo="CARACTER">Fecha de inicio de las llamadas facturadas</param>
            <param nom="SV_fec_fin" Tipo="CARACTER">Fecha de fin de las llamadas facturadas</param>
            <param nom="SN_cod_ciclo" Tipo="NUMERICO">Codigo de Ciclo</param>
            <param nom="SN_dia_periodo" Tipo="NUMERICO">Periodo de Dias</param>
            <param nom="SN_ind_tasador" Tipo="NUMERICO">Tasador Utilizado</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql         	   ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

	LV_sSql := 'SELECT TO_CHAR(a.fec_desdellam,''YYYYMMDD'') fec_ini, TO_CHAR(a.fec_hastallam,''YYYYMMDD'') fec_fin,';
	LV_sSql := LV_sSql || ' a.cod_ciclo, a.dia_periodo, a.ind_tasador';
	LV_sSql := LV_sSql || ' INTO SV_fec_ini, SV_fec_fin, SN_cod_ciclo, SN_dia_periodo, SN_ind_tasador';
	LV_sSql := LV_sSql || ' FROM fa_ciclfact a';
	LV_sSql := LV_sSql || ' WHERE a.cod_ciclfact = '||EN_cod_ciclfact;

	SELECT TO_CHAR(a.fec_desdellam,'YYYYMMDD') fec_ini, TO_CHAR(a.fec_hastallam,'YYYYMMDD') fec_fin,
	       a.cod_ciclo, a.dia_periodo, a.ind_tasador
	  INTO SV_fec_ini, SV_fec_fin, SN_cod_ciclo, SN_dia_periodo, SN_ind_tasador
	  FROM fa_ciclfact a
     WHERE a.cod_ciclfact = EN_cod_ciclfact;

	RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 254;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_datos_basicosciclo_fn('||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_datos_basicosciclo_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_datos_basicosciclo_fn('||EN_cod_ciclfact||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_datos_basicosciclo_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_datos_basicosciclo_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_datos_basicosfactura_fn (
   EN_cod_cliente	    IN     ga_abocel.cod_cliente%TYPE,
   EN_cant_facturas		IN     NUMBER,
   SN_tot_pagar		    OUT    NOCOPY fa_histdocu.tot_pagar%TYPE,
   SV_fec_emision	    OUT    NOCOPY VARCHAR2,
   SN_ind_ordentotal	OUT    NOCOPY fa_histdocu.ind_ordentotal%TYPE,
   SV_fec_vencimie		OUT    NOCOPY VARCHAR2,
   SN_cod_ciclfact		OUT    NOCOPY fa_histdocu.cod_ciclfact%TYPE,
   SN_imp_saldoant		OUT    NOCOPY fa_histdocu.imp_saldoant%TYPE,
   SN_tot_cuotas		OUT    NOCOPY fa_histdocu.tot_cuotas%TYPE,
   SN_cod_retorno       OUT	   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno      OUT    NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento        OUT    NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_DATOS_BASICOSFACTURA_FN"
      Lenguaje="PL/SQL"
      Fecha="16-06-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera informacion basica de una factura</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
            <param nom="EN_cant_facturas" Tipo="NUMERICO">Cantidad de Facturas</param>
         </Entrada>
         <Salida>
            <param nom="SN_tot_pagar" Tipo="NUMERICO">Total a Pagar</param>
            <param nom="SV_fec_emision" Tipo="CARACTER">Fecha de Emision del Documento</param>
            <param nom="SN_ind_ordentotal" Tipo="NUMERICO">Indicador de Orden Total</param>
            <param nom="SV_fec_vencimie" Tipo="CARACTER">Fecha de Vencimiento del Documento</param>
            <param nom="SN_cod_ciclfact" Tipo="NUMERICO">Ciclo de Facturacion</param>
            <param nom="SN_imp_saldoant" Tipo="NUMERICO">Saldo Anterior</param>
            <param nom="SN_tot_cuotas" Tipo="NUMERICO">Valor de Cuotas</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql         	   ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

	LV_sSql := 'SELECT tot_pagar, TO_CHAR(fec_emision,''YYYYMMDD'') fec_emision, ind_ordentotal, TO_CHAR(fec_vencimie,''YYYYMMDD'') fec_vencimie, cod_ciclfact, imp_saldoant, tot_cuotas';
    LV_sSql := LV_sSql || ' INTO SN_tot_pagar, SV_fec_emision, SN_ind_ordentotal, SV_fec_vencimie, SN_cod_ciclfact, SN_imp_saldoant, SN_tot_cuotas';
    LV_sSql := LV_sSql || ' FROM (SELECT a.tot_pagar, a.fec_emision, a.ind_ordentotal, a.fec_vencimie, a.cod_ciclfact, a.imp_saldoant, a.tot_cuotas';
    LV_sSql := LV_sSql || '         FROM fa_histdocu a';
    LV_sSql := LV_sSql || '        WHERE a.cod_cliente = '||EN_cod_cliente;
    LV_sSql := LV_sSql || '        ORDER BY a.fec_emision DESC)';
    LV_sSql := LV_sSql || ' WHERE ROWNUM = EN_cant_facturas;';

    SELECT tot_pagar, TO_CHAR(fec_emision,'YYYYMMDD') fec_emision, ind_ordentotal,
	       TO_CHAR(fec_vencimie,'YYYYMMDD') fec_vencimie, cod_ciclfact, imp_saldoant, tot_cuotas
      INTO SN_tot_pagar, SV_fec_emision, SN_ind_ordentotal, SV_fec_vencimie,
	       SN_cod_ciclfact, SN_imp_saldoant, SN_tot_cuotas
      FROM (  SELECT a.tot_pagar, a.fec_emision, a.ind_ordentotal,
	                 a.fec_vencimie, a.cod_ciclfact, a.imp_saldoant, a.tot_cuotas
                FROM fa_histdocu a
               WHERE a.cod_cliente = EN_cod_cliente
            ORDER BY a.fec_emision DESC)
     WHERE ROWNUM = EN_cant_facturas;

	RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 151;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_datos_basicosfactura_fn('||EN_cod_cliente||','||EN_cant_facturas||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_datos_basicosfactura_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_datos_basicosfactura_fn('||EN_cod_cliente||','||EN_cant_facturas||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_datos_basicosfactura_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_datos_basicosfactura_fn;

--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_detfactura_web_pr (
    EN_num_celular     IN              NUMBER,
    EN_num_folio       IN              NUMBER,
    SC_detfactura      OUT NOCOPY      refcursor,
    SN_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      OUT NOCOPY      ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_DETFACTURA_WEB_PR"
      Lenguaje="PL/SQL"
      Fecha="10-06-2005"
      Versión="1.0"
      Diseñador=""Karem Fernandez Ayala"
      Programador="Oscar Jorquera"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta detalle Factura, dependiendo de un número celular y el número de la factura</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
			<param nom="EN_num_folio" Tipo="NUMERICO>Número Factura</param>
         </Entrada>
         <Salida>
			<param nom="SC_detfactura" Tipo="GURSOR" >Cursor con el detalle de la factura</param>
			<param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_cod_tiplan		VARCHAR2(5);
    LN_ind_ordentotal	fa_histdocu.ind_ordentotal%TYPE;
    LN_cod_ciclfact		fa_histdocu.cod_ciclfact%TYPE;
    LV_obs_atencion	    VARCHAR2(60);
    LV_cod_oficina	 	VARCHAR2(10);
    LV_nom_tabla		VARCHAR2(50);
	LV_usuario			VARCHAR2(50):=USER;
    LV_sSql             ge_errores_pg.vQuery;
	LV_des_error        ge_errores_pg.desevent;

    datos_fact_no_enc   EXCEPTION;
    error_datos_fact	EXCEPTION;
    ordentotal_no_enc	EXCEPTION;
    cod_tipoplan_no_enc	EXCEPTION;
    situacion_no_permit	EXCEPTION;
	cod_tipoplan_no_val EXCEPTION;
	error_ejecucion		EXCEPTION;
	error_parametros	EXCEPTION;
BEGIN

 	SN_cod_retorno  := 0;
	SN_num_evento 	:= 0;
	SV_mens_retorno :='';

	OPEN SC_detfactura FOR
	SELECT NULL num_abonado, NULL cod_concepto, NULL des_concepto, NULL minutos,
	       NULL monto, NULL neto, NULL impuesto, NULL descuento, NULL tipo_descuento
	  FROM DUAL
	 WHERE ROWNUM = 0;

	IF (EN_num_folio IS NULL) OR (EN_num_folio = 0) THEN
	    RAISE error_parametros;
	END IF;

	LV_sSql := 'GA_SEGMENTACION_PG.GA_ORIGEN_CLIENTE_PR ('||EN_num_celular ||')';

 	-- Obtiene datos del abonado
	IF NOT ga_segmentacion_pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
 		                                           GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                   GN_cod_prod, GV_nom_responsable, gv_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
    END IF;

	IF (GV_cod_situacion = GV_cod_situacion_AAA or GV_cod_situacion = GV_cod_situacion_SAA) THEN

		-- Verificar si es PostPago o Híbrido
		LV_sSql := 'SELECT cod_tiplan ';
		LV_sSql := LV_sSql ||'INTO LV_cod_tiplan ';
		LV_sSql := LV_sSql ||'FROM ta_plantarif ';
		LV_sSql := LV_sSql ||'WHERE cod_plantarif = SV_cod_plantarif ';

		SELECT cod_tiplan
		INTO LV_cod_tiplan
		FROM ta_plantarif
		WHERE cod_plantarif = GV_cod_plantarif;

 	    IF LV_cod_tiplan IS NOT NULL AND (LV_cod_tiplan = GV_cod_tiplan_post OR LV_cod_tiplan = GV_cod_tiplan_hibr) THEN

			-- obtener la consulta de facturas del cliente

			LV_sSql := 'SELECT ';
			LV_sSql := LV_sSql ||'a.ind_ordentotal,';
			LV_sSql := LV_sSql ||'a.cod_ciclfact';
			LV_sSql := LV_sSql ||'INTO ';
			LV_sSql := LV_sSql ||'LN_ind_ordentotal,';
			LV_sSql := LV_sSql ||'LN_cod_ciclfact ';
			LV_sSql := LV_sSql ||'FROM fa_histdocu a ';
			LV_sSql := LV_sSql ||'WHERE a.cod_cliente = ' ||GN_cod_cliente;
			LV_sSql := LV_sSql ||'AND a.num_folio = EN_num_folio';

			SELECT
				   a.ind_ordentotal,
				   a.cod_ciclfact
			INTO
				   LN_ind_ordentotal,
				   LN_cod_ciclfact
			FROM   fa_histdocu a
			WHERE  a.cod_cliente = GN_cod_cliente
			       AND a.num_folio = EN_num_folio;

			IF LN_ind_ordentotal IS NULL OR LN_cod_ciclfact IS NULL THEN
			   RAISE ordentotal_no_enc;
			ELSE
				BEGIN

				 	LV_nom_tabla := 'FA_HISTCONC_' || LN_cod_ciclfact;

					LV_sSql := ' SELECT e.num_abonado, e.cod_concepto, e.des_concepto, ROUND(e.seg_consumido/60) minutos,'||
						 	   '        (e.imp_facturable + f.imp_facturable + ( NVL(g.imp_facturable, 0))) monto,'||
							   '        e.imp_facturable neto, f.imp_facturable impuesto, NVL(g.imp_facturable, 0) descuento,'||
							   '        e.tip_dto tipo_descuento'||
						   	   '   FROM fad_impgrupos a,'||
						       '        fad_impsubgrupos b,'||
						       '        fad_impconceptos c,'||
						       '        fa_conceptos d, '||
						                LV_nom_tabla ||' e, '||
						                LV_nom_tabla ||' f, '||
						                LV_nom_tabla ||' g'||
						       '  WHERE a.cod_grupo = b.cod_grupo'||
						       '    AND b.cod_subgrupo = c.cod_subgrupo'||
						       '    AND a.cod_formulario = '||GN_cod_formulario||
						       '    AND c.cod_concepto = d.cod_concepto'||
						       ' 	AND d.cod_concepto = e.cod_concepto'||
							   ' 	AND e.cod_tipconce <> '||GN_cod_tipconce_e||
						       ' 	AND e.ind_ordentotal = '||LN_ind_ordentotal||
						       ' 	AND f.ind_ordentotal(+) = '||LN_ind_ordentotal||
						       ' 	AND f.cod_tipconce(+) = '||GN_cod_tipconce_f ||
						       ' 	AND f.cod_concerel(+) = e.cod_concepto'||
						       ' 	AND f.columna_rel(+) = e.columna'||
						       ' 	AND g.ind_ordentotal(+) = '||LN_ind_ordentotal||
						       ' 	AND g.cod_tipconce(+) = '||GN_cod_tipconce_g||
						       ' 	AND g.cod_concerel(+) = e.cod_concepto'||
						       ' 	AND g.columna_rel(+) = e.columna'||
						 	   '  ORDER BY a.num_orden, b.num_orden, c.num_orden';

			   	    OPEN SC_detfactura FOR LV_sSql ;


					EXCEPTION
						WHEN NO_DATA_FOUND THEN
							RAISE datos_fact_no_enc;
						WHEN OTHERS THEN
					 		RAISE error_datos_fact;
				END;
			END IF;
		ELSE
			IF LV_cod_tiplan IS NULL THEN
			   RAISE cod_tipoplan_no_enc;
			ELSE
			   RAISE cod_tipoplan_no_val;
			END IF;
		END IF;
	ELSE
		RAISE situacion_no_permit;
	END IF;

EXCEPTION
   		WHEN error_ejecucion THEN
	        LV_des_error :=SUBSTR('ga_consulta_detfactura_web_pr('||EN_num_celular||','||EN_num_folio||'); - ' || SQLERRM,1,GN_largoerrtec);
        	SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_detfactura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

		WHEN situacion_no_permit THEN
			SN_cod_retorno := 321;
	        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := gv_error_no_clasif;
	        END IF;
	        LV_des_error :=SUBSTR('ga_consulta_detfactura_web_pr('||EN_num_celular||','||EN_num_folio||'); - ' || SQLERRM,1,GN_largoerrtec);
	 		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
	        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_detfactura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

		WHEN cod_tipoplan_no_enc THEN
			SN_cod_retorno := 282;
	        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := gv_error_no_clasif;
	        END IF;
	        LV_des_error :=SUBSTR('ga_consulta_detfactura_web_pr('||EN_num_celular||','||EN_num_folio||'); - ' || SQLERRM,1,GN_largoerrtec);
	 		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
	        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_detfactura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

		WHEN cod_tipoplan_no_val THEN
			SN_cod_retorno := 292;
	        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := gv_error_no_clasif;
	        END IF;
	        LV_des_error :=SUBSTR('ga_consulta_detfactura_web_pr('||EN_num_celular||','||EN_num_folio||'); - ' || SQLERRM,1,GN_largoerrtec);
	 		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
	        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_detfactura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

		WHEN ordentotal_no_enc THEN
			SN_cod_retorno := 200;
	        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := gv_error_no_clasif;
	        END IF;
	        LV_des_error :=SUBSTR('ga_consulta_detfactura_web_pr('||EN_num_celular||','||EN_num_folio||'); - ' || SQLERRM,1,GN_largoerrtec);
	 		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
	        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_detfactura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

		WHEN datos_fact_no_enc THEN
			SN_cod_retorno := 200;
	        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := gv_error_no_clasif;
	        END IF;
	        LV_des_error :=SUBSTR('ga_consulta_detfactura_web_pr('||EN_num_celular||','||EN_num_folio||'); - ' || SQLERRM,1,GN_largoerrtec);
	 		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
	        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_detfactura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

		WHEN error_datos_fact THEN
			SN_cod_retorno := 151;
	        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := gv_error_no_clasif;
	        END IF;
	        LV_des_error :=SUBSTR('ga_consulta_detfactura_web_pr('||EN_num_celular||','||EN_num_folio||'); - ' || SQLERRM,1,GN_largoerrtec);
	 		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
	        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_detfactura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

        WHEN error_parametros THEN
     	  SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := GV_error_no_clasif;
      	  END IF;
	        LV_des_error :=SUBSTR('ga_consulta_detfactura_web_pr('||EN_num_celular||','||EN_num_folio||'); - ' || SQLERRM,1,GN_largoerrtec);
	 		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
	        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_detfactura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

		WHEN OTHERS THEN
			SN_cod_retorno := GV_error_others;
	        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := gv_error_no_clasif;
	        END IF;
	        LV_des_error :=SUBSTR('ga_consulta_detfactura_web_pr('||EN_num_celular||','||EN_num_folio||'); - ' || SQLERRM,1,GN_largoerrtec);
	 		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
	        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, gv_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_detfactura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_detfactura_web_pr;

--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_factura_touch_pr (
    EN_num_celular    IN    NUMBER,
	SV_fec_ini  	 OUT    NOCOPY VARCHAR2,
    SV_fec_fin		 OUT    NOCOPY VARCHAR2,
	SV_fec_emision 	 OUT    NOCOPY VARCHAR2,
    SV_fec_vencimie	 OUT    NOCOPY VARCHAR2,
	SV_fec_susp 	 OUT    NOCOPY VARCHAR2,
    SN_saldo_ant	 OUT    NOCOPY NUMBER,
	SN_saldo_act	 OUT    NOCOPY NUMBER,
	SN_ult_pago		 OUT    NOCOPY NUMBER,
    SN_tot_iptos	 OUT    NOCOPY NUMBER,
    SN_tot_dctos	 OUT    NOCOPY NUMBER,
    SN_tot_cargos	 OUT    NOCOPY NUMBER,
    SN_tot_cargosme  OUT    NOCOPY NUMBER,
    SN_tot_cuotas	 OUT    NOCOPY NUMBER,
    SN_tot_pagar	 OUT    NOCOPY NUMBER,
	SN_cod_retorno   OUT    NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT    NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT    NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_FACTURA_TOUCH_PR"
      Lenguaje="PL/SQL"
      Fecha="15-06-2005"
      Versión="1.0"
      Diseñador="Carlos Navarro H."
      Programador="Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera informacion de la ültima factura de un cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_fec_ini" Tipo="CARACTER">Fecha de Inicio de Llamadas</param>
			<param nom="SV_fec_fin" Tipo="CARACTER">Fecha de Fin de Llamadas</param>
			<param nom="SV_fec_emision" Tipo="CARACTER">Fecha de Emision del Documento</param>
			<param nom="SV_fec_vencimie" Tipo="CARACTER">Fecha de Vencimiento del Documento</param>
			<param nom="SV_fec_susp " Tipo="CARACTER">Fecha de Suspension</param>
			<param nom="SN_saldo_ant" Tipo="NUMERICO">Saldo Anterior</param>
			<param nom="SN_saldo_act" Tipo="NUMERICO">Saldo Actual</param>
			<param nom="SN_ult_pago" Tipo="NUMERICO">Ultimo Pago</param>
			<param nom="SN_tot_iptos" Tipo="NUMERICO">Total de Impuesto</param>
			<param nom="SN_tot_dctos" Tipo="NUMERICO">Total de Descuentos</param>
			<param nom="SN_tot_cargos" Tipo="NUMERICO">Total de Cargos</param>
			<param nom="SN_tot_cargosme" Tipo="NUMERICO">Total Cargos del Mes</param>
			<param nom="SN_tot_cuotas" Tipo="NUMERICO">Total Cuotas</param>
			<param nom="SN_tot_pagar" Tipo="NUMERICO">Total a Pagar</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql            ge_errores_pg.vQuery;
	LN_ind_ordentotal  fa_histdocu.ind_ordentotal%type;
	LN_cod_ciclfact	   fa_histdocu.cod_ciclfact%type;
    LN_cod_ciclo	   fa_ciclfact.cod_ciclo%type;
    LN_dia_periodo	   fa_ciclfact.dia_periodo%type;
    LN_ind_tasador	   fa_ciclfact.ind_tasador%type;
    LN_cod_forpago	   co_pagos.cod_forpago%type;
    LN_cod_sispago	   co_pagos.cod_sispago%type;
    LV_cod_banco	   co_pagos.cod_banco%type;
    LV_cod_tiptarjeta  co_pagos.cod_tiptarjeta%type;
    LV_cod_sucursal	   co_pagos.cod_sucursal%type;
    LV_cta_corriente   co_pagos.cta_corriente%type;
    LV_num_tarjeta	   co_pagos.num_tarjeta%type;
    LV_des_pago		   co_pagos.des_pago%type;
    LV_pref_plaza	   co_pagos.pref_plaza%type;
	LN_cod_atencion	   NUMBER;
	LV_obs_atencion	   VARCHAR2(100);
	LN_cant_facturas   NUMBER;
    LN_cant_pagos	   NUMBER;

	error_ejecucion    EXCEPTION;
	error_abonado      EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';
	LN_cant_facturas:= 1;
	LN_cant_pagos  := 1;
	LN_cod_atencion:= 514;

	-- Se Obtienen datos del abonado
    IF NOT ga_segmentacion_pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                                   GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                   GN_cod_prod, GV_nom_responsable, gv_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
        RAISE error_ejecucion;
    END IF;

    -- Se válida que el cliente no sea de Prepago
    IF GV_tip_abonado = CV_prepago THEN
        RAISE error_abonado;
    END IF;

	-- Se obtiene los datos basicos de la factura
	IF NOT ga_datos_basicosfactura_fn(GN_cod_cliente,LN_cant_facturas,SN_tot_pagar,SV_fec_emision,
	                                  LN_ind_ordentotal,SV_fec_vencimie,LN_cod_ciclfact,SN_saldo_ant,
									  SN_tot_cuotas,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
	    RAISE error_ejecucion;
	END IF;

	-- Se obtienen datos del ciclo de facturacion
	IF NOT ga_datos_basicosciclo_fn(LN_cod_ciclfact,SV_fec_ini,SV_fec_fin,LN_cod_ciclo,LN_dia_periodo,LN_ind_tasador,
	                                SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		RAISE error_ejecucion;
	END IF;

	-- Se obtiene el ultimo pago del cliente (si es que se tiene)
	IF NOT ga_recupera_ultimopago_fn(GN_cod_cliente,SN_ult_pago,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		RAISE error_ejecucion;
	END IF;

	-- Se obtiene la fecha de suspencion (si es que se encuentra suspendido)
	IF NOT ga_recupera_fecsuspension_fn(GN_cod_cliente,SV_fec_susp,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
	    RAISE error_ejecucion;
	END IF;

	-- Se obtiene el saldo actual del cliente (si es que se tiene)
	IF NOT ga_recupera_saldocliente_fn(GN_cod_cliente,SN_saldo_act,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
	    RAISE error_ejecucion;
	END IF;

	-- Se obtienen los conceptos de la factura (Impuestos, Descuentos, Cargos)
	-- IMPUESTOS
	IF NOT ga_recupera_montoconcepto_fn(LN_ind_ordentotal,LN_cod_ciclfact,1,SN_tot_iptos,
	                                    SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		RAISE error_ejecucion;
	END IF;
	-- DESCUENTOS
	IF NOT ga_recupera_montoconcepto_fn(LN_ind_ordentotal,LN_cod_ciclfact,2,SN_tot_dctos,
	                                    SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		RAISE error_ejecucion;
	END IF;
	-- CARGOS
	IF NOT ga_recupera_montoconcepto_fn(LN_ind_ordentotal,LN_cod_ciclfact,3,SN_tot_cargos,
	                                    SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		RAISE error_ejecucion;
	END IF;
	-- TOTAL CARGOS DEL MES
	SN_tot_cargosme := SN_tot_iptos + SN_tot_dctos + SN_tot_cargos;

    -- Registro de atención del Cliente
    LV_obs_atencion := 'Se atendió al Celular ' || EN_num_celular;
    ga_segmentacion_pg.ga_reg_atencion_cliente_pr(EN_num_celular, LN_cod_atencion, LV_obs_atencion, USER, SN_cod_retorno , SV_mens_retorno, SN_num_evento );
    IF SN_cod_retorno <> 0 THEN
	    RAISE error_ejecucion;
    END IF;

EXCEPTION

    WHEN error_ejecucion THEN
        LV_des_error := 'ga_consulta_factura_touch_pr('||EN_num_celular||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_factura_touch_pr', LV_sSql, SN_cod_retorno, LV_des_error );

    WHEN error_abonado THEN
        SN_cod_retorno := 318;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := GV_error_no_clasif;
        END IF;
        LV_des_error := 'ga_consulta_factura_touch_pr('||EN_num_celular||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_factura_touch_pr', LV_sSql, SN_cod_retorno, LV_des_error );

    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := GV_error_no_clasif;
        END IF;
        LV_des_error := 'ga_consulta_factura_touch_pr('||EN_num_celular||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_factura_touch_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_factura_touch_pr;
--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_factura_web_pr (
    EN_num_celular     IN              NUMBER,
    SC_factura         OUT NOCOPY      refcursor,
    SN_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      OUT NOCOPY      ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_FACTURA_WEB_PR"
      Lenguaje="PL/SQL"
      Fecha="10-06-2005"
      Versión="1.0"
      Diseñador="Karem Fernandez Ayala"
      Programador="Karem Fernandez Ayala"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta detalle Factura, dependiendo de un número celular y el número de la factura</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SC_factura" Tipo="GURSOR" >Cursor de las facturas</param>
			<param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_cod_tiplan		  VARCHAR2(5);
    LN_ind_ordentotal	  fa_histdocu.ind_ordentotal%TYPE;
    LN_cod_ciclfact		  fa_histdocu.cod_ciclfact%TYPE;
    LV_obs_atencion	      VARCHAR2(60);
    LV_nom_tabla		  VARCHAR2(50);
	LV_usuario			  VARCHAR2(50):=USER;
	LV_des_error          ge_errores_pg.desevent;
    LV_sSql                  ge_errores_pg.vQuery;

	error_carga_datoscli  EXCEPTION;
	no_hibrido_ni_post	  EXCEPTION;

BEGIN

 	SN_cod_retorno  := 0;
	SV_mens_retorno := '';
	SN_num_evento 	:= 0;

	OPEN SC_factura FOR
	SELECT NULL imp_saldoant, NULL num_folio, NULL cod_tipdocum, NULL des_tipdocum,
               NULL fec_emision, NULL fec_vencimie, NULL tot_factura, NULL tot_pagar, NULL acum_iva,
               NULL tot_descuento, NULL tot_cargosme, NULL fec_desdellam, NULL fec_hastallam,
               NULL cod_ciclfact, NULL cod_cliente
          FROM DUAL
         WHERE ROWNUM = 0;

	-- Se Obtienen datos del abonado
    IF NOT ga_segmentacion_pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                                   GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                   GN_cod_prod, GV_nom_responsable, gv_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
        RAISE error_carga_datoscli;
    END IF;

    -- Se válida que el cliente no sea de Prepago
    IF GV_tip_abonado = CV_prepago THEN
        RAISE no_hibrido_ni_post;
    END IF;

	    OPEN SC_factura FOR
      SELECT a.imp_saldoant, a.num_folio, a.cod_tipdocum, c.des_tipdocum,
             a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
             a.tot_descuento, a.tot_cargosme, d.fec_desdellam, d.fec_hastallam,
             a.cod_ciclfact, a.cod_cliente
        FROM fa_histdocu a, fa_tipdocumen b, ge_tipdocumen c, fa_ciclfact d
       WHERE a.cod_tipdocum = b.cod_tipdocum
      	 AND a.cod_tipdocum = c.cod_tipdocum
       	 AND b.cod_tipdocummov = c.cod_tipdocum
       	 AND a.cod_ciclfact = d.cod_ciclfact
       	 AND a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener)
         AND a.cod_cliente = GN_cod_cliente
         AND a.fec_emision > SYSDATE - 120
    ORDER BY a.fec_emision DESC;

EXCEPTION

	WHEN no_hibrido_ni_post THEN
		 SN_cod_retorno := 318;
	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	        SV_mens_retorno := gv_error_no_clasif;
	     END IF;
	     LV_des_error := SUBSTR('ga_consulta_factura_web_pr('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
	 	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
	     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_factura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	WHEN error_carga_datoscli THEN
	     LV_des_error := SUBSTR('ga_consulta_factura_web_pr('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
	     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_factura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	WHEN OTHERS THEN
		 SN_cod_retorno := GV_error_others;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := gv_error_no_clasif;
         END IF;
         LV_des_error := SUBSTR('ga_consulta_factura_web_pr('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
 		 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_facturas_pg.ga_consulta_factura_web_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_factura_web_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ga_facturas_pg;
/
SHOW ERRORS
