package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

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

public interface KitBOIT {
	
	public KitDTO actualizaStockKit(KitDTO kit)throws ProductException;
	
//	public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO entrada)	throws ProductException;
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException;
		
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException;
	
//	public KitDTO getIndicadorTelefono(KitDTO entrada)throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoKit_NoPrecioLista(ParametrosCargoKitDTO entrada)	throws ProductException;
	
	public PrecioCargoDTO[] getPrecioCargoKit_PrecioLista(ParametrosCargoKitDTO entrada)throws ProductException, GeneralException;
	
	public KitDTO getKit(KitDTO entrada)throws ProductException, GeneralException;
	
	public ResultadoValidacionLogisticaDTO numeroReservadoOK(ParametrosValidacionLogisticaDTO entrada) throws ProductException;
	
	public ProcesoDTO validaAutenticacionSerie(KitDTO entrada) throws ProductException;
	
//	public KitDTO getImsiSimcard(KitDTO simcard) throws ProductException;
	
//	public ResultadoValidacionLogisticaDTO validaLargoSerieSimcard(ParametrosValidacionLogisticaDTO entrada) throws ProductException;


}
