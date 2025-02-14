package com.tmmas.scl.wsseguridad.dto;

import java.io.Serializable;

import com.tmmas.scl.wsfranquicias.common.vo.cambionumerosfrecuentes.firma.NumFrecuentesFirmaVO;

/**
 * @author mwn90113
 * 
 */
public class EjecucionCambioNumFrecuentesSACDTO implements Serializable
{

	private static final long serialVersionUID = 8681484758098292453L;

	private Long numAbonado;

	private String comentario;

	private NumFrecuentesFirmaVO[] bloqueNumFrecuenteServicioSuplementarioInsertar;

	private NumFrecuentesFirmaVO[] bloqueNumFrecuenteServicioSuplementarioEliminar;

	private NumFrecuentesFirmaVO[] bloqueNumFrecuentePlanTarifarioInsertar;

	private NumFrecuentesFirmaVO[] bloqueNumFrecuentePlanTarifarioEliminar;

	private long nroOOSS;

	private String codError;

	private String desError;

	private String numTransaccion;

	private String nomUsuarioSCL;

	/**
	 * @return the bloqueNumFrecuentePlanTarifarioEliminar
	 */
	public NumFrecuentesFirmaVO[] getBloqueNumFrecuentePlanTarifarioEliminar()
	{
		return bloqueNumFrecuentePlanTarifarioEliminar;
	}

	/**
	 * @param bloqueNumFrecuentePlanTarifarioEliminar
	 *            the bloqueNumFrecuentePlanTarifarioEliminar to set
	 */
	public void setBloqueNumFrecuentePlanTarifarioEliminar(
			NumFrecuentesFirmaVO[] bloqueNumFrecuentePlanTarifarioEliminar)
	{
		this.bloqueNumFrecuentePlanTarifarioEliminar = bloqueNumFrecuentePlanTarifarioEliminar;
	}

	/**
	 * @return the bloqueNumFrecuentePlanTarifarioInsertar
	 */
	public NumFrecuentesFirmaVO[] getBloqueNumFrecuentePlanTarifarioInsertar()
	{
		return bloqueNumFrecuentePlanTarifarioInsertar;
	}

	/**
	 * @param bloqueNumFrecuentePlanTarifarioInsertar
	 *            the bloqueNumFrecuentePlanTarifarioInsertar to set
	 */
	public void setBloqueNumFrecuentePlanTarifarioInsertar(
			NumFrecuentesFirmaVO[] bloqueNumFrecuentePlanTarifarioInsertar)
	{
		this.bloqueNumFrecuentePlanTarifarioInsertar = bloqueNumFrecuentePlanTarifarioInsertar;
	}

	/**
	 * @return the bloqueNumFrecuenteServicioSuplementarioEliminar
	 */
	public NumFrecuentesFirmaVO[] getBloqueNumFrecuenteServicioSuplementarioEliminar()
	{
		return bloqueNumFrecuenteServicioSuplementarioEliminar;
	}

	/**
	 * @param bloqueNumFrecuenteServicioSuplementarioEliminar
	 *            the bloqueNumFrecuenteServicioSuplementarioEliminar to set
	 */
	public void setBloqueNumFrecuenteServicioSuplementarioEliminar(
			NumFrecuentesFirmaVO[] bloqueNumFrecuenteServicioSuplementarioEliminar)
	{
		this.bloqueNumFrecuenteServicioSuplementarioEliminar = bloqueNumFrecuenteServicioSuplementarioEliminar;
	}

	/**
	 * @return the bloqueNumFrecuenteServicioSuplementarioInsertar
	 */
	public NumFrecuentesFirmaVO[] getBloqueNumFrecuenteServicioSuplementarioInsertar()
	{
		return bloqueNumFrecuenteServicioSuplementarioInsertar;
	}

	/**
	 * @param bloqueNumFrecuenteServicioSuplementarioInsertar
	 *            the bloqueNumFrecuenteServicioSuplementarioInsertar to set
	 */
	public void setBloqueNumFrecuenteServicioSuplementarioInsertar(
			NumFrecuentesFirmaVO[] bloqueNumFrecuenteServicioSuplementarioInsertar)
	{
		this.bloqueNumFrecuenteServicioSuplementarioInsertar = bloqueNumFrecuenteServicioSuplementarioInsertar;
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
	 * @return the comentario
	 */
	public String getComentario()
	{
		return comentario;
	}

	/**
	 * @param comentario
	 *            the comentario to set
	 */
	public void setComentario(String comentario)
	{
		this.comentario = comentario;
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

	public String toString()
	{
		StringBuffer b = new StringBuffer();
		b.append("getComentario(): ");
		b.append(getComentario());
		b.append("\n");
		b.append("getNomUsuarioSCL(): ");
		b.append(getNomUsuarioSCL());
		b.append("\n");
		b.append("getNroOOSS(): ");
		b.append(getNroOOSS());
		b.append("\n");
		b.append("getNumAbonado(): ");
		b.append(getNumAbonado());
		b.append("\n");
		b.append("getNumTransaccion(): ");
		b.append(getNumTransaccion());
		b.append("\n");
		b.append("getCodError(): ");
		b.append(getCodError());
		b.append("\n");
		b.append("getDesError(): ");
		b.append(getDesError());
		b.append("\n");
		b.append("getBloqueNumFrecuentePlanTarifarioEliminar(): ");
		if (getBloqueNumFrecuentePlanTarifarioEliminar() != null)
		{
			b.append(getBloqueNumFrecuentePlanTarifarioEliminar().length);
			b.append("\n");
			for (int i = 0; i < getBloqueNumFrecuentePlanTarifarioEliminar().length; i++)
			{
				NumFrecuentesFirmaVO vo = getBloqueNumFrecuentePlanTarifarioEliminar()[i];
				b.append("vo.getNumFrecuente(): " + vo.getNumFrecuente());
				b.append(", ");
				b.append("vo.getTipoNumFrecuente(): " + vo.getTipoNumFrecuente());
				b.append("; ");
			}
		}
		else
		{
			b.append("null");
		}
		b.append("\n");
		b.append("getBloqueNumFrecuentePlanTarifarioInsertar(): ");
		if (getBloqueNumFrecuentePlanTarifarioInsertar() != null)
		{
			b.append(getBloqueNumFrecuentePlanTarifarioInsertar().length);
			b.append("\n");
			for (int i = 0; i < getBloqueNumFrecuentePlanTarifarioInsertar().length; i++)
			{
				NumFrecuentesFirmaVO vo = getBloqueNumFrecuentePlanTarifarioInsertar()[i];
				b.append("vo.getNumFrecuente(): " + vo.getNumFrecuente());
				b.append(", ");
				b.append("vo.getTipoNumFrecuente(): " + vo.getTipoNumFrecuente());
				b.append("; ");
			}
		}
		else
		{
			b.append("null");
		}
		b.append("\n");
		return b.toString();
	}
}