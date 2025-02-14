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

import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;

import org.apache.log4j.Logger;
import org.apache.commons.configuration.CompositeConfiguration;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;

public class CargaClienteComboAction extends Action {

	private CompositeConfiguration config; // MA
	private static Logger logger = Logger.getLogger(CargaClienteComboAction.class); // MA
	
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
		
		setPropertieFile();
		
		logger.debug("CargaClienteComboAction execute"); // MA

		ArrayList listaClienteAsociaCargada = new ArrayList();
		ArrayList listaNuevaComboCli = new ArrayList();
		ArrayList listaCliChequeados = new ArrayList();
		HttpSession session = request.getSession();
		String itemChequeadosCli[] = null;

		itemChequeadosCli = request.getParameterValues("itemChequeadosCli") != null ? request
				.getParameterValues("itemChequeadosCli")
				: null;
		listaNuevaComboCli = (ArrayList) session
				.getAttribute("listaClienteAsociaCargada");// lista del combo
															// cliente

		String fila = "";
		
		logger.debug("itemChequeadosCli" + itemChequeadosCli.length); // MA
		
		for (int j = 0; j < itemChequeadosCli.length; j++) {

			logger.debug("Fila:"+j); //MA
			
			ClienteDTO clienteDTO = new ClienteDTO();
			fila = itemChequeadosCli[j];
			StringTokenizer st = new StringTokenizer(fila, "|");
			clienteDTO.setCodCliente(Long.parseLong(st.nextToken()));
			clienteDTO.setNomCliente(st.nextToken());
			clienteDTO.setNumIdent(st.nextToken());
			
			logger.debug("setCodCliente"+clienteDTO.getCodCliente()); // MA
			logger.debug("setNomCliente"+clienteDTO.getNomCliente()); // MA
			logger.debug("setNumIdent"+clienteDTO.getNumIdent()); // MA
			
			if (st.hasMoreTokens()) {
				clienteDTO.setNomApeClien1(st.nextToken());
			} else {
				clienteDTO.setNomApeClien1("");
			}
			if (st.hasMoreTokens()) {
				clienteDTO.setNomApeClien2(st.nextToken());
			} else {
				clienteDTO.setNomApeClien2("");
			}
			
			listaCliChequeados.add(clienteDTO);
		}

		if (listaNuevaComboCli != null) {
			String repetidoCli = "";
			int largoListaCombo = 0;
			int largoListaCheq = 0;
			int cont;

			// ----------lista que de clientes
			// chequeados-------------------------//
			Iterator mostIt1 = listaCliChequeados.iterator();
			ClienteDTO dto1 = null;
			boolean bandera = false;
			while (mostIt1.hasNext()) {
				cont = 0;
				largoListaCombo = listaNuevaComboCli.size();
				dto1 = (ClienteDTO) mostIt1.next();

				// lista que viene del combo-------------------------//

				Iterator mostIt2 = listaNuevaComboCli.iterator();
				ClienteDTO dto2 = null;

				while (mostIt2.hasNext()) {
					dto2 = (ClienteDTO) mostIt2.next();

					if (dto2.getCodCliente() == dto1.getCodCliente()) {
						repetidoCli = "clienAsociadoRepetido";

					} else {

						repetidoCli = "clienAsociadoNoRepetido";
						cont = cont + 1;
					}
				}
				if (largoListaCombo == cont) {

					listaNuevaComboCli.add(dto1);

				} else {
					bandera = true;
				}

			}

			if (bandera == true) {
				request.setAttribute("repetidoCli", "repetidoCli");
				session.setAttribute("listaClienteAsociaCargada",
						listaNuevaComboCli);
			} else {

				session.setAttribute("listaClienteAsociaCargada",listaNuevaComboCli);

			}

		} else {

			session.removeAttribute("listaClienteAsociados");
			session.setAttribute("listaClienteAsociaCargada",
					listaCliChequeados);

		}

		return mapping.findForward("sucessAgreCli");

	}

}
