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

public class EjecucionAjusteCReversionCargosSACDTO
{

	private static final long serialVersionUID = 3867111956492067940L;

	private DetalleAjusteSACVO[] arrayDetalleAjusteSACVO;

	private int codCauPago;

	private int codND;

	private int codOriPago;

	private String desND;

	private double montoTotalAjuste;

	private int tipoAjuste;

	private String observacion;

	private String codError;

	private String desError;

	private String nomUsuarioSCL;

	private long nroOOSS;

	private String numTransaccion;

	private String fecVencimiento;

	public DetalleAjusteSACVO[] getArrayDetalleAjusteSACVO()
	{
		return arrayDetalleAjusteSACVO;
	}

	public int getCodCauPago()
	{

		return this.codCauPago;
	}

	public String getCodError()
	{

		return this.codError;
	}

	public int getCodND()
	{

		return this.codND;
	}

	public int getCodOriPago()
	{

		return this.codOriPago;
	}

	public String getDesError()
	{

		return this.desError;
	}

	public String getDesND()
	{

		return this.desND;
	}

	public String getFecVencimiento()
	{
		return fecVencimiento;
	}

	public double getMontoTotalAjuste()
	{

		return this.montoTotalAjuste;
	}

	public String getNomUsuarioSCL()
	{

		return this.nomUsuarioSCL;
	}

	public long getNroOOSS()
	{

		return this.nroOOSS;
	}

	public String getNumTransaccion()
	{

		return this.numTransaccion;
	}

	public String getObservacion()
	{

		return this.observacion;
	}

	public int getTipoAjuste()
	{

		return this.tipoAjuste;
	}

	public void setArrayDetalleAjusteSACVO(DetalleAjusteSACVO[] arrayDetalleAjusteSACVO)
	{
		this.arrayDetalleAjusteSACVO = arrayDetalleAjusteSACVO;
	}

	public void setCodCauPago(int codCauPago)
	{

		this.codCauPago = codCauPago;
	}

	public void setCodError(String arg0)
	{

		this.codError = arg0;
	}

	public void setCodND(int codND)
	{

		this.codND = codND;
	}

	public void setCodOriPago(int codOriPago)
	{

		this.codOriPago = codOriPago;
	}

	public void setDesError(String desError)
	{

		this.desError = desError;
	}

	public void setDesND(String desNC)
	{

		this.desND = desNC;
	}

	public void setFecVencimiento(String fecVencimiento)
	{
		this.fecVencimiento = fecVencimiento;
	}

	public void setMontoTotalAjuste(double montoTotalAjuste)
	{

		this.montoTotalAjuste = montoTotalAjuste;
	}

	public void setNomUsuarioSCL(String nomUsuarioSCL)
	{

		this.nomUsuarioSCL = nomUsuarioSCL;
	}

	public void setNroOOSS(long nroOOSS)
	{

		this.nroOOSS = nroOOSS;
	}

	public void setNumTransaccion(String numTransaccion)
	{

		this.numTransaccion = numTransaccion;
	}

	public void setObservacion(String observacion)
	{

		this.observacion = observacion;
	}

	public void setTipoAjuste(int tipoAjuste)
	{

		this.tipoAjuste = tipoAjuste;
	}

}
