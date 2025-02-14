package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

public interface AbonadoBeneficiarioBOIT {
	
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiarios(AbonadoDTO abonadoDTO) throws CustomerException;

	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiariosPorNumCelular(AbonadoDTO abonadoDTO) throws CustomerException ;
	
	public RetornoDTO insertAbonadosBeneficiarios(AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO) throws CustomerException;
	
	public RetornoDTO deleteAbonadoBeneficiario(AbonadoBeneficiarioDTO abonadoBeneficiarioDTO) throws CustomerException;
	
	public RetornoDTO caducaEliminaAbonadoBeneficiario(AbonadoBeneficiarioListDTO abonadoBeneficiarioDTO) throws CustomerException;	
}
