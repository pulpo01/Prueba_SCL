package com.tmmas.scl.operations.crm.fab.cusintman.web.helper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.util.StrUtl;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AnulacionSiniestroBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;


public class SecurityHandler {
	
	private String codCliente;
	private String numAbonado;
	private String codOrdenServicio;
	private String usuario;
	private String clave;
	
	private final Logger logger = Logger.getLogger(SecurityHandler.class);
	private Global global = Global.getInstance();

	private AnulacionSiniestroBussinessDelegate delegate = new AnulacionSiniestroBussinessDelegate();
	private FrmkOOSSBussinessDelegate delegate2 = new FrmkOOSSBussinessDelegate();
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
		//Inlcuido Santiago Ventura 15/04/2010
		abonadoParam.setNumAbonado(Long.parseLong(numAbonado));
		abonadoParam = delegate.obtenerDatosAbonado(abonadoParam);
		abonadoParam.setCodCliente(abonadoParam.getCodCliente());
		abonadosArray[0] = delegate2.obtenerDatosAbonado2(abonadoParam);
		
		abonadosArray[0].setNumCelular(abonadoParam.getNumCelular());
		abonadosArray[0].setNumSerie(abonadoParam.getNumSerie());
		abonadosArray[0].setSimCard(abonadoParam.getSimCard());
		abonadosArray[0].setCodTecnologia(abonadoParam.getCodTecnologia());
		abonadosArray[0].setCodSituacion(abonadoParam.getCodSituacion());
		abonadosArray[0].setDesSituacion(abonadoParam.getDesSituacion());
		abonadosArray[0].setCodPlanServ(abonadoParam.getCodPlanServ());
		abonadosArray[0].setCodTipContrato(abonadoParam.getCodTipContrato());
		abonadosArray[0].setFecAlta(abonadoParam.getFecAlta());
		abonadosArray[0].setFecFinContrato(abonadoParam.getFecFinContrato());
		abonadosArray[0].setIndEqPrestado(abonadoParam.getIndEqPrestado());
		abonadosArray[0].setFecProrroga(abonadoParam.getFecProrroga());
		abonadosArray[0].setFlgRango(abonadoParam.getFlgRango());
		abonadosArray[0].setImpCargoBasico(abonadoParam.getImpCargoBasico());
		abonadosArray[0].setCodCentral(abonadoParam.getCodCentral());
		abonadosArray[0].setCodUso(abonadoParam.getCodUso());
		abonadosArray[0].setCodVendedor(abonadoParam.getCodVendedor());		
		abonadosArray[0].setCodCiclo(abonadoParam.getCodCiclo());
		sessionData.setAbonados(abonadosArray);
		// -----------------------------------------------------------------------------
		
		if (sessionData.getCodCliente() != 0){
			logger.debug("busqueda por cliente");
			ClienteDTO entCliente = new ClienteDTO();
			entCliente.setCodCliente(Long.parseLong(codCliente));
			logger.debug("obtenerDatosCliente:antes");
		    ClienteDTO respuesta = delegate2.obtenerDatosCliente(entCliente);
		    logger.debug("obtenerDatosCliente:despues");
		    sessionData.setCliente(respuesta);
		}
		else{
			logger.debug("busqueda por abonado");
			entAbonado = new AbonadoDTO();

			entAbonado.setNumAbonado(Long.parseLong(numAbonado));
			logger.debug("obtenerDatosAbonado2:antes");
			logger.debug("entAbonado.getNumAbonado() :"+entAbonado.getNumAbonado());

			abonadoParam = delegate.obtenerDatosAbonado(entAbonado);
			entAbonado.setCodCliente(abonadoParam.getCodCliente());
			sessionData.setCodCliente(entAbonado.getCodCliente()); 
			AbonadoDTO abonado = delegate2.obtenerDatosAbonado2(entAbonado);			
			abonado.setNumCelular(abonadoParam.getNumCelular());
			abonado.setNumSerie(abonadoParam.getNumSerie());
			abonado.setSimCard(abonadoParam.getSimCard());
			abonado.setCodTecnologia(abonadoParam.getCodTecnologia());
			abonado.setCodSituacion(abonadoParam.getCodSituacion());
			abonado.setDesSituacion(abonadoParam.getDesSituacion());
			abonado.setCodPlanServ(abonadoParam.getCodPlanServ());
			abonado.setCodTipContrato(abonadoParam.getCodTipContrato());
			abonado.setFecAlta(abonadoParam.getFecAlta());
			abonado.setFecFinContrato(abonadoParam.getFecFinContrato());
			abonado.setIndEqPrestado(abonadoParam.getIndEqPrestado());
			abonado.setFecProrroga(abonadoParam.getFecProrroga());
			abonado.setFlgRango(abonadoParam.getFlgRango());
			abonado.setImpCargoBasico(abonadoParam.getImpCargoBasico());
			abonado.setCodCentral(abonadoParam.getCodCentral());
			abonado.setCodUso(abonadoParam.getCodUso());
			abonado.setCodVendedor(abonadoParam.getCodVendedor());
			abonado.setCodCiclo(abonadoParam.getCodCiclo());
			logger.debug("obtenerDatosAbonado2:despues");
			
			ClienteDTO entCliente = new ClienteDTO();
			// entCliente.setCodCliente(abonado.getCodCliente());
			entCliente.setCodCliente(entAbonado.getCodCliente());
			logger.debug("entCliente.getCodCliente: "+entCliente.getCodCliente());
			logger.debug("obtenerDatosCliente:antes");
			ClienteDTO respuesta = delegate2.obtenerDatosCliente(entCliente);
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
