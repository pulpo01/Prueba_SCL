package com.tmmas.cl.scl.altacliente.presentacion.delegate;

import java.io.IOException;
import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.altacliente.negocio.ejb.session.AltaClienteFacadeSTL;
import com.tmmas.cl.scl.altacliente.negocio.ejb.session.AltaClienteFacadeSTLHome;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CargoLaboralDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteAltaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosRecaudacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosGeneralesComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.MensajePromocionalDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadCancelacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadPagoComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OperadoraDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ProfesionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ReferenciaClienteDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.RegistroFacturacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TarjetaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TipoCuentaBancariaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaCuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class AltaClienteDelegate
{

	private static AltaClienteDelegate instance = null;

	private static Logger logger = Logger.getLogger(AltaClienteDelegate.class);

	public static AltaClienteDelegate getInstance()
	{
		if (instance == null)
		{
			instance = new AltaClienteDelegate();
		}
		return instance;
	}

	protected ServiceLocator svcLocator = ServiceLocator.getInstance();

	private Global global = Global.getInstance();

	private AltaClienteFacadeSTL getAltaClienteFacade() throws AltaClienteException
	{

		logger.debug("getAltaClienteFacade():start");

		AltaClienteFacadeSTLHome altaClienteFacadeHome = null;
		String jndi = global.getValorExterno("jndi.AltaClienteFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = global.getValorExterno("url.AltaClienteFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");

		String user = global.getValorExterno("security.principal").trim();
		String password = global.getValorExterno("security.credentials").trim();
		String initialContextFactory = global.getValorExterno("initial.context.factory").trim();

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);
		env.put(Context.PROVIDER_URL, url);
		// env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		// env.put(Context.SECURITY_CREDENTIALS, securityCredentials);

		Context context = null;
		try
		{
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		}
		catch (NamingException e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		Object obj = null;
		try
		{
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		}
		catch (NamingException e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}

		AltaClienteFacadeSTLHome facadeHome = (AltaClienteFacadeSTLHome) PortableRemoteObject.narrow(obj,
				AltaClienteFacadeSTLHome.class);

		logger.debug("Recuperada interfaz home de AltaClienteFacadeSTL...");
		AltaClienteFacadeSTL facade = null;
		try
		{
			facade = facadeHome.create();
		}
		catch (CreateException e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new AltaClienteException(e);

		}
		catch (RemoteException e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getAltaClienteFacade():end");
		return facade;
	}

	public DatosGeneralesDTO[] getListCodigo(DatosGeneralesDTO datosGenerales) throws AltaClienteException,
			RemoteException
	{
		logger.debug("getListCodigo():start");
		DatosGeneralesDTO[] tiposCliente = null;

		logger.debug("CodigoModulo=" + datosGenerales.getCodigoModulo());
		logger.debug("Tabla=" + datosGenerales.getTabla());
		logger.debug("Columna=" + datosGenerales.getColumna());

		try
		{
			tiposCliente = getAltaClienteFacade().getListCodigo(datosGenerales);
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getListCodigo():end");
		return tiposCliente;
	}

	public ValorClasificacionDTO[] getCategoriasCliente() throws AltaClienteException, RemoteException
	{
		logger.debug("getCategoriasCliente():start");
		ValorClasificacionDTO[] clienteComDTO = null;
		try
		{
			clienteComDTO = getAltaClienteFacade().getCategorias();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCategoriasCliente():end");
		return clienteComDTO;
	}

	public IdentificadorCivilComDTO[] getTipoIdentificadoresCiviles() throws AltaClienteException, RemoteException
	{
		logger.debug("getTipoIdentificadoresCiviles():start");
		IdentificadorCivilComDTO[] identificadorCivilComDTO = null;
		try
		{
			identificadorCivilComDTO = getAltaClienteFacade().getTipoIdentificadoresCiviles();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTipoIdentificadoresCiviles():end");
		return identificadorCivilComDTO;
	}

	public RegistroFacturacionComDTO[] getCiclosFacturacion() throws AltaClienteException, RemoteException
	{
		logger.debug("getCiclosFacturacion():start");
		RegistroFacturacionComDTO[] registroFacturacionComDTO = null;
		try
		{
			registroFacturacionComDTO = getAltaClienteFacade().getCiclosFacturacion();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCiclosFacturacion():end");
		return registroFacturacionComDTO;
	}

	public RegistroFacturacionComDTO[] getCiclosFacturacionPrepago() throws AltaClienteException, RemoteException
	{
		logger.debug("getCiclosFacturacionPrepago():start");
		RegistroFacturacionComDTO[] registroFacturacionComDTO = null;
		try
		{
			registroFacturacionComDTO = getAltaClienteFacade().getCiclosFacturacionPrepago();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
		}
		logger.debug("getCiclosFacturacionPrepago():end");
		return registroFacturacionComDTO;
	}

	public OperadoraDTO[] getOperadoras() throws AltaClienteException, RemoteException
	{
		logger.debug("getOperadoras():start");
		OperadoraDTO[] operadoras = null;
		try
		{
			operadoras = getAltaClienteFacade().getOperadoras();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
		}
		logger.debug("getOperadoras():end");
		return operadoras;
	}

	public DatosGeneralesComDTO[] getPaises() throws AltaClienteException, RemoteException
	{
		logger.debug("getPaises():start");
		DatosGeneralesComDTO[] paises = null;
		try
		{
			paises = getAltaClienteFacade().getPaises();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
		}
		logger.debug("getPaises():end");
		return paises;
	}

	public DatosGeneralesComDTO[] getEstadosCiviles() throws AltaClienteException, RemoteException
	{
		logger.debug("getEstadosCiviles():start");
		DatosGeneralesComDTO[] datosGeneralesComDTO = null;
		try
		{
			
			datosGeneralesComDTO = getAltaClienteFacade().getEstadosCiviles();
			
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getEstadosCiviles():end");
		return datosGeneralesComDTO;
	}

	public ProfesionDTO[] getProfesiones() throws AltaClienteException, RemoteException
	{
		logger.debug("getProfesiones():start");
		ProfesionDTO[] profesiones = null;
		try
		{
			profesiones = getAltaClienteFacade().getProfesiones();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getProfesiones():end");
		return profesiones;
	}

	public CargoLaboralDTO[] getCargosLaborales() throws AltaClienteException, RemoteException
	{
		logger.debug("getCargosLaborales():start");
		CargoLaboralDTO[] cargos = null;
		try
		{
			cargos = getAltaClienteFacade().getCargosLaborales();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCargosLaborales():end");
		return cargos;
	}

	public OficinaComDTO[] getOficinas(OficinaComDTO oficinaComDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("getOficinas():start");
		OficinaComDTO[] oficinaComDTOs = null;
		try
		{
			logger.debug("getOficinas:antes");
			oficinaComDTOs = getAltaClienteFacade().getOficinas(oficinaComDTO);
			logger.debug("getOficinas:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getOficinas():end");
		return oficinaComDTOs;
	}

	public ClienteComDTO[] getCategoriasImpositivas() throws AltaClienteException, RemoteException
	{
		logger.debug("getCategoriasImpositivas():start");
		ClienteComDTO[] clienteComDTO = null;
		try
		{
			logger.debug("getCategoriasImpositivas:antes");
			clienteComDTO = getAltaClienteFacade().getCategoriasImpositivas();
			logger.debug("getCategoriasImpositivas:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCategoriasImpositivas():end");
		return clienteComDTO;
	}

	public DatosGeneralesComDTO[] getCategoriasTributarias() throws AltaClienteException, RemoteException
	{
		logger.debug("getCategoriasTributarias():start");
		DatosGeneralesComDTO[] datosGeneralesComDTO = null;
		try
		{
			logger.debug("getCategoriasTributarias:antes");
			datosGeneralesComDTO = getAltaClienteFacade().getCategoriasTributarias();
			logger.debug("getCategoriasTributarias:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCategoriasTributarias():end");
		return datosGeneralesComDTO;
	}

	public ModalidadCancelacionComDTO[] getModalidadesCancelacion() throws AltaClienteException, RemoteException
	{
		logger.debug("getModalidadesCancelacion():start");
		ModalidadCancelacionComDTO[] modalidadCancelacionComDTO = null;
		try
		{
			logger.debug("getModalidadesCancelacion:antes");
			modalidadCancelacionComDTO = getAltaClienteFacade().getModalidadesCancelacion();
			logger.debug("getModalidadesCancelacion:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getModalidadesCancelacion():end");
		return modalidadCancelacionComDTO;
	}

	public ConceptosRecaudacionComDTO[] getBancos() throws AltaClienteException, RemoteException
	{
		logger.debug("getBancos():start");
		ConceptosRecaudacionComDTO[] conceptosRecaudacionComDTO = null;
		try
		{
			logger.debug("getBancos:antes");
			conceptosRecaudacionComDTO = getAltaClienteFacade().getBancos();
			logger.debug("getBancos:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getBancos():end");
		return conceptosRecaudacionComDTO;
	}

	public ConceptosRecaudacionComDTO[] getTiposTarjetas() throws AltaClienteException, RemoteException
	{
		logger.debug("getTiposTarjetas():start");
		ConceptosRecaudacionComDTO[] conceptosRecaudacionComDTO = null;
		try
		{
			logger.debug("getTiposTarjetas:antes");
			conceptosRecaudacionComDTO = getAltaClienteFacade().getTiposTarjetas();
			logger.debug("getTiposTarjetas:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTiposTarjetas():end");
		return conceptosRecaudacionComDTO;
	}

	public TipoCuentaBancariaComDTO[] getTiposCuentasBancarias() throws AltaClienteException, RemoteException
	{
		logger.debug("getTiposCuentasBancarias():start");
		TipoCuentaBancariaComDTO[] tipoCuentaBancariaComDTO = null;
		try
		{
			logger.debug("getTiposCuentasBancarias:antes");
			tipoCuentaBancariaComDTO = getAltaClienteFacade().getTiposCuentasBancarias();
			logger.debug("getTiposCuentasBancarias:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTiposCuentasBancarias():end");
		return tipoCuentaBancariaComDTO;
	}

	public ConceptosRecaudacionComDTO[] getSucursalesBanco(ConceptosRecaudacionComDTO conceptosRecaudacionComDTO)
			throws AltaClienteException, RemoteException
	{
		logger.debug("getSucursalesBanco():start");
		ConceptosRecaudacionComDTO[] conceptosRecaudacionComDTOs = null;
		try
		{
			logger.debug("getSucursalesBanco:antes");
			conceptosRecaudacionComDTOs = getAltaClienteFacade().getSucursalesBanco(conceptosRecaudacionComDTO);
			logger.debug("getSucursalesBanco:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getSucursalesBanco():end");
		return conceptosRecaudacionComDTOs;
	}

	public ModalidadPagoComDTO[] getModalidadesPago(ModalidadCancelacionComDTO modalidadCancelacionComDTO)
			throws AltaClienteException, RemoteException
	{
		logger.debug("getModalidadesPago():start");
		ModalidadPagoComDTO[] modalidadPagoComDTOs = null;
		try
		{
			logger.debug("getModalidadesPago:antes");
			modalidadPagoComDTOs = getAltaClienteFacade().getModalidadesPago(modalidadCancelacionComDTO);
			logger.debug("getModalidadesPago:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getModalidadesPago():end");
		return modalidadPagoComDTOs;
	}

	public NumeroIdentificacionDTO validarIdentificador(NumeroIdentificacionDTO entrada) throws AltaClienteException,
			RemoteException
	{
		logger.debug("validarIdentificador():start");
		NumeroIdentificacionDTO numeroIdentificacionDTO = null;
		try
		{
			logger.debug("validarIdentificador:antes");
			numeroIdentificacionDTO = getAltaClienteFacade().validarIdentificador(entrada);
			logger.debug("validarIdentificador:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("validarIdentificador():end");
		return numeroIdentificacionDTO;

	}

	public TarjetaDTO validarTarjeta(TarjetaDTO entrada) throws AltaClienteException, RemoteException
	{
		logger.debug("validarTarjeta():start");
		TarjetaDTO resultado;
		try
		{
			logger.debug("Inicio:validarTarjeta()");
			resultado = getAltaClienteFacade().validarTarjeta(entrada);
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

	public ClienteAltaDTO crearCliente(ClienteAltaDTO entrada) throws AltaClienteException, RemoteException
	{
		logger.debug("crearCliente():start");
		ClienteAltaDTO resultado = new ClienteAltaDTO();
		try
		{
			logger.debug("crearCliente:antes");
			resultado = getAltaClienteFacade().crearCliente(entrada);
			logger.debug("crearCliente:despues");
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("validarIdentificador():end");
		return resultado;
	}

	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws AltaClienteException,
			RemoteException
	{
		logger.debug("getParametroGeneral():start");
		ParametrosGeneralesDTO retorno = null;
		try
		{
			retorno = getAltaClienteFacade().getParametroGeneral(entrada);
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getParametroGeneral():end");
		return retorno;
	}

	public void insReferenciaCliente(ReferenciaClienteDTO entrada) throws AltaClienteException, RemoteException
	{
		logger.debug("insReferenciaCliente():start");
		try
		{
			getAltaClienteFacade().insReferenciaCliente(entrada);
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("insReferenciaCliente():end");
	}

	public CuentaDTO[] getCuentas(BusquedaCuentaDTO cuentaDTO) throws AltaClienteException, RemoteException
	{
		logger.debug("Inicio");
		CuentaDTO[] r = null;
		try
		{
			r = getAltaClienteFacade().getCuentas(cuentaDTO);
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin");
		return r;
	}

	public boolean validarTelefonoReferencia(String telefono, String tipo) throws AltaClienteException, RemoteException
	{
		logger.debug("Inicio");
		boolean r = false;
		try
		{
			r = getAltaClienteFacade().validarTelefonoReferencia(telefono, tipo);
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException: " + log);
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException: " + log);
			throw new AltaClienteException(e);
		}
		logger.debug("Fin");
		return r;
	}
	
	public ClasificacionDTO[] getClasificaciones() throws AltaClienteException, RemoteException
	{
		logger.debug("Inicio");
		ClasificacionDTO[] resultado = null;
		try
		{
			resultado = getAltaClienteFacade().getClasificaciones();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin");
		return resultado;
	}	
	
	public ValorClasificacionDTO[] getCalificaciones() throws AltaClienteException, RemoteException
	{
		logger.debug("getCalificaciones():start");
		ValorClasificacionDTO[] segmentosDTO = null;
		try
		{
			segmentosDTO = getAltaClienteFacade().getCalificaciones();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCalificaciones():end");
		return segmentosDTO;
	}
	
	public ValorClasificacionDTO[] getCrediticia() throws AltaClienteException, RemoteException
	{
		logger.debug("getCrediticia():start");
		ValorClasificacionDTO[] segmentosDTO = null;
		try
		{
			segmentosDTO = getAltaClienteFacade().getCrediticia();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCrediticia():end");
		return segmentosDTO;
	}
	
	public ValorClasificacionDTO[] getColores() throws AltaClienteException, RemoteException
	{
		logger.debug("getColores():start");
		ValorClasificacionDTO[] segmentosDTO = null;
		try
		{
			segmentosDTO = getAltaClienteFacade().getColores();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getColores():end");
		return segmentosDTO;
	}
	
	public ValorClasificacionDTO[] getSegmentos(String tipoCliente) throws AltaClienteException, RemoteException
	{
		logger.debug("getSegmentos():start");
		ValorClasificacionDTO[] segmentosDTO = null;
		try
		{
			segmentosDTO = getAltaClienteFacade().getSegmentos(tipoCliente);
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getSegmentos():end");
		return segmentosDTO;
	}
	
	public ValorClasificacionDTO[] getCategorias() throws AltaClienteException, RemoteException
	{
		logger.debug("getCategorias():start");
		ValorClasificacionDTO[] segmentosDTO = null;
		try
		{
			segmentosDTO = getAltaClienteFacade().getCategorias();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCategorias():end");
		return segmentosDTO;
	}	
	
	public CategoriaCambioDTO[] getCategoriasCambio() throws AltaClienteException, RemoteException
	{
		logger.debug("getCategoriasCambio():start");
		CategoriaCambioDTO[] segmentosDTO = null;
		try
		{
			segmentosDTO = getAltaClienteFacade().getCategoriasCambio();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getCategoriasCambio():end");
		return segmentosDTO;
	}
	
	/**
	 * @param numIdent
	 * @param codTipIdent
	 * @return
	 * @throws VentasException
	 * @throws RemoteException
	 * @throws AltaClienteException 
	 */
	public Boolean validaClienteLN(String numIdent, String codTipIdent) throws AltaClienteException {
		Boolean r = Boolean.FALSE;
		logger.debug("Inicio");
		try {
			r = getAltaClienteFacade().validaClienteLN(numIdent, codTipIdent);
		}
		catch (AltaClienteException e) {
			logger.debug("AltaClienteException [" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (RemoteException e) {
			logger.debug("RemoteException [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin");
		return r;
	} // validaClienteLN
	
	//Inicio P-CSR-11002 JLGN 28/04/2011
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO entrada) throws AltaClienteException, RemoteException
	{
		logger.debug("getValorParametro():start");
		DatosGeneralesDTO salida;
		try
		{
			salida = getAltaClienteFacade().getValorParametro(entrada);
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getValorParametro():end");
		return salida;
	}
	
	public FormularioDireccionDTO getDireccionPrepago(String codDireccion) throws AltaClienteException, RemoteException
	{
		logger.debug("getDireccionPrepago():start");
		FormularioDireccionDTO salida;
		try
		{
			salida = getAltaClienteFacade().getDireccionPrepago(codDireccion);
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getDireccionPrepago():end");
		return salida;
	}	
	//Fin P-CSR-11002 JLGN 28/04/2011
	
	//Inicio P-CSR-11002 JLGN 29-04-2011
	public DatosClienteBuroDTO consultaBuro(String numIdent,String tipIdent,String tipoEstudio, String usuario) throws RemoteException,AltaClienteException, Exception{
		DatosClienteBuroDTO buroDTO = new DatosClienteBuroDTO();
		try{
			logger.debug("Inicio consultaBuro");
			buroDTO = getAltaClienteFacade().consultaBuro(numIdent, tipIdent, tipoEstudio, usuario);
			logger.debug("Fin consultaBuro");
		}catch(AltaClienteException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException ["+log+"]");
			throw e;
		}catch( Exception e ){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ExceptionDelegate[" + log + "]");
			throw e;
		}
		return buroDTO;
		
	}	
	//Fin P-CSR-11002 JLGN 29-04-2011
	
	//Inicio P-CSR-11002 JLGN 05-06-2011
	public boolean validaPassClasificacion(String passCalificacion) throws VentasException, RemoteException, AltaClienteException{
		logger.debug("validaPassClasificacion():start");
		boolean resultado = false;
		resultado = getAltaClienteFacade().validaPassClasificacion(passCalificacion);
		logger.debug("validaPassClasificacion():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 05-06-2011
	
	//Inicio P-CSR-11002 JLGN 01-07-2011
	public long obtineLimConsuCliente(String numIdent, String tipIdent) throws VentasException, RemoteException, AltaClienteException{
		logger.debug("obtineLimConsuCliente():start");
		long resultado = 0;
		resultado = getAltaClienteFacade().obtineLimConsuCliente(numIdent, tipIdent);
		logger.debug("obtineLimConsuCliente():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 01-07-2011
	
	//Inicio P-CSR-11002 JLGN 05-08-2011
	public MensajePromocionalDTO[] getMensajePromocional() throws AltaClienteException, RemoteException
	{
		logger.debug("getMensajePromocional():start");
		MensajePromocionalDTO[] mensajePromocional = null;
		try
		{
			mensajePromocional = getAltaClienteFacade().getMensajePromocional();
		}
		catch (AltaClienteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		}
		catch (RemoteException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getMensajePromocional():end");
		return mensajePromocional;
	}
	//Fin P-CSR-11002 JLGN 05-08-2011
	
	//Inicio Inc.179734 JLGN 04-01-2012
	public boolean validaClienteDDA(String codCliente) throws VentasException, CustomerDomainException, RemoteException, AltaClienteException{
		logger.debug("validaClienteDDA():start");
		boolean resultado = getAltaClienteFacade().validaClienteDDA(codCliente);
		logger.debug("validaClienteDDA():end");
		return resultado;		
	}
	//Fin Inc.179734 JLGN 04-01-2012
	
	//Inicio Inc.179734 JLGN 05-01-2012
	public boolean validaLineasClienteDDA(String tipIdent, String numIdent) throws VentasException, CustomerDomainException, RemoteException, AltaClienteException{
		logger.debug("validaLineasClienteDDA():start");
		boolean resultado = getAltaClienteFacade().validaLineasClienteDDA(tipIdent, numIdent);
		logger.debug("validaLineasClienteDDA():end");
		return resultado;		
	}
	//Fin Inc.179734 JLGN 05-01-2012
	
//	Inicio MA-180654 HOM
	public AbonadoDTO[] getAbonadosActvos(String tipIdent, String numIdent) throws VentasException, CustomerDomainException, RemoteException, AltaClienteException{
		logger.debug("getAbonadosActvos():start");
		AbonadoDTO[] resultado = getAltaClienteFacade().getAbonadosActvos(tipIdent, numIdent);
		logger.debug("getAbonadosActvos():end");
		return resultado;		
	}
//	Fin MA-180654 HOM

}
