package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.GeSegUsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.GeSegUsuarioListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.TipIdentListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;

public interface GestionParametrosGeneralesSrvIF {

	public ConversionListDTO obtenerConversionOOSS(ConversionDTO param) throws SupOrdHanException;
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws SupOrdHanException;
	
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws SupOrdHanException;
	
	public ParametroDTO obtenerParametrosSimples(ParametroDTO param) throws SupOrdHanException;
	
	public TipIdentListDTO obtenerTiposDeIdentidad() throws SupOrdHanException;
	
	public RetornoDTO actualizarComentPvIorserv(IOOSSDTO os) throws SupOrdHanException;
	
	public RetornoDTO validarPortabilidad(AbonadoDTO abonado) throws SupOrdHanException;

	public ParametroListDTO obtenerParametrosGenerales() throws SupOrdHanException;	
	
	public GeSegUsuarioListDTO obtenerUsuariosPorCodVendedorNumVenta(AbonadoDTO abonadoDTO) throws SupOrdHanException;
	
	public GedCodigosListDTO obtenerListaGedCodigos(GedCodigosDTO gedCodigosDTO) throws SupOrdHanException ;
	
	public GeSegUsuarioListDTO obtenerUsuariosPorCodVendedorNumVenta(GeSegUsuarioDTO geSegUsuarioDTO) throws SupOrdHanException;
	
	public RetornoDTO getUsuariosPorNumVenta(String numVenta) throws SupOrdHanException;
	
}
