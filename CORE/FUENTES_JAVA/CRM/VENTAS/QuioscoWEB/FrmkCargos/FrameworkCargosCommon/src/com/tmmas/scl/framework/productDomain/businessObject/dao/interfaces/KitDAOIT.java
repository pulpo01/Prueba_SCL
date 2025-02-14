package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.KitDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoKitDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface KitDAOIT {

	public KitDTO actualizaStockKit(KitDTO kit)	throws ProductException;
	
//	public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO lineaEntrada)throws ProductException;
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada)throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada) throws ProductException;
	
//	public DescuentoDTO[] getDescuentoCargoConceptoCol(ParametrosDescuentoDTO entrada) throws ProductException;
	
//	public SimcardDTO getImsiSimcard(SimcardDTO simcard)throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoKit_NoPrecioLista(ParametrosCargoKitDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoKit_PrecioLista(ParametrosCargoKitDTO entrada) throws ProductException, GeneralException;
	
	public KitDTO getKit(KitDTO kit)throws ProductException, GeneralException;
	
	public ProcesoDTO validaAutenticacionSerie(KitDTO entrada)throws ProductException;
	
//	public ResultadoValidacionLogisticaDTO getLargoSerieSimcard(ParametrosValidacionLogisticaDTO entrada)throws ProductException;
	
	public ResultadoValidacionLogisticaDTO getNumeroReservadoOK(ParametrosValidacionLogisticaDTO entrada)throws ProductException;
	
//	public KitDTO getIndicadorTelefono(KitDTO entrada)throws ProductException;
	
	
}
