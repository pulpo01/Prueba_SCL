package com.tmmas.scl.doblecuenta.action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;



public class CargaComboAction extends Action {
	
	private CompositeConfiguration config;
	
	private static Logger logger = Logger.getLogger(DobleCuentaWebAction.class); // MA
	
	private void setPropertieFile() {
//		  inicio MA
		     String strRuta = "/com/tmmas/cl/DobleCuentaWeb/web/properties/";
		     String srtRutaDeploy = System.getProperty("user.dir");
		     String strArchivoProperties= "DobleCuentaWeb.properties";
		     String strArchivoLog="DobleCuentaWeb.log";
		     String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
		     config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		     UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		     // fin MA           
		}
	

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		
		setPropertieFile(); // MA
		
		logger.debug("CargaComboAction execute"); // MA

		//ArrayList listaAbonaCarg = new ArrayList();
		ArrayList listaNuevaCombo2 = new ArrayList();
		ArrayList listaAbonChequeados = new ArrayList();
		HttpSession session = request.getSession();
		String itemChequeados[] = null;

		listaNuevaCombo2 = (ArrayList) session
				.getAttribute("listaAbonadosCargada");// lista del combo
		itemChequeados = request.getParameterValues("itemChequeados") != null ? request
				.getParameterValues("itemChequeados")
				: null;

		String fila = "";
		
		logger.debug("itemChequeados:"+itemChequeados.length);//MA
		
		for (int j = 0; j < itemChequeados.length; j++) {
			AbonadoDTO abonadoDTO = new AbonadoDTO();
			fila = itemChequeados[j];
			StringTokenizer st = new StringTokenizer(fila, "|");
			if (st.hasMoreTokens()) {
				
				logger.debug("Fila:"+j); //MA
				
				
				abonadoDTO.setNumAbonado(st.nextToken());
				abonadoDTO.setNumCelular(st.nextToken());
				abonadoDTO.setNomUsuario(st.nextToken());
				abonadoDTO.setNomApellido1(st.nextToken());
				
				logger.debug("setNumAbonado"+abonadoDTO.getNumAbonado()); //MA
				logger.debug("setNumCelular"+abonadoDTO.getNumCelular()); //MA
				logger.debug("setNomUsuario"+abonadoDTO.getNomUsuario()); //MA
				logger.debug("setNomApellido1"+abonadoDTO.getNomApellido1()); //MA
				
				listaAbonChequeados.add(abonadoDTO);
			}
		}

		if (listaNuevaCombo2 != null) {
			String repetido = "";
			int largoListaCombo = 0;
			int largoListaCheq = 0;
			int cont;

			// ----------lista que viene del los clientes
			// chequeados-------------------------//
			Iterator mostIt1 = listaAbonChequeados.iterator();
			AbonadoDTO dto1 = null;
			boolean bandera = false;
			while (mostIt1.hasNext()) {
				cont = 0;
				largoListaCombo = listaNuevaCombo2.size();
				dto1 = (AbonadoDTO) mostIt1.next();

				// lista que viene del combo -------------------------//

				Iterator mostIt2 = listaNuevaCombo2.iterator();
				AbonadoDTO dto2 = null;

				while (mostIt2.hasNext()) {
					dto2 = (AbonadoDTO) mostIt2.next();

					if (dto2.getNumCelular().equals(dto1.getNumCelular())) {
						repetido = "clienRepetido";

					} else {

						repetido = "clienNoRepetido";
						cont = cont + 1;
					}
				}
				if (largoListaCombo == cont) {
					listaNuevaCombo2.add(dto1);

				} else {
					bandera = true;
				}

			}

			if (bandera == true) {
				request.setAttribute("repetido", "repetido");
				session.setAttribute("listaAbonadosCargada", listaNuevaCombo2);
			} else {

				session.setAttribute("listaAbonadosCargada", listaNuevaCombo2);
			}

		} else {

			session.removeAttribute("listaAbonados");
			session.setAttribute("listaAbonadosCargada", listaAbonChequeados);
		}

		return mapping.findForward("sucessAgreA");
	}

}

