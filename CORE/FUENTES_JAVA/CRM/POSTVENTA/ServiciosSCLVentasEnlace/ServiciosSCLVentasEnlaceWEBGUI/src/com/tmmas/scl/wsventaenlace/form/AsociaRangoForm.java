package com.tmmas.scl.wsventaenlace.form;

import java.util.List;

import org.apache.struts.action.ActionForm;

import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.CargaAsociaRangoDTO;

public class AsociaRangoForm extends ActionForm
{
	private static final long serialVersionUID = 1L;
	private String mostrarNroOOSS;
	private String accion;
	private String opcion;

	private String fecha;
	
	//Atributos de la carga
	private String numAbonado;
	private String rangosAsociadosSeleccionados[];
	private String rangosDisponiblesSeleccionados[];
	private CargaAsociaRangoDTO cargaAsociaRangoDTO;
	private List rangosAsociados;
	private List rangosDisponibles;
	private String comentario;
	
	//Atributos de la ejecucion
	
	//Atributos comunes
	private String numTransaccion;
	private String nomUsuarioSCL;
	private String codError;
	private String desError;
	private long nroOOSS;//Salida ejecucion
	
	//utilizados para ser llamados desde aplicación VB OOSS_WEB
	private String ordenServicio;
	private String key;
	private String userName;
	
	public String toString()
	{
		StringBuffer buffer = new StringBuffer("AsociaRangoForm: ");
		
		buffer.append("accion = [").append(accion).append("]");
		buffer.append(", opcion = [").append(opcion).append("]");
		buffer.append(", numAbonado = [").append(numAbonado).append("]");
		buffer.append(", numTransaccion = [").append(numTransaccion).append("]");
		buffer.append(", nomUsuarioSCL = [").append(nomUsuarioSCL).append("]");
		buffer.append(", ordenServicio = [").append(ordenServicio).append("]");
		buffer.append(", key = [").append(key).append("]");
		buffer.append(", userName = [").append(userName).append("]");
		buffer.append(", nroOOSS = [").append(nroOOSS).append("]");
		buffer.append(", comentario = [").append(comentario).append("]");
		
		if (rangosAsociados != null)
			buffer.append(", rangosAsociados.size = ").append(rangosAsociados.size());
		else
			buffer.append(", rangosAsociados = NULL");
		
		if (rangosDisponibles != null)
			buffer.append(", rangosDisponibles.size = ").append(rangosDisponibles.size());
		else
			buffer.append(", rangosDisponibles = NULL");
		
		if (rangosAsociadosSeleccionados != null)
		{
			buffer.append("\nrangosAsociadosSeleccionados:\n");
			
			for(int i = 0; i < rangosAsociadosSeleccionados.length; i++)
				buffer.append(rangosAsociadosSeleccionados[i]).append("\n");
		}
		
		if (rangosDisponiblesSeleccionados != null)
		{
			buffer.append("\nrangosDisponiblesSeleccionados:\n");
			
			for(int i = 0; i < rangosDisponiblesSeleccionados.length; i++)
				buffer.append(rangosDisponiblesSeleccionados[i]).append("\n");
		}
		
		return buffer.toString();
	}

	public void myReset()
	{
		rangosAsociadosSeleccionados = null;
		rangosDisponiblesSeleccionados = null;
		cargaAsociaRangoDTO = null;
		rangosAsociados = null;
		rangosDisponibles = null;
		codError = null;
		desError = null;
		fecha = null;
		comentario = null;
	}

	public String getAccion()
	{
		return accion;
	}

	public void setAccion(String accion)
	{
		this.accion = accion;
	}

	public CargaAsociaRangoDTO getCargaAsociaRangoDTO()
	{
		return cargaAsociaRangoDTO;
	}

	public void setCargaAsociaRangoDTO(CargaAsociaRangoDTO cargaAsociaRangoDTO)
	{
		this.cargaAsociaRangoDTO = cargaAsociaRangoDTO;
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

	public String getKey()
	{
		return key;
	}

	public void setKey(String key)
	{
		this.key = key;
	}

	public String getNomUsuarioSCL()
	{
		return nomUsuarioSCL;
	}

	public void setNomUsuarioSCL(String nomUsuarioSCL)
	{
		this.nomUsuarioSCL = nomUsuarioSCL;
	}

	public String getNumAbonado()
	{
		return numAbonado;
	}

	public void setNumAbonado(String numAbonado)
	{
		this.numAbonado = numAbonado;
	}

	public String getNumTransaccion()
	{
		return numTransaccion;
	}

	public void setNumTransaccion(String numTransaccion)
	{
		this.numTransaccion = numTransaccion;
	}

	public String getOpcion()
	{
		return opcion;
	}

	public void setOpcion(String opcion)
	{
		this.opcion = opcion;
	}

	public String getOrdenServicio()
	{
		return ordenServicio;
	}

	public void setOrdenServicio(String ordenServicio)
	{
		this.ordenServicio = ordenServicio;
	}

	public List getRangosAsociados()
	{
		return rangosAsociados;
	}

	public void setRangosAsociados(List rangosAsociados)
	{
		this.rangosAsociados = rangosAsociados;
	}

	public String[] getRangosAsociadosSeleccionados()
	{
		return rangosAsociadosSeleccionados;
	}

	public void setRangosAsociadosSeleccionados(
			String[] rangosAsociadosSeleccionados)
	{
		this.rangosAsociadosSeleccionados = rangosAsociadosSeleccionados;
	}

	public List getRangosDisponibles()
	{
		return rangosDisponibles;
	}

	public void setRangosDisponibles(List rangosDisponibles)
	{
		this.rangosDisponibles = rangosDisponibles;
	}

	public String[] getRangosDisponiblesSeleccionados()
	{
		return rangosDisponiblesSeleccionados;
	}

	public void setRangosDisponiblesSeleccionados(
			String[] rangosDisponiblesSeleccionados)
	{
		this.rangosDisponiblesSeleccionados = rangosDisponiblesSeleccionados;
	}

	public String getUserName()
	{
		return userName;
	}

	public void setUserName(String userName)
	{
		this.userName = userName;
	}

	public String getFecha()
	{
		return fecha;
	}

	public void setFecha(String fecha)
	{
		this.fecha = fecha;
	}

	public long getNroOOSS()
	{
		return nroOOSS;
	}

	public void setNroOOSS(long nroOOSS)
	{
		this.nroOOSS = nroOOSS;
	}

	public String getComentario()
	{
		return comentario;
	}

	public void setComentario(String comentario)
	{
		this.comentario = comentario;
	}

	public String getMostrarNroOOSS() {
		return mostrarNroOOSS;
	}

	public void setMostrarNroOOSS(String mostrarNroOOSS) {
		this.mostrarNroOOSS = mostrarNroOOSS;
	}
	
	
}
