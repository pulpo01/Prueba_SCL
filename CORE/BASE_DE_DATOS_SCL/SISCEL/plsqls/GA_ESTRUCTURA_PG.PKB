CREATE OR REPLACE PACKAGE BODY          "GA_ESTRUCTURA_PG" 
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CREA_DIRECCION_PR(EV_cod_provincia IN GE_DIRECCIONES.COD_PROVINCIA%TYPE,
							EV_cod_region 	    IN GE_DIRECCIONES.COD_REGION%TYPE,
							EV_cod_ciudad	    IN GE_DIRECCIONES.COD_CIUDAD%TYPE,
                            EV_cod_comuna       IN ge_direcciones.cod_comuna%TYPE,
                            EV_nom_calle        IN ge_direcciones.nom_calle%TYPE,
                            EV_num_calle        IN ge_direcciones.num_calle%TYPE,
                            EV_num_piso         IN ge_direcciones.num_piso%TYPE,
                            EV_num_casilla      IN ge_direcciones.num_casilla%TYPE,
  						    SN_cod_direccion    OUT NOCOPY ge_direcciones.cod_direccion%TYPE,
							SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                            SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
						   )

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CREA_DIRECCION_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Crear una direccion </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_provincia" Tipo="CARACTER">Codigo de Provincia</param>
            <param nom="EV_cod_region" Tipo="CARACTER">Codigo de Region</param>
            <param nom="EV_cod_cuidad" Tipo="CARACTER">Codigo de Cuidad</param>
            <param nom="EV_cod_comuna" Tipo="CARACTER">Codigo de Comuna</param>
            <param nom="EV_nom_calle" Tipo="CARACTER">Nombre de la Calle</param>
            <param nom="EV_num_calle" Tipo="CARACTER">Piso y departamento</param>
            <param nom="EV_num_piso" Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_num_casilla" Tipo="CARACTER">Numero de la casilla</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_direccion"     Tipo="NUMERICO">Codigo de la direccion</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
      V_des_error      ge_errores_pg.DesEvent;
      sSql             ge_errores_pg.vQuery;

BEGIN
        sSql:=NULL;
		SN_cod_direccion:=NULL;
		SN_cod_retorno := '0';
   		SN_num_evento  := 0;
		--Obtener secuencia
		sSql:='SELECT CI_SEQ_NUMATTECLI.NEXTVAL  FROM DUAL';
        SELECT CI_SEQ_NUMATTECLI.NEXTVAL INTO SN_cod_direccion FROM DUAL;

		sSql:=SUBSTR('INSERT INTO GE_DIRECCIONES(COD_DIRECCION, COD_PROVINCIA, COD_REGION,'||
		      ' COD_CIUDAD,COD_COMUNA,NOM_CALLE, NUM_CALLE, NUM_PISO,'||
		      '	 NUM_CASILLA)  VALUES ('||
		      SN_cod_direccion||','||EV_cod_provincia||','||
		      EV_cod_region||','||EV_cod_ciudad||','||EV_cod_comuna||','||EV_nom_calle||','||
		      EV_num_calle||','||EV_num_piso||','||EV_num_casilla||')',1,CN_largoquery);
	    INSERT INTO GE_DIRECCIONES (COD_DIRECCION, COD_PROVINCIA, COD_REGION, COD_CIUDAD,
	 			 				 COD_COMUNA,NOM_CALLE, NUM_CALLE, NUM_PISO,
								 NUM_CASILLA)
         VALUES	(SN_cod_direccion, EV_cod_provincia, EV_cod_region, EV_cod_ciudad,
			  			 		 EV_cod_comuna, EV_nom_calle, EV_num_calle,EV_num_piso,
								 EV_num_casilla);
EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := '302';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error :=SUBSTR('Others:  GA_CREA_DIRECCION_PR('||EV_cod_provincia || ',' || EV_cod_region || ',' || EV_cod_ciudad || ',' || EV_cod_comuna || ',' || EV_nom_calle || ',' ||
		  EV_num_calle || ',' || EV_num_piso || ',' ||EV_num_casilla||'); - ' || SQLERRM,1,CN_largoerrtec);
    	SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_CREA_DIRECCION_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;

END GA_CREA_DIRECCION_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CREA_DIRECCION_CLIENTE_PR(EN_cod_cliente      IN  ge_clientes.cod_cliente%TYPE,
                                       EV_cod_tipdireccion IN  ga_direccli.cod_tipdireccion%TYPE,
  						    		   EN_cod_direccion    IN  ge_direcciones.cod_direccion%TYPE,
									   SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                            		   SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                            		   SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CREA_DIRECCION_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Crear una direccion para el cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del cliente</param>
            <param nom="EV_cod_tipdireccion" Tipo="CARACTER">Codigo del tipo de dirección</param>
            <param nom="EN_cod_direccion" Tipo="NUMERICO">Codigo de la direccion</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
      V_des_error      ge_errores_pg.DesEvent;
      sSql             ge_errores_pg.vQuery;

BEGIN
        sSql:=NULL;
		SN_cod_retorno := '0';
   		SN_num_evento  := 0;

		sSql:='INSERT INTO GA_DIRECCLI(COD_CLIENTE, COD_TIPDIRECCION, COD_DIRECCION) '||
		 	  ' VALUES('||EN_cod_cliente||','||EV_cod_tipdireccion||','||EN_cod_direccion||');';
		INSERT INTO GA_DIRECCLI(COD_CLIENTE, COD_TIPDIRECCION, COD_DIRECCION)
 		VALUES (EN_cod_cliente,EV_cod_tipdireccion,EN_cod_direccion);


EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := '302';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error:=SUBSTR('Others:  GA_CREA_DIRECCION_CLIENTE_PR('||EN_cod_cliente||','||EV_cod_tipdireccion||','||EN_cod_direccion||'); - ' || SQLERRM,1,CN_largoerrtec);
    	SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_CREA_DIRECCION_CLIENTE_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;
END GA_CREA_DIRECCION_CLIENTE_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ASOCIA_RESPONSABLE_PR(EN_cod_cliente    IN  ge_clientes.cod_cliente%TYPE,
                                   EV_cod_tipident	 IN  GE_CLIENTES.COD_TIPIDENT%TYPE,
 		  						   EV_num_ident	     IN  GE_CLIENTES.NUM_IDENT%TYPE,
   								   EV_nom_cliente 	 IN  GE_CLIENTES.NOM_CLIENTE%TYPE,
   								   EV_nom_apeclien1  IN  GE_CLIENTES.NOM_APECLIEN1%TYPE,
   								   EV_nom_apeclien2  IN  GE_CLIENTES.NOM_APECLIEN2%TYPE,
								   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                            	   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                            	   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ASOCIA_RESPONSABLE_PR"
      Lenguaje="PL/SQL"
      Fecha="21-06-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Ascciar responsable de la cuenta</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del cliente</param>
            <param nom="EV_cod_tipident"   Tipo="CARACTER">Código de identificación</param>
            <param nom="EV_num_ident"   Tipo="CARACTER">Número de identificación</param>
            <param nom="EV_nom_cliente"    Tipo="CARACTER">Nombre de Cliente</param>
            <param nom="EV_nom_apeclien1"    Tipo="CARACTER">Primer apellido</param>
            <param nom="EV_nom_apeclien2"    Tipo="CARACTER">Segundo apellido</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
      V_des_error      ge_errores_pg.DesEvent;
      sSql             ge_errores_pg.vQuery;
	  LV_nombre		   ga_respclientes.nom_responsable%TYPE;

BEGIN
        sSql:=NULL;
		SN_cod_retorno:=0;
   		SN_num_evento:=0;

		LV_nombre:=SUBSTR(EV_nom_cliente||' '||EV_nom_apeclien1||' '||EV_nom_apeclien2,1,50);
		sSql:=SUBSTR('INSERT INTO GA_RESPCLIENTES(COD_CLIENTE,NUM_ORDEN,COD_TIPIDENT,NUM_IDENT,NOM_RESPONSABLE)'||
			  ' VALUES('||EN_cod_cliente||',1,'||EV_cod_tipident||','||EV_num_ident||','||LV_nombre||');',1,CN_largoquery);

		INSERT INTO GA_RESPCLIENTES(COD_CLIENTE,NUM_ORDEN,
		      COD_TIPIDENT,NUM_IDENT,NOM_RESPONSABLE)
	    VALUES(EN_cod_cliente,1,
			   EV_cod_tipident,EV_num_ident,LV_nombre);

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := '302';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
		V_des_error:=SUBSTR('INSERT INTO GA_RESPCLIENTES(COD_CLIENTE,NUM_ORDEN,COD_TIPIDENT,NUM_IDENT,NOM_RESPONSABLE)'||
			  ' VALUES('||EN_cod_cliente||',1,'||EV_cod_tipident||','||EV_num_ident||','||LV_nombre||');- ' || SQLERRM,1,CN_largoquery);
    	SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_ASOCIA_CATIMPCLIENTES_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;
END GA_ASOCIA_RESPONSABLE_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ASOCIA_CATRIBUTCLIE_PR(EN_cod_cliente      IN  ge_clientes.cod_cliente%TYPE,
				 			        EV_cod_catribut     IN	ga_cuentas.cod_catribut%TYPE,
									EV_formato_fec      IN  ged_parametros.val_parametro%TYPE,
									SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                            		SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                            		SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ASOCIA_CATRIBUTCLIE_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Ascciar categoria tributaria al cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del cliente</param>
            <param nom="EV_cod_catribut" Tipo="CARACTER">Codigo tirbutario</param>
            <param nom="EV_formato_fec Tipo="CARACTER">Formato de la fecha</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
      V_des_error      ge_errores_pg.DesEvent;
      sSql             ge_errores_pg.vQuery;

BEGIN
        sSql:=NULL;
		SN_cod_retorno:=0;
   		SN_num_evento:=0;
        sSql:= SUBSTR('INSERT INTO GA_CATRIBUTCLIE(COD_CLIENTE, FEC_DESDE, FEC_HASTA, COD_CATRIBUT) '||
		       ' VALUES('||EN_cod_cliente||','||SYSDATE||',TO_DATE('||CV_fec_limite_cat||','||EV_formato_fec||'),'||
			     EV_cod_catribut||')',1,CN_largoquery);
	    INSERT INTO GA_CATRIBUTCLIE(COD_CLIENTE, FEC_DESDE, FEC_HASTA, COD_CATRIBUT)
	    VALUES(EN_cod_cliente,SYSDATE,TO_DATE(CV_fec_limite_cat,EV_formato_fec),EV_cod_catribut);

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := '302';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error:=SUBSTR('Others: GA_ASOCIA_CATRIBUTCLIE_PR('||EN_cod_cliente||','||EV_cod_catribut||','||EV_formato_fec||'); - ' || SQLERRM,1,CN_largoerrtec);
    	SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_ASOCIA_CATRIBUTCLIE_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;
END GA_ASOCIA_CATRIBUTCLIE_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ASOCIA_CATIMPCLIENTES_PR(EN_cod_cliente    IN  ge_clientes.cod_cliente%TYPE,
									EV_formato_fec      IN  ged_parametros.val_parametro%TYPE,
									SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                            		SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                            		SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ASOCIA_CATRIBUTCLIE_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Ascciar categoria impositiva al cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del cliente</param>
            <param nom="EV_formato_fec Tipo="CARACTER">Formato de la fecha</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
      V_des_error      ge_errores_pg.DesEvent;
      sSql             ge_errores_pg.vQuery;

BEGIN
        sSql:=NULL;
		SN_cod_retorno:=0;
   		SN_num_evento:=0;
		sSql:=SUBSTR(' INSERT INTO GE_CATIMPCLIENTES(COD_CLIENTE, FEC_DESDE, FEC_HASTA, COD_CATIMPOS) '||
		       ' VALUES('||EN_cod_cliente||','||SYSDATE||',TO_DATE('||CV_fec_limite||','||EV_formato_fec||'),1)',1,CN_largoquery);

	    INSERT INTO GE_CATIMPCLIENTES(COD_CLIENTE, FEC_DESDE, FEC_HASTA, COD_CATIMPOS)
	 	VALUES(EN_cod_cliente,SYSDATE,TO_DATE(CV_fec_limite_cat,EV_formato_fec),1);


EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := '302';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error:=SUBSTR('Others: GA_ASOCIA_CATIMPCLIENTES_PR('||EN_cod_cliente||','||EV_formato_fec||'); - ' || SQLERRM,1,CN_largoerrtec);
    	SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_ASOCIA_CATIMPCLIENTES_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;
END GA_ASOCIA_CATIMPCLIENTES_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ASOCIAR_PLAN_COMERCIAL_PR (EN_cod_cliente IN  ge_clientes.cod_cliente%TYPE,
							           EN_cod_plancom  IN  GA_CLIENTE_PCOM.COD_PLANCOM%TYPE,
							           EV_nom_usuario  IN  GE_CLIENTES.NOM_USUARORA%TYPE,
							           EV_fec_limite   IN  VARCHAR2,
									   EV_formato_fec  IN  ged_parametros.val_parametro%TYPE,
							           SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
                                       SV_mens_retorno OUT NOCOPY   ge_errores_pg.MsgError,
                                       SN_num_evento   OUT NOCOPY   ge_errores_pg.Evento
                              )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ASOCIAR_PLAN_COMERCIAL_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Asociar Plan Comercial a un Cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del cliente</param>
            <param nom="EN_cod_plancom"   Tipo="CARACTER">Código plan comercial</param>
			<param nom="EV_nom_usuario"    Tipo="CARACTER">Nombre de usuario</param>
			<param nom="EV_fec_limite"    Tipo="CARACTER">Fecha baja en el plan</param>
			<param nom="EV_formato_fec"    Tipo="CARACTER">Formato fecha</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
      V_des_error      ge_errores_pg.DesEvent;
      sSql             ge_errores_pg.vQuery;

BEGIN
        sSql:=NULL;
		SN_cod_retorno := '0';
   		SN_num_evento  := 0;

		sSql:=SUBSTR('INSERT INTO GA_CLIENTE_PCOM(COD_CLIENTE, COD_PLANCOM, FEC_DESDE, NOM_USUARORA, FEC_HASTA)' ||
		      'VALUES (' ||
			  EN_cod_cliente || ',' || EN_cod_plancom || ',' || SYSDATE || ',' || EV_nom_usuario ||
			  ', TO_DATE('|| EV_fec_limite|| ',' || EV_formato_fec || ')', 1,CN_largoquery);

	    INSERT INTO GA_CLIENTE_PCOM(COD_CLIENTE, COD_PLANCOM, FEC_DESDE, NOM_USUARORA, FEC_HASTA)
	 	VALUES(EN_cod_cliente,EN_cod_plancom,SYSDATE,EV_nom_usuario,TO_DATE(EV_fec_limite,EV_formato_fec));

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := '302'; -- Nuevo error
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error :=substr('OTHERS: GA_ASOCIAR_PLAN_COMERCIAL_PR(' || EN_cod_cliente || ',' || EN_cod_plancom || ',' ||EV_nom_usuario|| ','
		                     ||EV_fec_limite|| ',' ||EV_formato_fec||'); - ' || SQLERRM,1,CN_largoerrtec);
		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_ASOCIAR_PLAN_COMERCIAL_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;

END GA_ASOCIAR_PLAN_COMERCIAL_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_CREA_CUENTA_PR(EN_cod_cuenta     IN GA_CUENTAS.COD_CUENTA%TYPE,
		  					EV_cod_tipident	  IN GE_CLIENTES.COD_TIPIDENT%TYPE,
 		  					EV_num_ident	  IN GE_CLIENTES.NUM_IDENT%TYPE,
   							EV_nom_cliente 	  IN GE_CLIENTES.NOM_CLIENTE%TYPE,
   							EV_nom_apeclien1  IN GE_CLIENTES.NOM_APECLIEN1%TYPE,
   							EV_nom_apeclien2  IN GE_CLIENTES.NOM_APECLIEN2%TYPE,
							EV_cod_provincia  IN GE_DIRECCIONES.COD_PROVINCIA%TYPE,
							EV_cod_region 	  IN GE_DIRECCIONES.COD_REGION%TYPE,
							EV_cod_ciudad	  IN GE_DIRECCIONES.COD_CIUDAD%TYPE,
                            EV_cod_comuna     IN ge_direcciones.cod_comuna%TYPE,
                            EV_nom_calle      IN ge_direcciones.nom_calle%TYPE,
                            EV_num_calle      IN ge_direcciones.num_calle%TYPE,
                            EV_num_piso       IN ge_direcciones.num_piso%TYPE,
                            EV_num_casilla    IN ge_direcciones.num_casilla%TYPE,
   						    EV_tip_cuenta	  IN ga_cuentas.tip_cuenta%TYPE,
  						    EV_cod_catribut   IN ga_cuentas.cod_catribut%TYPE,
							SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
                            SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
                            SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
						   )

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CREA_CUENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Crear una cuenta </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cuenta" Tipo="NUMERICO">Codigo de la Cuenta</param>
            <param nom="EV_cod_tipident"   Tipo="CARACTER">Código de identificación</param>
            <param nom="EV_num_ident"   Tipo="CARACTER">Número de identificación</param>
            <param nom="EV_nom_cliente"    Tipo="CARACTER">Nombre de Cliente</param>
            <param nom="EV_nom_apeclien1"    Tipo="CARACTER">Primer apellido</param>
            <param nom="EV_nom_apeclien2"    Tipo="CARACTER">Segundo apellido</param>
            <param nom="EV_cod_provincia" Tipo="CARACTER">Codigo de Provincia</param>
            <param nom="EV_cod_region" Tipo="CARACTER">Codigo de Region</param>
            <param nom="EV_cod_cuidad" Tipo="CARACTER">Codigo de Cuidad</param>
            <param nom="EV_cod_comuna" Tipo="CARACTER">Codigo de Comuna</param>
            <param nom="EV_nom_calle" Tipo="CARACTER">Nombre de la Calle</param>
            <param nom="EV_num_calle" Tipo="CARACTER">Piso y departamento</param>
            <param nom="EV_num_piso" Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_num_casilla" Tipo="CARACTER">Numero de la casilla</param>
            <param nom="EV_tip_cuenta"    Tipo="CARACTER">Tipo de cuenta</param>
            <param nom="EV_cod_catribut"    Tipo="CARACTER">Categoria tributaria</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
      V_des_error      ge_errores_pg.DesEvent;
      sSql             ge_errores_pg.vQuery;
      vCategCuenta     GA_CUENTAS.COD_CATEGORIA%TYPE; --PBARRIA XO-200509160686 17-09-2005
      error_ejecucion  EXCEPTION;
      SN_cod_direccion ge_direcciones.cod_direccion%TYPE;
BEGIN
		 -- Inicio PBARRIA XO-200509160686 17-09-2005
                 SELECT VAL_PARAMETRO
                 INTO vCategCuenta
                 FROM GED_PARAMETROS
                 WHERE NOM_PARAMETRO = 'CATEGORIA_CUENTA';
                 -- Fin PBARRIA XO-200509160686 17-09-2005
        sSql:=NULL;
		SN_cod_retorno := '0';
   		SN_num_evento  := 0;
		SN_cod_direccion:=NULL;

		sSql:=SUBSTR('GA_CREA_DIRECCION_PR('||EV_cod_provincia || ',' || EV_cod_region || ',' || EV_cod_ciudad || ',' || EV_cod_comuna || ',' || EV_nom_calle || ',' ||
		      EV_num_calle || ',' || EV_num_piso || ',' ||EV_num_casilla||')',1,CN_largoerrtec);
		GA_CREA_DIRECCION_PR(EV_cod_provincia,EV_cod_region,EV_cod_ciudad,EV_cod_comuna,
		      EV_nom_calle,EV_num_calle,EV_num_piso,EV_num_casilla,
			  SN_cod_direccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

		IF SN_cod_retorno<>0 THEN
		   RAISE error_ejecucion;
		END IF;

	    --  INSERTAR NUEVA CUENTA....
		sSql:=SUBSTR('INSERT INTO GA_CUENTAS(COD_CUENTA, DES_CUENTA, TIP_CUENTA,'||
	   		  'NOM_RESPONSABLE, COD_TIPIDENT, NUM_IDENT,'||
	          'COD_DIRECCION, FEC_ALTA, IND_ESTADO,'||
			  'COD_CATRIBUT, COD_CATEGORIA,COD_SECTOR)'||
			  'VALUES('||EN_cod_cuenta||','||SUBSTR(EV_nom_cliente,1,40)||','||EV_tip_cuenta||','||
 			   SUBSTR(EV_nom_cliente,1,40)||','||EV_cod_tipident||','||EV_num_ident||','||
               SN_cod_direccion||',SYSDATE,S,'||EV_cod_catribut||',0)',1,CN_largoquery);
	    INSERT INTO GA_CUENTAS(COD_CUENTA, DES_CUENTA, TIP_CUENTA,
	   		  	   		     NOM_RESPONSABLE, COD_TIPIDENT, NUM_IDENT,
	                         COD_DIRECCION, FEC_ALTA, IND_ESTADO,
							 TEL_CONTACTO,IND_SECTOR,COD_CLASCTA,
							 COD_CATRIBUT, COD_CATEGORIA,
							 COD_SECTOR)
		VALUES(EN_cod_cuenta,SUBSTR(EV_nom_cliente,1,40),EV_tip_cuenta,
		       SUBSTR(EV_nom_cliente,1,40),EV_cod_tipident,EV_num_ident,
               SN_cod_direccion,SYSDATE,'S',
			   NULL,NULL,NULL,
			   --Inicio PBARRIA XO-200509160686 17-09-2005
			   EV_cod_catribut,vCategCuenta,NULL);
			   --EV_cod_catribut,0,NULL);
			   --Fin PBARRIA XO-200509160686 17-09-2005



EXCEPTION
WHEN error_ejecucion THEN
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error :=substr('error_ejecucion: GA_CREA_CUENTA_PR('||EN_cod_cuenta||'); - ' || SQLERRM,1,CN_largoerrtec);
    	SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_CREA_CUENTA_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;

WHEN OTHERS THEN
        SN_cod_retorno := '302';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error :=substr('Others: GA_CREA_CUENTA_PR('||EN_cod_cuenta||'); - ' || SQLERRM,1,CN_largoerrtec);
    	SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_CREA_CUENTA_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;

END GA_CREA_CUENTA_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CREA_USUAMIST_PR(EN_cod_usuario    IN GA_USUARIOS.COD_USUARIO%TYPE,
			    			 EN_num_abonado     IN GA_ABOAMIST.NUM_ABONADO%TYPE,
	   						 EV_cod_tipident	IN GE_CLIENTES.COD_TIPIDENT%TYPE,
 		  					 EV_num_ident		IN GE_CLIENTES.NUM_IDENT%TYPE,
   							 EV_nom_cliente 	IN GE_CLIENTES.NOM_CLIENTE%TYPE,
   							 EV_nom_apeclien1	IN GE_CLIENTES.NOM_APECLIEN1%TYPE,
   							 EV_nom_apeclien2	IN GE_CLIENTES.NOM_APECLIEN2%TYPE,
							 EV_ind_estado		IN VARCHAR2,
 							 SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                             SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
						   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CREA_USUAMIST_PR"
      Lenguaje="PL/SQL"
      Fecha="17-06-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Crear un usuario Amistar</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_usuario" Tipo="NUMERICO">Codigo del usuario</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero del abonado</param>
            <param nom="EV_cod_tipident"   Tipo="CARACTER">Código de identificación</param>
            <param nom="EV_num_ident"   Tipo="CARACTER">Número de identificación</param>
            <param nom="EV_nom_cliente"    Tipo="CARACTER">Nombre de Cliente</param>
            <param nom="EV_nom_apeclien1"    Tipo="CARACTER">Primer apellido</param>
            <param nom="EV_nom_apeclien2"    Tipo="CARACTER">Segundo apellido</param>
            <param nom="EV_ind_estado" Tipo="CARACTER">Indicador de estado del usuario</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        V_des_error      ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
    BEGIN
        sSql:=NULL;
		SN_cod_retorno := '0';
   		SN_num_evento  := 0;

	    --  INSERTAR USUARIO
		sSql:=SUBSTR('INSERT INTO GA_USUAMIST(COD_USUARIO, NUM_ABONADO,'||
              'NOM_USUARIO, NOM_APELLIDO1,NOM_APELLIDO2,'||
              'FEC_ALTA,COD_TIPIDENT, NUM_IDENT,IND_ESTADO,'||
			  'FEC_NACIMIEN,COD_ESTCIVIL,IND_SEXO,IND_TIPOTRAB,'||
			  'NOM_EMPRESA,COD_ACTEMP,COD_OCUPACION,NUM_PERCARGO,'||
			  'IMP_BRUTO,IND_PROCOPER,COD_OPERADOR,NOM_CONYUGE,COD_PINUSUAR) '||
              'VALUES('||EN_cod_usuario||','||EN_num_abonado||','''||
               EV_nom_cliente||''','''||EV_nom_apeclien1||''','''||EV_nom_apeclien2||
		       ''','''||SYSDATE||','''||EV_cod_tipident||''','''||EV_num_ident||
			   ''','''||EV_ind_estado||''',NULL,NULL,NULL,NULL,'||
			   'NULL,NULL,NULL,NULL'||
			   'NULL,NULL,NULL,NULL,NULL',1,CN_largoquery);

        INSERT INTO GA_USUAMIST(COD_USUARIO, NUM_ABONADO,
                  NOM_USUARIO, NOM_APELLIDO1,NOM_APELLIDO2,
                  FEC_ALTA,COD_TIPIDENT, NUM_IDENT,IND_ESTADO,
				  FEC_NACIMIEN,COD_ESTCIVIL,IND_SEXO,IND_TIPOTRAB,
				  NOM_EMPRESA,COD_ACTEMP,COD_OCUPACION,NUM_PERCARGO,
				  IMP_BRUTO,IND_PROCOPER,COD_OPERADOR,NOM_CONYUGE,COD_PINUSUAR)
        VALUES (EN_cod_usuario,EN_num_abonado,
                EV_nom_cliente,EV_nom_apeclien1,EV_nom_apeclien2,
		        SYSDATE,EV_cod_tipident,EV_num_ident,EV_ind_estado,
				NULL,NULL,NULL,NULL,
				NULL,NULL,NULL,NULL,
				NULL,NULL,NULL,NULL,NULL);

EXCEPTION
WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := SUBSTR('Others: GA_MOD_USUAMIST_PR('||EN_cod_usuario||','||EV_cod_tipident||
				               ','||EV_num_ident||','||EV_nom_cliente||','||EV_nom_apeclien1||
							   ','||EV_nom_apeclien2||','||EV_ind_estado||');' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_CREA_USUARIO_PR', sSql, SQLCODE, V_des_error );
				ROLLBACK;
END GA_CREA_USUAMIST_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MOD_USUAMIST_PR(EN_cod_usuario    IN GA_USUARIOS.COD_USUARIO%TYPE,
	   						 EV_cod_tipident	IN GE_CLIENTES.COD_TIPIDENT%TYPE,
 		  					 EV_num_ident		IN GE_CLIENTES.NUM_IDENT%TYPE,
   							 EV_nom_cliente 	IN GE_CLIENTES.NOM_CLIENTE%TYPE,
   							 EV_nom_apeclien1	IN GE_CLIENTES.NOM_APECLIEN1%TYPE,
   							 EV_nom_apeclien2	IN GE_CLIENTES.NOM_APECLIEN2%TYPE,
							 EV_ind_estado		IN VARCHAR2,
 							 SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                             SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
						   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MOD_USUAMIST_PR"
      Lenguaje="PL/SQL"
      Fecha="21-06-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Modificar un usuario Amistar</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_usuario" Tipo="NUMERICO">Codigo del usuario</param>
            <param nom="EV_cod_tipident"   Tipo="CARACTER">Código de identificación</param>
            <param nom="EV_num_ident"   Tipo="CARACTER">Número de identificación</param>
            <param nom="EV_nom_cliente"    Tipo="CARACTER">Nombre de Cliente</param>
            <param nom="EV_nom_apeclien1"    Tipo="CARACTER">Primer apellido</param>
            <param nom="EV_nom_apeclien2"    Tipo="CARACTER">Segundo apellido</param>
            <param nom="EV_ind_estado" Tipo="CARACTER">Indicador de estado del usuario</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        V_des_error      ge_errores_pg.DesEvent;
        sSql             ge_errores_pg.vQuery;

    BEGIN
       sSql:=NULL;
	   SN_cod_retorno := '0';
   	   SN_num_evento  := 0;

	   sSql:='UPDATE GA_USUAMIST usuario '||
	   		 'SET NOM_USUARIO='||EV_nom_cliente||','||
			 'NOM_APELLIDO1='''||EV_nom_apeclien1||''','||
			 'NOM_APELLIDO2='''||EV_nom_apeclien2||''','||
             'FEC_ALTA=SYSDATE,'||
			 'COD_TIPIDENT='''||EV_cod_tipident||''','||
			 'NUM_IDENT='''||EV_num_ident||''','||
			 'IND_ESTADO='''||EV_ind_estado||''','||
			 'FEC_NACIMIEN=NULL,'||
			 'COD_ESTCIVIL=NULL,'||
			 'IND_SEXO=NULL,'||
			 'IND_TIPOTRAB=NULL,'||
			 'NOM_EMPRESA=NULL,'||
			 'COD_ACTEMP=NULL,'||
			 'COD_OCUPACION=NULL,'||
			 'NUM_PERCARGO=NULL,'||
			 'IMP_BRUTO=NULL,'||
			 'IND_PROCOPER=NULL,'||
			 'COD_OPERADOR=NULL,'||
			 'NOM_CONYUGE=NULL,'||
			 'COD_PINUSUAR=NULL'||
	         'WHERE usuario.cod_usuario='||EN_cod_usuario;

	   UPDATE GA_USUAMIST usuario
	   		SET NOM_USUARIO=EV_nom_cliente,
			    NOM_APELLIDO1=EV_nom_apeclien1,
				NOM_APELLIDO2=EV_nom_apeclien2,
                FEC_ALTA=SYSDATE,
				COD_TIPIDENT=EV_cod_tipident,
				NUM_IDENT=EV_num_ident,
				IND_ESTADO=EV_ind_estado,
				FEC_NACIMIEN=NULL,
				COD_ESTCIVIL=NULL,
				IND_SEXO=NULL,
				IND_TIPOTRAB=NULL,
				NOM_EMPRESA=NULL,
				COD_ACTEMP=NULL,
				COD_OCUPACION=NULL,
				NUM_PERCARGO=NULL,
				IMP_BRUTO=NULL,
				IND_PROCOPER=NULL,
				COD_OPERADOR=NULL,
				NOM_CONYUGE=NULL,
				COD_PINUSUAR=NULL
	   WHERE usuario.cod_usuario=EN_cod_usuario;

EXCEPTION
WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := SUBSTR('Others: GA_MOD_USUAMIST_PR('||EN_cod_usuario||','||EV_cod_tipident||
				               ','||EV_num_ident||','||EV_nom_cliente||','||EV_nom_apeclien1||
							   ','||EV_nom_apeclien2||','||EV_ind_estado||');' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_CREA_USUARIO_PR', sSql, SQLCODE, V_des_error );
				ROLLBACK;
END GA_MOD_USUAMIST_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MOD_PARAMETRO      (EV_nom_parametro  IN           ged_parametros.nom_parametro%TYPE,
                                 EV_nom_modulo     IN           ged_parametros.cod_modulo%TYPE,
                                 EN_cod_producto   IN           ged_parametros.cod_producto%TYPE,
                                 EV_val_parametro  IN			ged_parametros.val_parametro%TYPE,
                                 SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
                                 SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
                                 SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento

)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MOD_PARAMETRO"
      Lenguaje="PL/SQL"
      Fecha="28-06-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Modifica valor de un parametro</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre del parametro</param>
            <param nom="EV_nom_modulo" Tipo="CARACTER">Nombre del modulo, no es obligatorio</param>
            <param nom="EN_cod_producto" Tipo="NUMERICO">Codigo del producto no es obligatorio</param>
            <param nom="EV_val_parametro"    Tipo="CARACTER">Valor del parametro</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;
		sSql:='UPDATE GED_PARAMETROS '||
		      ' SET VAL_PARAMETRO='||EV_val_parametro||
		      ' WHERE  NOM_PARAMETRO='||EV_nom_parametro||
   		      ' AND COD_MODULO='||EV_nom_modulo||
   		      ' AND COD_PRODUCTO='||EN_cod_producto;
		UPDATE GED_PARAMETROS
		   SET VAL_PARAMETRO=EV_val_parametro
		 WHERE  NOM_PARAMETRO=EV_nom_parametro
   		   AND COD_MODULO=EV_nom_modulo
   		   AND COD_PRODUCTO=EN_cod_producto;

EXCEPTION
WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
				V_des_error :=SUBSTR('OTHERS : GA_MOD_PARAMETRO('||EV_nom_parametro||','||EV_nom_modulo||','||EN_cod_producto||','||EV_val_parametro||'); - ' || SQLERRM,1,CN_largoerrtec);
		        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_MOD_PARAMETRO', sSql, SQLCODE, V_des_error );
END  GA_MOD_PARAMETRO;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CREA_CLIENTE_PR (EN_cod_cliente    IN  ge_clientes.cod_cliente%TYPE,
 			   				  EN_cod_cuenta     IN  GA_CUENTAS.COD_CUENTA%TYPE,
	   						  EV_cod_tipident	IN  GE_CLIENTES.COD_TIPIDENT%TYPE,
 		  					  EV_num_ident		IN  GE_CLIENTES.NUM_IDENT%TYPE,
							  EV_nom_cliente    IN  ge_clientes.nom_cliente%TYPE,
							  EV_nom_apeclien1  IN  ge_clientes.nom_apeclien1%TYPE,
							  EV_nom_apeclien2  IN  ge_clientes.nom_apeclien2%TYPE,
                              EV_cod_provincia  IN  ge_direcciones.cod_provincia%TYPE,
				 			  EV_cod_region     IN  ge_direcciones.cod_region%TYPE,
                              EV_cod_ciudad     IN  ge_direcciones.cod_ciudad%TYPE,
                              EV_cod_comuna     IN  ge_direcciones.cod_comuna%TYPE,
                              EV_nom_calle      IN  ge_direcciones.nom_calle%TYPE,
                              EV_num_calle      IN  ge_direcciones.num_calle%TYPE,
                              EV_num_piso       IN  ge_direcciones.num_piso%TYPE,
                              EV_num_casilla    IN  ge_direcciones.num_casilla%TYPE,
							  EN_cod_categoria  IN  ge_clientes.cod_categoria%TYPE,
				 			  EV_cod_catribut   IN	ga_cuentas.cod_catribut%TYPE,
				 			  EN_cod_ciclo	    IN  ga_abocel.cod_ciclo%TYPE,
				 			  EV_nom_usuario	IN  GE_CLIENTES.NOM_USUARORA%TYPE,
							  SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
                              SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
                              SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
                              )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CREA_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Crear un usuario </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del cliente</param>
            <param nom="EN_cod_cuenta" Tipo="NUMERICO">Codigo de la Cuenta</param>
            <param nom="EV_cod_tipident"   Tipo="CARACTER">Código de identificación</param>
            <param nom="EV_num_ident"   Tipo="CARACTER">Número de identificación</param>
            <param nom="EV_nom_cliente"    Tipo="CARACTER">Nombre de Cliente</param>
            <param nom="EV_nom_apeclien1"    Tipo="CARACTER">Primer apellido</param>
            <param nom="EV_nom_apeclien2"    Tipo="CARACTER">Segundo apellido</param>
            <param nom="EV_cod_provincia" Tipo="CARACTER">Codigo de Provincia</param>
            <param nom="EV_cod_region" Tipo="CARACTER">Codigo de Region</param>
            <param nom="EV_cod_cuidad" Tipo="CARACTER">Codigo de Cuidad</param>
            <param nom="EV_cod_comuna" Tipo="CARACTER">Codigo de Comuna</param>
            <param nom="EV_nom_calle" Tipo="CARACTER">Nombre de la Calle</param>
            <param nom="EV_num_calle" Tipo="CARACTER">Piso y departamento</param>
            <param nom="EV_num_piso" Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_num_casilla" Tipo="CARACTER">Numero de la casilla</param>
            <param nom="EV_cod_categoria"    Tipo="CARACTER">Categoria del cliente</param>
            <param nom="EV_cod_catribut"    Tipo="CARACTER">Categoria tributaria</param>
            <param nom="EV_cod_ciclo"    Tipo="CARACTER">Ciclo de facturacion</param>
            <param nom="EV_nom_usuario"    Tipo="CARACTER">Nombre de usuario</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

   CURSOR Dirobliga_CU (EV_cod_modulo  IN ged_codigos.cod_modulo%TYPE,
   		  			   	EV_nom_tabla   IN ged_codigos.nom_tabla%TYPE,
						EV_nom_columna IN ged_codigos.nom_columna%TYPE) IS
        SELECT dirobliga.cod_valor as valor
	      FROM ged_codigos dirobliga
		 WHERE dirobliga.cod_modulo=EV_cod_modulo
		   AND dirobliga.nom_tabla=EV_nom_tabla
		   AND dirobliga.nom_columna=EV_nom_columna;

   V_des_error                ge_errores_pg.DesEvent;
   sSql                 	  ge_errores_pg.vQuery;
   VP_COD_IDIOMA 			  GE_CLIENTES.COD_IDIOMA%TYPE;
   VP_COD_OPERADORA			  GE_CLIENTES.COD_OPERADORA%TYPE;
   SN_cod_direccion			  GE_DIRECCIONES.COD_DIRECCION%TYPE;
   VP_COD_CALCLIEN			  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   VP_COD_ABC 				  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   VP_COD_123 				  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   LV_agente_desbloqueo		  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   LV_cod_plancom			  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   LV_acepta_vta			  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   VP_formato_fec			  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   SV_val_parametro			  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   error_ejecucion			  EXCEPTION;
   LV_cod_tipdireccion		  GE_TIPDIRECCION.COD_TIPDIRECCION%TYPE;
   LN_control_error			  NUMBER(2);
   LV_cod_pais				  GED_PARAMETROS.VAL_PARAMETRO%TYPE;

    BEGIN

	   SN_cod_retorno := '0';
	   SN_num_evento  := 0;
       sSql:=NULL;
       SV_val_parametro:=NULL;
	   VP_COD_ABC:=NULL;
	   VP_COD_123:=NULL;
	   VP_COD_CALCLIEN:=NULL;
	   LV_agente_desbloqueo:=NULL;
	   LV_cod_plancom:=NULL;
	   LV_acepta_vta:=NULL;
	   VP_COD_IDIOMA:=NULL;
	   VP_COD_OPERADORA:=NULL;
	   LV_cod_pais:=NULL;

       sSql:='GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn('||CV_cod_abc||','||CV_cod_modulo||','||CV_cod_producto_post||')';
	   IF GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn(CV_cod_abc,CV_cod_modulo,CV_cod_producto_post,SV_val_parametro,
          SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		  VP_COD_ABC := SV_val_parametro;
	   END IF;

       sSql:='GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn('||CV_cod_123||','||CV_cod_modulo||','||CV_cod_producto_post||',)';
	   IF GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn(CV_cod_123,CV_cod_modulo,CV_cod_producto_post,SV_val_parametro,
          SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		  VP_COD_123:= SV_val_parametro;
	   END IF;

       sSql:='GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn('||CV_cod_calclien||','||CV_cod_modulo||','||CV_cod_producto_post||',)';
	   IF GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn(CV_cod_calclien,CV_cod_modulo,CV_cod_producto_post,SV_val_parametro,
          SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		  VP_COD_CALCLIEN:= SV_val_parametro;
	   END IF;

       sSql:='GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn('||CV_agente_desbloqueo||','||CV_cod_modulo||','||CV_cod_producto_post||',)';
	   IF GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn(CV_agente_desbloqueo,CV_cod_modulo,CV_cod_producto_post,SV_val_parametro,
          SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		  LV_agente_desbloqueo:= SV_val_parametro;
	   END IF;

       sSql:='GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn('||CV_cod_plancom||','||CV_cod_modulo||','||CV_cod_producto_post||',)';
	   IF GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn(CV_cod_plancom,CV_cod_modulo,CV_cod_producto_post,SV_val_parametro,
          SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		  LV_cod_plancom:= SV_val_parametro;
	   END IF;

       sSql:='GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn('||CV_ind_acepta_vta||','||CV_cod_modulo||','||CV_cod_producto_post||',)';
	   IF GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn(CV_ind_acepta_vta,CV_cod_modulo,CV_cod_producto_post,SV_val_parametro,
          SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		  LV_acepta_vta:= SV_val_parametro;
	   END IF;

       sSql:='GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn('||CV_cod_pais||','||CV_cod_modulo||','||CV_cod_producto_post||',)';
	   IF GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn(CV_cod_pais,CV_cod_modulo,CV_cod_producto_post,SV_val_parametro,
          SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		  LV_cod_pais:= SV_val_parametro;
	   END IF;

	   VP_formato_fec:='DD-MM-YYYY';
       sSql:='GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn('||CV_formato_fecha||','||CV_modulo||','||CV_cod_producto_post||',)';
	   IF GE_VALIDACIONES_PG.ge_obtiene_gedparametros_fn(CV_formato_fecha,CV_modulo,CV_cod_producto_post,SV_val_parametro,
          SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		  VP_formato_fec:= SV_val_parametro;
	   END IF;

       sSql:= 'VP_COD_IDIOMA:=GE_FN_IDIOMA_LOCAL';
       VP_COD_IDIOMA:=GE_FN_IDIOMA_LOCAL;

       sSql:= 'VP_COD_OPERADORA:=GE_FN_OPERADORA_SCL';
       VP_COD_OPERADORA:=GE_FN_OPERADORA_SCL;

       -- Insertamos Cliente
       sSql:=SUBSTR('INSERT INTO GE_CLIENTES(COD_CLIENTE, NOM_CLIENTE, NOM_APECLIEN1,NOM_APECLIEN2,'||
    	   ' COD_TIPIDENT, NUM_IDENT, COD_CALCLIEN, IND_SITUACION,'||
	   	   ' FEC_ALTA, IND_FACTUR, IND_TRASPASO, IND_AGENTE, FEC_ULTMOD, NOM_USUARORA, IND_ALTA,'||
	   	   ' COD_CUENTA, IND_ACEPVENT, COD_ABC, COD_123, COD_IDIOMA, COD_OPERADORA,'||
	   	   ' COD_CATEGORIA,COD_PAIS,COD_CICLO,NUM_ABOCEL)' ||
           ' VALUES('||EN_cod_cliente||','||EV_nom_cliente||','||EV_nom_apeclien1||
           ','||EV_nom_apeclien2||','||EV_cod_tipident||','||EV_num_ident||
           ','||VP_COD_CALCLIEN||',C,'||SYSDATE||',1,S'||
           ','||LV_agente_desbloqueo||','||SYSDATE||','||EV_nom_usuario||',M'||
	   	   ','||EN_cod_cuenta||','||LV_acepta_vta||','||VP_COD_ABC||
	   	   ','||VP_COD_123||','||VP_COD_IDIOMA||','||VP_COD_OPERADORA||
	   	   ','||EN_cod_categoria||','||LV_cod_pais||','||EN_cod_ciclo||',0)',1,CN_largoquery);

       INSERT INTO GE_CLIENTES(COD_CLIENTE, NOM_CLIENTE, NOM_APECLIEN1,NOM_APECLIEN2,
	     COD_TIPIDENT, NUM_IDENT, COD_CALCLIEN, IND_SITUACION,
	     FEC_ALTA, IND_FACTUR, IND_TRASPASO, IND_AGENTE, FEC_ULTMOD, NOM_USUARORA, IND_ALTA,
         COD_CUENTA, IND_ACEPVENT, COD_ABC, COD_123, COD_IDIOMA, COD_OPERADORA,
	     COD_CATEGORIA,COD_PAIS,COD_CICLO,NUM_ABOCEL)
       VALUES(EN_cod_cliente,EV_nom_cliente,EV_nom_apeclien1,EV_nom_apeclien2,
         EV_cod_tipident,EV_num_ident,VP_COD_CALCLIEN,'C',
	     SYSDATE,1,'S',LV_agente_desbloqueo,SYSDATE,EV_nom_usuario,'M',
	     EN_cod_cuenta,LV_acepta_vta,VP_COD_ABC,VP_COD_123,VP_COD_IDIOMA,VP_COD_OPERADORA,
  	     EN_cod_categoria,LV_cod_pais,EN_cod_ciclo,0);


		--updatear cliente en ged_parametros....
		sSql:=SUBSTR('GA_MOD_PARAMETRO('||CV_param_cliente||','||CV_cod_modulo||','||CV_cod_producto_post||','||EN_cod_cliente||');',1,CN_largoquery);
 	    GA_MOD_PARAMETRO(CV_param_cliente,CV_cod_modulo,CV_cod_producto_post,EN_cod_cliente,
		                     SN_cod_retorno,SV_mens_retorno,SN_num_evento);

		IF SN_cod_retorno<>0 THEN
           SN_cod_retorno := '302';
		   RAISE error_ejecucion;
		END IF;


        sSql:=SUBSTR('GA_ASOCIAR_PLAN_COMERCIAL_PR('|| EN_cod_cliente || ',' || LV_cod_plancom || ',' ||EV_nom_usuario|| ','
		                     ||CV_fec_limite|| ',' ||VP_formato_fec||'); - ',1,CN_largoerrtec);
		GA_ASOCIAR_PLAN_COMERCIAL_PR(EN_cod_cliente,LV_cod_plancom,EV_nom_usuario,CV_fec_limite,VP_formato_fec,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno<>0 THEN
		   RAISE error_ejecucion;
		END IF;


		SN_cod_direccion:=NULL;
		sSql:=SUBSTR('GA_CREA_DIRECCION_PR('||EV_cod_provincia || ',' || EV_cod_region || ',' || EV_cod_ciudad || ',' || EV_cod_comuna || ',' || EV_nom_calle || ',' ||
		      EV_num_calle || ',' || EV_num_piso || ',' ||EV_num_casilla||')',1,CN_largoerrtec);
		GA_CREA_DIRECCION_PR(EV_cod_provincia,EV_cod_region,EV_cod_ciudad,EV_cod_comuna,
		      EV_nom_calle,EV_num_calle,EV_num_piso,EV_num_casilla,
			  SN_cod_direccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

		IF SN_cod_retorno<>0 THEN
		   RAISE error_ejecucion;
		END IF;

		LN_control_error:=0;
		FOR Cursor_DirObliga IN Dirobliga_CU(CV_modulo,CV_nom_tabla,CV_nom_columna) LOOP
		   sSql:=SUBSTR('GA_CREA_DIRECCION_CLIENTE_PR('||EN_cod_cliente||','||Cursor_Dirobliga.valor||','||SN_cod_direccion||');',1,CN_largoquery);
		   GA_CREA_DIRECCION_CLIENTE_PR(EN_cod_cliente,Cursor_Dirobliga.valor,SN_cod_direccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		   IF SN_cod_retorno<>0 THEN
		      LN_control_error:=1;
		   END IF;
		   IF LN_control_error=1 THEN
		      EXIT;
		   END IF;
		END LOOP;

		IF LN_control_error=1 THEN
		   RAISE error_ejecucion;
		END IF;

		sSql:=SUBSTR('GA_ASOCIA_CATRIBUTCLIE_PR('||EN_cod_cliente||','||EV_cod_catribut||','||VP_formato_fec||');',1,CN_largoquery);
		GA_ASOCIA_CATRIBUTCLIE_PR(EN_cod_cliente,EV_cod_catribut,VP_formato_fec,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno<>0 THEN
		   RAISE error_ejecucion;
		END IF;

		sSql:=SUBSTR('GA_ASOCIA_CATIMPCLIENTES_PR('||EN_cod_cliente||','||VP_formato_fec||');',1,CN_largoquery);
		GA_ASOCIA_CATIMPCLIENTES_PR(EN_cod_cliente,VP_formato_fec,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

		IF SN_cod_retorno<>0 THEN
		   RAISE error_ejecucion;
		END IF;

		sSql:=SUBSTR('GA_ASOCIA_RESPONSABLE_PR('||EN_cod_cliente||','||EV_cod_tipident||','||EV_num_ident||
		              ','||EV_nom_cliente||','||EV_nom_apeclien1||','||EV_nom_apeclien2||');',1,CN_largoquery);
		GA_ASOCIA_RESPONSABLE_PR(EN_cod_cliente,EV_cod_tipident,EV_num_ident,EV_nom_cliente,
								 EV_nom_apeclien1,EV_nom_apeclien2,SN_cod_retorno,
								 SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno<>0 THEN
		   RAISE error_ejecucion;
		END IF;


EXCEPTION
WHEN error_ejecucion THEN
        SN_cod_retorno := '302'; -- Nuevo error
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error :=substr('error_ejecucion:  GA_CREA_CLIENTE_PR('||EN_cod_cliente||'); - ' || SQLERRM,1,CN_largoerrtec);
		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_CREA_CLIENTE_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;
WHEN OTHERS THEN
        SN_cod_retorno := '302'; -- Nuevo error
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        V_des_error :=substr('OTHERS: GA_CREA_CLIENTE_PR('||EN_cod_cliente||'); - ' || SQLERRM,1,CN_largoerrtec);
		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_CREA_CLIENTE_PR', sSql, SQLCODE, V_des_error );
		ROLLBACK;
END GA_CREA_CLIENTE_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CREA_ESTRUCTURA_ABONADO_PR (EN_num_abonado IN ga_abocel.num_abonado%TYPE,
                                 EV_cod_provincia   IN    ge_direcciones.cod_provincia%TYPE,
 		  						 EV_cod_region      IN    ge_direcciones.cod_region%TYPE,
                                 EV_cod_ciudad      IN    ge_direcciones.cod_ciudad%TYPE,
                                 EV_cod_comuna      IN    ge_direcciones.cod_comuna%TYPE,
                                 EV_nom_calle       IN    ge_direcciones.nom_calle%TYPE,
                                 EV_num_calle       IN    ge_direcciones.num_calle%TYPE,
                                 EV_num_piso        IN    ge_direcciones.num_piso%TYPE,
                                 EV_num_casilla     IN    ge_direcciones.num_casilla%TYPE,
                                 EV_obs_direccion   IN    ge_direcciones.obs_direccion%TYPE,
                                 EV_des_direc1      IN    ge_direcciones.des_direc1%TYPE,
                                 EV_des_direc2      IN    ge_direcciones.des_direc2%TYPE,
                                 EV_cod_pueblo      IN    ge_direcciones.cod_pueblo%TYPE,
                                 EV_cod_estado      IN    ge_direcciones.cod_estado%TYPE,
 								 EV_cod_tipident    IN    ge_clientes.cod_tipident%TYPE,
								 EV_num_ident       IN    ge_clientes.num_ident%TYPE,
								 EV_nom_cliente     IN    ge_clientes.nom_cliente%TYPE,
								 EV_nom_apeclien1   IN    ge_clientes.nom_apeclien1%TYPE,
								 EV_nom_apeclien2   IN    ge_clientes.nom_apeclien2%TYPE,
								 EN_cod_categoria   IN    ge_clientes.cod_categoria%TYPE,
								 EV_tip_cuenta	    IN	  ga_cuentas.tip_cuenta%TYPE,
								 EN_cod_ciclo	    IN    ga_abocel.cod_ciclo%TYPE,
								 EV_cod_catribut    IN	  ga_cuentas.cod_catribut%TYPE,
		  				         EN_ant_cod_cliente IN    ge_clientes.cod_cliente%TYPE,
							     SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                 SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                 SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                )

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ACTIVA_PREPAGO_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> XXX</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado Tipo="NUMERICO">Numero del abonado</param>
            <param nom="EV_cod_provincia" Tipo="CARACTER">Codigo de Provincia</param>
            <param nom="EV_cod_region" Tipo="CARACTER">Codigo de Region</param>
            <param nom="EV_cod_cuidad" Tipo="CARACTER">Codigo de Cuidad</param>
            <param nom="EV_cod_comuna" Tipo="CARACTER">Codigo de Comuna</param>
            <param nom="EV_nom_calle" Tipo="CARACTER">Nombre de la Calle</param>
            <param nom="EV_num_calle" Tipo="CARACTER">Piso y departamento</param>
            <param nom="EV_num_piso" Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_num_casilla" Tipo="CARACTER">Numero de la casilla</param>
            <param nom="EV_obs_direccion" Tipo="CARACTER">Otros indicadores</param>
            <param nom="EV_des_direc1" Tipo="CARACTER">Descripcion direccion 1</param>
            <param nom="EV_des_direc2" Tipo="CARACTER">Descripcion direccion 2</param>
            <param nom="EV_cod_pueblo" Tipo="CARACTER">Codigo de pueblo</param>
			<param nom="EV_cod_estado" Tipo="CARACTER">Codigo de estado</param>
            <param nom="EV_cod_tipident"   Tipo="CARACTER">Código de identificación</param>
            <param nom="EV_num_ident"   Tipo="CARACTER">Número de identificación</param>
            <param nom="EV_nom_cliente"    Tipo="CARACTER">Nombre de Cliente</param>
            <param nom="EV_nom_apeclien1"    Tipo="CARACTER">Primer apellido</param>
            <param nom="EV_nom_apeclien2"    Tipo="CARACTER">Segundo apellido</param>
            <param nom="EV_cod_categoria"    Tipo="CARACTER">Categoria del cliente</param>
            <param nom="EV_tip_cuenta"    Tipo="CARACTER">Tipo de cuenta</param>
            <param nom="EV_cod_ciclo"    Tipo="CARACTER">Ciclo de facturacion</param>
            <param nom="EV_cod_catribut"    Tipo="CARACTER">Categoria tributaria</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion   EXCEPTION;
        V_des_error       ge_errores_pg.DesEvent;
	    SN_cod_subcuenta  GA_SUBCUENTAS.COD_SUBCUENTA%TYPE;
	    EN_cod_cuenta     GA_CUENTAS.COD_CUENTA%TYPE;
	    EN_cod_usuario    GA_USUARIOS.COD_USUARIO%TYPE;
        sSql              ge_errores_pg.vQuery;
 		SN_cod_ciclo	  ga_abocel.cod_ciclo%TYPE;
		EN_cod_cliente    ge_clientes.cod_cliente%TYPE;
		SN_cod_cuenta	  ga_cuentas.cod_cuenta%TYPE;
        LV_usuario		  ged_parametros.val_parametro%TYPE;
        LN_cod_categoria	  ga_cuentas.cod_categoria%TYPE; --XO-200509240730 - 26/9/2005 - JJR.-
        LV_valparam		  ged_parametros.val_parametro%TYPE; --XO-200509240730 - 26/9/2005 - JJR.-


    BEGIN
        sSql:=NULL;
		SN_cod_subcuenta:=NULL;
        SN_cod_retorno := '0';
        SN_num_evento  := 0;
		EN_cod_cuenta:=NULL;
		EN_cod_usuario:=NULL;
		SN_cod_cuenta:=NULL;
		LN_cod_categoria:=0; --XO-200509240730 - 26/9/2005 - JJR.-

	    --Obtener usuario interno
	    LV_usuario:=NULL;
        sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_usuario||','||'GE'||','||CV_cod_producto_post||');';
	    IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_usuario,'GE',
		   	   				  CV_cod_producto_post,LV_usuario,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno:= '302';
			 RAISE  error_ejecucion;
	    END IF;

		-- 0.- Validar si existe una cuenta para la identificacion ingresada...
		sSql:='ge_validaciones_pg.ge_valida_ident_cuenta_fn('||EV_cod_tipident||','||EV_num_ident||');';
        IF NOT ge_validaciones_pg.ge_valida_ident_cuenta_fn(EV_cod_tipident,EV_num_ident,SN_cod_cuenta,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN

            ---1.- Crear cuenta y asignar una direccion con ga_crear_cuenta_pr..
            sSql:='SELECT GA_SEQ_CUENTAS.NEXTVAL INTO EN_cod_cuenta FROM DUAL';
            SELECT GA_SEQ_CUENTAS.NEXTVAL INTO EN_cod_cuenta FROM DUAL;

            sSql:=SUBSTR('GA_ESTRUCTURA_PG.GA_CREA_CUENTA_PR('||EN_cod_cuenta||','||EV_cod_tipident||','||EV_num_ident||
               ','||EV_nom_cliente||','||EV_nom_apeclien1||','||EV_nom_apeclien2||EV_cod_provincia||
     		  ','||EV_cod_region||','||EV_cod_ciudad||','||EV_cod_comuna||
     		  ','||EV_nom_calle||','||EV_num_calle||','||EV_num_piso||','||EV_num_casilla||','||EV_tip_cuenta||
     		  ','||EV_cod_catribut||');',1,CN_largoquery);

     		GA_ESTRUCTURA_PG.GA_CREA_CUENTA_PR(EN_cod_cuenta,
     	  					EV_cod_tipident,
     	  					EV_num_ident,
     	  					EV_nom_cliente,
     	  					EV_nom_apeclien1,
     	  					EV_nom_apeclien2,
     	  					EV_cod_provincia,
     	  					EV_cod_region,
     	  					EV_cod_ciudad,
     	  					EV_cod_comuna,
     	  					EV_nom_calle,
     	  					EV_num_calle,
     	  					EV_num_piso,
     	  					EV_num_casilla,
     	  					EV_tip_cuenta,
     	  					EV_cod_catribut,
     	  					SN_cod_retorno,
     	  					SV_mens_retorno,
     	  					SN_num_evento);


		 ELSE
		    EN_cod_cuenta:=SN_cod_cuenta;
 	     END IF;

	    IF SN_cod_retorno<>0 THEN
            	RAISE error_ejecucion;
            END IF;

            ---INICIO - XO-200509240730 - 26/9/2005 - JJR.-
                LV_valparam:=NULL;
        	sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn(''PARAM_CATEGORIA_CLIE'','||'GA'||','
          	||CV_cod_producto_post||');';
	    	IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn('PARAM_CATEGORIA_CLIE','GA', CV_cod_producto_post,LV_valparam,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                    	SN_cod_retorno:= '302';
			RAISE  error_ejecucion;
	    	END IF;
		LN_cod_categoria:=TO_number(LV_valparam);
	   ---FIN - XO-200509240730 - 26/9/2005 - JJR.-

		 --3.- Validar si existe usuario para abonado....
		 EN_cod_usuario:=NULL;
		 sSql:=SUBSTR('ge_validaciones_pg.ge_valida_existe_usuamist_fn('||EN_num_abonado||')',1,CN_largoquery);
		 IF  NOT ge_validaciones_pg.ge_valida_existe_usuamist_fn(EN_num_abonado,EN_cod_usuario,SN_cod_retorno,
		     SV_mens_retorno,SN_num_evento) THEN

			 --Crear un usuario....
       	     sSql:='SELECT GA_SEQ_USUARIOS.NEXTVAL INTO EN_cod_usuario FROM DUAL';
       	     SELECT GA_SEQ_USUARIOS.NEXTVAL INTO EN_cod_usuario FROM DUAL;

             sSql:=SUBSTR('GA_ESTRUCTURA_PG.GA_CREA_USUAMIST_PR('||EN_cod_usuario||','||EN_num_abonado||
       		          ','||EV_COD_TIPIDENT||','||EV_NUM_IDENT||','||EV_NOM_CLIENTE||','||EV_NOM_APECLIEN1||
       				  ','||EV_NOM_APECLIEN2||','||CV_ind_estado||');',1,CN_largoquery);

       		 GA_ESTRUCTURA_PG.GA_CREA_USUAMIST_PR(
			 					EN_cod_usuario,
                    		    EN_num_abonado,
                    		    EV_cod_tipident,
                    		    EV_num_ident,
                    		    EV_nom_cliente,
                    		    EV_nom_apeclien1,
                    		    EV_nom_apeclien2,
                    		    CV_ind_estado,
                    		    SN_cod_retorno,
                    		    SV_mens_retorno,
                    		    SN_num_evento);

		  END IF;


		  IF SN_cod_retorno<>0 THEN
		  	 RAISE error_ejecucion;
		  END IF;

		  IF EN_cod_usuario IS NULL THEN
       		 SN_cod_retorno:='302';
       		 RAISE error_ejecucion;
		  ELSE
		  	  --Modifica usuario existente...
              sSql:=SUBSTR('GA_ESTRUCTURA_PG.GA_MOD_USUAMIST_PR('||EN_cod_usuario||','||
		          ','||EV_COD_TIPIDENT||','||EV_NUM_IDENT||','||EV_NOM_CLIENTE||','||EV_NOM_APECLIEN1||
				  ','||EV_NOM_APECLIEN2||','||CV_ind_estado||');',1,CN_largoquery);
		      GA_ESTRUCTURA_PG.GA_MOD_USUAMIST_PR(EN_cod_usuario,
            		     EV_cod_tipident,
            		     EV_num_ident,
            		     EV_nom_cliente,
            		     EV_nom_apeclien1,
            		     EV_nom_apeclien2,
            		     CV_ind_estado,
            		     SN_cod_retorno,
            		     SV_mens_retorno,
            		     SN_num_evento);
	       	  IF SN_cod_retorno<>0 THEN
       		     SN_cod_retorno:= '302';
       		     RAISE error_ejecucion;
       	      END IF;
		  END IF;

          --INI P-COL-05024 Asignacion codigo cliente
          ---4.- Crear cliente, asociar y asignar 3 tipos de direcciones..usar  ga_crear_cliente_pr...
    	  --sSql:='SELECT GA_SEQ_CLIENTES.NEXTVAL INTO EN_cod_cliente FROM DUAL';
    	  --SELECT GE_SEQ_CLIENTES.NEXTVAL INTO EN_cod_cliente FROM DUAL;

	      EN_cod_cliente:=GE_SEQ_CLIENTES_FN(0);

          --FIN P-COL-05024 Asignacion codigo cliente


          sSql:=SUBSTR('GA_ESTRUCTURA_PG.GA_CREA_CLIENTE_PR('||EN_cod_cliente||','||EN_cod_cuenta||
    		          ','||EV_COD_TIPIDENT||','||EV_NUM_IDENT||','||EV_NOM_CLIENTE||','||EV_NOM_APECLIEN1||
    				  ','||EV_NOM_APECLIEN2||EV_cod_provincia||','||EV_cod_region||','||EV_cod_ciudad||','||EV_cod_comuna||
    				  ','||EV_nom_calle||','||EV_num_calle||','||EV_num_piso||','||EV_num_casilla||
    				  ','||EN_cod_categoria||','||EV_cod_catribut||','||EN_cod_ciclo||','||LV_usuario||');',1,CN_largoquery);
    	  GA_ESTRUCTURA_PG.GA_CREA_CLIENTE_PR
    			    (EN_cod_cliente,
     			     EN_cod_cuenta,
     			     EV_cod_tipident,
    	   		     EV_num_ident,
    				 EV_nom_cliente,
    				 EV_nom_apeclien1,
    				 EV_nom_apeclien2,
                     EV_cod_provincia,
    				 EV_cod_region,
                     EV_cod_ciudad,
                     EV_cod_comuna,
                     EV_nom_calle,
                     EV_num_calle,
                     EV_num_piso,
                     EV_num_casilla,
    				 --EN_cod_categoria, -- XO-200509240730 - 26/9/2005 - JJR.-
    				 LN_cod_categoria,   -- XO-200509240730 - 26/9/2005 - JJR.-
    				 EV_cod_catribut,
    				 EN_cod_ciclo,
    				 LV_usuario,
    				 SN_cod_retorno,
                     SV_mens_retorno,
                     SN_num_evento);

    		IF SN_cod_retorno<>0 THEN
    		   RAISE error_ejecucion;
    		END IF;

    		-- Asociar a cliente..
      	    sSql:='GA_SERVICIOS_ABONADOS_PG.GA_ASOCIA_CLI_PR('||EN_cod_cliente||','||EN_ant_cod_cliente||','||EN_num_abonado||','||EN_cod_usuario||','||EN_cod_cuenta||');';
    		GA_SERVICIOS_ABONADOS_PG.GA_ASOCIA_CLI_PR(
    		   	  EN_cod_cliente,
    			  EN_ant_cod_cliente,
    		      EN_num_abonado,
    			  EN_cod_usuario,
    			  EN_cod_cuenta,
    			  SN_cod_retorno,
                  SV_mens_retorno,
                  SN_num_evento);

    		IF SN_cod_retorno<>0 THEN
    		   RAISE error_ejecucion;
    	   	END IF;



EXCEPTION
WHEN error_ejecucion THEN
                SN_cod_retorno := '302'; -- Nuevo error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion:  GA_CREA_ESTRUCTURA_ABONADO_PR('||EN_num_abonado||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_ACTIVA_PREPAGO_PR', sSql, SQLCODE, V_des_error );

WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := '302'; -- Nuevo error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('no_data_found:  GA_CREA_ESTRUCTURA_ABONADO_PR('||EN_num_abonado||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_ACTIVA_PREPAGO_PR', sSql, SQLCODE, V_des_error );
WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('others:  GA_CREA_ESTRUCTURA_ABONADO_PR('||EN_num_abonado||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ESTRUCTURA_PG.GA_ACTIVA_PREPAGO_PR', sSql, SQLCODE, V_des_error );
END GA_CREA_ESTRUCTURA_ABONADO_PR;

END GA_ESTRUCTURA_PG;
/
SHOW ERRORS
