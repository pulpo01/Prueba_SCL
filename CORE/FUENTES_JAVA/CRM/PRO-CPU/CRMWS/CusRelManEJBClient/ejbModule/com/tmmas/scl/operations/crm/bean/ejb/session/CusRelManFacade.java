/*
 * Generated by XDoclet - Do not edit!
 */
package com.tmmas.scl.operations.crm.bean.ejb.session;

/**
 * Remote interface for CusRelManFacade.
 * @generated 
 * @wtp generated
 */
public interface CusRelManFacade
   extends javax.ejb.EJBObject
{
   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public java.lang.String foo( java.lang.String param )
      throws java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws SupOrdHanException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO sendToQueueAnulacionVenta( com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO datosVenta )
      throws com.tmmas.scl.operations.crm.common.Exception.CusRelManWSException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws ManConException
    * @throws ManProOffInvException
    * @throws NegSalException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO sendToQueueActivacionDesactivacionVenta( java.lang.String numeroVenta,java.lang.String codigoCliente )
      throws com.tmmas.scl.operations.crm.common.Exception.CusRelManWSException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws ManConException
    * @throws ManProOffInvException
    * @throws NegSalException
    * @throws SupOrdHanException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO sendToQueueActivacionProductosPorDefecto( com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO datosVenta )
      throws com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException, com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException, com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException, com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws SupOrdHanException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO sendToQueueRechazoVenta( com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO datosVenta )
      throws com.tmmas.scl.operations.crm.common.Exception.CusRelManWSException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws ManConException
    * @throws ManCusInvException
    * @throws ManProOffInvException
    * @throws NegSalException
    * @throws SupOrdHanException
    * @throws IssCusOrdException
    * @throws RemoteException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO activarDesactivarMantenerProductos( com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.CambioPlanAdicionalDTO[] cambioPlanAdicionalArr )
      throws com.tmmas.scl.operations.crm.common.Exception.CusRelManWSException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws IssCusOrdException
    * @throws RemoteException
    * @throws SupOrdHanException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO mantencionPlanesAdicionales( com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.PlanesAdicionalesDTO[] planesAdicionales )
      throws com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException, com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws ManConException
    * @throws ManProOffInvException
    * @throws NegSalException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosOutBeneficioDTO[] obtenerProductosOfertablesBeneficiario( com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosInBeneficioDTO datosInBeneficio )
      throws com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException, com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException, com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws RemoteException
    * @throws SOAPGeneralException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO contratacionPlanesAdicionalesOpcionales( com.tmmas.scl.operations.crm.common.dataTransferObject.DatosContrPlanesAdicDTO datosContratacion )
      throws com.tmmas.cl.framework.exception.SOAPGeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws RemoteException
    * @throws SOAPGeneralException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO contratacionModulos( com.tmmas.scl.operations.crm.common.dataTransferObject.DatosContrModulosDTO datosContratacion )
      throws com.tmmas.cl.framework.exception.SOAPGeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws SOAPGeneralException
    * @throws RemoteException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.operations.crm.common.dataTransferObject.RetornoListaNumerosDTO consultaDetalleProductoContratado( com.tmmas.scl.operations.crm.common.dataTransferObject.DatosConsultaProductoDTO datosConsulta )
      throws com.tmmas.cl.framework.exception.SOAPGeneralException, java.rmi.RemoteException;

   public com.tmmas.scl.operations.crm.common.dataTransferObject.RetornoListaNumerosDTO consultaDetalleNumeroFrecuente( com.tmmas.scl.operations.crm.common.dataTransferObject.DatosConsultaProductoDTO datosConsulta )
      throws com.tmmas.cl.framework.exception.SOAPGeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws RemoteException
    * @throws SOAPGeneralException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.operations.crm.common.dataTransferObject.RespProductoContratadoSimpleDTO obtenerPlanesAdicionalesContratados( com.tmmas.scl.operations.crm.common.dataTransferObject.DatosObtProductosContratadosDTO datosObtProdContratadosDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws RemoteException
    * @throws SOAPGeneralException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.operations.crm.common.dataTransferObject.RespProductoContratadoSimpleDTO consultarModulosContratados( com.tmmas.scl.operations.crm.common.dataTransferObject.DatosObtProductosContratadosDTO datosObtProdContratadosDTO )
      throws com.tmmas.cl.framework.exception.SOAPGeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws RemoteException
    * @throws SOAPGeneralException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO validarContratanteBeneficiario( com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ContratanteBeneficiarioDTO contratanteBeneficiarioDTO )
      throws com.tmmas.cl.framework.exception.SOAPGeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws SupOrdHanException
    * @throws RemoteException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.operations.crm.common.dataTransferObject.DatosOutWSListaPLanesDTO obtenerPlanesAdicionales( com.tmmas.scl.operations.crm.common.dataTransferObject.DatosInWSListaPLanesDTO datosInWSListaPLanesDTO )
      throws com.tmmas.cl.framework.exception.SOAPGeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @throws SupOrdHanException
    * @throws RemoteException
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.scl.operations.crm.common.dataTransferObject.DatosOutWSObtenerModProductoDTO obtenerModificacionesProducto( com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO productoContratado )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated Permite validar al cliente contra el modelo de restricciones    */
   public com.tmmas.scl.operations.crm.common.dataTransferObject.RetornoConTokenDTO validacion( com.tmmas.scl.operations.crm.common.dataTransferObject.ValidacionAbonadoDTO param )
      throws java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated Permite desactivar un plan adicional opcional    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO desactivacionDePlanAdicional( com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ActDesPlanAdicDTO param )
      throws java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated Permite activar un plan adicional opcional    */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO activacionDePlanAdicional( com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ActDesPlanAdicDTO param )
      throws java.rmi.RemoteException;

   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO AgregarEliminarNumerosFrecuentes( com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.InNumerosFrecuentesDTO inNumerosFrecuentesDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated     */
   public com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.IntegracionInClasificacionDTO consultaClasificacionCliente( com.tmmas.scl.operations.crm.common.dataTransferObject.InWsClasifClienteDTO inWsClasifClienteDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated     */
   public com.tmmas.scl.operations.crm.common.dataTransferObject.RespProductoContratadoSimpleDTO obtenerPlanesAdicionalesContratadosIntegracion( com.tmmas.scl.operations.crm.common.dataTransferObject.WSPlanesAdicionalesContratadosDTO wsPlanesAdicionalesContratadosDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated     */
   public com.tmmas.scl.operations.crm.common.dataTransferObject.WSListaProdOferDTO obtenerProductosOfertablesBeneficiarioIntegracion( com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosInBeneficioDTO datosInBeneficio )
      throws com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException, com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException, com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException, java.rmi.RemoteException;

}
