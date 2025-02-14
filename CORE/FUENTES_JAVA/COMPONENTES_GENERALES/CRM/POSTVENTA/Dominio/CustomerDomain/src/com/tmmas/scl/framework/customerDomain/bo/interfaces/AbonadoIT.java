package com.tmmas.scl.framework.customerDomain.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;


public interface AbonadoIT {
		
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws CustomerException;
	public UsuarioAbonadoDTO obtenerDatosUsuarioCelular(UsuarioAbonadoDTO UsuarioAbonado) throws CustomerException;	
	public UsuarioAbonadoDTO getPlanTarifarioDefault(UsuarioAbonadoDTO usuarioAbonadoDTO)throws CustomerException;
	public String obtenerCeldaAbonado(long numAbonado) throws CustomerException;
	/**
	 * Obtiene los datos del abonado para las OOSS Aviso y Anulacion de Siniestro.
	 * Package: PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_ABOCLIENTE2_PR
	 * @param abonado del tipo AbonadoDTO
	 * @return AbonadoDTO
	 * @throws CustomerException
	 * @author Santiago Ventura
	 * @date 15-04-2010 
	 */	
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws CustomerException;	
}
