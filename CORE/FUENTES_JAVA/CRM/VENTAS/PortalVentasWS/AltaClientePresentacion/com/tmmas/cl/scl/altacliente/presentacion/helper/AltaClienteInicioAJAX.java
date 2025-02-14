package com.tmmas.cl.scl.altacliente.presentacion.helper;

import java.rmi.RemoteException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoValidacionAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.form.AltaClienteInicioForm;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.RegistroFacturacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.SegmentoDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;

public class AltaClienteInicioAJAX {
	private final Logger logger = Logger.getLogger(AltaClienteInicioAJAX.class);
	private Global global = Global.getInstance();
	
	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();	

	/*
	 * Carga la lista de segmentos dependiendo del tipo de cliente seleccionado
	 */
	public RetornoListaAjaxDTO obtenerSegmentos(String tipoCliente){
		logger.debug("obtenerSegmentos:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);			
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		ValorClasificacionDTO[] listaSegmentos = null;
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm)sesion.getAttribute("AltaClienteInicioForm");
		ClasificacionDTO[] arrayClasificacion = altaClienteActionForm.getArrayClasificacion();
		ValorClasificacionDTO[] arrayValorDefecto = new ValorClasificacionDTO[1];
		try{
			listaSegmentos = delegate.getSegmentos(tipoCliente);
			
			if(altaClienteActionForm.getFlagCtrlClasifSegmentoActivo()=="0"){//solo permite seleccionar valor por defecto
				//busca valor por defecto
				for(int j=0; j<listaSegmentos.length;j++){
					if (listaSegmentos[j].getIndDefecto()==1){
						arrayValorDefecto[0] =  listaSegmentos[j];
						break;
					}
				}
				
				listaSegmentos = arrayValorDefecto;
			}
			
		}catch(Exception e){
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener segmentos");
		}
		retorno.setLista(listaSegmentos);
		logger.debug("obtenerSegmentos:fin()");
		return retorno;	
	}
	
	/*
	 * Obtiene lista de clasificacion crediticia
	 */
	public RetornoListaAjaxDTO obtenerCrediticia(){
		logger.debug("obtenerCrediticia:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);			
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm)sesion.getAttribute("AltaClienteInicioForm");
		ValorClasificacionDTO[] arrayCrediticia = altaClienteActionForm.getArrayCrediticia();
		retorno.setLista(arrayCrediticia);
		logger.debug("obtenerCrediticia:fin()");
		return retorno;	
	}
	
	
	public RetornoListaAjaxDTO obtenerCiclosFacturacion(String tipoCliente){
		logger.debug("obtenerCiclosFacturacion:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);				
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		RegistroFacturacionComDTO[] listaCiclos = null;
		try{
			String tipoClientePrepago = global.getValor("tipo.cliente.prepago");
			
			if (tipoCliente.equals(tipoClientePrepago)){
				listaCiclos = delegate.getCiclosFacturacionPrepago();
			}else{
				listaCiclos = delegate.getCiclosFacturacion();
			}
		}catch(Exception e){
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener ciclos de facturacion");
		}
		retorno.setLista(listaCiclos);
		logger.debug("obtenerCiclosFacturacion:fin()");
		return retorno;	
	}
	
	public RetornoListaAjaxDTO obtenerIdentificadoresFiltro(String codTipoIdentificadorSel){
		logger.debug("obtenerIdentificadoresFiltro:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);				
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
	
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm)sesion.getAttribute("AltaClienteInicioForm");
		IdentificadorCivilComDTO[] arrayIdentificadores = altaClienteActionForm.getArrayIdentificadorCliente();

		ArrayList arrayAuxIdenticadores2 = new ArrayList();
		
		for (int i=0;i<arrayIdentificadores.length;i++){
			IdentificadorCivilComDTO identAux= (IdentificadorCivilComDTO)arrayIdentificadores[i];
			if (!identAux.getCodigoTipIdentif().equals(codTipoIdentificadorSel)){
				arrayAuxIdenticadores2.add(identAux);
			}
		}
		
		IdentificadorCivilComDTO[] arrayIdenticadores2=(IdentificadorCivilComDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrayAuxIdenticadores2.toArray(), IdentificadorCivilComDTO.class);
		retorno.setLista(arrayIdenticadores2);
		
		logger.debug("obtenerIdentificadoresFiltro:fin()");
		return retorno;	
	}
	
	public RetornoValidacionAjaxDTO validarIdentificador(String tipoIdentif, String numIdentif) {
		logger.info("validarIdentificador:inicio()");
		logger.debug("tipoIdentif: " + tipoIdentif);
		logger.debug("numIdentif: " + numIdentif);
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValidacionAjaxDTO r = new RetornoValidacionAjaxDTO();

		if (!validarSesion(sesion)) {
			r.setCodError("-100");
			r.setMsgError("Su sesión ha expirado");
			return r;
		}

		NumeroIdentificacionDTO param = new NumeroIdentificacionDTO();
		r.setValido(true);

		try {
			param.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			param.setCorrelativo(Long.valueOf(global.getValor("param.identificador.correlativo")));
			param.setTipoIdentif(tipoIdentif);
			param.setNumIdentif(numIdentif);
			param = delegate.validarIdentificador(param);
			r.setIdentificadorFormateado(param.getFormatoNIT());
		}
		catch (Exception e) {
			r.setValido(false);
			r.setMsgError("Número de Identificaci\u00F3n no V\u00E1lido: " + numIdentif);
		}
		logger.debug("Valida listas negras...");
		try {
			delegate.validaClienteLN(numIdentif.trim(), tipoIdentif.trim());
		}
		catch (AltaClienteException e) {
			logger.error("AltaClienteException [" + StackTraceUtl.getStackTrace(e) + "]");
			r.setValido(false);
			if (e.getCodigo().trim().equals("4")) {
				r.setCodError(e.getCodigo());
				r.setMsgError(global.getValor("mensaje.listas.negras.alta.cliente"));
			}
		}
		logger.info("validarIdentificador:fin()");
		return r;
	}
	
	public RetornoValidacionAjaxDTO eliminarReferenciasCliente() {
		logger.info("eliminarReferenciasCliente, inicio");
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		RetornoValidacionAjaxDTO r = new RetornoValidacionAjaxDTO();
		if (!validarSesion(sesion)) {
			r.setCodError("-100");
			r.setMsgError("Su sesión ha expirado");
			logger.error(r.getMsgError());
			return r;
		}
		AltaClienteInicioForm form = (AltaClienteInicioForm) sesion.getAttribute("AltaClienteInicioForm");
		form.setArrayRefClienteAlta(null);
		logger.info("eliminarReferenciasCliente, fin");
		return r;
	}

	private boolean validarSesion(HttpSession sesion){
		if (sesion == null)	return false;
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal"); 
		if (sessionData == null) return false;
		return true;
	}	
	
	//Inicio P-CSR-11002 JLGN 12-08-2011
	public RetornoListaAjaxDTO obtenerIdentificadoresClienteFiltro(String tipCliente){
		logger.debug("obtenerIdentificadoresClienteFiltro:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);				
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
	
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm)sesion.getAttribute("AltaClienteInicioForm");
		IdentificadorCivilComDTO[] arrayIdentificadores = altaClienteActionForm.getArrayIdentificadorCliente();

		ArrayList arrayAuxIdenticadores2 = new ArrayList();
		
		//if(tipCliente.equals("1")){ MA-XXXXXX JLGN
		if(tipCliente.equals("1") || tipCliente.equals("4")){	
			//Cliente Empresa solo muestra Identificacion Juridica
			for (int i=0;i<arrayIdentificadores.length;i++){
				IdentificadorCivilComDTO identAux= (IdentificadorCivilComDTO)arrayIdentificadores[i];
				if (identAux.getCodigoTipIdentif().equals("02")){
					arrayAuxIdenticadores2.add(identAux);
				}
			}			
		}else if(tipCliente.equals("2")){
			//Cliente Particular no se muestra Identificacion Juridica
			for (int i=0;i<arrayIdentificadores.length;i++){
				IdentificadorCivilComDTO identAux= (IdentificadorCivilComDTO)arrayIdentificadores[i];
				if (!identAux.getCodigoTipIdentif().equals("02")){
					arrayAuxIdenticadores2.add(identAux);
				}
			}
		}else {
			for (int i=0;i<arrayIdentificadores.length;i++){
				IdentificadorCivilComDTO identAux= (IdentificadorCivilComDTO)arrayIdentificadores[i];
				arrayAuxIdenticadores2.add(identAux);				
			}			
		}
		
		IdentificadorCivilComDTO[] arrayIdenticadores2=(IdentificadorCivilComDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrayAuxIdenticadores2.toArray(), IdentificadorCivilComDTO.class);
		retorno.setLista(arrayIdenticadores2);
		
		logger.debug("obtenerIdentificadoresClienteFiltro:fin()");
		return retorno;	
	}
	//Fin P-CSR-11002 JLGN 12-08-2011
}
