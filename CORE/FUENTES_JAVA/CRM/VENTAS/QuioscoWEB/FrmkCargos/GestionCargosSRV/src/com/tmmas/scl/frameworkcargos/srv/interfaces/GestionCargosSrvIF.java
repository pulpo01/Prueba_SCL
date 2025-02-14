package com.tmmas.scl.frameworkcargos.srv.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosCodDescDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosRegistrarCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;

public interface GestionCargosSrvIF {
	
	public ObtencionCargosDTO getObtencionCargos(ParametrosObtencionCargosDTO parametros,ParametrosCodDescDTO[] listParametrosCodDescDTO)throws FrmkCargosException, GeneralException, Exception;
	
	public ResultadoRegCargosDTO registrarCargos(ParametrosRegistrarCargosDTO cargos)throws FrmkCargosException;
	
}
