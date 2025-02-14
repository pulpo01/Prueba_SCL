package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.util.StrUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.DatosClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OperadoraLocalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class SecurityHandler {
	
	private String codCliente;
	private String numAbonado;
	private String codOrdenServicio;
	private String usuario;
	private String clave;
	
	private final Logger logger = Logger.getLogger(SecurityHandler.class);
	private Global global = Global.getInstance();

	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ClienteOSSesionDTO validarSeguridad(HttpServletRequest req,
			HttpServletResponse resp) throws ManReqException {
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
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
		
		/**
		 * @author rlozano
		 * @description se procede a capturar el nombre de la orden de servicio para ser seteada
		 * en la cabecera de los jsp
		 */
		String NombreOss=global.getValor(codOrdenServicio+".name");
		
		validaParametros();
		
		sessionData = new ClienteOSSesionDTO();
		
		sessionData.setCodCliente(Long.parseLong(codCliente));
		sessionData.setNumAbonado(Long.parseLong(numAbonado));
		sessionData.setUsuario(usuario);
		sessionData.setNombOss(NombreOss);
		
		String flujoOrdenServicio = global.getValor(codOrdenServicio);
		logger.debug("flujoOrdenServicio["+flujoOrdenServicio +"]");
		
		
		if (flujoOrdenServicio == null){
			String msg = "No se encuentra un mapping para la orden de servicio";
			throw new ManReqException(msg);
			 
		}
		
		sessionData.setCodOrdenServicio(Long.parseLong(codOrdenServicio));
		
		/*------------------------------------------------------------------*/
	    String nombreOperadora = "";
	    OperadoraLocalDTO operadora = delegate.obtenerOperadoraLocal();
	    if("TMG".equals(operadora.getOperadora()))
	     {
	    	 nombreOperadora = global.getValor("NOM_OPERADORA_TMG");
	    }else
	    {
	    	nombreOperadora = global.getValor("NOM_OPERADORA_TMS");
	    }
	    req.getSession().setAttribute("operadora", nombreOperadora);	
	    //session.setAttribute("operadora", nombreOperadora);
	    /*------------------------------------------------------------------*/
		
		sessionData.setForward(flujoOrdenServicio);
		logger.debug("forward["+ flujoOrdenServicio +"]");
		
		AbonadoDTO entAbonado=null;
		
		try {
			if (sessionData.getCodCliente() != 0){
				logger.debug("busqueda por cliente");
				ClienteDTO entCliente = new ClienteDTO();
				entCliente.setCodCliente(Long.parseLong(codCliente));
				logger.debug("obtenerDatosCliente:antes");
			    ClienteDTO respuesta = delegate.obtenerDatosCliente(entCliente);//ahora trae 12 parámetros menos 270410 pv
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
					ClienteDTO respuesta = delegate.obtenerDatosCliente(entCliente);//ahora trae 12 parámetros menos 270410 pv
					logger.debug("obtenerDatosCliente:despues");
					
					respuesta.setCodTipoTerminal(abonado.getCodTipoTerminal());
					respuesta.setDesTipoTerminal(abonado.getDesTipoTerminal());
					respuesta.setCodPlanTarif(abonado.getCodPlanTarif());
					respuesta.setDesPlanTarif(abonado.getDesPlanTarif());
					respuesta.setLimiteConsumo(abonado.getLimiteConsumo());
					respuesta.setDesLimiteConsumo(abonado.getDesLimiteConsumo());
					respuesta.setCodCiclo(abonado.getCodCiclo());
					respuesta.setImpCargoBasico(Float.parseFloat(abonado.getImpCargoBasico()));		
					sessionData.setCliente(respuesta);
			}
			
			//otra informacion del cliente
			DatosClienteDTO datosCliente  = delegate.obtenerDatosAdicCliente(new Long(sessionData.getCliente().getCodCliente()));
			sessionData.setClColor(datosCliente.getDescripcionColor());
			sessionData.setClSegmento(datosCliente.getDescripcionSegmento());
			
			
		}catch(ManReqException e){
			throw e;
		} catch (Exception e) {
			throw new ManReqException(e);
		}				
		/**
		 * @author rlozano
		 * @Descripcion validar, existencia de Vendedor asociado a Usuario URL.
		*/
		UsuarioDTO usuario = new UsuarioDTO();
		usuario.setNombre(sessionData.getUsuario());
		logger.debug("obtenerVendedor():antes");
		UsuarioDTO usuarioVend = delegate.obtenerVendedor(usuario);
		logger.debug("obtenerVendedor():despues");
		try{
			sessionData.setExistVendUsuario(usuarioVend.getCodigo()==0?false:true);
			sessionData.setCodVendedor(""+usuarioVend.getCodigo());
		}
		catch(NumberFormatException e){
			sessionData.setExistVendUsuario(false);
		}
		
		logger.debug("validarSeguridad() :despues");
		return sessionData;
	}
	
	private void validaParametros() throws ManReqException {
		logger.debug("validaParametros : inicio");
		
		if (usuario.equalsIgnoreCase("")){
			logger.debug("Nombre de usuario vacio");
			throw new ManReqException("Parametros Invalidos de logueo");
		}
		
		if (codCliente.equalsIgnoreCase("0") && numAbonado.equalsIgnoreCase("0")){
			logger.debug("Codigo de cliente y Numero de abonado vacio");
			throw new ManReqException("Parametros Invalidos de logueo");
			
		}
		
		if (codOrdenServicio.equalsIgnoreCase("0")){
			logger.debug("Codigo de orden de servicio vacio");
			throw new ManReqException("Parametros Invalidos de logueo");
		}
		
		logger.debug("validaParametros : fin");
		
	}

}
