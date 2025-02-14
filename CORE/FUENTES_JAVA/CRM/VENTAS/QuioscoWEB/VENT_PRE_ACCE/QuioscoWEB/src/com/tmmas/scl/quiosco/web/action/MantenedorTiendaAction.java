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
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArrayOfTiendaDTO_Literal;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArrayOfTipificaClientizaDTO_Literal;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsUpdateTiendaOutDTO;
import com.tmmas.scl.quiosco.web.VO.MantTiendaVO;
import com.tmmas.scl.quiosco.web.form.MantenedorTiendaForm;

public class MantenedorTiendaAction extends Action {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(this.getClass());
	
	public ActionForward execute(ActionMapping mapping, ActionForm p_form, HttpServletRequest request, HttpServletResponse response) throws ServiceException {
		
		
		CompositeConfiguration config;
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
		UtilLog.setLog(config.getString("QuioscoWEB.log"));
		//SpnSclWSServiceStub proxy = new SpnSclWSServiceStub(config.getString("ruta.webservice"));
		
		SpnSclWSService service = new SpnSclWSService_Impl(config.getString("ruta.webservice"));    
		SpnSclWS port = service.getSpnSclWSSoapPort();
		HttpSession session = request.getSession();
		String target = null;
		
		MantenedorTiendaForm mantenedorTiendaForm = (MantenedorTiendaForm) p_form;
		
		WsCajaOutDTO cajaOutDTO = (WsCajaOutDTO )session.getAttribute("cajasDTO");
		
		
		List<MantTiendaVO> listaTienda =  (List<MantTiendaVO>) session.getAttribute("listaTienda");
			
		
		if(null==listaTienda)
			listaTienda = new ArrayList<MantTiendaVO>();
		
		if(null==cajaOutDTO){
		try {
			/*GetListaCaja listaCaja = new GetListaCaja();
			listaCaja.setCodOficina(config.getString("cod.oficina"));*/
			//WsCajaOutDTO cajaOutDTO = proxy.getListaCaja(listaCaja);
			//INI-01 (AL) - Comentado y reemplazado.

			//P-CSR-11002
			//WsCajaOutDTO cajaOutDTO2 = port.getListaCaja(config.getString("cod.oficina"));
			cajaOutDTO = port.getListaCaja(config.getString("cod.oficina"));

			if(0!=cajaOutDTO.getCodError()){
				logger.error("Error al recuperar cajas: "+cajaOutDTO.getMsgError());
				request.setAttribute("desError",cajaOutDTO.getMsgError());
				target="globalError";
				return mapping.findForward(target);
			}
			
			session.setAttribute("cajasDTO", cajaOutDTO);
			
		} catch (GeneralException e1) {
			e1.printStackTrace();
		} catch (RemoteException e1) {
			e1.printStackTrace();
		}
		}
		
		//Carga Inicial del Mantenedor
		if( "preCargaIni".equals(mantenedorTiendaForm.getAccionMantTienda()) ){
			
			if(logger.isDebugEnabled()){
				logger.error("preCargaIni:Inicio");
			}
			
			target = "preCargaIni";
			
			if(logger.isDebugEnabled()){
				logger.error("preCargaIni:Fin");
			}
			
		}
		else if( "cargaIni".equals(mantenedorTiendaForm.getAccionMantTienda()) ){
			
			if(logger.isDebugEnabled()){
				logger.error("cargaIni:Inicio");
			}
			
			try {
				
				
				//Se recupera la lista de articulos
				
				ArrayOfTiendaDTO_Literal tiendaDTO = new ArrayOfTiendaDTO_Literal();
				
				 tiendaDTO = port.obtieneListaTienda();
				
				
				//Transforma los datos a una List<MantTiendaVO>
				listaTienda = transformaArrayToList(tiendaDTO.getTiendaDTO());
				
			} catch (GeneralException e) {
				logger.error("GeneralException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.busc"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				logger.error("RemoteException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.busc"));
				target = "error";
				return mapping.findForward(target);
			}

			//Funcion que crea la cadena de tienda
			//String cadenaTienda = creaCadenaTien(listaTienda);
			
			//request.setAttribute("cadenaTien", cadenaTienda);
			target = "cargaIni";
			
			if(logger.isDebugEnabled()){
				logger.error("cargaIni:Fin");
			}
			
		}
		else if( "agregarTienda".equals(mantenedorTiendaForm.getAccionMantTienda()) ){
			
			if(logger.isDebugEnabled()){
				logger.error("agregarTienda:Inicio");
			}
			
			MantTiendaVO mantTiendaVO = null;
			
			//Funcion que crea una List<ArticuloVO>
			//List<MantTiendaVO> listaTienda = creaListaTienda( null != mantenedorTiendaForm.getCadenaTienda() ? mantenedorTiendaForm.getCadenaTienda(): "" );
			
			Boolean estadoTien = buscarTienLista(listaTienda,  mantenedorTiendaForm.getNomTienda());
			
			if(estadoTien){
				
				
				//Se obtiene de session el codigo usuario
				WsTiendaVendedorOutDTO wsTiendaVendedorOutDTO = (WsTiendaVendedorOutDTO)session.getAttribute("tiendaVendedor");
				
				//Si no hay datos en session
				if(null == wsTiendaVendedorOutDTO){
					logger.error("agregarTienda:"+config.getString("msj.error.sesion"));
					request.setAttribute("desError", config.getString("msj.error.sesion"));
					target = "error";
					return mapping.findForward(target);
				}
				
				//Se agrega el articulo a la lista
				mantTiendaVO = new MantTiendaVO();
				
				mantTiendaVO.setNomTienda(mantenedorTiendaForm.getNomTienda()); //Nombre de la tienda
				mantTiendaVO.setUsuaVendedor(mantenedorTiendaForm.getUsuaVendedor()); //Nombre vendedor
				mantTiendaVO.setUsuacajero(mantenedorTiendaForm.getUsuacajero()); //Nombre Cajero
				mantTiendaVO.setUsuaTien(wsTiendaVendedorOutDTO.getNomUsuario()); //Nombre caja
				mantTiendaVO.setCodCliente(mantenedorTiendaForm.getCodClienteTien()); //Codego cliente
				mantTiendaVO.setCodCaja(mantenedorTiendaForm.getCodCaja()); //Codigo caja
				mantTiendaVO.setDesCaja(mantenedorTiendaForm.getDesCaja()); //nombre caja
				mantTiendaVO.setIndApliPago(mantenedorTiendaForm.getIndApliPago());//aplica pago
				
				//transpasa los datos de un MantTiendaVO a TiendaDTO
				TiendaDTO tiendaDTO = new TiendaDTO(); 
				//tiendaDTO.setTiendaDTO(trapasarObjetos(mantTiendaVO));	
				
				tiendaDTO.setDesTienda(mantTiendaVO.getNomTienda());
				tiendaDTO.setNomUsuarioVendedor(mantTiendaVO.getUsuaVendedor());
				tiendaDTO.setNomUsuarioCajero(mantTiendaVO.getUsuacajero());
				tiendaDTO.setNomUsuario(mantTiendaVO.getUsuaTien());
				tiendaDTO.setCodCliente(mantTiendaVO.getCodCliente());
				tiendaDTO.setCodCaja(mantTiendaVO.getCodCaja());
				tiendaDTO.setDesCaja(mantTiendaVO.getDesCaja());
				tiendaDTO.setIndApliPago(mantTiendaVO.getIndApliPago());
				
				WsInsertTiendaOutDTO wsInsertTiendaOutDTO = null;
				
				try {
					//Se crea la tienda
					wsInsertTiendaOutDTO = port.insertTienda(tiendaDTO);
					
					
					if( 0 != wsInsertTiendaOutDTO.getCodError()){
						logger.error("Error:"+wsInsertTiendaOutDTO.getMsgError());
						request.setAttribute("desError", wsInsertTiendaOutDTO.getMsgError());
						target = "error";
						return mapping.findForward(target);
					}
					
					
					//Se obtiene el codigo de tienda guardado
					
					
					mantTiendaVO.setCodTienda(null == new Long(wsInsertTiendaOutDTO.getCodTienda()) ? null : new Long(wsInsertTiendaOutDTO.getCodTienda()).toString());
					
				} catch (GeneralException e) {
					logger.error("GeneralException:"+e);
					request.setAttribute("desError", config.getString("msj.error.tien.crea"));
					target = "error";
					return mapping.findForward(target);
				} catch (RemoteException e) {
					logger.error("RemoteException:"+e);
					request.setAttribute("desError", config.getString("msj.error.tien.crea"));
					target = "error";
					return mapping.findForward(target);
				}
				
				
				mantTiendaVO.setIndApliPago("1".equals(mantTiendaVO.getIndApliPago().trim())?"SI":"NO");
				listaTienda.add(mantTiendaVO);
				
				//Se agrega el nuevo registro a la cadena
				/*StringBuffer cadenaTienda = new StringBuffer();
			
				cadenaTienda.append( null != mantenedorTiendaForm.getCadenaTienda() ? mantenedorTiendaForm.getCadenaTienda(): "" );
				
				cadenaTienda.append(mantTiendaVO.getCodTienda()); //Codigo tienda
				cadenaTienda.append("##");//Separador de registro
				cadenaTienda.append(mantenedorTiendaForm.getNomTienda()); //Nombre tienda
				cadenaTienda.append("##");//Separador de registro
				cadenaTienda.append(mantenedorTiendaForm.getUsuaVendedor()); //Usuario vendedor
				cadenaTienda.append("##");//Separador de registro
				cadenaTienda.append(mantenedorTiendaForm.getUsuacajero()); //Cajero Usuario
				cadenaTienda.append("##");//Separador de registro
				cadenaTienda.append(wsTiendaVendedorOutDTO.getNomUsuario()); //Caja Usuario
				cadenaTienda.append("##");//Separador de registro
				cadenaTienda.append(mantenedorTiendaForm.getCodClienteTien()); //Codigo cliente
				cadenaTienda.append("##");//Separador de registro
				cadenaTienda.append(mantTiendaVO.getCodCaja()); //Codigo caja
				cadenaTienda.append("##");//Separador de registro
				cadenaTienda.append(mantTiendaVO.getDesCaja()); //nombre caja
			
				//Separador de linea
				cadenaTienda.append("$$");*/
		
				//Se elimina la referencia
				mantTiendaVO = null;
				
				
				request.setAttribute("msgTienda","Tienda Registrada Con Exito");
				session.setAttribute("listaTienda", listaTienda);
				target = "cargaIni";

			}else{
				//System.out.println("sj.error.tien.agre:"+config.getString("msj.error.tien.agre"));
				request.setAttribute("desError", config.getString("msj.error.tien.agre"));
				target = "error";
			}
			
			if(logger.isDebugEnabled()){
				logger.error("agregarTienda:Fin");
			}

		}
		else if( "eliminarTien".equals(mantenedorTiendaForm.getAccionMantTienda()) ){

			if(logger.isDebugEnabled()){
				logger.error("eliminarTien:Inicio");
			}
			
			try {
				//Se elimina la tienda
				/*DeleteTienda deleteTienda = new DeleteTienda();
				deleteTienda.setCodTienda(Long.valueOf(mantenedorTiendaForm.getCodTienda()));
				proxy.deleteTienda(deleteTienda);*/
				
				port.deleteTienda(Long.valueOf(mantenedorTiendaForm.getCodTienda()));
												
			} catch (GeneralException e) {
				logger.error("GeneralException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.elim"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				logger.error("RemoteException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.elim"));
				target = "error";
				return mapping.findForward(target);
			}
			
			
			
			//Se recupera la lista de articulos
			ArrayOfTiendaDTO_Literal tiendaDTO = new ArrayOfTiendaDTO_Literal();
			
			try {			
				
				tiendaDTO = port.obtieneListaTienda();
				
			} catch (GeneralException e) {
				logger.error("GeneralException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.busc"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				logger.error("RemoteException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.busc"));
				target = "error";
				return mapping.findForward(target);
			}
			//Transforma los datos a una List<MantTiendaVO>
			listaTienda = transformaArrayToList(tiendaDTO.getTiendaDTO());
			
			
			//Funcion que crea una List<ArticuloVO>
			//listaTienda = creaListaTienda( null != mantenedorTiendaForm.getCadenaTienda() ? mantenedorTiendaForm.getCadenaTienda(): "", mantenedorTiendaForm.getCodTienda() );
			
			//Funcion que crea la cadena de articulos
			//String cadenaTienda = creaCadenaTien(listaTienda);
			
			//request.setAttribute("cadenaTien", cadenaTienda);
			request.setAttribute("msgTienda","Tienda Eliminada Con Exito");
			session.setAttribute("listaTienda", listaTienda);
			request.setAttribute("eliminarTien", ""); //Flag
			target = "cargaIni";
			
			if(logger.isDebugEnabled()){
				logger.error("eliminarTien:Fin");
			}
			
		}
		else if( "modificarTien".equals(mantenedorTiendaForm.getAccionMantTienda()) ){
			
			if(logger.isDebugEnabled()){
				logger.error("modificarTien:Inicio");
			}
			
			
			Boolean estadoTien = buscarTienModLista(listaTienda,  mantenedorTiendaForm.getNomTienda(),mantenedorTiendaForm.getCodTienda());
			
			
			if(estadoTien){
				
				estadoTien = validarModificacion(listaTienda,  mantenedorTiendaForm);
				if(estadoTien){
			
			//Se obtiene de session el codigo usuario
			WsTiendaVendedorOutDTO wsTiendaVendedorOutDTO = (WsTiendaVendedorOutDTO)session.getAttribute("tiendaVendedor");
			
			//Si no hay datos en session
			if(null == wsTiendaVendedorOutDTO){
				logger.error("modificarTien:"+config.getString("msj.error.sesion"));
				request.setAttribute("desError", config.getString("msj.error.sesion"));
				target = "error";
				return mapping.findForward(target);
			}
			
			//Se agrega el articulo a la lista
			MantTiendaVO mantTiendaVO = new MantTiendaVO();
			
			mantTiendaVO.setCodTienda(mantenedorTiendaForm.getCodTienda()); //Codigo tienda
			mantTiendaVO.setNomTienda(mantenedorTiendaForm.getNomTienda()); //Nombre de la tienda
			mantTiendaVO.setUsuaVendedor(mantenedorTiendaForm.getUsuaVendedor()); //Nombre vendedor
			mantTiendaVO.setUsuacajero(mantenedorTiendaForm.getUsuacajero()); //Nombre Cajero
			mantTiendaVO.setUsuaTien(wsTiendaVendedorOutDTO.getNomUsuario()); //Nombre usuario
			mantTiendaVO.setCodCliente(mantenedorTiendaForm.getCodClienteTien()); //Codego cliente
			mantTiendaVO.setCodCaja(mantenedorTiendaForm.getCodCaja()); //Codego caja
			mantTiendaVO.setDesCaja(mantenedorTiendaForm.getDesCaja()); //nombre caja
			mantTiendaVO.setIndApliPago(mantenedorTiendaForm.getIndApliPago());//aplica pago
			
			//transpasa los datos de de un MantTiendaVO a TiendaDTO
			TiendaDTO tiendaDTO = new TiendaDTO(); 
			
			tiendaDTO.setCodTienda(mantTiendaVO.getCodTienda());
			tiendaDTO.setDesTienda(mantTiendaVO.getNomTienda());
			tiendaDTO.setNomUsuarioVendedor(mantTiendaVO.getUsuaVendedor());
			tiendaDTO.setNomUsuarioCajero(mantTiendaVO.getUsuacajero());
			tiendaDTO.setNomUsuario(mantTiendaVO.getUsuaTien());
			tiendaDTO.setCodCliente(mantTiendaVO.getCodCliente());
			tiendaDTO.setCodCaja(mantTiendaVO.getCodCaja());
			tiendaDTO.setDesCaja(mantTiendaVO.getDesCaja());
			tiendaDTO.setIndApliPago(mantTiendaVO.getIndApliPago());
			
			WsUpdateTiendaOutDTO wsUpdateTiendaOutDTO = null;
			
			try {
				//Se realiza la actualizacion de tienda
				wsUpdateTiendaOutDTO = port.updateTienda(tiendaDTO);
				
				
				if( 222 == wsUpdateTiendaOutDTO.getCodError()){
					logger.error("Error:"+wsUpdateTiendaOutDTO.getMsgError());
					request.setAttribute("desError", wsUpdateTiendaOutDTO.getMsgError());
					target = "error";
					return mapping.findForward(target);
				}
				
			} catch (GeneralException e) {
				logger.error("GeneralException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.mod"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				logger.error("RemoteException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.mod"));
				target = "error";
				return mapping.findForward(target);
			}
			
			//Se recupera la lista de articulos
			ArrayOfTiendaDTO_Literal tiendaDTO2 = new ArrayOfTiendaDTO_Literal();
			try{
				
			tiendaDTO2 = port.obtieneListaTienda();
			} catch (GeneralException e) {
				logger.error("GeneralException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.busc"));
				target = "error";
				return mapping.findForward(target);
			} catch (RemoteException e) {
				logger.error("RemoteException:"+e);
				request.setAttribute("desError", config.getString("msj.error.tien.busc"));
				target = "error";
				return mapping.findForward(target);
			}
			
			//Transforma los datos a una List<MantTiendaVO>
			listaTienda = transformaArrayToList(tiendaDTO2.getTiendaDTO());
			
			//Funcion que crea una List<ArticuloVO>
			//List<MantTiendaVO> listaTienda = creaListaTienda( null != mantenedorTiendaForm.getCadenaTienda() ? mantenedorTiendaForm.getCadenaTienda(): "", mantTiendaVO );
			
			//Funcion que crea la cadena de articulos
			//String cadenaTienda = creaCadenaTien(listaTienda);
			
			//request.setAttribute("cadenaTien", cadenaTienda);
			request.setAttribute("msgTienda","Tienda Modificada Con Exito");
			session.setAttribute("listaTienda", listaTienda);
			target = "cargaIni";
				}else{
					//ERROR
					request.setAttribute("desError", "No se han realizado modificaciones para la tienda");
					target = "error";
				}
			
			}else{
				//ERROR
				request.setAttribute("desError", "Nombre de tienda a modificar, ya existe para otra tienda");
				target = "error";
			}
			
			if(logger.isDebugEnabled()){
				logger.error("modificarTien:Fin");
			}
			
		}

		
		session.setAttribute("listaTienda", listaTienda);
		
		return mapping.findForward(target);
		
	}

	/*
	 * Metodo: creaCadenaTien
	 * Descripción: crea la una cadena con los datos por tienda.
	 * Fecha: 08/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	/*private String creaCadenaTien(List<MantTiendaVO> listaTienda){
		
		StringBuffer cadenaTienda = new StringBuffer();
		
		for (Iterator<MantTiendaVO> iterator = listaTienda.iterator(); iterator.hasNext();) {
			MantTiendaVO mantTiendaVO = (MantTiendaVO) iterator.next();

			cadenaTienda.append(mantTiendaVO.getCodTienda()); //Codigo tienda
			cadenaTienda.append("##");//Separador de registro
			cadenaTienda.append(mantTiendaVO.getNomTienda()); //Nombre tienda
			cadenaTienda.append("##");//Separador de registro
			cadenaTienda.append(mantTiendaVO.getUsuaVendedor()); //Usuario vendedor
			cadenaTienda.append("##");//Separador de registro
			cadenaTienda.append(mantTiendaVO.getUsuacajero()); //Cajero
			cadenaTienda.append("##");//Separador de registro
			cadenaTienda.append(mantTiendaVO.getUsuaTien()); //Usuario
			cadenaTienda.append("##");//Separador de registro
			cadenaTienda.append(mantTiendaVO.getCodCliente()); //Codigo cliente
			cadenaTienda.append("##");//Separador de registro
			cadenaTienda.append(mantTiendaVO.getCodCaja()); //Codigo caja
			cadenaTienda.append("##");//Separador de registro
			cadenaTienda.append(mantTiendaVO.getDesCaja()); //nombre caja
			//Fin fila
			cadenaTienda.append("$$");
			
		}
		
		System.out.println("creaCadenaTien: cadenaTienda-->:"+cadenaTienda.toString());
		
		return cadenaTienda.toString();
		
	}*/
	
	/*
	 * Metodo: creaListaTienda
	 * Descripción: crea la una List<MantTiendaVO> con los datos por tienda.
	 * Fecha: 08/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	/*private List<MantTiendaVO> creaListaTienda(String cadenaTienda){
		
		List<MantTiendaVO> listaTienda =  null;
		MantTiendaVO mantTiendaVO = null;
		
		//Separa las lineas y los parametros
		Vector<String> v = splitList(cadenaTienda, "$$", "##");
		
		//Obtiene el largo del vector
		int largo = v.size()-1;
		
		//Inicializa la lista
		listaTienda =  new ArrayList<MantTiendaVO>();
		
		for(int j=0; j<largo; j++){
			
			mantTiendaVO = new MantTiendaVO();
			
			mantTiendaVO.setCodTienda(v.elementAt(j)); //Codigo tienda
			mantTiendaVO.setNomTienda(v.elementAt(++j)); //Nombre tienda
			mantTiendaVO.setUsuaVendedor(v.elementAt(++j)); //Usuario vendedor
			mantTiendaVO.setUsuacajero(v.elementAt(++j)); //Usuario cajero
			mantTiendaVO.setUsuaTien(v.elementAt(++j)); //Usuario
			mantTiendaVO.setCodCliente(v.elementAt(++j)); //Codigo cliente
			mantTiendaVO.setCodCaja(v.elementAt(++j)); //Codigo caja
			mantTiendaVO.setDesCaja(v.elementAt(++j)); //nombre caja
			
			//Se agrega el articulo a la lista
			listaTienda.add(mantTiendaVO);
			
			//Se elimina la referencia
			mantTiendaVO = null;
		}
		
		//Se elimina la referencia
		v = null;
		
		return listaTienda;
		
	}*/
	
	/*
	 * Metodo: creaListaTienda
	 * Descripción: crea la una List<MantTiendaVO> con los datos por tienda.
	 * 				Excluyendo el codigo de articulo y sus relacionados (String codTienda).
	 * Fecha: 08/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	/*private List<MantTiendaVO> creaListaTienda(String , String codTienda){
		
		List<MantTiendaVO> listaTienda = null;
		MantTiendaVO mantTiendaVO = null;
		
		//Separa las lineas y los parametros
		Vector<String> v = splitList(cadenaTienda, "$$", "##");
		
		//Obtiene el largo del vector
		int largo = v.size()-1;
		
		//Inicializa la lista
		listaTienda =  new ArrayList<MantTiendaVO>();
		System.out.println("largo:"+largo);
		for(int j=0; j<largo; ++j){
			
			mantTiendaVO = new MantTiendaVO();
			
			mantTiendaVO.setCodTienda(v.elementAt(j)); //Codigo tienda
			mantTiendaVO.setNomTienda(v.elementAt(++j)); //Nombre tienda
			mantTiendaVO.setUsuaVendedor(v.elementAt(++j)); //Usuario vendedor
			mantTiendaVO.setUsuacajero(v.elementAt(++j)); //Usuario cajero
			mantTiendaVO.setUsuaTien(v.elementAt(++j)); //Usuario
			mantTiendaVO.setCodCliente(v.elementAt(++j)); //Codigo cliente
			mantTiendaVO.setCodCaja(v.elementAt(++j)); //Codigo caja
			mantTiendaVO.setDesCaja(v.elementAt(++j)); //nombre caja
			
			//Si el codigo es igual no se agrega a la lista
			if( !codTienda.equals(mantTiendaVO.getCodTienda()) ){
				//Se agrega el articulo a la lista
				listaTienda.add(mantTiendaVO);
			}
			
			//Se elimina la referencia
			mantTiendaVO = null;
		}
		
		//Se elimina la referencia
		v = null;
		
		return listaTienda;
		
	}*/
	
	/*
	 * Metodo: creaListaTienda
	 * Descripción: crea la una List<MantTiendaVO> con los datos por tienda.
	 * 				Modificando un articulo.
	 * Fecha: 08/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	/*private List<MantTiendaVO> creaListaTienda(String cadenaTienda, MantTiendaVO mantTiendaModVO){
		
		List<MantTiendaVO> listaTienda =  null;
		MantTiendaVO mantTiendaVO = null;
		
		//Separa las lineas y los parametros
		Vector<String> v = splitList(cadenaTienda, "$$", "##");
		
		//Obtiene el largo del vector
		int largo = v.size()-1;
		
		//Inicializa la lista
		listaTienda =  new ArrayList<MantTiendaVO>();
		
		for(int j=0; j<largo; ++j){
			
			mantTiendaVO = new MantTiendaVO();
			
			//Set codigo tienda
			mantTiendaVO.setCodTienda(v.elementAt(j));
			
			//Si es igual el codigo de articulo se modifica los datos
			if( mantTiendaVO.getCodTienda().equals(mantTiendaModVO.getCodTienda()) ){
			
				mantTiendaVO.setNomTienda(mantTiendaModVO.getNomTienda()); //Nombre tienda
				mantTiendaVO.setUsuaVendedor(mantTiendaModVO.getUsuaVendedor()); //Usuario vendedor
				mantTiendaVO.setUsuacajero(mantTiendaModVO.getUsuacajero()); //Usuario cajero
				mantTiendaVO.setUsuaTien(mantTiendaModVO.getUsuaTien()); //Usuario
				mantTiendaVO.setCodCliente(mantTiendaModVO.getCodCliente()); //Codigo cliente
				mantTiendaVO.setCodCaja(mantTiendaModVO.getCodCaja()); //Codigo caja
				mantTiendaVO.setDesCaja(mantTiendaModVO.getDesCaja()); //nombre caja
				
				v.elementAt(++j); //Nombre tienda
				v.elementAt(++j); //Usuario vendedor
				v.elementAt(++j); //Usuario cajero
				v.elementAt(++j); //Usuario
				v.elementAt(++j); //Codigo cliente
				v.elementAt(++j); //Codigo caja
				v.elementAt(++j); //nombre caja
				
			}else{
				
				mantTiendaVO.setNomTienda(v.elementAt(++j)); //Nombre tienda
				mantTiendaVO.setUsuaVendedor(v.elementAt(++j)); //Usuario vendedor
				mantTiendaVO.setUsuacajero(v.elementAt(++j)); //Usuario cajero
				mantTiendaVO.setUsuaTien(v.elementAt(++j)); //Usuario
				mantTiendaVO.setCodCliente(v.elementAt(++j)); //Codigo cliente
				mantTiendaVO.setCodCaja(v.elementAt(++j)); //Codigo caja
				mantTiendaVO.setDesCaja(v.elementAt(++j)); //nombre caja
			}
			
			//Se agrega el articulo a la lista
			listaTienda.add(mantTiendaVO);
			
			//Se elimina la referencia
			mantTiendaVO = null;
			
		}
		
		//Se elimina la referencia
		v = null;
		
		return listaTienda;
		
	}*/
	
	/*
	 * Metodo: buscarTienLista
	 * Descripción: busca en la lista de tienda, si ya existe el que se desea agregar (String nomTien).
	 * Fecha: 08/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	private Boolean buscarTienLista(List<MantTiendaVO> listaTienda, String nomTien){
		
		Boolean estadoTien = true;
		
		nomTien = nomTien.toUpperCase();
		
		for (Iterator<MantTiendaVO> iterator = listaTienda.iterator(); iterator.hasNext();) {
			MantTiendaVO mantTiendaVO = (MantTiendaVO) iterator.next();
			
			//Si el nombre se encuentra en la lista no permite agregar
			if( nomTien.equals(mantTiendaVO.getNomTienda().toUpperCase()) ){
				estadoTien = false;
				break;
			}
		}
		
		return estadoTien;
		
	}
	
	private Boolean buscarTienModLista(List<MantTiendaVO> listaTienda, String nomTien, String codTienda){
		
		Boolean estadoTien = true;
		
		nomTien = nomTien.toUpperCase();
		
		for (Iterator<MantTiendaVO> iterator = listaTienda.iterator(); iterator.hasNext();) {
			MantTiendaVO mantTiendaVO = (MantTiendaVO) iterator.next();
			
			//Si el nombre se encuentra en la lista no permite agregar
			if( nomTien.equals(mantTiendaVO.getNomTienda().toUpperCase())&&!codTienda.equals(mantTiendaVO.getCodTienda().toUpperCase()) ){
				estadoTien = false;
				break;
			}
		}
		
		return estadoTien;
		
	}
	
	
	
private Boolean validarModificacion(List<MantTiendaVO> listaTienda, MantenedorTiendaForm form){
		
		Boolean estadoTien = false;
		
		for (Iterator<MantTiendaVO> iterator = listaTienda.iterator(); iterator.hasNext();) {
			MantTiendaVO mantTiendaVO = (MantTiendaVO) iterator.next();
			String valAnt=mantTiendaVO.getIndApliPago();
			
			if( form.getCodTienda().equalsIgnoreCase(mantTiendaVO.getCodTienda()) ){
				
				String indPago="1".equals(form.getIndApliPago().trim())?"SI":"NO";

				if(!form.getNomTienda().equalsIgnoreCase(mantTiendaVO.getNomTienda()))
					estadoTien = true;
				else if(!form.getUsuaVendedor().equalsIgnoreCase(mantTiendaVO.getUsuaVendedor()))
					estadoTien = true;
				else if(!form.getUsuacajero().equalsIgnoreCase(mantTiendaVO.getUsuacajero()))
					estadoTien = true;
				else if(!form.getCodClienteTien().equalsIgnoreCase(mantTiendaVO.getCodCliente()))
					estadoTien = true;
				else if(!form.getCodCaja().equalsIgnoreCase(mantTiendaVO.getCodCaja()))
					estadoTien = true;		
				else if(!indPago.equalsIgnoreCase(mantTiendaVO.getIndApliPago()))
					estadoTien = true;
				break;
			}
		}
		
		return estadoTien;
		
	}
	
	
	/*
	 * Metodo: transformaArrayToList
	 * Descripción: traspasa de un TiendaDTO[] a List<MantTiendaVO>
	 * Fecha: 11/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	private List<MantTiendaVO> transformaArrayToList(TiendaDTO[] tiendaDTO){

		List<MantTiendaVO> listaTienda =  new ArrayList<MantTiendaVO>();
		
		int largo = tiendaDTO.length;
		
		for (int i = 0; i < largo; ++i) {
			
			MantTiendaVO mantTiendaVO =  new MantTiendaVO();
			mantTiendaVO.setCodTienda(tiendaDTO[i].getCodTienda()); //Codigo tienda
			mantTiendaVO.setNomTienda(tiendaDTO[i].getDesTienda()); //Nobre de la tienda
			mantTiendaVO.setUsuaVendedor(tiendaDTO[i].getNomUsuarioVendedor()); //Usuario vendedor
			mantTiendaVO.setUsuacajero(tiendaDTO[i].getNomUsuarioCajero()); //Usuario Cajero
			mantTiendaVO.setUsuaTien(tiendaDTO[i].getNomUsuario()); //Usuario de la tienda
			mantTiendaVO.setCodCliente(tiendaDTO[i].getCodCliente()); //Codigo cliente
			mantTiendaVO.setCodCaja(tiendaDTO[i].getCodCaja()); //Codigo caja
			mantTiendaVO.setDesCaja(tiendaDTO[i].getDesCaja()); //nombre caja
			mantTiendaVO.setIndApliPago("1".equals(tiendaDTO[i].getIndApliPago().trim()) ? "SI" : "NO");//Aplica Pago
			
			//Se agrega a la lista
			listaTienda.add(mantTiendaVO);
			
			//elimina la referencia
			mantTiendaVO = null;
		}
		
		return listaTienda;
		
	}

	/*
	 * Metodo: trapasarObjetos
	 * Descripción: traspasa de un MantTiendaVO a TiendaDTO
	 * Fecha: 11/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	private TiendaDTO trapasarObjetos(MantTiendaVO mantTiendaVO){
		
		TiendaDTO tiendaDTO = new TiendaDTO();
		
		tiendaDTO.setCodTienda(mantTiendaVO.getCodTienda());
		tiendaDTO.setDesTienda(mantTiendaVO.getNomTienda());
		tiendaDTO.setNomUsuarioVendedor(mantTiendaVO.getUsuaVendedor());
		tiendaDTO.setNomUsuarioCajero(mantTiendaVO.getUsuacajero());
		tiendaDTO.setNomUsuario(mantTiendaVO.getUsuaTien());
		tiendaDTO.setCodCliente(mantTiendaVO.getCodCliente());
		tiendaDTO.setCodCaja(mantTiendaVO.getCodCaja());
		tiendaDTO.setDesCaja(mantTiendaVO.getDesCaja());
		tiendaDTO.setIndApliPago(mantTiendaVO.getIndApliPago());
		
		return tiendaDTO;
		
	}
	
	/*
	 * Metodo: splitList
	 * Descripción: 
	 * Fecha: 14/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	/*public Vector<String> splitList(String str, String delims, String delimsInterno){

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
	
	}*/
	
	/*
	 * Metodo: splitString
	 * Descripción: 
	 * Fecha: 14/06/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	/*public static String[] splitString(String str, String delims){

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
