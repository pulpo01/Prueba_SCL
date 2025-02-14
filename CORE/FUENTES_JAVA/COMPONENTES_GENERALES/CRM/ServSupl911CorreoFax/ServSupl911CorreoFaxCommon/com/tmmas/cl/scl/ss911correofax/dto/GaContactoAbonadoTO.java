package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class GaContactoAbonadoTO extends GaSSTipDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
		protected String codServicio;//cod_servicio	varchar2(3)
		protected long numContacto;//num_contacto	number(2)
		protected String nombreContacto;//nombre_contacto	varchar2(50)
		protected String apellido1Contacto;//	varchar2(20)
		protected String apellido2Contacto;//	varchar2(20)
		protected String parentesco;//	varchar2(20)
		protected String codTipDireccion;//	varchar2(1)
		protected long codDireccion;//	Number(20)
		protected String placaVehicular;// Varchar(15)	
		protected String colorVehiculo;//	varchar2(30)
		protected long anioVehiculo;//	number(4)
		protected String observacion;//	varchar2(50)
		protected String indVigente;//	varchar2(1)
		protected Timestamp fecModificacion;//	date
		protected String nomUsuarora;//	varchar2(30)
		
		
		public long getAnioVehiculo() {
			return anioVehiculo;
		}
		public void setAnioVehiculo(long anioVehiculo) {
			this.anioVehiculo = anioVehiculo;
		}
		public String getApellido1Contacto() {
			return apellido1Contacto;
		}
		public void setApellido1Contacto(String apellido1Contacto) {
			this.apellido1Contacto = apellido1Contacto;
		}
		public String getApellido2Contacto() {
			return apellido2Contacto;
		}
		public void setApellido2Contacto(String apellido2Contacto) {
			this.apellido2Contacto = apellido2Contacto;
		}
		public long getCodDireccion() {
			return codDireccion;
		}
		public void setCodDireccion(long codDireccion) {
			this.codDireccion = codDireccion;
		}
		public String getCodServicio() {
			return codServicio;
		}
		public void setCodServicio(String codServicio) {
			this.codServicio = codServicio;
		}
		public String getCodTipDireccion() {
			return codTipDireccion;
		}
		public void setCodTipDireccion(String codTipDireccion) {
			this.codTipDireccion = codTipDireccion;
		}
		public String getColorVehiculo() {
			return colorVehiculo;
		}
		public void setColorVehiculo(String colorVehiculo) {
			this.colorVehiculo = colorVehiculo;
		}
		public Timestamp getFecModificacion() {
			return fecModificacion;
		}
		public void setFecModificacion(Timestamp fecModificacion) {
			this.fecModificacion = fecModificacion;
		}
		public String getIndVigente() {
			return indVigente;
		}
		public void setIndVigente(String indVigente) {
			this.indVigente = indVigente;
		}
		public String getNombreContacto() {
			return nombreContacto;
		}
		public void setNombreContacto(String nombreContacto) {
			this.nombreContacto = nombreContacto;
		}
		public String getNomUsuarora() {
			return nomUsuarora;
		}
		public void setNomUsuarora(String nomUsuarora) {
			this.nomUsuarora = nomUsuarora;
		}
		
		public long getNumContacto() {
			return numContacto;
		}
		public void setNumContacto(long numContacto) {
			this.numContacto = numContacto;
		}
		public String getObservacion() {
			return observacion;
		}
		public void setObservacion(String observacion) {
			this.observacion = observacion;
		}
		public String getParentesco() {
			return parentesco;
		}
		public void setParentesco(String parentesco) {
			this.parentesco = parentesco;
		}
		public String getPlacaVehicular() {
			return placaVehicular;
		}
		public void setPlacaVehicular(String placaVehicular) {
			this.placaVehicular = placaVehicular;
		}
	
}
