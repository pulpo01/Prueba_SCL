package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class GaContactoAbonadoToDTO  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
		protected String codServicio;//cod_servicio	varchar2(3)
		protected long numContacto;//num_contacto	number(2)
		protected String nombreContacto;//nombre_contacto	varchar2(50)
		protected String apellido1Contacto;//	varchar2(20)
		protected String apellido2Contacto;//	varchar2(20)
		protected String codParentesco;//	varchar2(20)
		protected String codTipDireccion;//	varchar2(1)
		protected long codDireccion;//	Number(20)
		protected String placaVehicular;// Varchar(15)	
		protected String colorVehiculo;//	varchar2(30)
		protected long anioVehiculo;//	number(4)
		protected String observacion;//	varchar2(50)
		protected String indVigente;//	varchar2(1)
		protected Timestamp fecModificacion;//	date
		protected String nomUsuarora;//	varchar2(30)
		protected long telefono;
		
		//Datos de la direccion
		protected String codProvincia;	
		protected String codRegion;			
		protected String codCiudad;			
		protected String codComuna;			
		protected String nomCalle;			
		protected String numCalle;			
		protected String obsDireccion;			
		protected String desDirec1;			
		protected String zip;				
		protected String codTipoCalle;	
		
		
		public long getTelefono() {
			return telefono;
		}
		public void setTelefono(long telefono) {
			this.telefono = telefono;
		}
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
		
		public String getPlacaVehicular() {
			return placaVehicular;
		}
		public void setPlacaVehicular(String placaVehicular) {
			this.placaVehicular = placaVehicular;
		}
		
		
		public String getCodParentesco() {
			return codParentesco;
		}
		public void setCodParentesco(String codParentesco) {
			this.codParentesco = codParentesco;
		}
		public String getCodCiudad() {
			return codCiudad;
		}
		public void setCodCiudad(String codCiudad) {
			this.codCiudad = codCiudad;
		}
		public String getCodComuna() {
			return codComuna;
		}
		public void setCodComuna(String codComuna) {
			this.codComuna = codComuna;
		}
		public String getCodProvincia() {
			return codProvincia;
		}
		public void setCodProvincia(String codProvincia) {
			this.codProvincia = codProvincia;
		}
		public String getCodRegion() {
			return codRegion;
		}
		public void setCodRegion(String codRegion) {
			this.codRegion = codRegion;
		}
		public String getCodTipoCalle() {
			return codTipoCalle;
		}
		public void setCodTipoCalle(String codTipoCalle) {
			this.codTipoCalle = codTipoCalle;
		}
		public String getDesDirec1() {
			return desDirec1;
		}
		public void setDesDirec1(String desDirec1) {
			this.desDirec1 = desDirec1;
		}
		public String getNomCalle() {
			return nomCalle;
		}
		public void setNomCalle(String nomCalle) {
			this.nomCalle = nomCalle;
		}
		public String getNumCalle() {
			return numCalle;
		}
		public void setNumCalle(String numCalle) {
			this.numCalle = numCalle;
		}
		public String getObsDireccion() {
			return obsDireccion;
		}
		public void setObsDireccion(String obsDireccion) {
			this.obsDireccion = obsDireccion;
		}
		public String getZip() {
			return zip;
		}
		public void setZip(String zip) {
			this.zip = zip;
		}	
	
}
