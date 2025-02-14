CREATE OR REPLACE PACKAGE BODY VE_alta_cuenta_PG IS

	--------------------
	-- PROCEDIMIENTOS --
	--------------------
	-- RECOMPILACION
	PROCEDURE VE_getCuenta_PR(EV_codCuenta    IN  VARCHAR2,
	                          SV_desCuenta    OUT NOCOPY VARCHAR2,
				              SV_tipCuenta    OUT NOCOPY VARCHAR2,
				   			  SV_responsable  OUT NOCOPY VARCHAR2,
				   			  SV_codTipident  OUT NOCOPY VARCHAR2,
				   			  SV_numIdent     OUT NOCOPY VARCHAR2,
				   			  SV_codDirec     OUT NOCOPY VARCHAR2,
				   			  SV_fecAlta      OUT NOCOPY VARCHAR2,
				   			  SV_indEstado    OUT NOCOPY VARCHAR2,
				   			  SV_TelContacto  OUT NOCOPY VARCHAR2,
				   			  SV_indSector    OUT NOCOPY VARCHAR2,
				   			  SV_clasCta      OUT NOCOPY VARCHAR2,
				   			  SV_codCatribut  OUT NOCOPY VARCHAR2,
				   			  SV_codCategoria OUT NOCOPY VARCHAR2,
				   			  SV_codSector    OUT NOCOPY VARCHAR2,
				   			  SV_codSubCat    OUT NOCOPY VARCHAR2,
				   			  SV_indMultuso   OUT NOCOPY VARCHAR2,
				   			  SV_cliPotencial OUT NOCOPY VARCHAR2,
				   			  SV_razonSocial  OUT NOCOPY VARCHAR2,
				   			  SV_fecInVPac    OUT NOCOPY VARCHAR2,
				   			  SV_tipComis     OUT NOCOPY VARCHAR2,
				   			  SV_usuarAsesor  OUT NOCOPY VARCHAR2,
				   			  SV_fecNac       OUT NOCOPY VARCHAR2,
				   			  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       	  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                          SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_getCuenta_PR"
			Lenguaje="PL/SQL"
			Fecha="19-06-2007"
			Versión="1.0.0"
			Diseñador="wjrc"
			Programador="wjrc"
			Ambiente="BD"
		<Retorno>
				  Datos Cuenta
		 </Retorno>
		<Descripción>
				  Datos Cuenta
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom="EV_codCuenta"    Tipo="STRING"> Codigo Cuenta </param>
			 </Entrada>
	         <Salida>
			   <param nom="SV_desCuenta"    Tipo="STRING"> descripcion Cuenta </param>
			   <param nom="SV_tipCuenta"    Tipo="STRING"> Tipo de Cuenta I=Individual, E= Empresa </param>
			   <param nom="SV_responsable"  Tipo="STRING"> Nombre del Responsable </param>
			   <param nom="SV_codTipident"  Tipo="STRING"> Tipo de Identificacion</param>
			   <param nom="SV_numIdent"     Tipo="STRING"> Número de identificacion</param>
			   <param nom="SV_codDirec"     Tipo="STRING"> Codigo de Direccion</param>
			   <param nom="SV_fecAlta"      Tipo="STRING"> Fecha de Nacimiento </param>
			   <param nom="SV_indEstado"    Tipo="STRING"> Estado de la Cuenta</param>
			   <param nom="SV_TelContacto"  Tipo="STRING"> Telefono Contacto de la Cuenta</param>
			   <param nom="SV_indSector"    Tipo="STRING"> Indice Sector de la Cuenta</param>
			   <param nom="SV_clasCta"      Tipo="STRING"> Clase de la Cuenta</param>
			   <param nom="SV_codCatribut"  Tipo="STRING"> Codigo de Categoria Tributaria de la Cuenta</param>
			   <param nom="SV_codCategoria" Tipo="STRING"> Codigo de Categoria de la Cuenta</param>
			   <param nom="SV_codSector"    Tipo="STRING"> Codigo de sector de la Cuenta</param>
			   <param nom="SV_codSubCat"    Tipo="STRING"> Codigo de Subcategoria Tributaria de la Cuenta</param>
			   <param nom="SV_indMultuso"   Tipo="STRING"> Indicador de Multiples usos</param>
			   <param nom="SV_cliPotencial" Tipo="STRING"> Indicador de Cuenta Potencial </param>
			   <param nom="SV_razonSocial"  Tipo="STRING"> Indicador de Cuenta Potencial </param>
               <param nom="SV_fecInVPac"    Tipo="STRING"> Fecha de la primera venta PA </param>
			   <param nom="SV_tipComis"     Tipo="STRING"> Codigo de Tipo de Comisionista </param>
			   <param nom="SV_usuarAsesor"  Tipo="STRING"> Nombre Usuario asesor de la cuenta </param>
			   <param nom="SV_fecNac"       Tipo="STRING"> Fecha de Nacimiento </param>
			   <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		ERROR_SQL EXCEPTION;
		LV_desError ge_errores_pg.desevent;
		LV_sql		ge_errores_pg.vquery;
		LV_formatoFecha VARCHAR2(30);
		LV_formatoHora  VARCHAR2(30);
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		--  OBTENEMOS EL VALOR PARA FORMATO FECHA (SEL2)
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FORMATOSEL2,
  		                                                  CV_MODULO_GE,
  			                                              CV_PRODUCTO,
  														  LV_formatoFecha,
  														  SN_codRetorno,
  														  SV_menRetorno,
  														  SN_numEvento);
		IF (SN_codRetorno <> 0) THEN
		   RAISE ERROR_SQL;
		END IF;

		--  OBTENEMOS EL VALOR PARA FORMATO HORA (SEL7)
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FORMATOSEL7,
  		                                                  CV_MODULO_GE,
  			                                              CV_PRODUCTO,
  														  LV_formatoHora,
  														  SN_codRetorno ,
  														  SV_menRetorno,
  														  SN_numEvento);

		IF (SN_codRetorno <> 0) THEN
		   RAISE ERROR_SQL;
		END IF;

		LV_Sql:=' SELECT a.DES_CUENTA,'
		         || 'a.TIP_CUENTA,'
                 || 'a.NOM_RESPONSABLE,'
                 || 'a.COD_TIPIDENT,'
                 || 'a.NUM_IDENT,'
                 || 'a.COD_DIRECCION,'
                 || 'a.FEC_ALTA,'
                 || 'a.IND_ESTADO,'
                 || 'a.TEL_CONTACTO,'
                 || 'a.IND_SECTOR,'
                 || 'a.COD_CLASCTA,'
                 || 'a.COD_CATRIBUT,'
                 || 'a.COD_CATEGORIA,'
                 || 'a.COD_SECTOR,'
                 || 'a.COD_SUBCATEGORIA,'
                 || 'a.IND_MULTUSO,'
                 || 'a.IND_CLIEPOTENCIAL,'
                 || 'a.DES_RAZON_SOCIAL,'
                 || 'a.FEC_INIVTA_PAC,'
                 || 'a.COD_TIPCOMIS,'
                 || 'a.NOM_USUARIO_ASESOR,'
                 || 'a.FEC_NACIMIENTO'
			     || 'FROM ga_cuentas a '
		   	     || 'WHERE a.cod_cuenta = ' || EV_codCuenta;

		  SELECT a.des_cuenta,
		         a.tip_cuenta,
                 a.nom_responsable,
                 a.cod_tipident,
                 a.num_ident,
                 a.cod_direccion,
                 TO_CHAR(a.fec_alta, LV_formatoFecha || LV_formatoHora ),
                 a.ind_estado,
                 a.tel_contacto,
                 a.ind_sector,
                 a.cod_clascta,
                 a.cod_catribut,
                 a.cod_categoria,
                 a.cod_sector,
                 a.cod_subcategoria,
                 a.ind_multuso,
                 a.ind_cliepotencial,
                 a.des_razon_social,
                 TO_CHAR(a.fec_inivta_pac, LV_formatoFecha || LV_formatoHora ),
                 a.cod_tipcomis,
                 a.nom_usuario_asesor,
                 TO_CHAR(a.fec_nacimiento, LV_formatoFecha || LV_formatoHora )
		  INTO SV_desCuenta,
               SV_tipCuenta,
               SV_responsable,
               SV_codTipident,
               SV_numIdent,
               SV_codDirec,
               SV_fecAlta,
               SV_indEstado,
               SV_TelContacto,
               SV_indSector,
               SV_clasCta,
               SV_codCatribut,
               SV_codCategoria,
               SV_codSector,
               SV_codSubCat,
               SV_indMultuso,
               SV_cliPotencial,
               SV_razonSocial,
               SV_fecInVPac,
               SV_tipComis,
               SV_usuarAsesor,
               SV_fecNac
 	      FROM ga_cuentas a
   	      WHERE a.cod_cuenta = EV_codCuenta;

	EXCEPTION
		   WHEN NO_DATA_FOUND THEN
				SN_codRetorno := 512;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := 'LA CUENTA SELECCIONADA NO EXISTE';
				END IF;
				LV_desError  := 'NO_DATA_FOUND:VE_alta_cuenta_PG.VE_getCuenta_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
				'VE_alta_cuenta_PG.VE_getCuenta_PR', LV_Sql, SQLCODE, LV_desError );
	       WHEN OTHERS THEN
			    SN_codRetorno := 513;
		   	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
			       SV_menRetorno := 'ERROR AL OBTENER CUENTA';
			    END IF;
		 	    LV_desError  := 'OTHERS:VE_alta_cuenta_PG.VE_getCuenta_PR;- ' || SQLERRM;
			    SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
		  	    'VE_alta_cuenta_PG.VE_getCuenta_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_getCuenta_PR;

	PROCEDURE VE_getCuentaIdentif_PR(EV_codTipident  IN  VARCHAR2,
				   			  		 EV_numIdent     IN  VARCHAR2,
									 SV_codCuenta    OUT NOCOPY VARCHAR2,
	                                 SV_desCuenta    OUT NOCOPY VARCHAR2,
				              		 SV_tipCuenta    OUT NOCOPY VARCHAR2,
				   			  		 SV_responsable  OUT NOCOPY VARCHAR2,
				   			  		 SV_codDirec     OUT NOCOPY VARCHAR2,
				   			  		 SV_fecAlta      OUT NOCOPY VARCHAR2,
				   			  		 SV_indEstado    OUT NOCOPY VARCHAR2,
				   			  		 SV_TelContacto  OUT NOCOPY VARCHAR2,
				   			  		 SV_indSector    OUT NOCOPY VARCHAR2,
				   			  		 SV_clasCta      OUT NOCOPY VARCHAR2,
				   			  		 SV_codCatribut  OUT NOCOPY VARCHAR2,
				   			  		 SV_codCategoria OUT NOCOPY VARCHAR2,
				   			  		 SV_codSector    OUT NOCOPY VARCHAR2,
				   			  		 SV_codSubCat    OUT NOCOPY VARCHAR2,
				   			  		 SV_indMultuso   OUT NOCOPY VARCHAR2,
				   			  		 SV_cliPotencial OUT NOCOPY VARCHAR2,
				   			  		 SV_razonSocial  OUT NOCOPY VARCHAR2,
				   			  		 SV_fecInVPac    OUT NOCOPY VARCHAR2,
				   			  		 SV_tipComis     OUT NOCOPY VARCHAR2,
				   			  		 SV_usuarAsesor  OUT NOCOPY VARCHAR2,
				   			  		 SV_fecNac       OUT NOCOPY VARCHAR2,
				   			  		 SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       	  		 SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                          		 SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_getCuentaIdentif_PR"
			Lenguaje="PL/SQL"
			Fecha="19-06-2007"
			Versión="1.0.0"
			Diseñador="wjrc"
			Programador="wjrc"
			Ambiente="BD"
		<Retorno>
				  Datos Cuenta
		 </Retorno>
		<Descripción>
				  Datos Cuenta por numero identificacion
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom="EV_codTipident"  Tipo="STRING"> Tipo de Identificacion</param>
			   <param nom="EV_numIdent"     Tipo="STRING"> Número de identificacion</param>
			 </Entrada>
	         <Salida>
			   <param nom="SV_codCuenta"    Tipo="STRING"> Codigo Cuenta </param>
			   <param nom="SV_desCuenta"    Tipo="STRING"> descripcion Cuenta </param>
			   <param nom="SV_tipCuenta"    Tipo="STRING"> Tipo de Cuenta I=Individual, E= Empresa </param>
			   <param nom="SV_responsable"  Tipo="STRING"> Nombre del Responsable </param>
			   <param nom="SV_codDirec"     Tipo="STRING"> Codigo de Direccion</param>
			   <param nom="SV_fecAlta"      Tipo="STRING"> Fecha de Nacimiento </param>
			   <param nom="SV_indEstado"    Tipo="STRING"> Estado de la Cuenta</param>
			   <param nom="SV_TelContacto"  Tipo="STRING"> Telefono Contacto de la Cuenta</param>
			   <param nom="SV_indSector"    Tipo="STRING"> Indice Sector de la Cuenta</param>
			   <param nom="SV_clasCta"      Tipo="STRING"> Clase de la Cuenta</param>
			   <param nom="SV_codCatribut"  Tipo="STRING"> Codigo de Categoria Tributaria de la Cuenta</param>
			   <param nom="SV_codCategoria" Tipo="STRING"> Codigo de Categoria de la Cuenta</param>
			   <param nom="SV_codSector"    Tipo="STRING"> Codigo de sector de la Cuenta</param>
			   <param nom="SV_codSubCat"    Tipo="STRING"> Codigo de Subcategoria Tributaria de la Cuenta</param>
			   <param nom="SV_indMultuso"   Tipo="STRING"> Indicador de Multiples usos</param>
			   <param nom="SV_cliPotencial" Tipo="STRING"> Indicador de Cuenta Potencial </param>
			   <param nom="SV_razonSocial"  Tipo="STRING"> Indicador de Cuenta Potencial </param>
               <param nom="SV_fecInVPac"    Tipo="STRING"> Fecha de la primera venta PA </param>
			   <param nom="SV_tipComis"     Tipo="STRING"> Codigo de Tipo de Comisionista </param>
			   <param nom="SV_usuarAsesor"  Tipo="STRING"> Nombre Usuario asesor de la cuenta </param>
			   <param nom="SV_fecNac"       Tipo="STRING"> Fecha de Nacimiento </param>
			   <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		ERROR_SQL EXCEPTION;
		LV_desError ge_errores_pg.desevent;
		LV_sql		ge_errores_pg.vquery;
		LV_formatoFecha VARCHAR2(30);
		LV_formatoHora  VARCHAR2(30);
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		--  OBTENEMOS EL VALOR PARA FORMATO FECHA (SEL2)
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FORMATOSEL2,
  		                                                  CV_MODULO_GE,
  			                                              CV_PRODUCTO,
  														  LV_formatoFecha,
  														  SN_codRetorno,
  														  SV_menRetorno,
  														  SN_numEvento);
		IF (SN_codRetorno <> 0) THEN
		   RAISE ERROR_SQL;
		END IF;

		--  OBTENEMOS EL VALOR PARA FORMATO HORA (SEL7)
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FORMATOSEL7,
  		                                                  CV_MODULO_GE,
  			                                              CV_PRODUCTO,
  														  LV_formatoHora,
  														  SN_codRetorno ,
  														  SV_menRetorno,
  														  SN_numEvento);

		IF (SN_codRetorno <> 0) THEN
		   RAISE ERROR_SQL;
		END IF;

		LV_Sql:=' SELECT a.cod_cuenta,'
		         || 'a.DES_CUENTA,'
		         || 'a.TIP_CUENTA,'
                 || 'a.NOM_RESPONSABLE,'
                 || 'a.COD_DIRECCION,'
                 || 'a.FEC_ALTA,'
                 || 'a.IND_ESTADO,'
                 || 'a.TEL_CONTACTO,'
                 || 'a.IND_SECTOR,'
                 || 'a.COD_CLASCTA,'
                 || 'a.COD_CATRIBUT,'
                 || 'a.COD_CATEGORIA,'
                 || 'a.COD_SECTOR,'
                 || 'a.COD_SUBCATEGORIA,'
                 || 'a.IND_MULTUSO,'
                 || 'a.IND_CLIEPOTENCIAL,'
                 || 'a.DES_RAZON_SOCIAL,'
                 || 'a.FEC_INIVTA_PAC,'
                 || 'a.COD_TIPCOMIS,'
                 || 'a.NOM_USUARIO_ASESOR,'
                 || 'a.FEC_NACIMIENTO'
			     || 'FROM ga_cuentas a '
		   	     || 'WHERE a.cod_tipident = ' || EV_codTipident
				 || 'AND a.num_ident = ' || EV_numIdent;

		  SELECT a.cod_cuenta,
		  		 a.des_cuenta,
		         a.tip_cuenta,
                 a.nom_responsable,
                 a.cod_direccion,
                 TO_CHAR(a.fec_alta, LV_formatoFecha || LV_formatoHora ),
                 a.ind_estado,
                 a.tel_contacto,
                 a.ind_sector,
                 a.cod_clascta,
                 a.cod_catribut,
                 a.cod_categoria,
                 a.cod_sector,
                 a.cod_subcategoria,
                 a.ind_multuso,
                 a.ind_cliepotencial,
                 a.des_razon_social,
                 TO_CHAR(a.fec_inivta_pac, LV_formatoFecha || LV_formatoHora ),
                 a.cod_tipcomis,
                 a.nom_usuario_asesor,
                 TO_CHAR(a.fec_nacimiento, LV_formatoFecha || LV_formatoHora )
		  INTO SV_codCuenta,
		  	   SV_desCuenta,
               SV_tipCuenta,
               SV_responsable,
               SV_codDirec,
               SV_fecAlta,
               SV_indEstado,
               SV_TelContacto,
               SV_indSector,
               SV_clasCta,
               SV_codCatribut,
               SV_codCategoria,
               SV_codSector,
               SV_codSubCat,
               SV_indMultuso,
               SV_cliPotencial,
               SV_razonSocial,
               SV_fecInVPac,
               SV_tipComis,
               SV_usuarAsesor,
               SV_fecNac
 	      FROM ga_cuentas a
		  WHERE a.cod_tipident = EV_codTipident
		  AND a.num_ident = EV_numIdent;

	EXCEPTION
		   WHEN NO_DATA_FOUND THEN
				SN_codRetorno := 1;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'NO_DATA_FOUND:VE_alta_cuenta_PG.VE_getCuentaIdentif_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
				'VE_alta_cuenta_PG.VE_getCuentaIdentif_PR', LV_Sql, SQLCODE, LV_desError );
	       WHEN OTHERS THEN
			    SN_codRetorno := 156;
		   	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
			       SV_menRetorno := CV_ERRORNOCLASIF;
			    END IF;
		 	    LV_desError  := 'OTHERS:VE_alta_cuenta_PG.VE_getCuentaIdentif_PR;- ' || SQLERRM;
			    SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
		  	    'VE_alta_cuenta_PG.VE_getCuentaIdentif_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_getCuentaIdentif_PR;

	--------------------------------------------------------------------------------------------
	--* CURSORES - LISTAS
	--------------------------------------------------------------------------------------------

	PROCEDURE VE_getListCuentas_PR(EV_criterioBusq IN VARCHAR2,
	                               EV_filtro       IN VARCHAR2,
								   EV_valorBusq    IN VARCHAR2,
								   EV_tipoIdentif  IN VARCHAR2,
	                               SC_cursorDatos  OUT NOCOPY REFCURSOR,
								   SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       		   SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                       		   SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_getListCuentas_PR"
			Lenguaje="PL/SQL"
			Fecha="22-05-2007"
			Versión="1.0.0"
			Diseñador="wjrc"
			Programador="wjrc"
			Ambiente="BD"
		<Retorno>
				  Cursor
		</Retorno>
		<Descripción>
				  Retorna listado de cuentas segun parametros

				  Criterios; NI (numero identificador)
				             CC (codigo cliente)
							 NC (nombre cliente)
							 DC (descripcion cuenta)

				  Filtro: I (igual a)
				          C (contiene)

		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom="EV_criterioBusq" Tipo="STRING"> criterio de busqueda </param>
			   <param nom="EV_filtro"       Tipo="STRING"> filtro de busqueda </param>
			   <param nom="EV_valorBusq"    Tipo="STRING"> valor de busqueda </param>
			   <param nom="EV_tipoIdentif"  Tipo="STRING"> tipo identificador </param>
			 </Entrada>
	         <Salida>
			   <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor cuentas </param>
			   <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

		CURSOR lc_cursor(entrada VARCHAR2) IS
		SELECT
		'CUE',
		a.cod_cuenta,
		a.cod_tipident,
		b.des_tipident,
		a.num_ident,
		a.des_cuenta
		FROM   ga_cuentas a, ge_tipident b
		WHERE  a.cod_tipident = b.cod_tipident
		AND  a.des_cuenta = entrada;

		NO_DATA_FOUND_CURSOR EXCEPTION;
		ERROR_PARAMETROS EXCEPTION;

		CV_NUMIDENTIF CONSTANT VARCHAR2(2)  := 'NI';
		CV_CODCLIENTE CONSTANT VARCHAR2(2)  := 'CC';
		CV_NOMCLIENTE CONSTANT VARCHAR2(2)  := 'NC';
		CV_DESCCUENTA CONSTANT VARCHAR2(2)  := 'DC';
		CV_ESIGUALA   CONSTANT VARCHAR2(1)  := 'I';
		CV_CONTIENE   CONSTANT VARCHAR2(1)  := 'C';

		LV_desError  ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;
		LN_contador  NUMBER;
	 BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		LN_contador := 0;

		IF EV_criterioBusq = CV_NUMIDENTIF THEN

			SELECT COUNT(1)
			INTO LN_contador
			FROM ga_cuentas a, ge_tipident b
			WHERE  a.cod_tipident = b.cod_tipident
			AND a.COD_TIPIDENT = EV_tipoIdentif
			AND a.NUM_IDENT = EV_valorBusq;

			LV_Sql := 'SELECT '
			          || '''CUE'', '
					  || 'a.cod_cuenta, '
					  || 'a.cod_tipident, '
					  || 'b.des_tipident, '
					  || 'a.num_ident, '
					  || 'a.des_cuenta, '
					  || 'a.tip_cuenta '
	                  || 'FROM   ga_cuentas a, ge_tipident b '
	                  || 'WHERE  a.cod_tipident = b.cod_tipident '
					  || ' AND a.cod_tipident = ''' || EV_tipoIdentif || ''' '
	                  || ' AND a.num_ident = ''' || EV_valorBusq || ''' ';

			IF (LN_contador = 0) THEN

				SELECT COUNT(1)
				INTO LN_contador
				FROM ge_clientes c, ga_cuentas a, ge_tipident b
				WHERE c.cod_tipident = EV_tipoIdentif
				AND c.num_ident = EV_valorBusq
				AND c.COD_CUENTA = a.COD_CUENTA
				AND a.COD_TIPIDENT = b.COD_TIPIDENT;

				LV_Sql := 'SELECT DISTINCT '
				          || '''CUE2'', '
						  || 'a.cod_cuenta, '
						  || 'a.cod_tipident, '
						  || 'b.des_tipident, '
						  || 'a.num_ident, '
					  	  || 'a.des_cuenta, '
					  	  || 'a.tip_cuenta '
		                  || 'FROM ge_clientes c, ga_cuentas a, ge_tipident b '
						  || 'WHERE c.cod_tipident = ''' || EV_tipoIdentif || ''' '
					      || ' AND c.num_ident = ''' || EV_valorBusq || ''' '
		                  || ' AND c.COD_CUENTA = a.COD_CUENTA '
		                  || ' AND a.COD_TIPIDENT = b.COD_TIPIDENT ';

			END IF;

		ELSIF EV_criterioBusq = CV_CODCLIENTE THEN

			SELECT COUNT(1)
			INTO LN_contador
			FROM ge_clientes c, ga_cuentas a, ge_tipident b
			WHERE c.cod_cliente = EV_valorBusq
			AND c.COD_CUENTA = a.COD_CUENTA
			AND a.COD_TIPIDENT = b.COD_TIPIDENT;

			LV_Sql := 'SELECT '
			          || '''CUE'', '
					  || 'a.cod_cuenta, '
					  || 'a.cod_tipident, '
					  || 'b.des_tipident, '
					  || 'a.num_ident, '
					  || 'a.des_cuenta, '
					  || 'a.tip_cuenta '
	                  || 'FROM ge_clientes c, ga_cuentas a, ge_tipident b '
					  || 'WHERE c.cod_cliente = ' || EV_valorBusq
	                  || ' AND c.COD_CUENTA = a.COD_CUENTA '
	                  || ' AND a.COD_TIPIDENT = b.COD_TIPIDENT ';

		ELSIF EV_criterioBusq = CV_NOMCLIENTE THEN
				IF EV_filtro = CV_ESIGUALA THEN

					SELECT COUNT(1)
					INTO LN_contador
					FROM ge_clientes c, ga_cuentas a, ge_tipident b
					WHERE c.nom_cliente = EV_valorBusq
					AND c.COD_CUENTA = a.COD_CUENTA
					AND a.COD_TIPIDENT = b.COD_TIPIDENT;

					LV_Sql := 'SELECT DISTINCT '
					          || '''CUE'', '
							  || 'a.cod_cuenta, '
							  || 'a.cod_tipident, '
							  || 'b.des_tipident, '
							  || 'a.num_ident, '
					  		  || 'a.des_cuenta, '
					  		  || 'a.tip_cuenta '
			                  || 'FROM ge_clientes c, ga_cuentas a, ge_tipident b '
							  || 'WHERE c.nom_cliente = ''' || EV_valorBusq || ''' '
			                  || ' AND c.COD_CUENTA = a.COD_CUENTA '
			                  || ' AND a.COD_TIPIDENT = b.COD_TIPIDENT ';

				ELSIF EV_filtro = CV_CONTIENE THEN

					SELECT COUNT(1)
					INTO LN_contador
					FROM ge_clientes c, ga_cuentas a, ge_tipident b
					WHERE c.nom_cliente LIKE '%'|| EV_valorBusq || '%'
					AND c.COD_CUENTA = a.COD_CUENTA
					AND a.COD_TIPIDENT = b.COD_TIPIDENT;

					LV_Sql := 'SELECT DISTINCT '
					          || '''CUE'', '
							  || 'a.cod_cuenta, '
							  || 'a.cod_tipident, '
							  || 'b.des_tipident, '
							  || 'a.num_ident, '
					  		  || 'a.des_cuenta, '
					  		  || 'a.tip_cuenta '
			                  || 'FROM ge_clientes c, ga_cuentas a, ge_tipident b '
							  || 'WHERE c.nom_cliente LIKE ''%' || EV_valorBusq || '%'' '
			                  || 'AND c.COD_CUENTA = a.COD_CUENTA '
			                  || 'AND a.COD_TIPIDENT = b.COD_TIPIDENT ';

				ELSE
					RAISE ERROR_PARAMETROS;
				END IF;

		ELSIF EV_criterioBusq = CV_DESCCUENTA THEN
				IF EV_filtro = CV_ESIGUALA THEN

					SELECT COUNT(1)
					INTO LN_contador
					FROM ga_cuentas a, ge_tipident b
					WHERE  a.cod_tipident = b.cod_tipident
					AND a.des_cuenta = EV_valorBusq;

					LV_Sql := 'SELECT '
					          || '''CUE'', '
							  || 'a.cod_cuenta, '
							  || 'a.cod_tipident, '
							  || 'b.des_tipident, '
							  || 'a.num_ident, '
					  		  || 'a.des_cuenta, '
					  		  || 'a.tip_cuenta '
			                  || ' FROM   ga_cuentas a, ge_tipident b '
			                  || ' WHERE  a.cod_tipident = b.cod_tipident '
			                  || ' AND a.des_cuenta = ''' || EV_valorBusq || ''' ';

							  --OPEN lc_cursor(EV_valorBusq);

				ELSIF EV_filtro = CV_CONTIENE THEN

					SELECT COUNT(1)
					INTO LN_contador
					FROM ga_cuentas a, ge_tipident b
                    WHERE a.des_cuenta LIKE '%' || EV_valorBusq || '%'
					AND  a.cod_tipident = b.cod_tipident;

					LV_Sql := 'SELECT '
					          || '''CUE'', '
							  || 'a.cod_cuenta, '
							  || 'a.cod_tipident, '
							  || 'b.des_tipident, '
							  || 'a.num_ident, '
					  		  || 'a.des_cuenta, '
					  		  || 'a.tip_cuenta '
			                  || ' FROM   ga_cuentas a, ge_tipident b '
			                  || ' WHERE a.des_cuenta LIKE ''%' || EV_valorBusq || '%'' '
			                  || ' AND a.cod_tipident = b.cod_tipident';

				ELSE
					RAISE ERROR_PARAMETROS;
				END IF;
		ELSE
			RAISE ERROR_PARAMETROS;
		END IF;

		OPEN SC_cursordatos FOR LV_Sql;

		IF (LN_contador = 0) THEN
			RAISE NO_DATA_FOUND_CURSOR;
		END IF;

	EXCEPTION
			WHEN ERROR_PARAMETROS THEN
				 SN_codRetorno:=2;
				 SV_menRetorno := CV_ERRORNOCLASIF;
			WHEN NO_DATA_FOUND_CURSOR THEN
				 SN_codRetorno:=1;
		         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
		            SV_menRetorno := CV_ERRORNOCLASIF;
		         END IF;
		         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cuenta_PG.VE_getListCuentas_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
		         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
				 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cuenta_PG.VE_getListCuentas_PR', LV_Sql, SN_codRetorno, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:VE_alta_cuenta_PG.VE_getListCuentas_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'VE_alta_cuenta_PG.VE_getListCuentas_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_getListCuentas_PR;

	PROCEDURE VE_getListClasifCuenta_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
								        SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       		        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                       		        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_getListClasifCuenta_PR"
			Lenguaje="PL/SQL"
			Fecha="22-05-2007"
			Versión="1.0.0"
			Diseñador="wjrc"
			Programador="wjrc"
			Ambiente="BD"
		<Retorno>
				  Cursor
		</Retorno>
		<Descripción>
				  Retorna lista de clasificaciones de una cuenta
		</Descripción>
		<Parámetros>
	         <Entrada> N/A </Entrada>
	         <Salida>
			   <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor clasificaciones cuenta </param>
			   <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		NO_DATA_FOUND_CURSOR EXCEPTION;
		LV_desError  ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;
		LN_contador  NUMBER;
	 BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		LV_Sql:='SELECT a.cod_clascta,a.des_clascta '
			|| 'FROM ge_clascta a '
            || 'ORDER BY a.des_clascta';

		LN_contador := 0;
		SELECT COUNT(1)
		INTO LN_contador
		FROM ge_clascta;

		OPEN SC_cursorDatos FOR
		SELECT a.cod_clascta,a.des_clascta
		FROM   ge_clascta a
        ORDER BY a.des_clascta;

		IF (LN_contador = 0) THEN
			RAISE NO_DATA_FOUND_CURSOR;
		END IF;

	EXCEPTION
			WHEN NO_DATA_FOUND_CURSOR THEN
				 SN_codRetorno:=1;
		         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
		            SV_menRetorno := CV_ERRORNOCLASIF;
		         END IF;
		         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cuenta_PG.VE_getListClasifCuenta_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
		         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
				 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cuenta_PG.VE_getListClasifCuenta_PR', LV_Sql, SN_codRetorno, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:VE_alta_cuenta_PG.VE_getListClasifCuenta_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'VE_alta_cuenta_PG.VE_getListClasifCuenta_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_getListClasifCuenta_PR;

	--------------------------------------------------------------------------------------------
	--* INSERTS y UPDATES
	--------------------------------------------------------------------------------------------

	PROCEDURE VE_insCuenta_PR(EV_codCuenta    IN  VARCHAR2,
	                          EV_desCuenta    IN  VARCHAR2,
				              EV_tipCuenta    IN  VARCHAR2,
				   			  EV_responsable  IN  VARCHAR2,
				   			  EV_codTipident  IN  VARCHAR2,
				   			  EV_numIdent     IN  VARCHAR2,
				   			  EV_codDirec     IN  VARCHAR2,
				   			  EV_indEstado    IN  VARCHAR2,
				   			  EV_TelContacto  IN  VARCHAR2,
				   			  EV_indSector    IN  VARCHAR2,
				   			  EV_clasCta      IN  VARCHAR2,
				   			  EV_codCatribut  IN  VARCHAR2,
				   			  EV_codCategoria IN  VARCHAR2,
				   			  EV_codSector    IN  VARCHAR2,
				   			  EV_codSubCat    IN  VARCHAR2,
				   			  EV_indMultuso   IN  VARCHAR2,
				   			  EV_cliPotencial IN  VARCHAR2,
				   			  EV_razonSocial  IN  VARCHAR2,
				   			  EV_fecInVPac    IN  VARCHAR2,
				   			  EV_tipComis     IN  VARCHAR2,
				   			  EV_usuarAsesor  IN  VARCHAR2,
				   			  EV_fecNac       IN  VARCHAR2,
				   			  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       	  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                          SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_insCuenta_PR"
			Lenguaje="PL/SQL"
			Fecha="08-06-2007"
			Versión="1.0.0"
			Diseñador="wjrc"
			Programador="NRCA"
			Ambiente="BD"
		<Retorno> N/A </Retorno>
		<Descripción>
				  Inserta Cuenta
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom="EV_codCuenta"    Tipo="STRING"> Codigo Cuenta </param>
			   <param nom="EV_desCuenta"    Tipo="STRING"> descripcion Cuenta </param>
			   <param nom="EV_tipCuenta"    Tipo="STRING"> Tipo de Cuenta I=Individual, E= Empresa </param>
			   <param nom="EV_responsable"  Tipo="STRING"> Nombre del Responsable </param>
			   <param nom="EV_codTipident"  Tipo="STRING"> Tipo de Identificacion</param>
			   <param nom="EV_numIdent"     Tipo="STRING"> Número de identificacion</param>
			   <param nom="EV_codDirec"     Tipo="STRING"> Codigo de Direccion</param>
			   <param nom="EV_indEstado"    Tipo="STRING"> Estado de la Cuenta</param>
			   <param nom="EV_TelContacto"  Tipo="STRING"> Telefono Contacto de la Cuenta</param>
			   <param nom="EV_indSector"    Tipo="STRING"> Indice Sector de la Cuenta</param>
			   <param nom="EV_clasCta"      Tipo="STRING"> Clase de la Cuenta</param>
			   <param nom="EV_codCatribut"  Tipo="STRING"> Codigo de Categoria Tributaria de la Cuenta</param>
			   <param nom="EV_codCategoria" Tipo="STRING"> Codigo de Categoria de la Cuenta</param>
			   <param nom="EV_codSector"    Tipo="STRING"> Codigo de sector de la Cuenta</param>
			   <param nom="EV_codSubCat"    Tipo="STRING"> Codigo de Subcategoria Tributaria de la Cuenta</param>
			   <param nom="EV_indMultuso"   Tipo="STRING"> Indicador de Multiples usos</param>
			   <param nom="EV_cliPotencial" Tipo="STRING"> Indicador de Cuenta Potencial </param>
			   <param nom="EV_razonSocial"  Tipo="STRING"> Indicador de Cuenta Potencial </param>
               <param nom="EV_fecInVPac"    Tipo="STRING"> Fecha de la primera venta PA </param>
			   <param nom="EV_tipComis"     Tipo="STRING"> Codigo de Tipo de Comisionista </param>
			   <param nom="EV_usuarAsesor"  Tipo="STRING"> Nombre Usuario asesor de la cuenta </param>
			   <param nom="EV_fecNac"       Tipo="STRING"> Fecha de Nacimiento </param>
			 </Entrada>
	         <Salida>
			   <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		LV_desError ge_errores_pg.desevent;
		LV_sql		ge_errores_pg.vquery;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		LV_Sql:='INSERT INTO ga_cuentas('
		         || 'cod_cuenta,'
				 || 'des_cuenta,'
				 || 'tip_cuenta,'
                 || 'nom_responsable,'
                 || 'cod_tipident,'
                 || 'num_ident,'
                 || 'cod_direccion,'
                 || 'fec_alta,'
                 || 'ind_estado,'
                 || 'tel_contacto,'
                 || 'ind_sector,'
                 || 'cod_clascta,'
                 || 'cod_catribut,'
                 || 'cod_categoria,'
                 || 'cod_sector,'
                 || 'cod_subcategoria,'
                 || 'ind_multuso,'
                 || 'ind_cliepotencial,'
                 || 'des_razon_social,'
                 || 'fec_inivta_pac,'
                 || 'cod_tipcomis,'
                 || 'nom_usuario_asesor,'
                 || 'fec_nacimiento)'
			     || 'VALUES (';

 		IF (EV_codCuenta IS NOT NULL) AND (length(EV_codCuenta) > 0) THEN
			LV_Sql:= LV_Sql || EV_codCuenta;
		ELSE
			LV_Sql:= LV_Sql || 'NULL';
		END IF;
 		IF (EV_desCuenta IS NOT NULL) AND (length(EV_desCuenta) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || substr(EV_desCuenta,1,50) || '''';  -- 72181 24/11/2008 JMC
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_tipCuenta IS NOT NULL) AND (length(EV_tipCuenta) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_tipCuenta || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_responsable IS NOT NULL) AND (length(EV_responsable) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || substr(EV_responsable,1,50) || '''';  -- 72181 24/11/2008 JMC
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_codTipident IS NOT NULL) AND (length(EV_codTipident) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_codTipident || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_numIdent IS NOT NULL) AND (length(EV_numIdent) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_numIdent || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_codDirec IS NOT NULL) AND (length(EV_codDirec) > 0) THEN
			LV_Sql:= LV_Sql || ',' || EV_codDirec;
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;

		LV_Sql:= LV_Sql || ',SYSDATE';


 		IF (EV_indEstado IS NOT NULL) AND (length(EV_indEstado) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_indEstado || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_TelContacto IS NOT NULL) AND (length(EV_TelContacto) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_TelContacto || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_indSector IS NOT NULL) AND (length(EV_indSector) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_indSector || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_clasCta IS NOT NULL) AND (length(EV_clasCta) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_clasCta || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_codCatribut IS NOT NULL) AND (length(EV_codCatribut) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_codCatribut || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_codCategoria IS NOT NULL) AND (length(EV_codCategoria) > 0) THEN
			LV_Sql:= LV_Sql || ',' || EV_codCategoria;
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
		--inc. 63316 13-03-2008
 		--IF (EV_codSector IS NOT NULL) AND (length(EV_codSector) > 0) THEN
 		IF (EV_codSector IS NOT NULL) AND (length(EV_codSector) > 0) AND (TRIM(EV_codSector)<>'0')THEN
 		--fin inc. 63316 13-03-2008
			LV_Sql:= LV_Sql || ',' || EV_codSector;
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_codSubCat IS NOT NULL) AND (length(EV_codSubCat) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_codSubCat || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_indMultuso IS NOT NULL) AND (length(EV_indMultuso) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_indMultuso || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_cliPotencial IS NOT NULL) AND (length(EV_cliPotencial) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_cliPotencial || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_razonSocial IS NOT NULL) AND (length(EV_razonSocial) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || substr(EV_razonSocial,1,50) || ''''; -- 72181 24/11/2008 JMC
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_fecInVPac IS NOT NULL) AND (length(EV_fecInVPac) > 0) THEN
			LV_Sql:= LV_Sql || ',' || EV_fecInVPac;
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_tipComis IS NOT NULL) AND (length(EV_tipComis) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_tipComis || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_usuarAsesor IS NOT NULL) AND (length(EV_usuarAsesor) > 0) THEN
			LV_Sql:= LV_Sql || ',''' || EV_usuarAsesor || '''';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
 		IF (EV_fecNac IS NOT NULL) AND (length(EV_fecNac) > 0) THEN
			LV_Sql:= LV_Sql || ',TO_DATE(''' || EV_fecNac || ''',''' || CV_FORMATOFECHA || ''')';
		ELSE
			LV_Sql:= LV_Sql || ',NULL';
		END IF;
		LV_Sql:= LV_Sql || ')';

    	EXECUTE IMMEDIATE LV_Sql;

	EXCEPTION
	       WHEN OTHERS THEN
		    SN_codRetorno := 156;
	   	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
		       SV_menRetorno := CV_ERRORNOCLASIF;
		    END IF;
	 	    LV_desError  := 'OTHERS:VE_alta_cuenta_PG.VE_insCuenta_PR;- ' || SQLERRM;
		    SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
	  	    'VE_alta_cuenta_PG.VE_insCuenta_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_insCuenta_PR;

	PROCEDURE VE_insSubCuenta_PR(EV_codCuenta    IN  VARCHAR2,
	                             EV_codSubCuenta IN  VARCHAR2,
	                             EV_desSubCuenta IN  VARCHAR2,
				   			     EV_codDirec     IN  VARCHAR2,
				   			     SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       	     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                             SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_insSubCuenta_PR"
			Lenguaje="PL/SQL"
			Fecha="08-06-2007"
			Versión="1.0.0"
			Diseñador="wjrc"
			Programador="NRCA"
			Ambiente="BD"
		<Retorno> N/A </Retorno>
		<Descripción>
				  Inserta SubCuenta
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom="EV_codCuenta"    Tipo="STRING"> Codigo Cuenta </param>
			   <param nom="EV_codSubCuenta" Tipo="STRING"> Codigo SubCuenta </param>
			   <param nom="EV_desSubCuenta" Tipo="STRING"> descripcion SubCuenta </param>
			   <param nom="EV_codDirec"     Tipo="STRING"> Codigo de Direccion</param>
			 </Entrada>
	         <Salida>
			   <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		LV_desError ge_errores_pg.desevent;
		LV_sql		ge_errores_pg.vquery;
		LV_codDirec ga_subcuentas.cod_direccion%type;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

                -- Inc. : 72181
                -- Fecha: 10/11/2008
                -- prog.: JMC
                If trim(EV_codDirec) = '0' or trim(EV_codDirec) is null then
                   LV_Sql := 'SELECT cod_direccion INTO LV_codDirec FROM ga_cuentas WHERE cod_cuenta = ' ||EV_codCuenta;


                   SELECT cod_direccion
                   INTO LV_codDirec
                   FROM ga_cuentas
                   WHERE cod_cuenta = EV_codCuenta;

                else
                   LV_codDirec := EV_codDirec;
                end if;
                -- Fin Inc. 72181

		LV_Sql:='INSERT INTO ga_subcuentas(cod_cuenta,cod_subcuenta,des_subcuenta,'
                 || 'cod_direccion,'
                 || 'fec_alta) '
			     || 'VALUES ('|| EV_codCuenta||', '
			     || EV_codSubCuenta||','
			     || substr(EV_desSubCuenta,1,30) ||',' -- 72181 24/11/2008 JMC
  			     || LV_codDirec||','
			     || 'SYSDATE)';

		   INSERT INTO ga_subcuentas(
		           cod_cuenta,
		           cod_subcuenta,
                   des_subcuenta,
                   cod_direccion,
                   fec_alta)
                VALUES
                  (EV_codCuenta,
		   EV_codSubCuenta,
                   substr(EV_desSubCuenta,1,30), --Inc. 72181 JMC 23-10-2008
                   LV_codDirec,
                   SYSDATE);

	EXCEPTION
	       WHEN OTHERS THEN
		    SN_codRetorno := 156;
	   	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
		       SV_menRetorno := CV_ERRORNOCLASIF;
		    END IF;
	 	    LV_desError  := 'OTHERS:VE_alta_cuenta_PG.VE_insSubCuenta_PR;- ' || SQLERRM;
		    SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
	  	    'VE_alta_cuenta_PG.VE_insSubCuenta_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_insSubCuenta_PR;

	PROCEDURE VE_updCategCuenta_PR(EV_codCuenta     IN  VARCHAR2,
								   EV_codCategoria  IN  VARCHAR2,
								   EV_codSubCateg   IN  VARCHAR2,
								   EV_codMultUso    IN  VARCHAR2,
								   EV_codCliePot    IN  VARCHAR2,
							  	   EV_desRazon      IN  VARCHAR2,
							       SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	       SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                               SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_updCategCuenta_PR"
			Lenguaje="PL/SQL"
			Fecha="15-06-2007"
			Versión="1.0.0"
			Diseñador="wjrc"
			Programador="wjrc"
			Ambiente="BD"
		<Retorno> N/A </Retorno>
		<Descripción>
				  Actualiza categoria de la cuenta
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom="EN_codCuenta"    Tipo="NUMBER"> codigo cuenta </param>
			   <param nom="EV_codCategoria" Tipo="STRING"> codigo categoria </param>
			   <param nom="EV_codSubCateg"  Tipo="STRING"> codigo subcategoria </param>
			   <param nom="EV_codMultUso"   Tipo="STRING"> codigo multi uso </param>
			   <param nom="EV_codCliePot"   Tipo="STRING"> codigo cliente potencial </param>
			   <param nom="EV_desRazon"     Tipo="STRING"> descripcion razon </param>
			 </Entrada>
	         <Salida>
			   <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		LV_desError ge_errores_pg.desevent;
		LV_sql		ge_errores_pg.vquery;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		LV_Sql:='UPDATE ga_cuentas a '
		     || ' SET a.cod_categoria = ' || EV_codCategoria
		     || ' ,a.cod_subcategoria = ' || EV_codSubCateg
	 	     || ' ,a.ind_multuso = ' || EV_codMultUso
		     || ' ,a.ind_cliepotencial = ' || EV_codCliePot
		     || ' ,a.des_razon_social = ' || EV_desRazon
		     || ' WHERE cod_cuenta = ' || EV_codCuenta;

		UPDATE ga_cuentas a
		SET a.cod_categoria = EV_codCategoria,
		    a.cod_subcategoria = EV_codSubCateg,
	 	    a.ind_multuso = EV_codMultUso,
		    a.ind_cliepotencial = EV_codCliePot,
		    a.des_razon_social = EV_desRazon
		WHERE cod_cuenta = EV_codCuenta;

	EXCEPTION
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:VE_alta_cuenta_PG.VE_updCategCuenta_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'VE_alta_cuenta_PG.VE_updCategCuenta_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_updCategCuenta_PR;

	--------------------------------------------------------------------------------------------
	--* DELETEs
	--------------------------------------------------------------------------------------------

	PROCEDURE VE_delCategCtasPotenciales_PR(EV_numIdentif    IN  VARCHAR2,
							                SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	                SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                                        SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_delCategCtasPotenciales_PR"
			Lenguaje="PL/SQL"
			Fecha="15-06-2007"
			Versión="1.0.0"
			Diseñador="wjrc"
			Programador="wjrc"
			Ambiente="BD"
		<Retorno> N/A </Retorno>
		<Descripción>
				  Actualiza categoria del cliente
		</Descripción>
		<Parámetros>
	         <Entrada>
	           <param nom="EV_numIdentif"   Tipo="STRING"> numero identificacion </param>
			 </Entrada>
	         <Salida>
			   <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		LV_desError ge_errores_pg.desevent;
		LV_sql		ge_errores_pg.vquery;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		LV_Sql:='DELETE FROM gat_categ_ctas_potenciales a '
			 || 'WHERE a.num_ident = ' || EV_numIdentif;

		DELETE FROM gat_categ_ctas_potenciales a
		WHERE a.num_ident = EV_numIdentif;

	EXCEPTION
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:VE_alta_cuenta_PG.VE_delCategCtasPotenciales_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'VE_alta_cuenta_PG.VE_delCategCtasPotenciales_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_delCategCtasPotenciales_PR;

	-- INC.  : 71895
        -- Fecha : 10/11/2008
        -- Prog  : JMC

	PROCEDURE VE_valida_identificacion_PR( EV_NUM_IDENT VARCHAR2,   -- Inc. 72181 27/11/2008 JMC
                                               EV_TIP_IDENT VARCHAR2,   -- Inc. 72181 27/11/2008 JMC
                                               SN_resultado    OUT NOCOPY NUMBER, -- Inc. 72181 27/11/2008 JMC
                                               SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_valida_identificacion_PR"
			Lenguaje="PL/SQL"
			Fecha="10-11-2008"
			Versión="1.0.0"
			Diseñador="rab"
			Programador="jmc"
			Ambiente="BD"
		<Retorno> N/A </Retorno>
		<Descripción>
				  Valida identificacion del cliente
		</Descripción>
		<Parámetros>
	         <Entrada>
	           <param nom="EV_NUM_IDENT"   Tipo="STRING"> numero identificacion </param>
	           <param nom="EV_TIP_IDENT"   Tipo="STRING"> tipo de  identificacion </param>
		 </Entrada>
	         <Salida>
	           <param nom="SN_resultado"   Tipo="NUMBER"> Resultado validacion: 0->OK , 1->NO OK  </param>
		   <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
		 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		LV_desError ge_errores_pg.desevent;
		LV_sql	    ge_errores_pg.vquery;
		LV_ret      VARCHAR2(300);
	BEGIN
	        SN_resultado  := 0;
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		LV_Sql:='LV_ret := ge_fn_ejecuta_rutina_bind(GE, 1,' || EV_NUM_IDENT || ',' || EV_TIP_IDENT ||');';


		LV_ret := substr(ge_fn_ejecuta_rutina_bind('GE', 1, EV_NUM_IDENT || ',' || EV_TIP_IDENT),1,300);

                if instr(LV_ret,'ERROR',1) = 0 then
                   SN_resultado := 0;
                else
                   SN_resultado := 1;
                   SV_menRetorno := LV_ret;
                end if;

	EXCEPTION
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:VE_alta_cuenta_PG.VE_valida_identificacion_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'VE_alta_cuenta_PG.VE_valida_identificacion_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_valida_identificacion_PR;

END VE_alta_cuenta_PG; 
/
SHOW ERRORS
