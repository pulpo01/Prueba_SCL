/**
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 08/06/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.altacliente.service.servicios;

import java.rmi.RemoteException;

import javax.ejb.SessionContext;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.altacliente.service.helper.Global;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CampanaVigenteComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CargoLaboralDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteAltaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosCobranzaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosRecaudacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosGeneralesComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.MensajePromocionalDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadCancelacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadPagoComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OperadoraDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.PlanComercialComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.PlanTarifarioComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ProfesionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ProspectoComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ReferenciaClienteDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.RegistroFacturacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.RepresentanteLegalComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.SegmentoDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TarjetaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TipoCuentaBancariaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.VendedorComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.CiclosdeFacturacionExclusivos;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.CampanaVigente;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Cliente;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.ConceptosCobranza;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.ConceptosRecaudacion;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Cuenta;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.DatosGenerales;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Direccion;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Factura;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.IdentificadorCivil;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.ModalidadPago;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Oficina;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Prospecto;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroEvaluacionRiesgo;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroFacturacion;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Vendedor;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaCuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ConceptosCobranzaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ConceptosRecaudacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosAnexoTerminalesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FacturaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.OficinaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProspectoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroEvaluacionRiesgoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RepresentanteLegalDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.productdomain.businessobject.bo.ParametrosGenerales;
import com.tmmas.cl.scl.productdomain.businessobject.bo.PlanComercial;
import com.tmmas.cl.scl.productdomain.businessobject.bo.PlanTarifario;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanComercialDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;

public class AltaClienteSrv {

	private static boolean visibleNivelFacturacion = false;
	private static boolean visibleIndicadorMorosidad = false;
	private ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();	
	private Prospecto prospectoBO = new Prospecto();
	private Direccion direccionBO = new Direccion();
	private Cliente clienteBO = new Cliente();
	private Cuenta cuentaBO = new Cuenta();
	private DatosGenerales datosGeneralesBO = new DatosGenerales();
	
	private final Logger logger = Logger.getLogger(AltaClienteSrv.class);
	private SessionContext context = null;
	private CompositeConfiguration config;
	
	Global global = Global.getInstance();
	
	public AltaClienteSrv()
	{
		logger.debug("AltaClienteSrv():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("AltaClienteSrv.log"));
		logger.debug("AltaClienteSrv():End");
	}

	/**
	 * Obtiene nivel de facturación
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return conceptosCobranzaComDTO
	 * @throws AltaClienteException
	 */
	public ConceptosCobranzaComDTO getNivelFacturacion()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getNivelFacturacion()");
		ConceptosCobranzaComDTO conceptosCobranzaComDTO = null;
		try {
			ConceptosCobranza conceptosCobranzaBO = new ConceptosCobranza();
			ConceptosCobranzaDTO conceptosCobranzaDTO = new ConceptosCobranzaDTO();
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.codigo.abc"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			conceptosCobranzaDTO.setCodigoABC(parametrosGeneralesDTO.getValorparametro());
			conceptosCobranzaDTO = conceptosCobranzaBO.getDescripcionABC(conceptosCobranzaDTO);
			conceptosCobranzaDTO.setCodigoABC(parametrosGeneralesDTO.getValorparametro());
			MapperIF mapper = new DozerBeanMapper();
			conceptosCobranzaComDTO = (ConceptosCobranzaComDTO) mapper.map(conceptosCobranzaDTO, ConceptosCobranzaComDTO.class);
			conceptosCobranzaComDTO.setVisible(visibleNivelFacturacion);
			
		} catch (CustomerDomainException e) {
			logger.debug("getNivelFacturacion:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (ProductDomainException e) {
			logger.debug("getNivelFacturacion:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getNivelFacturacion()");
		return conceptosCobranzaComDTO;
	}// fin getNivelFacturacion

	/**
	 * Obtiene indicador Morosidad
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return conceptosCobranzaComDTO
	 * @throws AltaClienteException
	 */

	public ConceptosCobranzaComDTO getIndicadorMorosidad()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getIndicadorMorosidad()");
		ConceptosCobranzaComDTO conceptosCobranzaComDTO = null;
		try {
			ConceptosCobranza conceptosCobranzaBO = new ConceptosCobranza();
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.codigo.123"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			ConceptosCobranzaDTO conceptosCobranzaDTO = new ConceptosCobranzaDTO();
			conceptosCobranzaDTO.setCodigo123(parametrosGeneralesDTO.getValorparametro());
			conceptosCobranzaDTO = conceptosCobranzaBO.getDescripcion123(conceptosCobranzaDTO);
			conceptosCobranzaDTO.setCodigo123(parametrosGeneralesDTO.getValorparametro());
			MapperIF mapper = new DozerBeanMapper();
			conceptosCobranzaComDTO = (ConceptosCobranzaComDTO) mapper.map(conceptosCobranzaDTO, ConceptosCobranzaComDTO.class);
			conceptosCobranzaComDTO.setVisible(visibleIndicadorMorosidad);
		} catch (CustomerDomainException e) {
			logger.debug("getIndicadorMorosidad:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (ProductDomainException e) {
			logger.debug("getIndicadorMorosidad:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getIndicadorMorosidad()");
		return conceptosCobranzaComDTO;

	}// fin getIndicadorMorosidad

	/**
	 * Obtiene listado de tipos de clientes
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayClienteComDTO
	 * @throws AltaClienteException
	 */

	public ClienteComDTO[] getTipoCliente() 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getTipoCliente()");
		// Busca tipo cliente por defecto
		ClienteComDTO clienteComDTO = getTipoClientePorDefecto();
		ClienteComDTO[] arrayClienteComDTO = new ClienteComDTO[2];
		arrayClienteComDTO[0] = new ClienteComDTO();
		arrayClienteComDTO[0].setCodigoTipoCliente(global.getValor("codigo.cliente.empresa"));
		arrayClienteComDTO[0].setTipoCliente(global.getValor("cliente.empresa"));
		arrayClienteComDTO[1] = new ClienteComDTO();
		arrayClienteComDTO[1].setTipoCliente(global.getValor("cliente.particular"));
		arrayClienteComDTO[1].setCodigoTipoCliente(global.getValor("codigo.cliente.particular"));
		try {
			for (int i = 0; i < arrayClienteComDTO.length; i++) {
				if (arrayClienteComDTO[i].getTipoCliente().equals(
						clienteComDTO.getTipoCliente())) {
					ClienteComDTO.indiceDefectoTipoCliente=i;
				}
			}
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}

		logger.debug("Fin:getTipoCliente()");
		return arrayClienteComDTO;
	}// fin getTipoCliente

	/**
	 * Obtiene tipo cliente por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return clienteComDTO
	 * @throws
	 */

	private ClienteComDTO getTipoClientePorDefecto() 
	{
		ClienteComDTO clienteComDTO = new ClienteComDTO();
		clienteComDTO.setTipoCliente(global.getValor("cliente.empresa"));
		return clienteComDTO;

	}// fin getTipoClientePorDefecto

	/**
	 * Obtiene listado de tipo de identificadores civiles
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayIdentCivilCommon
	 * @throws AltaClienteException
	 */

	public IdentificadorCivilComDTO[] getTipoIdentificadoresCiviles()
		throws AltaClienteException 
	{
		// Obtiene el identificador civil por defecto
		IdentificadorCivilComDTO[] arrayIdentCivilCommon = null;
		try {
			ParametrosGeneralesDTO parametrosGeneralesDTO = getTipoIdentificacionCivilPorDefecto();
			logger.debug("getTipoIdentificadoresCiviles():start");

			IdentificadorCivilDTO[] arrayIdentCivil = null;
			IdentificadorCivil identificadorCivilBO = new IdentificadorCivil();
			arrayIdentCivil = identificadorCivilBO.getListTiposIdentif();
			if (arrayIdentCivil != null) {
				MapperIF mapper = new DozerBeanMapper();
				arrayIdentCivilCommon = new IdentificadorCivilComDTO[arrayIdentCivil.length];
				for (int i = 0; i < arrayIdentCivil.length; i++) {

					IdentificadorCivilComDTO identificadorCommon = new IdentificadorCivilComDTO();
					mapper.map(arrayIdentCivil[i], identificadorCommon);
					arrayIdentCivilCommon[i] = identificadorCommon;
					if (arrayIdentCivilCommon[i].getCodigoTipIdentif().equals(
							parametrosGeneralesDTO.getValorparametro())) {
						IdentificadorCivilComDTO.indiceDefectoTipoIdentificador=i;
						
					}
				}
			}

			logger.debug("getTipoIdentificadoresCiviles():end");
		} catch (CustomerDomainException e) {
			logger.debug("getTipoIdentificadoresCiviles:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (ProductDomainException e) {
			logger.debug("getTipoIdentificadoresCiviles:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		return arrayIdentCivilCommon;
	}

	
	/**
	 * Obtiene listado de clasificaciones de cuenta
	 * 
	 * @author Mario Tigua
	 * @param
	 * @return arrayCuentaCommon
	 * @throws AltaClienteException
	 */

	public CuentaComDTO[] getListaClasificacionCuenta()
		throws AltaClienteException 
	{
		CuentaComDTO[] arrayCuentaCommon = null; 
		
		try {
			logger.debug("getListaClasificacionCuenta():start");
			CuentaDTO[] arrayCuenta = null;
			Cuenta cuentaBO = new Cuenta(); 
			arrayCuenta = cuentaBO.getListClasificacionCuenta();

			if (arrayCuenta != null) {
				MapperIF mapper = new DozerBeanMapper();
				arrayCuentaCommon = new CuentaComDTO[arrayCuenta.length];
				for (int i = 0; i < arrayCuenta.length; i++) {
					CuentaComDTO cuentaCommon = new CuentaComDTO();
					mapper.map(arrayCuenta[i], cuentaCommon);
					arrayCuentaCommon[i] = cuentaCommon;
				}
			}
			logger.debug("getListaClasificacionCuenta():end");
		}catch (CustomerDomainException e) {
			logger.debug("getListaClasificacionCuenta:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		}catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		return arrayCuentaCommon;
	}

	/**
	 * Obtiene listado de tipos de comisionista
	 * 
	 * @author Mario Tigua
	 * @param
	 * @return arrayVendedorCommon
	 * @throws AltaClienteException
	 */

	public VendedorComDTO[] getTipoComisionista()
		throws AltaClienteException 
	{
		VendedorComDTO[] arrayVendedorCommon = null;
		
		try {
			logger.debug("getTipoComisionista():start");
			VendedorDTO[] arrayVendedor = null;
			Vendedor vendedorBO = new Vendedor();
			arrayVendedor= vendedorBO.getListTiposComisionistas();
			
			if (arrayVendedor != null) {
				MapperIF mapper = new DozerBeanMapper();
				arrayVendedorCommon = new VendedorComDTO[arrayVendedor.length];
				for (int i = 0; i < arrayVendedor.length; i++) {
					VendedorComDTO vendedorCommon = new VendedorComDTO(); 
					mapper.map(arrayVendedor[i], vendedorCommon);
					arrayVendedorCommon[i] = vendedorCommon;
				}
			}
			logger.debug("getTipoComisionista():end");
		}catch (CustomerDomainException e) {
			logger.debug("getTipoComisionista:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		}catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		return arrayVendedorCommon;
	}
	
	
	/**
	 * Obtiene tipo identificación civil por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return parametrosGeneralesDTO
	 * @throws ProductDomainException
	 */

	private ParametrosGeneralesDTO getTipoIdentificacionCivilPorDefecto()
		throws ProductDomainException 
	{
		logger.debug("Inicio:getTipoIdentificacionCivilPorDefecto()");
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		parametrosGeneralesDTO.setCodigomodulo(global
				.getValor("codigo.modulo.GA"));
		parametrosGeneralesDTO.setNombreparametro(global
				.getValor("parametro.codigo.tipident.defecto"));
		parametrosGeneralesDTO.setCodigoproducto(global
				.getValor("codigo.producto"));
		ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
		parametrosGeneralesDTO = parametrosGeneralesBO
				.getParametroGeneral(parametrosGeneralesDTO);
		logger.debug("Fin:getTipoIdentificacionCivilPorDefecto()");
		return parametrosGeneralesDTO;
	}// fin getCategoriaClientePorDefecto


	/**
	 * Obtiene categoria cliente por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return parametrosGeneralesDTO
	 * @throws ProductDomainException
	 */

	private ParametrosGeneralesDTO getCategoriaClientePorDefecto()
		throws ProductDomainException 
	{
		logger.debug("Inicio:getCategoriaClientePorDefecto()");
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		parametrosGeneralesDTO.setCodigomodulo(global
				.getValor("codigo.modulo.GA"));
		parametrosGeneralesDTO.setNombreparametro(global
				.getValor("parametro.categoria.cliente.defecto"));
		parametrosGeneralesDTO.setCodigoproducto(global
				.getValor("codigo.producto"));
		ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
		parametrosGeneralesDTO = parametrosGeneralesBO
				.getParametroGeneral(parametrosGeneralesDTO);
		logger.debug("Fin:getCategoriaClientePorDefecto()");
		return parametrosGeneralesDTO;
	}// fin getCategoriaClientePorDefecto

	/**
	 * Obtiene Listado de idiomas configurados en SCL
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayDatosGeneralesComDTO
	 * @throws CustomerDomainException
	 */

	public DatosGeneralesComDTO[] getIdiomas() 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getIdiomas()");
		DatosGeneralesComDTO[] arrayDatosGeneralesComDTO = null;
		try {
			// Obtiene el idioma por defecto
			DatosGeneralesDTO datosGeneralesDTO2 = getIdiomaPorDefecto();
			DatosGenerales datosGeneralesBO = new DatosGenerales();
			DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoModulo(global
					.getValor("codigo.modulo.GE"));
			datosGeneralesDTO.setTabla(global.getValor("nombre.tabla.idioma"));
			datosGeneralesDTO.setColumna(global
					.getValor("nombre.columna.idioma"));
			DatosGeneralesDTO[] arrayDatosGeneralesDTO = datosGeneralesBO
					.getListCodigos(datosGeneralesDTO);
			if (arrayDatosGeneralesDTO != null) {
				arrayDatosGeneralesComDTO = new DatosGeneralesComDTO[arrayDatosGeneralesDTO.length];
				for (int i = 0; i < arrayDatosGeneralesDTO.length; i++) {
					DatosGeneralesComDTO datosGeneralesComDTO = new DatosGeneralesComDTO();
					MapperIF mapper = new DozerBeanMapper();
					datosGeneralesComDTO = (DatosGeneralesComDTO) mapper.map(
							arrayDatosGeneralesDTO[i],
							DatosGeneralesComDTO.class);
					arrayDatosGeneralesComDTO[i] = datosGeneralesComDTO;
					// Asigna valor 1 al idioma por defecto
					if (arrayDatosGeneralesComDTO[i].getCodigoValor().equals(
							datosGeneralesDTO2.getCodigoValor())) {
						DatosGeneralesComDTO.indiceDefectoIdioma=i;
					} 
				}
			}
		} catch (CustomerDomainException e) {
			logger.debug("getIdiomas():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getIdiomas()");
		return arrayDatosGeneralesComDTO;
	}// fin getIdiomas

	/**
	 * Obtiene idioma por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return datosGeneralesDTO
	 * @throws
	 */

	private DatosGeneralesDTO getIdiomaPorDefecto() 
	{
		logger.debug("Inicio:getIdiomaPorDefecto()");
		DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
		datosGeneralesDTO.setCodigoValor(global
				.getValor("codigo.idioma.defecto"));
		logger.debug("Fin:getIdiomaPorDefecto()");
		return datosGeneralesDTO;
	}

	/**
	 * Obtiene Listado de oficinas registradas en SCL
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayOficinaComDTO
	 * @throws CustomerDomainException
	 */

	public OficinaComDTO[] getOficinas(OficinaComDTO oficinaComDTO) 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getOficinas()");
		OficinaComDTO[] arrayOficinaComDTO = null;
		try {
			Oficina oficinaBO = new Oficina();
			OficinaDTO[] arrayOficinasDTO = oficinaBO.getListOficinasSCL(oficinaComDTO.getNombreUsuario());

			if (arrayOficinasDTO != null) {
				arrayOficinaComDTO = new OficinaComDTO[arrayOficinasDTO.length];
				for (int i = 0; i < arrayOficinasDTO.length; i++) {
					OficinaComDTO oficinaComDTO2 = new OficinaComDTO();
					MapperIF mapper = new DozerBeanMapper();
					oficinaComDTO2 = (OficinaComDTO) mapper.map(
							arrayOficinasDTO[i], OficinaComDTO.class);
					arrayOficinaComDTO[i] = oficinaComDTO2;
					if (arrayOficinaComDTO[i].getCodigoOficina().equals(
							oficinaComDTO.getCodigoOficina())) {
						OficinaComDTO.indiceDefectoOficina=i;
					}  
				}
			}
			logger.debug("Fin:getOficinas()");
		} catch (CustomerDomainException e) {
			logger.debug("getIdiomas():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		return arrayOficinaComDTO;
	}// fin getOficinas

	/**
	 * Obtiene listado de planes comerciales
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayPlanComercialComDTO
	 * @throws CustomerDomainException,
	 *             ProductDomainException
	 */

	public PlanComercialComDTO[] getPlanesComerciales()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getPlanesComerciales()");
		PlanComercialComDTO[] arrayPlanComercialComDTO = null;
		try {
			ParametrosGeneralesDTO parametrosGeneralesDTO2 = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO2.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO2.setNombreparametro(global.getValor("parametro.plan.comercial.defecto"));
			parametrosGeneralesDTO2.setCodigoproducto(global.getValor("codigo.producto"));
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
			parametrosGeneralesDTO2 = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO2);
			PlanComercial planComercialBO = new PlanComercial();
			PlanComercialDTO planComercialDTO = new PlanComercialDTO();
			planComercialDTO.setCodigoCalifCliente(parametrosGeneralesDTO2.getValorparametro());
			PlanComercialDTO[] arrayPlanComercialDTO = planComercialBO.getListPlanComercialCalCte(planComercialDTO);
			if (arrayPlanComercialDTO != null) {
				arrayPlanComercialComDTO = new PlanComercialComDTO[arrayPlanComercialDTO.length];
				for (int i = 0; i < arrayPlanComercialDTO.length; i++) {
					MapperIF mapper = new DozerBeanMapper();
					PlanComercialComDTO planComercialComDTO = (PlanComercialComDTO) mapper.map(arrayPlanComercialDTO[i],
									PlanComercialComDTO.class);
					arrayPlanComercialComDTO[i] = planComercialComDTO;
				}
			}
			logger.debug("Fin:getPlanesComerciales()");
		} catch (ProductDomainException e) {
			logger.debug("getPlanesComerciales:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		return arrayPlanComercialComDTO;
	}// fin getPlanesComerciales

	/**
	 * Obtiene listado de categorias impositivas
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayClienteComDTO
	 * @throws CustomerDomainException
	 */

	public ClienteComDTO[] getCategoriasImpositivas()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getCategoriasImpositivas()");
		ClienteComDTO[] arrayClienteComDTO = null;
		try {
			// Obtiene la categoria impositiva por defecto
			ParametrosGeneralesDTO parametrosGeneralesDTO = getCategoriaImpositivaPorDefecto();			
			ClienteDTO[] arrayClienteDTO = clienteBO.getListCategImpositivas();

			if (arrayClienteDTO != null) {
				arrayClienteComDTO = new ClienteComDTO[arrayClienteDTO.length];
				for (int i = 0; i < arrayClienteDTO.length; i++) {
					ClienteComDTO clienteComDTO = new ClienteComDTO();
					MapperIF mapper = new DozerBeanMapper();
					clienteComDTO = (ClienteComDTO) mapper.map(
							arrayClienteDTO[i], ClienteComDTO.class);
					// Asigna valor 1 a la categoria por defecto
					arrayClienteComDTO[i] = clienteComDTO;
					if (arrayClienteComDTO[i].getCodigoCategImpos().equals(
							parametrosGeneralesDTO.getValorparametro())) {
						ClienteComDTO.indiceDefectoCategoriaImpositiva=i;
					}
				}
			}
			logger.debug("Fin:getCategoriasImpositivas()");
		} catch (CustomerDomainException e) {
			logger.debug("getCategoriasImpositivas():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (ProductDomainException e) {
			logger.debug("getCategoriasImpositivas:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		return arrayClienteComDTO;

	}// fin getCategoriasImpositivas

	/**
	 * Obtiene categoria impositiva por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayDatosGeneralesComDTO
	 * @throws CustomerDomainException
	 */

	private ParametrosGeneralesDTO getCategoriaImpositivaPorDefecto()
		throws CustomerDomainException, ProductDomainException 
	{
		logger.debug("Inicio:getCategoriaImpositivaPorDefecto()");
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		parametrosGeneralesDTO.setCodigomodulo(global
				.getValor("codigo.modulo.GA"));
		parametrosGeneralesDTO.setNombreparametro(global
				.getValor("parametro.categoria.impositiva.defecto"));
		parametrosGeneralesDTO.setCodigoproducto(global
				.getValor("codigo.producto"));
		ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
		parametrosGeneralesDTO = parametrosGeneralesBO
				.getParametroGeneral(parametrosGeneralesDTO);
		logger.debug("Inicio:getCategoriaImpositivaPorDefecto()");
		return parametrosGeneralesDTO;

	}// fin getCategoriaImpositivaPorDefecto

	/**
	 * Obtiene listado de categorias tributarias disponibles en SCL
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayDatosGeneralesComDTO
	 * @throws CustomerDomainException
	 */

	public DatosGeneralesComDTO[] getCategoriasTributarias()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getCategoriasTributarias()");
		DatosGeneralesComDTO[] arrayDatosGeneralesComDTO = null;
		try {
			// Obtiene la categoria por defecto
			ParametrosGeneralesDTO parametrosGeneralesDTO = getCategoriaTributariaPorDefecto();

			DatosGenerales datosGeneralesBO = new DatosGenerales();
			DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoModulo(global
					.getValor("codigo.modulo.GA"));
			datosGeneralesDTO.setTabla(global
					.getValor("nombre.tabla.categoria.tributaria"));
			datosGeneralesDTO.setColumna(global
					.getValor("nombre.columna.categoria.tributaria"));
			DatosGeneralesDTO[] arrayDatosGeneralesDTO = datosGeneralesBO
					.getListCodigos(datosGeneralesDTO);

			if (arrayDatosGeneralesDTO != null) {
				arrayDatosGeneralesComDTO = new DatosGeneralesComDTO[arrayDatosGeneralesDTO.length];
				for (int i = 0; i < arrayDatosGeneralesDTO.length; i++) {
					DatosGeneralesComDTO datosGeneralesComDTO = new DatosGeneralesComDTO();
					MapperIF mapper = new DozerBeanMapper();
					datosGeneralesComDTO = (DatosGeneralesComDTO) mapper.map(
							arrayDatosGeneralesDTO[i],
							DatosGeneralesComDTO.class);
					// Asigna valor 1 a la categoira por defecto
					arrayDatosGeneralesComDTO[i] = datosGeneralesComDTO;
					if (arrayDatosGeneralesComDTO[i].getCodigoValor().equals(
							parametrosGeneralesDTO.getValorparametro())) {
						DatosGeneralesComDTO.indiceDefectoCategoriaTributaria=i;
					} 
				}
			}

			logger.debug("Fin:getCategoriasTributarias()");
		} catch (CustomerDomainException e) {
			logger.debug("getCategoriasTributarias():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (ProductDomainException e) {
			logger.debug("getCategoriasTributarias:end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}

		return arrayDatosGeneralesComDTO;
	}// fin getCategoriasTributarias

	/**
	 * Obtiene categoria tributaria por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayDatosGeneralesComDTO
	 * @throws CustomerDomainException
	 */

	private ParametrosGeneralesDTO getCategoriaTributariaPorDefecto()
		throws CustomerDomainException, ProductDomainException 
	{
		logger.debug("Inicio:getCategoriaTributariaPorDefecto()");
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		parametrosGeneralesDTO.setCodigomodulo(global
				.getValor("codigo.modulo.GA"));
		parametrosGeneralesDTO.setNombreparametro(global
				.getValor("parametro.categoria.tributaria.defecto"));
		parametrosGeneralesDTO.setCodigoproducto(global
				.getValor("codigo.producto"));
		ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
		parametrosGeneralesDTO = parametrosGeneralesBO
				.getParametroGeneral(parametrosGeneralesDTO);
		logger.debug("Inicio:getCategoriaTributariaPorDefecto()");
		return parametrosGeneralesDTO;

	}// fin getCategoriaTributariaPorDefecto

	/**
	 * Obtiene indicador de facturable
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayClienteComDTO
	 * @throws AltaClienteException
	 */

	public RegistroFacturacionComDTO[] getIndicadorDeFacturable()
		throws AltaClienteException 
	{
		logger.debug("Inicio:arrayRegistroFacturacionComDTO()");
		// Busca indicador facturable por defecto
		RegistroFacturacionComDTO registroFacturacionComDTO = getIndicadorDeFacturablePorDefecto();
		RegistroFacturacionComDTO[] arrayRegistroFacturacionComDTO = new RegistroFacturacionComDTO[2];
		arrayRegistroFacturacionComDTO[0] = new RegistroFacturacionComDTO();
		arrayRegistroFacturacionComDTO[0].setCodigoIndicadorFacturable("S");
		arrayRegistroFacturacionComDTO[0].setDescripcionIndicadorFacturable("SI");
		arrayRegistroFacturacionComDTO[1] = new RegistroFacturacionComDTO();
		arrayRegistroFacturacionComDTO[1].setCodigoIndicadorFacturable("N");
		arrayRegistroFacturacionComDTO[1].setDescripcionIndicadorFacturable("NO");
		try {
			for (int i = 0; i < arrayRegistroFacturacionComDTO.length; i++) {
				if (arrayRegistroFacturacionComDTO[i]
						.getDescripcionIndicadorFacturable().equals(registroFacturacionComDTO.getDescripcionIndicadorFacturable())) {
					RegistroFacturacionComDTO.indiceDefectoIndicadorFacturable=i;
				}
			}
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}

		logger.debug("Fin:getIndicadorDeFacturable()");
		return arrayRegistroFacturacionComDTO;
	}// fin getIndicadorDeFacturable

	/**
	 * Obtiene indicador facturable por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return registroFacturacionComDTO
	 * @throws
	 */

	private RegistroFacturacionComDTO getIndicadorDeFacturablePorDefecto() 
	{
		logger.debug("Inicio:getIndicadorDeFacturablePorDefecto()");
		RegistroFacturacionComDTO registroFacturacionComDTO = new RegistroFacturacionComDTO();
		registroFacturacionComDTO.setDescripcionIndicadorFacturable(global.getValor("indicador.facturable.defecto"));
		logger.debug("Fin:getIndicadorDeFacturablePorDefecto()");
		return registroFacturacionComDTO;

	}// fin getIndicadorDeFacturablePorDefecto

	/**
	 * Obtiene tipos de planes tarifarios
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayPlanTarifarioComDTO
	 * @throws AltaClienteException
	 */

	public PlanTarifarioComDTO[] getTiposPlanesTarifarios()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getTiposPlanesTarifarios()");
		PlanTarifarioComDTO[] arrayPlanTarifarioComDTO = new PlanTarifarioComDTO[3];
		arrayPlanTarifarioComDTO[0] = new PlanTarifarioComDTO();
		arrayPlanTarifarioComDTO[0].setCodigoPlanTarifario(global.getValor(
				"plan.tarifario.individual").substring(0, 1));
		arrayPlanTarifarioComDTO[0].setDescripcionPlanTarifario(global
				.getValor("plan.tarifario.individual"));
		arrayPlanTarifarioComDTO[1] = new PlanTarifarioComDTO();
		arrayPlanTarifarioComDTO[1].setCodigoPlanTarifario(global.getValor(
				"plan.tarifario.empresa").substring(0, 1));
		arrayPlanTarifarioComDTO[1].setDescripcionPlanTarifario(global
				.getValor("plan.tarifario.empresa"));
		arrayPlanTarifarioComDTO[2] = new PlanTarifarioComDTO();
		arrayPlanTarifarioComDTO[2].setCodigoPlanTarifario(global.getValor(
				"plan.tarifario.familiar").substring(0, 1));
		arrayPlanTarifarioComDTO[2].setDescripcionPlanTarifario(global
				.getValor("plan.tarifario.familiar"));
		logger.debug("Fin:getTiposPlanesTarifarios()");
		return arrayPlanTarifarioComDTO;
	}// fin getTiposPlanesTarifarios

	/**
	 * Obtiene modalidades de cancelación
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayPlanTarifarioComDTO
	 * @throws AltaClienteException
	 */

	public ModalidadCancelacionComDTO[] getModalidadesCancelacion()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getModalidadesCancelacion()");
		// Obtiene modalidad de cancelación por defecto
		ModalidadCancelacionComDTO modalidadCancelacionComDTO = getModalidadCancelacionPorDefecto();
		ModalidadCancelacionComDTO[] arrayModalidadCancelacionComDTO = new ModalidadCancelacionComDTO[2];
		arrayModalidadCancelacionComDTO[0] = new ModalidadCancelacionComDTO();
		arrayModalidadCancelacionComDTO[0].setCodigo(global.getValor("modalidad.cancelacion.automatica").substring(0, 1));
		arrayModalidadCancelacionComDTO[0].setDescripcion(global.getValor("modalidad.cancelacion.automatica"));
		arrayModalidadCancelacionComDTO[1] = new ModalidadCancelacionComDTO();
		arrayModalidadCancelacionComDTO[1].setCodigo(global.getValor("modalidad.cancelacion.manual").substring(0, 1));
		arrayModalidadCancelacionComDTO[1].setDescripcion(global.getValor("modalidad.cancelacion.manual"));
		try {
			for (int i = 0; i < arrayModalidadCancelacionComDTO.length; i++) {
				if (arrayModalidadCancelacionComDTO[i].getDescripcion().equals(	modalidadCancelacionComDTO.getDescripcion())){
					ModalidadCancelacionComDTO.indiceDefecto=i;
				}
			}			
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getModalidadesCancelacion()");
		return arrayModalidadCancelacionComDTO;
	}// fin getModalidadesCancelacion

	/**
	 * Obtiene modalidad de cancelación por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return registroFacturacionComDTO
	 * @throws
	 */

	private ModalidadCancelacionComDTO getModalidadCancelacionPorDefecto() 
	{
		logger.debug("Inicio:getModalidadCancelacionPorDefecto()");
		ModalidadCancelacionComDTO modalidadCancelacionComDTO = new ModalidadCancelacionComDTO();
		modalidadCancelacionComDTO.setDescripcion(global
				.getValor("modalidad.cancelacion.manual"));
		logger.debug("Fin:getModalidadCancelacionPorDefecto()");
		return modalidadCancelacionComDTO;

	}// fin getModalidadCancelacionPorDefecto

	/**
	 * Obtiene listado de bancos
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayConceptosRecaudacionComDTO
	 * @throws AltaClienteException
	 */

	public ConceptosRecaudacionComDTO[] getBancos() 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getBancos()");
		ConceptosRecaudacionComDTO[] arrayConceptosRecaudacionComDTO = null;
		try {
			ConceptosRecaudacion conceptosRecaudacionBO = new ConceptosRecaudacion();
			ConceptosRecaudacionDTO conceptosRecaudacionDTO = new ConceptosRecaudacionDTO();
			conceptosRecaudacionDTO.setIndicadorPAC(Integer.parseInt(global.getValor("indicador.PAC")));
			ConceptosRecaudacionDTO[] arrayconceptosRecaudacionDTO = conceptosRecaudacionBO.getListBancosPAC(conceptosRecaudacionDTO);
			if (arrayconceptosRecaudacionDTO != null) {
				arrayConceptosRecaudacionComDTO = new ConceptosRecaudacionComDTO[arrayconceptosRecaudacionDTO.length];
				for (int i = 0; i < arrayconceptosRecaudacionDTO.length; i++) {
					ConceptosRecaudacionComDTO conceptosRecaudacionComDTO = new ConceptosRecaudacionComDTO();
					MapperIF mapper = new DozerBeanMapper();
					conceptosRecaudacionComDTO = (ConceptosRecaudacionComDTO) mapper.map(arrayconceptosRecaudacionDTO[i],
									ConceptosRecaudacionComDTO.class);
					arrayConceptosRecaudacionComDTO[i] = conceptosRecaudacionComDTO;
				}
			}
		} catch (CustomerDomainException e) {
			logger.debug("getBancos():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getBancos()");
		return arrayConceptosRecaudacionComDTO;
	}// fin getBancos

	/**
	 * Obtiene listado de tipos tarjetas
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayConceptosRecaudacionComDTO
	 * @throws AltaClienteException
	 */

	public ConceptosRecaudacionComDTO[] getTiposTarjetas()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getTiposTarjetas()");
		ConceptosRecaudacionComDTO[] arrayConceptosRecaudacionComDTO = null;
		try {
			ConceptosRecaudacion conceptosRecaudacionBO = new ConceptosRecaudacion();
			ConceptosRecaudacionDTO[] arrayconceptosRecaudacionDTO = conceptosRecaudacionBO
					.getListTarjetas();
			if (arrayconceptosRecaudacionDTO != null) {
				arrayConceptosRecaudacionComDTO = new ConceptosRecaudacionComDTO[arrayconceptosRecaudacionDTO.length];
				for (int i = 0; i < arrayconceptosRecaudacionDTO.length; i++) {
					ConceptosRecaudacionComDTO conceptosRecaudacionComDTO = new ConceptosRecaudacionComDTO();
					MapperIF mapper = new DozerBeanMapper();
					conceptosRecaudacionComDTO = (ConceptosRecaudacionComDTO) mapper
							.map(arrayconceptosRecaudacionDTO[i],
									ConceptosRecaudacionComDTO.class);
					arrayConceptosRecaudacionComDTO[i] = conceptosRecaudacionComDTO;
				}
			}
		} catch (CustomerDomainException e) {
			logger.debug("getTiposTarjetas():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getTiposTarjetas()");
		return arrayConceptosRecaudacionComDTO;
	}// fin getTiposTarjetas

	/**
	 * Obtiene tipos de cuentas bancarias
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayTipoCuentaBancariaComDTO
	 * @throws AltaClienteException
	 */

	public TipoCuentaBancariaComDTO[] getTiposCuentasBancarias()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getTiposCuentasBancarias()");
		// Obtiene modalidad de cancelación por defecto
		
		TipoCuentaBancariaComDTO tipoCuentaBancariaComDTO = getTipoCuentaBancariaPorDefecto();
		TipoCuentaBancariaComDTO[] arrayTipoCuentaBancariaComDTO = new TipoCuentaBancariaComDTO[2];
		arrayTipoCuentaBancariaComDTO[0] = new TipoCuentaBancariaComDTO();
		arrayTipoCuentaBancariaComDTO[0].setCodigo(global.getValor(
				"tipo.cuenta.ahorro").substring(0, 1));
		arrayTipoCuentaBancariaComDTO[0].setDescripcion(global
				.getValor("tipo.cuenta.ahorro"));
		arrayTipoCuentaBancariaComDTO[1] = new TipoCuentaBancariaComDTO();
		arrayTipoCuentaBancariaComDTO[1].setCodigo(global.getValor(
				"tipo.cuenta.corriente").substring(0, 1));
		arrayTipoCuentaBancariaComDTO[1].setDescripcion(global
				.getValor("tipo.cuenta.corriente"));
		try {
			for (int i = 0; i < arrayTipoCuentaBancariaComDTO.length; i++) {
				if (arrayTipoCuentaBancariaComDTO[i].getDescripcion().equals(
						tipoCuentaBancariaComDTO.getDescripcion())) {
					
					TipoCuentaBancariaComDTO.indiceDefecto=i;
				} 

			}
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getTiposCuentasBancarias()");
		return arrayTipoCuentaBancariaComDTO;
	}// fin getTiposCuentasBancarias

	/**
	 * Obtiene modalidad de cancelación por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return tipoCuentaBancariaComDTO
	 * @throws
	 */

	private TipoCuentaBancariaComDTO getTipoCuentaBancariaPorDefecto() 
	{
		logger.debug("Inicio:getTipoCuentaBancariaPorDefecto()");
		TipoCuentaBancariaComDTO tipoCuentaBancariaComDTO = new TipoCuentaBancariaComDTO();
		tipoCuentaBancariaComDTO.setDescripcion(global
				.getValor("tipo.cuenta.corriente"));
		logger.debug("Fin:getTipoCuentaBancariaPorDefecto()");
		return tipoCuentaBancariaComDTO;

	}// fin getTipoCuentaBancariaPorDefecto

	/**
	 * Obtiene datos de Buro
	 * 
	 * @author Héctor Hermosilla
	 * @param clienteComDTO
	 * @return clienteComDTO
	 * @throws AltaClienteException
	 */

	public ClienteComDTO getDatosBuro(ClienteComDTO clienteComDTO)
		throws AltaClienteException 
	{
		logger.debug("Inicio:getDatosBuro()");
		try {
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
			RegistroEvaluacionRiesgo registroEvaluacionRiesgoBO = new RegistroEvaluacionRiesgo();
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.despacho.datos"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			if (parametrosGeneralesDTO.getValorparametro().toUpperCase().equals("TRUE")) {
				// Verifica si el cliente tiene excepciones. Si tiene no busca
				// evaluación
				RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO = new RegistroEvaluacionRiesgoDTO();
				registroEvaluacionRiesgoDTO.setNumIdentificacion(clienteComDTO.getNumeroIdentificacion());
				registroEvaluacionRiesgoDTO.setCodigoTipoIdentificacion(clienteComDTO.getCodigoTipoIdentificacion());
				registroEvaluacionRiesgoDTO = registroEvaluacionRiesgoBO.existeExcepcion(registroEvaluacionRiesgoDTO);
				if (registroEvaluacionRiesgoDTO == null) {
					parametrosGeneralesDTO = new ParametrosGeneralesDTO();
					parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
					parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
					parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.codigo.tipident.defecto"));
					parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
					registroEvaluacionRiesgoDTO = new RegistroEvaluacionRiesgoDTO();
					registroEvaluacionRiesgoDTO
							.setNumIdentificacion(clienteComDTO.getNumeroIdentificacion());
					registroEvaluacionRiesgoDTO = registroEvaluacionRiesgoBO
							.getRegEvaluacionRiesgo(registroEvaluacionRiesgoDTO);
					if (registroEvaluacionRiesgoDTO != null) {
						if (registroEvaluacionRiesgoDTO.getCodigoTipoIdentificacion().equals(
								parametrosGeneralesDTO.getValorparametro())) {
							clienteComDTO.setDatosBuro(1);// Cliente
							clienteComDTO.setNombreCliente(registroEvaluacionRiesgoDTO.getNombreCliente());
							clienteComDTO.setNombreApellido1(registroEvaluacionRiesgoDTO.getPrimerApellido());
							clienteComDTO.setNombreApellido2(registroEvaluacionRiesgoDTO.getSegundoApellido());
						} else {
							clienteComDTO.setDatosBuro(0);// Empresa
							clienteComDTO.setNombreCliente(registroEvaluacionRiesgoDTO.getNombreCliente());
							clienteComDTO.setDescripcionNombre(registroEvaluacionRiesgoDTO.getDescripcionNombre());
						}
					}
					clienteComDTO.setExisteExcepcion(false);
				} else
					clienteComDTO.setExisteExcepcion(true);
			}
		} catch (CustomerDomainException e) {
			logger.debug("getDatosBuro():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}

		logger.debug("Inicio:getDatosBuro()");
		return clienteComDTO;
	}// obtenerDatosBuro

	/**
	 * Obtiene listado de Subcategorias impositivas
	 * 
	 * @author Héctor Hermosilla
	 * @param clienteComDTO
	 * @return arrayClienteComDTO
	 * @throws AltaClienteException
	 */
	public ClienteComDTO[] getSubCategoriasImpositivas(ClienteComDTO clienteComDTO) 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getSubCategoriasImpositivas()");
		ClienteComDTO[] arrayClienteComDTO = null;
		try {
			// Obtiene la categoria impositiva por defecto
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global
					.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setCodigoproducto(global
					.getValor("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(global
					.getValor("parametro.indicador.subcatimp"));			
			ClienteDTO clienteDTO = new ClienteDTO();
			clienteDTO.setCodigoCategImpos(clienteComDTO.getCodigoCategImpos());
			ClienteDTO[] arrayClienteDTO = clienteBO
					.getListSubCategImpos(clienteDTO);

			if (arrayClienteDTO != null) {
				arrayClienteComDTO = new ClienteComDTO[arrayClienteDTO.length];
				for (int i = 0; i < arrayClienteDTO.length; i++) {
					ClienteComDTO clienteComDTO2 = new ClienteComDTO();
					MapperIF mapper = new DozerBeanMapper();
					clienteComDTO2 = (ClienteComDTO) mapper.map(
							arrayClienteDTO[i], ClienteComDTO.class);
					arrayClienteComDTO[i] = clienteComDTO2;

				}
			} else {
				throw new AltaClienteException(
						"No se encontro subcategorias impositivas");
			}

			logger.debug("Fin:getSubCategoriasImpositivas()");

		} catch (CustomerDomainException e) {
			logger.debug("getSubCategoriasImpositivas():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (AltaClienteException e) {
			logger.debug("getSubCategoriasImpositivas():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		return arrayClienteComDTO;

	}// fin getSubCategoriasImpositivas

	/**
	 * Obtiene modalidades de cancelación
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayPlanTarifarioComDTO
	 * @throws AltaClienteException
	 */

	public ModalidadPagoComDTO[] getModalidadesPago(ModalidadCancelacionComDTO modalidadCancelacionComDTO)
		throws AltaClienteException 
	{
		logger.debug("Inicio:getModalidadesPago()");
		ModalidadPagoComDTO[] arrayModalidadPagoComDTO = null;
		try {
			ModalidadPagoDTO modalidadPagoDTO = new ModalidadPagoDTO();
			if (modalidadCancelacionComDTO.getCodigo().equals(
					global.getValor("modalidad.cancelacion.manual").substring(
							0, 1)))
				modalidadPagoDTO.setIndicadorManual(Integer.parseInt(global
						.getValor("modalidad.cancelacion.manual.ind")));
			else
				modalidadPagoDTO.setIndicadorManual(Integer.parseInt(global
						.getValor("modalidad.cancelacion.automatica.ind")));
			ModalidadPago modalidadPagoBO = new ModalidadPago();
			ModalidadPagoDTO[] arrayModalidadPagoDTO = modalidadPagoBO
					.getListModalidadPagoIndManual(modalidadPagoDTO);
			if (arrayModalidadPagoDTO != null) {
				arrayModalidadPagoComDTO = new ModalidadPagoComDTO[arrayModalidadPagoDTO.length];
				for (int i = 0; i < arrayModalidadPagoComDTO.length; i++) {
					ModalidadPagoComDTO modalidadPagoComDTO = new ModalidadPagoComDTO();
					MapperIF mapper = new DozerBeanMapper();
					modalidadPagoComDTO = (ModalidadPagoComDTO) mapper
							.map(arrayModalidadPagoDTO[i],
									ModalidadPagoComDTO.class);
					arrayModalidadPagoComDTO[i] = modalidadPagoComDTO;
				}
			} else {
				throw new AltaClienteException(
						"No se encontro modalidades de pago");
			}
		} catch (CustomerDomainException e) {
			logger.debug("getModalidadesPago():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (AltaClienteException e) {
			logger.debug("getModalidadesPago:end");
			logger.debug("AltaClienteException");
			throw e;
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getModalidadesPago()");
		return arrayModalidadPagoComDTO;
	}// fin getModalidadesPago

	/**
	 * Obtiene listado de sucursales de banco
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayConceptosRecaudacionComDTO
	 * @throws AltaClienteException
	 */

	public ConceptosRecaudacionComDTO[] getSucursalesBanco(ConceptosRecaudacionComDTO conceptosRecaudacionComDTO)
		throws AltaClienteException 
	{
		logger.debug("Inicio:getSucursalesBanco()");
		ConceptosRecaudacionComDTO[] conceptosRecaudacionComDTOs = null;
		try {
			ConceptosRecaudacion conceptosRecaudacionBO = new ConceptosRecaudacion();
			ConceptosRecaudacionDTO conceptosRecaudacionDTO = new ConceptosRecaudacionDTO();
			conceptosRecaudacionDTO.setCodigoBanco(conceptosRecaudacionComDTO
					.getCodigoBanco());
			ConceptosRecaudacionDTO[] arrayconceptosRecaudacionDTO = conceptosRecaudacionBO
					.getListSucursalesBancos(conceptosRecaudacionDTO);
			if (arrayconceptosRecaudacionDTO != null) {
				conceptosRecaudacionComDTOs = new ConceptosRecaudacionComDTO[arrayconceptosRecaudacionDTO.length];
				for (int i = 0; i < arrayconceptosRecaudacionDTO.length; i++) {
					conceptosRecaudacionComDTOs[i] = new ConceptosRecaudacionComDTO();
					MapperIF mapper = new DozerBeanMapper();
					conceptosRecaudacionComDTOs[i] = (ConceptosRecaudacionComDTO) mapper
							.map(arrayconceptosRecaudacionDTO[i],
									ConceptosRecaudacionComDTO.class);

				}
			}
		} catch (CustomerDomainException e) {
			logger.debug("getSucursalesBanco():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getSucursalesBanco()");
		return conceptosRecaudacionComDTOs;
	}// fin getSucursalesBanco

	/**
	 * Obtiene listado de tipos de planes tarifarios
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return planTarifarioComDTOs
	 * @throws AltaClienteException
	 */

	public PlanTarifarioComDTO[] getTiposPlanesTarifarios(ClienteComDTO clienteComDTO) 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getTiposPlanesTarifarios()");
		PlanTarifarioComDTO[] planTarifarioComDTOs = null;
		try {
			int iLargoArreglo = 0;
			int iIndividual = 0;
			int iFamiliar = 0;
			int iEmpresa = 0;
			// Busca evaluación de riesgo
			RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO = new RegistroEvaluacionRiesgoDTO();
			registroEvaluacionRiesgoDTO.setCodigoTipoIdentificacion(clienteComDTO.getCodigoTipoIdentificacion());
			registroEvaluacionRiesgoDTO.setNumIdentificacion(clienteComDTO.getNumeroIdentificacion());
			registroEvaluacionRiesgoDTO.setTipoSolicitud(global.getValor("indicador.tipo.solicitud"));
			RegistroEvaluacionRiesgo registroEvaluacionRiesgoBO = new RegistroEvaluacionRiesgo();
			registroEvaluacionRiesgoDTO = registroEvaluacionRiesgoBO.getEvaluacionRiesgoVigenteCliente(registroEvaluacionRiesgoDTO);

			// Busca excepciones asociadas al cliente
			RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO2 = new RegistroEvaluacionRiesgoDTO();
			registroEvaluacionRiesgoDTO2.setNumIdentificacion(clienteComDTO.getNumeroIdentificacion());
			registroEvaluacionRiesgoDTO2 = registroEvaluacionRiesgoBO.existeExcepcion(registroEvaluacionRiesgoDTO2);
			if ((clienteComDTO.getCicloFacturacion() == CiclosdeFacturacionExclusivos.ciclo1
					|| clienteComDTO.getCicloFacturacion() == CiclosdeFacturacionExclusivos.ciclo2 || clienteComDTO
					.getCicloFacturacion() == CiclosdeFacturacionExclusivos.ciclo3)) {
				iLargoArreglo = 1;
				if (registroEvaluacionRiesgoDTO2 != null) {
					if ((registroEvaluacionRiesgoDTO2.getCodigoRestriccion() == 0 
						|| registroEvaluacionRiesgoDTO2.getCodigoRestriccion() == 1
						|| registroEvaluacionRiesgoDTO2.getCodigoRestriccion() == 2))
						iLargoArreglo = 3;
					if (iLargoArreglo == 1)
						iIndividual = 1;
					else {
						iIndividual = 1;
						iFamiliar = 1;
						iEmpresa = 1;
					}
				}

			} else if (registroEvaluacionRiesgoDTO != null
					&& registroEvaluacionRiesgoDTO2 == null) {
				RegistroEvaluacionRiesgoDTO[] registroEvaluacionRiesgoDTOs = registroEvaluacionRiesgoBO
				.getListPlanTarifarioAutoriz(registroEvaluacionRiesgoDTO);
				if (registroEvaluacionRiesgoDTOs != null) {
					PlanTarifario planTarifarioBO = new PlanTarifario();
					for (int i = 0; i < registroEvaluacionRiesgoDTOs.length; i++) {
						PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
						planTarifarioDTO.setCodigoPlanTarifario(registroEvaluacionRiesgoDTOs[i].getCodigoPlanTarifario());
						planTarifarioDTO.setCodigoProducto(global.getValor("codigo.producto"));
						planTarifarioDTO.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
						planTarifarioDTO = planTarifarioBO.getPlanTarifario(planTarifarioDTO);
						if (planTarifarioDTO != null) {
							if (planTarifarioDTO.getTipoPlanTarifario().toUpperCase().equals("I"))
								iIndividual = 1;
							else if (planTarifarioDTO.getTipoPlanTarifario().toUpperCase().equals("E")
									&& planTarifarioDTO.getIndFamiliar() == 1)
								iFamiliar = 1;
							else if (planTarifarioDTO.getTipoPlanTarifario().toUpperCase().equals("E")
									&& planTarifarioDTO.getIndFamiliar() != 1)
								iEmpresa = 1;
						}
					}

				}
			}
			iLargoArreglo = iIndividual + iFamiliar + iEmpresa;
			if (iLargoArreglo > 0) {
				planTarifarioComDTOs = new PlanTarifarioComDTO[iLargoArreglo];
				int indicePlan = 0;
				if (iIndividual == 1) {
					planTarifarioComDTOs[indicePlan] = new PlanTarifarioComDTO();
					planTarifarioComDTOs[indicePlan]
							.setDescripcionPlanTarifario(global
									.getValor("tipo.plan.individual"));
					planTarifarioComDTOs[indicePlan]
							.setCodigoPlanTarifario(global
									.getValor("tipo.plan.codindividual"));
					indicePlan++;
				}
				if (iEmpresa == 1) {
					planTarifarioComDTOs[indicePlan] = new PlanTarifarioComDTO();
					planTarifarioComDTOs[indicePlan]
							.setDescripcionPlanTarifario(global
									.getValor("tipo.plan.empresa"));
					planTarifarioComDTOs[indicePlan]
							.setCodigoPlanTarifario(global
									.getValor("tipo.plan.codempresa"));
					indicePlan++;
				}
				if (iFamiliar == 1) {
					planTarifarioComDTOs[indicePlan] = new PlanTarifarioComDTO();
					planTarifarioComDTOs[indicePlan]
							.setDescripcionPlanTarifario(global
									.getValor("tipo.plan.familiar"));
					planTarifarioComDTOs[indicePlan]
							.setCodigoPlanTarifario(global
									.getValor("tipo.plan.codfamiliar"));
					indicePlan++;
				}
			}

		} catch (CustomerDomainException e) {
			logger.debug("getTiposPlanesTarifarios():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getTiposPlanesTarifarios()");
		return planTarifarioComDTOs;
	}// fin getTiposPlanesTarifarios

	/**
	 * Obtiene listado de planes tarifarios
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return planTarifarioComDTOs
	 * @throws AltaClienteException
	 */

	public PlanTarifarioComDTO[] getPlanesTarifarios(ClienteComDTO clienteComDTO)
		throws AltaClienteException 
	{
		logger.debug("Inicio:getPlanesTarifarios()");
		PlanTarifarioComDTO[] planTarifarioComDTOs = null;
		try {
			PlanTarifario planTarifarioBO = new PlanTarifario();
			PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
			planTarifarioDTO.setCodigoTipoIdentificador(clienteComDTO.getCodigoTipoIdentificacion());
			planTarifarioDTO.setNumeroIdentificador(clienteComDTO.getNumeroIdentificacion());
			planTarifarioDTO.setTipoPlanTarifario(clienteComDTO.getTipoPlanTarifario());
			PlanTarifarioDTO[] planTarifarioDTOs = planTarifarioBO.getListPlanTarifarioNumIdentTipoPlan(planTarifarioDTO);
			if (planTarifarioDTOs != null){
				planTarifarioComDTOs = new PlanTarifarioComDTO[planTarifarioDTOs.length];
				for (int i = 0; i < planTarifarioDTOs.length; i++) {
					MapperIF mapper = new DozerBeanMapper();
					planTarifarioComDTOs[i] = (PlanTarifarioComDTO) mapper.map(planTarifarioDTOs[i],PlanTarifarioComDTO.class);
				}
			}
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getPlanesTarifarios()");
		return planTarifarioComDTOs;
	}// fin getPlanesTarifarios

	
	/**
	 * Obtiene listado de planes tarifarios
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return planTarifarioComDTOs
	 * @throws AltaClienteException
	 */

	public PlanTarifarioComDTO[] getListPlanTarifarioPorPlanORango(ClienteComDTO clienteComDTO) 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getPlanesTarifarios()");
		PlanTarifarioComDTO[] planTarifarioComDTOs = null;
		try {
			PlanTarifario planTarifarioBO = new PlanTarifario();
			PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
			planTarifarioDTO.setCodigoTipoIdentificador(clienteComDTO.getCodigoTipoIdentificacion());
			planTarifarioDTO.setNumeroIdentificador(clienteComDTO.getNumeroIdentificacion());
			planTarifarioDTO.setTipoPlanTarifario(clienteComDTO.getTipoPlanTarifario());
			planTarifarioDTO.setSeleccionPlanORango(clienteComDTO.getSeleccionPlanORango());
			
			PlanTarifarioDTO[] planTarifarioDTOs = planTarifarioBO.getListPlanTarifarioPorPlanORango(planTarifarioDTO);
			
			if (planTarifarioDTOs != null){
				planTarifarioComDTOs = new PlanTarifarioComDTO[planTarifarioDTOs.length];
				for (int i = 0; i < planTarifarioDTOs.length; i++) {
					MapperIF mapper = new DozerBeanMapper();
					planTarifarioComDTOs[i] = (PlanTarifarioComDTO) mapper.map(planTarifarioDTOs[i],PlanTarifarioComDTO.class);
				}
			}
		} 
		catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getPlanesTarifarios()");
		return planTarifarioComDTOs;
	}// fin getPlanesTarifarios
	
	
	/**
	 * Obtiene listado de limites de consumo asociables al cliente
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return planTarifarioComDTOs
	 * @throws AltaClienteException
	 */

	public PlanTarifarioComDTO[] getLimitesConsumo(PlanTarifarioComDTO planTarifarioComDTO)
		throws AltaClienteException 
	{
		logger.debug("Inicio:getLimitesConsumo()");
		PlanTarifarioComDTO[] planTarifarioComDTOs = null;
		try {
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
			PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
			planTarifarioDTO.setCodigoPlanTarifario(planTarifarioComDTO.getCodigoPlanTarifario());
			planTarifarioDTO.setCodigoCliente(planTarifarioComDTO.getCodigoCliente());
			// Obtiene primer formato para consultar los limites de consumo
			// asociados al cliente
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GE"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.formato.sel2"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			planTarifarioDTO.setFormatoFecha1(parametrosGeneralesDTO.getValorparametro());
			// Obtiene segundo formato para consultar los limites de consumo
			// asociados al cliente
			parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GE"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.formato.sel7"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			planTarifarioDTO.setFormatoFecha2(parametrosGeneralesDTO.getValorparametro());

			PlanTarifario planTarifarioBO = new PlanTarifario();
			PlanTarifarioDTO[] planTarifarioDTOs = planTarifarioBO.getListLimiteConsumo(planTarifarioDTO);
			if (planTarifarioDTOs != null) {
				planTarifarioComDTOs = new PlanTarifarioComDTO[planTarifarioDTOs.length];
				for (int i = 0; i < planTarifarioDTOs.length; i++) {
					MapperIF mapper = new DozerBeanMapper();
					planTarifarioComDTOs[i] = (PlanTarifarioComDTO) mapper.map(planTarifarioDTOs[i], PlanTarifarioComDTO.class);

				}
			}
		} catch (ProductDomainException e) {
			logger.debug("getLimitesConsumo():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getLimitesConsumo()");
		return planTarifarioComDTOs;
	}// fin getLimitesConsumo

	/**
	 * Obtiene compañas vigentes postpago
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return campanaVigenteComDTOs
	 * @throws AltaClienteException
	 */

	public CampanaVigenteComDTO[] getCampanasVigentesPostPago()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getCampanasVigentesPostPago()");
		CampanaVigenteComDTO[] campanaVigenteComDTOs = null;
		try {
			CampanaVigente campanaVigenteBO = new CampanaVigente();
			CampanaVigenteDTO[] campanaVigenteDTOs = campanaVigenteBO.getListCampVigentesPostpago();
			if (campanaVigenteDTOs != null) {
				campanaVigenteComDTOs = new CampanaVigenteComDTO[campanaVigenteDTOs.length];
				for (int i = 0; i < campanaVigenteDTOs.length; i++) {
					campanaVigenteComDTOs[i] = new CampanaVigenteComDTO();
					MapperIF mapper = new DozerBeanMapper();
					campanaVigenteComDTOs[i] = (CampanaVigenteComDTO) mapper
							.map(campanaVigenteDTOs[i],
									CampanaVigenteComDTO.class);
				}
			}

		} catch (CustomerDomainException e) {
			logger.debug("getCampanasVigentesPostPago:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getCampanasVigentesPostPago()");
		return campanaVigenteComDTOs;
	}// fin getCampanasVigentesPostPago
	
	
	/**
	 * Importa Prospecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return prospectoComDTO
	 * @throws AltaClienteException
	 */

	public ProspectoComDTO importarProspecto(ClienteComDTO clienteComDTO)
		throws AltaClienteException 
	{
		logger.debug("Inicio:importarProspecto()");
		ProspectoComDTO prospectoComDTO = null;
		try {
			Prospecto prospectoBO = new Prospecto();
			ProspectoDTO prospectoDTO = new ProspectoDTO();
			prospectoDTO.setCodigoTipoIdent(clienteComDTO.getCodigoTipoIdentificacion());
			prospectoDTO.setNumeroIdent(clienteComDTO.getNumeroIdentificacion());
			prospectoDTO = prospectoBO.getProspectoCliente(prospectoDTO);
			if (prospectoDTO != null) {
				MapperIF mapper = new DozerBeanMapper();
				prospectoDTO = prospectoBO.getProspectoDireccion(prospectoDTO);
				prospectoComDTO = (ProspectoComDTO) mapper.map(prospectoDTO, ProspectoComDTO.class);
				
			}

		} catch (CustomerDomainException e) {
			logger.debug("importarProspecto:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:importarProspecto()");
		return prospectoComDTO;
	}// fin importarProspecto
	
	
	
	/**
	 * Obtiene Listado de paises configurados en SCL
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return datosGeneralesComDTOs
	 * @throws CustomerDomainException
	 */

	public DatosGeneralesComDTO[] getPaises() 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getPaises()");
		DatosGeneralesComDTO[] datosGeneralesComDTOs = null;
		try {
			DatosGenerales datosGeneralesBO = new DatosGenerales();
			DatosGeneralesDTO[] arrayDatosGeneralesDTO = datosGeneralesBO.getListPaises();
			if (arrayDatosGeneralesDTO != null) {
				datosGeneralesComDTOs = new DatosGeneralesComDTO[arrayDatosGeneralesDTO.length];
				for (int i = 0; i < arrayDatosGeneralesDTO.length; i++) {
					DatosGeneralesComDTO datosGeneralesComDTO = new DatosGeneralesComDTO();
					MapperIF mapper = new DozerBeanMapper();
					datosGeneralesComDTO = (DatosGeneralesComDTO) mapper.map(
							arrayDatosGeneralesDTO[i],
							DatosGeneralesComDTO.class);
					datosGeneralesComDTOs[i] = datosGeneralesComDTO;
				}
			}
		} catch (CustomerDomainException e) {
			logger.debug("getPaises():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getPaises()");
		return datosGeneralesComDTOs;
	}// fin getPaises
	
	/**
	 * Obtiene Listado de actividades configurados en SCL
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return datosGeneralesComDTOs
	 * @throws CustomerDomainException
	 */

	public DatosGeneralesComDTO[] getActividades() 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getActividades()");
		DatosGeneralesComDTO[] datosGeneralesComDTOs = null;
		try {
			DatosGenerales datosGeneralesBO = new DatosGenerales();
			DatosGeneralesDTO[] arrayDatosGeneralesDTO = datosGeneralesBO.getListActividades();
			if (arrayDatosGeneralesDTO != null) {
				datosGeneralesComDTOs = new DatosGeneralesComDTO[arrayDatosGeneralesDTO.length];
				for (int i = 0; i < arrayDatosGeneralesDTO.length; i++) {
					DatosGeneralesComDTO datosGeneralesComDTO = new DatosGeneralesComDTO();
					MapperIF mapper = new DozerBeanMapper();
					datosGeneralesComDTO = (DatosGeneralesComDTO) mapper.map(
							arrayDatosGeneralesDTO[i],
							DatosGeneralesComDTO.class);
					datosGeneralesComDTOs[i] = datosGeneralesComDTO;
				}
			}
		} catch (CustomerDomainException e) {
			logger.debug("getActividades():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getActividades()");
		return datosGeneralesComDTOs;
	}// fin getActividades
	
	
	
	/**
	 * Obtiene listado de estados civiles
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return arrayPlanTarifarioComDTO
	 * @throws AltaClienteException
	 */

	public DatosGeneralesComDTO[] getEstadosCiviles()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getEstadosCiviles()");		
		DatosGeneralesComDTO[] datosGeneralesComDTOs = new DatosGeneralesComDTO[5];
		datosGeneralesComDTOs[0] = new DatosGeneralesComDTO();
		datosGeneralesComDTOs[0].setCodigoValor(global.getValor("codigo.estadocivil.soltero"));
		datosGeneralesComDTOs[0].setDescripcionValor(global.getValor("estadocivil.soltero"));
		datosGeneralesComDTOs[1] = new DatosGeneralesComDTO();
		datosGeneralesComDTOs[1].setCodigoValor(global.getValor("codigo.estadocivil.casado"));
		datosGeneralesComDTOs[1].setDescripcionValor(global.getValor("estadocivil.casado"));
		datosGeneralesComDTOs[2] = new DatosGeneralesComDTO();
		datosGeneralesComDTOs[2].setCodigoValor(global.getValor("codigo.estadocivil.viudo"));
		datosGeneralesComDTOs[2].setDescripcionValor(global.getValor("estadocivil.viudo"));
		datosGeneralesComDTOs[3] = new DatosGeneralesComDTO();
		datosGeneralesComDTOs[3].setCodigoValor(global.getValor("codigo.estadocivil.divorciado"));
		datosGeneralesComDTOs[3].setDescripcionValor(global.getValor("estadocivil.divorciado"));
		datosGeneralesComDTOs[4] = new DatosGeneralesComDTO();
		datosGeneralesComDTOs[4].setCodigoValor(global.getValor("codigo.estadocivil.otro"));
		datosGeneralesComDTOs[4].setDescripcionValor(global.getValor("estadocivil.otro"));
		logger.debug("Fin:getEstadosCiviles()");		
		return datosGeneralesComDTOs;
	}// fin getEstadosCiviles

	
	
	
	/**
	 * Obtiene ciclos de facturación
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return registroFacturacionComDTOs
	 * @throws AltaClienteException
	 */

	public RegistroFacturacionComDTO[] getCiclosFacturacion()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getCiclosFacturacion()");
		// Busca indicador facturable por defecto
		RegistroFacturacionComDTO[] registroFacturacionComDTOs =null;
		try {
			RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();
			// Obtiene ciclo por defecto
			RegistroFacturacionDTO registroFacturacionDTO = getCicloFacturacionporDefecto(registroFacturacionBO);
			//Obtiene parametro COD_AMI_CICLO
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.ciclo.prepago"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);

			RegistroFacturacionDTO registroFacturacionDTO2 = new RegistroFacturacionDTO();
			registroFacturacionDTO2.setCicloPrePago(Integer.parseInt(parametrosGeneralesDTO.getValorparametro()));
			RegistroFacturacionDTO[] registroFacturacionDTOs = registroFacturacionBO
			.getListCiclosPostPago(registroFacturacionDTO2);

			if (registroFacturacionDTOs != null) {
				registroFacturacionComDTOs = new RegistroFacturacionComDTO[registroFacturacionDTOs.length];
				for (int i = 0; i < registroFacturacionDTOs.length; i++) {
					RegistroFacturacionComDTO registroFacturacionComDTO = new RegistroFacturacionComDTO();
					MapperIF mapper = new DozerBeanMapper();
					registroFacturacionComDTO = (RegistroFacturacionComDTO) mapper.map(registroFacturacionDTOs[i],
							RegistroFacturacionComDTO.class);
					// Asigna valor 1 al ciclo por defecto
					registroFacturacionComDTOs[i] = registroFacturacionComDTO;
					if (registroFacturacionComDTOs[i].getCodigoCicloFacturacion()==
							registroFacturacionDTO.getCodigoCicloFacturacion()) {
						RegistroFacturacionComDTO.indiceDefectoCicloFacturacion=i;
					}
				}
			}

			logger.debug("Fin:getCiclosFacturacion()");
		} catch (AltaClienteException e) {
			logger.debug("getCiclosFacturacion:end");
			logger.debug("AltaClienteException");
			throw e;
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}

		logger.debug("Fin:getCiclosFacturacion()");
		return registroFacturacionComDTOs;
	}// fin getCiclosFacturacion

	
	
	/**
	 * Obtiene ciclos de facturación
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return registroFacturacionComDTOs
	 * @throws AltaClienteException
	 */

	public RegistroFacturacionComDTO[] getCiclosFacturacionPrepago()
		throws Exception 
	{
		logger.debug("Inicio:getCiclosFacturacionPrepago()");
		// Busca indicador facturable por defecto
		RegistroFacturacionComDTO[] arrayCicloFact =null;
		try {
			RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();

			//Obtiene parametro COD_AMI_CICLO
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.ciclo.prepago"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);

			RegistroFacturacionComDTO regFact = new RegistroFacturacionComDTO();
			regFact.setCodigoCicloFacturacion(Integer.parseInt(parametrosGeneralesDTO.getValorparametro()));
			regFact.setDescripcionCiclo("("+parametrosGeneralesDTO.getValorparametro()+")"+global.getValor("descripcion.ciclo.prepago").trim());
			arrayCicloFact = new RegistroFacturacionComDTO[1];
			arrayCicloFact[0] = regFact;
			
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getCiclosFacturacionPrepago()");
		return arrayCicloFact;
	}// fin getCiclosFacturacion

	
	
	
	/**
	 * Obtiene ciclo facturación por defecto
	 * 
	 * @author Héctor Hermosilla
	 * @param
	 * @return registroFacturacionDTO
	 * @throws
	 */

	private RegistroFacturacionDTO getCicloFacturacionporDefecto(RegistroFacturacion registroFacturacionBO) 
		throws AltaClienteException
	{
		RegistroFacturacionDTO registroFacturacionDTO = null;
		logger.debug("Inicio:getCicloFacturacionporDefecto()");
		try{
			registroFacturacionDTO = registroFacturacionBO.getCicloFacturacion();
		} catch (CustomerDomainException e) {
			logger.debug("getAtributosCicloFacturable:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getCicloFacturacionporDefecto()");
		return registroFacturacionDTO;

	}// fin getCicloFacturacionporDefecto*/

	
	
	/**
	 * Ejecuta todos los procesos necesarios para crear cliente en SISCEL
	 * Este metodo lo usa la pagina web de GUATEMALA - EL SALVADOR
	 * @return 
	 * @throws AltaClienteException
	 */

	public ClienteAltaDTO crearCliente (ClienteAltaDTO clienteComDTO)
		throws AltaClienteException 
	{
		logger.debug("Inicio:crearClienteWeb()");
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		DatosGenerales datosGeneralesBO = new DatosGenerales();
		DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
		boolean existeCuenta = true;
		boolean datosDireccionEnviados= true;
		ClienteAltaDTO resultado = new ClienteAltaDTO();
		String codCuenta = "";
		
		try {
			//Verifica si la cuenta existe o no en BD
			//CuentaComDTO cuentaComDTO2 = getCuenta(cuentaComDTO);
			CuentaComDTO cuentaComDTO = new CuentaComDTO();
			cuentaComDTO.setNumeroIdentificacion(clienteComDTO.getNumeroIdentificacion());
			cuentaComDTO.setCodigoTipIdentif(clienteComDTO.getCodigoTipoIdentificacion());
			
			//(+) EV 04/01/10 numeros de identificacion duplicados
			//CuentaComDTO cuentaComDTO2 = this.getCuentaNumIdent(cuentaComDTO);
			CuentaComDTO cuentaComDTO2 = null;
			logger.debug("Codigo Cuenta: " + clienteComDTO.getCodigoCuenta());
			if (clienteComDTO.getCodigoCuenta() != null && !clienteComDTO.getCodigoCuenta().equals("0")){
				cuentaComDTO.setCodigoCuenta(clienteComDTO.getCodigoCuenta());
				cuentaComDTO2 = getCuenta(cuentaComDTO);
			}
			//(-)
			
			//Si la cuenta no existe se crea junto con la direccion
			if (cuentaComDTO2==null)
			{
				existeCuenta = false;
				//Se crea dirección de la cta con la informacion de la direccion personal que se envia en el cliente			
				DireccionNegocioWebDTO direccionNegocioDTO = new DireccionNegocioWebDTO();
				direccionNegocioDTO.setTipo(Integer.parseInt(global.getValor("tipo.direccion.cuenta")));							
				DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();		
				datosGenerales.setCodigoSecuencia(global.getValor("secuencia.direccion"));
				datosGenerales  = datosGeneralesBO.getSecuencia(datosGenerales);
				direccionNegocioDTO.setCodigo(String.valueOf(datosGenerales.getSecuencia()));				
				direccionNegocioDTO.setCodMunicipio(clienteComDTO.getCodMunicipio());
				direccionNegocioDTO.setCodDepartamento(clienteComDTO.getCodDepartamento());				
				direccionNegocioDTO.setCodZonaDistrito(clienteComDTO.getCodZonaDistrito());
				
				//Incidencia 134089: setear el valor de comuna (Loc/Barrio)
				direccionNegocioDTO.setLocBarrio(clienteComDTO.getLocBarrio());
				
				direccionNegocioDTO.setCodSiglaDomicilio(clienteComDTO.getCodSiglaDomicilio());
				direccionNegocioDTO.setNombreCalle(clienteComDTO.getNombreCalle());
				direccionNegocioDTO.setNumeroCalle(clienteComDTO.getNumeroCalle());
				direccionNegocioDTO.setObservacionDireccion(clienteComDTO.getObservacionDireccion());
				direccionNegocioDTO.setCodigoPostalDireccion(clienteComDTO.getCodigoPostalDireccion());
				direccionNegocioDTO.setDesDirec2(clienteComDTO.getDesDirec2());				
				direccionBO.setDireccion(direccionNegocioDTO);
				
				//Se crea la cuenta
				cuentaComDTO.setCodigoDireccion(new Long(datosGenerales.getSecuencia()).intValue());
				cuentaComDTO.setIndicadorEstado(global.getValor("indicador.estado.cuenta"));
				cuentaComDTO.setIndicadorMultUso(global.getValor("indicador.multiuso"));
				cuentaComDTO.setClientePotencial(global.getValor("indicador.cliente.potencial"));
				cuentaComDTO.setDescripcionCuenta(clienteComDTO.getNombreCliente());
				String nombreCuenta="";
				if (clienteComDTO.getCodigoTipoCliente().equals(global.getValor("indicador.tipo.cliente.empresa").trim())
						||clienteComDTO.getCodigoTipoCliente().equals(global.getValor("indicador.tipo.cliente.pyme").trim()))
				{
					nombreCuenta = clienteComDTO.getNombreCliente();
				}else {	
					
					String apellido1 = clienteComDTO.getNombreApellido1()==null?"":clienteComDTO.getNombreApellido1();
					String apellido2 = clienteComDTO.getNombreApellido2()==null?"":clienteComDTO.getNombreApellido2();
						
					nombreCuenta = clienteComDTO.getNombreCliente()+" "+apellido1+" "+apellido2;					
				}
				
				cuentaComDTO.setResponsable(nombreCuenta);
				
                if (clienteComDTO.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.empresa").trim())
                		||clienteComDTO.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.pyme").trim()))
                {
                	cuentaComDTO.setTipoCuenta(global.getValor("indicador.tipo.cuenta.empresa"));
				}else{
					cuentaComDTO.setDescripcionCuenta(nombreCuenta);
					cuentaComDTO.setDescripcionSubCuenta(nombreCuenta);
				    cuentaComDTO.setTipoCuenta(global.getValor("indicador.tipo.cuenta.natural"));					
				}
				
                cuentaComDTO.setDescripcionSubCuenta(clienteComDTO.getNombreCliente());
				//cuentaComDTO.setTelefonoContacto(clienteComDTO.getNumeroTelefono2());
				
                
                /*parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
				parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
				parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.categoria.tributaria").trim());
				parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
				cuentaComDTO.setCodigoCategTributaria(parametrosGeneralesDTO.getValorparametro());*/
				
				cuentaComDTO.setCodigoCategTributaria(clienteComDTO.getCategoriaTributaria());
				
				parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
				parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
				parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.categoria.cliente.defecto").trim());
				parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
				cuentaComDTO.setCodigoCategoria(parametrosGeneralesDTO.getValorparametro());				
				
				crearCuenta(cuentaComDTO);
				//cuentaComDTO2 = this.getCuentaNumIdent(cuentaComDTO);
				cuentaComDTO2 = getCuenta(cuentaComDTO);
				
				if (cuentaComDTO.getClienteComDTO()!=null){
					cuentaComDTO.getClienteComDTO().setCodigoCuenta(cuentaComDTO.getCodigoCuenta());
				}
				cuentaComDTO2.setCodigoDireccion(new Long(datosGenerales.getSecuencia()).intValue());
				codCuenta = cuentaComDTO.getCodigoCuenta();
			}
			else {
			    // Verificar si la cuenta tiene subcuenta
				codCuenta = cuentaComDTO2.getCodigoCuenta();
				cuentaComDTO2 =	existeSubCuenta(cuentaComDTO2);
				boolean existeSubCuenta = cuentaComDTO2.getExisteSubCuenta()==1?true:false;
				if (!existeSubCuenta){
					cuentaComDTO2.setDescripcionSubCuenta(cuentaComDTO2.getDescripcionCuenta());
					Cuenta cuentaBO = new Cuenta();
					MapperIF mapper = new DozerBeanMapper();
					CuentaDTO cuentaDTO = (CuentaDTO) mapper.map(cuentaComDTO2, CuentaDTO.class);
					crearSubCuenta(cuentaBO,cuentaDTO);
				}
			}
			
			
			//Seteo de valores
			clienteComDTO.setCodigoCuenta(cuentaComDTO2.getCodigoCuenta());			
			clienteComDTO.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto").trim()));
			// Codigo Modificacion
			clienteComDTO.setCodigoModificacion(global.getValor("codigo.modificacion.cliente"));
			//Calidad
			datosGeneralesDTO.setColumna(global.getValor("nombre.columna.calidad.cliente").trim());
			datosGeneralesDTO = datosGeneralesBO.getDatosGener(datosGeneralesDTO);
			clienteComDTO.setCodigoCalidadCliente(datosGeneralesDTO.getValorParametro());
			// Codigo ABC
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.codigo.abc"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteComDTO.setCodigoABC(parametrosGeneralesDTO.getValorparametro());
			// Codigo123
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.codigo.123"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteComDTO.setCodigo123(parametrosGeneralesDTO.getValorparametro());
			// Operadora			
			clienteComDTO.setCodigoOperadora(clienteBO.getCodigoOperadoraCliente());
			// Codigo uso
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.uso.venta"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteComDTO.setCodigoUso(parametrosGeneralesDTO.getValorparametro());
			// Otros
			clienteComDTO.setCodigoIdioma(global.getValor("codigo.idioma.defecto").trim());
			clienteComDTO.setIndicadorSituacion(global.getValor("indicador.situacion").trim());
			clienteComDTO.setIndicativoFacturable(Integer.parseInt(global.getValor("indicador.facturable.si").trim())); 
			clienteComDTO.setIndicadorTraspaso(global.getValor("indicador.traspaso.si").trim());
			clienteComDTO.setIndicadorAgente(global.getValor("indicador.agente").trim());	
			clienteComDTO.setIndicadorAcepVenta(global.getValor("indicador.aceptacion.venta").trim());
			// Plan comercial 
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.plan.comercial").trim());
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteComDTO.setCodigoPlanComercial(parametrosGeneralesDTO.getValorparametro());
			
			//Se cometa ya que va el valor que se ingreso en la pantalla
			// Categoria impositiva 
			/*parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.categoria.impositiva.defecto").trim());
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteComDTO.setCodigoCategImpos(parametrosGeneralesDTO.getValorparametro());*/			
			
			//Se cometa ya que va el valor que se ingreso en la pantalla
			// Categoria tributaria
			/*parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.categoria.tributaria").trim());
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);*/
			
			clienteComDTO.setCategoriaTributaria(clienteComDTO.getCategoriaTributaria());
			clienteComDTO.setNumeroAbocel(global.getValor("codigo.numero.abocel").trim());			
			clienteComDTO.setNumeroAbobeep(global.getValor("codigo.numero.abobeep").trim());
			clienteComDTO.setNumeroAbotrunk(global.getValor("codigo.numero.abotrunk").trim());		    
			clienteComDTO.setNumeroAbotrek(global.getValor("codigo.numero.abotrek").trim());
			clienteComDTO.setNumeroAborent(global.getValor("codigo.numero.aborent").trim());		    
			clienteComDTO.setNumeroAboroaming(global.getValor("codigo.numero.aboroaming").trim());			
			clienteComDTO.setCodigoNPI(global.getValor("codigo.npi").trim());
			if(clienteComDTO.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.empresa").trim())
					||clienteComDTO.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.pyme").trim()))
			{
				clienteComDTO.setIndicadirTipPersona(global.getValor("indicador.tipo.juridica"));
			}else clienteComDTO.setIndicadirTipPersona(global.getValor("indicador.tipo.natural"));
									
			//Sub-categoria
			clienteComDTO.setCodigoSubCategoria(clienteComDTO.getCodigoSubCategoria());
						
			
			//Genera direcciones
			for (int i=0;i<3;i++){
				if(!clienteComDTO.getDirecciones()[i].isReplicada())
				{
					datosGeneralesDTO = new DatosGeneralesDTO();
					datosGeneralesDTO.setCodigoSecuencia(global.getValor("secuencia.direccion"));
					datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);					
					clienteComDTO.getDirecciones()[i].setCodigo(String.valueOf(datosGeneralesDTO.getSecuencia()));
					direccionBO.setDireccion(clienteComDTO.getDirecciones()[i]);
				} 	else {			
					clienteComDTO.getDirecciones()[i].setCodigo(String.valueOf(datosGeneralesDTO.getSecuencia()));
				}
			}
						
			// Setea responsables del cliente
		    MapperIF mapper = new DozerBeanMapper();
			RepresentanteLegalComDTO[] arrayRepresentantes = null;
			
			if (clienteComDTO.getRepresentanteLegalComDTO()!=null){
				// Esto se haría para persona jurídica y natural
				arrayRepresentantes = new RepresentanteLegalComDTO[clienteComDTO.getRepresentanteLegalComDTO().length];
				for(int i=0;i<clienteComDTO.getRepresentanteLegalComDTO().length;i++){
					if (clienteComDTO.getRepresentanteLegalComDTO()[i]!=null){
						arrayRepresentantes[i] = new RepresentanteLegalComDTO();
						arrayRepresentantes[i] = (RepresentanteLegalComDTO) mapper.map(clienteComDTO.getRepresentanteLegalComDTO()[i], RepresentanteLegalComDTO.class);
					}	
				}
			}
			
			clienteComDTO.setRepresentanteLegalComDTO(arrayRepresentantes);
			
			//Obtiene secuencia del cliente
			datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoSecuencia(global.getValor("secuencia.cliente"));
			datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);
			clienteComDTO.setCodigoCliente(String.valueOf(datosGeneralesDTO.getSecuencia()));			
			clienteComDTO.setCodigoOperadora(datosGeneralesBO.getCodigoOperadora());
			
			//Sea indicador de alta dependiendo del tipo de cliente
			if(clienteComDTO.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
			{
				clienteComDTO.setIndicadorAlta(global.getValor("indicador.alta.prepago"));
			}else clienteComDTO.setIndicadorAlta(global.getValor("indicador.alta.pospago"));
						
			//TODO: revisar firma
			//Registra Cliente
			logger.debug("Inicio:crearCliente() --> Registra cliente");
			clienteComDTO.setIndicadorDebito(clienteComDTO.getModalidadCancelacionComDTO().getCodigo().trim());
			clienteBO.insClienteSrv(clienteComDTO);
			clienteComDTO.setCodigoCliente(clienteComDTO.getCodigoCliente());						
			
			if (clienteComDTO.getModalidadCancelacionComDTO().getCodigo().trim().equals(global.
					getValor("modalidad.cancelacion.automatica.sigla").trim()))
			{
				ConceptosCobranzaDTO conceptosCobranzaDTO = new ConceptosCobranzaDTO();
				ConceptosCobranza conceptosCobranza = new ConceptosCobranza();
				conceptosCobranzaDTO.setCodigoCliente(clienteComDTO.getCodigoCliente());
				if(clienteComDTO.getCodigoBanco()!= null)
				{
					conceptosCobranzaDTO.setCodigoBanco(clienteComDTO.getCodigoBanco());
				}else{
					conceptosCobranzaDTO.setCodigoBanco(clienteComDTO.getCodigoBancoTarjeta());
				}
				conceptosCobranzaDTO.setNumeroTelefono(clienteComDTO.getCodigoCliente());//En VB esta así. 
				conceptosCobranzaDTO.setCodigoZona(global.getValor("pac.codigo.zona"));
				conceptosCobranzaDTO.setCodigoBcoi(global.getValor("pac.codigo.bancoi"));
				conceptosCobranzaDTO.setCodigoCentral(global.getValor("pac.codigo.central"));
				conceptosCobranza.insPagoAutomatico(conceptosCobranzaDTO);
			}
			
			//Inserta datos cliente factura
			logger.debug("Inicio:crearCliente() --> Inserta cliente factura imprimible");
			if(clienteComDTO.getFacturaNombreTercero() != null && 
					clienteComDTO.getFacturaNombreTercero().trim().equals(global.getValor("factura.nombre.tercero")))
			{
				clienteComDTO.setTipoFacturaClienteFactura(global.getValor("tipo.factura.cliente.factura").trim());
				clienteComDTO.setTipoDocumentoClienteFactura(Long.valueOf(global.getValor("tipo.documento.cliente.factura").trim()));
				clienteBO.crearClienteFacturaImprimible(clienteComDTO);
			}
			
			//Inserta monto preautorizado
			logger.debug("Inicio:crearCliente() --> Inserta monto preautorizado");
			clienteBO.insMontoPreautorizado(clienteComDTO);
			
			//(+) EV 02/11/2009
			//Inserta referencias
			if (clienteComDTO.getReferenciasCliente()!=null){
				for(int i=0; i<clienteComDTO.getReferenciasCliente().length;i++){
					ReferenciaClienteDTO referencia = new ReferenciaClienteDTO();
					referencia.setNumeroReferencia(Long.parseLong(clienteComDTO.getReferenciasCliente()[i].getNumReferencia()));					
					referencia.setCodigoCliente(Long.parseLong(clienteComDTO.getCodigoCliente()));
					referencia.setNomCliente(clienteComDTO.getReferenciasCliente()[i].getNombreReferencia());
					referencia.setApellido1(clienteComDTO.getReferenciasCliente()[i].getPrimerApellido());
					referencia.setApellido2(clienteComDTO.getReferenciasCliente()[i].getSegundoApellido());
					if (clienteComDTO.getReferenciasCliente()[i].getTelefonoReferenciaFijo()!=null && !clienteComDTO.getReferenciasCliente()[i].getTelefonoReferenciaFijo().equals(""))
						referencia.setTelefonoReferenciaFijo(Long.parseLong(clienteComDTO.getReferenciasCliente()[i].getTelefonoReferenciaFijo()));
					if (clienteComDTO.getReferenciasCliente()[i].getTelefonoReferenciaMovil()!=null && !clienteComDTO.getReferenciasCliente()[i].getTelefonoReferenciaMovil().equals(""))
						referencia.setTelefonoReferenciaMovil(Long.parseLong(clienteComDTO.getReferenciasCliente()[i].getTelefonoReferenciaMovil()));
					
					referencia.setNomUsuario(clienteComDTO.getNombreUsuarOra());
					clienteBO.insReferenciaCliente(referencia);
				}
			}
			//(-)
			
			//(+) EV 23/02/2010
			//Asocia categoria de cambio a cliente
			CategoriaCambioClienteDTO categCambio =  new CategoriaCambioClienteDTO();
			categCambio.setCodCategoriaCambio(Integer.parseInt(clienteComDTO.getCodigoCategCambio()));
			categCambio.setCodCliente(Long.parseLong(clienteComDTO.getCodigoCliente()));
			categCambio.setNomUsuario(clienteComDTO.getNombreUsuarOra());
			clienteBO.insCategoriaCambioCliente(categCambio);
			//(-)
			
			resultado.setCodigoCliente(clienteComDTO.getCodigoCliente());
			resultado.setCodigoCuenta(codCuenta);
			logger.debug("Inicio:crearCliente() resultado --> " + resultado);
		} 
		catch (AltaClienteException e) {
			logger.debug("crearClienteWeb:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} 
		catch (CustomerDomainException e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			AltaClienteException a = new AltaClienteException();
			a.setMessage(e.getMessage());
			a.setCodigo(e.getCodigo());
			a.setCodigoEvento(e.getCodigoEvento());
			a.setDescripcionEvento(e.getDescripcionEvento());
			throw a;
		}
		catch (ProductDomainException e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			AltaClienteException a = new AltaClienteException();
			a.setMessage(e.getMessage());
			a.setCodigo(e.getCodigo());
			a.setCodigoEvento(e.getCodigoEvento());
			a.setDescripcionEvento(e.getDescripcionEvento());
			throw a;
		}
		logger.debug("Fin:crearClienteWeb()");
		return resultado;
	}// fin crearCliente	

	
	/**
	 * Ejecuta todos los procesos necesarios para crear cliente en SISCEL
	 * 
	 * @author Héctor Hermosilla
	 * @param cuentaComDTO
	 * @return 
	 * @throws AltaClienteException
	 */

	public void crearCliente(CuentaComDTO cuentaComDTO)
		throws AltaClienteException 
	{
		logger.debug("Inicio:crearCliente()");
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		
		try {
			
			//Verifica si la cuenta existe o no en BD
			CuentaComDTO cuentaComDTO2 = getCuenta(cuentaComDTO);
			
			//Si la cuenta no existe se registra en BD
			if (cuentaComDTO2 ==null){
				logger.debug("Inicio:crearCliente() --> Cuenta NO existe");
				cuentaComDTO.setIndicadorEstado(global.getValor("indicador.estado.cuenta"));
				cuentaComDTO.setIndicadorMultUso(global.getValor("indicador.multiuso"));
				cuentaComDTO.setClientePotencial(global.getValor("indicador.cliente.potencial"));
				crearCuenta(cuentaComDTO);
				if (cuentaComDTO.getClienteComDTO()!=null){
					cuentaComDTO.getClienteComDTO().setCodigoCuenta(cuentaComDTO.getCodigoCuenta());
				}
			}
			else{
				logger.debug("Inicio:crearCliente() --> Cuenta SI existe");
				// Crear subcuenta si no existe
				cuentaComDTO2 =	existeSubCuenta(cuentaComDTO2);
				boolean existeSubCuenta = cuentaComDTO2.getExisteSubCuenta()==1?true:false;
				// Si no existe subcuenta crear una
				if (!existeSubCuenta){
					cuentaComDTO2.setDescripcionSubCuenta(cuentaComDTO2.getDescripcionCuenta());
					Cuenta cuentaBO = new Cuenta();
					MapperIF mapper = new DozerBeanMapper();
					CuentaDTO cuentaDTO = (CuentaDTO) mapper.map(cuentaComDTO2, CuentaDTO.class);
					crearSubCuenta(cuentaBO,cuentaDTO);
				}
				// Categorizar la cuenta
				cuentaComDTO2 = categorizacionCuenta(cuentaComDTO,cuentaComDTO2);
			}
				
			ClienteDTO clienteDTO = null;
			if (cuentaComDTO.getClienteComDTO()!=null){
				logger.debug("Inicio:crearCliente() --> Setea datos del cliente");
				ClienteComDTO clienteComDTO = cuentaComDTO.getClienteComDTO();				
				clienteDTO = new ClienteDTO();
				MapperIF mapper = new DozerBeanMapper();
				clienteDTO = (ClienteDTO) mapper.map(clienteComDTO, ClienteDTO.class);
				clienteDTO.setIndicadorAgente(global.getValor("indicador.agente"));
				clienteDTO.setIndicadorSituacion(global.getValor("indicador.situacion"));
				clienteDTO.setIndicadorAcepVenta(global.getValor("indicador.aceptacion.venta"));
				clienteDTO.setIndicadorTraspaso(global.getValor("indicador.traspaso.si").trim());
				clienteDTO.setCodigoModificacion(global.getValor("codigo.modificacion.cliente"));
				
				logger.debug("Inicio:crearCliente() --> Setea direcciones"); 
				//Almacena direcciones del cliente
				if (clienteComDTO.getDirecciones()!=null){
					DireccionNegocioDTO[] direccionNegocios = new DireccionNegocioDTO[clienteComDTO.getDirecciones().length];
					for(int i=0;i<clienteComDTO.getDirecciones().length;i++)
					{
						if (clienteComDTO.getDirecciones()[i]!=null)
						{
							direccionNegocios[i] = new DireccionNegocioDTO();
							direccionNegocios[i] = (DireccionNegocioDTO) mapper.map(clienteComDTO.getDirecciones()[i], DireccionNegocioDTO.class);
						}
					}
					clienteDTO.setDirecciones(direccionNegocios);
				}
				
				logger.debug("Inicio:crearCliente() --> Setea responsables");
				// Setea responsables del cliente
				RepresentanteLegalDTO[] arrayRepresentantes = null;
				if (clienteComDTO.getRepresentanteLegalComDTO()!=null){
					arrayRepresentantes = new RepresentanteLegalDTO[clienteComDTO.getRepresentanteLegalComDTO().length];
					for(int i=0;i<clienteComDTO.getRepresentanteLegalComDTO().length;i++){
						if (clienteComDTO.getRepresentanteLegalComDTO()[i]!=null){
							arrayRepresentantes[i] = new RepresentanteLegalDTO();
							arrayRepresentantes[i] = (RepresentanteLegalDTO) mapper.map(clienteComDTO.getRepresentanteLegalComDTO()[i], RepresentanteLegalDTO.class);
						}	
					}
				}
				clienteDTO.setRepresentanteLegalDTO(arrayRepresentantes);
				
				//Obtiene secuencia del cliente
				logger.debug("Inicio:crearCliente() --> Obtiene secuencia del cliente");
				DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
				datosGeneralesDTO.setCodigoSecuencia(global.getValor("secuencia.cliente"));
				DatosGenerales datosGeneralesBO = new DatosGenerales();
				datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);
				clienteDTO.setCodigoCliente(String.valueOf(datosGeneralesDTO.getSecuencia()));
				//Obtiene calidad 
				datosGeneralesDTO.setColumna(global.getValor("nombre.columna.calidad.cliente").trim());
				datosGeneralesDTO = datosGeneralesBO.getDatosGener(datosGeneralesDTO);
				clienteDTO.setCodigoCalidadCliente(datosGeneralesDTO.getValorParametro());
				clienteDTO.setCodigoOperadora(datosGeneralesBO.getCodigoOperadora());
				// Si no se ingresa pais en pantalla se llena con un valor por defecto
				if (clienteDTO.getCodigoPais()==null){
					clienteDTO.setCodigoPais(global.getValor("codigo.pais.defecto").trim());
				}
				// Numero abocel
				clienteDTO.setNumeroAbocel(global.getValor("codigo.numero.abocel").trim());
				// Indicador de privacidad
				clienteDTO.setCodigoNPI(global.getValor("codigo.npi").trim());
				// Codigo de uso
				clienteDTO.setCodigoUso(null);
				// Codigo tipo de identificacion tributaria
				// Número de identificacion tributaria
				if (clienteDTO.getCodigoTipoIdentificacionTributaria()==null){
					clienteDTO.setCodigoTipoIdentificacionTributaria(clienteDTO.getCodigoTipoIdentificacion());
				}
				if (clienteDTO.getNumeroIdentificacionTributaria()==null){
					clienteDTO.setNumeroIdentificacionTributaria(clienteDTO.getNumeroIdentificacion());
				}
				
				
				//Registra Cliente
				logger.debug("Inicio:crearCliente() --> Registra cliente");
				//Sea indicador de alta dependiendo del tipo de cliente
				if(clienteDTO.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
				{
					clienteDTO.setIndicadorAlta(global.getValor("indicador.alta.prepago"));
				}else clienteDTO.setIndicadorAlta(global.getValor("indicador.alta.pospago"));
				
				//clienteBO.insCliente(clienteDTO);
				
				//Si es cliente empresa registra en la tabla ge_empresa 
				if ( clienteDTO.getCodigoTipoCliente()!=null && 
						clienteDTO.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.empresa")) 
						&& clienteDTO.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.pyme")))
				{					
					//clienteBO.insEmpresa(clienteDTO);					
					if (clienteDTO.getPlanTarifario() != null && !clienteDTO.getPlanTarifario().trim().equals("") 
							&& clienteDTO.getMontoDescuento()!=null)
					{						
						clienteBO.insDescCliBolsaDinamica(clienteDTO);				
					}	
				}
				
				if (clienteComDTO.getModalidadCancelacionComDTO().getCodigo().equals(global.
						getValor("modalidad.cancelacion.automatica.ind")))
				{
					ConceptosCobranzaDTO conceptosCobranzaDTO = new ConceptosCobranzaDTO();
					ConceptosCobranza conceptosCobranza = new ConceptosCobranza();
					conceptosCobranzaDTO.setCodigoCliente(clienteDTO.getCodigoCliente());
					conceptosCobranzaDTO.setCodigoBanco(clienteDTO.getCodigoBanco());
					conceptosCobranzaDTO.setNumeroTelefono(clienteDTO.getCodigoCliente());//En VB esta así. 
					conceptosCobranzaDTO.setCodigoZona(global.getValor("pac.codigo.zona"));
					conceptosCobranzaDTO.setCodigoBcoi(global.getValor("pac.codigo.bancoi"));
					conceptosCobranzaDTO.setCodigoCentral(global.getValor("pac.codigo.central"));
					conceptosCobranza.insPagoAutomatico(conceptosCobranzaDTO);
				}
				// Actualiza categoria del cliente
				logger.debug("Inicio:crearCliente() --> Update categoria del cliente");
				clienteBO.updCategCliente(clienteDTO) ;				
			}
			
			cuentaComDTO2 = getCuenta(cuentaComDTO);
			if (cuentaComDTO2!=null){
				if (clienteDTO!=null && cuentaComDTO.getClienteComDTO()!=null){
					cuentaComDTO.getClienteComDTO().setCodigoCliente(clienteDTO.getCodigoCliente());
					cuentaComDTO.getClienteComDTO().setCodigoEmpresa(clienteDTO.getCodigoEmpresa());
				}	
				cuentaComDTO2 = categorizacionCuenta(cuentaComDTO,cuentaComDTO2);
			}
			

		} catch (CustomerDomainException e) {
			logger.debug("crearCliente:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:crearCliente()");
		
	}// fin crearCliente	

	/**
	 * Ejecuta todos los procesos necesarios para crear cliente en SISCEL
	 * Este metodo lo usa el webservice del COL08009
	 * @author Mario Tigua
	 * @param cuentaComDTO
	 * @return 
	 * @throws AltaClienteException
	 */

	public ClienteComDTO crearCliente (ClienteComDTO clienteComDTO)
		throws AltaClienteException 
	{
		logger.debug("Inicio:crearCliente()");
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		DatosGenerales datosGeneralesBO = new DatosGenerales();
		DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
		boolean existeCuenta = true;
		boolean datosDireccionEnviados= true;
		
		try {
			//Verifica si la cuenta existe o no en BD
			//CuentaComDTO cuentaComDTO2 = getCuenta(cuentaComDTO);
			CuentaComDTO cuentaComDTO = new CuentaComDTO(); 
			cuentaComDTO.setNumeroIdentificacion(clienteComDTO.getNumeroIdentificacion());
			cuentaComDTO.setCodigoTipIdentif(clienteComDTO.getCodigoTipoIdentificacion());
			CuentaComDTO cuentaComDTO2 = this.getCuentaNumIdent(cuentaComDTO);
			
			//Si al cuenta no existe se crea junto con la direccion
			if (cuentaComDTO2==null)
			{
				existeCuenta = false;
				//Se crea dirección de la cta							
				DireccionNegocioDTO direccionNegocioDTO = new DireccionNegocioDTO();
				direccionNegocioDTO.setTipo(Integer.parseInt(global.getValor("tipo.direccion.cuenta")));							
				DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();		
				datosGenerales.setCodigoSecuencia(global.getValor("secuencia.direccion"));
				datosGenerales  = datosGeneralesBO.getSecuencia(datosGenerales);
				direccionNegocioDTO.setCodigo(String.valueOf(datosGenerales.getSecuencia()));
				direccionNegocioDTO.setProvincia(clienteComDTO.getCodProvincia());
				direccionNegocioDTO.setRegion(clienteComDTO.getCodRegion());
				direccionNegocioDTO.setCiudad(clienteComDTO.getCodCiudad());
				direccionNegocioDTO.setComuna(clienteComDTO.getCodComuna());
				direccionNegocioDTO.setCalle(clienteComDTO.getNomCalle());
				direccionNegocioDTO.setNumero(clienteComDTO.getNumCalle());
				direccionNegocioDTO.setZip(clienteComDTO.getZip());
				direccionNegocioDTO.setDescripcionDireccion1(clienteComDTO.getDesDirec1());
				direccionNegocioDTO.setDescripcionDireccion2(clienteComDTO.getDesDirec2());
				direccionNegocioDTO.setTipoCalle(clienteComDTO.getTipoCalle());
				direccionNegocioDTO.setObservacionDescripcion(clienteComDTO.getObservacionDireccion());
				//direccionBO.setDireccion(direccionNegocioDTO);
				
				//Se crea la cuenta
				cuentaComDTO.setCodigoDireccion(new Long(datosGenerales.getSecuencia()).intValue());
				cuentaComDTO.setIndicadorEstado(global.getValor("indicador.estado.cuenta"));
				cuentaComDTO.setIndicadorMultUso(global.getValor("indicador.multiuso"));
				cuentaComDTO.setClientePotencial(global.getValor("indicador.cliente.potencial"));
				cuentaComDTO.setDescripcionCuenta(clienteComDTO.getNombreCliente());
				String nombreCuenta = clienteComDTO.getNombreCliente()+" "+clienteComDTO.getNombreApellido1()+" "+clienteComDTO.getNombreApellido2();
				cuentaComDTO.setResponsable(nombreCuenta);
				
				
				
                if (clienteComDTO.getIndicadirTipPersona().equals(global.getValor("indicador.tipo.natural").trim())){
				    cuentaComDTO.setDescripcionCuenta(nombreCuenta);
				    cuentaComDTO.setTipoCuenta(global.getValor("indicador.tipo.cuenta.natural"));
				}else{
					cuentaComDTO.setTipoCuenta(global.getValor("indicador.tipo.cuenta.empresa"));
				}
				
                cuentaComDTO.setDescripcionSubCuenta(clienteComDTO.getNombreCliente());
				cuentaComDTO.setTelefonoContacto(clienteComDTO.getNumeroTelefono2());
				parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
				parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
				parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.categoria.tributaria").trim());
				parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
				cuentaComDTO.setCodigoCategTributaria(parametrosGeneralesDTO.getValorparametro());
				
				parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
				parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
				parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.categoria.cliente.defecto").trim());
				parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
				cuentaComDTO.setCodigoCategoria(parametrosGeneralesDTO.getValorparametro());				
				
				crearCuenta(cuentaComDTO);
				cuentaComDTO2 = this.getCuentaNumIdent(cuentaComDTO);
				if (cuentaComDTO.getClienteComDTO()!=null){
					cuentaComDTO.getClienteComDTO().setCodigoCuenta(cuentaComDTO.getCodigoCuenta());
				}
				cuentaComDTO2.setCodigoDireccion(new Long(datosGenerales.getSecuencia()).intValue());
			}
			else {
			    // Verificar si la cuenta tiene subcuenta
				cuentaComDTO2 =	existeSubCuenta(cuentaComDTO2);
				boolean existeSubCuenta = cuentaComDTO2.getExisteSubCuenta()==1?true:false;
				if (!existeSubCuenta){
					cuentaComDTO2.setDescripcionSubCuenta(cuentaComDTO2.getDescripcionCuenta());
					Cuenta cuentaBO = new Cuenta();
					MapperIF mapper = new DozerBeanMapper();
					CuentaDTO cuentaDTO = (CuentaDTO) mapper.map(cuentaComDTO2, CuentaDTO.class);
					crearSubCuenta(cuentaBO,cuentaDTO);
				}
			}
			
			ClienteDTO clienteDTO = new ClienteDTO();			
			MapperIF mapper = new DozerBeanMapper();
			clienteDTO = (ClienteDTO) mapper.map(clienteComDTO, ClienteDTO.class);
			//Seteo de valores
			clienteDTO.setCodigoCuenta(cuentaComDTO2.getCodigoCuenta());
				
			if (clienteDTO.getCodigoTipoCliente().equals(global.getValor("indicador.tipo.cliente.prepago").trim())	
			){
			   clienteDTO.setIndicadorAlta(global.getValor("indicador.alta.prepago").trim());
			   // Codigo ciclo amistar
			   parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim()); 
			   parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim()); 
			   parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.amiciclo").trim());  
			   parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			   clienteDTO.setCodigoCicloFacturacion(parametrosGeneralesDTO.getValorparametro());
			} 
			else if (clienteDTO.getCodigoTipoCliente().equals(global.getValor("indicador.tipo.cliente.pospago").trim())){
			   clienteDTO.setIndicadorAlta(global.getValor("indicador.alta.pospago").trim());
			   // Obtiene el ciclo de facturacion 
			   Factura facturaBO = new Factura();
			   FacturaDTO facturaDTO = facturaBO.getDatosCicloFacturacion();
			   clienteDTO.setCodigoCicloFacturacion(facturaDTO.getCodigoCiclo());
			}
			
			//Nombre se cambia a peticion de incidencia nro 39
			//clienteDTO.setNombreCliente(cuentaComDTO2.getDescripcionCuenta());
			clienteDTO.setNombreCliente(clienteDTO.getNombreCliente());
			// Descripcion empresa
			clienteDTO.setDescripcionEmpresa(cuentaComDTO2.getDescripcionCuenta());
			// Producto
			clienteDTO.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto").trim()));
			// Codigo Modificacion
			clienteDTO.setCodigoModificacion(global.getValor("codigo.modificacion.cliente"));
			//Calidad
			datosGeneralesDTO.setColumna(global.getValor("nombre.columna.calidad.cliente").trim());
			datosGeneralesDTO = datosGeneralesBO.getDatosGener(datosGeneralesDTO);
			clienteDTO.setCodigoCalidadCliente(datosGeneralesDTO.getValorParametro());
			// Codigo ABC
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.codigo.abc"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteDTO.setCodigoABC(parametrosGeneralesDTO.getValorparametro());
			// Codigo123
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.codigo.123"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteDTO.setCodigo123(parametrosGeneralesDTO.getValorparametro());
			// Operadora			
			clienteDTO.setCodigoOperadora(clienteBO.getCodigoOperadoraCliente());
			// Codigo uso
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.uso.venta"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteDTO.setCodigoUso(parametrosGeneralesDTO.getValorparametro());
			// Otros
			clienteDTO.setCodigoIdioma(global.getValor("codigo.idioma.defecto").trim());
			clienteDTO.setIndicadorSituacion(global.getValor("indicador.situacion").trim());
			clienteDTO.setIndicativoFacturable(Integer.parseInt(global.getValor("indicador.facturable.si").trim())); 
			clienteDTO.setIndicadorTraspaso(global.getValor("indicador.traspaso.si").trim());
			clienteDTO.setIndicadorAgente(global.getValor("indicador.agente").trim());	
			clienteDTO.setIndicadorAcepVenta(global.getValor("indicador.aceptacion.venta").trim());
			// Plan comercial 
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.plan.comercial").trim());
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteDTO.setCodigoPlanComercial(parametrosGeneralesDTO.getValorparametro());	
			// Categoria impositiva 
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.categoria.impositiva.defecto").trim());
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteDTO.setCodigoCategImpos(parametrosGeneralesDTO.getValorparametro());
			// Categoria tributaria
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.categoria.tributaria").trim());
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			clienteDTO.setCategoriaTributaria(parametrosGeneralesDTO.getValorparametro());			
				
			clienteDTO.setNumeroAbocel(global.getValor("codigo.numero.abocel").trim());			
			clienteDTO.setNumeroAbobeep(global.getValor("codigo.numero.abobeep").trim());			
			clienteDTO.setIndicadorDebito(global.getValor("codigo.numero.debito").trim());		    
			clienteDTO.setNumeroAbotrunk(global.getValor("codigo.numero.abotrunk").trim());		    
			clienteDTO.setNumeroAbotrek(global.getValor("codigo.numero.abotrek").trim());
			clienteDTO.setNumeroAborent(global.getValor("codigo.numero.aborent").trim());		    
			clienteDTO.setNumeroAboroaming(global.getValor("codigo.numero.aboroaming").trim());			
			clienteDTO.setCodigoNPI(global.getValor("codigo.npi").trim());
			
			//Prospecto cliente
			ProspectoDTO prospectoDTO = new ProspectoDTO();
			prospectoDTO.setCodigoTipoIdent(clienteComDTO.getCodigoTipoIdentificacion());
			prospectoDTO.setNumeroIdent(clienteComDTO.getNumeroIdentificacion());
			prospectoDTO = prospectoBO.getProspectoCliente(prospectoDTO);
			if(prospectoDTO != null && prospectoDTO.getCodigoTipoIdent() != null && 
					!prospectoDTO.getCodigoTipoIdent().trim().equals(""))
			{
				clienteDTO.setCodigoTipoIdentificacionApoderado(prospectoDTO.getCodigoTipoIdent());
			}
						
			//Categoria
			clienteDTO.setCodigoCategoriaEmpresa(cuentaComDTO2.getCodigoCategoria());
			//Sub-categoria
			clienteDTO.setCodigoSubCategoria(clienteComDTO.getCodigoSubCategoria());
			
			//Codigo tipo identificacion tributaria
			clienteDTO.setCodigoTipoIdentificacionTributaria(cuentaComDTO.getCodigoTipIdentif());
			
			//Numero identificacion tributaria
			clienteDTO.setNumeroIdentificacionTributaria(cuentaComDTO.getNumeroIdentificacion());

			// Direccion de la cuenta 
			Direccion direccionBO = new Direccion();
			DireccionNegocioDTO direccionNegocioCuentaDTO = new DireccionNegocioDTO();
			direccionNegocioCuentaDTO.setCodigo(String.valueOf(cuentaComDTO2.getCodigoDireccion()));
			direccionNegocioCuentaDTO = direccionBO.getDireccionCodigo(direccionNegocioCuentaDTO);

			
			if(existeCuenta && clienteComDTO.getCodProvincia() != null 
					&& clienteComDTO.getCodRegion() != null && clienteComDTO.getCodCiudad() != null
					&& clienteComDTO.getCodComuna()	!= null && clienteComDTO.getNomCalle() != null
					&& clienteComDTO.getNumCalle() != null)
			{
				//Segun MA si existe la cuenta pero están enviando los datos de la direccion como 
				//parametros de entrada se debe crear las direcciones con los nuevos datos y no con la direccion de la cuenta
				datosDireccionEnviados = true;
				direccionNegocioCuentaDTO.setProvincia(clienteComDTO.getCodProvincia());
				direccionNegocioCuentaDTO.setRegion(clienteComDTO.getCodRegion());
				direccionNegocioCuentaDTO.setCiudad(clienteComDTO.getCodCiudad());
				direccionNegocioCuentaDTO.setComuna(clienteComDTO.getCodComuna());
				direccionNegocioCuentaDTO.setCalle(clienteComDTO.getNomCalle());
				direccionNegocioCuentaDTO.setNumero(clienteComDTO.getNumCalle());
				direccionNegocioCuentaDTO.setZip(clienteComDTO.getZip());
				direccionNegocioCuentaDTO.setDescripcionDireccion1(clienteComDTO.getDesDirec1());
				direccionNegocioCuentaDTO.setDescripcionDireccion2(clienteComDTO.getDesDirec2());
				direccionNegocioCuentaDTO.setTipoCalle(clienteComDTO.getTipoCalle());
				direccionNegocioCuentaDTO.setObservacionDescripcion(clienteComDTO.getObservacionDireccion());
			}			
			
			if (direccionNegocioCuentaDTO!=null)
			{
				DireccionNegocioDTO[] direccionNegocios = new DireccionNegocioDTO[3];
				datosGeneralesDTO = new DatosGeneralesDTO();
				datosGeneralesDTO.setCodigoSecuencia(global.getValor("secuencia.direccion"));
				datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);

				for (int i=0;i<3;i++){
					direccionNegocios[i] = new DireccionNegocioDTO();
					direccionNegocios[i] = (DireccionNegocioDTO) mapper.map(direccionNegocioCuentaDTO, DireccionNegocioDTO.class);
					direccionNegocios[i].setCodigo(String.valueOf(datosGeneralesDTO.getSecuencia()));
					//if (i==0) direccionBO.setDireccion(direccionNegocios[0]);
					switch(i){
						case 0:direccionNegocios[i].setTipo(Integer.parseInt(global.getValor("tipo.cliente.facturacion").trim()));break;
						case 1:direccionNegocios[i].setTipo(Integer.parseInt(global.getValor("tipo.cliente.personal").trim()));	break;	
						case 2:direccionNegocios[i].setTipo(Integer.parseInt(global.getValor("tipo.cliente.correspondencia").trim()));break;	
					}
				}
				
				clienteDTO.setDirecciones(direccionNegocios);
			}
			
			
			// Setea responsables del cliente
			RepresentanteLegalDTO[] arrayRepresentantes = null;
			
			if (clienteComDTO.getRepresentanteLegalComDTO()!=null){
				// Esto se haría para persona jurídica y natural
				arrayRepresentantes = new RepresentanteLegalDTO[clienteComDTO.getRepresentanteLegalComDTO().length];
				for(int i=0;i<clienteComDTO.getRepresentanteLegalComDTO().length;i++){
					if (clienteComDTO.getRepresentanteLegalComDTO()[i]!=null){
						arrayRepresentantes[i] = new RepresentanteLegalDTO();
						arrayRepresentantes[i] = (RepresentanteLegalDTO) mapper.map(clienteComDTO.getRepresentanteLegalComDTO()[i], RepresentanteLegalDTO.class);
					}	
				}
			}
			
			
			clienteDTO.setRepresentanteLegalDTO(arrayRepresentantes);
			
			//Obtiene secuencia del cliente
			datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoSecuencia(global.getValor("secuencia.cliente"));
			datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);
			clienteDTO.setCodigoCliente(String.valueOf(datosGeneralesDTO.getSecuencia()));
			
			//Paarmetros nuevos pedidos en MA
			clienteDTO.setNumeroTelefono1(clienteComDTO.getNumeroTelefono1());
			clienteDTO.setFechaNacimiento(clienteComDTO.getFechaNacimiento());
			clienteDTO.setNombreApoderado(clienteComDTO.getNombreApoderado());
			clienteDTO.setNumeroTelefono2(clienteComDTO.getNumeroTelefono2());
			if(clienteComDTO.getCodigoCalidadCliente() != null && !clienteComDTO.getCodigoCalidadCliente().trim().equals(""))
			{
				clienteDTO.setCodigoCalidadCliente(clienteComDTO.getCodigoCalidadCliente());
			}
			clienteDTO.setIndicadorSexo(clienteComDTO.getIndicadorSexo());
			
			// Parametros COL08009
			clienteDTO.setDireccionEMail(clienteComDTO.getDireccionEMail());
			clienteDTO.setIndicadorEstadoCivil(clienteComDTO.getIndicadorEstadoCivil());
			clienteDTO.setIndicadirTipPersona(clienteComDTO.getIndicadirTipPersona());
			
			//Registra Cliente
			//clienteBO.insClienteSrv(clienteDTO);
			clienteComDTO.setCodigoCliente(clienteDTO.getCodigoCliente());
			
		} 
		catch (AltaClienteException e) {
			logger.debug("crearCliente:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} 
		catch (CustomerDomainException e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			AltaClienteException a = new AltaClienteException();
			a.setMessage(e.getMessage());
			a.setCodigo(e.getCodigo());
			a.setCodigoEvento(e.getCodigoEvento());
			a.setDescripcionEvento(e.getDescripcionEvento());
			throw a;
		}
		catch (ProductDomainException e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			AltaClienteException a = new AltaClienteException();
			a.setMessage(e.getMessage());
			a.setCodigo(e.getCodigo());
			a.setCodigoEvento(e.getCodigoEvento());
			a.setDescripcionEvento(e.getDescripcionEvento());
			throw a;
		}
		logger.debug("Fin:crearCliente()");
		return clienteComDTO;
	}// fin crearCliente	
	
	/**
	 * Modifica valor da columna categoria solo y cuando el cliente ya exista, además consulta si 
	 * el cliente es vendedor.
	 * @author Héctor Hermosilla
	 * @param clienteBO, clienteDTO
	 * @return 
	 * @throws CustomerDomainException
	 */
	
	/*private ClienteDTO ajustarValoresCliente(Cliente clienteBO, ClienteDTO clienteDTO) throws CustomerDomainException{
		logger.debug("Inicio:ajustarValoresCliente()");
		ClienteDTO resultado =clienteBO.getClienteVendedor(clienteDTO); 
		if (resultado!=null){
			resultado.setCodigoModificacion(global.getValor("codigo.modificacion.cliente"));
		}
		logger.debug("Fin:ajustarValoresCliente()");
		return resultado;
		
	}*/
	
	/**
	 * Crea Cuenta
	 * @author Héctor Hermosilla
	 * @param cuentaComDTO
	 * @return 
	 * @throws AltaClienteException
	 */
	
	public void crearCuenta(CuentaComDTO cuentaComDTO) 
		throws AltaClienteException 
	{
		try{
			logger.debug("Inicio:crearCuenta()");
			Cuenta cuentaBO = new Cuenta();
			MapperIF mapper = new DozerBeanMapper();
			CuentaDTO cuentaDTO = (CuentaDTO) mapper.map(cuentaComDTO, CuentaDTO.class);
	        //Obtiene secuencia de la cuenta
			DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoSecuencia(global.getValor("secuencia.cuenta"));
			DatosGenerales datosGeneralesBO = new DatosGenerales();
			datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);
			cuentaDTO.setCodigoCuenta(String.valueOf(datosGeneralesDTO.getSecuencia()));
			cuentaComDTO.setCodigoCuenta(String.valueOf(datosGeneralesDTO.getSecuencia())); 
			cuentaBO.insCuenta(cuentaDTO);
			crearSubCuenta(cuentaBO,cuentaDTO);
		} catch (CustomerDomainException e) {
			logger.debug("getAtributosCicloFacturable:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:crearCuenta()");
		
	}
	
	
	/**
	 * Crea Sub Cuenta
	 * @author Héctor Hermosilla
	 * @param cuentaComDTO
	 * @return 
	 * @throws AltaClienteException
	 */
	
	private void crearSubCuenta(Cuenta cuentaBO, CuentaDTO cuentaDTO) 
		throws AltaClienteException 
	{
		try{
			logger.debug("Inicio:crearSubCuenta()");
			cuentaDTO.setCodigoSubCuenta(cuentaDTO.getCodigoCuenta() + ".1");
			cuentaBO.insSubCuenta(cuentaDTO);
		} catch (CustomerDomainException e) {
			logger.debug("getAtributosCicloFacturable:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:crearSubCuenta()");
	}
	
	/**
	 * Consulta cuenta
	 * @author Héctor Hermosilla
	 * @param cuentaComDTO
	 * @return cuentaComDTO
	 * @throws AltaClienteException
	 */
	public CuentaComDTO getCuenta(CuentaComDTO cuentaComDTO) 
		throws AltaClienteException 
	{
		CuentaComDTO cuentaComDTO2 = null;
		try{
			if (cuentaComDTO.getCodigoCuenta()!=null) 
			{
				Cuenta cuentaBO = new Cuenta();
				logger.debug("Inicio:getCuenta()");
				MapperIF mapper = new DozerBeanMapper();
				CuentaDTO cuentaDTO = (CuentaDTO) mapper.map(cuentaComDTO, CuentaDTO.class);
				cuentaDTO= cuentaBO.getCuentaAll(cuentaDTO);
				cuentaComDTO2 = (CuentaComDTO) mapper.map(cuentaDTO, CuentaComDTO.class);
			}
		} catch (CustomerDomainException e) {
			logger.debug("getCuenta:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getCuenta()");
		return cuentaComDTO2;
	}//fin getCuenta


	/**
	 * Verifica si  cuenta
	 * @author MTI
	 * @param cuentaComDTO
	 * @return cuentaComDTO
	 * @throws AltaClienteException
	 */
	public CuentaComDTO existeSubCuenta (CuentaComDTO cuentaComDTO) 
		throws AltaClienteException 
	{
		logger.debug("Inicio:existeSubCuenta()");
		CuentaComDTO cuentaComDTO2 = null;
		try{
			if (cuentaComDTO.getCodigoCuenta()!=null) {
				Cuenta cuentaBO = new Cuenta();
				MapperIF mapper = new DozerBeanMapper();
				CuentaDTO cuentaDTO = (CuentaDTO) mapper.map(cuentaComDTO, CuentaDTO.class);
				cuentaDTO = cuentaBO.existeSubCuenta(cuentaDTO);
				cuentaComDTO2 = (CuentaComDTO) mapper.map(cuentaDTO, CuentaComDTO.class);
			}
		} catch (CustomerDomainException e) {
			logger.debug("existeSubCuenta:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:existeSubCuenta()");
		return cuentaComDTO2;
	}//fin existeSubCuenta
	
	
	/**
	 * Consulta cuenta por numero de identificación
	 * @author Héctor Hermosilla
	 * @param cuentaComDTO
	 * @return cuentaComDTO
	 * @throws AltaClienteException
	 */
	public CuentaComDTO getCuentaNumIdent(CuentaComDTO cuentaComDTO) 
		throws AltaClienteException 
	{
		CuentaComDTO cuentaComDTO2 = new CuentaComDTO();
		try{
			Cuenta cuentaBO = new Cuenta();
			logger.debug("Inicio:getCuentaNumIdent()");
			MapperIF mapper = new DozerBeanMapper();
			CuentaDTO cuentaDTO = (CuentaDTO) mapper.map(cuentaComDTO, CuentaDTO.class);
			cuentaDTO= cuentaBO.getCuentaNumIdent(cuentaDTO);
			if (cuentaDTO!=null)
			{
				cuentaComDTO2 = (CuentaComDTO) mapper.map(cuentaDTO, CuentaComDTO.class);				
			}
		} catch (CustomerDomainException e) {
			logger.debug("getCuentaNumIdent:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getCuentaNumIdent()");
		return cuentaComDTO2;
	}//fin getCuentaNumIdent
	
	/**
	 * Consulta atributo del ciclo de facturación
	 * @author Héctor Hermosilla
	 * @param registroFacturacionComDTO
	 * @return registroFacturacionComDTO
	 * @throws AltaClienteException
	 */
	public RegistroFacturacionComDTO getAtributosCicloFacturable(RegistroFacturacionComDTO registroFacturacionComDTO) 
		throws AltaClienteException 
	{
		logger.debug("Inicio:getAtributosCicloFacturable()");
		try{
			RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();
			MapperIF mapper = new DozerBeanMapper();
			RegistroFacturacionDTO registroFacturacionDTO = (RegistroFacturacionDTO) mapper.map(registroFacturacionComDTO, RegistroFacturacionDTO.class);
			registroFacturacionDTO = registroFacturacionBO.esCicloFredom(registroFacturacionDTO);
			//Restringe el tipo plan a solo individual si el ciclo corresponde a 15, 17 o 22
			if (registroFacturacionComDTO.getCodigoCicloFacturacion()==15 || registroFacturacionComDTO.getCodigoCicloFacturacion()== 17
				|| registroFacturacionComDTO.getCodigoCicloFacturacion()==25){
				registroFacturacionComDTO.setRestriccionTipoPlan(global.getValor("restriccion.tipo.plan"));
			}
			registroFacturacionDTO = registroFacturacionBO.esCicloFredom(registroFacturacionDTO);
			registroFacturacionComDTO.setEsCicloFacturacion(registroFacturacionDTO.isCicloFreedom());
		} catch (CustomerDomainException e) {
			logger.debug("getAtributosCicloFacturable:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getAtributosCicloFacturable()");
		return registroFacturacionComDTO;
	}//fin getAtributosCicloFacturable
	
	
	/**
	 * Ejecuta caso de uso categorización cuenta
	 * @author Héctor Hermosilla
	 * @param cuentaComDTO
	 * @return cuentaComDTO
	 * @throws AltaClienteException
	 */
	private CuentaComDTO categorizacionCuenta(CuentaComDTO cuentaComDTO,CuentaComDTO cuentaComDTO2) 
		throws AltaClienteException 
	{
		CuentaComDTO cuentaComDTO3 = null;
		Cuenta cuentaBO = new Cuenta();		
		ParametrosGeneralesDTO parametrosGeneralesDTO =null;
		ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
		try{
			logger.debug("Inicio:categorizacionCuenta()");
			if (cuentaComDTO2 != null){
				if(cuentaComDTO2.getCodigoCategoria() ==null || cuentaComDTO2.getCodigoCategoria().equals("0")){	
					MapperIF mapper = new DozerBeanMapper();
					CuentaDTO cuentaDTO = (CuentaDTO) mapper.map(cuentaComDTO, CuentaDTO.class);
					//Obtiene la categoria de la cuenta
					cuentaDTO.setTipoModulo(global.getValor("tipo.modulo"));
					cuentaDTO= cuentaBO.getCategoriaCuenta(cuentaDTO);
					mapper = new DozerBeanMapper();
					cuentaComDTO3 = (CuentaComDTO) mapper.map(cuentaDTO, CuentaComDTO.class);
				}
				
				if (cuentaComDTO3!=null){
					if(cuentaComDTO3.getCodigoCategoria() !=null && !cuentaComDTO3.getCodigoCategoria().equals("0")){
						MapperIF mapper = new DozerBeanMapper();
						CuentaDTO cuentaDTO1 = (CuentaDTO) mapper.map(cuentaComDTO3, CuentaDTO.class);
						//Actualiza datos de la cuenta.
						cuentaBO.actualizaCuenta(cuentaDTO1);
						//Actualiza categorias de los clientes
						ClienteDTO clienteDTO =new ClienteDTO();
						clienteDTO.setCodigoCategoria(cuentaComDTO3.getCodigoCategoria());
						clienteDTO.setCodigoCuenta(cuentaComDTO3.getCodigoCuenta());
						clienteBO.actualizaCategoriasClientes(clienteDTO);
						//Actualiza codigo uso de los clientes asociados a la cuenta.
						
						if (cuentaComDTO3.getIndicadorMultUso().equals(global.getValor("indicador.multiuso"))){
							parametrosGeneralesDTO = new ParametrosGeneralesDTO();		
							parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.uso.venta"));
							parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
							parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
							parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
							clienteDTO = new ClienteDTO();
							clienteDTO.setCodigoUso(parametrosGeneralesDTO.getValorparametro());
							clienteDTO.setCodigoCuenta(cuentaComDTO3.getCodigoCuenta());
							clienteDTO.setCodigoCategoria(cuentaComDTO3.getCodigoCategoria());
							clienteBO.actualizaCodigoUsoClientes(clienteDTO);
						}
						
						parametrosGeneralesDTO = new ParametrosGeneralesDTO();		
						parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.indicador.subcatimp"));
						parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
						parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
						parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
						//Actualiza subcategoria impositiva del cliente.
						if (parametrosGeneralesDTO.getValorparametro().equals("TRUE")){
							clienteDTO = new ClienteDTO();
							clienteDTO.setCodigoCliente(cuentaComDTO3.getCodigoCuenta());
							clienteDTO.setCodigoSubCategoria(cuentaComDTO3.getCodigoSubCategoria());
							clienteBO.actualizaSubCategoriaImpositiva(clienteDTO);
						}
						//Elimina cliente potencial
						if (cuentaComDTO3.getClientePotencial().equals(global.getValor("cliente.potencial"))){
							cuentaBO.eliminaCuentasPotenciales(cuentaDTO1);
						}
					}
				}
			}
		} catch (CustomerDomainException e) {
			logger.debug("categorizacionCuenta:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:categorizacionCuenta()");
		return cuentaComDTO3;
	}//fin categorizacionCuenta

	/**
	 * Obtiene listado de estados civiles disponibles en SCL
	 * 
	 * @param
	 * @return array DatosGeneralesComDTO
	 * @throws CustomerDomainException
	 */

	public DatosGeneralesComDTO[] getListEstadosCiviles()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getListEstadosCiviles()");
		DatosGeneralesComDTO[] arrayDatosGeneralesComDTO = null;
		try {
			DatosGenerales datosGeneralesBO = new DatosGenerales();
			DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			datosGeneralesDTO.setTabla(global.getValor("nombre.tabla.clientes"));
			datosGeneralesDTO.setColumna(global.getValor("nombre.columna.estadocivil.cliente"));
			DatosGeneralesDTO[] arrayDatosGeneralesDTO = datosGeneralesBO.getListCodigos(datosGeneralesDTO);

			if (arrayDatosGeneralesDTO != null) {
				arrayDatosGeneralesComDTO = new DatosGeneralesComDTO[arrayDatosGeneralesDTO.length];
				for (int i = 0; i < arrayDatosGeneralesDTO.length; i++) {
					DatosGeneralesComDTO datosGeneralesComDTO = new DatosGeneralesComDTO();
					MapperIF mapper = new DozerBeanMapper();
					datosGeneralesComDTO = (DatosGeneralesComDTO) mapper.map(arrayDatosGeneralesDTO[i],DatosGeneralesComDTO.class);
					arrayDatosGeneralesComDTO[i] = datosGeneralesComDTO;
				}
			}
			logger.debug("Fin:getListEstadosCiviles()");
		} catch (CustomerDomainException e) {
			logger.debug("getListEstadosCiviles():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		return arrayDatosGeneralesComDTO;
	}// fin getListEstadosCiviles

	
	/**
	 * Obtiene listado de subcategorias disponibles en SCL
	 * 
	 * @param
	 * @return array DatosGeneralesComDTO
	 * @throws CustomerDomainException
	 */

	public DatosGeneralesComDTO[] getListSubcategorias()
		throws AltaClienteException 
	{
		logger.debug("Inicio:getListSubcategorias()");
		DatosGeneralesComDTO[] arrayDatosGeneralesComDTO = null;
		try {
			DatosGenerales datosGeneralesBO = new DatosGenerales();
			DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoModulo(global.getValor("codigo.modulo.GA"));
			datosGeneralesDTO.setTabla(global.getValor("nombre.tabla.clientes"));
			datosGeneralesDTO.setColumna(global.getValor("nombre.columna.subcategoria.cliente"));
			DatosGeneralesDTO[] arrayDatosGeneralesDTO = datosGeneralesBO.getListCodigos(datosGeneralesDTO);

			if (arrayDatosGeneralesDTO != null) {
				arrayDatosGeneralesComDTO = new DatosGeneralesComDTO[arrayDatosGeneralesDTO.length];
				for (int i = 0; i < arrayDatosGeneralesDTO.length; i++) {
					DatosGeneralesComDTO datosGeneralesComDTO = new DatosGeneralesComDTO();
					MapperIF mapper = new DozerBeanMapper();
					datosGeneralesComDTO = (DatosGeneralesComDTO) mapper.map(arrayDatosGeneralesDTO[i],DatosGeneralesComDTO.class);
					arrayDatosGeneralesComDTO[i] = datosGeneralesComDTO;
				}
			}
			logger.debug("Fin:getListSubcategorias()");
		} catch (CustomerDomainException e) {
			logger.debug("getListSubcategorias():end");
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		return arrayDatosGeneralesComDTO;
	}// fin getListSubcategorias
	

	// Ini. Inc. 71895 10-11-2008
	/**
	 * Ejecuta validacion de Numero de Identificacion
	 * @author Rodrigo Araneda
	 * @param clienteComDTO
	 * @return boolean
	 * @throws AltaClienteException
	 */
	public boolean validarNumeroIdentificacion(ClienteComDTO clienteComDTO) 
		throws AltaClienteException 
	{		
		boolean retorno = false;
		try{
			logger.debug("Inicio:validarNumeroIdentificacion()");
			if (clienteComDTO.getNumeroIdentificacion() != null){
					MapperIF mapper = new DozerBeanMapper();
					ClienteDTO clienteDTO = (ClienteDTO) mapper.map(clienteComDTO, ClienteDTO.class);
					retorno = clienteBO.validarNumeroIdentificacion(clienteDTO);
					//Obtiene la categoria de la cuenta
			}
			else {
				retorno = false;
			}
		} catch (CustomerDomainException e) {
			logger.debug("validarNumeroIdentificacion:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:validarNumeroIdentificacion()");
		return retorno;
	}//fin validarNumeroIdentificacion
	// Fin Inc. 71895 10-11-2008

	// Ini. Inc. 72637 17-11-2008
	/**
	 * Ejecuta obtnecion de ciclo de facturacion por defecto
	 * @author Rodrigo Araneda
	 * @param 
	 * @return String
	 * @throws AltaClienteException
	 */
	public String obtenerCicloDefault() 
		throws AltaClienteException 
	{		
		String retorno = "";
		try{
			logger.debug("Inicio:obtenerCicloDefault()");
			retorno = clienteBO.obtenerCicloDefault();
					//Obtiene la categoria de la cuenta
		} catch (CustomerDomainException e) {
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:validarNumeroIdentificacion()");
		return retorno;
	}//fin obtenerCicloDefault
	// Fin Inc. 72637 17-11-2008
	
	/******************************************/
	/* Nuevos metodos Guatemala - EL Salvador */
	/******************************************/	
	public void crearClienteFacturaImprimible(ClienteAltaDTO entrada) 
		throws AltaClienteException 
	{
		try {
			logger.debug("Inicio:crearClienteFacturaImprimible()");
			clienteBO.crearClienteFacturaImprimible(entrada);			
		} catch (CustomerDomainException e) {
			logger.debug("crearClienteFacturaImprimible:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:crearClienteFacturaImprimible()");		
	}
	
	public void insMontoPreautorizado(ClienteAltaDTO entrada) 
		throws AltaClienteException 
	{
		try {
			logger.debug("Inicio:insMontoPreautorizado()");
			clienteBO.insMontoPreautorizado(entrada);			
		} catch (CustomerDomainException e) {
			logger.debug("insMontoPreautorizado:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:insMontoPreautorizado()");		
	}
	
	public OperadoraDTO[] getOperadoras() 
		throws AltaClienteException 
	{
		OperadoraDTO[] resultado;
		try {
			logger.debug("Inicio:getOperadoras()");
			resultado = clienteBO.getOperadoras();						
		} catch (CustomerDomainException e) {
			logger.debug("getOperadoras:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getOperadoras()");
		return resultado;
	}
	
	public ProfesionDTO[] getProfesiones() 
		throws AltaClienteException 
	{
		ProfesionDTO[] resultado;
		try {
			logger.debug("Inicio:getProfesiones()");
			resultado = clienteBO.getProfesiones();
		} catch (CustomerDomainException e) {
			logger.debug("getProfesiones:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getProfesiones()");
		return resultado;
	}
	
	public CargoLaboralDTO[] getCargosLaborales() 
		throws AltaClienteException 
	{
		CargoLaboralDTO[] resultado;
		try {
			logger.debug("Inicio:getCargos()");
			resultado = clienteBO.getCargosLaborales();		
		} catch (CustomerDomainException e) {
			logger.debug("getCargos:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getCargos()");
		return resultado;
	}
	
	public DatosGeneralesDTO[] getListCodigo(DatosGeneralesDTO entrada)  
		throws AltaClienteException 
	{
		DatosGeneralesDTO[] resultado;
		try {
			logger.debug("Inicio:getCargos()");
			resultado = datosGeneralesBO.getListCodigos(entrada);		
		} catch (CustomerDomainException e) {
			logger.debug("getCargos:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getCargos()");
		return resultado;
	}
	
	public NumeroIdentificacionDTO validarIdentificador(NumeroIdentificacionDTO entrada)  
		throws AltaClienteException 
	{
		NumeroIdentificacionDTO resultado;
		try {
			logger.debug("Inicio:validarIdentificador()");
			resultado = datosGeneralesBO.validarIdentificador(entrada);		
		} catch (CustomerDomainException e) {
			logger.debug("getCargos:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:validarIdentificador()");
		return resultado;
	}
	
	public TarjetaDTO validarTarjeta(TarjetaDTO entrada) throws AltaClienteException {
		logger.info("validarTarjeta, inicio");
		TarjetaDTO r = null;
		try {
			r = datosGeneralesBO.validarTarjeta(entrada);
		}
		catch (CustomerDomainException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			AltaClienteException ex = new AltaClienteException();
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			ex.setCodigo(e.getCodigo());
			throw ex;
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new AltaClienteException(e);
		}
		logger.info("validarTarjeta, fin");
		return r;
	}
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada)
		throws AltaClienteException
	{
		ParametrosGeneralesDTO resultado;
		try {
			logger.debug("Inicio:getParametroGeneral()");
			resultado = parametrosGeneralesBO.getParametroGeneral(entrada);			
		} catch (ProductDomainException e) {
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getParametroGeneral()");
		return resultado;			
	}
	
	public void insReferenciaCliente(ReferenciaClienteDTO entrada)
		throws AltaClienteException, RemoteException
	{
		try {
			logger.debug("Inicio:getParametroGeneral()");
			clienteBO.insReferenciaCliente(entrada);			
		} catch (CustomerDomainException e) {
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:insertaReferenciaCliente()");		
	}
	
	public CuentaDTO[] getCuentas(BusquedaCuentaDTO cuentaDTO) throws AltaClienteException, RemoteException
	{
		CuentaDTO[] resultado;
		try
		{
			logger.debug("Inicio:getCuentas()");
			resultado = cuentaBO.getCuentas(cuentaDTO);
		}
		catch (CustomerDomainException e)
		{
			logger.debug("getCuentas:Fin");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getCuentas()");
		return resultado;
	}
	
	public boolean validarTelefonoReferencia(String telefono, String tipo) throws AltaClienteException, RemoteException
	{
		boolean resultado;
		try
		{
			logger.debug("Inicio");
			resultado = clienteBO.validarTelefonoReferencia(telefono, tipo);
		}
		catch (CustomerDomainException e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("CustomerDomainException: " + log);
			throw new AltaClienteException(e.getMessage(), e);
		}
		catch (Exception e)
		{
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("Exception: " + log);
			throw new AltaClienteException(e);
		}
		logger.debug("Fin");
		return resultado;
	}
	
	public ClasificacionDTO[] getClasificaciones() throws AltaClienteException, RemoteException
	{
		ClasificacionDTO[] resultado;
		try
		{
			logger.debug("Inicio:getClasificaciones()");
			resultado = clienteBO.getClasificaciones();
		}
		catch (CustomerDomainException e)
		{
			logger.debug("getClasificaciones:Fin");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		}
		catch (Exception e)
		{
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:getClasificaciones()");
		return resultado;		
	}
	
	public ValorClasificacionDTO[] getCalificaciones() throws AltaClienteException 
	{
			ValorClasificacionDTO[] resultado;
		try {
			logger.debug("Inicio:getCalificaciones()");
			resultado = clienteBO.getCalificaciones();		
		} catch (CustomerDomainException e) {
			logger.debug("getCalificaciones:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getCalificaciones()");
		return resultado;
	}

	public ValorClasificacionDTO[] getCrediticia() throws AltaClienteException 
	{
		ValorClasificacionDTO[] resultado;
		try {
			logger.debug("Inicio:getCrediticia()");
			resultado = clienteBO.getCrediticia();		
		} catch (CustomerDomainException e) {
			logger.debug("getCrediticia:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getCrediticia()");
		return resultado;
	}

	public ValorClasificacionDTO[] getColores() throws AltaClienteException 
	{
		ValorClasificacionDTO[] resultado;
		try {
			logger.debug("Inicio:getColores()");
			resultado = clienteBO.getColores();		
		} catch (CustomerDomainException e) {
			logger.debug("getColores:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getColores()");
		return resultado;
	}
	
	public ValorClasificacionDTO[] getSegmentos(String codTipoCliente) throws AltaClienteException 
	{
			ValorClasificacionDTO[] resultado;
		try {
			logger.debug("Inicio:getSegmentos()");
			resultado = clienteBO.getSegmentos(codTipoCliente);		
		} catch (CustomerDomainException e) {
			logger.debug("getSegmentos:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getSegmentos()");
		return resultado;
	}
	
	public ValorClasificacionDTO[] getCategorias() throws AltaClienteException 
	{
			ValorClasificacionDTO[] resultado;
		try {
			logger.debug("Inicio:getCategorias()");
			resultado = clienteBO.getCategorias();		
		} catch (CustomerDomainException e) {
			logger.debug("getCategorias:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getCategorias()");
		return resultado;
	}
	
	public CategoriaCambioDTO[] getCategoriasCambio() throws AltaClienteException 
	{
		CategoriaCambioDTO[] resultado;
		try {
			logger.debug("Inicio:getCategoriasCambio()");
			resultado = clienteBO.getCategoriasCambio();		
		} catch (CustomerDomainException e) {
			logger.debug("getCategoriasCambio:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getCategoriasCambio()");
		return resultado;
	}

	public void insCategoriaCambioCliente(CategoriaCambioClienteDTO categCambioCliente) throws AltaClienteException, RemoteException
	{
		try {
			logger.debug("Inicio:insCategoriaCambioCliente()");
			clienteBO.insCategoriaCambioCliente(categCambioCliente);			
		} catch (CustomerDomainException e) {
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("Fin:insCategoriaCambioCliente()");		
	}
	
	public FacturaDTO getDatosCicloFacturacion() throws CustomerDomainException
	{
		Factura facturaBO = new Factura();
		FacturaDTO facturaDTO = facturaBO.getDatosCicloFacturacion();
		return facturaDTO;
	}
	
	/**
	 * @author mwn40031
	 * @param numIdent
	 * @param codTipIdent
	 * @return
	 * @throws CustomerDomainException
	 */
	public Boolean validaClienteLN(String numIdent, String codTipIdent) throws CustomerDomainException {
		logger.info("Inicio");
		Boolean r = clienteBO.validaClienteLN(numIdent, codTipIdent);
		logger.info("Fin");
		return r;
	}
	
	//Inicio P-CSR-11002 JLGN 28/04/2011
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO entrada) throws AltaClienteException {
		DatosGeneralesDTO resultado;
	try {
		logger.debug("Inicio:getValorParametro()");
		resultado = datosGeneralesBO.getValorParametro(entrada);		
	} catch (CustomerDomainException e) {
		logger.debug("getValorParametro:end");
		logger.debug("AltaClienteException");
		throw new AltaClienteException(e.getMessage(), e);
	} catch (Exception e) {
		logger.debug("AltaClienteException");
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("log error[" + log + "]");
		throw new AltaClienteException(e);
	}		
	logger.debug("Fin:getValorParametro()");
	return resultado;
	}
	
	public FormularioDireccionDTO getDireccionPrepago(String codDireccion) throws AltaClienteException {
		FormularioDireccionDTO resultado;
	try {
		logger.debug("Inicio:getDireccionPrepago()");
		resultado = direccionBO.getDireccionPrepago(codDireccion);		
	} catch (CustomerDomainException e) {
		logger.debug("getDireccionPrepago:end");
		logger.debug("AltaClienteException");
		throw new AltaClienteException(e.getMessage(), e);
	} catch (Exception e) {
		logger.debug("AltaClienteException");
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("log error[" + log + "]");
		throw new AltaClienteException(e);
	}		
	logger.debug("Fin:getDireccionPrepago()");
	return resultado;
	}
	//Fin Inicio P-CSR-11002 JLGN 28/04/2011

	//Inicio P-CSR-11002 JLGN 29-04-2011
	public String consultaURLBuro(String numIdent, String tipIdent, String tipoEstudio) throws AltaClienteException, RemoteException{
		String iniURL = "";
		String desTipIdent = "";
		String desNumIdent = "";
		String destipoEstudio = "";
		String secuencia = "";
		String ruta = "";
	try {
		logger.debug("Inicio:consultaURLBuro()");
		
		DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();
		datosGrales.setCodigoSecuencia(global.getValor("secuencia.buro"));
		//config.getString("secuencia.buro")		
		datosGrales = datosGeneralesBO.getSecuencia(datosGrales);
		
		//Inicio Inc.179734 JLGN 01-01-2012
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();		
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.id.buro"));
		parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);	
		//Fin Inc.179734 JLGN 01-01-2012
		
		iniURL = "https://www.infocredito.co.cr/Integratec/Clientes/Telefonica/?";
		//iniURL = "http://www.infocredito.co.cr/Integratec/Clientes/Telefonica/?";
		desTipIdent = "TI="+tipIdent;
		desNumIdent = "&I="+numIdent;
		//Inicio Inc.179734 JLGN 01-01-2012
		//destipoEstudio = "&TE="+tipoEstudio+"&ID=@INTETELEFONICA&R=N";
		destipoEstudio = "&TE="+tipoEstudio+"&ID="+parametrosGeneralesDTO.getValorparametro()+"&R=N";
		//destipoEstudio = "&TE="+tipoEstudio+"&ID=@INTETELEFONICA";
		//Fin Inc.179734 JLGN 01-01-2012
		secuencia = "&KEY="+datosGrales.getSecuencia();
		ruta = iniURL+desTipIdent+desNumIdent+destipoEstudio+secuencia;
		//ruta = iniURL+desTipIdent+desNumIdent+destipoEstudio; 
		
		logger.debug("Ruta que se ocupara para invocar a Buro: ["+ruta+"]");
	
	} catch (CustomerDomainException e) {
		logger.debug("consultaURLBuro:end");
		logger.debug("AltaClienteException");
		throw new AltaClienteException(e.getMessage(), e);
	} catch (Exception e) {
		logger.debug("AltaClienteException");
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("log error[" + log + "]");
		throw new AltaClienteException(e);
	}		
	logger.debug("Fin:consultaURLBuro()");
	return ruta;
	}	

	public DatosClienteBuroDTO consultaBuro(String url, String tipIdent) throws AltaClienteException, Exception {
		DatosClienteBuroDTO resultado;
	try {
		logger.debug("Inicio:consultaBuro()");
		resultado = clienteBO.consultaBuro(url, tipIdent);	
	} catch (Exception e) {
		logger.debug("Exception");
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("log error[" + log + "]");
		throw e;
	}		
	logger.debug("Fin:consultaBuro()");
	return resultado;
	}
	//Fin P-CSR-11002 JLGN 29-04-2011
	//InicioP-CSR-11002 JLGN 06-05-2011
	public void insertaClienteBuro(DatosClienteBuroDTO clienteBuroDTO, String usuario) throws AltaClienteException, Exception {
	try {
		logger.debug("Inicio:insertaClienteBuro()");
		clienteBO.insertaClienteBuro(clienteBuroDTO, usuario);	
	} catch (Exception e) {
		logger.debug("Exception");
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("log error[" + log + "]");
		throw e;
	}		
	logger.debug("Fin:insertaClienteBuro()");
	}
	//Fin P-CSR-11002 JLGN 06-05-2011
	
	//	Inicio P-CSR-11002 JLGN 05-06-2011
	public boolean validaPassClasificacion(String passCalificacion) throws CustomerDomainException{
		logger.info("Inicio validaPassClasificacion");
		boolean flagCalificacion = true;
		flagCalificacion = clienteBO.validaPassClasificacion(passCalificacion);	
		logger.info("Fin validaPassClasificacion");
		return flagCalificacion;
	}	
	//Fin P-CSR-11002 JLGN 05-06-2011
	
	//Inicio P-CSR-11002 JLGN 01-07-2011
	public long obtineLimConsuCliente(String numIdent, String tipIdent) throws VentasException, CustomerDomainException{
		logger.info("Inicio obtineLimConsuCliente");
		long resultado = 0;
		resultado = clienteBO.obtineLimConsuCliente(numIdent,tipIdent);	
		logger.info("Fin obtineLimConsuCliente");
		return resultado;
	}	
	//Fin P-CSR-11002 JLGN 01-07-2011

	//Inicio P-CSR-11002 JLGN 05-08-2011	
	public MensajePromocionalDTO[] getMensajePromocional() throws AltaClienteException 
	{
		MensajePromocionalDTO[] resultado;
		try {
			logger.debug("Inicio:getMensajePromocional()");
			resultado = clienteBO.getMensajePromocional();		
		} catch (CustomerDomainException e) {
			logger.debug("getMensajePromocional:end");
			logger.debug("AltaClienteException");
			throw new AltaClienteException(e.getMessage(), e);
		} catch (Exception e) {
			logger.debug("AltaClienteException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new AltaClienteException(e);
		}		
		logger.debug("Fin:getMensajePromocional()");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 05-08-2011	
	
	//Inicio Inc.179734 JLGN 04-01-2012
	public boolean validaClienteDDA(String codCliente) throws VentasException, CustomerDomainException{
		logger.debug("validaClienteDDA():start");
		boolean resultado = clienteBO.validaClienteDDA(codCliente);
		logger.debug("validaClienteDDA():end");
		return resultado;		
	}
	//Fin Inc.179734 JLGN 04-01-2012
	
	//Inicio Inc.179734 JLGN 05-01-2012
	public boolean validaLineasClienteDDA(String tipIdent, String numIdent) throws VentasException, CustomerDomainException{
		logger.debug("validaLineasClienteDDA():start");
		boolean resultado = clienteBO.validaLineasClienteDDA(tipIdent, numIdent);
		logger.debug("validaLineasClienteDDA():end");
		return resultado;		
	}
	//Fin Inc.179734 JLGN 05-01-2012
	
//	Inicio MA-180654 HOM
	public AbonadoDTO[] getAbonadosActvos(String tipIdent, String numIdent) throws VentasException, CustomerDomainException{
		logger.debug("getAbonadosActvos():start");
		AbonadoDTO[] resultado = clienteBO.getAbonadosActvos(tipIdent, numIdent);
		logger.debug("getAbonadosActvos():end");
		return resultado;	
	}
	
	public DatosAnexoTerminalesDTO getDatosAnexoTerminales(Long numVenta) throws VentasException, CustomerDomainException{
		logger.debug("getDatosAnexoTerminales():start");
		DatosAnexoTerminalesDTO resultado = clienteBO.getDatosAnexoTerminales(numVenta);
		logger.debug("getDatosAnexoTerminales():end");
		return resultado;	
	}
//	Fin MA-180654 HOM	

}

