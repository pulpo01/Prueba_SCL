CREATE OR REPLACE PACKAGE CE_VALIDA_PAGO_PG IS
/****************************************************************************************
   NOMBRE:       CE_VALIDA_PAGO_PG
   PROPOSITO:    FUNCIONES DE VALIDACION DE DATOS

   REVISION:
   Ver       Proyecto    Fecha       Autor                    Accion
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       TMM_03048   30-01-2004  Arq.Sol: Marco Moreno    Creacion de Paquete
                                     Dis.Tec: Stuver Ca?ete
                                     Program: Julio Bustos

****************************************************************************************/
FUNCTION CE_IsRevEmpresa_FN (
/****************************************************************************************
   NOMBRE:       CE_IsRevEmpresa_FN
   PROPOSITO:    Validacion empresa recaudadora(pRevEmpresa) contra tabla CED_EMPRESAS

   REVISION:
   Ver       Proyecto    Fecha       Autor                    Accion
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       TMM_03048   30-01-2004  Arq.Sol: Marco Moreno    Creacion de Funcion
                                     Dis.Tec: Stuver Ca?ete
                                     Program: Julio Bustos

****************************************************************************************/
   pRevEmpresa  IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN;

FUNCTION CE_IsRevCaja_FN (
/****************************************************************************************
   NOMBRE:       CE_IsRevCaja_FN
   PROPOSITO:    Validacion caja recaudadora(pRevCaja) contra tabla CO_CAJAS

   REVISION:
   Ver       Proyecto    Fecha       Autor                    Accion
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       TMM_03048   30-01-2004  Arq.Sol: Marco Moreno    Creacion de Funcion
                                     Dis.Tec: Stuver Ca?ete
                                     Program: Julio Bustos

****************************************************************************************/
   pRevCaja     IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN;

FUNCTION CE_IsRevOperador_FN (
/****************************************************************************************
   NOMBRE:       CE_IsRevOperador_FN
   PROPOSITO:    Validacion usuario Oracle utilizado(pRevOperador) contra tabla GE_SEG_USUARIO

   REVISION:
   Ver       Proyecto    Fecha       Autor                    Accion
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       TMM_03048   30-01-2004  Arq.Sol: Marco Moreno    Creacion de Funcion
                                     Dis.Tec: Stuver Ca?ete
                                     Program: Julio Bustos

****************************************************************************************/
   pRevOperador IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN;

FUNCTION CE_IsRevCliente_FN (
/****************************************************************************************
   NOMBRE:       CE_IsRevCliente_FN
   PROPOSITO:    Validacion cliente existe en SCL(pRevCliente) contra tabla GE_CLIENTES

   REVISION:
   Ver       Proyecto    Fecha       Autor                    Accion
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       TMM_03048   30-01-2004  Arq.Sol: Marco Moreno    Creacion de Funcion
                                     Dis.Tec: Stuver Ca?ete
                                     Program: Julio Bustos

****************************************************************************************/
   pRevCliente  IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN;

FUNCTION CE_IsRevBcoDocum_FN (
/****************************************************************************************
   NOMBRE:       CE_IsRevBcoDocum_FN
   PROPOSITO:    Validacion codigo del banco(pRevBcoDocum) contra tabla GE_BANCOS

   REVISION:
   Ver       Proyecto    Fecha       Autor                    Accion
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       TMM_03048   30-01-2004  Arq.Sol: Marco Moreno    Creacion de Funcion
                                     Dis.Tec: Stuver Ca?ete
                                     Program: Julio Bustos

****************************************************************************************/
   pRevBcoDocum IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN;

FUNCTION CE_IsRevFechaEfectiva_FN (
/****************************************************************************************
   NOMBRE:       CE_IsRevFechaEfectiva_FN
   PROPOSITO:    Validacion formato de fecha(pRevFechaEfectiva)

   REVISION:
   Ver       Proyecto    Fecha       Autor                    Accion
   --------  ----------  ----------  ----------------------   ---------------------------
   1.0       TMM_03048   30-01-2004  Arq.Sol: Marco Moreno    Creacion de Funcion
                                     Dis.Tec: Stuver Ca?ete
                                     Program: Julio Bustos

****************************************************************************************/
   pRevFechaEfectiva IN  VARCHAR2
  ,p_cErrFrom        OUT VARCHAR2
  ,p_cErrCode        OUT VARCHAR2
  ,p_cErrMens        OUT VARCHAR2
)  RETURN BOOLEAN;

END CE_VALIDA_PAGO_PG;
/
SHOW ERRORS
