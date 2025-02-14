/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class DetalleDireccionDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String desComuna;

	private String desCiudad;

	private String desProvincia;

	private String desRegion;

	private String codComuna;

	private String codCiudad;

	private String codProvincia;

	private String codRegion;

	private String nomCalle;

	private String numCalle;

	private String numPiso;

	private String zip;

	private String obsDireccion;

	private String codError;

	private String desError;

	
	/*
	 * Modificacion
	 * Fecha: 04/08/2010
	 * 
	 */
	
	private String obsDireccion2;
	
	public String getDesCiudad()
	{
		return desCiudad;
	}

	public void setDesCiudad(String desCiudad)
	{
		this.desCiudad = desCiudad;
	}

	public String getDesComuna()
	{
		return desComuna;
	}

	public void setDesComuna(String desComuna)
	{
		this.desComuna = desComuna;
	}

	public String getDesProvincia()
	{
		return desProvincia;
	}

	public void setDesProvincia(String desProvincia)
	{
		this.desProvincia = desProvincia;
	}

	public String getDesRegion()
	{
		return desRegion;
	}

	public void setDesRegion(String desRegion)
	{
		this.desRegion = desRegion;
	}

	public String getNomCalle()
	{
		return nomCalle;
	}

	public void setNomCalle(String nomCalle)
	{
		this.nomCalle = nomCalle;
	}

	public String getObsDireccion()
	{
		return obsDireccion;
	}

	public void setObsDireccion(String obsDireccion)
	{
		this.obsDireccion = obsDireccion;
	}

	public String getCodError()
	{
		return codError;
	}

	public void setCodError(String codError)
	{
		this.codError = codError;
	}

	public String getDesError()
	{
		return desError;
	}

	public void setDesError(String desError)
	{
		this.desError = desError;
	}

	public String getNumCalle()
	{
		return numCalle;
	}

	public void setNumCalle(String numCalle)
	{
		this.numCalle = numCalle;
	}

	public String getZip()
	{
		return zip;
	}

	public void setZip(String numCasilla)
	{
		this.zip = numCasilla;
	}

	public String getNumPiso()
	{
		return numPiso;
	}

	public void setNumPiso(String numPiso)
	{
		this.numPiso = numPiso;
	}

	public final String getCodCiudad()
	{
		return codCiudad;
	}

	public final void setCodCiudad(String codCiudad)
	{
		this.codCiudad = codCiudad;
	}

	public final String getCodComuna()
	{
		return codComuna;
	}

	public final void setCodComuna(String codComuna)
	{
		this.codComuna = codComuna;
	}

	public final String getCodProvincia()
	{
		return codProvincia;
	}

	public final void setCodProvincia(String codProvincia)
	{
		this.codProvincia = codProvincia;
	}

	public final String getCodRegion()
	{
		return codRegion;
	}

	public final void setCodRegion(String codRegion)
	{
		this.codRegion = codRegion;
	}

	public String getObsDireccion2() {
		return obsDireccion2;
	}

	public void setObsDireccion2(String obsDireccion2) {
		this.obsDireccion2 = obsDireccion2;
	}
	

}
