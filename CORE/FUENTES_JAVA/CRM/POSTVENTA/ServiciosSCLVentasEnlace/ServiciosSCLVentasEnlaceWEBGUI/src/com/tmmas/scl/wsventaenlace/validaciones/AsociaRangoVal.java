package com.tmmas.scl.wsventaenlace.validaciones;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.CargaAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.EjecucionAsociaRangoDTO;

public class AsociaRangoVal implements WSVentaEnlaceSCLVal
{
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private GlobalProperties global =  GlobalProperties.getInstance();
	private CargaAsociaRangoDTO cargaAsociaRangoDTO;
	private EjecucionAsociaRangoDTO ejecucionAsociaRangoDTO;
	
	public AsociaRangoVal()
	{
	}
	
	public void validarCarga(CargaAsociaRangoDTO cargaAsociaRangoDTO) throws ServicioVentasEnlaceException
	{
		if (cargaAsociaRangoDTO == null)
			throw new ServicioVentasEnlaceException("ERR.0001", 1, global.getValor("ERR.0001"));
		
		this.cargaAsociaRangoDTO = cargaAsociaRangoDTO;
		
		validaNumeroAbonado("" + cargaAsociaRangoDTO.getNumAbonado());
		validaNombreUsuarioSCL(cargaAsociaRangoDTO.getNomUsuarioSCL());
	}
	
	public void validarEjecucion(EjecucionAsociaRangoDTO ejecucionAsociaRangoDTO) throws ServicioVentasEnlaceException
	{
		if (ejecucionAsociaRangoDTO == null)
			throw new ServicioVentasEnlaceException("ERR.0001", 1, global.getValor("ERR.0001"));
		
		this.ejecucionAsociaRangoDTO = ejecucionAsociaRangoDTO;
		
		validarCambios();
	}
	
	private void validarCambios() throws ServicioVentasEnlaceException
	{
		if 
		(
			(ejecucionAsociaRangoDTO.getRangosAdicionados() == null || ejecucionAsociaRangoDTO.getRangosAdicionados().length < 1)
			&&
			(ejecucionAsociaRangoDTO.getRangosEliminados() == null || ejecucionAsociaRangoDTO.getRangosEliminados().length < 1)
		)
			throw new ServicioVentasEnlaceException("ERR.0601", 1, global.getValor("ERR.0601"));
	}

	public boolean validaLongitudParametros(String longitudValida, long longitudEvaluada) throws ServicioVentasEnlaceException
	{
		return false;
	}
	
	public void validarLongitudParametrosCarga() throws ServicioVentasEnlaceException
	{
		if (cargaAsociaRangoDTO.getNomUsuarioSCL() == null || cargaAsociaRangoDTO.getNomUsuarioSCL().length() < 1)
			throw new ServicioVentasEnlaceException("ERR.0007", 1, global.getValor("ERR.0007"));
	}	
	
	public boolean validaNoVacios(String atributo) throws ServicioVentasEnlaceException
	{
		return false;
	}

	public boolean validaLongitudParametroTexto(String longitudValida, String textoEvaluado) throws ServicioVentasEnlaceException
	{
		return false;
	}

	public void validaNombreUsuarioSCL(String nomUsuarioSCL) throws ServicioVentasEnlaceException
	{
		if (nomUsuarioSCL == null)
			throw new ServicioVentasEnlaceException("ERR.0605", 1, global.getValor("ERR.0605"));
		
		if (nomUsuarioSCL.length() < 2)
			throw new ServicioVentasEnlaceException("ERR.0600", 1, global.getValor("ERR.0600"));
	}

	public void validaNumeroAbonado(String numAbonado) throws ServicioVentasEnlaceException
	{
		if (numAbonado == null)
			throw new ServicioVentasEnlaceException("ERR.0600", 1, global.getValor("ERR.0600"));
		
		try
		{
			new Long(numAbonado);
		}
		catch(Throwable t)
		{
			throw new ServicioVentasEnlaceException("ERR.0600", 1, global.getValor("ERR.0600"));
		}
	}

	public void validaOOSSDTONulo(OOSSDTO oossdto) throws ServicioVentasEnlaceException
	{
	}
}
