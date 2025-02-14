package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoTerminalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoTerminalRestitucionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
public interface TerminalBOIT {
	
	public ResultadoValidacionLogisticaDTO  verificaRechazoSerie (ParametrosValidacionLogisticaDTO entrada)throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista(ParametrosCargoTerminalDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista(ParametrosCargoTerminalDTO entrada)throws ProductException;
	
	public TerminalDTO getTerminal(TerminalDTO entrada)	throws ProductException;
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista_PV(ParametrosCargoTerminalDTO entrada)	throws ProductException;
	
	//CSR11003
	public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista_Rest(ParametrosCargoTerminalRestitucionDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista_Rest(ParametrosCargoTerminalRestitucionDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista_Rest_PV(ParametrosCargoTerminalRestitucionDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoTerminal_Deducible_Rest(ParametrosCargoTerminalRestitucionDTO entrada) throws ProductException;
	//CSR11003
}
