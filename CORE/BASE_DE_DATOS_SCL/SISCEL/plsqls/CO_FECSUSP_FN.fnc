CREATE OR REPLACE FUNCTION CO_FECSUSP_FN ( EN_Cod_Cliente IN NUMBER, ED_FecVencimiento in DATE )
RETURN VARCHAR2
/*
1.	<Documentación TipoDoc = "Función">
2.	<Elemento Nombre = "CO_FECSUSP_FN" Lenguaje="PL/SQL" Fecha="07-06-2005" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.	<Retorno>VARCHAR2</Retorno>
4.	<Descripción>funcion para obtener la fecha de suspencion de un cliente dada una fecha de vencimiento</Descripción>
5.	<Parámetros>
6.	<Entrada>
7.	<param nom="EN_Cod_Cliente" Tipo="NUMBER">Código de Cliente</param>
8.	<param nom="ED_FecVencimiento" Tipo="DATE">Fecha de vencimiento</param>
10.	</Entrada>
16.	</Parámetros>
17.	</Elemento>
18.	</Documentación>
*/
IS
GV_Cod_Categoria  	CO_PTOSGESTION.COD_CATEGORIA%TYPE;
CV_Cod_PtoGest_SusUn CO_PTOSGESTION.COD_PTOGEST%TYPE :='SUSUN';
CV_Cod_PtoGest_SusBi CO_PTOSGESTION.COD_PTOGEST%TYPE :='SUSBI';
CV_Nom_Tabla      	CO_CODIGOS.NOM_TABLA%TYPE:='GE_CLIENTES';
CV_Nom_Columna    	CO_CODIGOS.NOM_COLUMNA%TYPE:='COD_CATEGORIA';
GV_Des_Valor      	CO_CODIGOS.DES_VALOR%TYPE;
GN_Num_Dias       	CO_PTOSGESTION.NUM_DIAS%TYPE;
GV_Fec_Suspencion 	VARCHAR2(11);
CV_dd_mon_yyyy    	VARCHAR2(11):='DD-MON-YYYY';
GV_Retorno        	VARCHAR2(250);
BEGIN

    BEGIN
        SELECT cod_categoria
          INTO GV_Cod_Categoria
          FROM ge_clientes
         WHERE cod_cliente = EN_Cod_Cliente;

    EXCEPTION
     WHEN OTHERS THEN
        GV_Retorno := TO_CHAR(SQLCODE)|| ';ERROR CO_ULTPAGO_FN:GE_CLIENTES :' || ', ' || SQLERRM;
        RETURN GV_Retorno;
    END;

    BEGIN
        SELECT des_valor
          INTO GV_Des_Valor
          FROM co_codigos
         WHERE nom_tabla   = CV_Nom_Tabla
           AND nom_columna = CV_Nom_Columna
           AND cod_valor   = GV_Cod_Categoria;
    EXCEPTION
     WHEN OTHERS THEN
        GV_Retorno := TO_CHAR(SQLCODE)|| ';ERROR CO_ULTPAGO_FN:DES_CATEGORIA :' || ', ' || SQLERRM;
        RETURN GV_Retorno;
    END;


    BEGIN
        SELECT MIN (NUM_DIAS)
          INTO GN_Num_Dias
          FROM CO_PTOSGESTION
         WHERE COD_CATEGORIA = GV_Des_Valor
           AND COD_PTOGEST   IN (CV_Cod_PtoGest_SusUn, CV_Cod_PtoGest_SusBi);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    	GN_Num_Dias := 0;
    WHEN OTHERS THEN
        GV_Retorno := TO_CHAR(SQLCODE)|| ';ERROR CO_ULTPAGO_FN:CO_PTOSGESTION :' || ', ' || SQLERRM;
        RETURN GV_Retorno;
    END;

    GV_Fec_Suspencion:= TO_CHAR(ED_FecVencimiento + GN_Num_Dias, CV_dd_mon_yyyy);

    RETURN GV_Fec_Suspencion;

    EXCEPTION
    WHEN OTHERS THEN
        GV_Retorno := TO_CHAR(SQLCODE)|| ';ERROR CO_ULTPAGO_FN :' || ', ' || SQLERRM;
        RETURN GV_Retorno;
END CO_FECSUSP_FN;
/
SHOW ERRORS
