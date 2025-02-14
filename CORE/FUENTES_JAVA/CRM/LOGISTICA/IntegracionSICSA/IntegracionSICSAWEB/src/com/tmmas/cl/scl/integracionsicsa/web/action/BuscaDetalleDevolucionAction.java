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

import com.tmmas.cl.scl.integracionsicsa.common.dto.DetalleDevolucionDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DetallePedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.web.form.BuscaDetalleDevolucionForm;
import com.tmmas.cl.scl.integracionsicsa.web.helper.IntegracionSICSAServiceLocator;

public class BuscaDetalleDevolucionAction extends Action {
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
		logger.debug("inicio: BuscaDetalleDevolucionAction", nombreClase);
		try {

			BuscaDetalleDevolucionForm form = (BuscaDetalleDevolucionForm) p_form;
			HttpSession session = request.getSession();
			
			if("buscarDetalle".equals(form.getOpcion())){
				logger.debug("opcion: " + form.getOpcion(),nombreClase);
				
				logger.debug("getCodDevolucionBusc(): " + form.getCodDevolucionBusc(),nombreClase);
				
				integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
				integracionSICSALocal = integracionSICSAServiceLocator.getIntegracionSICSALocal();
				
				
				HashMap mapDetallesDevoluciones = (HashMap) session.getAttribute("mapDetallesDevoluciones");
					
				if(null==mapDetallesDevoluciones){
					logger.debug("mapDetallesDevoluciones=NULL",nombreClase);
					mapDetallesDevoluciones = new HashMap();
				}
				
				if(!mapDetallesDevoluciones.containsKey(form.getCodDevolucionBusc())){
					logger.debug("!mapDetallesDevoluciones.containsKey",nombreClase);
					mapDetallesDevoluciones=integracionSICSALocal.consultarDetalleDevolucionUsuario(form.getCodDevolucionBusc(), mapDetallesDevoluciones);
				}				
				
				if(mapDetallesDevoluciones.containsKey((form.getCodDevolucionBusc()))){
					ArrayList lista = (ArrayList) mapDetallesDevoluciones.get(form.getCodDevolucionBusc());
					DetalleDevolucionDTO[] detalleDevolucionDTO = (DetalleDevolucionDTO[]) copiaArregloTipoEspecifico(lista.toArray(), DetalleDevolucionDTO.class);
					
					if(detalleDevolucionDTO.length>0){
						request.setAttribute("detalleDevolucionDTO", detalleDevolucionDTO);
					}
					
										  
				}
				request.setAttribute("codDevolucion", form.getCodDevolucionBusc());
				session.setAttribute("mapDetallesDevoluciones",mapDetallesDevoluciones);
				target = "detDevolucion";
				
			}			
			else if("exportarTXT".equals(form.getOpcion())){
				//CODIGO PARA EXPORTAR
				logger.debug("Exportar a TXT inicio",nombreClase);
				
				logger.debug("form.getCodDevolucionBusc()"+form.getCodDevolucionBusc(),nombreClase);
				
				HashMap mapDetallesDevoluciones = (HashMap) session.getAttribute("mapDetallesDevoluciones");
				ArrayList lista = (ArrayList) mapDetallesDevoluciones.get(form.getCodDevolucionBusc());
				
				ByteArrayOutputStream  baos = new ByteArrayOutputStream();  
				BufferedWriter bwr = new BufferedWriter(new OutputStreamWriter(baos));
				DetalleDevolucionDTO detalleDevolucionDTO= null;
				
				for(int i=0;i<=lista.size()-1;i++){
					detalleDevolucionDTO = (DetalleDevolucionDTO)lista.get(i);
					bwr.write(detalleDevolucionDTO.getSerie());
					bwr.newLine();
				}
				bwr.close();
				String nomTxt = "Devolucion_"+form.getCodDevolucionBusc()+".txt";
				request.setAttribute("nomTxt",nomTxt);
				request.setAttribute("array", baos.toByteArray());
				target="generarTXT";
				logger.debug("Exportar a TXT fin",nombreClase);
			}
		else if("volver".equals(form.getOpcion())){
			//CODIGO PARA EXPORTAR
			logger.debug("Volver a devoluciones",nombreClase);
			target="devoluciones";

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
		logger.debug("fin: BuscaDetalleDevolucionAction", nombreClase);
		return mapping.findForward(target);
	}
	
    public static Object copiaArregloTipoEspecifico(Object[] aOrig, Class type) {
		Object copy = Array.newInstance(type, aOrig.length);
		System.arraycopy(aOrig, 0, copy, 0, aOrig.length);
		return copy;
	}

}
