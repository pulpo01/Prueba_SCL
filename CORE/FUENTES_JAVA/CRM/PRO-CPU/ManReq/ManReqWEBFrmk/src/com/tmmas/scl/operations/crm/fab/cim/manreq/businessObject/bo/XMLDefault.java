package com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo;

import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.PaginaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;

public class XMLDefault {
	
	PaginaDTO paginaDTO= new PaginaDTO();
	SeccionDTO seccionDTO=new SeccionDTO();
	ControlDTO controlDTO=new ControlDTO();
	ControlDTO controlRetorno=new ControlDTO();
	DefaultPaginaCPUDTO defaultPagina= new DefaultPaginaCPUDTO();
	
	public ControlDTO obtenerControl(DefaultPaginaCPUDTO defpag, String pagina, String seccion, String control){
		defaultPagina=defpag;
		if(defaultPagina==null){
			System.out.println("OBJETO NULO");
		}else{
			paginaDTO = defaultPagina.obtPagina(pagina);
			if (paginaDTO!=null){
				seccionDTO = paginaDTO.obtSeccion(seccion);
				if (seccionDTO!=null){
					
					controlDTO = seccionDTO.obtControl(control);
					if (controlDTO!=null){
						controlRetorno = controlDTO;
						return controlRetorno;
					}
				}
			}
		}
		return null;
	}
	
	public SeccionDTO obtenerSeccion(DefaultPaginaCPUDTO defpag, String pagina, String seccion){
		defaultPagina=defpag;
		if(defaultPagina==null){
			System.out.println("OBJETO NULO");
		}else{
			paginaDTO = defaultPagina.obtPagina(pagina);
			if (paginaDTO!=null){
				seccionDTO = paginaDTO.obtSeccion(seccion);
				if (seccionDTO!=null){
					return seccionDTO;
				}
			}
		}
		return null;
	}
	
	public String estadoVisibleControl(String pagina, String seccion, String control){
		String retorno="";
		if(defaultPagina==null){
			return retorno;
		}else{
			paginaDTO = defaultPagina.obtPagina(pagina);
			if (paginaDTO!=null){
				seccionDTO = paginaDTO.obtSeccion(seccion);
				if (seccionDTO!=null){
					controlDTO = seccionDTO.obtControl(control);
					if (controlDTO!=null){
						return controlDTO.getVisible();
					}
				}
			}
		}
		return retorno;
	}

	

}
