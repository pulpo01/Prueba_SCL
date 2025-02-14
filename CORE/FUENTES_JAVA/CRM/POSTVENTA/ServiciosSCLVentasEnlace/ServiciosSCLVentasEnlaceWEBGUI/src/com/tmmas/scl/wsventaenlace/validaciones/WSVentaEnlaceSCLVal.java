package com.tmmas.scl.wsventaenlace.validaciones;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;

public interface WSVentaEnlaceSCLVal 
{
	public void validaOOSSDTONulo(OOSSDTO oossdto) throws ServicioVentasEnlaceException;
	public void validaNumeroAbonado(String numAbonado) throws ServicioVentasEnlaceException;
	public void validaNombreUsuarioSCL(String nomUsuarioSCL) throws ServicioVentasEnlaceException;
	public boolean validaLongitudParametros(String longitudValida, long longitudEvaluada) throws ServicioVentasEnlaceException;
	public boolean validaNoVacios(String atributo) throws ServicioVentasEnlaceException;
	public boolean validaLongitudParametroTexto(String longitudValida, String textoEvaluado) throws ServicioVentasEnlaceException;
}
