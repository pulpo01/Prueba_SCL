/******************************************************************************

 Fichero    :  composi.pc 
 Descripcion:   
 Fecha      :  21-02-1997 
 Autor      :  Javier Garcia Paredes
*******************************************************************************/

#define _COMPOSI_C_

#include <composi.h>

/* ------------------------------------------------------------------------- */
/*    bComposicion ()                                                        */
/* Valores Retorno : 0 => Todo Ok                                            */
/*                   1 => Error Paso a Historicos                            */
/*                   2 => Error Impresion                                    */
/* ------------------------------------------------------------------------- */
int ifnComposicion(long lNumProceso,long lCodCliente,int iTipFact) 
{
    BOOL bRes      = TRUE;

    memset (&stProceso, 0, sizeof (PROCESO));

    strncpy (stAnomProceso.szDesProceso,"Composicion",
             sizeof(stAnomProceso.szDesProceso));
    stAnomProceso.lCodCliente = lCodCliente     ;
    stAnomProceso.lNumProceso = lNumProceso     ;
    stProceso.lNumProceso     = lNumProceso     ;

    vDTrazasLog (szExeName,
    "\n     *********************************************************************"
    "\n     *                          COMPOSICION                              *"
	    "\n     *********************************************************************"
	    "\n\t\t* COMPOSICION FACTURA CONTADO\n"
		"\n\t\t=> Num.Proceso  [%ld]",
	    LOG03,lNumProceso);
    vDTrazasError (szExeName,
    "\n     *********************************************************************"
    "\n     *                           COMPOSICION                             *"
	    "\n     *********************************************************************"
	    "\n\t\t* COMPOSICION FACTURA CONTADO\n"
                             "\n\t\t=> Num.Proceso  [%ld]",
                             LOG03,lNumProceso);

    memset (&stVenta       , 0, sizeof (VENTAS))      ;
    memset (&stTransContado, 0, sizeof (TRANSCONTADO));

	/* RAO160402: Carga datos en estructura para el manejo de decimales */
   	if (!bGetParamDecimales ())
   	{
	    vDTrazasError (szExeName,"\n\t\t* Error en la obtencionde numero de Decimales",LOG03);
        bRes = FALSE;
    }

    if (!bfnInitInterFact(iPROCESO_INT_FACTURACION,lNumProceso,iTipFact))
       bRes = FALSE;

    if (bRes)
        if (!bfnCargaComposicion(lNumProceso, lCodCliente, &stVenta, &stTransContado))
            bRes = FALSE;

    if (bRes)
    {
        if (stPreFactura.iNumRegistros > 0)
        {
			if (!bfnPasoHistoricos ())
            	bRes = FALSE;
        } 
    }
    vFreeMaxColPreFa ();
    vfnFreeCicloCli  ();
    
    if (!bRes)
    {
        if(!bfnOraRollBack())
        {
            iDError(szExeName,ERR000,vInsertarIncidencia,"RollBackWork",szfnORAerror());
            bChangeIndEstadoPro(stStatus.IdPro,PROC_EJECUTANDOSE,iESTAPROC_TERMINADO_ERROR);
            bChangeCodEstaProcInterfaz(stStatus.IdPro,iESTAPROC_TERMINADO_ERROR);
            vFreeModulos ();
            return (1)     ;
        }
        if(!bInsertaAnomProceso (&stAnomProceso))
        {
            if(!bfnOraRollBack ())
            {
                iDError(szExeName,ERR000,vInsertarIncidencia,"RollBackWork",szfnORAerror());
                bChangeIndEstadoPro(stStatus.IdPro,PROC_EJECUTANDOSE,iESTAPROC_TERMINADO_ERROR);
                bChangeCodEstaProcInterfaz(stStatus.IdPro,iESTAPROC_TERMINADO_ERROR);
                vFreeModulos ();
                return (1)     ; 
            }
        }/* fin if bInsertaAnomProceso ... */
        else
        {
            if(!bfnOraCommit())
            {
                iDError(szExeName,ERR000,vInsertarIncidencia,"CommitWork",szfnORAerror());
                bChangeIndEstadoPro(stStatus.IdPro,PROC_EJECUTANDOSE,iESTAPROC_TERMINADO_ERROR);
                bChangeCodEstaProcInterfaz(stStatus.IdPro,iESTAPROC_TERMINADO_ERROR);
                vFreeModulos();
                return (1)    ; 
            }
        }/* fin else bInsertaAnom ... */
        bChangeIndEstadoPro(stStatus.IdPro,PROC_EJECUTANDOSE,iESTAPROC_TERMINADO_ERROR);
        bChangeCodEstaProcInterfaz(stStatus.IdPro,iESTAPROC_TERMINADO_ERROR);
        vFreeModulos ();
        return (1)     ; 
    }/* fin if !bRes */
    else
    {
        bChangeIndEstadoPro(stStatus.IdPro,PROC_EJECUTANDOSE,iESTAPROC_TERMINADO_OK);
        bChangeCodEstaProcInterfaz(stStatus.IdPro,iESTAPROC_TERMINADO_OK);
        if(!bfnOraCommit())
        {
            iDError(szExeName,ERR000,vInsertarIncidencia,"CommitWork",szfnORAerror());
            bChangeIndEstadoPro(stStatus.IdPro,PROC_EJECUTANDOSE,iESTAPROC_TERMINADO_ERROR);
            bChangeCodEstaProcInterfaz(stStatus.IdPro,iESTAPROC_TERMINADO_ERROR);
            vFreeModulos ();
            return (1)     ; 
        }
    }
    vDTrazasLog (szExeName,"\n\n\t*** Proceso Composicion finalizado ***\n",LOG03);
    
    return (!bRes )?1:0;  
    
}/*************************** Final bComposicion ****************************/

/****************************************************************************/
/*                         funcion : bfnCargaComposcion                     */
/****************************************************************************/
static BOOL bfnCargaComposicion (long          lNumProceso,
                                 long          lCodCliente,
                                 VENTAS       *pstVenta   ,
                                 TRANSCONTADO *pstTransContado)
{
  static BOOL         bOptProceso = FALSE ;
  static ENLACEHIST   stEnlaceHist        ;
  BOOL 	bPreBilling = FALSE;  
  int  	iCodZonaImpos = 0    ;
  char  szCodRegion    [4]="";
  char  szCodProvincia [6]="";
  char  szCodCiudad    [6]="";
  char  modulo[] = "bfnCargaComposicion";
  char  szCodOficina   [3]="";

  
  	memset(&stEnlaceHist,0,sizeof(ENLACEHIST));
  
  	vDTrazasLog (modulo,"\n\t\t* Parametros de Entrada a Carga Composcion"
                         "\n\t\t=> Num.Proceso [%ld]"
                         "\n\t\t=> Cod.Cliente [%ld]", LOG05,
                         lNumProceso, lCodCliente);

	/***************************************************************************/
	/*  Si ejecutamos el PreBilling y Composicion conjuntamente la carga de es-*/
	/* tas tablas habran sido efectuadas, y por lo tanto son inecesarias.      */
	/***************************************************************************/
	if (stPreFactura.iNumRegistros == 0)
	{
		if (!bfnCargaDesAcumulado (pstDesAcumulado, &NUM_DESACUMULADO))
	         return FALSE;
	    if (!bGetDatosGener (&stDatosGener, szSysDate))
	         return FALSE;
	
	    stProceso.lNumProceso = lNumProceso;
	    if (!bfnGetProceso    (&stProceso))
	         return FALSE;
	
	    if (!bfnDBCargaPresupuesto (lNumProceso, lCodCliente))
	         return FALSE;
	         
	    /* RAO030502 : Se agrega la busqueda de la zona impositiva */
	  	/* ******************************************************** */
	}
	else
	    bPreBilling = TRUE;
	
	if (stPreFactura.iNumRegistros > 0)
	{
	    if (stPreFactura.A_PFactura[0].lNumVenta        > 0 &&
	        stPreFactura.A_PFactura[0].lNumTransaccion  > 0)
	    {
	        pstVenta->lNumVenta       = 
	                                stPreFactura.A_PFactura[0].lNumVenta      ;
	        pstVenta->lNumTransaccion = 
	                                stPreFactura.A_PFactura[0].lNumTransaccion; 
	        if (!bGetVenta (pstVenta))
	             return FALSE;
	    }
	    if (stPreFactura.A_PFactura[0].lNumTransaccion  > 0 &&
	        stPreFactura.A_PFactura[0].lNumVenta        <=0)
	    {
	        pstTransContado->lNumTransaccion =
	                       stPreFactura.A_PFactura[0].lNumTransaccion ;
	
	        if (!bGetTransContado (pstTransContado))
	             return FALSE;
	    }
	    stCliente.lCodCliente = stPreFactura.A_PFactura[0].lCodCliente ; 
	    stCliente.iIndCredito = stPreFactura.A_PFactura[0].iIndCuota   ;
	    stCliente.iIndSuperTel= 0                                      ;
	    stCliente.iCodCatImpos= stPreFactura.A_PFactura[0].iCodCatImpos;
	    stCliente.lCodPlanCom = stPreFactura.A_PFactura[0].lCodPlanCom ;
	
		if (!bPreBilling)
	    {
			if (stCliente.lCodCliente <= 0)
	        {
				/* RAO110402: se carga el stcliente */
			   	if (!bfnGetDatosCliente (stCliente.lCodCliente))
	     			return FALSE;
		  	}
	
	        if (!bfnGetDirecCli     (stCliente.lCodCliente, TIPDIRECCION_FACTURA))
	             return FALSE;
	    }
	    if (!bfnEvalZonasImpos (szSysDate, 5, &iCodZonaImpos,0 )) /* Se fuerza el valor a 0 */
		{
			vDTrazasError(modulo,"\n\t** No se pueden evaluar Zonas Impositivas **",LOG01);
			vDTrazasLog  (modulo,"\n\t** No se pueden evaluar Zonas Impositivas **",LOG01);
		    return FALSE;
		}
		stPreFactura.iCodZonaImpo=iCodZonaImpos;

	    if (!bfnCargaAbonoCli(stEnlaceHist, bOptProceso))
	         return FALSE;
	}
	return TRUE;
}/************************* Final bfnCargaComposicion ***********************/
