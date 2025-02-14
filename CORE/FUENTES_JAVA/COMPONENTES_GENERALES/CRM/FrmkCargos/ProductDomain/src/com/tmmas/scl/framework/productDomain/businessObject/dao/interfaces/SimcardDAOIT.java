package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSimcardRestitucionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;


public interface SimcardDAOIT {

	public SimcardDTO actualizaStockSimcard(SimcardDTO simcard)	throws ProductException;
	
	public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO lineaEntrada)throws ProductException;
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada)throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public SimcardDTO getImsiSimcard(SimcardDTO simcard)throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista(ParametrosCargoSimcardDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista(ParametrosCargoSimcardDTO entrada) throws ProductException;
	
	public SimcardDTO getSimcard(SimcardDTO simcard)throws ProductException;
	
	public ProcesoDTO validaAutenticacionSerie(SimcardDTO entrada)throws ProductException;
	
	public ResultadoValidacionLogisticaDTO getLargoSerieSimcard(ParametrosValidacionLogisticaDTO entrada)throws ProductException;
	
	public ResultadoValidacionLogisticaDTO getNumeroReservadoOK(ParametrosValidacionLogisticaDTO entrada)throws ProductException;
	
	public SimcardDTO getIndicadorTelefono(SimcardDTO entrada)throws ProductException;
	
	//CSR11003
	
	public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista_Rest(ParametrosCargoSimcardRestitucionDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista_Rest(ParametrosCargoSimcardRestitucionDTO entrada) throws ProductException;
	
	//CSR11003
	
}
