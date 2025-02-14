package com.tmmas.cl.scl.crmcommon.commonapp.dto;
import java.io.Serializable;
import java.util.Date;

public class RangoDTO implements Serializable
{
	private static final long serialVersionUID = 1L;
	private long numDesde;
	private long numHasta;

	public RangoDTO()
	{
	}
	
	public RangoDTO(long numDesde)
	{
		this.numDesde = numDesde;
	}
	
	public RangoDTO(long numDesde, long numHasta, Date fechaAlta, Date fechaBaja, Date fechaSuspension, Date fechaRehabilitacion, String estado, String nomUsuarOra)
	{
		this.numDesde = numDesde;
		this.numHasta = numHasta;
	}
	
	public String toString()
	{
		StringBuffer buffer = new StringBuffer("RangoDTO: ");
		
		buffer.append("numDesde=[").append(numDesde).append("]");
		buffer.append(", numHasta=[").append(numHasta).append("]");

		return buffer.toString();
	}
	
	public boolean equals(Object right)
	{
		if(right == null || !(right instanceof RangoDTO))
			return false;
		
		if (this == right)
			return true;
		
		RangoDTO rangoDTO = (RangoDTO) right;
		
		if (rangoDTO.getNumDesde() == numDesde)
			return true;

		return false;
	}

	public int hashCode()
	{
		int hash = 7;
		
		hash = 31 * hash + (int) numDesde;
		
		return hash;
	}

	public long getNumDesde()
	{
		return numDesde;
	}

	public void setNumDesde(long numDesde)
	{
		this.numDesde = numDesde;
	}

	public long getNumHasta()
	{
		return numHasta;
	}

	public void setNumHasta(long numHasta)
	{
		this.numHasta = numHasta;
	}
}

