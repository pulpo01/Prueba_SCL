package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSerieBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.businessObject.dao.ParseoXML;

public class DevolucionDeEquipoAction extends Action {

	private final Logger logger = Logger.getLogger(DevolucionDeEquipoAction.class);
	private Global global = Global.getInstance();
	private CambioSerieBussinessDelegate delegate = CambioSerieBussinessDelegate.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		// TODO process request and return an ActionForward instance, for example:
		// return mapping.findForward("forward_name");

		// Configuro el path para el log4j
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		// ------------------------------------------------------------------------------------
		
		// Agrego una entrada al log
		logger.debug("execute():start");

		// Tomo los datos iniciales del cliente que estan en sesion
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    //---------------------------------------------------
	    session.setAttribute("nombreOOSS", "Devolución de Equipo");
	    session.setAttribute("operadora", global.getValor("NOM_OPERADORA"));
// 		------------------------------------------------------------------------------------
	    //
		String archivo = System.getProperty("user.dir")+global.getValor("ruta.xml")+global.getValor("xml.valoresdefecto");
		ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo y parseando XML configuración:antes");
		ValoresJSPPorDefectoDTO definicionPagina=parseo.cargaXML(archivo);
		logger.debug("leyendo y parseando XML configuracion:despues");
		sessionData.setDefaultPagina(definicionPagina);
//--------------------------------------------------------------------
	    
	    
	    UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();

	    Long numAbonadoLong = new Long (sessionData.getNumAbonado());
	    usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());

	    // Busco los datos para la cabecera de las paginas
	    usuarioAbonado = delegate.obtenerDatosUsuarioAbonado(usuarioAbonado);
	    session.setAttribute("usuarioAbonado", usuarioAbonado);
// 		------------------------------------------------------------------------------------
	    // Carga de combo
	    BodegaDTO[] bodegasLista = null;
	    SesionDTO sesionDTO = new SesionDTO();
	    sesionDTO.setCodCliente(sessionData.getCliente().getCodCliente());

	    // Almaceno el usuario del sistema
	    UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
	    usuarioSistema.setNom_usuario(sessionData.getUsuario());
	    sesionDTO.setUsuario(usuarioSistema);
	    
	    bodegasLista = delegate.obtenerBodegas(sesionDTO);
	    request.setAttribute("bodegasLista", bodegasLista);
	    request.setAttribute("titulo", "Devolución de Equipo");
//	    ------------------------------------------------------------------------------------
	    
	    return mapping.findForward("inicio");
	    
	}  // execute

}  // DevolucionDeEquipoAction
