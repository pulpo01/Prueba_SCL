package com.tmmas.scl.operations.crm.fab.cusintman.web.helper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.util.StrUtl;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.SuspensionVoluntariaBussinessDelegate;


public class SecurityHandler {
	
	private String codCliente;
	private String numAbonado;
	private String codOrdenServicio;
	private String usuario;
	private String clave;
	
	private final Logger logger = Logger.getLogger(SecurityHandler.class);
	private Global global = Global.getInstance();

	private SuspensionVoluntariaBussinessDelegate delegate = new SuspensionVoluntariaBussinessDelegate();
	
	public ClienteOSSesionDTO validarSeguridad(HttpServletRequest req,
			HttpServletResponse resp) throws Exception{
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("validarSeguridad( :antes");
		
		ClienteOSSesionDTO sessionData = null;
		

		usuario = StrUtl.isNull(req.getParameter("userName"));
		//usuario = String.valueOf(req.getAttribute("usuario"));
		logger.debug("usuario["+ usuario + "]");
		
		clave = StrUtl.isNull(req.getParameter("key"));
		//clave = String.valueOf(req.getAttribute("clave"));
		logger.debug("clave ["+ clave + "]");	
				 
		codCliente = StrUtl.isNullCero(req.getParameter("codigoCliente"));
		//codCliente = String.valueOf(req.getAttribute("codCliente"));
		logger.debug("codCliente[" + codCliente + "]");
			
		numAbonado = StrUtl.isNullCero(req.getParameter("numeroAbonado"));
		//numAbonado = String.valueOf(req.getAttribute("numAbonado"));
		logger.debug("numAbonado[" + numAbonado+ "]");
				
		codOrdenServicio = StrUtl.isNullCero(req.getParameter("codOrdenServicio"));
		//codOrdenServicio = String.valueOf(req.getAttribute("codOrdenServicio"));
		logger.debug("codOrdenServicio["+ codOrdenServicio +"]");
						
		validaParametros();
		
		sessionData = new ClienteOSSesionDTO();
		
		sessionData.setCodCliente(Long.parseLong(codCliente));
		sessionData.setNumAbonado(Long.parseLong(numAbonado));
		sessionData.setUsuario(usuario);
		String flujoOrdenServicio = global.getValor(codOrdenServicio);
		logger.debug("flujoOrdenServicio["+flujoOrdenServicio +"]");
		
		
		if (flujoOrdenServicio == null){
			String msg = "No se encuentra un mapping para la orden de servicio";
			throw new Exception(msg);
			 
		}
		
		sessionData.setCodOrdenServicio(Long.parseLong(codOrdenServicio));
		sessionData.setForward(flujoOrdenServicio);
		logger.debug("forward["+ flujoOrdenServicio +"]");

		AbonadoDTO entAbonado=null;
		
		// -----------------------------------------------------------------------------
		// Busco los datos del abonado y lo guardo en la coleccion de los datos de sesion
		AbonadoDTO abonadosArray[] =  new AbonadoDTO[1];
		AbonadoDTO abonadoParam = new AbonadoDTO();
		abonadoParam.setNumAbonado(Long.parseLong(numAbonado));
		abonadosArray[0] = delegate.obtenerDatosAbonado(abonadoParam);
		sessionData.setAbonados(abonadosArray);
		// -----------------------------------------------------------------------------
		
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
		logger.debug("validarSeguridad() :despues");
		return sessionData;
	}
	
	private void validaParametros() throws Exception {
		logger.debug("validaParametros : inicio");
		
		if (usuario.equalsIgnoreCase("")){
			logger.debug("Nombre de usuario vacio");
			throw new Exception("Parametros Invalidos de logueo");
		}
		
		if (codCliente.equalsIgnoreCase("0") && numAbonado.equalsIgnoreCase("0")){
			logger.debug("Codigo de cliente y Numero de abonado vacio");
			throw new Exception("Parametros Invalidos de logueo");
			
		}
		
		if (codOrdenServicio.equalsIgnoreCase("0")){
			logger.debug("Codigo de orden de servicio vacio");
			throw new Exception("Parametros Invalidos de logueo");
		}
		
		logger.debug("validaParametros : fin");
		
	}

}
