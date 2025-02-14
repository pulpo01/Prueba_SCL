package com.tmmas.cl.scl.integracionsicsa.web.action;

import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.OutputStreamWriter;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.scl.integracionsicsa.common.dto.DetallePedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.web.form.BuscaDetallePedidoForm;
import com.tmmas.cl.scl.integracionsicsa.web.helper.IntegracionSICSAServiceLocator;

public class BuscaDetallePedidoAction extends Action {
	/**
	 *@author H.O.M
	 */
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;

	private static final long serialVersionUID = 1L;
	String target = new String();

	public ActionForward execute(ActionMapping mapping, ActionForm p_form,
			HttpServletRequest request, HttpServletResponse response) {
		logger.debug("inicio: BuscaDetallePedidoAction", nombreClase);
		try {

			BuscaDetallePedidoForm form = (BuscaDetallePedidoForm) p_form;
			HttpSession session = request.getSession();
			
			if("mostrarSeries".equals(form.getOpcion())){
				logger.debug("opcion: " + form.getOpcion(),nombreClase);
				
				logger.debug("getLinPedidoBusc(): " + form.getLinPedidoBusc(),nombreClase);
				logger.debug("getCodPedidoBusc(): " + form.getCodPedidoBusc(),nombreClase);
				
				HashMap mapSeries = (HashMap) session.getAttribute("mapSeries");
				
				if(null==mapSeries){
					logger.debug("mapSeries=NULL",nombreClase);
					mapSeries = new HashMap();
				}
				
				if(!mapSeries.containsKey(form.getLinPedidoBusc()+form.getCodPedidoBusc())){
					logger.debug("!mapSeries.containsKey",nombreClase);
					mapSeries=integracionSICSALocal.consultarSeriePedidosUsuario(form.getCodPedidoBusc(),form.getLinPedidoBusc(), mapSeries);
				}
				
				if(mapSeries.containsKey(form.getLinPedidoBusc()+form.getCodPedidoBusc())){
					ArrayList lista = (ArrayList) mapSeries.get(form.getLinPedidoBusc()+form.getCodPedidoBusc());
					
					SerieDTO[] serieDTO = (SerieDTO[]) copiaArregloTipoEspecifico(lista.toArray(), SerieDTO.class);	
					
					if(serieDTO.length>0){
						request.setAttribute("serieDTO", serieDTO);
					}
				}
				
				session.setAttribute("mapSeries",mapSeries);
				
				target = "mostrarSeries";
				
				
			}else if("buscarDetalle".equals(form.getOpcion())){
				logger.debug("opcion: " + form.getOpcion(),nombreClase);
				
				logger.debug("getCodPedidoBusc(): " + form.getCodPedidoBusc(),nombreClase);
				
				integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
				integracionSICSALocal = integracionSICSAServiceLocator.getIntegracionSICSALocal();
				
				
				HashMap mapDetallesPedidos = (HashMap) session.getAttribute("mapDetallesPedidos");
					
				if(null==mapDetallesPedidos){
					logger.debug("mapDetallesPedidos=NULL",nombreClase);
					mapDetallesPedidos = new HashMap();
				}
				
				if(!mapDetallesPedidos.containsKey(form.getCodPedidoBusc())){
					logger.debug("!mapDetallesPedidos.containsKey",nombreClase);
					mapDetallesPedidos=integracionSICSALocal.consultarDetallePedidosUsuario(form.getCodPedidoBusc(), mapDetallesPedidos);
				}				
				
				if(mapDetallesPedidos.containsKey((form.getCodPedidoBusc()))){
					ArrayList lista = (ArrayList) mapDetallesPedidos.get(form.getCodPedidoBusc());
					DetallePedidoDTO[] detallePedidoDTO = (DetallePedidoDTO[]) copiaArregloTipoEspecifico(lista.toArray(), DetallePedidoDTO.class);
					
					if(detallePedidoDTO.length>0){
						request.setAttribute("detallePedidoDTO", detallePedidoDTO);
					}
					
										  
				}
				request.setAttribute("codPedido", form.getCodPedidoBusc());
				session.setAttribute("mapDetallesPedidos",mapDetallesPedidos);
				target = "detPedido";
				
			}			
			else if("exportarTXT".equals(form.getOpcion())){
				//CODIGO PARA EXPORTAR
				logger.debug("Exportar a TXT inicio",nombreClase);
				
				logger.debug("form.getLinPedidoBusc()+form.getCodPedidoBusc()"+form.getLinPedidoBusc()+form.getCodPedidoBusc(),nombreClase);
				
				HashMap mapSeries = (HashMap) session.getAttribute("mapSeries");
				ArrayList lista = (ArrayList) mapSeries.get(form.getLinPedidoBusc()+form.getCodPedidoBusc());
				
				ByteArrayOutputStream  baos = new ByteArrayOutputStream();  
				BufferedWriter bwr = new BufferedWriter(new OutputStreamWriter(baos));
				SerieDTO serieDTO = null;
				
				for(int i=0;i<=lista.size()-1;i++){
					serieDTO = (SerieDTO)lista.get(i);
					bwr.write(serieDTO.getNumSerie());
					bwr.newLine();
				}
				bwr.close();
				String nomTxt = "Pedido_"+form.getCodPedidoBusc()+"-Articulo_"+form.getNomArticulo()+".txt";
				request.setAttribute("nomTxt",nomTxt);
				request.setAttribute("array", baos.toByteArray());
				target="generarTXT";
				logger.debug("Exportar a TXT fin",nombreClase);
			}
		else if("volver".equals(form.getOpcion())){
			//CODIGO PARA EXPORTAR
			logger.debug("Volver a pedidos",nombreClase);
			target="pedidos";

		}
		} catch (IntegracionSICSAException e) {
			target = "globalError";
			request.setAttribute("desError", e.getDescripcionEvento());
			logger.error(e, nombreClase);
		} catch (Exception e) {
			target = "globalError";
			request.setAttribute("desError",
			"Se ha producido un error no clasificado.");
			logger.error(e, nombreClase);
		}
		logger.debug("fin: BuscaDetallePedidoAction", nombreClase);
		return mapping.findForward(target);
	}
	
    public static Object copiaArregloTipoEspecifico(Object[] aOrig, Class type) {
		Object copy = Array.newInstance(type, aOrig.length);
		System.arraycopy(aOrig, 0, copy, 0, aOrig.length);
		return copy;
	}

}
