package com.tmmas.scl.gestionlc.srv;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.aplicationDomain.bo.UsuarioSistemaBOFactory;
import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOFactoryIT;
import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOIT;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.customerDomain.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.gestionlc.bo.GeneralBO;
import com.tmmas.scl.gestionlc.bo.SerieBO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.srv.common.GestionLimiteConsumoAbstractSRV;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

public class GestionLimiteConsumoSrv extends GestionLimiteConsumoAbstractSRV {

    private AbonadoBOFactoryIT factoryBO11 = new AbonadoBOFactory();
    private AbonadoIT abonadoBO = factoryBO11.getBusinessObject1();

    private ClienteBOFactoryIT factoryBO13 = new ClienteBOFactory();
    private ClienteIT clienteBO = factoryBO13.getBusinessObject1();

    private PlanTarifarioBOFactoryIT planFactory = new PlanTarifarioBOFactory();
    private PlanTarifarioIT planTarifarioBO = planFactory.getBusinessObject1();

    private UsuarioSistemaBOFactoryIT factoryBO2 = new UsuarioSistemaBOFactory();
    private UsuarioSistemaBOIT usuarioSistemaBO = factoryBO2.getBusinessObject1();

    private GeneralBO generalBO = new GeneralBO();

    private SerieBO serieBO = new SerieBO();

    public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws CusIntManException {
        AbonadoDTO respuesta = null;
        try {

            loggerDebug("obtenerDatosAbonado():start");
            respuesta = abonadoBO.obtenerDatosAbonado(abonado);
            loggerDebug("obtenerDatosAbonado():end");

        } catch (GeneralException e) {
            loggerError(e);
            throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
        } catch (Exception e) {
            loggerError(e);
            throw new CusIntManException(e);
        }
        return respuesta;
    }

    public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CusIntManException {
        ClienteDTO respuesta = null;

        try {

            loggerDebug("obtenerDatosCliente():start");
            respuesta = clienteBO.obtenerDatosCliente(cliente);
            loggerDebug("obtenerDatosCliente():end");

        } catch (GeneralException e) {
            loggerError(e);
            throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
        } catch (Exception e) {
            loggerError(e);
            throw new CusIntManException(e);
        }

        return respuesta;
    }

    /**
     * obtiene el indicador de abono asociado a la modalidad de la venta
     * 
     * @param
     * @return IndicadorAbonoOutDTO
     * @throws GestionLimiteConsumoException
     */
    public IndicadorAbonoOutDTO obtieneIndicadorAbono(IndicadorAbonoInDTO pIndicadorAbonoInDTO)

        throws GestionLimiteConsumoException {

        loggerDebug("Inicio(SRV):obtieneIndicadorAbono");

        IndicadorAbonoOutDTO result = generalBO.obtieneIndicadorAbono(pIndicadorAbonoInDTO);

        loggerDebug("Fin(SRV):obtieneIndicadorAbono");

        return result;
    }

    /**
     * obtiene el indicador de venta externa asociado al vendedor
     * 
     * @param
     * @return IndicadorVtaExternaVendedorOutDTO
     * @throws GestionLimiteConsumoException
     */
    public IndicadorVtaExternaVendedorOutDTO obtieneIndicadorVtaExternaVendedor(IndicadorVtaExternaVendedorInDTO pIndicadorVtaExternaVendedorInDTO)

        throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtieneIndicadorVtaExternaVendedor");

        IndicadorVtaExternaVendedorOutDTO result = generalBO.obtieneIndicadorVtaExternaVendedor(pIndicadorVtaExternaVendedorInDTO);

        loggerDebug("Inicio():obtieneIndicadorVtaExternaVendedor");

        return result;

    }

    public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO usuarioAbonado) throws CusIntManException {
        UsuarioAbonadoDTO respuesta = null;
        try {

            loggerDebug("obtenerDatosUsuarioAbonado():start");

            respuesta = abonadoBO.obtenerDatosUsuarioCelular(usuarioAbonado);

            loggerDebug("obtenerDatosUsuarioAbonado():end");

        } catch (GeneralException e) {
            loggerError(e);
            throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
        } catch (Exception e) {
            loggerError(e);
            throw new CusIntManException(e);
        }
        return respuesta;

    } // obtenerDatosUsuarioAbonado

    public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO pPlanTarifarioDTO) throws GeneralException {

        PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
        try {

            loggerDebug("getCategoriaPlanTarifario():start");

            planTarifarioDTO = planTarifarioBO.getCategoriaPlanTarifario(pPlanTarifarioDTO);

            loggerDebug("getCategoriaPlanTarifario():end");

        } catch (GeneralException e) {
            loggerError(e);
            throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
        } catch (Exception e) {
            loggerError(e);
            throw new ProductException(e);
        }

        return planTarifarioDTO;
    }

    public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws AplicationException {

        UsuarioSistemaDTO respuesta = null;

        try {

            loggerDebug("ejecutaRestrccion():start");
            respuesta = usuarioSistemaBO.obtenerInformacionUsuario(usuarioSistema);
            loggerDebug("ejecutaRestrccion():end");

        } catch (AplicationException e) {
            loggerError(e);
            throw e;
        } catch (Exception e) {
            loggerError(e);
            throw new AplicationException(e);
        }

        return respuesta;

    } // obtenerInformacionUsuario
}
