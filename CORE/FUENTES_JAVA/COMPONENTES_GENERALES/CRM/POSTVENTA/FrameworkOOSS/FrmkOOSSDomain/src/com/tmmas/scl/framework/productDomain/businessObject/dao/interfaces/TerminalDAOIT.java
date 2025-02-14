package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoTerminalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface TerminalDAOIT {

	public ResultadoValidacionLogisticaDTO verificaRechazoSerie (ParametrosValidacionLogisticaDTO lineaEntrada) throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista(ParametrosCargoTerminalDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista(ParametrosCargoTerminalDTO entrada) throws ProductException;
	
	public TerminalDTO getTerminal(TerminalDTO entrada)	throws ProductException;
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException;
	
}
