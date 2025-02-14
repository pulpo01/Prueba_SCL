package com.tmmas.scl.framework.commonDoman.dataTransferObject;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class ValoresJSPPorDefectoDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	Map paginas=new HashMap();

	public Map getPaginas() {
		return paginas;
	}

	public void setPaginas(Map paginas) {
		this.paginas = paginas;
	}
	
	public void addPagina(String id, PaginaDTO valor){
		paginas.put(id, valor);
	}
	
	public PaginaDTO obtPagina(String id){
		return (PaginaDTO)paginas.get(id);
	}

}