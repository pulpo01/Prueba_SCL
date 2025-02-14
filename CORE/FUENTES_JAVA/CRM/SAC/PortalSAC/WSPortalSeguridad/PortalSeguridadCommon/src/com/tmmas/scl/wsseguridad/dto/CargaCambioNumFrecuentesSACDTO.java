package com.tmmas.scl.wsseguridad.dto;

import java.io.Serializable;

import com.tmmas.scl.wsfranquicias.common.dto.cambionumerosfrecuentes.CargaCambioNumFrecuentesDTO;
import com.tmmas.scl.wsfranquicias.common.vo.cambionumerosfrecuentes.firma.NumFrecuentesFirmaVO;
import com.tmmas.scl.wsfranquicias.common.vo.cambionumerosfrecuentes.firma.TipoNumFrecuenteFirmaVO;

import com.tmmas.scl.wsportal.common.exception.PortalSACException;

/**
 * @author mwn90113
 * 
 */
public class CargaCambioNumFrecuentesSACDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Long numAbonado;

	private Long numCelular;

	private Long cantRedMovil;

	private Long cantRedFija;

	private Long cantidadMaximoTotal;

	private Long cantRedMovilSS;

	private Long cantRedFijaSS;

	private Long cantidadMaximoTotalSS;

	private String codPlantarif;

	private String desPlantarif;

	private Long codCliente;

	private NumFrecuentesFirmaVO[] arrayNumFrecuentesSS;

	private NumFrecuentesFirmaVO[] arrayNumFrecuentesPlan;

	private TipoNumFrecuenteFirmaVO[] arrayTipoNumFrecuentes;

	private String mensajeNumFrec;

	private long nroOOSS;

	private String codError;

	private String desError;

	private String numTransaccion;

	private String nomUsuarioSCL;

	public CargaCambioNumFrecuentesSACDTO(CargaCambioNumFrecuentesDTO dto)
	{
		this.setCantidadMaximoTotal(dto.getCantidadMaximoTotal());
		this.setCantidadMaximoTotalSS(dto.getCantidadMaximoTotalSS());
		this.setCantRedFija(dto.getCantRedFija());
		this.setCantRedFijaSS(dto.getCantRedFijaSS());
		this.setCantRedMovil(dto.getCantRedMovil());
		this.setCantRedMovilSS(dto.getCantRedMovilSS());
		this.setCodCliente(dto.getCodCliente());
		this.setCodPlantarif(dto.getCodPlantarif());
		this.setDesPlantarif(dto.getDesPlantarif());
		this.setMensajeNumFrec(dto.getMensajeNumFrec());
		this.setNumCelular(dto.getNumCelular());
		this.setNomUsuarioSCL(dto.getNomUsuarioSCL());
		this.setNumTransaccion(dto.getNumTransaccion());
		this.setCodError(dto.getCodError());
		this.setDesError(dto.getDesError());
		this.setArrayTipoNumFrecuentes(dto.getArrayTipoNumFrecuentes());
		this.setArrayNumFrecuentesPlan(dto.getArrayNumFrecuentesPlan());
		this.setArrayNumFrecuentesSS(dto.getArrayNumFrecuentesSS());
	}
	
	public CargaCambioNumFrecuentesSACDTO(PortalSACException pe)
	{
		this.setCodError(pe.getCodigo());
		this.setDesError(pe.getMessage());
	}

	public CargaCambioNumFrecuentesSACDTO()
	{

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

	/**
	 * @return the mensajeNumFrec
	 */
	public String getMensajeNumFrec()
	{
		return mensajeNumFrec;
	}

	/**
	 * @param mensajeNumFrec
	 *            the mensajeNumFrec to set
	 */
	public void setMensajeNumFrec(String mensajeNumFrec)
	{
		this.mensajeNumFrec = mensajeNumFrec;
	}

	/**
	 * @return the arrayNumFrecuentesPlan
	 */
	public NumFrecuentesFirmaVO[] getArrayNumFrecuentesPlan()
	{
		return arrayNumFrecuentesPlan;
	}

	/**
	 * @param arrayNumFrecuentesPlan
	 *            the arrayNumFrecuentesPlan to set
	 */
	public void setArrayNumFrecuentesPlan(NumFrecuentesFirmaVO[] arrayNumFrecuentesPlan)
	{
		this.arrayNumFrecuentesPlan = arrayNumFrecuentesPlan;
	}

	/**
	 * @return the arrayNumFrecuentesSS
	 */
	public NumFrecuentesFirmaVO[] getArrayNumFrecuentesSS()
	{
		return arrayNumFrecuentesSS;
	}

	/**
	 * @param arrayNumFrecuentesSS
	 *            the arrayNumFrecuentesSS to set
	 */
	public void setArrayNumFrecuentesSS(NumFrecuentesFirmaVO[] arrayNumFrecuentesSS)
	{
		this.arrayNumFrecuentesSS = arrayNumFrecuentesSS;
	}

	/**
	 * @return the arrayTipoNumFrecuentes
	 */
	public TipoNumFrecuenteFirmaVO[] getArrayTipoNumFrecuentes()
	{
		return arrayTipoNumFrecuentes;
	}

	/**
	 * @param arrayTipoNumFrecuentes
	 *            the arrayTipoNumFrecuentes to set
	 */
	public void setArrayTipoNumFrecuentes(TipoNumFrecuenteFirmaVO[] arrayTipoNumFrecuentes)
	{
		this.arrayTipoNumFrecuentes = arrayTipoNumFrecuentes;
	}

	/**
	 * @return the cantidadMaximoTotal
	 */
	public Long getCantidadMaximoTotal()
	{
		return cantidadMaximoTotal;
	}

	/**
	 * @param cantidadMaximoTotal
	 *            the cantidadMaximoTotal to set
	 */
	public void setCantidadMaximoTotal(Long cantidadMaximoTotal)
	{
		this.cantidadMaximoTotal = cantidadMaximoTotal;
	}

	/**
	 * @return the cantRedFija
	 */
	public Long getCantRedFija()
	{
		return cantRedFija;
	}

	/**
	 * @param cantRedFija
	 *            the cantRedFija to set
	 */
	public void setCantRedFija(Long cantRedFija)
	{
		this.cantRedFija = cantRedFija;
	}

	/**
	 * @return the cantRedMovil
	 */
	public Long getCantRedMovil()
	{
		return cantRedMovil;
	}

	/**
	 * @param cantRedMovil
	 *            the cantRedMovil to set
	 */
	public void setCantRedMovil(Long cantRedMovil)
	{
		this.cantRedMovil = cantRedMovil;
	}

	/**
	 * @return the codCliente
	 */
	public Long getCodCliente()
	{
		return codCliente;
	}

	/**
	 * @param codCliente
	 *            the codCliente to set
	 */
	public void setCodCliente(Long codCliente)
	{
		this.codCliente = codCliente;
	}

	/**
	 * @return the codPlantarif
	 */
	public String getCodPlantarif()
	{
		return codPlantarif;
	}

	/**
	 * @param codPlantarif
	 *            the codPlantarif to set
	 */
	public void setCodPlantarif(String codPlantarif)
	{
		this.codPlantarif = codPlantarif;
	}

	/**
	 * @return the numAbonado
	 */
	public Long getNumAbonado()
	{
		return numAbonado;
	}

	/**
	 * @param numAbonado
	 *            the numAbonado to set
	 */
	public void setNumAbonado(Long numAbonado)
	{
		this.numAbonado = numAbonado;
	}

	/**
	 * @return the numCelular
	 */
	public Long getNumCelular()
	{
		return numCelular;
	}

	/**
	 * @param numCelular
	 *            the numCelular to set
	 */
	public void setNumCelular(Long numCelular)
	{
		this.numCelular = numCelular;
	}

	/**
	 * @return the desPlantarif
	 */
	public String getDesPlantarif()
	{
		return desPlantarif;
	}

	/**
	 * @param desPlantarif
	 *            the desPlantarif to set
	 */
	public void setDesPlantarif(String desPlantarif)
	{
		this.desPlantarif = desPlantarif;
	}

	/**
	 * @return the cantidadMaximoTotalSS
	 */
	public Long getCantidadMaximoTotalSS()
	{
		return cantidadMaximoTotalSS;
	}

	/**
	 * @param cantidadMaximoTotalSS
	 *            the cantidadMaximoTotalSS to set
	 */
	public void setCantidadMaximoTotalSS(Long cantidadMaximoTotalSS)
	{
		this.cantidadMaximoTotalSS = cantidadMaximoTotalSS;
	}

	/**
	 * @return the cantRedFijaSS
	 */
	public Long getCantRedFijaSS()
	{
		return cantRedFijaSS;
	}

	/**
	 * @param cantRedFijaSS
	 *            the cantRedFijaSS to set
	 */
	public void setCantRedFijaSS(Long cantRedFijaSS)
	{
		this.cantRedFijaSS = cantRedFijaSS;
	}

	/**
	 * @return the cantRedMovilSS
	 */
	public Long getCantRedMovilSS()
	{
		return cantRedMovilSS;
	}

	/**
	 * @param cantRedMovilSS
	 *            the cantRedMovilSS to set
	 */
	public void setCantRedMovilSS(Long cantRedMovilSS)
	{
		this.cantRedMovilSS = cantRedMovilSS;
	}

	public String getNomUsuarioSCL()
	{
		return nomUsuarioSCL;
	}

	public void setNomUsuarioSCL(String nomUsuarioSCL)
	{
		this.nomUsuarioSCL = nomUsuarioSCL;
	}

	public long getNroOOSS()
	{
		return nroOOSS;
	}

	public void setNroOOSS(long nroOOSS)
	{
		this.nroOOSS = nroOOSS;
	}

	public String getNumTransaccion()
	{
		return numTransaccion;
	}

	public void setNumTransaccion(String numTransaccion)
	{
		this.numTransaccion = numTransaccion;
	}

}
