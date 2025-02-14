/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/09/2008         Hernán Segura Muñoz                  Versión Inicial 
 * 
 *
 * 
 * RateUsageRecordsWSBean
 * @author Hernán Segura Muñoz 
 * @version 1.0
 **/
package com.tmmas.scl.RateUsageRecordsWS.soa.ejb.session;

import java.rmi.RemoteException;
import java.util.Collection;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.helper.CrearGeneralSoapException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.RateUsageRecordsEJB.ejb.session.RateUsageRecords;
import com.tmmas.scl.RateUsageRecordsEJB.ejb.session.RateUsageRecordsHome;
import com.tmmas.scl.RateUsageRecordsWS.soa.ejb.session.helper.ValidacionesBasicasHelper;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.FacturaMiscelaneaEntradaDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.FacturaMiscelaneaSalidaDTO;
import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!--
 * begin-xdoclet-definition -->
 * 
 * @ejb.bean name="RateUsageRecordsWS" description="An EJB named
 *           RateUsageRecordsWS" display-name="RateUsageRecordsWS"
 *           jndi-name="RateUsageRecordsWS" type="Stateless"
 *           transaction-type="Container" view-type="remote"
 * 
 * <!-- end-xdoclet-definition -->
 * @generated
 */

public class RateUsageRecordsWSBean implements javax.ejb.SessionBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static Logger logger = Logger
			.getLogger(RateUsageRecordsWSBean.class);

	private CompositeConfiguration config;

	public RateUsageRecordsWSBean() {
		super();
		config = UtilProperty
				.getConfiguration("ServicioFacturacionWS.properties",
						"com/tmmas/scl/framework/properties/archivorecursos.properties");
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.create-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() {
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

	public FacturaMiscelaneaSalidaDTO generarFacturaMiscelanea(
			FacturaMiscelaneaEntradaDTO facturaMiscelaneaEntradaDTO)
			throws RateUsageRecordsException, RemoteException {
		UtilLog.setLog(config.getString("RateUsageRecordsWS.log"));

		FacturaMiscelaneaSalidaDTO facturaMiscelaneaSalidaDTO = null;

		String urlMsg = "";

		try {

			logger.debug("generarFacturaMiscelanea(...).start");

			// debe chequear que el DTO de entrada cumpla con las exigencias
			// minimas
			ValidacionesBasicasHelper validacionesBasicasHelper = new ValidacionesBasicasHelper();

			facturaMiscelaneaSalidaDTO = validacionesBasicasHelper
					.getFacturaMiscelaneaEntradaDTOValido(facturaMiscelaneaEntradaDTO);

			// si las validaciones son satisfactorias, osea el DTO de salida no
			// trae
			// errores (cod=0)
			if (facturaMiscelaneaSalidaDTO.getSnError() == null) {
				// cambia la modalidad de cobro, segun programa antiguo
				facturaMiscelaneaEntradaDTO = convierteValoresModalidad(facturaMiscelaneaEntradaDTO);
				if (facturaMiscelaneaEntradaDTO != null) {
					facturaMiscelaneaSalidaDTO = this
							.getRateUsageRecordsFacade()
							.generarFacturaMiscelanea(
									facturaMiscelaneaEntradaDTO);
				} else {
					return putErrors(config
							.getString("cod_error_modalidadCobro"), config
							.getString("msg_error_modalidadCobro"));
				}

			}

		} catch (RateUsageRecordsException e) {
			facturaMiscelaneaSalidaDTO = new FacturaMiscelaneaSalidaDTO();
			facturaMiscelaneaSalidaDTO.setSnError(e.getCodigo());
			facturaMiscelaneaSalidaDTO.setSnEvento(String.valueOf(e
					.getCodigoEvento()));
			facturaMiscelaneaSalidaDTO.setSvMensaje(e.getDescripcionEvento());
			/*
			 * logger.debug(" generarFacturaMiscelanea():end "); return
			 * facturaMiscelaneaSalidaDTO;
			 */
		}

		// debe convertir los caracteres extraños
		convertirCaracterParser(facturaMiscelaneaSalidaDTO);
		logger.debug("generarFacturaMiscelanea(...).end");
		return facturaMiscelaneaSalidaDTO;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		// TODO Auto-generated method stub

	}

	/**
	 * 
	 * @return
	 * @throws RateUsageRecordsException
	 */
	private RateUsageRecords getRateUsageRecordsFacade()
			throws RateUsageRecordsException {

		logger.debug("getRateUsageRecordsFacade():start");

		String jndi = config.getString("jndi.RateUsageRecordsEJB");
		logger.debug("Buscando servicio[" + jndi + "]");
		// esta variable se obtiene del archivo de propiedades externo que esta
		// en el servidor.
		String url = config.getString("url.provider");
		logger.debug("url.provider[" + url + "]");

		String initialContextFactory = config
				.getString("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);
		env.put(Context.PROVIDER_URL, url);

		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}

		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}

		RateUsageRecordsHome facadeHome = (RateUsageRecordsHome) PortableRemoteObject
				.narrow(obj, RateUsageRecordsHome.class);

		logger.debug("Recuperada interfaz home de RateUsageRecordsEJB...");
		RateUsageRecords facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new RateUsageRecordsException(e);

		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new RateUsageRecordsException(e);
		}

		logger.debug("getRateUsageRecordsFacade():end");
		return facade;
	}

	/**
	 * Cambia el valor de modalidad de cobro, para un manejo interno If
	 * OPTMan(iOPTCON).Value Then
	 * 
	 * atFldPref(iFLDINDMOD).stxt = "1" ' contado
	 * 
	 * End If
	 * 
	 * 
	 * 
	 * If OPTMan(iOPTSIN).Value Then
	 * 
	 * atFldPref(iFLDINDMOD).stxt = "5" ' regalo
	 * 
	 * End If
	 * 
	 * 
	 * 
	 * If OPTMan(iOPTCUO).Value Then
	 * 
	 * atFldPref(iFLDINDMOD).stxt = "7" ' CUOTA
	 * 
	 * End If
	 * 
	 * 
	 * 
	 * If OPTMan(iOPTCUOCON).Value Then
	 * 
	 * atFldPref(iFLDINDMOD).stxt = "8" ' CUOTA CONSIGNACION
	 * 
	 * End If
	 * 
	 */
	private FacturaMiscelaneaEntradaDTO convierteValoresModalidad(
			FacturaMiscelaneaEntradaDTO fDTO) {
		FacturaMiscelaneaEntradaDTO salidaDTO = new FacturaMiscelaneaEntradaDTO();
		salidaDTO.setCabeceraDocumento(fDTO.getCabeceraDocumento());
		salidaDTO.setDetalleDocumento(fDTO.getDetalleDocumento());
		salidaDTO.setMoneda(fDTO.getMoneda());
		salidaDTO.setNumeroCuotas(fDTO.getNumeroCuotas());
		salidaDTO.setTipoDocumento(fDTO.getTipoDocumento());
		salidaDTO.setTipoGlosa(fDTO.getTipoGlosa());
		salidaDTO.setUsuarioSistema(fDTO.getUsuarioSistema());

		String modalidadCobro = fDTO.getModalidadCobro();
		if (modalidadCobro != null
				&& modalidadCobro.trim().equalsIgnoreCase("1")) {
			salidaDTO.setModalidadCobro(config
					.getString("modalidadCobrocontado"));
		} else if (modalidadCobro != null
				&& modalidadCobro.trim().equalsIgnoreCase("2")) {
			salidaDTO.setModalidadCobro(config
					.getString("modalidadCobroregalo"));
		} else if (modalidadCobro != null
				&& modalidadCobro.trim().equalsIgnoreCase("3")) {
			salidaDTO
					.setModalidadCobro(config.getString("modalidadCobrocuota"));

		} else if (modalidadCobro != null
				&& modalidadCobro.trim().equalsIgnoreCase("4")) {
			salidaDTO.setModalidadCobro(config
					.getString("modalidadCobrocuotaconsig"));

		} else
			salidaDTO = null;
		return salidaDTO;
	}

	/**
	 * setea el codigo de error y el mensaje de error a un DTO de salida
	 * 
	 * @param codError
	 * @param msnError
	 * @return
	 */
	private FacturaMiscelaneaSalidaDTO putErrors(String codError,
			String msnError) {
		FacturaMiscelaneaSalidaDTO facturaMiscelaneaSalidaDTO = new FacturaMiscelaneaSalidaDTO();
		facturaMiscelaneaSalidaDTO.setSnError(codError);
		facturaMiscelaneaSalidaDTO.setSvMensaje(msnError);
		return facturaMiscelaneaSalidaDTO;
	}

	private void convertirCaracterParser(
			FacturaMiscelaneaSalidaDTO facturaMiscelaneaSalidaDTO) {
		logger.debug("convertirCaracterParser: start");
		String cadenaMsg = facturaMiscelaneaSalidaDTO.getSvMensaje();
		if (cadenaMsg != null) {
			Map hashTable = llenarEstructura();

			/*
			 * String[] arCaracterOld = config.getString("caracterold").split(
			 * config.getString("separadorCaracter"));
			 */

			if (hashTable != null) {
				Collection colKey = hashTable.keySet();

				// int i = 0;
				// Iterator it =colKey.iterator();
				for (Iterator iter = colKey.iterator(); iter.hasNext();) {
					// if (i < arCaracterOld.length) {
					String element = (String) iter.next();
					/*
					 * cadenaMsg = cadenaMsg.replaceAll(arCaracterOld[i],
					 * (String) hashTable.get(arCaracterOld[i]));
					 */
					cadenaMsg = cadenaMsg.replaceAll(element,
							(String) hashTable.get(element));
					// i++;
					// }
				}

			}
		}
		logger.debug("convertirCaracterParser: end");
		facturaMiscelaneaSalidaDTO.setSvMensaje(cadenaMsg);

	}

	private Map llenarEstructura() {
		logger.debug("llenarEstructura: start");
		Map hashTable = new Hashtable();

		/*
		 * caracterold=á/é/í/ó/ú/ñ
		 * 
		 * caracternew=a/e/i/o/u/n
		 * 
		 * separadorCaracter=/
		 */

		String[] arCaracterOld = config.getString("caracterold").split(
				config.getString("separadorCaracter"));
		String[] arCaracterNew = config.getString("caracternew").split(
				config.getString("separadorCaracter"));
		if (arCaracterOld.length == arCaracterNew.length) {
			for (int i = 0; i < arCaracterOld.length; i++) {
				hashTable.put(arCaracterOld[i], arCaracterNew[i]);
			}
		} else {
			logger
					.debug("Error en los campos caracterold, caracternew  y separadorCaracter del archivoRecursos.properties");
			// throw new RateUsageRecordsException("Error en los campos
			// caracterold y caracternew del archivoRecursos.properties");
			hashTable = null;
		}
		logger.debug("llenarEstructura: end");
		return hashTable;
	}
}
