package com.tmmas.scl.gestionlc.web.helper;

import java.rmi.RemoteException;
import java.util.Hashtable;
import java.util.Properties;

import javax.ejb.CreateException;
import javax.ejb.RemoveException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioEquipoNuevoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacade;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacadeHome;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaCierreRestitucionInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaCierreRestitucionOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;
import com.tmmas.scl.gestionlc.ejb.session.AbonoLimiteConsumo;
import com.tmmas.scl.gestionlc.ejb.session.AbonoLimiteConsumoHome;
import com.tmmas.scl.gestionlc.ejb.session.GestLimCon;
import com.tmmas.scl.gestionlc.ejb.session.GestLimConHome;
import com.tmmas.scl.gestionlc.ejb.session.ModificacionLimiteConsumo;
import com.tmmas.scl.gestionlc.ejb.session.ModificacionLimiteConsumoHome;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipoHome;

public class GestionLimiteConsumoLocator {

    private GlobalProperties global = GlobalProperties.getInstance();
    private final LoggerHelper logger = LoggerHelper.getInstance();
    private final String nombreClase = this.getClass().getName();
    
    public GestionLimiteConsumoLocator() {

    }

    // Metodo que obtiene interface local del EJB GestLimCon
    public GestLimCon getGestLimConFacade() throws GestionLimiteConsumoException {
        
        logger.debug("getGestLimCon():inicio", nombreClase);
        
        String jndi = global.getValorExterno("jndi.GestLimCon");
        logger.debug("jndi.GestLimCon: " + jndi, nombreClase);

        String url = global.getValorExterno("url.GestLimConProvider");
        logger.debug("url.GestLimConProvider: " + url, nombreClase);

        String initialContextFactory = global.getValorExterno("initial.context.factory");
        logger.debug("initialContextFactory: " + initialContextFactory, nombreClase);

        String securityPrincipal = global.getValorExterno("security.principal");
        logger.debug("securityPrincipal: " + securityPrincipal, nombreClase);

        String securityCredentials = global.getValorExterno("security.credentials");
        logger.debug("securityCredentials: " + securityCredentials, nombreClase);
        
        logger.debug("Antes de obtener Bean Remoto", nombreClase);

        GestLimConHome gestLimConHome = null;
        try {
            gestLimConHome = (GestLimConHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, 
                    url, jndi, securityPrincipal, securityCredentials, GestLimConHome.class);
        } catch (ServiceLocatorException e1) {

            e1.printStackTrace();
            logger.error(e1, nombreClase);
            new GestionLimiteConsumoException(e1.getOriginalExcepcion());
        }

        logger.debug("Despues de obtener Bean Remoto", nombreClase);
        
        GestLimCon gestLimCon = null;

        try {
            gestLimCon = gestLimConHome.create();
        } catch (CreateException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
        }
        
        
        logger.debug("getGestLimCon():fin", nombreClase);
        return gestLimCon;
    }

    // Metodo que obtiene interface local del EJB AbonoLimiteCredito
    public RestitucionEquipo getRestitucionEquipoFacade() throws GestionLimiteConsumoException {
        
        logger.debug("getRestitucionEquipoFacade():inicio", nombreClase);
        
        String jndi = global.getValorExterno("jndi.RestitucionEquipo");
        logger.debug("jndi.GestionLimiteConsumo: " + jndi, nombreClase);

        String url = global.getValorExterno("url.RestitucionEquipoProvider");
        logger.debug("url.GestionLimiteConsumoProvider: " + url, nombreClase);

        String initialContextFactory = global.getValorExterno("initial.context.factory");
        logger.debug("initialContextFactory: " + initialContextFactory, nombreClase);

        String securityPrincipal = global.getValorExterno("security.principal");
        logger.debug("securityPrincipal: " + securityPrincipal, nombreClase);

        String securityCredentials = global.getValorExterno("security.credentials");
        logger.debug("securityCredentials: " + securityCredentials, nombreClase);
        
        
        logger.debug("Antes de obtener Bean Remoto", nombreClase);

        RestitucionEquipoHome restitucionEquipoHome = null;
        try {
            restitucionEquipoHome = (RestitucionEquipoHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, 
                    url, jndi, securityPrincipal, securityCredentials, RestitucionEquipoHome.class);
        } catch (ServiceLocatorException e1) {

            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw new GestionLimiteConsumoException(e1.getOriginalExcepcion());
        }

        logger.debug("Despues de obtener Bean Remoto", nombreClase);

        RestitucionEquipo restitucionEquipo = null;

        try {
           
            restitucionEquipo = restitucionEquipoHome.create();

        } catch (CreateException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
        }

        logger.debug("getRestitucionEquipoFacade():fin", nombreClase);
        return restitucionEquipo;
    }

    public AbonoLimiteConsumo getAbonoLimiteConsumoFacade() throws GestionLimiteConsumoException {
        
        logger.debug("getAbonoLimiteConsumoFacade():inicio", nombreClase);

        String jndi = global.getValorExterno("jndi.AbonoLimiteConsumo");
        logger.debug("jndi.AbonoLimiteConsumo: " + jndi, nombreClase);

        String url = global.getValorExterno("url.AbonoLimiteConsumoProvider");
        logger.debug("url.AbonoLimiteConsumoProvider: " + url, nombreClase);

        String initialContextFactory = global.getValorExterno("initial.context.factory");
        logger.debug("initialContextFactory: " + initialContextFactory, nombreClase);

        String securityPrincipal = global.getValorExterno("security.principal");
        logger.debug("securityPrincipal: " + securityPrincipal, nombreClase);

        String securityCredentials = global.getValorExterno("security.credentials");
        logger.debug("securityCredentials: " + securityCredentials, nombreClase);
        
        logger.debug("Antes de obtener Bean Remoto", nombreClase);

        AbonoLimiteConsumoHome abonoLimiteConsumoHome = null;
        try {
            abonoLimiteConsumoHome = (AbonoLimiteConsumoHome)ServiceLocator.getInstance().getRemoteHome(initialContextFactory, 
                    url, jndi, securityPrincipal, securityCredentials, AbonoLimiteConsumoHome.class);
        } catch (ServiceLocatorException e1) {

            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw new GestionLimiteConsumoException(e1.getOriginalExcepcion());
        } 

        logger.debug("Despues de obtener Bean Remoto", nombreClase);

        AbonoLimiteConsumo abonoLimiteConsumo = null;

        try {

            abonoLimiteConsumo = abonoLimiteConsumoHome.create();

        } catch (CreateException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
        }

        logger.debug("getAbonoLimiteConsumoFacade():fin", nombreClase);

        return abonoLimiteConsumo;
    }

    // Metodo que obtiene interface local del EJB ModificacionLimiteConsumo
    public ModificacionLimiteConsumo getModificacionLimiteConsumoFacade() throws GestionLimiteConsumoException {
        
        logger.debug("getModificacionLimiteConsumoFacade():inicio", nombreClase);

        String jndi = global.getValorExterno("jndi.ModificacionLimiteConsumo");
        logger.debug("jndi.ModificacionLimiteConsumo: " + jndi, nombreClase);

        String url = global.getValorExterno("url.ModificacionLimiteConsumoProvider");
        logger.debug("url.ModificacionLimiteConsumoProvider: " + url, nombreClase);

        String initialContextFactory = global.getValorExterno("initial.context.factory");
        logger.debug("initialContextFactory: " + initialContextFactory, nombreClase);

        String securityPrincipal = global.getValorExterno("security.principal");
        logger.debug("securityPrincipal: " + securityPrincipal, nombreClase);

        String securityCredentials = global.getValorExterno("security.credentials");
        logger.debug("securityCredentials: " + securityCredentials, nombreClase);

        logger.debug("Antes de obtener Bean Remoto", nombreClase);

        ModificacionLimiteConsumoHome modificacionLimiteConsumoHome = null;
        try {
            modificacionLimiteConsumoHome = (ModificacionLimiteConsumoHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, 
                    url, jndi, securityPrincipal, securityCredentials, ModificacionLimiteConsumoHome.class);
        } catch (ServiceLocatorException e1) {

            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw new GestionLimiteConsumoException(e1.getOriginalExcepcion());
        }

        logger.debug("Despues de obtener Bean Remoto", nombreClase);
        
        ModificacionLimiteConsumo modificacionLimiteConsumo = null;

        try {

            modificacionLimiteConsumo = modificacionLimiteConsumoHome.create();

        } catch (CreateException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
        }


        logger.debug("getModificacionLimiteConsumoFacade():fin", nombreClase);

        return modificacionLimiteConsumo;
    }

    private FrmkOOSSFacade getFrmkOOSSFacade() throws GestionLimiteConsumoException {
        
        logger.debug("getFrmkOOSSFacade():start", nombreClase);
        
        String jndi = global.getValorExterno("jndi.FrmkOOSSFacade");
        logger.debug("Buscando servicio[" + jndi + "]", nombreClase);
        
        String url = global.getValorExterno("url.FrmkOOSSProvider");
        logger.debug("Url provider[" + url + "]", nombreClase);
        
        String initialContextFactory = global.getValorExterno("ext.initial.context.factory");
        logger.debug("Initial context factory[" + initialContextFactory + "]", nombreClase);
        
        String securityPrincipal = global.getValorExterno("ext.security.principal");
        logger.debug("Security principal[" + securityPrincipal + "]", nombreClase);   
        
        String securityCredentials = global.getValorExterno("ext.security.credentials");
        logger.debug("Security credentials[" + securityCredentials + "]", nombreClase);
               
        logger.debug("Antes de obtener Bean Remoto", nombreClase);

        FrmkOOSSFacadeHome facadeHome = null;
        try {
            facadeHome = (FrmkOOSSFacadeHome)ServiceLocator.getInstance().getRemoteHome(initialContextFactory, 
                    url, jndi, securityPrincipal, securityCredentials, FrmkOOSSFacadeHome.class);
        } catch (ServiceLocatorException e1) {

            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw new GestionLimiteConsumoException(e1.getOriginalExcepcion());
        }
        
        logger.debug("Despues de obtener Bean Remoto", nombreClase);

        FrmkOOSSFacade frmkOOSSFacade = null;

        try {
            
            frmkOOSSFacade = facadeHome.create();
            
            logger.debug("Recuperada interfaz home de FrmkOOSSFacade...", nombreClase);
            
        } catch (CreateException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
        }

        logger.debug("getFrmkOOSSFacade():fin", nombreClase);

        return frmkOOSSFacade;
        
    }
    
    private FrmkCargosFacade getFrmkCargosFacade() throws GestionLimiteConsumoException {
        
        logger.debug("getFrmkCargosFacade():start", nombreClase);
        
        String jndi = global.getValorExterno("jndi.FrmkCargosFacade");
        logger.debug("Buscando servicio[" + jndi + "]", nombreClase);
        
        String url = global.getValorExterno("url.FrmkCargosProvider");
        logger.debug("Url provider[" + url + "]", nombreClase);
        
        String initialContextFactory = global.getValorExterno("ext.initial.context.factory");
        logger.debug("Initial context factory[" + initialContextFactory + "]", nombreClase);
        
        String securityPrincipal = global.getValorExterno("ext.security.principal");
        logger.debug("Security principal[" + securityPrincipal + "]", nombreClase);   
        
        String securityCredentials = global.getValorExterno("ext.security.credentials");
        logger.debug("Security credentials[" + securityCredentials + "]", nombreClase);           
        
        FrmkCargosFacadeHome frmkCargosFacadeHome = null;
        try {
            
            frmkCargosFacadeHome = (FrmkCargosFacadeHome)ServiceLocator.getInstance().getRemoteHome(initialContextFactory, 
                    url, jndi, securityPrincipal, securityCredentials, FrmkCargosFacadeHome.class);
            
            logger.debug("Recuperada interfaz home de FrmkCargosFacade...", nombreClase);
            
        } catch (ServiceLocatorException e1) {

            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw new GestionLimiteConsumoException(e1.getOriginalExcepcion());
        } 
        
    
        logger.debug("Despues de obtener Bean Remoto", nombreClase);

        FrmkCargosFacade frmkCargosFacade = null;

        try {

            frmkCargosFacade = frmkCargosFacadeHome.create();

            logger.debug("Recuperada interfaz home de FrmkOOSSFacade...", nombreClase);
            
        } catch (CreateException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
        }

        logger.debug("getFrmkCargosFacade():fin", nombreClase);

        return frmkCargosFacade;
        
    }
    
    public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws RemoteException, GestionLimiteConsumoException {

        SecuenciaDTO resultado = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        
        logger.debug("obtenerSecuencia():start", nombreClase);
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade(); 
            resultado = frmkOOSSFacade.obtenerSecuencia(parametro);    
            
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        logger.debug("obtenerSecuencia():end", nombreClase);
        
        return resultado;
    }

    public void registrarVenta(IngresoVentaDTO venta) throws RemoteException, GestionLimiteConsumoException {
        
        FrmkOOSSFacade frmkOOSSFacade = null; 
            
        try{
            
            logger.debug("inicio - registrarVenta", nombreClase);
            frmkOOSSFacade = getFrmkOOSSFacade(); 
            
            frmkOOSSFacade.registrarVenta(venta);
            logger.debug("fin - registrarVenta", nombreClase);
            

        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
    }

    public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws GestionLimiteConsumoException {

        UsuarioDTO resultado = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        logger.debug("obtenerVendedor():start", nombreClase);
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade(); 
            
            resultado = frmkOOSSFacade.obtenerVendedor(usuario);
                        
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerVendedor():end", nombreClase);
        
        return resultado;
    }

    public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO descVend) throws GestionLimiteConsumoException {

        DescuentoVendedorDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        
        logger.debug("obtenerDescuentoVendedor():start", nombreClase);
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade(); 
            
            retorno = frmkOOSSFacade.obtenerDescuentoVendedor(descVend);
            
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerDescuentoVendedor():end", nombreClase);
        
        return retorno;
        
    }

    public ParametroDTO obtenerParametroGeneral(ParametroDTO parametro) throws GestionLimiteConsumoException {
        
        logger.debug("obtenerParametroGeneral():start", nombreClase);
        
        ParametroDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
            
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade(); 
            
            retorno = frmkOOSSFacade.obtenerParametroGeneral(parametro);
            
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerParametroGeneral():end", nombreClase);
        
        return retorno;
        
    }

    public DocumentoListDTO obtenerTiposDocumento(BusquedaTiposDocumentoDTO tipoDocumento) throws GestionLimiteConsumoException {
        
        DocumentoListDTO documentoList = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        
        logger.debug("obtenerTiposDocumento():start", nombreClase);
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade(); 
            
            documentoList = frmkOOSSFacade.obtenerTiposDocumentos(tipoDocumento);
            
            
        } catch (GeneralException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
                
        } catch (RemoteException e) {
                
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerTiposDocumento():end", nombreClase);
        
        return documentoList;
        
    }

    public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO formaPago) throws GestionLimiteConsumoException {

        FormaPagoListDTO formaPagoList = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        
        logger.debug("obtenerFromasPago():start", nombreClase);
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            
            formaPagoList = frmkOOSSFacade.obtenerFormasPago(formaPago);
            
            
        } catch (GeneralException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerFromasPago():end", nombreClase);
        
        return formaPagoList;
        
    }

    public CuotasProductoDTO[] obtenerCuotasProducto() throws GestionLimiteConsumoException {
        
        CuotasProductoDTO[] cuotasProducto = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        
        logger.debug("obtenerCuotasProducto():start", nombreClase);
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            
            cuotasProducto = frmkOOSSFacade.obtenerCuotasProducto();
            
        } catch (GeneralException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerCuotasProducto():end", nombreClase);
        
        return cuotasProducto;
        
    }

    public IndicadorVtaExternaVendedorOutDTO obtieneIndicadorVtaExternaVendedor(IndicadorVtaExternaVendedorInDTO indicadorVtaExternaVendedorInDTO) throws GestionLimiteConsumoException, RemoteException {

        IndicadorVtaExternaVendedorOutDTO result= null;
        
        logger.debug("obtieneIndicadorVtaExternaVendedor():start", nombreClase);
        
        GestLimCon gestLimCon = null;
        try {
            
            gestLimCon = this.getGestLimConFacade();
            
            result = gestLimCon.obtieneIndicadorVtaExternaVendedor(indicadorVtaExternaVendedorInDTO);
            
        } catch (GestionLimiteConsumoException e1) {
            
            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw e1;
        } catch (RemoteException e1) {
            
            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw e1;
        }
        
        logger.debug("obtieneIndicadorVtaExternaVendedor():end", nombreClase);
        
        return result;
    }

    public ObtencionCargosDTO obtencionCargos(ParametrosObtencionCargosDTO parametrosCargos) throws GestionLimiteConsumoException {

        ObtencionCargosDTO resultado = null;
        FrmkCargosFacade frmkCargosFacade = null;
        
        logger.debug("CamSerFacadeBean obtencionCargos():start", nombreClase);
        try {

            logger.debug("parametrosCargos.getOperacion:"+   parametrosCargos.getOperacion(), nombreClase); // RRG

            logger.debug("CamSerFacadeBean:Tipo Pantalla::"+parametrosCargos.getTipoPantalla(), nombreClase);                  
            logger.debug("CamSerFacadeBean:Codigo Modalidad de Venta::"+parametrosCargos.getCodigoModalidadVenta(), nombreClase);      
            logger.debug("CamSerFacadeBean:Abonados cantidad::"+parametrosCargos.getAbonados(), nombreClase);              
            logger.debug("CamSerFacadeBean:Codigo Cliente Origen::"+parametrosCargos.getCodigoClienteOrigen(), nombreClase);          
            logger.debug("CamSerFacadeBean:Codigo Cliente Destino::"+parametrosCargos.getCodigoClienteDestino(), nombreClase);         
            logger.debug("CamSerFacadeBean:Codigo PlanTarifario Origen::"+parametrosCargos.getCodigoPlanTarifOrigen(), nombreClase);    
            logger.debug("CamSerFacadeBean:Codigo PlanTarifario Destino::"+parametrosCargos.getCodigoPlanTarifDestino(), nombreClase);   
            logger.debug("CamSerFacadeBean:Tipo Segmentacion Origen::"+parametrosCargos.getTipoSegOrigen(), nombreClase);       
            logger.debug("CamSerFacadeBean:Tipo Segmentacion Origen::"+parametrosCargos.getTipoSegDestino(), nombreClase);       
            logger.debug("CamSerFacadeBean:Codigo Causa Cambio de Plan::"+parametrosCargos.getCodCausaCambioPlan(), nombreClase);    
            logger.debug("CamSerFacadeBean:Codigo Actuacion::"+parametrosCargos.getCodActabo(), nombreClase);               
            logger.debug("CamSerFacadeBean:Codigo Tecnologia::"+parametrosCargos.getCodigoTecnologia(), nombreClase);              
            logger.debug("CamSerFacadeBean:Codigo Penalizacion::"+parametrosCargos.getCodPenalizacion(), nombreClase);            
            logger.debug("CamSerFacadeBean:Indicador Comodato::"+parametrosCargos.getIndComodato(), nombreClase);             
            logger.debug("CamSerFacadeBean:Codigo Categoria::"+parametrosCargos.getCodCategoria(), nombreClase);               
            logger.debug("CamSerFacadeBean:Tipo Contrato::"+parametrosCargos.getTipoContrato(), nombreClase);                  
            logger.debug("CamSerFacadeBean:Indicador Causa::"+parametrosCargos.getIndCausa(), nombreClase);                
            logger.debug("CamSerFacadeBean:Estado Devolucion de Cargador::"+parametrosCargos.getEstdDevlCargador(), nombreClase);  
            logger.debug("CamSerFacadeBean:Fecha Vigencia::"+parametrosCargos.getFechaVigenciaAbonadoCero(), nombreClase);                
            logger.debug("CamSerFacadeBean:Nombre Usuario:" + parametrosCargos.getNombreUsuario(), nombreClase); //INC-79469; COL; 11-03-2009; AVC

            frmkCargosFacade = getFrmkCargosFacade(); 
            
            resultado = frmkCargosFacade.obtenerCargos(parametrosCargos);
            
        } catch (FrmkCargosException e){
            
            logger.error(e, nombreClase);
            
            logger.error("e.getMessage: " + e.getMessage(), nombreClase); 
            logger.error("e.getCause: " + e.getCause(), nombreClase);  
            logger.error("e.getCodigo: " + e.getCodigo(), nombreClase);
            logger.error("e.getCodigoEvento: " + e.getCodigoEvento(), nombreClase);   
            logger.error("e.getDescripcionEvento: " + e.getDescripcionEvento(), nombreClase); 

            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
          
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);

            logger.error("e.getMessage: " + e.getMessage(), nombreClase); // RRG COL 07-07-2009 96723
            logger.error("e.getCause: " + e.getCause(), nombreClase);  // RRG COL 07-07-2009 96723
            logger.error("e.getCodigo: " + e.getCodigo(), nombreClase);    // RRG COL 07-07-2009 96723
            logger.error("e.getCodigoEvento: " + e.getCodigoEvento(), nombreClase);    // RRG COL 07-07-2009 96723
            logger.error("e.getDescripcionEvento: " + e.getDescripcionEvento(), nombreClase);  // RRG COL 07-07-2009 96723

            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
          
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtencionCargos():end", nombreClase);
        return resultado;

    }

    public PrecioTerminalDTO getRecPrecioEquipoActual(TerminalDTO pTerminalDTO) throws GestionLimiteConsumoException {
        
        PrecioTerminalDTO retorno = null;
        FrmkCargosFacade frmkCargosFacade = null;
        
        logger.debug("getRecPrecioEquipoActual():start", nombreClase);
        
        try {
            frmkCargosFacade = getFrmkCargosFacade();  
            retorno = frmkCargosFacade.getRecPrecioEquipoActual(pTerminalDTO);
            
        } catch (FrmkCargosException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        }catch(GeneralException e){

            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("getRecPrecioEquipoActual():end", nombreClase);
        
        return retorno;
        
    }

    public PrecioTerminalDTO getRecPrecioEquipoNuevo(PrecioEquipoNuevoDTO pTerminalDTO) throws GestionLimiteConsumoException {
        
        PrecioTerminalDTO retorno = null;
        FrmkCargosFacade frmkCargosFacade = null;
        
        logger.debug("getRecPrecioEquipoNuevo():start", nombreClase);
        
        try {
            
            frmkCargosFacade = getFrmkCargosFacade(); 
            retorno = frmkCargosFacade.getRecPrecioEquipoNuevo(pTerminalDTO);
            
            
        } catch (FrmkCargosException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        }catch(GeneralException e){

            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("getRecPrecioEquipoNuevo():end", nombreClase);
        
        return retorno;
    }

    public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planTarifarioDTO) throws GestionLimiteConsumoException, RemoteException  {

        logger.debug("getCategoriaPlanTarifario():start", nombreClase);
        
        PlanTarifarioDTO resultado = null;
        GestLimCon gestLimCon = null;
        
        try {

            gestLimCon = this.getGestLimConFacade();
            
            resultado = gestLimCon.getCategoriaPlanTarifario(planTarifarioDTO);
            
        } catch (GestionLimiteConsumoException e1) {

            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw e1;
            
        } catch (RemoteException e1) {

            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw e1;
            
        }
        
        logger.debug("getCategoriaPlanTarifario():end", nombreClase);
        
        return resultado;
    }

    public RetornoDTO insertarConceptoDescuento(DescuentoDTO descuento) throws GestionLimiteConsumoException {

        logger.debug("insertarConceptoDescuento():start", nombreClase);
        
        RetornoDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
            
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            
            retorno = frmkOOSSFacade.insertarConceptoDescuento(descuento);
                        
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("insertarConceptoDescuento():end", nombreClase);
        
        return retorno;
        
    }

    public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO param) throws GestionLimiteConsumoException {
        
        logger.debug("obtenerCodConceptoDescuento():start", nombreClase);
        
        DescuentoDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null; 
            
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            
            retorno = frmkOOSSFacade.obtenerCodConceptoDescuento(param);
            
            
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());

        } catch (RemoteException e) {
        
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerCodConceptoDescuento():end", nombreClase);
        
        return retorno;
        
    }

    public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws GestionLimiteConsumoException {
        
        logger.debug("eliminaCodConceptoDescuento():start", nombreClase);
        
        RetornoDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            
            retorno = frmkOOSSFacade.eliminaCodConceptoDescuento(numTransaccion);
            
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("eliminaCodConceptoDescuento():end", nombreClase);
        
        return retorno;
        
    }

    public void rollbackReservaSerie(Long lonNumTransacReserva) throws Exception {
        
        logger.debug("rollbackReservaSerie():start", nombreClase);
        
        RestitucionEquipo restitucionEquipo = null; 
            
        try {
            
            restitucionEquipo = this.getRestitucionEquipoFacade();
            
            restitucionEquipo.rollbackReservaSerie(lonNumTransacReserva);
            
        } catch (RemoteException e1) {

            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw e1;            
        } catch (GestionLimiteConsumoException e1) {
            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw e1;
        } catch (Exception e1) {
            e1.printStackTrace();
            logger.error(e1, nombreClase);
            throw e1;
        }
            
        logger.debug("rollbackReservaSerie():end", nombreClase);
        
    }

    public void desbloquearVendedor(com.tmmas.scl.gestionlc.common.dto.UsuarioDTO usuarioDTO) throws RemoteException, GestionLimiteConsumoException {
        
        logger.debug("desbloquearVendedor():start", nombreClase);
        RestitucionEquipo restitucionEquipo = null;
        
        try{
            
            restitucionEquipo = this.getRestitucionEquipoFacade(); 
            
            restitucionEquipo.desbloquearVendedor(usuarioDTO);
        
        }catch(RemoteException e){
            logger.error(e, nombreClase);
            e.printStackTrace();
            throw e;
            
        }catch(GestionLimiteConsumoException e){
            logger.error(e, nombreClase);
            e.printStackTrace();
            throw e;
            
        }
        
        logger.debug("desbloquearVendedor():end", nombreClase);
        
    }
    
    public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws GestionLimiteConsumoException{
        
        logger.debug("obtenerVendedor():start", nombreClase);
        
        VendedorDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            
            retorno = frmkOOSSFacade.obtenerVendedor(vendedor);
            
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerVendedor():end", nombreClase);
        
        return retorno;     
    }

    public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws GestionLimiteConsumoException{
        
        RetornoDTO retorno= null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        
        logger.debug("eliminarPresupuesto():start", nombreClase);
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            retorno = frmkOOSSFacade.eliminarPresupuesto(registro);
            
            
        } catch (GeneralException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("eliminarSolicitud():end", nombreClase);
        return retorno;
    }   
    
    public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws GestionLimiteConsumoException{
        
        logger.debug("obtenerTipoContrato():start", nombreClase);
        
        ContratoDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
            
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            retorno = frmkOOSSFacade.obtenerTipoContrato(contrato);
                        
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerTipoContrato():end", nombreClase);
        
        return retorno;     
    }
    
    public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws GestionLimiteConsumoException{
        
        logger.debug("obtenerModalidadPago():start", nombreClase);
        
        ModalidadPagoDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
                
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            retorno = frmkOOSSFacade.obtenerModalidadPago(modalidad);
                        
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerModalidadPago():end", nombreClase);
        
        return retorno;     
    }
    
    public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws GestionLimiteConsumoException{
        
        logger.debug("obtenerDetallePresupuesto():start", nombreClase);
        
        PresupuestoDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
                
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            retorno = frmkOOSSFacade.obtenerDetallePresupuesto(presup);
            
            
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerDetallePresupuesto():end", nombreClase);
        
        return retorno;     
    }
    
    public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws GestionLimiteConsumoException{
        
        logger.debug("obtenerPlanComercial():start", nombreClase);
        
        ClienteDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
                
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            retorno = frmkOOSSFacade.obtenerPlanComercial(cliente);
                        
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("obtenerVendedor():end", nombreClase);
        
        return retorno;     
    }
    
    public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO cargos) throws GestionLimiteConsumoException{
        
        RegCargosDTO retorno = null;
        FrmkCargosFacade frmkCargosFacade = null;
                
        logger.debug("construirRegistroCargos():start", nombreClase);
        
        try {
            
            frmkCargosFacade = getFrmkCargosFacade(); 
            retorno = frmkCargosFacade.construirRegistroCargos(cargos);
                        
        } catch (FrmkCargosException e){
            
            logger.error(e, nombreClase);
            
            logger.debug("e.getMessage: " + e.getMessage(), nombreClase); // RRG COL 07-07-2009 96723
            logger.debug("e.getCause: " + e.getCause(), nombreClase);  // RRG COL 07-07-2009 96723
            logger.debug("e.getCodigo: " + e.getCodigo(), nombreClase);    // RRG COL 07-07-2009 96723
            logger.debug("e.getCodigoEvento: " + e.getCodigoEvento(), nombreClase);    // RRG COL 07-07-2009 96723
            logger.debug("e.getDescripcionEvento: " + e.getDescripcionEvento(), nombreClase);  // RRG COL 07-07-2009 96723

            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());

        }catch(GeneralException e){

            logger.error(e, nombreClase);
            
            logger.debug("e.getMessage: " + e.getMessage(), nombreClase); // RRG COL 07-07-2009 96723
            logger.debug("e.getCause: " + e.getCause(), nombreClase);  // RRG COL 07-07-2009 96723
            logger.debug("e.getCodigo: " + e.getCodigo(), nombreClase);    // RRG COL 07-07-2009 96723
            logger.debug("e.getCodigoEvento: " + e.getCodigoEvento(), nombreClase);    // RRG COL 07-07-2009 96723
            logger.debug("e.getDescripcionEvento: " + e.getDescripcionEvento(), nombreClase);  // RRG COL 07-07-2009 96723

            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());

        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("construirRegistroCargos():end", nombreClase);
        
        return retorno;     
    }
    
    public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO cargos) throws GestionLimiteConsumoException{
        
        ResultadoRegCargosDTO retorno = null;
        FrmkCargosFacade frmkCargosFacade = null; 
            
        logger.debug("parametrosRegistrarCargos():start", nombreClase);
        
        try {
            
            frmkCargosFacade = getFrmkCargosFacade(); 
            retorno = getFrmkCargosFacade().parametrosRegistrarCargos(cargos);
                        
        } catch (FrmkCargosException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        }catch(GeneralException e){

            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("parametrosRegistrarCargos():end", nombreClase);
        
        return retorno;     
    }

    
    public void cierreVenta(GaVentasDTO gaVentasDTO)throws GestionLimiteConsumoException{
        
        logger.debug("cierreVenta():start", nombreClase);

        FrmkCargosFacade frmkCargosFacade = null; 
            
        try {
            
            frmkCargosFacade = getFrmkCargosFacade();  
            frmkCargosFacade.cierreVenta(gaVentasDTO);
                        
        } catch (FrmkCargosException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        }catch(GeneralException e){

            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
            
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("cierreVenta():end", nombreClase);
        
    }
    
    public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro) throws GestionLimiteConsumoException{  
        
        logger.debug("solicitarAprobacionDescuento():start", nombreClase);
        
        RespuestaSolicitudDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;                
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            retorno = frmkOOSSFacade.solicitarAprobacionDescuento(registro);
                        
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("solicitarAprobacionDescuento():end", nombreClase);
        
        return retorno;     
    }
    
    
    public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro)  throws GestionLimiteConsumoException{  
        
        RegistroSolicitudDTO retorno = null;
        FrmkOOSSFacade frmkOOSSFacade = null;
        
        logger.debug("consultarEstadoSolicitud():start", nombreClase);
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            retorno = frmkOOSSFacade.consultarEstadoSolicitud(registro);
            
            
        }catch(GeneralException e){
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("consultarEstadoSolicitud():end", nombreClase);
        
        return retorno;     
    }
    
    public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws GestionLimiteConsumoException{
        
        RetornoDTO retorno= null;
        FrmkOOSSFacade frmkOOSSFacade = null; 
            
        logger.debug("eliminarSolicitud():start", nombreClase);
        
        try {
            
            frmkOOSSFacade = getFrmkOOSSFacade();
            retorno = frmkOOSSFacade.eliminarSolicitud(registro);
            
            
        } catch (GeneralException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
        } catch (RemoteException e) {
            
            logger.error(e, nombreClase);
            throw new GestionLimiteConsumoException(e);
        }
        
        logger.debug("eliminarSolicitud():end", nombreClase);
        return retorno;
    }

    public IndicadorAbonoOutDTO obtieneIndicadorAbono(IndicadorAbonoInDTO pIndicadorAbonoInDTO) throws RemoteException, GestionLimiteConsumoException {
  
        logger.debug("eliminarSolicitud():start", nombreClase);
        
        IndicadorAbonoOutDTO result = null;
        GestLimCon gestLimCon = null;

        try{

            gestLimCon = this.getGestLimConFacade();
            
            result = gestLimCon.obtieneIndicadorAbono(pIndicadorAbonoInDTO);
            
        }catch(RemoteException e){
            logger.error(e, nombreClase);
            e.printStackTrace();
            throw e;
        }catch(GestionLimiteConsumoException e){
            logger.error(e, nombreClase);
            e.printStackTrace();
            throw e;
        }
        
        logger.debug("eliminarSolicitud():end", nombreClase);
                
        return result;
    }

    public EjecutaCierreRestitucionOutDTO ejecutarCierreRestitucion(EjecutaCierreRestitucionInDTO inDTO) throws RemoteException, GestionLimiteConsumoException {
        
        logger.debug("eliminarSolicitud():start", nombreClase);
        
        EjecutaCierreRestitucionOutDTO result = null;
        RestitucionEquipo restitucionEquipo = null;
        
        try{
             restitucionEquipo = this.getRestitucionEquipoFacade(); 
    
             result = restitucionEquipo.ejecutarCierreRestitucion(inDTO);
    
        }catch(RemoteException e){
            
            logger.error(e, nombreClase);
            e.printStackTrace();
            throw e;
        }catch(GestionLimiteConsumoException e){
            
            logger.error(e, nombreClase);
            e.printStackTrace();
            throw e;
            
        }

        logger.debug("eliminarSolicitud():end", nombreClase);
        
        return result;
    }
}
