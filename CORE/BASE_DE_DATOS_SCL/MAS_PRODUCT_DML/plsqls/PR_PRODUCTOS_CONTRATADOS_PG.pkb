CREATE OR REPLACE PACKAGE BODY PR_PRODUCTOS_CONTRATADOS_PG
AS

FUNCTION PR_UPDATE_TO_FN( EN_PRODUCTO     IN NUMBER,
        ED_FECHA    IN DATE,
        SN_FILAS    OUT NOCOPY NUMBER,
         SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_UPDATE_TO_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
            <param nom="EV_ORIGEN" Tipo="CARACTER">Código de Producto</param>
            <param nom="ED_FECHA" Tipo="FECHA">Código de Producto</param>
         </Entrada>
         <Salida>
            <param nom="SN_FILAS" Tipo="NUMERICO">Numero de filas actualizadas</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN

 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql := 'UPDATE PR_PRODUCTOS_CONTRATADOS_TO A ';
 LV_sSql := LV_sSql || 'SET    A.FEC_TERMINO_VIGENCIA = ,'|| ED_FECHA;
 LV_sSql := LV_sSql || 'A.COD_ESTADO = ELIMINADO ';
 LV_sSql := LV_sSql || 'A.FEC_PROCESO = '||SYSDATE ;
 LV_sSql := LV_sSql || 'WHERE  A.COD_PROD_CONTRATADO = '|| EN_PRODUCTO;

 -- SE DA DE BAJA EL PRODUCTO
 UPDATE PR_PRODUCTOS_CONTRATADOS_TO A
 SET    A.FEC_TERMINO_VIGENCIA = ED_FECHA,
     A.COD_ESTADO     = 'ELIMINADO',
     A.FEC_PROCESO    = SYSDATE
 WHERE  A.COD_PROD_CONTRATADO  =  EN_PRODUCTO;

 SN_FILAS := SQL%ROWCOUNT;

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al actualizar estado del producto contratado - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_UPDATE_TO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_UPDATE_TO_FN;

FUNCTION PR_UPDATE_TH_FN( EN_PRODUCTO     IN NUMBER,
        EV_PROCESO   IN VARCHAR2,
        EV_ORIGEN    IN VARCHAR2,
        ED_FECHA    IN DATE,
         SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_UPDATE_TH_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
            <param nom="EV_PROCESO" Tipo="CARACTER">Numero de Proceso</param>
   <param nom="EV_ORIGEN" Tipo="CARACTER">Origen de Proceso</param>
            <param nom="ED_FECHA" Tipo="FECHA">Fecha de Proceso</param>
         </Entrada>
         <Salida>
            <param nom="SN_FILAS" Tipo="NUMERICO">Numero de filas actualizadas</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql := 'UPDATE PR_PRODUCTOS_CONTRATADOS_TH A';
 LV_sSql := LV_sSql || ' SET A.FEC_TERMINO_VIGENCIA = '||ED_FECHA;
 LV_sSql := LV_sSql || ' , A.ORIGEN_PROCESO_DESCONTRATA = '||EV_ORIGEN;
 LV_sSql := LV_sSql || ' , A.NUM_PROC_DESCONTRATA = '||EV_PROCESO;
 LV_sSql := LV_sSql || ' , A.FEC_PROCESO = '||SYSDATE;
 LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO = '||EN_PRODUCTO;

 -- SE DA DE BAJA EL PRODUCTO EN LA HISTORICA
 UPDATE PR_PRODUCTOS_CONTRATADOS_TH A
 SET    A.FEC_TERMINO_VIGENCIA       = ED_FECHA,
     A.ORIGEN_PROCESO_DESCONTRATA = EV_ORIGEN,
     A.NUM_PROC_DESCONTRATA       = EV_PROCESO,
     A.FEC_PROCESO           = SYSDATE
 WHERE  A.COD_PROD_CONTRATADO        = EN_PRODUCTO;

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al actualizar estado del producto contratado historico - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_UPDATE_TH_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_UPDATE_TH_FN;

FUNCTION PR_UPDATE_PQ_TO_FN( EN_PRODUCTO     IN NUMBER,
          ED_FECHA    IN DATE,
           SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
          SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
          SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_UPDATE_PQ_TO_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
            <param nom="ED_FECHA" Tipo="FECHA">Fecha de Proceso</param>
         </Entrada>
         <Salida>
            <param nom="SN_FILAS" Tipo="NUMERICO">Numero de filas actualizadas</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql := 'UPDATE PR_PRODUCTOS_CONTRATADOS_TO A';
 LV_sSql := LV_sSql || ' SET A.FEC_TERMINO_VIGENCIA = '|| ED_FECHA;
 LV_sSql := LV_sSql || ' A.COD_ESTADO = ELIMINADO';
 LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO IN ( SELECT B.COD_PROD_CONTRA_PADRE';
 LV_sSql := LV_sSql || ' FROM PR_PRODUCTOS_CONTRATADOS_TO B';
 LV_sSql := LV_sSql || ' WHERE B.COD_PROD_CONTRATADO = '||EN_PRODUCTO;

 -- SE DAN DE BAJA LOS PAQUETES DE LOS PRODUCTOS
 UPDATE PR_PRODUCTOS_CONTRATADOS_TO A
 SET A.FEC_TERMINO_VIGENCIA = ED_FECHA,
  A.COD_ESTADO     = 'ELIMINADO'
 WHERE A.COD_PROD_CONTRATADO IN ( SELECT B.COD_PROD_CONTRA_PADRE
               FROM  PR_PRODUCTOS_CONTRATADOS_TO B
          WHERE B.COD_PROD_CONTRATADO = EN_PRODUCTO);

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al actualizar los paquetes del producto contratado - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_UPDATE_PQ_TO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_UPDATE_PQ_TO_FN;

FUNCTION PR_INSERT_TH_FN( EN_PRODUCTO     IN NUMBER,
        EV_PROCESO   IN VARCHAR2,
        EV_ORIGEN    IN VARCHAR2,
         SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_INSERT_TH_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
            <param nom="EV_PROCESO" Tipo="CARACTER">Numero de Proceso</param>
   <param nom="EV_ORIGEN" Tipo="CARACTER">Origen de Proceso</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql := 'INSERT INTO ';
 LV_sSql := LV_sSql || 'PR_PRODUCTOS_CONTRATADOS_TH ( ';
 LV_sSql := LV_sSql || 'COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO, ';
 LV_sSql := LV_sSql || 'FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, ';
 LV_sSql := LV_sSql || 'IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA, ';
 LV_sSql := LV_sSql || 'IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO, NUM_PROC_DESCONTRATA, ';
 LV_sSql := LV_sSql || 'ORIGEN_PROCESO_DESCONTRATA, FEC_DESCONTRATA, COD_LIMCONS,MTO_LIMCONS) ';--TMM_09008
 LV_sSql := LV_sSql || 'SELECT A.COD_PROD_CONTRATADO, A.COD_CLIENTE_BENEFICIARIO, A.NUM_ABONADO_BENEFICIARIO, A.COD_PROD_OFERTADO, ';
 LV_sSql := LV_sSql || 'A.FEC_INICIO_VIGENCIA, A.COD_CANAL, A.NUM_PROCESO, A.ORIGEN_PROCESO, A.FEC_PROCESO, A.COD_ESTADO, ';
 LV_sSql := LV_sSql || 'A.IND_CONDICION_CONTRATACION, A.COD_CLIENTE_CONTRATANTE, A.NUM_ABONADO_CONTRATANTE, A.FEC_TERMINO_VIGENCIA, ';
 LV_sSql := LV_sSql || 'A.IND_PRIORIDAD, A.COD_PROD_CONTRA_PADRE, NVL(A.COD_PERFIL_LISTA,0), A.TIPO_COMPORTAMIENTO, ';
 LV_sSql := LV_sSql ||  EV_PROCESO||', '||EV_ORIGEN||', '||SYSDATE||', COD_LIMCONS, MTO_LIMCONS';--TMM_09008
 LV_sSql := LV_sSql || 'FROM   PR_PRODUCTOS_CONTRATADOS_TO A ';
 LV_sSql := LV_sSql || 'WHERE  A.COD_PROD_CONTRATADO = '||EN_PRODUCTO;

 --SE INSERTAN EN LOS HISTORICOS LOS PRODUCTOS
 INSERT INTO PR_PRODUCTOS_CONTRATADOS_TH
 ( COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,
   FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,
   IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
   IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
   NUM_PROC_DESCONTRATA, ORIGEN_PROCESO_DESCONTRATA, FEC_DESCONTRATA, COD_LIMCONS,MTO_LIMCONS --TMM_09008
 )
 SELECT
   A.COD_PROD_CONTRATADO, A.COD_CLIENTE_BENEFICIARIO, A.NUM_ABONADO_BENEFICIARIO, A.COD_PROD_OFERTADO,
   A.FEC_INICIO_VIGENCIA, A.COD_CANAL, A.NUM_PROCESO, A.ORIGEN_PROCESO, A.FEC_PROCESO, A.COD_ESTADO,
   A.IND_CONDICION_CONTRATACION, A.COD_CLIENTE_CONTRATANTE, A.NUM_ABONADO_CONTRATANTE, A.FEC_TERMINO_VIGENCIA,
   A.IND_PRIORIDAD, A.COD_PROD_CONTRA_PADRE, A.COD_PERFIL_LISTA, A.TIPO_COMPORTAMIENTO,
   EV_PROCESO, EV_ORIGEN, SYSDATE, A.COD_LIMCONS,A.MTO_LIMCONS--TMM_09008
 FROM   PR_PRODUCTOS_CONTRATADOS_TO A
 WHERE  A.COD_PROD_CONTRATADO = EN_PRODUCTO;


 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al insertar en tabla de productos historica - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_INSERT_TH_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_INSERT_TH_FN;

FUNCTION PR_INSERT_PQ_TH_FN( EN_PRODUCTO     IN NUMBER,
        EV_PROCESO   IN VARCHAR2,
        EV_ORIGEN    IN VARCHAR2,
         SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_INSERT_PQ_TH_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
            <param nom="EV_PROCESO" Tipo="CARACTER">Numero de Proceso</param>
   <param nom="EV_ORIGEN" Tipo="CARACTER">Origen de Proceso</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql := 'INSERT INTO ';
 LV_sSql := LV_sSql || 'PR_PRODUCTOS_CONTRATADOS_TH ( ';
 LV_sSql := LV_sSql || 'COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO, ';
 LV_sSql := LV_sSql || 'FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, ';
 LV_sSql := LV_sSql || 'IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA, ';
 LV_sSql := LV_sSql || 'IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO, NUM_PROC_DESCONTRATA, ';
 LV_sSql := LV_sSql || 'ORIGEN_PROCESO_DESCONTRATA, FEC_DESCONTRATA, COD_LIMCONS,MTO_LIMCONS) ';--TMM_09008
 LV_sSql := LV_sSql || 'SELECT A.COD_PROD_CONTRATADO, A.COD_CLIENTE_BENEFICIARIO, A.NUM_ABONADO_BENEFICIARIO, A.COD_PROD_OFERTADO, ';
 LV_sSql := LV_sSql || 'A.FEC_INICIO_VIGENCIA, A.COD_CANAL, A.NUM_PROCESO, A.ORIGEN_PROCESO, A.FEC_PROCESO, A.COD_ESTADO, ';
 LV_sSql := LV_sSql || 'A.IND_CONDICION_CONTRATACION, A.COD_CLIENTE_CONTRATANTE, A.NUM_ABONADO_CONTRATANTE, A.FEC_TERMINO_VIGENCIA, ';
 LV_sSql := LV_sSql || 'A.IND_PRIORIDAD, A.COD_PROD_CONTRA_PADRE, NVL(A.COD_PERFIL_LISTA,0), A.TIPO_COMPORTAMIENTO, ';
 LV_sSql := LV_sSql ||  EV_PROCESO||', '||EV_ORIGEN||', '||SYSDATE||', COD_LIMCONS,MTO_LIMCONS';--TMM_09008
 LV_sSql := LV_sSql || 'FROM   PR_PRODUCTOS_CONTRATADOS_TO A ';
 LV_sSql := LV_sSql || 'WHERE  A.COD_PROD_CONTRATADO in (SELECT B.COD_PROD_CONTRA_PADRE ';
 LV_sSql := LV_sSql || 'FROM PR_PRODUCTOS_CONTRATADOS_TO B';
 LV_sSql := LV_sSql || 'WHERE  B.COD_PROD_CONTRATADO = '||EN_PRODUCTO||')';

 --SE INSERTAN EN LOS HISTORICOS LOS PRODUCTOS
 INSERT INTO PR_PRODUCTOS_CONTRATADOS_TH
 ( COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,
   FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,
   IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
   IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
   NUM_PROC_DESCONTRATA, ORIGEN_PROCESO_DESCONTRATA, FEC_DESCONTRATA, COD_LIMCONS,MTO_LIMCONS--TMM_09008
 )
 SELECT
   A.COD_PROD_CONTRATADO, A.COD_CLIENTE_BENEFICIARIO, A.NUM_ABONADO_BENEFICIARIO, A.COD_PROD_OFERTADO,
   A.FEC_INICIO_VIGENCIA, A.COD_CANAL, A.NUM_PROCESO, A.ORIGEN_PROCESO, A.FEC_PROCESO, A.COD_ESTADO,
   A.IND_CONDICION_CONTRATACION, A.COD_CLIENTE_CONTRATANTE, A.NUM_ABONADO_CONTRATANTE, A.FEC_TERMINO_VIGENCIA,
   A.IND_PRIORIDAD, A.COD_PROD_CONTRA_PADRE, A.COD_PERFIL_LISTA, A.TIPO_COMPORTAMIENTO,
   EV_PROCESO, EV_ORIGEN, SYSDATE, A.COD_LIMCONS,MTO_LIMCONS--TMM_09008
 FROM   PR_PRODUCTOS_CONTRATADOS_TO A
 WHERE  A.COD_PROD_CONTRATADO in (SELECT B.COD_PROD_CONTRA_PADRE
              FROM PR_PRODUCTOS_CONTRATADOS_TO B
          WHERE B.COD_PROD_CONTRATADO = EN_PRODUCTO);

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al insertar en tabla de productos historica los paquetes - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_INSERT_PQ_TH_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_INSERT_PQ_TH_FN;


FUNCTION PR_UPDATE_PQ_TH_FN( EN_PRODUCTO     IN NUMBER,
        EV_PROCESO   IN VARCHAR2,
        EV_ORIGEN    IN VARCHAR2,
        ED_FECHA    IN DATE,
         SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_UPDATE_PQ_TH_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
            <param nom="EV_PROCESO" Tipo="CARACTER">Numero de Proceso</param>
   <param nom="EV_ORIGEN" Tipo="CARACTER">Origen de Proceso</param>
            <param nom="ED_FECHA" Tipo="FECHA">Fecha de Proceso</param>
         </Entrada>
         <Salida>
            <param nom="SN_FILAS" Tipo="NUMERICO">Numero de filas actualizadas</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;


 LV_sSql := 'UPDATE PR_PRODUCTOS_CONTRATADOS_TH A';
 LV_sSql := LV_sSql || ' SET A.FEC_TERMINO_VIGENCIA = '||ED_FECHA;
 LV_sSql := LV_sSql || ' , A.ORIGEN_PROCESO_DESCONTRATA = '||EV_ORIGEN;
 LV_sSql := LV_sSql || ' , A.NUM_PROC_DESCONTRATA = '||EV_PROCESO;
 LV_sSql := LV_sSql || ' , A.FEC_PROCESO = '||SYSDATE;
 LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO IN ( SELECT B.COD_PROD_CONTRA_PADRE';
 LV_sSql := LV_sSql || ' FROM PR_PRODUCTOS_CONTRATADOS_TH B';
 LV_sSql := LV_sSql || ' WHERE B.COD_PROD_CONTRATADO = '||EN_PRODUCTO||')';

 -- SE DA DE BAJA EL PRODUCTO EN LA HISTORICA
 UPDATE PR_PRODUCTOS_CONTRATADOS_TH A
 SET    A.FEC_TERMINO_VIGENCIA       = ED_FECHA,
     A.ORIGEN_PROCESO_DESCONTRATA = EV_ORIGEN,
     A.NUM_PROC_DESCONTRATA       = EV_PROCESO,
     A.FEC_PROCESO           = SYSDATE
 WHERE  A.COD_PROD_CONTRATADO IN ( SELECT B.COD_PROD_CONTRA_PADRE
               FROM   PR_PRODUCTOS_CONTRATADOS_TH B
           WHERE  B.COD_PROD_CONTRATADO = EN_PRODUCTO);

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al actualizar los paquetes del producto contratado historico - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_UPDATE_PQ_TH_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_UPDATE_PQ_TH_FN;

FUNCTION PR_DELETE_TO_FN( EN_PRODUCTO     IN NUMBER,
         SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_DELETE_TO_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql := 'DELETE PR_PRODUCTOS_CONTRATADOS_TO A ';
 LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO ='||EN_PRODUCTO;

 -- SE BORRAN LOS PAQUETES
 DELETE PR_PRODUCTOS_CONTRATADOS_TO A
 WHERE  A.COD_PROD_CONTRATADO = EN_PRODUCTO;

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al eliminar el producto contratado - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_DELETE_TO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_DELETE_TO_FN;

FUNCTION PR_DELETE_PQ_TO_FN( EN_PRODUCTO     IN NUMBER,
         SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_DELETE_PQ_TO_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql := 'DELETE PR_PRODUCTOS_CONTRATADOS_TO A ';
 LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO IN ( SELECT B.COD_PROD_CONTRA_PADRE';
 LV_sSql := LV_sSql || ' FROM PR_PRODUCTOS_CONTRATADOS_TO B';
 LV_sSql := LV_sSql || ' WHERE B.COD_PROD_CONTRATADO ='||EN_PRODUCTO||')';

 -- SE BORRAN LOS PAQUETES
 DELETE PR_PRODUCTOS_CONTRATADOS_TO A
 WHERE  A.COD_PROD_CONTRATADO IN ( SELECT B.COD_PROD_CONTRA_PADRE
 FROM  PR_PRODUCTOS_CONTRATADOS_TO B
 WHERE B.COD_PROD_CONTRATADO = EN_PRODUCTO);

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al eliminar el paquete del producto contratado - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_DELETE_PQ_TO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_DELETE_PQ_TO_FN;

FUNCTION PR_DELETE_TH_FN( EN_PRODUCTO     IN NUMBER,
         SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_DELETE_TH_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql := 'DELETE PR_PRODUCTOS_CONTRATADOS_TH A ';
 LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO ='||EN_PRODUCTO;

 -- SE BORRAN LOS PAQUETES
 DELETE PR_PRODUCTOS_CONTRATADOS_TH A
 WHERE  A.COD_PROD_CONTRATADO = EN_PRODUCTO;

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al eliminar el producto contratado - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_DELETE_TH_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_DELETE_TH_FN;

FUNCTION PR_DELETE_PQ_TH_FN( EN_PRODUCTO     IN NUMBER,
         SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
        SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
        SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_DELETE_PQ_TH_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Actualiza el estado y la fecha de fin de vigencia de un producto contratado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
v_contador     number(9);
BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql := 'DELETE PR_PRODUCTOS_CONTRATADOS_TH A ';
 LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO IN ( SELECT B.COD_PROD_CONTRA_PADRE';
 LV_sSql := LV_sSql || ' FROM PR_PRODUCTOS_CONTRATADOS_TH B';
 LV_sSql := LV_sSql || ' WHERE B.COD_PROD_CONTRATADO ='||EN_PRODUCTO||')';

 -- SE BORRAN LOS PAQUETES
 DELETE PR_PRODUCTOS_CONTRATADOS_TH A
 WHERE  A.COD_PROD_CONTRATADO IN ( SELECT B.COD_PROD_CONTRA_PADRE
 FROM  PR_PRODUCTOS_CONTRATADOS_TH B
 WHERE B.COD_PROD_CONTRATADO = EN_PRODUCTO);

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'Error al eliminar el paquete del producto contratado - '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_DELETE_PQ_TH_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
END PR_DELETE_PQ_TH_FN;


PROCEDURE PR_PRODUCTO_CONTR_FS_PR(EN_TIPO_COMPORTAMIENTO   IN NUMBER,
            EN_COD_CLIENTE_CONTRATANTE  IN NUMBER,
            EN_NUM_ABONADO_CONTRATANTE  IN NUMBER,
               SO_Lista_Productos      OUT NOCOPY refCursor,
               SV_mens_retorno         OUT NOCOPY    ge_errores_pg.msgerror)
 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PR_PRODUCTO_CONTR_FS_PR"
       Lenguaje="PL/SQL"
       Fecha="03-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Jorge Marín"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Procedimiento fachada para ser invocado desde VB</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_COD_CLIENTE_CONTRATANTE" Tipo="NUMBER">Cliente contratante</param>>
             <param nom="EN_NUM_ABONADO_CONTRATANTE" Tipo="NUMBER">Abonado contratante</param>>
          </Entrada>
          <Salida>
             <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

EO_productos    PR_PRODUCTOS_CONTS_TO_QT;
LV_des_error    ge_errores_pg.DesEvent;
LV_sSql      ge_errores_pg.vQuery;
SN_cod_retorno     ge_errores_pg.coderror;
SN_num_evento      ge_errores_pg.evento;
v_contador     number(9);
ERROR_PARAMETROS EXCEPTION;

BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

    EO_productos := PR_PRODUCTOS_CONTS_TO_QT();
 EO_productos.TIPO_COMPORTAMIENTO     := EN_TIPO_COMPORTAMIENTO;
 EO_productos.COD_CLIENTE_CONTRATANTE := EN_COD_CLIENTE_CONTRATANTE;
 EO_productos.NUM_ABONADO_CONTRATANTE := EN_NUM_ABONADO_CONTRATANTE;
 PR_PRODUCTO_CONTR_PR(EO_productos,SO_Lista_Productos,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    SV_mens_retorno := SQLERRM;
    LV_des_error   := 'PR_PRODUCTO_CONTR_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_CONTR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PR_PRODUCTO_CONTR_FS_PR;

PROCEDURE PR_PRODUCTO_CONTR_PR(EO_productos         IN    PR_PRODUCTOS_CONTS_TO_QT,
             SO_Lista_Productos  OUT NOCOPY refCursor,
            SN_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
            SV_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
            SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PR_PRODUCTO_CONTR_PR"
       Lenguaje="PL/SQL"
       Fecha="03-11-2008"
       Versión="La del package"
       Diseñador="Jorge Marín"
       Programador="Jorge Marín"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_productos" Tipo="estructura">Código de Producto Padre</param>>
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

 IF EO_productos IS NULL THEN
  RAISE ERROR_PARAMETROS;
 ELSE

  IF EO_productos.TIPO_COMPORTAMIENTO = 0 THEN
			LV_sSql := 'SELECT DISTINCT OFER.COD_PROD_OFERTADO, OFER.DES_PROD_OFERTADO, OFER.FEC_INICIO_VIGENCIA, OFER.FEC_TERMINO_VIGENCIA';
   LV_sSql := LV_sSql || ' FROM   PR_PRODUCTOS_CONTRATADOS_TO PROD , PF_PRODUCTOS_OFERTADOS_TD OFER';
   LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE_BENEFICIARIO = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND  NUM_ABONADO_BENEFICIARIO = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' PROD.NUM_ABONADO_BENEFICIARIO = EO_productos.NUM_ABONADO_CONTRATANTE ';
   LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN PROD.FEC_INICIO_VIGENCIA AND PROD.FEC_TERMINO_VIGENCIA ';
   LV_sSql := LV_sSql || ' ORDER BY OFER.COD_PROD_OFERTADO ';

   OPEN SO_Lista_Productos FOR
				SELECT DISTINCT OFER.COD_PROD_OFERTADO, OFER.DES_PROD_OFERTADO, OFER.FEC_INICIO_VIGENCIA, OFER.FEC_TERMINO_VIGENCIA
    FROM   PR_PRODUCTOS_CONTRATADOS_TO PROD , PF_PRODUCTOS_OFERTADOS_TD OFER
    WHERE  PROD.COD_CLIENTE_BENEFICIARIO = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    PROD.NUM_ABONADO_BENEFICIARIO = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    OFER.COD_PROD_OFERTADO = PROD.COD_PROD_OFERTADO
    AND    SYSDATE BETWEEN PROD.FEC_INICIO_VIGENCIA AND PROD.FEC_TERMINO_VIGENCIA
    ORDER BY OFER.COD_PROD_OFERTADO;
  ELSIF EO_productos.TIPO_COMPORTAMIENTO = 1 THEN
			LV_sSql := 'SELECT DISTINCT OFER.COD_PROD_OFERTADO, OFER.DES_PROD_OFERTADO, OFER.FEC_INICIO_VIGENCIA, OFER.FEC_TERMINO_VIGENCIA';
   LV_sSql := LV_sSql || ' FROM   PR_PRODUCTOS_CONTRATADOS_TH PROD , PF_PRODUCTOS_OFERTADOS_TD OFER';
   LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE_BENEFICIARIO = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND  NUM_ABONADO_BENEFICIARIO = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' PROD.NUM_ABONADO_BENEFICIARIO = EO_productos.NUM_ABONADO_CONTRATANTE ';
--   LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN PROD.FEC_INICIO_VIGENCIA AND PROD.FEC_TERMINO_VIGENCIA ';
   LV_sSql := LV_sSql || ' ORDER BY OFER.COD_PROD_OFERTADO ';

   OPEN SO_Lista_Productos FOR
				SELECT DISTINCT OFER.COD_PROD_OFERTADO, OFER.DES_PROD_OFERTADO, OFER.FEC_INICIO_VIGENCIA, OFER.FEC_TERMINO_VIGENCIA
    FROM   PR_PRODUCTOS_CONTRATADOS_TH PROD , PF_PRODUCTOS_OFERTADOS_TD OFER
    WHERE  PROD.COD_CLIENTE_BENEFICIARIO = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    PROD.NUM_ABONADO_BENEFICIARIO = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    OFER.COD_PROD_OFERTADO = PROD.COD_PROD_OFERTADO
 --   AND    SYSDATE BETWEEN PROD.FEC_INICIO_VIGENCIA AND PROD.FEC_TERMINO_VIGENCIA
    ORDER BY OFER.COD_PROD_OFERTADO;

  END IF;
 END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
       SN_cod_retorno := 98;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PRODUCTO_CONTR_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_CONTR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PRODUCTO_CONTR_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_CONTR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PRODUCTO_CONTR_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_CONTR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PR_PRODUCTO_CONTR_PR;


PROCEDURE PR_PRODUCTO_S_PR(EO_productos   IN    PR_PRODUCTOS_CONTS_TO_QT,
        SO_Lista_Productos  OUT NOCOPY refCursor,
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

 IF EO_productos IS NULL THEN
  RAISE ERROR_PARAMETROS;
 ELSE
  IF (EO_productos.TIPO_COMPORTAMIENTO = '') OR (EO_productos.TIPO_COMPORTAMIENTO IS NULL) THEN

   LV_sSql := 'SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, ';
   LV_sSql := LV_sSql || ' COD_PROD_OFERTADO, FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ';
   LV_sSql := LV_sSql || ' ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, IND_CONDICION_CONTRATACION,';
   LV_sSql := LV_sSql || ' COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA, ';
   LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,';
   LV_sSql := LV_sSql || ' DECODE(COD_PROD_CONTRA_PADRE,0,1,COD_PROD_CONTRATADO,0,COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE, COD_LIMCONS,MTO_LIMCONS';--TMM_09008
   LV_sSql := LV_sSql || ' FROM  PR_PRODUCTOS_CONTRATADOS_TO ';
   LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE_BENEFICIARIO = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND  NUM_ABONADO_BENEFICIARIO = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND (COD_PROD_CONTRA_PADRE = 0 OR COD_PROD_CONTRA_PADRE = COD_PROD_CONTRATADO)';
   LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA ';
   LV_sSql := LV_sSql || ' UNION ';
   LV_sSql := LV_sSql || ' SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, ';
   LV_sSql := LV_sSql || ' COD_PROD_OFERTADO, FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ';
   LV_sSql := LV_sSql || ' ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, IND_CONDICION_CONTRATACION,';
   LV_sSql := LV_sSql || ' COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA, ';
   LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,';
   LV_sSql := LV_sSql || ' DECODE(COD_PROD_CONTRA_PADRE,0,1,COD_PROD_CONTRATADO,0,COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE, COD_LIMCONS,MTO_LIMCONS ';--TMM_09008
   LV_sSql := LV_sSql || ' FROM  PR_PRODUCTOS_CONTRATADOS_TH ';
   LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE_BENEFICIARIO = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND  NUM_ABONADO_BENEFICIARIO = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND (COD_PROD_CONTRA_PADRE = 0 OR COD_PROD_CONTRA_PADRE = COD_PROD_CONTRATADO)';
   LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA ';

   OPEN SO_Lista_Productos FOR
    SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO,
        COD_PROD_OFERTADO, TO_CHAR(FEC_INICIO_VIGENCIA,'DD/MM/YYYY HH24:MI:SS') AS FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO,
        ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, IND_CONDICION_CONTRATACION,
        COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
        IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
        DECODE(COD_PROD_CONTRA_PADRE,0,'1',COD_PROD_CONTRATADO,'0',COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
    FROM   PR_PRODUCTOS_CONTRATADOS_TO
    WHERE  COD_CLIENTE_BENEFICIARIO = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    NUM_ABONADO_BENEFICIARIO = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    (COD_PROD_CONTRA_PADRE = 0 OR COD_PROD_CONTRA_PADRE = COD_PROD_CONTRATADO)
    AND    SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA
    UNION
    SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO,
        COD_PROD_OFERTADO, TO_CHAR(FEC_INICIO_VIGENCIA,'DD/MM/YYYY HH24:MI:SS') AS FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO,
        ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, IND_CONDICION_CONTRATACION,
        COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
        IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
        DECODE(COD_PROD_CONTRA_PADRE,0,'1',COD_PROD_CONTRATADO,'0',COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
    FROM   PR_PRODUCTOS_CONTRATADOS_TH
    WHERE  COD_CLIENTE_BENEFICIARIO = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    NUM_ABONADO_BENEFICIARIO = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    (COD_PROD_CONTRA_PADRE = 0 OR COD_PROD_CONTRA_PADRE = COD_PROD_CONTRATADO)
    AND    SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA;
  ELSE
   LV_sSql := 'SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, ';
   LV_sSql := LV_sSql || ' COD_PROD_OFERTADO, FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ';
   LV_sSql := LV_sSql || ' ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, IND_CONDICION_CONTRATACION,';
   LV_sSql := LV_sSql || ' COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA, ';
   LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,';
   LV_sSql := LV_sSql || ' DECODE(COD_PROD_CONTRA_PADRE,0,1,COD_PROD_CONTRATADO,0,COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE, COD_LIMCONS,MTO_LIMCONS ';--TMM_09008
   LV_sSql := LV_sSql || ' FROM PR_PRODUCTOS_CONTRATADOS_TO ';
   LV_sSql := LV_sSql || ' WHERE COD_CLIENTE_BENEFICIARIO = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND NUM_ABONADO_BENEFICIARIO = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND TIPO_COMPORTAMIENTO = ' ||EO_productos.TIPO_COMPORTAMIENTO;
   LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA ';
   LV_sSql := LV_sSql || ' UNION';
   LV_sSql := LV_sSql || ' SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, ';
   LV_sSql := LV_sSql || ' COD_PROD_OFERTADO, FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ';
   LV_sSql := LV_sSql || ' ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, IND_CONDICION_CONTRATACION,';
   LV_sSql := LV_sSql || ' COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA, ';
   LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,';
   LV_sSql := LV_sSql || ' DECODE(COD_PROD_CONTRA_PADRE,0,1,COD_PROD_CONTRATADO,0,COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE, COD_LIMCONS,MTO_LIMCONS ';--TMM_09008
   LV_sSql := LV_sSql || ' FROM PR_PRODUCTOS_CONTRATADOS_TO ';
   LV_sSql := LV_sSql || ' WHERE COD_CLIENTE_BENEFICIARIO = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND NUM_ABONADO_BENEFICIARIO = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND TIPO_COMPORTAMIENTO = ' ||EO_productos.TIPO_COMPORTAMIENTO;
   LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA ';

   OPEN SO_Lista_Productos FOR
    SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO,
        COD_PROD_OFERTADO,TO_CHAR(FEC_INICIO_VIGENCIA,'DD/MM/YYYY HH24:MI:SS') AS FEC_INICIO_VIGENCIA, COD_CANAL, 
        NUM_PROCESO,ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, IND_CONDICION_CONTRATACION,
        COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
        IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
        DECODE(COD_PROD_CONTRA_PADRE,0,'1',COD_PROD_CONTRATADO,'0',COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
    FROM   PR_PRODUCTOS_CONTRATADOS_TO
    WHERE  COD_CLIENTE_BENEFICIARIO = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    NUM_ABONADO_BENEFICIARIO = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    TIPO_COMPORTAMIENTO   = EO_productos.TIPO_COMPORTAMIENTO
    AND    SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA
    UNION
    SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO,
        COD_PROD_OFERTADO,TO_CHAR(FEC_INICIO_VIGENCIA,'DD/MM/YYYY HH24:MI:SS') AS FEC_INICIO_VIGENCIA,COD_CANAL, 
        NUM_PROCESO,ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO, IND_CONDICION_CONTRATACION,
        COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
        IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
        DECODE(COD_PROD_CONTRA_PADRE,0,'1',COD_PROD_CONTRATADO,'0',COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
    FROM   PR_PRODUCTOS_CONTRATADOS_TH
    WHERE  COD_CLIENTE_BENEFICIARIO = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    NUM_ABONADO_BENEFICIARIO = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    TIPO_COMPORTAMIENTO   = EO_productos.TIPO_COMPORTAMIENTO
    AND    SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA;
  END IF;
 END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
       SN_cod_retorno := 98;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

 END PR_PRODUCTO_S_PR;


PROCEDURE PR_DETALLE_S_PR(EO_LISTA_PRODUCTOS IN     PR_PROD_CONTR_LST_QT,
        SO_LISTA_PRODUCTOS  OUT NOCOPY REFCURSOR,
        SN_COD_RETORNO      OUT NOCOPY    GE_ERRORES_PG.CODERROR,
        SV_MENS_RETORNO     OUT NOCOPY    GE_ERRORES_PG.MSGERROR,
        SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO)
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
              <param nom="EO_LISTA_PRODUCTOS Tipo="estructura">Lista de Producto Contratado</param>>
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

 IF EO_LISTA_PRODUCTOS IS NULL THEN
  RAISE ERROR_PARAMETROS;
 ELSE
  LV_sSql := 'SELECT a.COD_PROD_CONTRATADO, a.COD_CLIENTE_BENEFICIARIO, a.NUM_ABONADO_BENEFICIARIO,';
  LV_sSql := LV_sSql || ' a.COD_PROD_OFERTADO, a.FEC_INICIO_VIGENCIA, a.COD_CANAL, a.NUM_PROCESO,';
  LV_sSql := LV_sSql || ' a.ORIGEN_PROCESO, a.FEC_PROCESO, a.COD_ESTADO, a.IND_CONDICION_CONTRATACION,';
  LV_sSql := LV_sSql || ' a.COD_CLIENTE_CONTRATANTE, a.NUM_ABONADO_CONTRATANTE, a.FEC_TERMINO_VIGENCIA,';
  LV_sSql := LV_sSql || ' a.IND_PRIORIDAD, a.COD_PROD_CONTRA_PADRE, a.COD_PERFIL_LISTA, a.TIPO_COMPORTAMIENTO,';
  LV_sSql := LV_sSql || ' DECODE(a.COD_PROD_CONTRA_PADRE,0,1,a.COD_PROD_CONTRATADO,0,a.COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE,a.COD_LIMCONS,a.MTO_LIMCONS ';--TMM_09008
  LV_sSql := LV_sSql || ' FROM  PR_PRODUCTOS_CONTRATADOS_TO a';
  LV_sSql := LV_sSql || ' WHERE  a.COD_PROD_CONTRATADO in ( SELECT B.COD_PROD_CONTRATADO ';
  LV_sSql := LV_sSql || ' FROM   TABLE(CAST (EO_lista_productos AS PR_PROD_CONTR_LST_QT)) B)';
  LV_sSql := LV_sSql || ' UNION';
  LV_sSql := LV_sSql || ' SELECT a.COD_PROD_CONTRATADO, a.COD_CLIENTE_BENEFICIARIO, a.NUM_ABONADO_BENEFICIARIO,';
  LV_sSql := LV_sSql || ' a.COD_PROD_OFERTADO, a.FEC_INICIO_VIGENCIA, a.COD_CANAL, a.NUM_PROCESO,';
  LV_sSql := LV_sSql || ' a.ORIGEN_PROCESO, a.FEC_PROCESO, a.COD_ESTADO, a.IND_CONDICION_CONTRATACION,';
  LV_sSql := LV_sSql || ' a.COD_CLIENTE_CONTRATANTE, a.NUM_ABONADO_CONTRATANTE, a.FEC_TERMINO_VIGENCIA,';
  LV_sSql := LV_sSql || ' a.IND_PRIORIDAD, a.COD_PROD_CONTRA_PADRE, a.COD_PERFIL_LISTA, a.TIPO_COMPORTAMIENTO,';
  LV_sSql := LV_sSql || ' DECODE(a.COD_PROD_CONTRA_PADRE,0,1,a.COD_PROD_CONTRATADO,0,a.COD_PROD_CONTRA_PADRE ) AS IND_PAQUETE,a.COD_LIMCONS,a.MTO_LIMCONS ';--TMM_09008
  LV_sSql := LV_sSql || ' FROM  PR_PRODUCTOS_CONTRATADOS_TH a';
  LV_sSql := LV_sSql || ' WHERE  a.COD_PROD_CONTRATADO in ( SELECT B.COD_PROD_CONTRATADO ';
  LV_sSql := LV_sSql || ' FROM   TABLE(CAST (EO_lista_productos AS PR_PROD_CONTR_LST_QT)) B)';



  OPEN SO_Lista_Productos FOR
   SELECT a.COD_PROD_CONTRATADO, a.COD_CLIENTE_BENEFICIARIO, a.NUM_ABONADO_BENEFICIARIO,
       a.COD_PROD_OFERTADO, a.FEC_INICIO_VIGENCIA, a.COD_CANAL, a.NUM_PROCESO,
       a.ORIGEN_PROCESO, a.FEC_PROCESO, a.COD_ESTADO, a.IND_CONDICION_CONTRATACION,
       a.COD_CLIENTE_CONTRATANTE, a.NUM_ABONADO_CONTRATANTE, a.FEC_TERMINO_VIGENCIA,
       a.IND_PRIORIDAD, a.COD_PROD_CONTRA_PADRE, a.COD_PERFIL_LISTA, a.TIPO_COMPORTAMIENTO,
       DECODE(a.COD_PROD_CONTRA_PADRE,0,'1',a.COD_PROD_CONTRATADO,'0','0') AS IND_PAQUETE,
		a.COD_LIMCONS,MTO_LIMCONS --TMM_09008
   FROM   PR_PRODUCTOS_CONTRATADOS_TO a
   WHERE  a.COD_PROD_CONTRATADO in ( SELECT B.COD_PROD_CONTRATADO
   FROM   TABLE(CAST (EO_lista_productos AS PR_PROD_CONTR_LST_QT)) B)
   UNION
   SELECT a.COD_PROD_CONTRATADO, a.COD_CLIENTE_BENEFICIARIO, a.NUM_ABONADO_BENEFICIARIO,
       a.COD_PROD_OFERTADO, a.FEC_INICIO_VIGENCIA, a.COD_CANAL, a.NUM_PROCESO,
       a.ORIGEN_PROCESO, a.FEC_PROCESO, a.COD_ESTADO, a.IND_CONDICION_CONTRATACION,
       a.COD_CLIENTE_CONTRATANTE, a.NUM_ABONADO_CONTRATANTE, a.FEC_TERMINO_VIGENCIA,
       a.IND_PRIORIDAD, a.COD_PROD_CONTRA_PADRE, a.COD_PERFIL_LISTA, a.TIPO_COMPORTAMIENTO,
       DECODE(a.COD_PROD_CONTRA_PADRE,0,'1',a.COD_PROD_CONTRATADO,'0','0') AS IND_PAQUETE,
		a.COD_LIMCONS,A.MTO_LIMCONS --TMM_09008
   FROM   PR_PRODUCTOS_CONTRATADOS_TH a
   WHERE  a.COD_PROD_CONTRATADO in ( SELECT B.COD_PROD_CONTRATADO
   FROM   TABLE(CAST (EO_lista_productos AS PR_PROD_CONTR_LST_QT)) B);

END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
       SN_cod_retorno := 98;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PF_DETALLE_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PF_DETALLE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PF_DETALLE_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PF_DETALLE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PF_DETALLE_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PF_DETALLE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PR_DETALLE_S_PR;
----------------------------------------------------------------------------------------------------------------
PROCEDURE PR_PAQUETE_S_PR(EO_productos   IN    PR_PRODUCTOS_CONTS_TO_QT,
        SO_Lista_Productos  OUT NOCOPY refCursor,
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

 IF EO_productos IS NULL THEN
  RAISE ERROR_PARAMETROS;
 ELSE
  IF (EO_productos.TIPO_COMPORTAMIENTO = '') OR (EO_productos.TIPO_COMPORTAMIENTO IS NULL) THEN
   LV_sSql := 'SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,';
   LV_sSql := LV_sSql || ' FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO';
   LV_sSql := LV_sSql || ' IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,';
   LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,';
   LV_sSql := LV_sSql || ' DECODE(COD_PROD_CONTRA_PADRE,0,S,COD_PROD_CONTRATADO,N,H ) AS IND_PAQUETE,COD_LIMCONS,MTO_LIMCONS';--TMM_09008
   LV_sSql := LV_sSql || ' FROM  PR_PRODUCTOS_CONTRATADOS_TO ';
   LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE_CONTRATANTE = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND  NUM_ABONADO_CONTRATANTE = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND COD_PROD_CONTRA_PADRE = ' ||EO_productos.COD_PROD_CONTRATADO;
   LV_sSql := LV_sSql || ' UNION';
   LV_sSql := LV_sSql || ' SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,';
   LV_sSql := LV_sSql || ' FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO';
   LV_sSql := LV_sSql || ' IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,';
   LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,';
   LV_sSql := LV_sSql || ' DECODE(COD_PROD_CONTRA_PADRE,0,S,COD_PROD_CONTRATADO,N,H ) AS IND_PAQUETE,COD_LIMCONS,MTO_LIMCONS';--TMM_09008
   LV_sSql := LV_sSql || ' FROM  PR_PRODUCTOS_CONTRATADOS_TH ';
   LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE_CONTRATANTE = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND  NUM_ABONADO_CONTRATANTE = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND COD_PROD_CONTRA_PADRE = ' ||EO_productos.COD_PROD_CONTRATADO;

   OPEN SO_Lista_Productos FOR
    SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,
        FEC_INICIO_VIGENCIA,COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,
        IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
        IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
        DECODE(COD_PROD_CONTRA_PADRE,0,'S',COD_PROD_CONTRATADO,'N','H' ) AS IND_PAQUETE,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
    FROM   PR_PRODUCTOS_CONTRATADOS_TO
    WHERE  COD_CLIENTE_CONTRATANTE = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    NUM_ABONADO_CONTRATANTE = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    COD_PROD_CONTRA_PADRE = EO_productos.COD_PROD_CONTRATADO
    UNION
    SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,
        TO_DATE(FEC_INICIO_VIGENCIA,'DD/MM/YYYY HH24:MI:SS'), COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,
        IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
        IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
        DECODE(COD_PROD_CONTRA_PADRE,0,'S',COD_PROD_CONTRATADO,'N','H' ) AS IND_PAQUETE,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
    FROM   PR_PRODUCTOS_CONTRATADOS_TH
    WHERE  COD_CLIENTE_CONTRATANTE = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    NUM_ABONADO_CONTRATANTE = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    COD_PROD_CONTRA_PADRE = EO_productos.COD_PROD_CONTRATADO
    AND    SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA;
  ELSE
   LV_sSql := 'SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,';
   LV_sSql := LV_sSql || ' FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO';
   LV_sSql := LV_sSql || ' IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,';
   LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,';
   LV_sSql := LV_sSql || ' DECODE(COD_PROD_CONTRA_PADRE,0,S,COD_PROD_CONTRATADO,N,H ) AS IND_PAQUETE, COD_LIMCONS,MTO_LIMCONS';--TMM_09008
   LV_sSql := LV_sSql || ' FROM   PR_PRODUCTOS_CONTRATADOS_TO ';
   LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE_CONTRATANTE = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND   NUM_ABONADO_CONTRATANTE = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND   TIPO_COMPORTAMIENTO   = ' ||EO_productos.TIPO_COMPORTAMIENTO;
   LV_sSql := LV_sSql || ' AND  COD_PROD_CONTRA_PADRE  = ' ||EO_productos.COD_PROD_CONTRATADO;
   LV_sSql := LV_sSql || ' UNION';
   LV_sSql := LV_sSql || ' SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,';
   LV_sSql := LV_sSql || ' FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO';
   LV_sSql := LV_sSql || ' IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,';
   LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,';
   LV_sSql := LV_sSql || ' DECODE(COD_PROD_CONTRA_PADRE,0,S,COD_PROD_CONTRATADO,N,H ) AS IND_PAQUETE, COD_LIMCONS,MTO_LIMCONS';--TMM_09008
   LV_sSql := LV_sSql || ' FROM   PR_PRODUCTOS_CONTRATADOS_TH ';
   LV_sSql := LV_sSql || ' WHERE  COD_CLIENTE_CONTRATANTE = ' ||EO_productos.COD_CLIENTE_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND   NUM_ABONADO_CONTRATANTE = ' ||EO_productos.NUM_ABONADO_CONTRATANTE;
   LV_sSql := LV_sSql || ' AND   TIPO_COMPORTAMIENTO   = ' ||EO_productos.TIPO_COMPORTAMIENTO;
   LV_sSql := LV_sSql || ' AND  COD_PROD_CONTRA_PADRE  = ' ||EO_productos.COD_PROD_CONTRATADO;
   LV_sSql := LV_sSql || ' AND    SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA';

   OPEN SO_Lista_Productos FOR
    SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,
        FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,
        IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
        IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
        DECODE(COD_PROD_CONTRA_PADRE,0,'S',COD_PROD_CONTRATADO,'N','H' ) AS IND_PAQUETE,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
    FROM   PR_PRODUCTOS_CONTRATADOS_TO
    WHERE  COD_CLIENTE_CONTRATANTE = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    NUM_ABONADO_CONTRATANTE = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    TIPO_COMPORTAMIENTO   = EO_productos.TIPO_COMPORTAMIENTO
    AND    COD_PROD_CONTRA_PADRE  = EO_productos.COD_PROD_CONTRATADO
    UNION
    SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,
        FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,
        IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
        IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
        DECODE(COD_PROD_CONTRA_PADRE,0,'S',COD_PROD_CONTRATADO,'N','H' ) AS IND_PAQUETE,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
    FROM   PR_PRODUCTOS_CONTRATADOS_TH
    WHERE  COD_CLIENTE_CONTRATANTE = EO_productos.COD_CLIENTE_CONTRATANTE
    AND    NUM_ABONADO_CONTRATANTE = EO_productos.NUM_ABONADO_CONTRATANTE
    AND    TIPO_COMPORTAMIENTO   = EO_productos.TIPO_COMPORTAMIENTO
    AND    COD_PROD_CONTRA_PADRE  = EO_productos.COD_PROD_CONTRATADO
    AND    SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA;
  END IF;
 END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
       SN_cod_retorno := 98;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PAQUETE_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PAQUETE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PAQUETE_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PAQUETE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PAQUETE_S_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PAQUETE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

 END PR_PAQUETE_S_PR;
----------------------------------------------------------------------------------------------------------------
PROCEDURE PR_VENTA_S_PR(EO_venta   IN    PR_VENTA_QT,
        SO_Lista_Productos  OUT NOCOPY refCursor,
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

 IF EO_venta IS NULL THEN
  RAISE ERROR_PARAMETROS;
 ELSE
  LV_sSql := 'SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,';
  LV_sSql := LV_sSql || ' FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,';
  LV_sSql := LV_sSql || ' IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,';
  LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO, COD_LIMCONS,MTO_LIMCONS ';--TMM_09008
  LV_sSql := LV_sSql || ' FROM  PR_PRODUCTOS_CONTRATADOS_TO ';
  LV_sSql := LV_sSql || ' WHERE  NUM_PROCESO = ' ||EO_venta.NUM_VENTA;
  LV_sSql := LV_sSql || ' UNION';
  LV_sSql := LV_sSql || ' SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,';
  LV_sSql := LV_sSql || ' FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,';
  LV_sSql := LV_sSql || ' IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,';
  LV_sSql := LV_sSql || ' IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO, COD_LIMCONS,MTO_LIMCONS ';--TMM_09008
  LV_sSql := LV_sSql || ' FROM  PR_PRODUCTOS_CONTRATADOS_TO ';
  LV_sSql := LV_sSql || ' WHERE  NUM_PROCESO = ' ||EO_venta.NUM_VENTA;
  LV_sSql := LV_sSql || ' AND    SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA';

  OPEN SO_Lista_Productos FOR
   SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,
       FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,
       IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
       IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
   FROM   PR_PRODUCTOS_CONTRATADOS_TO
   WHERE  NUM_PROCESO = EO_venta.NUM_VENTA
   AND    COD_PROD_CONTRA_PADRE != 0
   UNION
   SELECT COD_PROD_CONTRATADO, COD_CLIENTE_BENEFICIARIO, NUM_ABONADO_BENEFICIARIO, COD_PROD_OFERTADO,
       FEC_INICIO_VIGENCIA, COD_CANAL, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, COD_ESTADO,
       IND_CONDICION_CONTRATACION, COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, FEC_TERMINO_VIGENCIA,
       IND_PRIORIDAD, COD_PROD_CONTRA_PADRE, COD_PERFIL_LISTA, TIPO_COMPORTAMIENTO,
		COD_LIMCONS,MTO_LIMCONS --TMM_09008
   FROM   PR_PRODUCTOS_CONTRATADOS_TH
   WHERE  NUM_PROCESO = EO_venta.NUM_VENTA
   AND    COD_PROD_CONTRA_PADRE != 0
   AND    SYSDATE BETWEEN FEC_INICIO_VIGENCIA AND FEC_TERMINO_VIGENCIA;
 END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
       SN_cod_retorno := 98;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_VENTA_S_PR(Lista Ventas); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_VENTA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_VENTA_S_PR(Lista Ventas); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_VENTA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_VENTA_S_PR(Lista Ventas); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_VENTA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PR_VENTA_S_PR;

PROCEDURE PR_PRODUCTO_D_PR(EO_lista_productos IN     PR_PROD_CONTR_LST_QT,
        SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
        SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
        SN_num_evento       OUT NOCOPY ge_errores_pg.evento)IS
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
ERROR_FUNCION  EXCEPTION;
LN_PRODUCTO     NUMBER;
LO_cProductos    refcursor;

BEGIN
  SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

  IF EO_lista_productos IS NULL THEN
     RAISE ERROR_PARAMETROS;
  ELSE
   OPEN LO_cProductos FOR
   SELECT c.COD_PROD_CONTRATADO
   FROM   TABLE(CAST(EO_lista_productos as PR_PROD_CONTR_LST_QT)) c;

   LOOP
    FETCH LO_cProductos INTO LN_PRODUCTO;

    EXIT WHEN LO_cProductos%NOTFOUND;

    LV_sSql := 'PR_DELETE_TO_FN('||LN_PRODUCTO||')';
    --Se elimina el producto
    IF NOT PR_DELETE_TO_FN( LN_PRODUCTO,
            SN_cod_retorno,
            SV_mens_retorno,
            SN_num_evento)
    THEN
       RAISE ERROR_FUNCION;
    END IF;

    LV_sSql := 'PR_DELETE_TH_FN('||LN_PRODUCTO||')';
    --Se elimina el producto desde las tablas historicas
    IF NOT PR_DELETE_TH_FN( LN_PRODUCTO,
            SN_cod_retorno,
            SV_mens_retorno,
            SN_num_evento)
    THEN
       RAISE ERROR_FUNCION;
    END IF;

   END LOOP;

  END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
       SN_cod_retorno := 98;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PRODUCTO_D_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_D_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN ERROR_FUNCION THEN
       SN_cod_retorno := 1424;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PRODUCTO_D_PR(Lista Productos); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_D_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
     SV_mens_retorno := cv_error_no_clasif;
  END IF;
  LV_des_error   := 'PR_PRODUCTO_D_PR('||'); - ' || SQLERRM;
  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PR',
                   SV_mens_retorno, CV_version, USER,
              'PR_PRODUCTOS_CONTRATADOS_SP_PG.PR_PRODUCTO_D_PR',
              LV_sSQL, SN_cod_retorno, LV_des_error );
END PR_PRODUCTO_D_PR;
---------------------------------------------------------------------------------------------------------
PROCEDURE PR_PRODUCTO_U_PR(EO_producto     IN     PR_PRODUCTO_DES_LST_QT,
        SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
        SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
        SN_num_evento       OUT NOCOPY ge_errores_pg.evento)IS
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
ERROR_PARAMETROS   EXCEPTION;
ERROR_FUNCION    EXCEPTION;
LN_PRODUCTO     NUMBER;
LV_PROCESO     VARCHAR2(10);
LV_ORIGEN      VARCHAR2(5);
LD_FECHA     DATE;
LN_indHistorico    NUMBER;
LO_cProductos    refcursor;

LO_ProductosTMP PR_PRODUCTO_DES_LST_QT := EO_producto;

BEGIN
  SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

  IF EO_producto IS NULL THEN
     RAISE ERROR_PARAMETROS;
  ELSE
   LV_sSql := 'SELECT c.COD_PROD_CONTRATADO, c.NUM_PROC_DESCONTRATA, c.ORIGEN_PROCESO_DESCONTRATA ';
   LV_sSql := LV_sSql || ' NVL(c.FEC_TERMINO_VIGENCIA,SYSDATE) ';
   LV_sSql := LV_sSql || ' FROM   TABLE(CAST(LO_ProductosTMP as PR_PRODUCTO_DES_LST_QT)) c';

   --Se recuperan de la estructura de entrada los datos necesarios para el proceso de la baja
   OPEN LO_cProductos for
   SELECT c.COD_PROD_CONTRATADO, c.NUM_PROC_DESCONTRATA, c.ORIGEN_PROCESO_DESCONTRATA,
       c.FEC_TERMINO_VIGENCIA
   FROM   TABLE(CAST(LO_ProductosTMP as PR_PRODUCTO_DES_LST_QT)) c;

   --Se recorre el cursor de los productos a descontratar
   LOOP
    FETCH LO_cProductos
    INTO LN_PRODUCTO,
      LV_PROCESO,
      LV_ORIGEN,
      LD_FECHA;

    EXIT WHEN LO_cProductos%NOTFOUND;

    --Se quita la hora de la fecha de termino para los productos de duracion infinita.
    IF (TO_CHAR(LD_FECHA,'DD-MM-YYYY') = '31-12-3000') THEN
       LD_FECHA := TO_DATE('31-12-3000','DD-MM-YYYY');
    END IF;

    LV_sSql:= 'PR_UPDATE_TO_FN('||LN_PRODUCTO
           ||', '||LD_FECHA||')';
    --Se actualiza el estado y a fecha de proceso del producto contratado
    IF NOT PR_UPDATE_TO_FN( LN_PRODUCTO,
         LD_FECHA,
         LN_indHistorico,
         SN_cod_retorno,
         SV_mens_retorno,
         SN_num_evento)
    THEN
       RAISE ERROR_FUNCION;
    END IF;

    IF (LN_indHistorico = 0) THEN
    --Si el número de filas actualizadas es 0, se actualiza desde la tabla de historicos
     LV_sSql := 'PR_UPDATE_TH_FN('||LN_PRODUCTO||', '
                      ||LV_PROCESO||', '
               ||LV_ORIGEN||', '
               ||LD_FECHA||')';

     IF NOT PR_UPDATE_TH_FN( LN_PRODUCTO,
             LV_PROCESO,
          LV_ORIGEN,
          LD_FECHA,
          SN_cod_retorno,
          SV_mens_retorno,
          SN_num_evento)
     THEN
        RAISE ERROR_FUNCION;
     END IF;
    END IF;

    --Una vez actualizado los estados, se pasan a registros históricos
    IF (LN_indHistorico != 0) THEN --Se inserta y elimina sólo si no es un registro histórico

     LV_sSql := 'PR_INSERT_TH_FN('||LN_PRODUCTO||', '
                 ||LV_PROCESO||', '
                ||LV_ORIGEN||')';
     -- Se inserta el producto en la tabla histórica
     IF NOT PR_INSERT_TH_FN( LN_PRODUCTO,
             LV_PROCESO,
          LV_ORIGEN,
          SN_cod_retorno,
          SV_mens_retorno,
          SN_num_evento)
     THEN
        RAISE ERROR_FUNCION;
     END IF;

     LV_sSql := 'PR_DELETE_TO_FN('||LN_PRODUCTO||')';
     --Se elimina el producto
     IF NOT PR_DELETE_TO_FN( LN_PRODUCTO,
             SN_cod_retorno,
             SV_mens_retorno,
             SN_num_evento)
     THEN
        RAISE ERROR_FUNCION;
     END IF;

    END IF;

   END LOOP;

  END IF;

EXCEPTION
 WHEN ERROR_PARAMETROS THEN
  SN_cod_retorno := 98;
  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
     SV_mens_retorno := CV_error_no_clasif;
  END IF;
  LV_des_error   := 'PR_PRODUCTO_U_PR(Lista Productos); '||SQLERRM;
  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN ERROR_FUNCION THEN
  SN_cod_retorno := 1424;
  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
     SV_mens_retorno := CV_error_no_clasif;
  END IF;
  LV_des_error   := 'PR_PRODUCTO_U_PR(Lista Productos); '||SQLERRM;
  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
  SN_cod_retorno := 156;
  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
     SV_mens_retorno := cv_error_no_clasif;
  END IF;
  LV_des_error   := 'PR_PRODUCTO_U_PR('||'); - ' || SQLERRM;
  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PR',
                   SV_mens_retorno, CV_version, USER,
              'PR_PRODUCTOS_CONTRATADOS_SP_PG.PR_PRODUCTO_U_PR',
              LV_sSQL, SN_cod_retorno, LV_des_error );
END PR_PRODUCTO_U_PR;
---------------------------------------------------------------------------------------------------------
PROCEDURE PR_CONTRATA_I_PR ( EO_productos  IN  PR_PRODUCTOS_CONTS_TO_QT,
--             SO_productos  OUT NOCOPY refCursor,
                        SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
        SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
        SN_num_evento       OUT NOCOPY ge_errores_pg.evento
                         ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "PR_PRODUCTOS_CONTRATADOS_I_PR"
      Fecha modificacion=" "
      Fecha creacion="11-08-2007"
      Programador="Andrés Osorio"
      Diseñador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado insertar registros en la tabla PR_PRODUCTOS_CONTRATADOS_TO.</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EP_productos" Tipo="Registro">Registro de la tabla PR_PRODUCTOS_CONTRATADOS_TO</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error                  ge_errores_pg.DesEvent;
LV_sSql                       ge_errores_pg.vQuery;
EO_TMP_productos              PR_PRODUCTOS_CONTS_TO_QT:= EO_productos;
LV_APLICA_PLAN_ADIC_OO        VARCHAR2(5); --JMO 16-11-2010 INC-155400
lv_ind_condicion_contratacion VARCHAR2(2); --JMO 16-11-2010 INC-155400

LN_CONT_PA                              NUMBER; --194354
LN_MAX_CONTRATACIONES        PF_PRODUCTOS_OFERTADOS_TD.MAX_CONTRATACIONES%TYPE;

BEGIN

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

 IF (EO_TMP_productos.COD_PROD_CONTRAT_PADRE IS NULL) OR (EO_TMP_productos.COD_PROD_CONTRAT_PADRE='') THEN
    EO_TMP_productos.COD_PROD_CONTRAT_PADRE := EO_TMP_productos.COD_PROD_CONTRATADO;
 END IF;

 --Se quita la hora de la fecha de termino para los productos de duracion infinita.
 IF (TO_CHAR(EO_TMP_productos.FEC_TERMINO_VIGENCIA,'DD-MM-YYYY') = '31-12-3000') THEN
    EO_TMP_productos.FEC_TERMINO_VIGENCIA := TO_DATE('31-12-3000','DD-MM-YYYY');
 END IF;

 --**inicio JMO 16-11-2010 INC-155400
 --**Se obtiene parametro para evaluar si aplican los planes opcionales obligatorios
 BEGIN

     LV_sSql := 'SELECT VAL_PARAMETRO '
             || ' FROM GED_PARAMETROS '
             || ' WHERE COD_PRODUCTO = '||CN_COD_PRODUCTO
             || ' AND COD_MODULO = '||CV_GE
             || ' AND NOM_PARAMETRO = '||CV_APLICA_PLAN_ADIC_OO;

     SELECT VAL_PARAMETRO
     INTO LV_APLICA_PLAN_ADIC_OO
     FROM GED_PARAMETROS
     WHERE COD_PRODUCTO = CN_COD_PRODUCTO
     AND COD_MODULO = CV_GE
     AND NOM_PARAMETRO = CV_APLICA_PLAN_ADIC_OO;

 EXCEPTION
     WHEN NO_DATA_FOUND THEN
        LV_APLICA_PLAN_ADIC_OO := 'FALSE';
 END;

 --**Se reemplaza valor de campo IND_CONDICION_CONTRATACION para planes opcionales obligatorios
 --**Si viene seteado con B se reemplaza por O en espera de cambios a nivel de Postventa
  IF (LV_APLICA_PLAN_ADIC_OO = 'TRUE') AND (EO_TMP_productos.IND_CONDICION_CONTRATACION = 'B') THEN
    lv_ind_condicion_contratacion := 'O';

  ELSE
    lv_ind_condicion_contratacion := EO_TMP_productos.IND_CONDICION_CONTRATACION;
  END IF;
 --**fin JMO 16-11-2010 INC-155400
 
 --INI 194354 CSR
 LV_sSQL:= LV_sSQL || ' SELECT COUNT(1) FROM PR_PRODUCTOS_CONTRATADOS_TO ';
 LV_sSQL:= LV_sSQL || ' WHERE COD_PROD_OFERTADO = '||EO_TMP_productos.COD_PROD_OFERTADO;
 LV_sSQL:= LV_sSQL || ' AND COD_CLIENTE_BENEFICIARIO =  '|| EO_TMP_productos.COD_CLIENTE_BENEFICIARIO;
 LV_sSQL:= LV_sSQL || ' AND NUM_ABONADO_BENEFICIARIO = '||EO_TMP_productos.NUM_ABONADO_BENEFICIARIO;
  
 SELECT COUNT(1) 
 INTO LN_CONT_PA
 FROM PR_PRODUCTOS_CONTRATADOS_TO
 WHERE COD_PROD_OFERTADO = EO_TMP_productos.COD_PROD_OFERTADO
 AND COD_CLIENTE_BENEFICIARIO = EO_TMP_productos.COD_CLIENTE_BENEFICIARIO
 AND NUM_ABONADO_BENEFICIARIO = EO_TMP_productos.NUM_ABONADO_BENEFICIARIO;
 
 LV_sSQL:= LV_sSQL || '  SELECT MAX_CONTRATACIONES FROM PF_PRODUCTOS_OFERTADOS_TD ';
 LV_sSQL:= LV_sSQL || ' WHERE COD_PROD_OFERTADO = '||EO_TMP_productos.COD_PROD_OFERTADO;
 
 SELECT MAX_CONTRATACIONES 
 INTO LN_MAX_CONTRATACIONES
 FROM PF_PRODUCTOS_OFERTADOS_TD 
 WHERE COD_PROD_OFERTADO = EO_TMP_productos.COD_PROD_OFERTADO
 AND ROWNUM = 1; 
 
 LV_sSQL:= 'LN_MAX_CONTRATACIONES: '||LN_MAX_CONTRATACIONES||',  LN_CONT_PA: '||LN_CONT_PA;
 
 IF LN_MAX_CONTRATACIONES > LN_CONT_PA THEN

 --FIN 194354 CSR 

 LV_sSQL:= LV_sSQL || '(INSERT INTO PR_PRODUCTOS_CONTRATADOS_TO (';
 LV_sSQL:= LV_sSQL || 'COD_PROD_CONTRATADO, ';
 LV_sSQL:= LV_sSQL || 'COD_CLIENTE_BENEFICIARIO, ';
 LV_sSQL:= LV_sSQL || 'NUM_ABONADO_BENEFICIARIO, ';
 LV_sSQL:= LV_sSQL || 'COD_PROD_OFERTADO, ';
 LV_sSQL:= LV_sSQL || 'FEC_INICIO_VIGENCIA, ';
 LV_sSQL:= LV_sSQL || 'COD_CANAL, ';
 LV_sSQL:= LV_sSQL || 'NUM_PROCESO, ';
 LV_sSQL:= LV_sSQL || 'ORIGEN_PROCESO,';
 LV_sSQL:= LV_sSQL || 'FEC_PROCESO, ';
 LV_sSQL:= LV_sSQL || 'COD_ESTADO, ';
 LV_sSQL:= LV_sSQL || 'IND_CONDICION_CONTRATACION, ';
 LV_sSQL:= LV_sSQL || 'COD_CLIENTE_CONTRATANTE, ';
 LV_sSQL:= LV_sSQL || 'NUM_ABONADO_CONTRATANTE, ';
 LV_sSQL:= LV_sSQL || 'FEC_TERMINO_VIGENCIA, ';
 LV_sSQL:= LV_sSQL || 'IND_PRIORIDAD, ';
 LV_sSQL:= LV_sSQL || 'COD_PROD_CONTRA_PADRE, ';
 LV_sSQL:= LV_sSQL || 'COD_PERFIL_LISTA, ';
 LV_sSQL:= LV_sSQL || 'TIPO_COMPORTAMIENTO, ';
 LV_sSQL:= LV_sSQL || 'COD_LIMCONS,MTO_LIMCONS '; --TMM09008
 LV_sSQL:= LV_sSQL || 'VALUES (';
 LV_sSQL:= LV_sSQL || '('||EO_TMP_productos.COD_PROD_CONTRATADO  ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.COD_CLIENTE_BENEFICIARIO  ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.NUM_ABONADO_BENEFICIARIO  ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.COD_PROD_OFERTADO         ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.FEC_INICIO_VIGENCIA       ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.COD_CANAL                 ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.NUM_PROCESO               ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.ORIGEN_PROCESO            ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.FEC_PROCESO               ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.COD_ESTADO                ||',';
 --LV_sSQL:= LV_sSQL || EO_TMP_productos.IND_CONDICION_CONTRATACION||','; --JMO 16-11-2010 INC-155400
 LV_sSQL:= LV_sSQL || lv_ind_condicion_contratacion              ||',';   --JMO 16-11-2010 INC-155400
 LV_sSQL:= LV_sSQL || EO_TMP_productos.COD_CLIENTE_CONTRATANTE   ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.NUM_ABONADO_CONTRATANTE   ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.FEC_TERMINO_VIGENCIA      ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.IND_PRIORIDAD             ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.COD_PROD_CONTRAT_PADRE    ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.COD_PERFIL_LISTA          ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.TIPO_COMPORTAMIENTO       ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.COD_LIMCONS       ||',';
 LV_sSQL:= LV_sSQL || EO_TMP_productos.MTO_LIMCONS       ||')';--TMM09008
 
         INSERT INTO PR_PRODUCTOS_CONTRATADOS_TO (
          COD_PROD_CONTRATADO,
          COD_CLIENTE_BENEFICIARIO,
          NUM_ABONADO_BENEFICIARIO,
          COD_PROD_OFERTADO,
          FEC_INICIO_VIGENCIA,
          COD_CANAL,
          NUM_PROCESO,
          ORIGEN_PROCESO,
          FEC_PROCESO,
          COD_ESTADO,
          IND_CONDICION_CONTRATACION,
          COD_CLIENTE_CONTRATANTE,
          NUM_ABONADO_CONTRATANTE,
          FEC_TERMINO_VIGENCIA,
          IND_PRIORIDAD,
          COD_PROD_CONTRA_PADRE,
          COD_PERFIL_LISTA,
          TIPO_COMPORTAMIENTO,
          COD_LIMCONS,MTO_LIMCONS)--TMM_09008
         VALUES (
          EO_TMP_productos.COD_PROD_CONTRATADO,
          EO_TMP_productos.COD_CLIENTE_BENEFICIARIO,
          EO_TMP_productos.NUM_ABONADO_BENEFICIARIO,
          EO_TMP_productos.COD_PROD_OFERTADO,
          EO_TMP_productos.FEC_INICIO_VIGENCIA,
          EO_TMP_productos.COD_CANAL,
          EO_TMP_productos.NUM_PROCESO,
          EO_TMP_productos.ORIGEN_PROCESO,
          EO_TMP_productos.FEC_PROCESO,
          EO_TMP_productos.COD_ESTADO,
          EO_TMP_productos.IND_CONDICION_CONTRATACION,
          EO_TMP_productos.COD_CLIENTE_CONTRATANTE,
          EO_TMP_productos.NUM_ABONADO_CONTRATANTE,
          EO_TMP_productos.FEC_TERMINO_VIGENCIA,
          EO_TMP_productos.IND_PRIORIDAD,
          EO_TMP_productos.COD_PROD_CONTRAT_PADRE,
          EO_TMP_productos.COD_PERFIL_LISTA,
          EO_TMP_productos.TIPO_COMPORTAMIENTO,
          EO_TMP_productos.COD_LIMCONS,
          EO_TMP_productos.MTO_LIMCONS);--TMM_09008

END IF; --194354 CSR

EXCEPTION
WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 1400;  --ojo cambiar codigo
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_CONTRATA_I_PR(--); '||SQLERRM;
WHEN OTHERS THEN
   SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PR_CONTRATA_I_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PR',
                 SV_mens_retorno, CV_version, USER,
                 'PR_PRODUCTOS_CONTRATADOS_SP_PG.PR_CONTRATA_I_PR',
                 LV_sSQL, SN_cod_retorno, LV_des_error );

END PR_CONTRATA_I_PR;

---------------------------------------------------------------------------------------------------------
PROCEDURE PR_SECUENCIA_PRODUCTO_PR (EO_SECUENCIA IN OUT NOCOPY PR_SECUENCIA_QT,
            SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
                     SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
                     SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PV_OBTIENE_SECUENCIA_PR    "
      Lenguaje="PL/SQL"
      Fecha="25-07-2007"
      Versión="La del package"
      Diseñador="Carlos Elizondo"
      Programador="Carlos Elizondo"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
   <param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=NOM_PARAMETRO VARCHAR2(20)  </param>>
         </Entrada>
         <Salida>
   <param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VALOR_NUMERICO NUMBER(20,6) </param>>
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

BEGIN
SN_cod_retorno  := 0;
SN_num_evento   := 0;
SV_mens_retorno := NULL;

 LV_sSql := 'SELECT ' || EO_SECUENCIA.NOM_SECUENCIA || '.NEXTVAL FROM DUAL';
 EXECUTE IMMEDIATE LV_sSql INTO EO_SECUENCIA.NUM_SECUENCIA;

EXCEPTION
  WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
   LV_des_error   := ' PR_SECUENCIA_PRODUCTO_PR('||EO_SECUENCIA.NOM_SECUENCIA||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PRODUCTOS_CONTRATADOS_PG.PR_SECUENCIA_PRODUCTO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END PR_SECUENCIA_PRODUCTO_PR;

PROCEDURE PR_ACTUALIZA_BONOS_PR( EN_PROD_CONTRATADO IN PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_CONTRATADO%type,
           SN_cod_retorno     OUT NOCOPY  ge_errores_pg.coderror,
               SV_mens_retorno    OUT NOCOPY  ge_errores_pg.msgerror,
               SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PV_OBTIENE_SECUENCIA_PR    "
      Lenguaje="PL/SQL"
      Fecha="25-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
   <param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=NOM_PARAMETRO VARCHAR2(20)  </param>>
         </Entrada>
         <Salida>
   <param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VALOR_NUMERICO NUMBER(20,6) </param>>
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

BEGIN
SN_cod_retorno  := 0;
SN_num_evento   := 0;
SV_mens_retorno := NULL;

 LV_sSql := 'UPDATE PR_PRODUCTOS_CONTRATADOS_TO';
 LV_sSql := LV_sSql || ' SET COD_ESTADO = '||CV_ESTADO_OK;
 LV_sSql := LV_sSql || ' WHERE COD_PROD_CONTRATADO = '||EN_PROD_CONTRATADO;


 UPDATE PR_PRODUCTOS_CONTRATADOS_TO
 SET COD_ESTADO = CV_ESTADO_OK,
  FEC_PROCESO = SYSDATE
 WHERE COD_PROD_CONTRATADO = EN_PROD_CONTRATADO;



EXCEPTION
  WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
   LV_des_error   := ' PR_ACTUALIZA_BONOS_PR('||EN_PROD_CONTRATADO||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PRODUCTOS_CONTRATADOS_PG.PR_ACTUALIZA_BONOS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END PR_ACTUALIZA_BONOS_PR;

PROCEDURE PR_OBTIENE_CONTRATADOS_PR(EN_COD_PROD_OFERTADO IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
         EN_COD_CLIENTE    IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
         EN_NUM_ABONADO    IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
         SN_CANTIDAD_PROD  OUT NOCOPY NUMBER,
         SN_cod_retorno       OUT NOCOPY  ge_errores_pg.coderror,
         SV_mens_retorno      OUT NOCOPY  ge_errores_pg.msgerror,
         SN_num_evento        OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PR_OBTIENE_CONTRATADOS_PR"
      Lenguaje="PL/SQL"
      Fecha="25-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción>Obtiene la cantidad contratada para un cliente/abonado de un producto ofertado</Descripción>>
      <Parámetros>
         <Entrada>
   <param nom="EN_COD_PROD_OFERTADO" Tipo="NUMERICO">Codigo de producto ofertado</param>>
   <param nom="EN_COD_CLIENTE " Tipo="NUMERICO">Codigo de Cliente</param>>
   <param nom="EN_NUM_ABONADO" Tipo="NUMERICO">Numero de Abonado</param>>
         </Entrada>
         <Salida>
   <param nom="SN_cod_retorno" Tipo="NUMERICO">Numero de veces contratado</param>>
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

BEGIN
 SN_cod_retorno  := 0;
 SN_num_evento   := 0;
 SV_mens_retorno := NULL;

 LV_sSql := 'SELECT COUNT(0)';
 LV_sSql := LV_sSql || 'FROM pr_productos_contratados_to';
 LV_sSql := LV_sSql || 'WHERE cod_prod_ofertado = '||EN_COD_PROD_OFERTADO;
 LV_sSql := LV_sSql || 'AND   cod_cliente_beneficiario = '||EN_COD_CLIENTE;
 LV_sSql := LV_sSql || 'AND   num_abonado_beneficiario = '||EN_NUM_ABONADO;

 SELECT COUNT(0)
 INTO SN_CANTIDAD_PROD
 FROM pr_productos_contratados_to
 WHERE cod_prod_ofertado = EN_COD_PROD_OFERTADO
 AND   cod_cliente_beneficiario = EN_COD_CLIENTE
 AND   num_abonado_beneficiario = EN_NUM_ABONADO;


EXCEPTION
  WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
   LV_des_error   := ' PR_OBTIENE_CONTRATADOS_PR('||EN_COD_PROD_OFERTADO||', '||EN_COD_CLIENTE||', '||EN_NUM_ABONADO||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PRODUCTOS_CONTRATADOS_PG.PR_OBTIENE_CONTRATADOS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END PR_OBTIENE_CONTRATADOS_PR;


END PR_PRODUCTOS_CONTRATADOS_PG;
/
SHOW ERRORS