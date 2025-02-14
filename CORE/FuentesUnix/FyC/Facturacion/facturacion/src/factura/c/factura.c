/******************************************************************************
 Fichero    : factura.c 
 Descripcion:   

 Fecha      : 19-02-1997 
 Autor      : Javier Garcia Paredes       
*******************************************************************************/

#define _FACTURA_C_

#include <factura.h>

/* -------------------------------------------------------------------------- */
/*                  Variables Globales                                        */
/* -------------------------------------------------------------------------- */
CONFIG stConfig;

/* -------------------------------------------------------------------------- */
/*   main (int,char**)                                                        */
/*     Proceso que se encarga de leer la informacion dejada por otros modulos */
/*     y facturarla en el presente ciclo (Prebilling). Una vez que esten los  */
/*     datos del ciclo en fa_prefactura se realiza el proceso de Descuentos   */
/*     para el ciclo de facturacion.                                          */
/*                                                                            */
/*     Valores retorno: Codigo del error que se ha producido - Error          */
/*                      0 - Todo bien                                         */
/* -------------------------------------------------------------------------- */
int main (void)
{
  int iInd = 0, iRegProc = 0;

  long lNumProceso     = -1;

  memset (&stStatus,0,sizeof(STATUS));

  vDatosInicialesTiempo();
  vPreparacionSenales()  ;


  vInitConfig ();

  if (!bEntradaFactura ())
      return FALSE;
  if (stConfig.iNivelLog > 0)
      stStatus.LogNivel = stConfig.iNivelLog;
  else
      stStatus.LogNivel = iLOGNIVEL_DEF     ;

  if(!bInitInstance(stConfig.iTipoFactura))
      return (4);

  if (stConfig.bOptPreBilling) 
  {
     if(!bfnPreBilling(stConfig.iTipoFactura   ,
                       stConfig.lCodCliente    ,
                       stConfig.lNumAbonado    ,
                       stConfig.iCodProducto   ,
                       stConfig.lNumAlquiler   ,
                       stConfig.lNumEstaDia    ,
                       stConfig.lCodCiclFact   ,
                       stConfig.lNumProceso    ,
                       stConfig.lNumVenta      ,
                       stConfig.lNumTransaccion,
                       stConfig.lClienteIni    ,
                       stConfig.lClienteFin ))
     {
        iDError(szExeName,ERR018,vInsertarIncidencia);
        bExitInstance();
	    return (1);
     }
 
  }
  if (stConfig.bOptComposicion)
  {
      if (stStatus.IdPro2 != 0)
          iRegProc = 2;
      else
          iRegProc = 1;

      for (iInd=0;iInd<iRegProc;iInd++)
      {
           if (iInd == 1)
               lNumProceso = stStatus.IdPro2;
           else
               lNumProceso = stStatus.IdPro ;

           if (ifnComposicion (lNumProceso,stConfig.lCodCliente,
                               stConfig.iTipoFactura))
           {
               iDError (szExeName,ERR029,vInsertarIncidencia);
               bExitInstance ();
               return (2);
           }
      }
  }

  bExitInstance  ();
  return (0);
}/************************** Final main **************************************/



/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisión                                            : */
/**  %PR% */
/** Autor de la Revisión                                : */
/**  %AUTHOR% */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creación de la Revisión                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

