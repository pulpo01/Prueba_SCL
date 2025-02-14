package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsRegistraCampanaByPInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.AbonadoDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AperturaRangoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.GaEquipAboserDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.OutAbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RestriccionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaOutDTO;

public class AbonadoBO {
	private AbonadoDAO abonadoDAO  = new AbonadoDAO();
	private static Category cat = Category.getInstance(AbonadoBO.class);
	Global global = Global.getInstance();
	
	/**
	 * Valida si la simcard esta asociado a un Abonado
	 * @param entradaValidacionVentas
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ResultadoValidacionVentaDTO  existeSerieSimcardEnAbonado(ParametrosValidacionVentasDTO entradaValidacionVentas)
	throws GeneralException{
		ResultadoValidacionVentaDTO resultado = null;
		cat.debug("Inicio:existeSerieSimcardEnAbonado()");
		resultado = abonadoDAO.getExisteSerieSimcardEnAbonado(entradaValidacionVentas); 
		if (resultado.getResultadoBase() == 1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0){
			resultado.setResultado(false);
		}
		cat.debug("Fin:existeSerieSimcardEnAbonado()");
		return resultado;
	}//fin existeSerieSimcardEnAbonado	
	
	/**
	 * Valida si el Terminal esta asociado a un Abonado
	 * @param entradaValidacionVentas
	 * @return resultado
	 * @throws GeneralException
	 */

	public ResultadoValidacionVentaDTO  existeSerieTerminalEnAbonado(ParametrosValidacionVentasDTO entradaValidacionVentas)
	throws GeneralException{
		ResultadoValidacionVentaDTO resultado = null;
		cat.debug("Inicio:existeSerieTerminalEnAbonado()");
		resultado = abonadoDAO.existeSerieTerminalEnAbonado(entradaValidacionVentas);
		if (resultado.getResultadoBase() ==1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0){
			resultado.setResultado(false);
		}
		cat.debug("Fin:existeSerieTerminalEnAbonado()");
		return resultado;
	}//fin existeSerieTerminalEnAbonado	

	
	
	public ResultadoValidacionVentaDTO  validaSerieTermialEnListaNegra(TerminalSNPNDTO terminal)
	throws GeneralException{
		ResultadoValidacionVentaDTO resultado = null;
		cat.debug("Inicio:validaSerieTermialEnListaNegra()");
		resultado = abonadoDAO.getValidaSerieTerminalListaNegra(terminal); 
		if (resultado.getResultadoBase() == 1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0){
			resultado.setResultado(false);
		}
		cat.debug("Fin:validaSerieTermialEnListaNegra()");
		return resultado;
	}//fin validaSerieTermialEnListaNegra
	
	/**
	 * Obtiene Oficina principal del Abonado en base a datos del vendedor
	 * @param vendedor
	 * @return resultado
	 * @throws GeneralException
	 */
	public AbonadoDTO  getOficinaPrincipal(VendedorDTO vendedor)
	throws GeneralException{
		AbonadoDTO resultado = new AbonadoDTO();
		cat.debug("Inicio:getOficinaPrincipal()");
		resultado = abonadoDAO.getOficinaPrincipal(vendedor); 
		cat.debug("Fin:getOficinaPrincipal()");
		return resultado;
	}//fin getOficinaPrincipal	
	
	/**
	 * Obtiene Numero de Secuencia para asignarlo a un Nuevo Abonado
	 * @param abonado
	 * @return abonado
	 * @throws GeneralException
	 */
	
	public AbonadoDTO getSecuenciaAbonado(AbonadoDTO abonado)
	throws GeneralException{
		cat.debug("Inicio:getSecuenciaAbonado()");
		abonado =abonadoDAO.getSecuenciaAbonado(abonado); 
		cat.debug("Fin:getSecuenciaAbonado()");
		return abonado;
	}
	/**
	 * Crea Abonado
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */
	public void creaAbonado(AbonadoDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:creaAbonado()");
		
		if( (entrada.getCodUsoSimcard() == 3) && entrada.getCodigoTipoPlan().equals("1")) {
			if( ((entrada.getCodUsoTerminal() == 3) && entrada.getCodigoTipoPlan().equals("1"))|| entrada.getIndProcEqTerminal().equals("E") ) {
				abonadoDAO.creaAbonadoprepago(entrada);
			}else{
				throw new GeneralException("112411",0,"Error Defincion de Aboando Uso Terminal no corresponde al tipo de plan");
			}
				
		}else if (( (entrada.getCodUsoSimcard() == 2) && entrada.getCodigoTipoPlan().equals("2")) || ( entrada.getCodUsoSimcard() == 10 && entrada.getCodigoTipoPlan().equals("3"))){
			
			if ( ( ((entrada.getCodUsoTerminal() == 2) && entrada.getCodigoTipoPlan().equals("2")) || (entrada.getCodUsoTerminal() == 10 && entrada.getCodigoTipoPlan().equals("3")) ) || entrada.getIndProcEqTerminal().equals("E") ){
				abonadoDAO.creaAbonado(entrada);	
			}else{
				throw new GeneralException("112411",0,"Error Defincion de Aboando Uso Terminal no corresponde al tipo de plan");
			}
			
		}else{
			throw new GeneralException("12411",0,"Error Defincion de Aboando Uso Simcard no corresponde al tipo de plan");	
		}
		
		
		
		
		cat.debug("Fin:creaAbonado()");
	}
	
	public void creaAbonadoCDMA(AbonadoDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:creaAbonado()");
				
			if( (entrada.getCodUsoTerminal() == 3) && entrada.getCodigoTipoPlan().equals("1") ) {
				abonadoDAO.creaAbonadoprepago(entrada);
			}else if ( ( ((entrada.getCodUsoTerminal() == 2) && entrada.getCodigoTipoPlan().equals("2")) || ( (entrada.getCodUsoTerminal() == 10) && entrada.getCodigoTipoPlan().equals("3")) ) ){
				abonadoDAO.creaAbonado(entrada);				
			}else{
				throw new GeneralException("112411",0,"Error Defincion de Aboando Uso Terminal no corresponde al tipo de plan");
			}						
		cat.debug("Fin:creaAbonado()");
	}	
	
	/**
	 * Asocia simcard con abonado en tabla ga_equipaboser
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */
	public void creaSimcardAboser(AbonadoDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:creaSimcardAboser()");
		abonadoDAO.creaSimcardAboser(entrada); 
		cat.debug("Fin:creaSimcardAboser()");
	}
	
	/**
	 * Asocia terminal con abonado en tabla ga_equipaboser
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */
	public void creaTerminalAboser(AbonadoDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:creaTerminalAboser()");
		abonadoDAO.creaTerminalAboser(entrada); 
		cat.debug("Fin:creaTerminalAboser()");
	}
	
	/**
	 * Obtiene Listado de abonados asociados a un numero de venta
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public AbonadoDTO[] getListaAbonadosVenta(RegistroVentaDTO entrada) 
	throws GeneralException{
		AbonadoDTO[] resultado;
		cat.debug("Inicio:creaTerminalAboser()");
		resultado = abonadoDAO.getListaAbonadosVenta(entrada); 
		cat.debug("Fin:creaTerminalAboser()");
		return resultado;
	}//fin getListaAbonadosVenta
	
	/**
	 * inserta monto garantia asociada al abonado
	 * @param entrada
	 * @return 
	 * @throws GeneralException
	 */
	public void insertaGarantiaAbonado(AbonadoDTO entrada)throws GeneralException{
		cat.debug("Inicio:insertaGarantiaAbonado()");
		abonadoDAO.insertaGarantiaAbonado(entrada); 
		cat.debug("Fin:insertaGarantiaAbonado()");
	} //insertaGarantiaAbonado
	

	/**
	 * Obtiene Listado de equipos seriados
	 * @param abonado
	 * @return resultado
	 * @throws GeneralException
	 */
	public AbonadoDTO[] getEquiposSeriados(AbonadoDTO abonado) 
	throws GeneralException{
		AbonadoDTO[] resultado;
		cat.debug("Inicio:getEquiposSeriados()");
		resultado = abonadoDAO.getEquiposSeriados(abonado); 
		cat.debug("Fin:getEquiposSeriados()");
		return resultado;
	}//fin getEquiposSeriados

	/**
	 * Actualiza tabla ga_equipaboser
	 * @param entrada
	 * @return void
	 * @throws GeneralException
	 */
	public void actualizaEquipAboSer(AbonadoDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:actualizaEquipAboSer()");
		abonadoDAO.actualizaEquipAboSer(entrada); 
		cat.debug("Fin:actualizaEquipAboSer()");
	}//fin actualizaEquipAboSer
	
	public void updateAboVendealer(String numAbonado) throws GeneralException{		
		
			cat.debug(" updateAboVendealer:start");
			abonadoDAO.updateAboVendealer(numAbonado);
			cat.debug(" updateAboVendealer:end");
	}
	
	public void setUpdateGaEquiAboser(GaEquipAboserDTO gaEquipAboserDTO)throws GeneralException{
		cat.debug("Inicio:actualizaEquipAboSer()");
		abonadoDAO.setUpdateGaEquiAboser(gaEquipAboserDTO); 
		cat.debug("Fin:actualizaEquipAboSer()");
	}

	/**
	 * Actualiza código situación del abonado
	 * @param abonado
	 * @return 
	 * @throws GeneralException
	 */
	public void updCodigoSituacion(AbonadoDTO abonadoDTO) 
	throws GeneralException{
		cat.debug("Inicio:updCodigoSituacion()");
		abonadoDAO.updCodigoSituacion(abonadoDTO); 
		cat.debug("Fin:updCodigoSituacion()");
	}//fin updCodigoSituacion
	
	/**
	 * Actualiza clase servicio para el abonado
	 * @param abonado
	 * @return abonado
	 * @throws GeneralException
	 */
	public void updAbonadoClaseServ(AbonadoDTO abonado) 
	throws GeneralException{
		cat.debug("Inicio:updAbonadoClaseServ()");
		abonadoDAO.updAbonadoClaseServ(abonado); 
		cat.debug("Fin:updAbonadoClaseServ()");
	}//fin updAbonadoClaseServ	
	
	/**
	 * Obtiene numero abonados vigentes por cliente
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */			
	public Long obtieneAbonadosVigentes(Long codCliente)
		throws GeneralException		
	{	
		cat.debug("Inicio:obtieneAbonadosVigentes()");
		Long resultado = abonadoDAO.obtieneAbonadosVigentes(codCliente); 
		cat.debug("Fin:obtieneAbonadosVigentes()");
		return resultado;
	}//fin updAbonadoClaseServ
	
	
	/**
	 * setDesMarcaAbonadoPortado
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
	public OutAbonadoPortadoDTO setDesMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		OutAbonadoPortadoDTO retValue=null;
		try{
			cat.debug("Inicio:setDesMarcaAbonadoPortado()");
			retValue=abonadoDAO.setDesMarcaAbonadoPortado(abonadoPortadoDTO);
			cat.debug("Fin:setDesMarcaAbonadoPortado()");
		}catch(GeneralException e){
			cat.debug("Error: General Exception");
			throw(e);
		}
		return retValue;
	}
	
	
	/**
	 * setMarcaAbonadoPortado
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
	public OutAbonadoPortadoDTO setMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		OutAbonadoPortadoDTO retValue=null;
		try{
			cat.debug("Inicio:setMarcaAbonadoPortado()");
			retValue=abonadoDAO.setMarcaAbonadoPortado(abonadoPortadoDTO);
			cat.debug("Fin:setMarcaAbonadoPortado()");
		}catch(GeneralException e){
			cat.debug("Error: General Exception");
			throw(e);
		}
		return retValue;
	}
	
	public RetornoDTO getPreActivaAbonado(AbonadoDTO inWSPreActivaAbonadoDTO)throws GeneralException{ 
		//RSIS 001
		RetornoDTO retValue=new RetornoDTO();
		try{
			cat.debug("SpnSclWSBean: preactivaAbonado:start");
			retValue=abonadoDAO.getPreActivaAbonado(inWSPreActivaAbonadoDTO);
			cat.debug("SpnSclWSBean: preactivaAbonado:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	public RetornoDTO getAperturaRango (AperturaRangoDTO aperturaRangoDTO)throws GeneralException{
		RetornoDTO retValue=new RetornoDTO();
		try{
			cat.debug("SpnSclWSBean: preactivaAbonado:start");
			retValue=abonadoDAO.getAperturaRango(aperturaRangoDTO);
			cat.debug("SpnSclWSBean: preactivaAbonado:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	/**
	 * Obtiene informacion de una linea dado el numero de celular
	 * @param WsInformacionLineaInDTO
	 * @return WsInformacionLineaOutDTO
	 * @throws GeneralException
	 */
	public WsInformacionLineaOutDTO getInformacionLinea(WsInformacionLineaInDTO wsInformacionLineaInDTO)
	throws GeneralException{
		WsInformacionLineaOutDTO retValue=new WsInformacionLineaOutDTO();
		try{
			cat.debug("Inicio: getInformacionLinea:start");
			retValue=abonadoDAO.getInformacionLinea(wsInformacionLineaInDTO);
			cat.debug("Fin: getInformacionLinea:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public AbonadoDTO getAbonadoPorNumCelular(AbonadoDTO abonadoDTO)throws GeneralException{
		AbonadoDTO retValue=null;
		try{
			cat.debug("Inicio: getAbonadoPorNumCelular:start");
			retValue=abonadoDAO.getAbonadoPorNumCelular(abonadoDTO);
			cat.debug("Fin: getAbonadoPorNumCelular:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	public RetornoDTO setUpdateAbonadoNumImei(AbonadoDTO abonadoDTO)throws GeneralException{
		RetornoDTO retValue=null;
		try{
			cat.debug("Inicio: setUpdateAbonadoNumImei:start");
			retValue=abonadoDAO.setUpdateAbonadoNumImei(abonadoDTO);
			cat.debug("Fin: setUpdateAbonadoNumImei:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}	
	
	public GaEquipAboserDTO[] getGaEquipAboser(GaEquipAboserDTO gaEquipAboserDTO)throws GeneralException{
		GaEquipAboserDTO[] retValue=null;
		try{
			cat.debug("Inicio: getGaEquipAboser:start");
			retValue=abonadoDAO.getGaEquipAboser(gaEquipAboserDTO);
			cat.debug("Fin: getGaEquipAboser:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, AbonadoDTO abonado)throws GeneralException{
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		try{
			cat.debug("Inicio: solicitaBajaAbonado:start");
			solicitaBajaAbonadoOut = abonadoDAO.solicitaBajaAbonado(solicitudBajaAbonadoDTO,abonado);
			cat.debug("Fin: solicitaBajaAbonado:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return solicitaBajaAbonadoOut;
	}
	
	
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO,AbonadoDTO abonado)throws GeneralException{
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		try{
			cat.debug("Inicio: solicitaBajaAbonado:start");
			solicitaBajaAbonadoOut = abonadoDAO.solicitaBajaAbonadoPrepago(solicitudBajaAbonadoDTO, abonado);
			cat.debug("Fin: solicitaBajaAbonado:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return solicitaBajaAbonadoOut;
	}	
	
	public ReservaOutDTO solicitaReserva(ReservaDTO solicitaReservaDTO)throws GeneralException{
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();
		try{
			cat.debug("Inicio: solicitaBajaAbonado:start");
			solicitaReservaOutDTO = abonadoDAO.solicitaReserva(solicitaReservaDTO);
			cat.debug("Fin: solicitaBajaAbonado:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return solicitaReservaOutDTO;
	}
	
	public ReservaOutDTO solicitaDesreserva(ReservaDTO solicitaReservaDTO)throws GeneralException{
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();
		try{
			cat.debug("Inicio: solicitaBajaAbonado:start");
			solicitaReservaOutDTO = abonadoDAO.solicitaDesreserva(solicitaReservaDTO);
			cat.debug("Fin: solicitaBajaAbonado:end");
		}
		catch(GeneralException e){
			cat.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			cat.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return solicitaReservaOutDTO;
	}
	
	
	public void ActualizaSituacionAbonado(GaVentasDTO gaVentasDTO, String codigoSituacion) 
	throws GeneralException{
		cat.debug("Inicio:ActualizaSituacionAbonado()");
		abonadoDAO.ActualizaSituacionAbonado(gaVentasDTO,codigoSituacion); 
		cat.debug("Fin:ActualizaSituacionAbonadov()");
	}	
	
	public void ejecutarRestriccion(RestriccionDTO restriccionDTO) 
	throws GeneralException{	
		cat.debug("Inicio:ejecutarRestriccion()");
		abonadoDAO.ejecutarRestriccion(restriccionDTO); 
		cat.debug("Fin:ejecutarRestriccion()");		
	}
	
	
	public void registraAltaAsincrono(WsCunetaAltaDeLineaOutDTO cunetaAltaDeLineaOut, String id_transaccion) 
	throws GeneralException
	{	
		cat.debug("Inicio:registraAltaAsincrono()");
		abonadoDAO.registraAltaAsincrono(cunetaAltaDeLineaOut, id_transaccion); 
		cat.debug("Fin:registraAltaAsincrono()");		
	}
	
	public WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono(String id_transaccion) 
	throws GeneralException
	{
		WsCunetaAltaDeLineaOutDTO CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO(); 
		cat.debug("Inicio:recuperarAltaAsincrono()");
		CunetaAltaDeLineaOut = abonadoDAO.recuperarAltaAsincrono(id_transaccion); 
		cat.debug("Fin:recuperarAltaAsincrono()");	
		return CunetaAltaDeLineaOut;
	}	
	
	public void regBeneficioPrepago(AbonadoDTO entrada) 
	throws GeneralException
	{	
		cat.debug("Inicio:regBeneficioPrepago()");
		abonadoDAO.regBeneficioPrepago(entrada); 
		cat.debug("Fin:regBeneficioPrepago()");			
	}
	
	
	public WsBeneficioPromocionOutDTO[] recCampanaBeneficio(WsBeneficioPromocionInDTO beneficioPromocion) 
	throws GeneralException
	{		 
		cat.debug("Inicio:recCampanaBeneficio()");
		WsBeneficioPromocionOutDTO[] retorno = abonadoDAO.recCampanaBeneficio(beneficioPromocion); 		
		cat.debug("Fin:recCampanaBeneficio()");
		return retorno;
	}	
	
	public void registraCampanaBeneficio(WsRegistraCampanaByPInDTO registraCampanaByPIn) 
	throws GeneralException
	{
		cat.debug("Inicio:registraCampanaBeneficio()");
	    abonadoDAO.registraCampanaBeneficio(registraCampanaByPIn); 		
		cat.debug("Fin:registraCampanaBeneficio()");			
	}
	
//	Inicio Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
	public void cancelaVenta(GaVentasDTO gaVentasDTO) 
	throws GeneralException{
		cat.debug("Inicio:cancelaVenta()");
		abonadoDAO.cancelaVenta(gaVentasDTO); 
		cat.debug("Fin:cancelaVenta()");
	}	
//	Fin Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
	
}//fin class Abonado
