CREATE OR REPLACE PACKAGE BODY GA_REGISTRO_ACCESO_PG
IS

-------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_ingreso_evento_fn (
      EM_tabla                   IN  	 tip_ga_desc_evento_td,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "ga_ingreso_evento_fn" Lenguaje="PL/SQL" Fecha="12-04-2007" Versión="La misma del package" Diseñador="Jorge Marin M." Programador="German Saavedra" Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Registra nuevos eventos a auditar</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EM_tabla" Tipo="Tabla"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_sqlcode Tipo="ge_errores_td.cod_msgerror%type">Código de Error SQL</param>
        <param nom="SV_sqlerrm Tipo="ge_errores_td.det_msgerror%type">Descripción de Error SQL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

NO_EXISTE_DATOS      	 EXCEPTION;

BEGIN

	    IF EM_tabla.COUNT = 0 THEN
		      RAISE NO_EXISTE_DATOS;
		ELSE
	        FORALL i IN 1..EM_tabla.COUNT
            INSERT INTO ga_desc_evento_td VALUES EM_tabla (i);
        END IF;

	    RETURN TRUE ;

EXCEPTION
   WHEN NO_EXISTE_DATOS THEN
      SV_sqlcode := 6671;
	  SV_sqlerrm := 'No existe eventos nuevos que registrar';
      RETURN FALSE;
   WHEN OTHERS THEN
      SV_sqlcode := SQLCODE;
	  SV_sqlerrm := SQLERRM;
      RETURN FALSE;

END ga_ingreso_evento_fn;

-------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_evento_fn (
      EM_tabla                   IN OUT  NOCOPY tip_ga_desc_evento_td,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "ga_modifica_evento_fn" Lenguaje="PL/SQL" Fecha="12-04-2007" Versión="La misma del package" Diseñador="Jorge Marin M." Programador="German Saavedra" Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Registra nuevos eventos a auditar</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EM_tabla" Tipo="Tabla"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_sqlcode Tipo="ge_errores_td.cod_msgerror%type">Código de Error SQL</param>
        <param nom="SV_sqlerrm Tipo="ge_errores_td.det_msgerror%type">Descripción de Error SQL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

NO_EXISTE_DATOS      	 EXCEPTION;
LV_cod_evento 			 ga_desc_evento_td.cod_evento%type;
BEGIN

	    LV_cod_evento := EM_Tabla(1).cod_evento;

		SELECT  g.cod_evento
			   ,g.cod_modulo
			   ,g.cod_programa
			   ,g.cod_proceso
			   ,g.des_objeto
	    BULK COLLECT INTO EM_Tabla
		FROM   ga_desc_evento_td g
		WHERE  g.cod_evento    = LV_cod_evento;


	    IF EM_tabla.COUNT = 0 THEN
		      RAISE NO_EXISTE_DATOS;
		END IF;

	    RETURN TRUE ;

EXCEPTION
   WHEN NO_EXISTE_DATOS THEN
      SV_sqlcode := 6671;
	  SV_sqlerrm := 'No existe eventos que modificar';
      RETURN FALSE;
   WHEN OTHERS THEN
      SV_sqlcode := SQLCODE;
	  SV_sqlerrm := SQLERRM;
      RETURN FALSE;

END ga_recupera_evento_fn;

-------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_modifica_evento_fn (
      EM_tabla                   IN  	 tip_ga_desc_evento_td,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "ga_modifica_evento_fn" Lenguaje="PL/SQL" Fecha="12-04-2007" Versión="La misma del package" Diseñador="Jorge Marin M." Programador="German Saavedra" Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Registra nuevos eventos a auditar</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EM_tabla" Tipo="Tabla"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_sqlcode Tipo="ge_errores_td.cod_msgerror%type">Código de Error SQL</param>
        <param nom="SV_sqlerrm Tipo="ge_errores_td.det_msgerror%type">Descripción de Error SQL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

NO_EXISTE_DATOS      	 EXCEPTION;

BEGIN

	    IF EM_tabla.COUNT = 0 THEN
		      RAISE NO_EXISTE_DATOS;
		ELSE
	        FOR i IN 1..EM_tabla.COUNT LOOP
				UPDATE ga_desc_evento_td
				SET
	   			 cod_modulo    = EM_Tabla(i).cod_modulo
				,cod_programa  = EM_Tabla(i).cod_programa
				,cod_proceso   = EM_Tabla(i).cod_proceso
				,des_objeto    = EM_Tabla(i).des_objeto
				WHERE  cod_evento    = EM_Tabla(i).cod_evento;
		    END LOOP;
        END IF;


	    RETURN TRUE ;

EXCEPTION
   WHEN NO_EXISTE_DATOS THEN
      SV_sqlcode := 6671;
	  SV_sqlerrm := 'No existe eventos que modificar';
      RETURN FALSE;
   WHEN OTHERS THEN
      SV_sqlcode := SQLCODE;
	  SV_sqlerrm := SQLERRM;
      RETURN FALSE;

END ga_modifica_evento_fn;
-------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_registra_acceso_usuario_fn (
      EM_tabla                   IN  	 tip_ga_traza_usuario_to,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "ga_registra_acceso_usuario_fn" Lenguaje="PL/SQL" Fecha="12-04-2007" Versión="La misma del package" Diseñador="Jorge Marin M." Programador="German Saavedra" Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Registra nuevos eventos a auditar</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EM_tabla" Tipo="Tabla"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_sqlcode Tipo="ge_errores_td.cod_msgerror%type">Código de Error SQL</param>
        <param nom="SV_sqlerrm Tipo="ge_errores_td.det_msgerror%type">Descripción de Error SQL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
BEGIN
	        FORALL i IN 1..EM_tabla.COUNT
            INSERT INTO ga_traza_usuario_to VALUES EM_tabla (i);

	   		 RETURN TRUE ;
EXCEPTION
   WHEN OTHERS THEN
      SV_sqlcode := SQLCODE;
	  SV_sqlerrm := SQLERRM;
      RETURN FALSE;
END ga_registra_acceso_usuario_fn;




-------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_registra_acceso_usuario_pr (
	  EV_cod_evento				 IN             ga_traza_usuario_to.cod_evento%TYPE,
	  EV_tip_entidad			 IN             ga_traza_usuario_to.tip_entidad%TYPE,
	  EN_val_entidad			 IN             ga_traza_usuario_to.val_entidad%TYPE,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "ga_registra_acceso_usuario_pr" Lenguaje="PL/SQL" Fecha="12-04-2007" Versión="La misma del package" Diseñador="Jorge Marin M." Programador="German Saavedra" Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Registra nuevos eventos a auditar</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EM_tabla" Tipo="Tabla"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_sqlcode Tipo="ge_errores_td.cod_msgerror%type">Código de Error SQL</param>
        <param nom="SV_sqlerrm Tipo="ge_errores_td.det_msgerror%type">Descripción de Error SQL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

  EM_tabla tip_ga_traza_usuario_to;
  LN_num_correl NUMBER;
  error  EXCEPTION;
BEGIN
	 SELECT ge_trza_sq.NEXTVAL INTO  LN_num_correl FROM DUAL;
	 EM_tabla(1).num_correl  := LN_num_correl;
	 EM_tabla(1).cod_evento  := EV_cod_evento;
	 EM_tabla(1).tip_entidad := EV_tip_entidad;
	 EM_tabla(1).val_entidad := EN_val_entidad;
	 EM_tabla(1).nom_usuario := User;
	 EM_tabla(1).fec_audit	 := sysdate;

	 IF ga_registra_acceso_usuario_fn(EM_tabla,SV_sqlcode,SV_sqlerrm) THEN
	 	SV_sqlcode := 0;
		SV_sqlerrm := '';
	 ELSE
	   RAISE error;
	 END IF;

EXCEPTION
   WHEN OTHERS THEN
      SV_sqlcode := SQLCODE;
	  SV_sqlerrm := SQLERRM;
END ga_registra_acceso_usuario_pr;

-------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_historico_acceso_usuario_fn (
      EM_tabla                   IN  	 tip_ga_traza_usuario_th,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "ga_registra_acceso_usuario_fn" Lenguaje="PL/SQL" Fecha="12-04-2007" Versión="La misma del package" Diseñador="Jorge Marin M." Programador="German Saavedra" Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Registra nuevos eventos a auditar</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EM_tabla" Tipo="Tabla"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_sqlcode Tipo="ge_errores_td.cod_msgerror%type">Código de Error SQL</param>
        <param nom="SV_sqlerrm Tipo="ge_errores_td.det_msgerror%type">Descripción de Error SQL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

BEGIN
	        FORALL i IN 1..EM_tabla.COUNT
            INSERT INTO ga_traza_usuario_th VALUES EM_tabla (i);

	   		 RETURN TRUE ;
EXCEPTION
   WHEN OTHERS THEN
      SV_sqlcode := SQLCODE;
	  SV_sqlerrm := SQLERRM;
      RETURN FALSE;
END ga_historico_acceso_usuario_fn;
-------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_elimina_registro_actual_fn (
	  ED_FechaIni                IN             ga_traza_usuario_to.fec_audit%type,
	  ED_FechaFin                IN             ga_traza_usuario_to.fec_audit%type,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%type,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%type
) RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "gga_recupera_registro_actual_fn" Lenguaje="PL/SQL" Fecha="12-04-2007" Versión="La misma del package" Diseñador="Jorge Marin M." Programador="German Saavedra" Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Registra nuevos eventos a auditar</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EM_tabla" Tipo="Tabla"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_sqlcode Tipo="ge_errores_td.cod_msgerror%type">Código de Error SQL</param>
        <param nom="SV_sqlerrm Tipo="ge_errores_td.det_msgerror%type">Descripción de Error SQL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/



NO_EXISTE_DATOS      	 EXCEPTION;
LD_fec_audit_ini		 ga_traza_usuario_to.fec_audit%type;
LD_fec_audit_fin		 ga_traza_usuario_to.fec_audit%type;
BEGIN

		LD_fec_audit_ini := ED_FechaIni;
		LD_fec_audit_fin := ED_FechaFin;

			DELETE FROM   ga_traza_usuario_to g
			WHERE g.fec_audit     BETWEEN NVL(LD_fec_audit_ini,g.fec_audit) AND  nvl(LD_fec_audit_fin,sysdate);

	    RETURN TRUE ;

EXCEPTION
   WHEN OTHERS THEN
      SV_sqlcode := SQLCODE;
	  SV_sqlerrm := SQLERRM;
      RETURN FALSE;

END ga_elimina_registro_actual_fn;
-------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_registro_actual_fn (
      EM_tabla                   IN OUT  NOCOPY tip_ga_traza_usuario_to,
	  ED_FechaFin                IN             ga_traza_usuario_to.fec_audit%type,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%type,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%type
) RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "gga_recupera_registro_actual_fn" Lenguaje="PL/SQL" Fecha="12-04-2007" Versión="La misma del package" Diseñador="Jorge Marin M." Programador="German Saavedra" Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Registra nuevos eventos a auditar</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EM_tabla" Tipo="Tabla"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_sqlcode Tipo="ge_errores_td.cod_msgerror%type">Código de Error SQL</param>
        <param nom="SV_sqlerrm Tipo="ge_errores_td.det_msgerror%type">Descripción de Error SQL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/



NO_EXISTE_DATOS      	 EXCEPTION;
LV_cod_evento 			 ga_traza_usuario_to.cod_evento%type;
LV_nom_usuario			 ga_traza_usuario_to.nom_usuario%type;
LV_tip_entidad			 ga_traza_usuario_to.tip_entidad%type;
LN_val_entidad			 ga_traza_usuario_to.val_entidad%type;
LD_fec_audit_ini		 ga_traza_usuario_to.fec_audit%type;
LD_fec_audit_fin		 ga_traza_usuario_to.fec_audit%type;
BEGIN

		LV_cod_evento 	 := EM_Tabla(1).cod_evento;
		LV_nom_usuario	 := EM_Tabla(1).nom_usuario;
		LV_tip_entidad	 := EM_Tabla(1).tip_entidad;
		LN_val_entidad	 := EM_Tabla(1).val_entidad;
		LD_fec_audit_ini := EM_Tabla(1).fec_audit;
		LD_fec_audit_fin := ED_FechaFin;

			SELECT  g.num_correl
					,g.cod_evento
					,g.nom_usuario
					,g.tip_entidad
					,g.val_entidad
					,g.fec_audit
			BULK COLLECT INTO EM_Tabla
			FROM   ga_traza_usuario_to g
			WHERE g.cod_evento    = NVL(LV_cod_evento ,g.cod_evento )
			AND   g.nom_usuario   = NVL(LV_nom_usuario,g.nom_usuario)
			AND   g.tip_entidad   = NVL(LV_tip_entidad,g.tip_entidad)
			AND   g.val_entidad   = NVL(LN_val_entidad,g.val_entidad)
			AND   g.fec_audit     BETWEEN NVL(LD_fec_audit_ini,g.fec_audit) AND  nvl(LD_fec_audit_fin,sysdate);


        IF EM_tabla.COUNT = 0 THEN
		      RAISE NO_EXISTE_DATOS;
		END IF;

	    RETURN TRUE ;

EXCEPTION
   WHEN NO_EXISTE_DATOS THEN
      SV_sqlcode := 6671;
	  SV_sqlerrm := 'No existen registro según criterio ingresado';
      RETURN FALSE;
   WHEN OTHERS THEN
      SV_sqlcode := SQLCODE;
	  SV_sqlerrm := SQLERRM;
      RETURN FALSE;

END ga_recupera_registro_actual_fn;

-------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_historico_acceso_usuario_pr (
	  EM_tabla			         IN OUT  NOCOPY tip_ga_traza_usuario_to,
	  ED_FechaFin                IN             ga_traza_usuario_to.fec_audit%type,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) IS
/*
<Documentación TipoDoc = "function">
<Elemento Nombre = "ga_historico_acceso_usuario_pr" Lenguaje="PL/SQL" Fecha="12-04-2007" Versión="La misma del package" Diseñador="Jorge Marin M." Programador="German Saavedra" Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Registra nuevos eventos a auditar</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EM_tabla" Tipo="Tabla"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_sqlcode Tipo="ge_errores_td.cod_msgerror%type">Código de Error SQL</param>
        <param nom="SV_sqlerrm Tipo="ge_errores_td.det_msgerror%type">Descripción de Error SQL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

  EM_tabla_hist tip_ga_traza_usuario_th;
  ED_FechaIni   ga_traza_usuario_to.fec_audit%type;
  LN_num_correl NUMBER;
  error  EXCEPTION;
BEGIN
	 ED_FechaIni :=EM_tabla(1).fec_audit;

 	 IF ga_recupera_registro_actual_fn(EM_tabla,ED_FechaFin,SV_sqlcode,SV_sqlerrm) THEN
	 	FOR i IN 1..EM_tabla.count LOOP
	     	EM_tabla_hist(i).num_correl  := EM_tabla(i).num_correl  ;
		 	EM_tabla_hist(i).cod_evento  := EM_tabla(i).cod_evento  ;
		 	EM_tabla_hist(i).tip_entidad := EM_tabla(i).tip_entidad ;
		 	EM_tabla_hist(i).val_entidad := EM_tabla(i).val_entidad ;
		 	EM_tabla_hist(i).nom_usuario := EM_tabla(i).nom_usuario ;
		 	EM_tabla_hist(i).fec_audit   := EM_tabla(i).fec_audit	 ;
			EM_tabla_hist(i).fec_hist    := sysdate;
 	    END LOOP;

   	    IF  ga_historico_acceso_usuario_fn(EM_tabla_hist,SV_sqlcode,SV_sqlerrm) THEN
		 	IF  ga_elimina_registro_actual_fn(ED_FechaIni,ED_FechaFin,SV_sqlcode,SV_sqlerrm) THEN
				SV_sqlcode := 0;
				SV_sqlerrm := '';
			ELSE
			   RAISE error;
			END IF;
		 ELSE
		   RAISE error;
		 END IF;
	 ELSE
	   RAISE error;
	 END IF;


EXCEPTION
   WHEN error THEN
    NULL;
   WHEN OTHERS THEN
      SV_sqlcode := SQLCODE;
	  SV_sqlerrm := SQLERRM;
END ga_historico_acceso_usuario_pr;

END GA_REGISTRO_ACCESO_PG;
/
SHOW ERRORS