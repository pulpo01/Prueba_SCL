/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */

package com.tmmas.scl.wsseguridad.dto;

public class DetalleAjusteSACVO
{

	private static final long serialVersionUID = -6569245507570253620L;

	private int codProducto;

	private double importeConcepto;

	private int numAbonado;

	private int codCentrEmi;

	private int codTipDocum;

	private long codVendedor;

	private String letra;

	private double monto;

	private long nroSecuencia;

	public int getCodProducto()
	{

		return this.codProducto;
	}

	public double getImporteConcepto()
	{

		return this.importeConcepto;
	}

	public int getNumAbonado()
	{

		return this.numAbonado;
	}

	public void setCodProducto(int codProducto)
	{

		this.codProducto = codProducto;
	}

	public void setImporteConcepto(double importeConcepto)
	{

		this.importeConcepto = importeConcepto;
	}

	public void setNumAbonado(int numAbonado)
	{

		this.numAbonado = numAbonado;
	}

	public int getCodCentrEmi()
	{

		return this.codCentrEmi;
	}

	public int getCodTipDocum()
	{

		return this.codTipDocum;
	}

	public long getCodVendedor()
	{

		return this.codVendedor;
	}

	public String getLetra()
	{

		return this.letra;
	}

	public double getMonto()
	{

		return this.monto;
	}

	public long getNroSecuencia()
	{

		return this.nroSecuencia;
	}

	public void setCodCentrEmi(int codCentrEmi)
	{

		this.codCentrEmi = codCentrEmi;
	}

	public void setCodTipDocum(int codTipDocum)
	{

		this.codTipDocum = codTipDocum;
	}

	public void setCodVendedor(long codVendedor)
	{

		this.codVendedor = codVendedor;
	}

	public void setLetra(String letra)
	{

		this.letra = letra;
	}

	public void setMonto(double monto)
	{

		this.monto = monto;
	}

	public void setNroSecuencia(long nroSecuencia)
	{

		this.nroSecuencia = nroSecuencia;
	}

}
