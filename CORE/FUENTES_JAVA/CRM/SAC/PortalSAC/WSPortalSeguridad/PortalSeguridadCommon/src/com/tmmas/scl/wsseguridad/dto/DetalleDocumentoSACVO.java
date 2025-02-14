package com.tmmas.scl.wsseguridad.dto;

import java.io.Serializable;

/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones,
 * SA. Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile Todos los
 * derechos reservados.
 * 
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en
 * concordancia con los t&eacute;rminos de derechos de licencias que sean
 * adquiridos con TM-mAs.
 * 
 * Fecha ------------------- Autor ------------------------- Cambios ----------
 * 13/03/2008 - 10:30:32 Santiago Ventura Versión Inicial
 * 
 * 
 * 
 * 
 * @author Santiago Ventura
 * @version 1.0
 */
public class DetalleDocumentoSACVO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * N&uacute;mero identificador del abonado.
	 */
	private int numAbonado;

	/**
	 * C&oacute;digo del producto
	 * 
	 */
	private int codProducto;

	/**
	 * Descripci&oacute;n del producto.
	 */
	private String desProducto;

	/**
	 * Indica si el documento es 0 - Recurrente 1 - Contado
	 */
	private int indContado;

	/**
	 * C&oacute;digo del tipo de documento.
	 */
	private int codTipDocum;

	/**
	 * C&oacute;digo del vendedor.
	 */
	private long codVendedor;

	/**
	 * Letra de un documento.
	 */
	private String letra;

	/**
	 * C&oacute;digo del centro emisor.
	 */
	private int codCentrEmi;

	/**
	 * N&uacute;mero de secuencia del siguiente documento.
	 */
	private long nroSecuencia;

	private double monto;

	private double montoNIC = 0.0;

	/**
	 * 
	 */
	public DetalleDocumentoSACVO()
	{

	}

	public int getCodCentrEmi()
	{
		return codCentrEmi;
	}

	/**
	 * @return int the codProducto
	 */
	public int getCodProducto()
	{
		return codProducto;
	}

	public int getCodTipDocum()
	{
		return codTipDocum;
	}

	public long getCodVendedor()
	{
		return codVendedor;
	}

	/**
	 * @return String the desProducto
	 */
	public String getDesProducto()
	{
		return desProducto;
	}

	/**
	 * @return int the indContado
	 */
	public int getIndContado()
	{
		return indContado;
	}

	public String getLetra()
	{
		return letra;
	}

	public double getMonto()
	{
		return monto;
	}

	public double getMontoNIC()
	{
		return montoNIC;
	}

	public long getNroSecuencia()
	{
		return nroSecuencia;
	}

	/**
	 * @return int the numAbonado
	 */
	public int getNumAbonado()
	{
		return numAbonado;
	}

	public void setCodCentrEmi(int codCentrEmi)
	{
		this.codCentrEmi = codCentrEmi;
	}

	/**
	 * @param codProducto
	 *            int the codProducto to set
	 */
	public void setCodProducto(int codProducto)
	{
		this.codProducto = codProducto;
	}

	public void setCodTipDocum(int codTipDocum)
	{
		this.codTipDocum = codTipDocum;
	}

	public void setCodVendedor(long codVendedor)
	{
		this.codVendedor = codVendedor;
	}

	/**
	 * @param desProducto
	 *            String the desProducto to set
	 */
	public void setDesProducto(String desProducto)
	{
		this.desProducto = desProducto;
	}

	/**
	 * @param indContado
	 *            int the indContado to set
	 */
	public void setIndContado(int indContado)
	{
		this.indContado = indContado;
	}

	public void setLetra(String letra)
	{
		this.letra = letra;
	}

	public void setMonto(double monto)
	{
		this.monto = monto;
	}

	public void setMontoNIC(double montoNIC)
	{
		this.montoNIC = montoNIC;
	}

	public void setNroSecuencia(long nroSecuencia)
	{
		this.nroSecuencia = nroSecuencia;
	}

	/**
	 * @param numAbonado
	 *            int the numAbonado to set
	 */
	public void setNumAbonado(int numAbonado)
	{
		this.numAbonado = numAbonado;
	}

}
