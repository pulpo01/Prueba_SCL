package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraLineaDTO implements Serializable{
	
	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;		        
		private WsStructuraSimcardDTO simcard;					
		private WsStructuraTerminalDTO terminal;	        			
		private WsStructuraUsuarioLineaDTO usuarioLinea;
		private String CodigoCentral;
	
		public String getCodigoCentral() {
			return CodigoCentral;
		}
		public void setCodigoCentral(String codigoCentral) {
			CodigoCentral = codigoCentral;
		}
		public WsStructuraSimcardDTO getSimcard() {
			return simcard;
		}
		public void setSimcard(WsStructuraSimcardDTO simcard) {
			this.simcard = simcard;
		}
		public WsStructuraTerminalDTO getTerminal() {
			return terminal;
		}
		public void setTerminal(WsStructuraTerminalDTO terminal) {
			this.terminal = terminal;
		}
		public WsStructuraUsuarioLineaDTO getUsuarioLinea() {
			return usuarioLinea;
		}
		public void setUsuarioLinea(WsStructuraUsuarioLineaDTO usuarioLinea) {
			this.usuarioLinea = usuarioLinea;
		}

}
