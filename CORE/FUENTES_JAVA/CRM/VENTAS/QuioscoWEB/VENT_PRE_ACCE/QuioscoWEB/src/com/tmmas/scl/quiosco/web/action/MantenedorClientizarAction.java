package com.tmmas.scl.quiosco.web.action;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.rpc.ServiceException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWS;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService_Impl;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArrayOfTipificaClientizaDTO_Literal;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTipificacionOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.scl.quiosco.web.VO.ArticuloVO;
import com.tmmas.scl.quiosco.web.form.MantenedorClientizarForm;



public class MantenedorClientizarAction extends Action {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(this.getClass());

	public ActionForward execute(ActionMapping mapping, ActionForm p_form, HttpServletRequest request, HttpServletResponse response) throws GeneralException, ServiceException{
		
		CompositeConfiguration config;
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
		UtilLog.setLog(config.getString("QuioscoWEB.log"));
		HttpSession session = request.getSession();
		String target = null;
		
		SpnSclWSService service = new SpnSclWSService_Impl(config.getString("ruta.webservice"));    
		SpnSclWS port = service.getSpnSclWSSoapPort();
		
		MantenedorClientizarForm mantenedorClientizarForm = (MantenedorClientizarForm) p_form;
		
		List<ArticuloVO> listaArticulo = (List<ArticuloVO>)session.getAttribute("listaArticulo");
		
		if(null==listaArticulo)
			listaArticulo = new ArrayList<ArticuloVO>();
			
			
		//Carga Inicial del Mantenedor
		if( "preCargaIni".equals(mantenedorClientizarForm.getAccionMantClient()) ){
			
			if(logger.isDebugEnabled()){
				logger.error("preCargaIni:Inicio");
			}
			
			target = "preCargaIni";
			
			if(logger.isDebugEnabled()){
				logger.error("preCargaIni:Fin");
			}
		}
		else if( "cargaIni".equals(mantenedorClientizarForm.getAccionMantClient()) ){
			
			if(logger.isDebugEnabled()){
				logger.error("cargaIni:Inicio");
			}
			
			//Funcion que consulta lista de articulos configurador
			ArrayOfTipificaClientizaDTO_Literal tipificaClientizaDTO  = null;
			
			try {
				//Se recupera la lista de articulos
				tipificaClientizaDTO = new ArrayOfTipificaClientizaDTO_Literal();
				
				tipificaClientizaDTO = port.recuperaArrayTipificacion();
				
				//Transforma los datos a una List<ArticuloVO>
				listaArticulo = transformaArrayToList(tipificaClientizaDTO.getTipificaClientizaDTO());
				
			} catch (GeneralException e) {
				logger.error("GeneralException:"+e);
				request.setAttribute("desError", config.getString("msj.error.busc"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				logger.error("RemoteException:"+e);
				request.setAttribute("desError", config.getString("msj.error.busc"));
				target = "error";
				return mapping.findForward(target);
			}
	
			//Funcion que crea la cadena de articulos
			//String cadenaArticulos = creaCadenaArt(listaArticulo);
			
			//request.setAttribute("cadenaArti", cadenaArticulos);
			session.setAttribute("listaArticulo", listaArticulo);
			target = "cargaIni";
			
			if(logger.isDebugEnabled()){
				logger.error("cargaIni:Fin");
			}
			
		}
		else if( "agregarArticulo".equals(mantenedorClientizarForm.getAccionMantClient()) ){
			
			if(logger.isDebugEnabled()){
				logger.error("agregarArticulo:Inicio");
			}
			
			ArticuloVO articuloVO = null;
			
			//Funcion que crea una List<ArticuloVO>
			//List<ArticuloVO> listaArticulo = creaListaArt( null != mantenedorClientizarForm.getCadenaArticulos() ? mantenedorClientizarForm.getCadenaArticulos(): "" );
	
			Boolean estadoArt = buscarArtLista(listaArticulo, mantenedorClientizarForm.getCodArticulo());
			
			if(estadoArt){
			
				//Se agrega el articulo a la lista
				articuloVO = new ArticuloVO();
				articuloVO.setCodArticulo(mantenedorClientizarForm.getCodArticulo());
				articuloVO.setCodTipificacion(mantenedorClientizarForm.getCodTipificacion());
				articuloVO.setDescripcion(null == mantenedorClientizarForm.getDescripcion() ? "" : mantenedorClientizarForm.getDescripcion());
				//articuloVO.setTipificacion(mantenedorClientizarForm.getTipificacion());
				articuloVO.setClientizable(mantenedorClientizarForm.getClientizable());
				
				//Se obtiene de session el nombre de usuario
				WsTiendaVendedorOutDTO wsTiendaVendedorOutDTO = (WsTiendaVendedorOutDTO)session.getAttribute("tiendaVendedor");
				
				//Si no hay datos en session
				if(null == wsTiendaVendedorOutDTO){
					logger.error("agregarArticulo:"+config.getString("msj.error.sesion"));
					request.setAttribute("desError", config.getString("msj.error.sesion"));
					target = "error";
					return mapping.findForward(target);
				}
				
				articuloVO.setUsuaSclClient(wsTiendaVendedorOutDTO.getNomUsuario());
				
				//Se traspasa los dato al tipo de Objeto del WS
				TipificaClientizaDTO tipificaClientizaDTO = new TipificaClientizaDTO();
				//tipificaClientizaDTO.setTipificaClientizaDTO(trapasarObjetos(articuloVO));
				
				tipificaClientizaDTO.setCodArticulo(Integer.parseInt(articuloVO.getCodArticulo()));
				tipificaClientizaDTO.setCodTipificacion(articuloVO.getCodTipificacion());
				tipificaClientizaDTO.setDesTipificacion(articuloVO.getDescripcion());
				tipificaClientizaDTO.setFlagClientizable(Integer.parseInt(articuloVO.getClientizable()));
				tipificaClientizaDTO.setNomUsuario(articuloVO.getUsuaSclClient());
				
				try {
					//Se crea el articulo
					WsInsertTipificacionOutDTO outDTO = port.insertarTipificacion(tipificaClientizaDTO);
									
					if(0!=outDTO.getCodError()){
						request.setAttribute("desError", outDTO.getMsgError());
						target = "error";
						return mapping.findForward(target);
					}

					
					
					
				} catch (RemoteException e) {
					logger.error("RemoteException:"+e);
					request.setAttribute("desError", config.getString("msj.error.crea"));
					target = "error";
					return mapping.findForward(target);
				}
				
				if ("1".equals(mantenedorClientizarForm.getClientizable())){
					articuloVO.setClientizable("Si");
				} else {
					articuloVO.setClientizable("No");
				}
				//Se agrega el articulo
				listaArticulo.add(articuloVO);
				
				//Se elimina la referencia
				articuloVO = null;
				
				/*Se agrega el nuevo registro a la cadena
				StringBuffer cadenaArticulos = new StringBuffer();
				
				cadenaArticulos.append( null != mantenedorClientizarForm.getCadenaArticulos() ? mantenedorClientizarForm.getCadenaArticulos(): "" );
				
				cadenaArticulos.append(mantenedorClientizarForm.getCodArticulo()); //Codigo Articulo
				cadenaArticulos.append("##");//Separador de registro
				cadenaArticulos.append(mantenedorClientizarForm.getCodTipificacion()); //Codigo Tipificacion
				cadenaArticulos.append("##");//Separador de registro
				//cadenaArticulos.append( null == mantenedorClientizarForm.getDescripcion() ? "" :mantenedorClientizarForm.getDescripcion() ); //Descripcion
				//cadenaArticulos.append("##");//Separador de registro
				//cadenaArticulos.append(mantenedorClientizarForm.getTipificacion()); //Tipificacion
				//cadenaArticulos.append("#");//Separador de registro
				cadenaArticulos.append(mantenedorClientizarForm.getClientizable()); //Clientizable
				cadenaArticulos.append("##");//Separador de registro
				cadenaArticulos.append(wsTiendaVendedorOutDTO.getCodVendedor()); //Codigo usuario
				cadenaArticulos.append("##");//Separador de registro
				cadenaArticulos.append( null == mantenedorClientizarForm.getDescripcion() ? "" :mantenedorClientizarForm.getDescripcion() ); //Descripcion
				
				//separador de lineas
				cadenaArticulos.append("$$");
				
				request.setAttribute("cadenaArti", cadenaArticulos.toString());*/
				request.setAttribute("msgTipif","Tipificación Registrada Con Exito");
				session.setAttribute("listaArticulo", listaArticulo);
				target = "cargaIni";
				
			}else{
				request.setAttribute("desError", config.getString("msj.error.agre"));
				target = "error";
			}
			
			if(logger.isDebugEnabled()){
				logger.error("agregarArticulo:Fin");
			}
			
		}
		else if( "eliminarArt".equals(mantenedorClientizarForm.getAccionMantClient()) ){

			if(logger.isDebugEnabled()){
				logger.error("eliminarArt:Inicio");
			}
			
			try {
				//Se elimina el articulo
				
				port.deleteTipificacion(Long.valueOf(mantenedorClientizarForm.getCodArticulo()));
				
			} catch (GeneralException e) {
				request.setAttribute("desError", config.getString("msj.error.elim"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				request.setAttribute("desError", config.getString("msj.error.elim"));
				target = "error";
				return mapping.findForward(target);
			}
		
			
			//Funcion que consulta lista de articulos configurador
			ArrayOfTipificaClientizaDTO_Literal tipificaClientizaDTO  = null;
			
			try {
				//Se recupera la lista de articulos
				tipificaClientizaDTO = new ArrayOfTipificaClientizaDTO_Literal();
				
				tipificaClientizaDTO = port.recuperaArrayTipificacion();
								
				//Transforma los datos a una List<ArticuloVO>
				listaArticulo = transformaArrayToList(tipificaClientizaDTO.getTipificaClientizaDTO());
				
			} catch (GeneralException e) {
				logger.error("GeneralException:"+e);
				request.setAttribute("desError", config.getString("msj.error.busc"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				logger.error("RemoteException:"+e);
				request.setAttribute("desError", config.getString("msj.error.busc"));
				target = "error";
				return mapping.findForward(target);
			}
			
			/*Funcion que crea una List<ArticuloVO>
			List<ArticuloVO> listaArticulo = creaListaArt( null != mantenedorClientizarForm.getCadenaArticulos() ? mantenedorClientizarForm.getCadenaArticulos(): "", mantenedorClientizarForm.getCodArticulo() );
			
			//Funcion que crea la cadena de articulos
			String cadenaArticulos = creaCadenaArt(listaArticulo);
			
			request.setAttribute("cadenaArti", cadenaArticulos);*/
			request.setAttribute("msgTipif","Tipificación Eliminada Con Exito");
			session.setAttribute("listaArticulo", listaArticulo);
			request.setAttribute("eliminarArt", ""); //Flag
			target = "cargaIni";
			
			if(logger.isDebugEnabled()){
				logger.error("eliminarArt:Fin");
			}
			
		}
		else if( "modificarArt".equals(mantenedorClientizarForm.getAccionMantClient()) ){
			
			if(logger.isDebugEnabled()){
				logger.error("modificarArt:Inicio");
			}
					
			
			boolean esValido = buscarArtListaMod(listaArticulo,mantenedorClientizarForm);
			
			if(esValido){
			
			ArticuloVO ArtVO = new ArticuloVO();
			
			ArtVO.setCodArticulo(mantenedorClientizarForm.getCodArticulo());
			ArtVO.setCodTipificacion(mantenedorClientizarForm.getCodTipificacion());
			ArtVO.setDescripcion( null == mantenedorClientizarForm.getDescripcion() ? "" : mantenedorClientizarForm.getDescripcion() );
			//ArtVO.setTipificacion(mantenedorClientizarForm.getTipificacion());
			ArtVO.setClientizable(mantenedorClientizarForm.getClientizable());
			
			//Se obtiene de session el codigo usuario
			WsTiendaVendedorOutDTO wsTiendaVendedorOutDTO = (WsTiendaVendedorOutDTO)session.getAttribute("tiendaVendedor");
			
			//Si no hay datos en session
			if(null == wsTiendaVendedorOutDTO){
				logger.error("modificarArt:"+config.getString("msj.error.sesion"));
				request.setAttribute("desError", config.getString("msj.error.sesion"));
				target = "error";
				return mapping.findForward(target);
			}
			
			ArtVO.setUsuaSclClient(wsTiendaVendedorOutDTO.getCodVendedor());

			//Se traspasa los dato al tipo de Objeto del WS
			TipificaClientizaDTO tipificaClientizaDTO = new TipificaClientizaDTO();
			//tipificaClientizaDTO.setTipificaClientizaDTO(trapasarObjetos(ArtVO));
			
			tipificaClientizaDTO.setCodArticulo(Integer.parseInt(ArtVO.getCodArticulo()));
			tipificaClientizaDTO.setCodTipificacion(ArtVO.getCodTipificacion());
			tipificaClientizaDTO.setDesTipificacion(ArtVO.getDescripcion());
			tipificaClientizaDTO.setFlagClientizable(Integer.parseInt(ArtVO.getClientizable()));
			tipificaClientizaDTO.setNomUsuario(ArtVO.getUsuaSclClient());
			
			try {								 
				//Se realiza la actualizacion del articulo
				port.updateTipificacion(tipificaClientizaDTO);
				
				
			} catch (GeneralException e) {
				request.setAttribute("desError", config.getString("msj.error.mod"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				request.setAttribute("desError", config.getString("msj.error.mod"));
				target = "error";
				return mapping.findForward(target);
			}
		
			
			//Funcion que consulta lista de articulos configurador
			ArrayOfTipificaClientizaDTO_Literal tipificaClientizaDTOs  = null;
			
			try {
				//Se recupera la lista de articulos
				tipificaClientizaDTOs = new ArrayOfTipificaClientizaDTO_Literal();
				
				tipificaClientizaDTOs = port.recuperaArrayTipificacion();
				
				//Transforma los datos a una List<ArticuloVO>
				listaArticulo = transformaArrayToList(tipificaClientizaDTOs.getTipificaClientizaDTO());
				
			} catch (GeneralException e) {
				logger.error("GeneralException:"+e);
				request.setAttribute("desError", config.getString("msj.error.busc"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				logger.error("RemoteException:"+e);
				request.setAttribute("desError", config.getString("msj.error.busc"));
				target = "error";
				return mapping.findForward(target);
			}
			
			//Funcion que crea una List<ArticuloVO>
			/*List<ArticuloVO> listaArticulo = creaListaArt( null != mantenedorClientizarForm.getCadenaArticulos() ? mantenedorClientizarForm.getCadenaArticulos(): "", ArtVO );
			
			//Funcion que crea la cadena de articulos
			String cadenaArticulos = creaCadenaArt(listaArticulo);
			
			request.setAttribute("cadenaArti", cadenaArticulos.toString());*/
			request.setAttribute("msgTipif","Tipificación Modificada Con Exito");
			session.setAttribute("listaArticulo", listaArticulo);
			target = "cargaIni";
		
			if(logger.isDebugEnabled()){
				logger.error("modificarArt:Fin");
			}
			}else{
				request.setAttribute("desError", "El código de articulo ya esta configurado con otra tipificación");
				target = "error";
			}
			
		}
		
		return mapping.findForward(target);
		
	}

	/*
	 * Metodo: creaCadenaArt
	 * Descripción: crea la una cadena con los datos por articulo
	 * Fecha: 07/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	/*private String creaCadenaArt(List<ArticuloVO> listaArticulo){
		
		StringBuffer cadenaArticulos = new StringBuffer();

		for (Iterator<ArticuloVO> iterator = listaArticulo.iterator(); iterator.hasNext();) {
			ArticuloVO articuloCadVO = (ArticuloVO) iterator.next();
			
			cadenaArticulos.append(articuloCadVO.getCodArticulo()); //Codigo Articulo
			cadenaArticulos.append("##");//Separador de registro
			cadenaArticulos.append(articuloCadVO.getCodTipificacion()); //Codigo Tipificacion
			cadenaArticulos.append("##");//Separador de registro
			//cadenaArticulos.append(null == articuloCadVO.getDescripcion() ? "" : articuloCadVO.getDescripcion() ); //Descripcion
			//cadenaArticulos.append("##");//Separador de registro
			//cadenaArticulos.append(articuloCadVO.getTipificacion()); //Tipificacion
			//cadenaArticulos.append("#");//Separador de registro
			cadenaArticulos.append(articuloCadVO.getClientizable()); //Clientizable
			cadenaArticulos.append("##");//Separador de registro
			cadenaArticulos.append(articuloCadVO.getUsuaSclClient()); //Usuario registro
			cadenaArticulos.append("##");//Separador de registro
			cadenaArticulos.append(null == articuloCadVO.getDescripcion() ? "" : articuloCadVO.getDescripcion() ); //Descripcion
			
			//Fin fila
			cadenaArticulos.append("$$");
			
		}

		return cadenaArticulos.toString();
		
	}*/
	
	/*
	 * Metodo: creaListaArt
	 * Descripción: crea la una List<ArticuloVO> con los datos por articulo
	 * Fecha: 07/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	/*private List<ArticuloVO> creaListaArt(String cadenaArticulo){
		
		List<ArticuloVO> listaArticulo =  null;
		ArticuloVO articuloVO = null;
		
		
		//Separa las lineas y los parametros
		Vector<String> v = splitList(cadenaArticulo, "$$", "##");
		
		//Obtiene el largo del vector
		int largo = v.size()-1;
		
		//Inicializa la lista
		listaArticulo =  new ArrayList<ArticuloVO>();

		for(int j=0; j<largo; ++j){
			
			articuloVO = new ArticuloVO();
			
			articuloVO.setCodArticulo(v.elementAt(j)); //Codigo articulo
			articuloVO.setCodTipificacion(v.elementAt(++j)); //Codigo tipificacion
			articuloVO.setClientizable(v.elementAt(++j)); //Clientizable
			articuloVO.setUsuaSclClient(v.elementAt(++j)); //Usuario SCL
			articuloVO.setDescripcion(v.elementAt(++j));

			//Se agrega el articulo a la lista
			listaArticulo.add(articuloVO);
	
			//Se elimina la referencia
			articuloVO = null;
		}
		
		//Se elimina la referencia
		v = null;

		return listaArticulo;
		
	}*/
	
	/*
	 * Metodo: creaListaArt
	 * Descripción: crea la una List<ArticuloVO> con los datos por articulo.
	 * 				Excluyendo el codigo de articulo y sus relacionados (String codArticulo).
	 * Fecha: 07/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	/*private List<ArticuloVO> creaListaArt(String cadenaArticulo, String codArticulo){
		
		List<ArticuloVO> listaArticulo =  null;
		ArticuloVO articuloVO = null;
		
		//Separa las lineas y los parametros
		Vector<String> v = splitList(cadenaArticulo, "$$", "##");
		
		//Obtiene el largo del vector
		int largo = v.size()-1;
		
		//Inicializa la lista
		listaArticulo =  new ArrayList<ArticuloVO>();

		for(int j=0; j<largo; ++j){
			
			articuloVO = new ArticuloVO();
			
			articuloVO.setCodArticulo(v.elementAt(j)); //Codigo articulo
			articuloVO.setCodTipificacion(v.elementAt(++j)); //Codigo tipificacion
			articuloVO.setClientizable(v.elementAt(++j)); //Clientizable
			articuloVO.setUsuaSclClient(v.elementAt(++j)); //Usuario SCL
			articuloVO.setDescripcion(v.elementAt(++j)); //Descripcion

			if( !codArticulo.equals(articuloVO.getCodArticulo()) ){
				//Se agrega el articulo a la lista
				listaArticulo.add(articuloVO);
			}
			//Se elimina la referencia
			articuloVO = null;
		}
		
		//Se elimina la referencia
		v = null;
		
		return listaArticulo;
		
	}
	
	/*
	 * Metodo: creaListaArt
	 * Descripción: crea la una List<ArticuloVO> con los datos por articulo.
	 * 				Modificando un articulo.
	 * Fecha: 07/06/2010
	 * Developer: Gabriel Moraga L. 
	 *
	
	private List<ArticuloVO> creaListaArt(String cadenaArticulo, ArticuloVO articuloModVO){
		
		List<ArticuloVO> listaArticulo =  new ArrayList<ArticuloVO>();
		ArticuloVO articuloVO = null;
		
		//Separa las lineas y los parametros
		Vector<String> v = splitList(cadenaArticulo, "$$", "##");
		
		//Obtiene el largo del vector
		int largo = v.size()-1;
		
		//Inicializa la lista
		listaArticulo =  new ArrayList<ArticuloVO>();

		for(int j=0; j<largo; ++j){
			
			articuloVO = new ArticuloVO();
			
			articuloVO.setCodArticulo(v.elementAt(j)); //Codigo articulo
			
			//Si es igual el codigo de articulo se modifica los datos
			if( articuloVO.getCodArticulo().equals(articuloModVO.getCodArticulo()) ){
			
				articuloVO.setCodTipificacion(articuloModVO.getCodTipificacion()); //Codigo tipificacion
				articuloVO.setClientizable(articuloModVO.getClientizable()); //Clientizable
				articuloVO.setUsuaSclClient(articuloModVO.getUsuaSclClient()); //Usuario SCL
				articuloVO.setDescripcion(articuloModVO.getDescripcion()); //Descripcion
				
				v.elementAt(++j); //Codigo tipificacion
				v.elementAt(++j); //Clientizable
				v.elementAt(++j); //Usuario SCL
				
			}else{
				
				articuloVO.setCodTipificacion(v.elementAt(++j)); //Codigo tipificacion
				articuloVO.setClientizable(v.elementAt(++j)); //Clientizable
				articuloVO.setUsuaSclClient(v.elementAt(++j)); //Usuario SCL
				articuloVO.setDescripcion(v.elementAt(++j)); //Descripcion
				
			}
			
			//Se agrega el articulo a la lista
			listaArticulo.add(articuloVO);
		
			//Se elimina la referencia
			articuloVO = null;
		}
		
		//Se elimina la referencia
		v = null;
		
		return listaArticulo;
		
	}
	
	/*
	 * Metodo: buscarArtLista
	 * Descripción: busca en la lista de articulos si ya existe el que se desea agregar (String codArt).
	 * Fecha: 07/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	private Boolean buscarArtLista(List<ArticuloVO> listaArticulo, String codArt){
		
		Boolean estadoArt = true;
		
		for (Iterator<ArticuloVO> iterator = listaArticulo.iterator(); iterator.hasNext();) {
			ArticuloVO articuloCadVO = (ArticuloVO) iterator.next();
			
			//Si el codigo se encuentra en la lista no permite agregar
			if( codArt.equals(articuloCadVO.getCodArticulo()) ){
				estadoArt = false;
				break;
			}
		}
		
		return estadoArt;
		
	}
	
	
private Boolean buscarArtListaMod(List<ArticuloVO> listaArticulo, MantenedorClientizarForm form){
		
		Boolean estadoArt = true;
		
		for (Iterator<ArticuloVO> iterator = listaArticulo.iterator(); iterator.hasNext();) {
			ArticuloVO articuloCadVO = (ArticuloVO) iterator.next();
			
			//Si el codigo se encuentra en la lista no permite agregar
			if( form.getCodArticulo().equals(articuloCadVO.getCodArticulo()) &&!form.getCodTipificacion().equals(articuloCadVO.getCodTipificacion())){
				estadoArt = false;
				break;
			}
		}
		
		return estadoArt;
		
	}
	
	
	
	/*
	 * Metodo: transformaArrayToList
	 * Descripción: traspasa de un TipificaClientizaDTO[] a List<ArticuloVO>
	 * Fecha: 09/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	private List<ArticuloVO> transformaArrayToList(TipificaClientizaDTO[] tipificaClientizaDTO){

		List<ArticuloVO> listaArticulo =  new ArrayList<ArticuloVO>();
		
		int largo = tipificaClientizaDTO.length;
		
		for (int i = 0; i < largo; ++i) {
			
			ArticuloVO articuloVO =  new ArticuloVO();
			articuloVO.setCodArticulo(String.valueOf(tipificaClientizaDTO[i].getCodArticulo())); //Codigo articulo
			articuloVO.setCodTipificacion(tipificaClientizaDTO[i].getCodTipificacion()); //Codigo tipificacion
			//articuloVO.setTipificacion("No");
			//P-CSR-11002 articuloVO.setClientizable( 0 == tipificaClientizaDTO[i].getFlagClientizable() ? "Si" : "No" ); //Clientizable
			if(tipificaClientizaDTO[i].getFlagClientizable() == 1){
				articuloVO.setClientizable("Si");
			} else {
				articuloVO.setClientizable("No");
			}
			articuloVO.setUsuaSclClient(String.valueOf(tipificaClientizaDTO[i].getNomUsuario())); // Usuario scl
			articuloVO.setDescripcion(tipificaClientizaDTO[i].getDesTipificacion()); //Descripcion
			//Se agrega a la lista
			listaArticulo.add(articuloVO);
			
			//elimina la referencia
			articuloVO = null;
		}
		
		return listaArticulo;
		
	}
	
	/*
	 * Metodo: trapasarObjetos
	 * Descripción: traspasa de un ArticuloVO a TipificaClientizaDTO
	 * Fecha: 11/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	private TipificaClientizaDTO trapasarObjetos(ArticuloVO articuloVO){
		
		TipificaClientizaDTO tipificaClientizaDTO = new TipificaClientizaDTO();
		
		tipificaClientizaDTO.setCodArticulo(Integer.parseInt(articuloVO.getCodArticulo()));
		logger.error("codArticulo: "+tipificaClientizaDTO.getCodArticulo());
		tipificaClientizaDTO.setCodTipificacion(articuloVO.getCodTipificacion());
		logger.error("getCodTipificacion: "+tipificaClientizaDTO.getCodTipificacion());
		tipificaClientizaDTO.setFlagClientizable("Si"==articuloVO.getClientizable() ? 0 : 1 ); //Si es Si = 0, No = 1 
		logger.error("setFlagClientizable: "+tipificaClientizaDTO.getFlagClientizable());
		tipificaClientizaDTO.setNomUsuario(articuloVO.getUsuaSclClient());
		logger.error("setNomUsuario: "+tipificaClientizaDTO.getNomUsuario());
		tipificaClientizaDTO.setDesTipificacion(articuloVO.getDescripcion());
		logger.error("getDesTipificacion: "+tipificaClientizaDTO.getDesTipificacion());
		
		return tipificaClientizaDTO;
		
	}
	
	/*
	 * Metodo: splitList
	 * Descripción: 
	 * Fecha: 14/06/2010
	 * Developer: Gabriel Moraga L. 
	 *
	
	public Vector<String> splitList(String str, String delims, String delimsInterno){

		Vector<String> v = new Vector<String>();

		//Obtiene las lineas
		String[] arregloLinea = splitString(str, delims);
		
		//Obtiene la cantidad de registros
		int largoLinea = arregloLinea.length;
		
		for(int i=0; i<largoLinea; i++){
		
			int pos = 0;
			int newpos = arregloLinea[i].indexOf(delimsInterno, pos);
			
			while(newpos != -1){
				v.addElement(arregloLinea[i].substring(pos, newpos));
				pos = newpos + delimsInterno.length();
				newpos = arregloLinea[i].indexOf(delimsInterno, pos);
			}
			
			v.addElement(arregloLinea[i].substring(pos));
	
		}
		
		//Se elimina la referencia
		arregloLinea = null;
		
		return v;
	
	}
	
	/*
	 * Metodo: splitString
	 * Descripción: 
	 * Fecha: 14/06/2010
	 * Developer: Gabriel Moraga L. 
	 *
	
	public static String[] splitString(String str, String delims){

		String[] s;
		Vector<String> v = new Vector<String>();
		
		int pos = 0;
		int newpos = str.indexOf(delims, pos);
		
		while(newpos != -1){
			v.addElement(str.substring(pos, newpos));
			pos = newpos + delims.length();
			newpos = str.indexOf(delims, pos);
		}
		
		v.addElement(str.substring(pos));
		s = new String[v.size()];
		
		for(int i=0, cnt=s.length; i<cnt; i++){
			s[i] = (String) v.elementAt(i);
		}
		
		//Se elimina la referencia
		v = null;
		
		return s;
	
	}*/
	
}
