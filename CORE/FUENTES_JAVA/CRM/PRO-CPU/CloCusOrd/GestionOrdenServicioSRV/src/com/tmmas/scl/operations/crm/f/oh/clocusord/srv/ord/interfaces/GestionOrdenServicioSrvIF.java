package com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RegReordPlanDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CambioPlanPendienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CartaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaCambioPlanDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EventoNumFrecDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PagoAnticipadoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PlanBatchDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CtaPersonalEmpDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaPermanenciaDTO;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RegistroColaDTO; // RRG

public interface GestionOrdenServicioSrvIF {

	public RetornoDTO registraNivelOoss(RegistroNivelOOSSDTO registro) throws CloCusOrdException;
	
	public RetornoDTO registraCambPlanBatch(PlanBatchDTO param) throws CloCusOrdException;
	
	public RetornoDTO eliminaCuentaPersonal(CuentaPersonalDTO cuenta) throws CloCusOrdException;
	
	public RetornoDTO reservaAmist(CuentaPersonalDTO cuenta) throws CloCusOrdException;
	
	public RetornoDTO validaPermanencia(ValidaPermanenciaDTO param) throws CloCusOrdException;	
	
	public RetornoDTO registrarOOSSEnLinea (RegistrarOossEnLineaDTO param)throws CloCusOrdException;
    //	 INI P-MIX-09003 OCB
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO param) throws CloCusOrdException;
   //	 fin P-MIX-09003 OCB
	
	public CambioPlanPendienteListDTO obtenerSolicPendPlan(ClienteDTO cliente) throws CloCusOrdException;
		
	public void validarActivarNumPer(CuentaPersonalDTO cuentaPersonalDTO)throws CloCusOrdException;

	public RetornoDTO validaDesactivaCuentaPersonal(CuentaPersonalDTO cuentaPersonalDTO)throws CloCusOrdException;

	public RetornoDTO insertarCarta(CartaDTO carta)throws CloCusOrdException;
	
	public RetornoDTO insertarFrecuentesProgramados (DesactServFreDTO desactServFre) throws CloCusOrdException;
	
	public RetornoDTO insertarFrecuentesOnline (DesactServFreDTO desactServFre) throws CloCusOrdException;
	
	public RetornoDTO insertarFrecuentesFFOnline (DesactServFreDTO desactServFre) throws CloCusOrdException;
	
	public RetornoDTO registrarCambioCuotas(RegReordPlanDTO regReordPlanDTO) throws CloCusOrdException;
	
	public RetornoDTO eliminarFrecuentesOnLine (DesactServFreDTO desactServFre) throws CloCusOrdException;
	
	public RetornoDTO insertarFrecuentesFFProgramados(DesactServFreDTO desactServFre)throws CloCusOrdException;
	
	public RetornoDTO actualizarIntarcelAbonado(AbonadoDTO abonado)throws CloCusOrdException;

	public RetornoDTO registrarFinciclo(AbonadoDTO abonado)throws CloCusOrdException;
	
	public EstadoProcesoOOSSDTO actualizarEstado(EstadoProcesoOOSSDTO estadoProcesoOOSS) throws CloCusOrdException;
	
	public RetornoDTO modificarNumeroPersonal(CuentaPersonalDTO cuenta) throws CloCusOrdException;
	
	public CuentaPersonalDTO obtieneNumeroCorporativo (CuentaPersonalDTO cuenta) throws CloCusOrdException;
	
	public RetornoDTO validaBajaAtlEmpresa(ClienteDTO cliente) throws CloCusOrdException;
	
	public CtaPersonalEmpDTO obtenerDatosCtaPersonalCliEmp(CtaPersonalEmpDTO cta) throws CloCusOrdException;
	
		// INC-77866; COL; 11-02-2009; AVC
	public RetornoDTO insertaTablaCola(RegistroColaDTO param) throws CloCusOrdException;
	
	//INI P-MIX-09003 pv 28-07-2009
	public EventoNumFrecDTO obtenerMontoEvento(EventoNumFrecDTO eventoNumFrecDTO) throws CloCusOrdException;
	
	public RetornoDTO insertarEventoNumFrec(EventoNumFrecDTO eventoNumFrecDTO) throws CloCusOrdException;
	//FIN P-MIX-09003 pv 28-07-2009
	
	public RetornoDTO regCausaCambioPlan(CausaCambioPlanDTO causaCambioPlan) throws CloCusOrdException;
	
	public RetornoDTO regPagoAnticipado(PagoAnticipadoDTO pagoAnticipado) throws CloCusOrdException;
}
