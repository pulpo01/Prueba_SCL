package com.tmmas.cl.scl.migracionmasiva.dto;

import java.io.Serializable;

public class WSDatosEntradaDTO implements Serializable {

		/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		private String codCliente;
		private String codPlanTarif;
		private String numCelular;
		private String indProcedencia;
		private String imei;
		private String nomUsuario;
		private String saldo;
		
		
		
		public String getSaldo() {
			return saldo;
		}
		public void setSaldo(String saldo) {
			this.saldo = saldo;
		}
		public String getCodCliente() {
			return codCliente;
		}
		public void setCodCliente(String codCliente) {
			this.codCliente = codCliente;
		}
		public String getCodPlanTarif() {
			return codPlanTarif;
		}
		public void setCodPlanTarif(String codPlanTarif) {
			this.codPlanTarif = codPlanTarif;
		}
		public String getImei() {
			return imei;
		}
		public void setImei(String imei) {
			this.imei = imei;
		}
		public String getIndProcedencia() {
			return indProcedencia;
		}
		public void setIndProcedencia(String indProcedencia) {
			this.indProcedencia = indProcedencia;
		}
		public String getNomUsuario() {
			return nomUsuario;
		}
		public void setNomUsuario(String nomUsuario) {
			this.nomUsuario = nomUsuario;
		}
		public String getNumCelular() {
			return numCelular;
		}
		public void setNumCelular(String numCelular) {
			this.numCelular = numCelular;
		}
		
}
