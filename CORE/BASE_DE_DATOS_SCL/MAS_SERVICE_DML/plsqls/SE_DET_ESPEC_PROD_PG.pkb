CREATE OR REPLACE PACKAGE BODY SE_DET_ESPEC_PROD_PG
AS
PROCEDURE SE_ESPEC_S_PR(EO_Det_Espec_productos   IN    SE_DETALLE_ESPEC_TO_QT,
        SO_Lista_Det_Espec_Productos  OUT NOCOPY refCursor,
        SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
        SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
        SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PF_PRODUCTO_S_PR"
       Lenguaje="PL/SQL"
       Fecha="20-07-2007"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Hilda Quezada"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
          </Entrada>
          <Salida>
             <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 v_contador     number(9);
 ERROR_PARAMETROS EXCEPTION;
  BEGIN
         SN_cod_retorno  := 0;
         SV_mens_retorno := ' ';
         SN_num_evento  := 0;

   IF EO_Det_Espec_productos IS NULL THEN
     RAISE ERROR_PARAMETROS;
   ELSE

    LV_sSql := 'SELECT A.COD_ESPEC_PROD, A.COD_SERVICIO_BASE, A.IND_TIPO_SERVICIO, NVL(A.COD_PROV_SERV,0) as COD_PROV_SERV , NVL(A.COD_PERFIL_LISTA,0) as COD_PERFIL_LISTA   ';
    LV_sSql := LV_sSql || '  FROM SE_DETALLES_ESPECIFICACION_TO a ';
     LV_sSql := LV_sSql || ' WHERE  a.cod_espec_prod =' ||EO_Det_Espec_productos.cod_espec_prod;

                OPEN SO_Lista_Det_Espec_Productos FOR
    SELECT A.COD_ESPEC_PROD,
        A.COD_SERVICIO_BASE,
        A.IND_TIPO_SERVICIO,
        NVL(A.COD_PROV_SERV,0) as COD_PROV_SERV ,
        NVL(A.COD_PERFIL_LISTA,0) as COD_PERFIL_LISTA
    FROM SE_DETALLES_ESPECIFICACION_TO a
    WHERE a.cod_espec_prod =EO_Det_Espec_productos.cod_espec_prod;

   END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
       SN_cod_retorno := 98;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PS_ESPEC_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_DET_ESPEC_PROD_PG.PS_ESPEC_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 1406;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PS_ESPEC_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_DET_ESPEC_PROD_PG.PS_ESPEC_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PS_ESPEC_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_DET_ESPEC_PROD_PG.PS_ESPEC_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

 END SE_ESPEC_S_PR;

END SE_DET_ESPEC_PROD_PG;
/
SHOW ERRORS
