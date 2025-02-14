/**
 * 
 */
package com.tmmas.cl.scl.altacliente.negocio.ejb.session;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.HttpURLConnection;
import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.altacliente.service.servicios.AltaClienteSrv;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CampanaVigenteComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CargoLaboralDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteAltaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosCobranzaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosRecaudacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosGeneralesComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.MensajePromocionalDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadCancelacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadPagoComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OperadoraDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.PlanComercialComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.PlanTarifarioComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ProfesionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ProspectoComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ReferenciaClienteDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.RegistroFacturacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TarjetaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TipoCuentaBancariaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.VendedorComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaCuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosAnexoTerminalesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FacturaDTO;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!--
 * begin-xdoclet-definition -->
 * 
 * @ejb.bean name="AltaClienteFacadeSTL" description="An EJB named
 *           AltaClienteFacadeSTL" display-name="AltaClienteFacadeSTL"
 *           jndi-name="AltaClienteFacadeSTL" type="Stateless"
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition -->
 * @generated
 */

public class AltaClienteFacadeSTLBean implements javax.ejb.SessionBean
{

	private static final long serialVersionUID = 1L;

	private AltaClienteSrv srv = new AltaClienteSrv();

	private final Logger logger = Logger.getLogger(AltaClienteFacadeSTLBean.class);

	private SessionContext context = null;

	private CompositeConfiguration config;

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.create-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate()
	{
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ConceptosCobranzaComDTO getNivelFacturacion() throws AltaClienteException, RemoteException
	{
		logger.debug("getNivelFacturacion():start");
		ConceptosCobranzaComDTO conceptosCobranzaComDTO = null;

		try
		{
			conceptosCobranzaComDTO = srv.getNivelFacturacion();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getNivelFacturacion():end");
		return conceptosCobranzaComDTO;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ConceptosCobranzaComDTO getIndicadorMorosidad() throws AltaClienteException, RemoteException
	{
		logger.debug("getIndicadorMorosidad():start");
		ConceptosCobranzaComDTO conceptosCobranzaComDTO = null;

		try
		{
			conceptosCobranzaComDTO = srv.getIndicadorMorosidad();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getIndicadorMorosidad():end");
		return conceptosCobranzaComDTO;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteComDTO[] getTipoCliente() throws AltaClienteException, RemoteException
	{
		logger.debug("getTipoCliente():start");
		ClienteComDTO[] clienteComDTOs = null;
		try
		{
			clienteComDTOs = srv.getTipoCliente();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTipoCliente():end");
		return clienteComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public IdentificadorCivilComDTO[] getTipoIdentificadoresCiviles() throws AltaClienteException, RemoteException
	{
		logger.debug("getTipoIdentificadoresCiviles():start");
		IdentificadorCivilComDTO[] identificadorCivilComDTOs = null;

		try
		{
			identificadorCivilComDTOs = srv.getTipoIdentificadoresCiviles();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTipoIdentificadoresCiviles():end");
		return identificadorCivilComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuentaComDTO[] getListaClasificacionCuenta() throws AltaClienteException, RemoteException
	{
		logger.debug("getListaClasificacionCuenta():start");
		CuentaComDTO[] arrayCuentaCommon = null;
		try
		{
			arrayCuentaCommon = srv.getListaClasificacionCuenta();
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getListaClasificacionCuenta():end");
		return arrayCuentaCommon;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorComDTO[] getTipoComisionista() throws AltaClienteException, RemoteException
	{
		logger.debug("getTipoComisionista():start");
		VendedorComDTO[] arrayVendedorCommon = null;
		try
		{
			arrayVendedorCommon = srv.getTipoComisionista();
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTipoComisionista():end");
		return arrayVendedorCommon;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesComDTO[] getIdiomas() throws AltaClienteException, RemoteException
	{
		logger.debug("getIdiomas():start");
		DatosGeneralesComDTO[] datosGeneralesComDTOs = null;

		try
		{
			datosGeneralesComDTOs = srv.getIdiomas();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getIdiomas():end");
		return datosGeneralesComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OficinaComDTO[] getOficinas(OficinaComDTO oficinaComDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("getOficinas():start");
		OficinaComDTO[] oficinaComDTOs = null;

		try
		{
			oficinaComDTOs = srv.getOficinas(oficinaComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getOficinas():end");
		return oficinaComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanComercialComDTO[] getPlanesComerciales() throws AltaClienteException, RemoteException
	{
		logger.debug("getPlanesComerciales():start");
		PlanComercialComDTO[] planComercialComDTOs = null;

		try
		{
			planComercialComDTOs = srv.getPlanesComerciales();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getPlanesComerciales():end");
		return planComercialComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteComDTO[] getCategoriasImpositivas() throws AltaClienteException, RemoteException
	{
		logger.debug("getCategoriasImpositivas():start");
		ClienteComDTO[] clienteComDTOs = null;

		try
		{
			clienteComDTOs = srv.getCategoriasImpositivas();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCategoriasImpositivas():end");
		return clienteComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesComDTO[] getCategoriasTributarias() throws AltaClienteException, RemoteException
	{
		logger.debug("getCategoriasTributarias():start");
		DatosGeneralesComDTO[] datosGeneralesComDTOs = null;

		try
		{
			datosGeneralesComDTOs = srv.getCategoriasTributarias();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCategoriasTributarias():end");
		return datosGeneralesComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesComDTO[] getListEstadosCiviles() throws AltaClienteException, RemoteException
	{
		logger.debug("getListEstadosCiviles():start");
		DatosGeneralesComDTO[] datosGeneralesComDTOs = null;

		try
		{
			datosGeneralesComDTOs = srv.getListEstadosCiviles();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getListEstadosCiviles():end");
		return datosGeneralesComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesComDTO[] getListSubcategorias() throws AltaClienteException, RemoteException
	{
		logger.debug("getListSubcategorias():start");
		DatosGeneralesComDTO[] datosGeneralesComDTOs = null;

		try
		{
			datosGeneralesComDTOs = srv.getListSubcategorias();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getListSubcategorias():end");
		return datosGeneralesComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RegistroFacturacionComDTO[] getIndicadorDeFacturable() throws AltaClienteException, RemoteException
	{
		logger.debug("getIndicadorDeFacturable():start");
		RegistroFacturacionComDTO[] registroFacturacionComDTOs = null;

		try
		{
			registroFacturacionComDTOs = srv.getIndicadorDeFacturable();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getIndicadorDeFacturable():end");
		return registroFacturacionComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioComDTO[] getTiposPlanesTarifarios() throws AltaClienteException, RemoteException
	{
		logger.debug("getTiposPlanesTarifarios():start");
		PlanTarifarioComDTO[] planTarifarioComDTOs = null;

		try
		{
			planTarifarioComDTOs = srv.getTiposPlanesTarifarios();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTiposPlanesTarifarios():end");
		return planTarifarioComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ModalidadCancelacionComDTO[] getModalidadesCancelacion() throws AltaClienteException, RemoteException
	{
		logger.debug("getModalidadesCancelacion():start");
		ModalidadCancelacionComDTO[] modalidadCancelacionComDTOs = null;

		try
		{
			modalidadCancelacionComDTOs = srv.getModalidadesCancelacion();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getModalidadesCancelacion():end");
		return modalidadCancelacionComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ConceptosRecaudacionComDTO[] getBancos() throws AltaClienteException, RemoteException
	{
		logger.debug("getBancos():start");
		ConceptosRecaudacionComDTO[] conceptosRecaudacionComDTOs = null;

		try
		{
			conceptosRecaudacionComDTOs = srv.getBancos();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getBancos():end");
		return conceptosRecaudacionComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuentaDTO[] getCuentas(BusquedaCuentaDTO cuentaDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("Inicio");
		CuentaDTO[] r = null;

		try
		{
			r = srv.getCuentas(cuentaDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin");
		return r;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public boolean validarTelefonoReferencia(String telefono, String tipo) throws AltaClienteException, RemoteException
	{
		logger.debug("Inicio");
		boolean r = false;
		try
		{
			r = srv.validarTelefonoReferencia(telefono, tipo);
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin");
		return r;
	}
	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ConceptosRecaudacionComDTO[] getTiposTarjetas() throws AltaClienteException, RemoteException
	{
		logger.debug("getTiposTarjetas():start");
		ConceptosRecaudacionComDTO[] conceptosRecaudacionComDTOs = null;

		try
		{
			conceptosRecaudacionComDTOs = srv.getTiposTarjetas();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTiposTarjetas():end");
		return conceptosRecaudacionComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public TipoCuentaBancariaComDTO[] getTiposCuentasBancarias() throws AltaClienteException, RemoteException
	{
		logger.debug("getTiposCuentasBancarias():start");
		TipoCuentaBancariaComDTO[] tipoCuentaBancariaComDTOs = null;

		try
		{
			tipoCuentaBancariaComDTOs = srv.getTiposCuentasBancarias();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTiposCuentasBancarias():end");
		return tipoCuentaBancariaComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteComDTO getDatosBuro(ClienteComDTO clienteComDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("getDatosBuro():start");
		try
		{
			clienteComDTO = srv.getDatosBuro(clienteComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getDatosBuro():end");
		return clienteComDTO;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteComDTO[] getSubCategoriasImpositivas(ClienteComDTO clienteComDTO) throws AltaClienteException,
			RemoteException
	{
		logger.debug("getSubCategoriasImpositivas():start");
		ClienteComDTO[] clienteComDTOs = null;

		try
		{
			clienteComDTOs = srv.getSubCategoriasImpositivas(clienteComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getSubCategoriasImpositivas():end");
		return clienteComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ModalidadPagoComDTO[] getModalidadesPago(ModalidadCancelacionComDTO modalidadCancelacionComDTO)
			throws AltaClienteException, RemoteException
	{
		logger.debug("getModalidadesPago():start");
		ModalidadPagoComDTO[] modalidadPagoComDTOs = null;

		try
		{
			modalidadPagoComDTOs = srv.getModalidadesPago(modalidadCancelacionComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getModalidadesPago():end");
		return modalidadPagoComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ConceptosRecaudacionComDTO[] getSucursalesBanco(ConceptosRecaudacionComDTO conceptosRecaudacionComDTO)
			throws AltaClienteException, RemoteException
	{
		logger.debug("getSucursalesBanco():start");
		ConceptosRecaudacionComDTO[] conceptosRecaudacionComDTOs = null;

		try
		{
			conceptosRecaudacionComDTOs = srv.getSucursalesBanco(conceptosRecaudacionComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getSucursalesBanco():end");
		return conceptosRecaudacionComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioComDTO[] getTiposPlanesTarifarios(ClienteComDTO clienteComDTO) throws AltaClienteException,
			RemoteException
	{
		logger.debug("getTiposPlanesTarifarios():start");
		PlanTarifarioComDTO[] planTarifarioComDTOs = null;

		try
		{
			planTarifarioComDTOs = srv.getTiposPlanesTarifarios(clienteComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTiposPlanesTarifarios():end");
		return planTarifarioComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioComDTO[] getLimitesConsumo(PlanTarifarioComDTO planTarifarioComDTO)
			throws AltaClienteException, RemoteException
	{
		logger.debug("getLimitesConsumo():start");
		PlanTarifarioComDTO[] planTarifarioComDTOs = null;

		try
		{
			planTarifarioComDTOs = srv.getLimitesConsumo(planTarifarioComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getLimitesConsumo():end");
		return planTarifarioComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CampanaVigenteComDTO[] getCampanasVigentesPostPago() throws AltaClienteException, RemoteException
	{
		logger.debug("getCampanasVigentesPostPago():start");
		CampanaVigenteComDTO[] campanaVigenteComDTOs = null;

		try
		{
			campanaVigenteComDTOs = srv.getCampanasVigentesPostPago();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCampanasVigentesPostPago():end");
		return campanaVigenteComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ProspectoComDTO importarProspecto(ClienteComDTO clienteComDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("importarProspecto():start");
		ProspectoComDTO prospectoComDTO = null;

		try
		{
			prospectoComDTO = srv.importarProspecto(clienteComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("importarProspecto():end");
		return prospectoComDTO;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesComDTO[] getPaises() throws AltaClienteException, RemoteException
	{
		logger.debug("getPaises():start");
		DatosGeneralesComDTO[] datosGeneralesComDTOs = null;

		try
		{
			datosGeneralesComDTOs = srv.getPaises();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getPaises():end");
		return datosGeneralesComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesComDTO[] getActividades() throws AltaClienteException, RemoteException
	{
		logger.debug("getActividades():start");
		DatosGeneralesComDTO[] datosGeneralesComDTOs = null;

		try
		{
			datosGeneralesComDTOs = srv.getActividades();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getActividades():end");
		return datosGeneralesComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesComDTO[] getEstadosCiviles() throws AltaClienteException, RemoteException
	{
		logger.debug("getEstadosCiviles():start");
		DatosGeneralesComDTO[] datosGeneralesComDTOs = null;

		try
		{
			datosGeneralesComDTOs = srv.getEstadosCiviles();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getEstadosCiviles():end");
		return datosGeneralesComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RegistroFacturacionComDTO[] getCiclosFacturacion() throws AltaClienteException, RemoteException
	{
		logger.debug("getCiclosFacturacion():start");
		RegistroFacturacionComDTO[] registroFacturacionComDTOs = null;

		try
		{
			registroFacturacionComDTOs = srv.getCiclosFacturacion();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCiclosFacturacion():end");
		return registroFacturacionComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RegistroFacturacionComDTO[] getCiclosFacturacionPrepago() throws RemoteException
	{
		logger.debug("getCiclosFacturacionPrepago():start");
		RegistroFacturacionComDTO[] registroFacturacionComDTOs = null;

		try
		{
			registroFacturacionComDTOs = srv.getCiclosFacturacionPrepago();
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
		}
		logger.debug("getCiclosFacturacionPrepago():end");
		return registroFacturacionComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuentaComDTO crearCliente(CuentaComDTO cuentaComDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("crearCliente():start");
		try
		{
			srv.crearCliente(cuentaComDTO);
		}
		catch (AltaClienteException e)
		{
			context.setRollbackOnly();
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("crearCliente():end");
		return cuentaComDTO;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteComDTO crearCliente(ClienteComDTO clienteComDTO) throws VentasException, RemoteException
	{
		logger.debug("crearCliente():start");
		ClienteComDTO respuesta = null;
		try
		{
			respuesta = srv.crearCliente(clienteComDTO);
		}
		catch (AltaClienteException e)
		{
			context.setRollbackOnly();
			logger.debug("LegalizaVenta:end");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(e.getMessage());
			v.setCodigo(e.getCodigo());
			v.setCodigoEvento(e.getCodigoEvento());
			v.setDescripcionEvento(e.getDescripcionEvento());
			throw v;
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("crearCliente():end");
		return respuesta;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void crearCuenta(CuentaComDTO cuentaComDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("crearCuenta():start");
		try
		{
			srv.crearCuenta(cuentaComDTO);
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("crearCuenta():end");
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RegistroFacturacionComDTO getAtributosCicloFacturable(RegistroFacturacionComDTO registroFacturacionComDTO)
			throws AltaClienteException, RemoteException
	{
		logger.debug("getAtributosCicloFacturable():start");
		RegistroFacturacionComDTO resultado;
		try
		{
			resultado = srv.getAtributosCicloFacturable(registroFacturacionComDTO);
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getAtributosCicloFacturable():end");
		return resultado;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioComDTO[] getPlanesTarifarios(ClienteComDTO clienteComDTO) throws AltaClienteException,
			RemoteException
	{
		logger.debug("getPlanesTarifarios():start");
		PlanTarifarioComDTO[] planTarifarioComDTOs = null;

		try
		{
			planTarifarioComDTOs = srv.getPlanesTarifarios(clienteComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getPlanesTarifarios():end");
		return planTarifarioComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public PlanTarifarioComDTO[] getListPlanTarifarioPorPlanORango(ClienteComDTO clienteComDTO)
			throws AltaClienteException, RemoteException
	{
		logger.debug("getListPlanTarifarioPorPlanORango():start");
		PlanTarifarioComDTO[] planTarifarioComDTOs = null;

		try
		{
			planTarifarioComDTOs = srv.getListPlanTarifarioPorPlanORango(clienteComDTO);

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getListPlanTarifarioPorPlanORango():end");
		return planTarifarioComDTOs;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuentaComDTO getCuentaNumIdent(CuentaComDTO cuentaComDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("getCuentaNumIdent():start");
		CuentaComDTO cuentaComDTO2 = null;

		try
		{
			cuentaComDTO2 = srv.getCuentaNumIdent(cuentaComDTO);
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCuentaNumIdent():end");
		return cuentaComDTO2;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public CuentaComDTO getCuenta(CuentaComDTO cuentaComDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("getCuenta():start");
		CuentaComDTO cuentaComDTO2 = null;
		try
		{
			cuentaComDTO2 = srv.getCuenta(cuentaComDTO);
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCuenta():end");
		return cuentaComDTO2;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public boolean validarNumeroIdentificacion(ClienteComDTO clienteComDTO) throws AltaClienteException,
			RemoteException
	{
		// Ini. Inc. 71895 10-11-2008
		logger.debug("validarNumeroIdentificacion():start");
		boolean resultado = false;
		try
		{
			resultado = srv.validarNumeroIdentificacion(clienteComDTO);
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("validarNumeroIdentificacion():end");
		return resultado;
	}

	// Fin Inc. 71895 10-11-2008

	// Ini. Inc. 72637 10-11-2008
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String obtenerCicloDefault() throws AltaClienteException, RemoteException
	{
		logger.debug("obtenerCicloDefault():start");
		String resultado = "";
		try
		{
			resultado = srv.obtenerCicloDefault();
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("obtenerCicloDefault():end");
		return resultado;
	}

	// Fin Inc. 72637 10-11-2008

	/** *************************************** */
	/* Nuevos metodos Guatemala - EL Salvador */
	/** *************************************** */

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteAltaDTO crearClienteFacturaImprimible(ClienteAltaDTO entrada) throws AltaClienteException,
			RemoteException
	{
		logger.debug("crearClienteFacturaImprimible():start");
		ClienteAltaDTO resultado = new ClienteAltaDTO();
		try
		{
			srv.crearClienteFacturaImprimible(entrada);
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("crearClienteFacturaImprimible():end");
		return resultado;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insMontoPreautorizado(ClienteAltaDTO entrada) throws AltaClienteException, RemoteException
	{
		logger.debug("insMontoPreautorizado():start");
		try
		{
			srv.insMontoPreautorizado(entrada);
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("insMontoPreautorizado():end");
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OperadoraDTO[] getOperadoras() throws AltaClienteException, RemoteException
	{
		logger.debug("getOperadoras():start");
		OperadoraDTO[] resultado;
		try
		{
			resultado = srv.getOperadoras();
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getOperadoras():end");
		return resultado;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ProfesionDTO[] getProfesiones() throws AltaClienteException, RemoteException
	{
		logger.debug("getProfesiones():start");
		ProfesionDTO[] resultado;
		try
		{
			resultado = srv.getProfesiones();
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getProfesiones():end");
		return resultado;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CargoLaboralDTO[] getCargosLaborales() throws AltaClienteException, RemoteException
	{
		logger.debug("getCargosLaborales():start");
		CargoLaboralDTO[] resultado;
		try
		{
			resultado = srv.getCargosLaborales();
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCargosLaborales():end");
		return resultado;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesDTO[] getListCodigo(DatosGeneralesDTO datosGenerales) throws AltaClienteException,
			RemoteException
	{
		logger.debug("getListCodigo():start");
		DatosGeneralesDTO[] resultado;
		try
		{
			logger.debug("Inicio:getListCodigo()");
			resultado = srv.getListCodigo(datosGenerales);
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getListCodigo():start");
		return resultado;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public NumeroIdentificacionDTO validarIdentificador(NumeroIdentificacionDTO entrada) throws AltaClienteException,
			RemoteException
	{
		logger.debug("validarIdentificador():start");
		NumeroIdentificacionDTO resultado;
		try
		{
			logger.debug("Inicio:validarIdentificador()");
			resultado = srv.validarIdentificador(entrada);
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("validarIdentificador():start");
		return resultado;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteAltaDTO crearCliente(ClienteAltaDTO entrada) throws AltaClienteException, RemoteException
	{
		logger.debug("crearCliente():start");
		ClienteAltaDTO resultado = new ClienteAltaDTO();
		try
		{
			logger.debug("Inicio:crearCliente()");
			resultado = srv.crearCliente(entrada);
		}
		catch (AltaClienteException e)
		{
			context.setRollbackOnly();
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("crearCliente():start");
		return resultado;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public TarjetaDTO validarTarjeta(TarjetaDTO entrada) throws AltaClienteException, RemoteException
	{
		logger.debug("validarTarjeta():start");
		TarjetaDTO resultado;
		try
		{
			logger.debug("Inicio:validarTarjeta()");
			resultado = srv.validarTarjeta(entrada);
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("validarTarjeta():start");
		return resultado;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws AltaClienteException,
			RemoteException
	{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		logger.debug("getParametroGeneral:start");
		try
		{
			resultado = srv.getParametroGeneral(entrada);
		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getParametroGeneral:end");
		return resultado;
	}// fin getParametroGeneral

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insReferenciaCliente(ReferenciaClienteDTO entrada) throws AltaClienteException, RemoteException
	{
		logger.debug("insertaReferenciaCliente:start");
		try
		{
			srv.insReferenciaCliente(entrada);
		}
		catch (AltaClienteException e)
		{
			context.setRollbackOnly();
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("insertaReferenciaCliente:end");
	}// fin insertaReferenciaCliente

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClasificacionDTO[] getClasificaciones()	throws AltaClienteException, RemoteException
	{
		logger.debug("getClasificaciones:start");
		ClasificacionDTO[] resultado = null;
		try
		{
			resultado = srv.getClasificaciones();
		}
		catch (AltaClienteException e)
		{
			context.setRollbackOnly();
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getClasificaciones:end");
		return resultado;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ValorClasificacionDTO[] getCalificaciones() throws AltaClienteException, RemoteException
	{
		logger.debug("getCalificaciones():start");
		ValorClasificacionDTO[] resultado;
		try
		{
			logger.debug("Inicio:getCalificaciones()");
			resultado = srv.getCalificaciones();
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCalificaciones():start");
		return resultado;
	}	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ValorClasificacionDTO[] getCrediticia() throws AltaClienteException, RemoteException
	{
		logger.debug("getCrediticia():start");
		ValorClasificacionDTO[] resultado;
		try
		{
			logger.debug("Inicio:getCrediticia()");
			resultado = srv.getCrediticia();
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCrediticia():start");
		return resultado;
	}	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ValorClasificacionDTO[] getColores() throws AltaClienteException, RemoteException
	{
		logger.debug("getColores():start");
		ValorClasificacionDTO[] resultado;
		try
		{
			logger.debug("Inicio:getColores()");
			resultado = srv.getColores();
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getColores():start");
		return resultado;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ValorClasificacionDTO[] getSegmentos(String codTipoCliente) throws AltaClienteException, RemoteException
	{
		logger.debug("getSegmentos():start");
		ValorClasificacionDTO[] resultado;
		try
		{
			logger.debug("Inicio:getSegmentos()");
			resultado = srv.getSegmentos(codTipoCliente);
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getSegmentos():start");
		return resultado;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ValorClasificacionDTO[] getCategorias() throws AltaClienteException, RemoteException
	{
		logger.debug("getCategorias():start");
		ValorClasificacionDTO[] resultado;
		try
		{
			logger.debug("Inicio:getCategorias()");
			resultado = srv.getCategorias();
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCategorias():start");
		return resultado;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public FacturaDTO getDatosCicloFacturacion() throws AltaClienteException, RemoteException
	{
		logger.debug("getDatosCicloFacturacion:start");
		FacturaDTO resultado;
		try
		{
			logger.debug("Inicio:getDatosCicloFacturacion");
			resultado = srv.getDatosCicloFacturacion();
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getDatosCicloFacturacion:end");
		return resultado;
	}
		
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CategoriaCambioDTO[] getCategoriasCambio() throws AltaClienteException, RemoteException
	{
		logger.debug("getCategoriasCambio():start");
		CategoriaCambioDTO[] resultado;
		try
		{
			logger.debug("Inicio:getCategoriasCambio()");
			resultado = srv.getCategoriasCambio();
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCategoriasCambio():start");
		return resultado;
	}	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void insCategoriaCambioCliente(CategoriaCambioClienteDTO categCambioCliente) throws AltaClienteException, RemoteException
	{
		logger.debug("insCategoriaCambioCliente:start");
		try
		{
			srv.insCategoriaCambioCliente(categCambioCliente);
		}
		catch (AltaClienteException e)
		{
			context.setRollbackOnly();
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("insCategoriaCambioCliente:end");
	}// fin insCategoriaCambioCliente
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated 
	 */
	public Boolean validaClienteLN(String numIdent, String codTipIdent) throws AltaClienteException, RemoteException {
		Boolean r = Boolean.FALSE;
		logger.info("Inicio");
		try {
			r = srv.validaClienteLN(numIdent, codTipIdent);
		}
		catch (CustomerDomainException e) {
			logger.error("log error [" + StackTraceUtl.getStackTrace(e) + "]");
			AltaClienteException ex = new AltaClienteException(e.getMessage());
			ex.setCodigo(e.getCodigo());
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setMessage(e.getMessage());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			throw ex;
		}
		catch (Exception e) {
			logger.error("log error[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new AltaClienteException(e);
		}
		logger.info("Fin");
		return r;
	}
	
	
	/*
	 * public DatosGeneralesComDTO validaIdentificador(DatosGeneralesComDTO
	 * datosGeneralesComDTO) throws AltaClienteException,RemoteException{
	 * logger.debug("validaIdentificador():start"); DatosGeneralesComDTO
	 * datosGeneralesComDTO2 = null; try{ datosGeneralesComDTO2 =
	 * srv.validaIdentificador(datosGeneralesComDTO); } catch
	 * (AltaClienteException e) { logger.debug("AltaClienteException"); String
	 * log = StackTraceUtl.getStackTrace(e); logger.debug("log error[" + log +
	 * "]"); throw e; } catch (Exception e) { logger.debug("Exception"); String
	 * log = StackTraceUtl.getStackTrace(e); logger.debug("log error[" + log +
	 * "]"); throw new AltaClienteException(e); }
	 * logger.debug("validaIdentificador():end"); return datosGeneralesComDTO2; }
	 */

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	/*
	 * public ConceptosCobranzaComDTO validaTarjeta(ConceptosCobranzaComDTO
	 * cobranzaComDTO) throws AltaClienteException,RemoteException{
	 * logger.debug("validaTarjeta():start"); ConceptosCobranzaComDTO
	 * conceptosCobranzaComDTO = null;
	 * 
	 * try{ conceptosCobranzaComDTO = srv.validaTarjeta(cobranzaComDTO);
	 *  } catch (AltaClienteException e) { logger.debug("AltaClienteException");
	 * String log = StackTraceUtl.getStackTrace(e); logger.debug("log error[" +
	 * log + "]"); throw e; } catch (Exception e) { logger.debug("Exception");
	 * String log = StackTraceUtl.getStackTrace(e); logger.debug("log error[" +
	 * log + "]"); throw new AltaClienteException(e); }
	 * logger.debug("validaTarjeta():end"); return conceptosCobranzaComDTO; }
	 */
	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException
	{
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException
	{
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException
	{
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException, RemoteException
	{
		context = arg0;
	}

	/**
	 * 
	 */
	public AltaClienteFacadeSTLBean()
	{
		logger.debug("AltaClienteFacadeSTLBean():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("AltaClienteEJB.log"));
		logger.debug("AltaClienteFacadeSTLBean():End");
	}
	
	//Inicio P-CSR-11002 JLGN 28/04/2011
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO entrada) throws AltaClienteException, RemoteException
	{
		logger.debug("getValorParametro:start");
		DatosGeneralesDTO resultado;
		try
		{
			resultado = srv.getValorParametro(entrada);
		}
		catch (AltaClienteException e)
		{
			context.setRollbackOnly();
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getValorParametro:end");
		return resultado;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public FormularioDireccionDTO getDireccionPrepago(String codDireccion) throws AltaClienteException, RemoteException
	{
		logger.debug("getDireccionPrepago:start");
		FormularioDireccionDTO resultado;
		try
		{
			resultado = srv.getDireccionPrepago(codDireccion);
		}
		catch (AltaClienteException e)
		{
			context.setRollbackOnly();
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getDireccionPrepago:end");
		return resultado;
	}
	
	//Fin P-CSR-11002 JLGN 28/04/2011
	
	//Inicio P-CSR-11002 JLGN 29-04-2011
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosClienteBuroDTO consultaBuro(String numIdent, String tipIdent, String tipoEstudio, String usuario) throws AltaClienteException, RemoteException, Exception
	{
		logger.debug("consultaBuro:start");
		//DatosClienteBuroDTO resultado =  new DatosClienteBuroDTO();
		DatosClienteBuroDTO resultado =  null;
		String ruta="";
		try
		{			
			//Genera URL para consulta de Buro
			logger.debug("Genera URL para consulta de Buro");
			ruta = srv.consultaURLBuro(numIdent,tipIdent,tipoEstudio);
			//Realiza Consulta de Buro y Obtiene los datos del XML
			logger.debug("Realiza Consulta de Buro y Obtiene los datos del XML");
			resultado = srv.consultaBuro(ruta, tipIdent);
			//Inserta los datos Obtenidos del XML en BD
			logger.debug("Inserta los datos Obtenidos del XML en BD");
			logger.debug("Solo se inserta en BD cuando el Tipo de Estudio es DGG");
			if(tipoEstudio.equals("DGG")){
				//Inicio Inc. 179734 JLGN 01-01-2012 
				if(resultado.getFlagDDA().equals("false")){
					srv.insertaClienteBuro(resultado, usuario);
				}
				//Fin Inc. 179734 JLGN 01-01-2012 	
			}
			resultado.setFlagTipCliente("true");
		}
		catch (Exception e) {
			logger.error("log error[" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}				
		logger.debug("consultaBuro:end");
		return resultado;
	}
	
	//Fin P-CSR-11002 JLGN 29-04-2011
	
	//Inicio P-CSR-11002 JLGN 05-06-2011
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public boolean validaPassClasificacion(String passCalificacion) throws VentasException, RemoteException
	{
		logger.debug("validaPassClasificacion:start");
		boolean flagCalificacion = true;
		try {
			flagCalificacion = srv.validaPassClasificacion(passCalificacion);
		}
		catch(CustomerDomainException e){
			logger.debug("validaPassClasificacion:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validaPassClasificacion:end");	
		return flagCalificacion;
	}//fin getDatosCliente
	//Fin P-CSR-11002 JLGN 05-06-2011
	
	//Inicio P-CSR-11002 JLGN 01-07-2011
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public long obtineLimConsuCliente(String numIdent, String tipIdent) throws VentasException
	{
		logger.debug("obtineLimConsuCliente:start");
		long resultado = 0;
		try {
			resultado = srv.obtineLimConsuCliente(numIdent, tipIdent);
		}catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtineLimConsuCliente:start:end");	
		return resultado;
	}//fin obtineLimConsuCliente:start
	//Fin P-CSR-11002 JLGN 01-07-2011

	//Inicio P-CSR-11002 JLGN 05-08-2011	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public MensajePromocionalDTO[] getMensajePromocional() throws AltaClienteException, RemoteException
	{
		logger.debug("getMensajePromocional():start");
		MensajePromocionalDTO[] mensajePromocional = null;
		try
		{
			mensajePromocional = srv.getMensajePromocional();

		}
		catch (AltaClienteException e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e)
		{
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getMensajePromocional():end");
		return mensajePromocional;
	}
	//Inicio P-CSR-11002 JLGN 05-08-2011
	
	//Inicio RA JLGN 04-01-2012
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public boolean validaClienteDDA(String codCliente) throws VentasException, CustomerDomainException{
		logger.debug("validaClienteDDA():start");
		boolean resultado = srv.validaClienteDDA(codCliente);
		logger.debug("validaClienteDDA():end");
		return resultado;		
	}
	//Fin RA JLGN 04-01-2012

	//Inicio RA JLGN 05-01-2012
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public boolean validaLineasClienteDDA(String tipIdent, String numIdent) throws VentasException, CustomerDomainException{
		logger.debug("validaLineasClienteDDA():start");
		boolean resultado = srv.validaLineasClienteDDA(tipIdent, numIdent);
		logger.debug("validaLineasClienteDDA():end");
		return resultado;		
	}
	//Fin RA JLGN 05-01-2012
	
	//Inicio MA-180654 HOM
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoDTO[] getAbonadosActvos(String tipIdent, String numIdent) throws VentasException, CustomerDomainException{
		logger.debug("getAbonadosActvos():start");
		AbonadoDTO[] resultado = srv.getAbonadosActvos(tipIdent, numIdent);
		logger.debug("getAbonadosActvos():end");
		return resultado;		
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosAnexoTerminalesDTO getDatosAnexoTerminales(Long numVenta) throws VentasException, CustomerDomainException{
		logger.debug("getDatosAnexoTerminales():start");
		DatosAnexoTerminalesDTO resultado = srv.getDatosAnexoTerminales(numVenta);
		logger.debug("getDatosAnexoTerminales():end");
		return resultado;		
	}
	//Fin MA-180654 HOM
}
