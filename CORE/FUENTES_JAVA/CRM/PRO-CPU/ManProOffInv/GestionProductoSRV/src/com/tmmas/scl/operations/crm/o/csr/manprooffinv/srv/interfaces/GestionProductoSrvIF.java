package com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaPlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoScoringListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ReglasListaNumerosListDTO;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;

public interface GestionProductoSrvIF {

	public PlanTarifarioListDTO obtenerPlanesTarifarios(BusquedaPlanTarifarioDTO param) throws ManProOffInvException;
	
	public PlanTarifarioDTO obtenerTipoCobroPlanTarifario(PlanTarifarioDTO plan) throws ManProOffInvException;
	
	public ProductoOfertadoListDTO obtenerDetalleProductos(ProductoOfertadoListDTO productoOfertadoLista) throws ManProOffInvException;
	
	public ProductoOfertadoListDTO obtenerProductosOfertablesPorPaquete(PaqueteDTO paquete) throws ManProOffInvException;
	
	public ReglasListaNumerosListDTO obtenerRestriccionesLista(EspecServicioListaDTO especServicioLista) throws ManProOffInvException;
	
	public ProductoOfertadoListDTO obtenerProductosPorDefecto(AbonadoDTO abonado)throws ManProOffInvException;
	
	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ManProOffInvException;
	
	public ProductoOfertadoListDTO obtenerProductosOfertablesPaquetePorDefecto(PaqueteDTO paquete) throws ManProOffInvException;
	
	public PlanTarifarioDTO obtenerDetallePlanTarif(PlanTarifarioDTO planTarif) throws ManProOffInvException;
	
	public ProductoOfertadoListDTO obtenerProductosOfertablesporCanal(AbonadoDTO abonado) throws ManProOffInvException;
	
	public ProductoOfertadoListDTO obtenerLCplanAdicional(ProductoOfertadoListDTO productoOfertadoLista) throws ManProOffInvException, GeneralException;
	
	public LimiteConsumoProductoListDTO consultaAbonoLcProducto(LimiteConsumoProductoDTO limiteConsumoProducto);
	
	public TipoComportamientoListDTO obtenerTiposComportamiento() throws ManProOffInvException;
	
	public ProductoScoringListDTO obtenerProductosScoring(Long numAbonado) throws ManProOffInvException;
}
