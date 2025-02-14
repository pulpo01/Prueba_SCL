package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoNumerosFrecuentesDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteTipoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CambiarPlanForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.NumerosFrecuentesCPUForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

/**
 * @author santiago
 *
 */
public class NumerosFrecuentesCPUAction extends Action {
	
	private final Logger logger = Logger.getLogger(ControlFlujoCPUAction.class);
	private Global global = Global.getInstance();
	String  CLASS_NAME = "NumerosFrecuentesCPUAction ";
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(true);
		log2(CLASS_NAME+" Dentro del Action NumerosFrecuentesCPUAction");		
			
	    NumerosFrecuentesCPUForm numFrecform = null;
	    numFrecform = (NumerosFrecuentesCPUForm)form;
	    
	    String paginaRegreso = (String) session.getAttribute("paginaRegreso");
	    
	    if (numFrecform.getCancelaNumFrec().equals("volver")) {
	    	return mapping.findForward(paginaRegreso);
	    } 
	    else {
	    	System.out.println("Se va actualizar la lista");
	    }
							
		try {
			actualizarListFrecuentes (numFrecform, session);
			log2(CLASS_NAME+" actualizar");
		} catch (Throwable e) {				
			e.printStackTrace();
		}			
		return mapping.findForward(paginaRegreso);
	}
	
	public void actualizarListFrecuentes (NumerosFrecuentesCPUForm form, HttpSession session) throws Throwable {
		log2(CLASS_NAME+" actualizarListFrecuentes");
		String numFrecArr = null;
		String tiposNumArr = null;
		String codTiposNumArr = null;	
		
		String arrayNumFrecArr[] = null;
		String arrayTiposNumArr[] = null;
		String arrayCodTiposNumArr[] = null;
		if (form.getNumFrecArr().equals("")&&form.getTiposNumArr().equals("")&&form.getCodTiposNumArr().equals("")) {
			arrayNumFrecArr = new String[0];
			arrayTiposNumArr = new String[0];
			arrayCodTiposNumArr = new String[0];			
		} else {
			numFrecArr = form.getNumFrecArr();
			tiposNumArr = form.getTiposNumArr();
			codTiposNumArr = form.getCodTiposNumArr();
			
			arrayNumFrecArr = numFrecArr.split(",");
			arrayTiposNumArr = tiposNumArr.split(",");
			arrayCodTiposNumArr = codTiposNumArr.split(",");			
		}						
		
		log2(CLASS_NAME+" numFrecArr: "+numFrecArr);
		log2(CLASS_NAME+" tiposNumArr: "+tiposNumArr);
		log2(CLASS_NAME+" codTiposNumArr: "+codTiposNumArr);
		
		log2(CLASS_NAME+" arrayNumFrecArr.length: "+arrayNumFrecArr.length);
		log2(CLASS_NAME+" arrayTiposNumArr.length: "+arrayTiposNumArr.length);
		log2(CLASS_NAME+" arrayCodTiposNumArr.length: "+arrayCodTiposNumArr.length);
		
		int contadorMov = 0;
		int contadorFij = 0;
		
		//int cantidadFinalNumerosMoviles = form.getCantidadFinalNumerosMoviles();
		//int cantidadFinalNumerosFijos = form.getCantidadFinalNumerosFijos();
		int cantidadFinalNumerosMoviles = 0;
		int cantidadFinalNumerosFijos = 0;
		if(arrayCodTiposNumArr!=null && arrayCodTiposNumArr.length!=0) {
			arrayTiposNumArr = new String[arrayCodTiposNumArr.length];
			for (int v = 0; v<arrayCodTiposNumArr.length;v++){
				if (arrayCodTiposNumArr[v].equals("OFN")||arrayCodTiposNumArr[v].equals("ONN")) {
					arrayTiposNumArr[v]="MOVILES";
				}else if (arrayCodTiposNumArr[v].equals("RDF")){
					arrayTiposNumArr[v]="RED-FIJA";
				}				
			}			
		}

		log2(CLASS_NAME+" arrayTiposNumArr: "+arrayTiposNumArr.length);
		log2(CLASS_NAME+" arrayTiposNumArr: "+arrayTiposNumArr.toString());		
		//1.- Se obtiene la cantidad final de números moviles y fijos del arreglo arrayTiposNumArr			
		if (arrayNumFrecArr!=null && arrayNumFrecArr.length>0) {
			for (int w = 0; w < arrayNumFrecArr.length; w++) {
				String q = arrayCodTiposNumArr[w];
				if (q.equals("OFN")||q.equals("ONN")||q.equals("MOVILES")) {
					cantidadFinalNumerosMoviles=cantidadFinalNumerosMoviles+1;
				} else {
					cantidadFinalNumerosFijos=cantidadFinalNumerosFijos+1;
				}			
			}
		}
		log2(CLASS_NAME+" cantidadFinalNumerosMoviles: "+cantidadFinalNumerosMoviles+" cantidadFinalNumerosFijos: "+cantidadFinalNumerosFijos);
		
		AbonadoNumerosFrecuentesDTO anbonadoNumFrecDTO = (AbonadoNumerosFrecuentesDTO)session.getAttribute("anbonadoNumFrecDTO");
		ArrayList numerosFrecuentesTipoArrListDTO = anbonadoNumFrecDTO.getNumerosFrecuentesTipoListDTO();
		
		//2.- Se obtiene los arreglos de numeros frecuentes originales
		NumeroFrecuenteDTO [] numMovFrecuentesIngresados = new NumeroFrecuenteDTO [cantidadFinalNumerosMoviles];
		NumeroFrecuenteDTO [] numFijFrecuentesIngresados = new NumeroFrecuenteDTO [cantidadFinalNumerosFijos];		
		
		//NumeroFrecuenteDTO []numMovFAntiaguos = null;
		//NumeroFrecuenteDTO []numFijFAntiaguos = null;		
//		if (numerosFrecuentesTipoArrListDTO!=null&&(arrayTiposNumArr==null || arrayTiposNumArr.length==0)) {
//			for(int g = 0; g < numerosFrecuentesTipoArrListDTO.size(); g++){				
//				NumeroFrecuenteTipoListDTO nFTLDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoArrListDTO.get(g);
//				if ((nFTLDTO.getTipo().equals("ONN-NET")||nFTLDTO.getTipo().equals("OFF-NET")||nFTLDTO.getTipo().equals("MOVILES"))) {					
//					numMovFAntiaguos = nFTLDTO.getNumFrecuentesIngresadosList();					
//				} else {
//					numFijFAntiaguos = nFTLDTO.getNumFrecuentesIngresadosList();		
//				}					
//			}						
//		} else {
//			numMovFAntiaguos = new NumeroFrecuenteDTO[0];
//			numFijFAntiaguos = new NumeroFrecuenteDTO[0];
//		}
		log2("Se obtiene los arreglos de numeros frecuentes originales");


		String t = null;
		//Se crean los objetos NumeroFrecuenteDTO para los arreglos numMovFrecuentesIngresados y numFijFrecuentesIngresados
		if (arrayTiposNumArr!=null && arrayTiposNumArr.length>0) {
			for (int j = 0; j < arrayTiposNumArr.length; j++) {
				t = arrayTiposNumArr[j];	
				System.out.println("######################## "+arrayTiposNumArr[j]);
				if (t.equals("ONN-NET")||t.equals("OFF-NET")||t.equals("MOVILES")) {
					t = "MOVILES";
				} else {
					t = "RED-FIJA";
				}
				NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = null;
				for(int n = 0; n < numerosFrecuentesTipoArrListDTO.size(); n++){				
					numeroFrecuenteTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoArrListDTO.get(n);					
					String tArr = numeroFrecuenteTipoListDTO.getTipo();					
					if (t.equals(tArr)) {						
						log2(CLASS_NAME+" t: "+t+" tArr: "+tArr);						
						NumeroFrecuenteDTO numeroFrecuenteDTO = new NumeroFrecuenteDTO();	
						numeroFrecuenteDTO.setNumero(Long.parseLong(arrayNumFrecArr[j]));
						numeroFrecuenteDTO.setTipo(t);//"ON-NET";
						numeroFrecuenteDTO.setCodTipo(arrayCodTiposNumArr[j]);//"ONN";	
						if (t.equals("ONN-NET")||t.equals("OFF-NET")||t.equals("MOVILES")) {
							numMovFrecuentesIngresados[contadorMov] = numeroFrecuenteDTO;							
							contadorMov++;
							log2(CLASS_NAME+" MOVILES INGRESADOS AL ARREGLO: "+contadorMov+" TIPOS"+t);							
						} else if (t.equals("RED-FIJA")) {
							numFijFrecuentesIngresados[contadorFij] = numeroFrecuenteDTO;									
							contadorFij++;
							log2(CLASS_NAME+" FIJOS INGRESADOS AL ARREGLO: "+contadorFij+" TIPOS"+t);							
						}								
					}
				}	
			}			
		}
		log2("Se crean los objetos NumeroFrecuenteDTO para los arreglos numMovFrecuentesIngresados y numFijFrecuentesIngresados");
		NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = null;
		for(int p = 0; p < numerosFrecuentesTipoArrListDTO.size(); p++){
			numeroFrecuenteTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoArrListDTO.get(p);
			String tn = numeroFrecuenteTipoListDTO.getTipo();
			int cnf = 0;
			if (tn.equals("ONN-NET")||tn.equals("OFF-NET")||tn.equals("MOVILES")) {
				//cnf = numMovFrecuentesIngresados.length+numMovFAntiaguos.length;
				cnf = numMovFrecuentesIngresados.length;
				log2("cnf(MOVILES): "+cnf);
				NumeroFrecuenteDTO[] arrM = new NumeroFrecuenteDTO [cnf];
//				int m = 0;
//				if (numMovFAntiaguos.length!=0){
//					for (m = 0; m < numMovFAntiaguos.length; m++){
//						if(numMovFAntiaguos[m]!=null)arrM[m] = numMovFAntiaguos[m];
//					}					
//				}
				//int m1 = m;
				int m1 = 0;
				if (numMovFrecuentesIngresados.length!=0){
					for (m1 = 0; m1 < numMovFrecuentesIngresados.length; m1++){
						if(numMovFrecuentesIngresados[m1]!=null)arrM[m1] = numMovFrecuentesIngresados[m1];
					}									
				}
				numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(arrM);				
			} else if (tn.equals("RED-FIJA")) {
				//cnf = numFijFrecuentesIngresados.length+numFijFAntiaguos.length;
				cnf = numFijFrecuentesIngresados.length;
				log2("cnf(FIJA): "+cnf);
				NumeroFrecuenteDTO[] arrF = new NumeroFrecuenteDTO [cnf];
//				int f = 0;
//				if (numFijFAntiaguos.length!=0){
//					for (f = 0; f < numFijFAntiaguos.length; f++){
//						if (numFijFAntiaguos[f]!=null)arrF[f]=numFijFAntiaguos[f];
//					}					
//				}
				//int f1 = f;
				int f1 = 0;				
				if (numFijFrecuentesIngresados.length!=0){
					for (f1 = 0; f1 < numFijFrecuentesIngresados.length; f1++){
						if (numFijFrecuentesIngresados[f1]!=null)arrF[f1]=numFijFrecuentesIngresados[f1];
					}									
				}
				numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(arrF);				
			}				
			numerosFrecuentesTipoArrListDTO.remove(p);
			numerosFrecuentesTipoArrListDTO.add(p, numeroFrecuenteTipoListDTO);		
			log2(CLASS_NAME+" numerosFrecuentesTipoArrListDTO: "+numerosFrecuentesTipoArrListDTO.size());			
		}
		session.setAttribute("anbonadoNumFrecDTO", anbonadoNumFrecDTO);
		session.setAttribute("abonadoNumerosFrecuentesListDTO", numerosFrecuentesTipoArrListDTO);	
		log2("Se han construido los numero frecuentes y se han asignado a la sesion");
		log2(CLASS_NAME+" Arreglo de número    "+numFrecArr);						

	}	
	
	public void log2(Object o){
		System.out.println(o);
	}	

}
