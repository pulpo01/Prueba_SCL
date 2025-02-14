package com.tmmas.scl.doblecuenta.businessobject.dao.interfaces;

import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;

public interface AbonadoDAOIT {
	
	public AbonadoDTO[] obtenerListaAbonado(AbonadoDTO abonado) throws ProyectoException;
	
	
	
}
