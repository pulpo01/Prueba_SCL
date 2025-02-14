CREATE OR REPLACE PACKAGE BODY GA_CUSTOMER_ABE_PG AS

 GV_ERROR_NO_CLASIF VARCHAR2(100) := 'Error no clasificado';
 GV_SQL             VARCHAR2(1000);
-- 
-- 
 PROCEDURE GA_OBTENERDATOSCLIENTE_PR   ( EN_CODCLIENTE      IN  NUMBER,
                                         EV_FECHASISTEMA    IN  VARCHAR2,
                                         SV_CODSUBCATEGORIA OUT NOCOPY VARCHAR2,
										 SV_CODCATRIBUT     OUT NOCOPY VARCHAR2,
										 SN_CODCATIMPOS     OUT NOCOPY NUMBER,
										 SV_CODIDIOMA       OUT NOCOPY VARCHAR2,
 			                             SN_COD_RETORNO     OUT NOCOPY NUMBER, 
			                             SV_MENS_RETORNO    OUT NOCOPY VARCHAR2, 
			                             SN_NUM_EVENTO      OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Procedure">
   <Elemento
      Nombre = "GA_OBTENERDATOSCLIENTE_PR" 
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008" 
      Creado por="Jorge H. Toro Omar" 
      Fecha modificacion="" 
      Modificado por="" 
      Ambiente Desarrollo="BD"> 
      <Retorno>Número de Secuencia</Retorno> 
      <Descripcion>Recupera Datos del Cliente,SubCategoria,Categoria Tributaria, Categoria Impositiva,Zona Impositiva, Idioma</Descripcion> 
      <Parámetros> 
          <Entrada> 
            <param nom="EN_CODCLIENTE" Tipo="NUMBER">Código Cliente</param>
            <param nom="EV_FECHASISTEMA" Tipo="VARCHAR2">Fecha Sistema</param>			
         </Entrada> 
         <Salida> 
		 </Salida> 
      </Parametros> 
   </Elemento> 
</Documentacion> 
*/	 
 AS
  
 LV_CODSUBCATEGORIA GE_CLIENTES.COD_SUBCATEGORIA%TYPE := NULL;
 LV_CODCATRIBUT     GA_CATRIBUTCLIE.COD_CATRIBUT%TYPE := NULL;
 LN_CODCATIMPOS     GE_CATIMPCLIENTES.COD_CATIMPOS%TYPE := NULL;
 LV_CODIDIOMA       GE_CLIENTES.COD_IDIOMA%TYPE := NULL; 
 LD_FECHASISTEMA    DATE;    
 ERROR_PROCEDURE    EXCEPTION;
 NO_EXISTE_CLIENTE  EXCEPTION; 
 LN_EXISTECLIENTE   NUMBER:=0;
 
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;
 
    LD_FECHASISTEMA := TO_DATE(EV_FECHASISTEMA,'DDMMYYYY HH24MISS');
	
	-- VALIDAR CLIENTE 
	--
	SELECT COUNT(1)
	INTO   LN_EXISTECLIENTE
	FROM GE_CLIENTES A
	WHERE A.COD_CLIENTE = EN_CODCLIENTE;
	
	IF LN_EXISTECLIENTE = 0 
	THEN
	    RAISE NO_EXISTE_CLIENTE; -- TRUE 
	END IF;

    -- OBTENER SUBCATEGORIA CLIENTE 
	--
    GA_OBTSUBCATEGORIACLIENTE_PR(EN_CODCLIENTE, LV_CODSUBCATEGORIA,
                                 SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);	
    -- 
	IF (SN_COD_RETORNO = 0) 
	THEN
	   SV_CODSUBCATEGORIA := LV_CODSUBCATEGORIA;
	ELSE
	   RAISE ERROR_PROCEDURE;
	END IF;	   

	-- OBTENER CATEGORIA TRIBUTARIA CLIENTE 								 
	-- 
	GA_OBTCATEGORIATRIBUTARIA_PR(EN_CODCLIENTE, LD_FECHASISTEMA, 
	                             LV_CODCATRIBUT,  
	                             SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);								 
    -- 	
	IF (SN_COD_RETORNO = 0)
	THEN			
	   SV_CODCATRIBUT := LV_CODCATRIBUT;
	ELSE
	   RAISE ERROR_PROCEDURE;
	END IF;	   					 	
	   
	-- OBTENER CATEGORIA IMPOSITIVA CLIENTE 
	--
    GA_OBTCATEGORIAIMPOSITIVA_PR(EN_CODCLIENTE, LD_FECHASISTEMA,LN_CODCATIMPOS,
                                 SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);
    -- 
	IF (SN_COD_RETORNO = 0) 
	THEN	
	   SN_CODCATIMPOS := LN_CODCATIMPOS;
	ELSE
	   RAISE ERROR_PROCEDURE;
	END IF;
	-- 		
	
	-- OBTENER IDIOMA CLIENTE 
	--
    GA_OBTENERIDIOMACLIENTE_PR(EN_CODCLIENTE, LV_CODIDIOMA,
                               SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);
    -- 
	IF (SN_COD_RETORNO = 0) 
	THEN	
	   SV_CODIDIOMA := LV_CODIDIOMA;
	ELSE
	   RAISE ERROR_PROCEDURE;
	END IF;
	-- 									 	
	
 EXCEPTION	   
    WHEN ERROR_PROCEDURE THEN
         NULL;
    WHEN NO_EXISTE_CLIENTE THEN
         SN_COD_RETORNO := 1247; -- Cód. Cliente No Existe  
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTENERDATOSCLIENTE_PR', 
												   GV_SQL, SQLCODE, SQLERRM );	
 END;
-------------------------------------------------------------------------------- 
-- PROCEDURE GA_OBTSUBCATEGORIACLIENTE_PR
 PROCEDURE GA_OBTSUBCATEGORIACLIENTE_PR (EN_CODCLIENTE       IN  NUMBER,
                                         SV_CODSUBCATEGORIA  OUT NOCOPY VARCHAR2,
                                         SN_COD_RETORNO      OUT NOCOPY NUMBER, 
                                         SV_MENS_RETORNO     OUT NOCOPY VARCHAR2, 
                                         SN_NUM_EVENTO       OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Procedure">
   <Elemento
      Nombre = "GA_OBTSUBCATEGORIACLIENTE_PR"  
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008" 
      Creado por="Jorge H. Toro Omar" 
      Fecha modificacion="" 
      Modificado por="" 
      Ambiente Desarrollo="BD"> 
      <Retorno>Número de Secuencia</Retorno> 
      <Descripcion>Recupera Cód. SubCategoria</Descripcion> 
      <Parámetros> 
          <Entrada> 
            <param nom="EN_CODCLIENTE" Tipo="NUMBER">Código Cliente</param> 
         </Entrada> 
         <Salida> 
            <param nom="SV_CODSUBCATEGORIA" Tipo="VARCHAR2">Código Sub Categoria</param>		 
		 </Salida> 
      </Parametros> 
   </Elemento> 
</Documentacion> 
*/
 AS
 
  LV_CODSUBCATEGORIA GE_CLIENTES.COD_SUBCATEGORIA%TYPE := NULL;
   
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0; 

	GV_SQL:='';
    GV_SQL:='SELECT A.COD_SUBCATEGORIA ';
	GV_SQL:= GV_SQL || 'FROM GE_CLIENTES A '; 
	GV_SQL:= GV_SQL || 'WHERE A.COD_CLIENTE = ' || EN_CODCLIENTE;
	 
	SELECT A.COD_SUBCATEGORIA
	INTO   LV_CODSUBCATEGORIA
	FROM   GE_CLIENTES A 
	WHERE  A.COD_CLIENTE = EN_CODCLIENTE;
	
	SV_CODSUBCATEGORIA := LV_CODSUBCATEGORIA;
		
 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_RETORNO := 2158; -- Cod. SubCategoria No Encontrado .	
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTSUBCATEGORIACLIENTE_PR', 
												   GV_SQL, SQLCODE, SQLERRM );		 
	WHEN OTHERS THEN
         SN_COD_RETORNO := 2159; -- Error en Recupera Cod. SubCategoria.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTSUBCATEGORIACLIENTE_PR', 
												   GV_SQL, SQLCODE, SQLERRM );		  
 END;
--------------------------------------------------------------------------------
-- PROCEDURE GA_OBTCATEGORIATRIBUTARIA_PR			   
 PROCEDURE GA_OBTCATEGORIATRIBUTARIA_PR (EN_CODCLIENTE   IN  NUMBER,
                                         ED_FECHASISTEMA IN  DATE,
                                         SV_CODCATRIBUT  OUT NOCOPY VARCHAR2,
                                         SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                         SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                         SN_NUM_EVENTO   OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Procedure">
   <Elemento
      Nombre = "GA_OBTCATEGORIATRIBUTARIA_PR"   
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008" 
      Creado por="Jorge H. Toro Omar" 
      Fecha modificacion="" 
      Modificado por="" 
      Ambiente Desarrollo="BD"> 
      <Retorno>Número de Secuencia</Retorno> 
      <Descripcion>Recupera Cód. Categorias Tributaria</Descripcion> 
      <Parámetros> 
          <Entrada> 
            <param nom="EN_CODCLIENTE" Tipo="NUMBER">Código Cliente</param>
            <param nom="ED_FECHASISTEMA" Tipo="NUMBER">Fecha Sistema</param>			 
         </Entrada> 
         <Salida> 
            <param nom="SV_CODCATRIBUT" Tipo="VARCHAR2">Código Categoria Tributaria</param>		 
		 </Salida> 
      </Parametros> 
   </Elemento> 
</Documentacion> 
*/
 AS
 
  LV_CODCATRIBUT GA_CATRIBUTCLIE.COD_CATRIBUT%TYPE := NULL;
  LV_FECHASISTEMA VARCHAR2(21);
   
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;  
 
    GV_SQL:='';
    GV_SQL:='SELECT A.COD_CATRIBUT ';
	GV_SQL:= GV_SQL || 'FROM GA_CATRIBUTCLIE A ';
	GV_SQL:= GV_SQL || 'WHERE A.COD_CLIENTE = ' || EN_CODCLIENTE;	 
 
    SELECT A.COD_CATRIBUT
    INTO   LV_CODCATRIBUT
    FROM   GA_CATRIBUTCLIE A
    WHERE  A.COD_CLIENTE = EN_CODCLIENTE
	AND    ED_FECHASISTEMA BETWEEN A.FEC_DESDE AND A.FEC_HASTA;
  
    SV_CODCATRIBUT := LV_CODCATRIBUT;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_RETORNO := 2307; -- Cod. Categoria Tributaria No Encontrado .	
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTCATEGORIATRIBUTARIA_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
	WHEN OTHERS THEN
         SN_COD_RETORNO := 1221; -- Error en Recuperar Cod. Categoria Tributaria .
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTCATEGORIATRIBUTARIA_PR', 
												   GV_SQL, SQLCODE, SQLERRM );		 	
 END;			   
--------------------------------------------------------------------------------
-- PROCEDURE GA_OBTCATEGORIAIMPOSITIVA_PR			   
 PROCEDURE GA_OBTCATEGORIAIMPOSITIVA_PR (EN_CODCLIENTE   IN NUMBER,
                                         ED_FECHASISTEMA IN DATE,
                                         SN_CODCATIMPOS  OUT NOCOPY NUMBER,
                                         SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                         SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                         SN_NUM_EVENTO   OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Procedure">
   <Elemento
      Nombre = "GA_OBTCATEGORIAIMPOSITIVA_PR"   
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008" 
      Creado por="Jorge H. Toro Omar" 
      Fecha modificacion="" 
      Modificado por="" 
      Ambiente Desarrollo="BD"> 
      <Retorno>Número de Secuencia</Retorno> 
      <Descripcion>Recupera Cód. Categoria Impositiva</Descripcion> 
      <Parámetros> 
          <Entrada> 
            <param nom="EN_CODCLIENTE" Tipo="NUMBER">Código Cliente</param>
            <param nom="ED_FECHASISTEMA" Tipo="VARCHAR2">Fecha Sistema</param>			 
         </Entrada> 
         <Salida> 
            <param nom="SN_CODCATIMPOS" Tipo="NUMBER">Código Categoria Impositiva</param>		 
		 </Salida> 
      </Parametros> 
   </Elemento> 
</Documentacion> 
*/
 AS
 
  LN_CODCATIMPOS  GE_CATIMPCLIENTES.COD_CATIMPOS%TYPE := NULL;
   
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;  
 
    GV_SQL:='';
    GV_SQL:='SELECT A.COD_CATIMPOS ';
	GV_SQL:= GV_SQL || 'FROM GE_CATIMPCLIENTES A ';
	GV_SQL:= GV_SQL || 'WHERE A.COD_CLIENTE = ' || EN_CODCLIENTE; 
 
    SELECT A.COD_CATIMPOS
    INTO   LN_CODCATIMPOS
    FROM   GE_CATIMPCLIENTES A
    WHERE  A.COD_CLIENTE = EN_CODCLIENTE
	AND    ED_FECHASISTEMA BETWEEN A.FEC_DESDE AND A.FEC_HASTA;
  
    SN_CODCATIMPOS := LN_CODCATIMPOS;	
	
 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_RETORNO := 762; -- Cod. Categoria Impositiva No Encontrado .
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTCATEGORIAIMPOSITIVA_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
	WHEN OTHERS THEN
         SN_COD_RETORNO := 2160; -- Error en Recuperar Cod. Categoria Impositiva .	
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTCATEGORIAIMPOSITIVA_PR', 
												   GV_SQL, SQLCODE, SQLERRM );   
 END;
-------------------------------------------------------------------------------- 
-- PROCEDURE GA_OBTENERIDIAOMACLIENTE_PR
 PROCEDURE GA_OBTENERIDIOMACLIENTE_PR (EN_CODCLIENTE       IN  NUMBER,
                                       SV_CODIDIOMA        OUT NOCOPY VARCHAR2,
                                       SN_COD_RETORNO      OUT NOCOPY NUMBER, 
                                       SV_MENS_RETORNO     OUT NOCOPY VARCHAR2, 
                                       SN_NUM_EVENTO       OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Procedure">
   <Elemento
      Nombre = "GA_OBTENERIDIOMACLIENTE_PR"   
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008" 
      Creado por="Jorge H. Toro Omar" 
      Fecha modificacion="" 
      Modificado por="" 
      Ambiente Desarrollo="BD"> 
      <Retorno>Número de Secuencia</Retorno> 
      <Descripcion>Recupera Cód. Idioma</Descripcion> 
      <Parámetros> 
          <Entrada> 
            <param nom="EN_CODCLIENTE" Tipo="NUMBER">Código Cliente</param> 
         </Entrada> 
         <Salida> 
            <param nom="SV_CODIDIOMA" Tipo="VARCHAR2">Código Idioma</param>		 
		 </Salida> 
      </Parametros> 
   </Elemento> 
</Documentacion> 
*/
 AS
 
  LV_CODIDIOMA  GE_CLIENTES.COD_IDIOMA%TYPE := NULL;
   
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0; 

	GV_SQL:='';
    GV_SQL:='SELECT A.COD_IDIOMA ';
	GV_SQL:= GV_SQL || 'FROM GE_CLIENTES A '; 
	GV_SQL:= GV_SQL || 'WHERE A.COD_CLIENTE = ' || EN_CODCLIENTE;
	 
	SELECT A.COD_IDIOMA
	INTO   LV_CODIDIOMA
	FROM   GE_CLIENTES A 
	WHERE  A.COD_CLIENTE = EN_CODCLIENTE;
	
	SV_CODIDIOMA := LV_CODIDIOMA;
	
 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_RETORNO := 209; -- Cod. Idioma No Encontrado .	
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTENERIDIOMACLIENTE_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
	WHEN OTHERS THEN
         SN_COD_RETORNO := 2161; -- Error en Recupera Cod. Idioma.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTENERIDIOMACLIENTE_PR', 
												   GV_SQL, SQLCODE, SQLERRM );		  
 END; 			   
--------------------------------------------------------------------------------
-- PROCEDURE GA_OBTENEROFICINA_PR			   
 PROCEDURE GA_OBTENEROFICINA_PR (EV_NOMUSUARIO     IN  VARCHAR2,
                                 SV_CODOFICINA    OUT NOCOPY VARCHAR2,
								 SV_COD_REGION    OUT NOCOPY VARCHAR2,
								 SV_COD_PROVINCIA OUT NOCOPY VARCHAR2,
								 SV_COD_COMUNA    OUT NOCOPY VARCHAR2,								 
								 SN_CODVENDEDOR   OUT NOCOPY NUMBER,
                                 SN_COD_RETORNO   OUT NOCOPY NUMBER, 
                                 SV_MENS_RETORNO  OUT NOCOPY VARCHAR2, 
                                 SN_NUM_EVENTO    OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Procedure">
   <Elemento
      Nombre = "GA_OBTENEROFICINA_PR"   
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008" 
      Creado por="Jorge H. Toro Omar" 
      Fecha modificacion="" 
      Modificado por="" 
      Ambiente Desarrollo="BD"> 
      <Retorno>Número de Secuencia</Retorno> 
      <Descripcion>Recupera Cód. Oficina y Cód. Vendedor</Descripcion> 
      <Parámetros> 
          <Entrada> 
            <param nom="EV_NOMUSUARIO" Tipo="VARCHAR2">Nombre Usuario</param> 
         </Entrada> 
         <Salida> 
            <param nom="SV_CODOFICINA" Tipo="VARCHAR2">Código Oficina</param>
            <param nom="SN_CODVENDEDOR" Tipo="NUMBER">Código Vendedor</param>
            <param nom="SV_COD_REGION" Tipo="VARCHAR2">Código Región</param>
            <param nom="SV_COD_PROVINCIA" Tipo="VARCHAR2">Código Provincia</param>		
            <param nom="SV_COD_COMUNA" Tipo="VARCHAR2">Código Comuna</param>											 
		 </Salida> 
      </Parametros> 
   </Elemento> 
</Documentacion> 
*/
 AS
  
  LV_CODOFICINA  GE_SEG_USUARIO.COD_OFICINA%TYPE := NULL;
  LN_CODVENDEDOR VE_VENDEDORES.COD_VENDEDOR%TYPE := NULL;
  LV_CODREGION	 GE_OFICINAS.COD_REGION%TYPE := NULL;
  LV_CODPROVINCIA	GE_OFICINAS.COD_PROVINCIA%TYPE := NULL;
  LV_CODCOMUNA		GE_OFICINAS.COD_COMUNA%TYPE := NULL;
  
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;  
 
    GV_SQL:='';
    GV_SQL:='SELECT C.COD_OFICINA, C.COD_VENDEDOR ';
	GV_SQL:= GV_SQL || 'FROM   GE_SEG_USUARIO A, GE_OFICINAS B, VE_VENDEDORES C ';
	GV_SQL:= GV_SQL || 'WHERE  A.NOM_USUARIO  = ' || EV_NOMUSUARIO;
	GV_SQL:= GV_SQL || ' AND   B.COD_OFICINA  = A.COD_OFICINA ';
	GV_SQL:= GV_SQL || ' AND   C.COD_VENDEDOR = A.COD_VENDEDOR ';		 

    SELECT C.COD_OFICINA, C.COD_VENDEDOR, B.COD_REGION, B.COD_PROVINCIA, X.COD_CIUDAD   -- REMPLAZAR COMUNA
    INTO   LV_CODOFICINA, LN_CODVENDEDOR, LV_CODREGION, LV_CODPROVINCIA, LV_CODCOMUNA
    FROM   GE_SEG_USUARIO A, GE_OFICINAS B, VE_VENDEDORES C, GE_DIRECCIONES X
    WHERE  A.NOM_USUARIO   = EV_NOMUSUARIO
    AND    B.COD_OFICINA   = C.COD_OFICINA
    AND    B.COD_DIRECCION = X.COD_DIRECCION
    AND    C.COD_VENDEDOR  = A.COD_VENDEDOR;

  
    SV_CODOFICINA  := LV_CODOFICINA;
    SN_CODVENDEDOR := LN_CODVENDEDOR;
	SV_COD_REGION  := LV_CODREGION;
	SV_COD_PROVINCIA := LV_CODPROVINCIA;
	SV_COD_COMUNA    := LV_CODCOMUNA;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_RETORNO := 2162; -- Cod. Oficina o Cód. Vendedor No Encontrado.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTENEROFICINA_PR', 
												   GV_SQL, SQLCODE, SQLERRM );	   
    WHEN OTHERS THEN
         SN_COD_RETORNO := 2163; -- Error en Recuperar Cod. Oficina o Cod. Vendedor.  
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTENEROFICINA_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
	   
 END;			   
--------------------------------------------------------------------------------			    
-- PROCEDURE GA_OBTENERZONAIMPOSITIVA_PR 
 PROCEDURE GA_OBTENERZONAIMPOSITIVA_PR (EV_CODOFICINA   IN  VARCHAR2,
                                        SN_CODZONAIMPO  OUT NOCOPY NUMBER,
                                        SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                        SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                        SN_NUM_EVENTO   OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Procedure">
   <Elemento
      Nombre = "GA_OBTENERZONAIMPOSITIVA_PR"   
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008" 
      Creado por="Jorge H. Toro Omar" 
      Fecha modificacion="" 
      Modificado por="" 
      Ambiente Desarrollo="BD"> 
      <Retorno>Número de Secuencia</Retorno> 
      <Descripcion>Recupera Cód. Zona Impositiva</Descripcion> 
      <Parámetros> 
          <Entrada> 
            <param nom="EN_CODOFICINA" Tipo="VARCHAR2">Código de Oficina</param> 
         </Entrada> 
         <Salida> 
            <param nom="SN_CODZONAIMPO" Tipo="NUMBER">Código Zona Impositiva</param>		 
		 </Salida> 
      </Parametros> 
   </Elemento> 
</Documentacion> 
*/										
 AS
 
  LN_CODZONAIMPO GE_ZONACIUDAD.COD_ZONAIMPO%TYPE := NULL;
   
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;  
 
    GV_SQL:='';
    GV_SQL:='SELECT C.COD_ZONAIMPO ';
	GV_SQL:= GV_SQL || 'FROM   GE_OFICINAS A, GE_DIRECCIONES B, GE_ZONACIUDAD C ';
	GV_SQL:= GV_SQL || 'WHERE  A.COD_OFICINA    = ' || EV_CODOFICINA;
	GV_SQL:= GV_SQL || ' AND    A.COD_DIRECCION = B.COD_DIRECCION ';
	GV_SQL:= GV_SQL || ' AND    B.COD_REGION    = C.COD_REGION ';
	GV_SQL:= GV_SQL || ' AND    B.COD_PROVINCIA = C.COD_PROVINCIA ';
	GV_SQL:= GV_SQL || ' AND    B.COD_CIUDAD    = C.COD_CIUDAD ';		 

    SELECT C.COD_ZONAIMPO
    INTO   LN_CODZONAIMPO
    FROM   GE_OFICINAS A, GE_DIRECCIONES B, GE_ZONACIUDAD C 
    WHERE  A.COD_OFICINA   = EV_CODOFICINA
    AND    A.COD_DIRECCION = B.COD_DIRECCION 
    AND    B.COD_REGION    = C.COD_REGION 
    AND    B.COD_PROVINCIA = C.COD_PROVINCIA
    AND    B.COD_CIUDAD    = C.COD_CIUDAD;
  
    SN_CODZONAIMPO := LN_CODZONAIMPO;
  
 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_RETORNO := 1476; -- Cod. Zona Impositiva No Encontrado.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTENERZONAIMPOSITIVA_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
    WHEN OTHERS THEN
         SN_COD_RETORNO := 1473; -- Error en Recuperar Cod. Zona Impositiva.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'GA_CUSTOMER_ABE_PG.GA_OBTENERZONAIMPOSITIVA_PR', 
												   GV_SQL, SQLCODE, SQLERRM );		  
 END;			   
 
END;
/
SHOW ERRORS