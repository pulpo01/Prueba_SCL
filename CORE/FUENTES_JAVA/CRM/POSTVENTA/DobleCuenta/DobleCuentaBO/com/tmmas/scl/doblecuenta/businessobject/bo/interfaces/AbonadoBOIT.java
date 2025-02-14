package com.tmmas.scl.doblecuenta.businessobject.bo.interfaces;

import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;

public interface AbonadoBOIT {
	
	public AbonadoDTO[] obtenerListaAbonado(AbonadoDTO abonado) throws ProyectoException;
	
	
}
