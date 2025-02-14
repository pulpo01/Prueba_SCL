package com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CalificacionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ConsultaHibridoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.FiltroAbonadosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaFiltroAbonadosDTO;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;

public interface GestionAbonadoSrvIF {

	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente) throws ManConException;
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ManConException;
	
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws ManConException;	

	public RetornoDTO consultaHibrido(ConsultaHibridoDTO consulta) throws ManConException;
	
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiarios(AbonadoDTO abonadoDTO) throws ManConException;
	
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiariosPorNumCelular(AbonadoDTO abonadoDTO) throws ManConException;
	
	public RetornoDTO agregaAbonadosBeneficiarios(AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO)throws ManConException;
	
	public RetornoDTO eliminaAbonadoBeneficiario(AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO)throws ManConException ;
	
	public RetornoDTO caducaEliminaAbonadoBeneficiario(AbonadoBeneficiarioListDTO abonadoBeneficiarioList) throws ManConException;
	
	public AbonadoDTO obtenerNumeroMovimientoAlta(AbonadoDTO abonado) throws ManConException;
	
	public AbonadoDTO obtenerDatosAbonadoByNumCelular(AbonadoDTO abonado) throws ManConException;
	
	public AbonadoVetadoListDTO obtieneAbonadosVetados(AbonadoDTO abonadoDTO)throws ManConException;
	
	public RetornoDTO actualizarAbonadoVetadoTerminoVigencia(AbonadoVetadoListDTO abonadoVetadoDTO)throws ManConException ;
	
	public RetornoDTO agregarAbonadosVetados(AbonadoVetadoListDTO abonadoVetadoListDTO)throws ManConException;

	public CuentaPersonalDTO obtenerNumeroPersonal(CuentaPersonalDTO cuentaPersonalDTO) throws ManConException;
	
	public AbonadoListDTO obtenerListaAbonadosFiltrados(FiltroAbonadosDTO filtro) throws ManConException;	
	
	public RetornoDTO validaFiltroAbonados(ValidaFiltroAbonadosDTO filtro) throws ManConException;
	
	public AbonadoDTO obtenerAbonadoEmpresa(ClienteDTO cliente) throws ManConException;
	
	public AbonadoListDTO obtieneBloqueAbonados(FiltroAbonadosDTO bloque) throws ManConException;
	
    // INICIO RRG 17-02-2009 COL 78551
	public int validaAbonadoBajaProgramada(long numAbonado) throws ManConException;
	// FIN RRG 17-02-2009 COL 78551
	
	public CalificacionAbonadoDTO obtieneCalificacionAbonado(CalificacionAbonadoDTO abonado) throws ManConException;
}
