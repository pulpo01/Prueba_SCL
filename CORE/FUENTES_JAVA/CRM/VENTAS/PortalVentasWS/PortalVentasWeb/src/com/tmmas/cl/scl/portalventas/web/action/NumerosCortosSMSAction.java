package com.tmmas.cl.scl.portalventas.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioNumerosSMSDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.NumerosCortosSMSForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

public class NumerosCortosSMSAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(NumerosFrecuentesAction.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();	
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("inicio, inicio");
		NumerosCortosSMSForm numerosCortosForm = (NumerosCortosSMSForm) form;
		numerosCortosForm.setLargoNumero(global.getValorExterno("largo.numeros.sms"));
		numerosCortosForm.setMaximoNumeros(global.getValorExterno("maximo.numeros.sms"));		
		logger.info("inicio, fin");
		
		return mapping.findForward("inicio");
	}	
	
	public ActionForward actualizarListaNumeros(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		logger.info("actualizarListaNumeros");

		NumerosCortosSMSForm numerosCortosForm = (NumerosCortosSMSForm) form;
 		String numeroCorto = numerosCortosForm.getNumCortoPos();

		if (numeroCorto.equals("0"))
		{// agregar a lista
			int totalLista = 0;
			int numRef = 0;
			if (numerosCortosForm.getArrayNumeros() == null
					|| numerosCortosForm.getArrayNumeros().length == 0)
			{
				numRef = 1;
			}
			else
			{
				totalLista = numerosCortosForm.getArrayNumeros().length;
				numRef = totalLista + 1;
			}
			
			FormularioNumerosSMSDTO refNueva = new FormularioNumerosSMSDTO();
			refNueva.setNumeroCortoValor(Long.valueOf(numerosCortosForm.getNumeroCortoValor()).longValue());
			refNueva.setNumCortoPos(String.valueOf(numRef));
			
			FormularioNumerosSMSDTO[] arrayNumerosNuevo = new FormularioNumerosSMSDTO[totalLista + 1];
			for (int i = 0; i < totalLista; i++)
				arrayNumerosNuevo[i] = numerosCortosForm.getArrayNumeros()[i];

			int posUltFila = totalLista;
			arrayNumerosNuevo[posUltFila] = refNueva;
			numerosCortosForm.setArrayNumeros(arrayNumerosNuevo);

		}
		else
		{// modificar
			for (int i = 0; i < numerosCortosForm.getArrayNumeros().length; i++)
			{
				FormularioNumerosSMSDTO ref = numerosCortosForm.getArrayNumeros()[i];
				if (ref.equals(numeroCorto))
				{
					ref.setNumeroCortoValor(Long.valueOf(numerosCortosForm.getNumeroCortoValor()).longValue());				
				}
			}
		}

		// limpia campos
		numerosCortosForm.setNumCortoPos("0");		
		logger.info("actualizarListaNumeros");
		return mapping.findForward("inicio");
	}

	public ActionForward eliminarNumero(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		logger.info("eliminarNumero");

		NumerosCortosSMSForm numerosCortosSMSForm = (NumerosCortosSMSForm) form;
		String numSMS = numerosCortosSMSForm.getNumCortoPos();

		int totalLista = numerosCortosSMSForm.getArrayNumeros().length;
		int totalNuevaLista = totalLista - 1;
		FormularioNumerosSMSDTO[] arrayNumerosNuevo = new FormularioNumerosSMSDTO[(totalNuevaLista)];
		int correlativo = 1;
		int indiceNuevaLista = 0;
		for (int i = 0; i < totalLista; i++)
		{
			if (!numerosCortosSMSForm.getArrayNumeros()[i].getNumCortoPos().equals(numSMS))
			{
				arrayNumerosNuevo[indiceNuevaLista] = numerosCortosSMSForm.getArrayNumeros()[i];
				arrayNumerosNuevo[indiceNuevaLista].setNumCortoPos(String.valueOf(correlativo));
				indiceNuevaLista++;
				correlativo++;
			}
		}

		numerosCortosSMSForm.setArrayNumeros(arrayNumerosNuevo);
		// limpia campos
		numerosCortosSMSForm.setNumCortoPos("0");
		numerosCortosSMSForm.setNumeroCortoValor("");
		
		logger.info("eliminarNumero");
		return mapping.findForward("inicio");
	}
	
	public ActionForward aceptar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		logger.info("aceptar");
		NumerosCortosSMSForm numerosCortosSMSForm = (NumerosCortosSMSForm) form;
		HttpSession sesion = request.getSession(false);

		DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
		if (datosLineaForm != null)
		{
			datosLineaForm.setArrayNumerosSms(numerosCortosSMSForm.getArrayNumeros());
		}
		
		logger.info("aceptar");
		return mapping.findForward("aceptar");
	}
	
	public ActionForward cancelar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		logger.info("cancelar");
		NumerosCortosSMSForm numerosCortosSMSForm = (NumerosCortosSMSForm) form;
		numerosCortosSMSForm.setArrayNumeros(null);
		logger.info("cancelar");
		return mapping.findForward("cancelar");
	}
}
