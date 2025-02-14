package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;


import java.rmi.RemoteException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.DatosClienteDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.exception.ManProException;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;

public class SecurityHandler {
	
	private String codCliente;
	private String numAbonado;
	private String codOrdenServicio;
	private String usuario;
	private String clave;
	
	private final Logger logger = Logger.getLogger(SecurityHandler.class);
	private Global global = Global.getInstance();

	private ManageProspectBussinessDelegate delegate = ManageProspectBussinessDelegate.getInstance();
	
	public ClienteOSSesionDTO validarSeguridad(HttpServletRequest req,
			HttpServletResponse resp) throws ManProException, ManConException, RemoteException {
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("validarSeguridad( :antes");
		
		ClienteOSSesionDTO sessionData = null;
		try
		{
			//usuario = StrUtl.isNull(req.getParameter("userName"));
			usuario = String.valueOf(req.getAttribute("usuario"));
			logger.debug("usuario["+ usuario + "]");
			
			//clave = StrUtl.isNull(req.getParameter("key"));
			clave = String.valueOf(req.getAttribute("clave"));
			logger.debug("clave ["+ clave + "]");	
					 
			//codCliente = StrUtl.isNullCero(req.getParameter("codigoCliente"));
			codCliente = String.valueOf(req.getAttribute("codCliente"));
			logger.debug("codCliente[" + codCliente + "]");
				
			//numAbonado = StrUtl.isNullCero(req.getParameter("numeroAbonado"));
			numAbonado = String.valueOf(req.getAttribute("numAbonado"));
			logger.debug("numAbonado[" + numAbonado+ "]");
					
			//codOrdenServicio = StrUtl.isNullCero(req.getParameter("codOrdenServicio"));
			codOrdenServicio = String.valueOf(req.getAttribute("codOrdenServicio"));
			logger.debug("codOrdenServicio["+ codOrdenServicio +"]");
			log2("usuario "+usuario);
			log2("clave "+clave);
			log2("codCliente "+codCliente);
			log2("numAbonado "+numAbonado);
			log2("codOrdenServicio "+codOrdenServicio);

				
			validaParametros();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		
		sessionData = new ClienteOSSesionDTO();
		
		sessionData.setCodCliente(Long.parseLong(codCliente));
		sessionData.setNumAbonado(Long.parseLong(numAbonado));
		sessionData.setUsuario(usuario);
		String flujoOrdenServicio = global.getValor(codOrdenServicio);
		logger.debug("flujoOrdenServicio["+flujoOrdenServicio +"]");
		
		
		if (flujoOrdenServicio == null){
			log2("flujoOrdenServicio == null");
			String msg = "No se encuentra un mapping para la orden de servicio";
			throw new ManProException(msg);
			 
		}
		
		sessionData.setCodOrdenServicio(Long.parseLong(codOrdenServicio));
		sessionData.setForward(flujoOrdenServicio);
		logger.debug("forward["+ flujoOrdenServicio +"]");
		
		AbonadoDTO entAbonado=null;
		
		if (sessionData.getCodCliente() != 0){
			logger.debug("busqueda por cliente");
			ClienteDTO entCliente = new ClienteDTO();
			entCliente.setCodCliente(Long.parseLong(codCliente));
			logger.debug("obtenerDatosCliente:antes");
		    ClienteDTO respuesta = delegate.obtenerDatosCliente(entCliente);
		    logger.debug("obtenerDatosCliente:despues");
		    sessionData.setCliente(respuesta);
		}
		else{
			logger.debug("busqueda por abonado");
			entAbonado = new AbonadoDTO();
			entAbonado.setNumAbonado(Long.parseLong(numAbonado));
			logger.debug("obtenerDatosAbonado:antes");
			logger.debug("entAbonado.getNumAbonado() :"+entAbonado.getNumAbonado());
			AbonadoDTO abonado = delegate.obtenerDatosAbonado(entAbonado);
			logger.debug("obtenerDatosAbonado:despues");
			
			ClienteDTO entCliente = new ClienteDTO();
			entCliente.setCodCliente(abonado.getCodCliente());
			logger.debug("entCliente.getCodCliente: "+entCliente.getCodCliente());
			logger.debug("obtenerDatosCliente:antes");
			ClienteDTO respuesta = delegate.obtenerDatosCliente(entCliente);
			logger.debug("obtenerDatosCliente:despues");
			sessionData.setCliente(respuesta);
			
		}
		
		//otra informacion del cliente
		/*DatosClienteDTO datosCliente  = delegate.obtenerDatosAdicCliente(new Long(sessionData.getCliente().getCodCliente()));
		sessionData.setClColor(datosCliente.getDescripcionColor());
		sessionData.setClSegmento(datosCliente.getDescripcionSegmento());*/
		
		logger.debug("validarSeguridad() :despues");
		return sessionData;
	}
	
	private void validaParametros() throws ManProException {
		logger.debug("validaParametros : inicio");
		
		if (usuario.equalsIgnoreCase("")){
			logger.debug("Nombre de usuario vacio");
			throw new ManProException("Parametros Invalidos de logueo");
		}
		
		if (codCliente.equalsIgnoreCase("0") && numAbonado.equalsIgnoreCase("0")){
			logger.debug("Codigo de cliente y Numero de abonado vacio");
			throw new ManProException("Parametros Invalidos de logueo");
			
		}
		
		if (codOrdenServicio.equalsIgnoreCase("0")){
			logger.debug("Codigo de orden de servicio vacio");
			throw new ManProException("Parametros Invalidos de logueo");
		}
		
		logger.debug("validaParametros : fin");
		
	}
	
	public void log2(Object o)
	{

	}

}
