package com.tmmas.scl.wsportal.common.exception;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;

import com.tmmas.cl.framework.exception.GeneralException;

public class PortalSACException extends GeneralException
{
	private static final long serialVersionUID = 720054058906382571L;

	public String stackTraceToString()
	{
		final Writer writer = new StringWriter();
		this.printStackTrace(new PrintWriter(writer));
		String stackTrace = writer.toString();
		StringBuffer b = new StringBuffer();
		b.append("\n");
		b.append("[ ");
		b.append("Codigo: " + this.getCodigo());
		b.append(", ");
		b.append("Mensaje: " + this.getMessage());
		b.append(", ");
		b.append("Codigo Evento: " + this.getCodigoEvento());
		b.append("]");
		b.append("\n");
		b.append(stackTrace);
		return b.toString();
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<PortalSACException>");
		b.append("<codError>");
		b.append(this.getCodigo());
		b.append("</codError>");
		b.append("<desError>");
		b.append(this.getMessage());
		b.append("</desError>");
		b.append("</PortalSACException>");
		return b.toString();
	}

	public PortalSACException(String codError, String desError, Throwable e)
	{
		super(desError, e);
		this.setCodigo(codError);
	}

	public PortalSACException(String codError, String desError, long numEvento)
	{
		super(desError);
		this.setCodigo(codError);
		this.setCodigoEvento(numEvento);
	}

	public PortalSACException(String codError, String desError)
	{
		super(desError);
		this.setCodigo(codError);

	}
}
