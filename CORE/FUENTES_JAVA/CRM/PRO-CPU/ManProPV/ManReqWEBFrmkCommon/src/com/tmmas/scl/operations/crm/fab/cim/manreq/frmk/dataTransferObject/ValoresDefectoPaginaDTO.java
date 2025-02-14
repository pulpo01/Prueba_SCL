package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class ValoresDefectoPaginaDTO  implements Serializable {
		
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
