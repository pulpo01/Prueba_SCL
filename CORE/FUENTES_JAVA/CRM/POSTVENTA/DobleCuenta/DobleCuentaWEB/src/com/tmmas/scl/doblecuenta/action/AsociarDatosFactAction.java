package com.tmmas.scl.doblecuenta.action;

import java.util.ArrayList;
import java.util.Iterator;

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
import com.tmmas.scl.doblecuenta.form.FacturacionDTO;
import com.tmmas.scl.doblecuenta.form.FacturacionDifForm;

public class AsociarDatosFactAction extends Action{
	
	private CompositeConfiguration config; // MA
	private static Logger logger = Logger.getLogger(AsociarDatosFactAction.class);
	
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
		
		logger.debug("AsociarDatosFactAction execute");//MA
		
		String asociar="";
		String idOperacion="";
		String idModalidad="";
		String idTipoValor="";
		String idConceptos="";
		String valor="";
		String idAbonado="";
		String idClienteAsociado="";
		String descripOperacion="";
		String descModalidad="";
		String descConcepto="";
		String descTipoValor="";
		String descAbonado="";
		String descClienAsociado="";
		String activ = "";
		HttpSession session = request.getSession();
		FacturacionDifForm factDifForm = (FacturacionDifForm)form;
    //-----llamada al servicio para asociar datos--------------------------------------------------------------------
	
	String countTipoV = (String) request.getParameter("count"); // Contador tipo valor desde web
	ArrayList listaGrilla = session.getAttribute("listaGrilla")!=null?(ArrayList)session.getAttribute("listaGrilla"):new ArrayList();
	ArrayList listaAbonadosCargada = session.getAttribute("listaAbonadosCargada")!=null?(ArrayList)session.getAttribute("listaAbonadosCargada"):new ArrayList();
	activ=factDifForm != null ? factDifForm. getActivarChec() : "";
	
	asociar = factDifForm != null ? factDifForm.getAsociarDat(): "";
	if (("asoc").equals(asociar)){
		
		
		FacturacionDTO factDTO = new FacturacionDTO();
		idOperacion= factDifForm != null ? factDifForm.getOperacion(): "";
		idModalidad= factDifForm != null ? factDifForm.getModalidad() : "";
		idTipoValor=factDifForm != null ? factDifForm.getTipoValor(): "";
		idConceptos=factDifForm != null ? factDifForm.getConcepto() : "";
		valor=factDifForm != null ? factDifForm.getValor() : "";
		idAbonado=factDifForm != null ? factDifForm.getAbonado() : "";
		idClienteAsociado=factDifForm != null ? factDifForm.getClienteAsociado(): "";
		
		descripOperacion=factDifForm != null ? factDifForm.getDescripOperacion(): "";
		descModalidad=factDifForm != null ? factDifForm.getDescModalidad(): "";
		descConcepto=factDifForm != null ? factDifForm.getDescConcepto(): "";
		descTipoValor=factDifForm != null ? factDifForm.getDescTipoValor(): "";
		descAbonado=factDifForm != null ? factDifForm.getDescAbonado(): "";
		descClienAsociado=factDifForm != null ? factDifForm.getDescClienAsociado(): "";
		
		String abonadoRep="rep";
		int respuesta = 0;
		respuesta = this.validaAbonRepetidoEnGrilla(idAbonado, idConceptos,session);
		  if(respuesta > 0){
			  
			  request.setAttribute("abonadoRep","abonadoRep");	  
		  }else{
			  
			  
			    logger.debug("setCodigoOperacion:"+idOperacion); // MA
			    logger.debug("setCodigoModalidad:"+idModalidad); // MA
			    logger.debug("setCodigoTipoValor:"+idTipoValor); // MA
			    logger.debug("setCodigoConcepto:"+idConceptos); // MA
			    logger.debug("setValor:"+valor); // MA
			    logger.debug("setCodigoAbonado:"+idAbonado); // MA
			    logger.debug("setCodClienAsociado:"+idClienteAsociado); // MA
			    logger.debug("setDescripOperacion:"+descripOperacion); // MA
			    logger.debug("setDescModalidad:"+descripOperacion); // MA
			    logger.debug("setDescConcepto:"+descConcepto); // MA
			    logger.debug("setDescTipoValor:"+descTipoValor); // MA
			    logger.debug("setDescClienAsociado:"+descClienAsociado); // MA
			    logger.debug("setDescAbonado:"+descAbonado); // MA
			  
			    factDTO.setCodigoOperacion(idOperacion);
				factDTO.setCodigoModalidad(idModalidad);
				factDTO.setCodigoTipoValor(idTipoValor);
				factDTO.setCodigoConcepto(idConceptos);
				factDTO.setValor(valor);
				factDTO.setCodigoAbonado(idAbonado);
				factDTO.setCodClienAsociado(idClienteAsociado);
				factDTO.setDescripOperacion(descripOperacion);
				factDTO.setDescModalidad(descModalidad);
				factDTO.setDescConcepto(descConcepto);
				factDTO.setDescTipoValor(descTipoValor);
				factDTO.setDescClienAsociado(descClienAsociado);
				factDTO.setDescAbonado(descAbonado);
				factDTO.setEstadoListaFact("listaNueva");
				listaGrilla.add(factDTO);
			    
		  }
	session.setAttribute("idTipoValor",idTipoValor);	  
	session.setAttribute("countTipoV",countTipoV);
//Inicio INC|62580|03-04-2008|MMC
    session.setAttribute("idModalidad", idModalidad);
//Fin INC|62580|03-04-2008|MMC	
	}
	request.setAttribute("activ","activ");
	session.setAttribute("listaGrilla", listaGrilla);
	return mapping.findForward("sucessGri");
}

	
	
public int validaAbonRepetidoEnGrilla(String idAbonado, String idConceptos,HttpSession session)
	{	
	    
		ArrayList listaGrillaDesplegada=new ArrayList();
		listaGrillaDesplegada=(ArrayList)session.getAttribute("listaGrilla");
		
		int SiRepetido = 0;
		int NoRepetido = 0;
		
		String numAbon="";
		String concep="";
		if(listaGrillaDesplegada!=null)
		{
			Iterator it=listaGrillaDesplegada.iterator();
			FacturacionDTO facturaDTO = new FacturacionDTO();
			
		 while(it.hasNext())
			{
			 facturaDTO=(FacturacionDTO)it.next();
				numAbon=String.valueOf(facturaDTO.getCodigoAbonado());	
				concep=String.valueOf(facturaDTO.getCodigoConcepto());
				if(idAbonado.equals(numAbon) && concep.equals(idConceptos))
				 {
					SiRepetido++;
				 }else{
					 
					NoRepetido++; 
				 }
			}
		}
		return SiRepetido;
	}		

}
