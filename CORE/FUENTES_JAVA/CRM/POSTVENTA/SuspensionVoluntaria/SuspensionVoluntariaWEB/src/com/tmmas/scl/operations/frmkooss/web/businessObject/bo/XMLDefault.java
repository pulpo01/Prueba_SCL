package com.tmmas.scl.operations.frmkooss.web.businessObject.bo;

import com.tmmas.scl.framework.commonDoman.dataTransferObject.ControlDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.PaginaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.SeccionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;

public class XMLDefault {
	
	PaginaDTO paginaDTO= new PaginaDTO();
	SeccionDTO seccionDTO=new SeccionDTO();
	ControlDTO controlDTO=new ControlDTO();
	ControlDTO controlRetorno=new ControlDTO();
	ValoresJSPPorDefectoDTO defaultPagina= new ValoresJSPPorDefectoDTO();
	
	public ControlDTO obtenerControl(ValoresJSPPorDefectoDTO defpag, String pagina, String seccion, String control){
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
	
	public SeccionDTO obtenerSeccion(ValoresJSPPorDefectoDTO defpag, String pagina, String seccion){
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
