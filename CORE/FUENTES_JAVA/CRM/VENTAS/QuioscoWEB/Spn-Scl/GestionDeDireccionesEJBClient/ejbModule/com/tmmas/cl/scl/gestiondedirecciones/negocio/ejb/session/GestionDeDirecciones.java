/*
 * Generated by XDoclet - Do not edit!
 */
package com.tmmas.cl.scl.gestiondedirecciones.negocio.ejb.session;

/**
 * Remote interface for GestionDeDirecciones.
 * @generated 
 * @wtp generated
 */
public interface GestionDeDirecciones
   extends javax.ejb.EJBObject
{
   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO getDatosDireccion( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO direccionDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDireccionDTO getProvincias( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDireccionDTO provinciaDireccionDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDireccionDTO getCiudades( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDireccionDTO ciudadDireccionDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaDireccionDTO getComunas( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaDireccionDTO comunaDireccionDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO[] setDireccion( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO[] direccionNegocioDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO setDireccion( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO direccionNegocioDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public void updDireccion( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO direccionNegocioDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO getDireccionCodigo( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO direccionDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO getDireccion( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO direccionNegocioDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public void eliminaDireccion( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO direccionNegocioDTO )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO[] getListadoRegiones(  )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO[] getListadoProvincias( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO region )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO[] getListadoCiudaddes( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO provincia )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO[] getListadoComunas( com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO ciudad )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.PuebloDTO[] getListadoPueblos( com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO estado )
      throws com.tmmas.cl.framework.exception.GeneralException, java.rmi.RemoteException;

   /**
    * <!-- begin-xdoclet-definition -->
    * @generated //TODO: Must provide implementation for bean method stub    */
   public java.lang.String foo( java.lang.String param )
      throws java.rmi.RemoteException;

}
