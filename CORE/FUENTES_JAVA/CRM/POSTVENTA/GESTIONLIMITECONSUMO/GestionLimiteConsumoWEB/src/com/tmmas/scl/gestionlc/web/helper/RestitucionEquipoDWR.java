package com.tmmas.scl.gestionlc.web.helper;

import java.rmi.RemoteException;

import javax.servlet.http.HttpSession;

import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.gestionlc.common.dto.ConsultaSeriesDTO;
import com.tmmas.scl.gestionlc.common.dto.CuotaDTO;
import com.tmmas.scl.gestionlc.common.dto.ModalidadDTO;
import com.tmmas.scl.gestionlc.common.dto.SerieDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboCuotasInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboCuotasOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboModalidadInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboModalidadOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaListSeriesInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaListSeriesOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;
import com.tmmas.scl.gestionlc.ejb.session.GestLimCon;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.web.form.restitucion.CargosForm;
import com.tmmas.scl.gestionlc.web.form.restitucion.PresupuestoForm;

public class RestitucionEquipoDWR {

    private final LoggerHelper logger = LoggerHelper.getInstance();
    private GlobalProperties global = GlobalProperties.getInstance();
    private GestionLimiteConsumoLocator locator;
    private RestitucionEquipo beanLocal;
    private GestLimCon gestLimConBean;

    // Inicio obtener modalidad de pago
    public ModalidadDTO[] obtenerModalidadPago(String codTipContrato, String userName, String numAbonado) throws GestionLimiteConsumoException, RemoteException {

        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getRestitucionEquipoFacade();

        RecargaCboModalidadInDTO recargaCboModalidadInDTO = new RecargaCboModalidadInDTO();
        recargaCboModalidadInDTO.setStrCodTipContrato(codTipContrato);
        recargaCboModalidadInDTO.setStrNomUsuario(userName);
        recargaCboModalidadInDTO.setLonNumAbonado(Long.valueOf(numAbonado));

        RecargaCboModalidadOutDTO recargaCboModalidadOutDTO = beanLocal.recargarCboModalidad(recargaCboModalidadInDTO);

        ModalidadDTO[] modalidadDTOs = recargaCboModalidadOutDTO.getModalidadDTOs();

        return modalidadDTOs;
    }

    // Fin obtener modalidad de pago

    public RetornoDTO eliminarCargos() throws RemoteException, GestionLimiteConsumoException {

        logger.debug("DWR - eliminarCargos", this.getClass().getName());

        locator = new GestionLimiteConsumoLocator();

        RetornoDTO retorno = new RetornoDTO();

        HttpSession session = WebContextFactory.get().getSession();

        PresupuestoForm formPresupuesto = (PresupuestoForm) session.getAttribute("PresupuestoForm");

        CargosForm cargosForm = (CargosForm) session.getAttribute("CargosForm");
        boolean isACiclo;
        if ("NO".equals(cargosForm.getRbCiclo().trim())) {
            isACiclo = true;
        } else {
            isACiclo = false;
        }

        RegistroFacturacionDTO registro = new RegistroFacturacionDTO();

        registro.setNumeroProcesoFacturacion(String.valueOf(formPresupuesto.getNumProceso()));

        if (isACiclo) {
            retorno = locator.eliminarPresupuesto(registro);
        }

        logger.debug("DWR - eliminarCargos():end", this.getClass().getName());
        return retorno;
    }

    public void rollbackReservaSerie() {

        logger.debug("DWR - rollbackReservaSerie", this.getClass().getName());

        locator = new GestionLimiteConsumoLocator();

        try {

            beanLocal = locator.getRestitucionEquipoFacade();

            HttpSession session = WebContextFactory.get().getSession();

            Long lonNumTransacReserva = (Long) session.getAttribute("LonNumTransacReserva");

            if (lonNumTransacReserva != null) {

                beanLocal.rollbackReservaSerie(lonNumTransacReserva);

                logger.debug("Desreserva de la serie realizada", this.getClass().getName());

            } else {
                logger.debug("No se realizo la desreserva, no hay numero de reserva", this.getClass().getName());
            }

        } catch (Exception e) {
            logger.error(e, this.getClass().getName());
            e.printStackTrace();
        }

        logger.debug("DWR - rollbackReservaSerie():end", this.getClass().getName());

    }

    // Inicio obtener cuota
    public CuotaDTO[] obtenerCuota(String codModVenta, String userName) throws GestionLimiteConsumoException, RemoteException {

        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getRestitucionEquipoFacade();

        RecargaCboCuotasInDTO recargaCboCuotasInDTO = new RecargaCboCuotasInDTO();
        recargaCboCuotasInDTO.setShoCodModVenta(Short.valueOf(codModVenta));
        recargaCboCuotasInDTO.setStrNomUsuario(userName);

        RecargaCboCuotasOutDTO recargaCboCuotasOutDTO = beanLocal.recargarCboCuotas(recargaCboCuotasInDTO);

        CuotaDTO[] cuotaDTO = recargaCboCuotasOutDTO.getCuotaDTOs();

        return cuotaDTO;
    }

    // Fin obtener cuota

    // Inicio carga equipos
    public String obtenerEquipos(String userName, String numAbonado, String numSiniestro, String codModVenta, String codTipContrato, int codUso,
            int codArticulo, int codBodega, int codEstado) throws GestionLimiteConsumoException, RemoteException {

        HttpSession session = WebContextFactory.get().getSession();

        ConsultaSeriesDTO consultaSeriesDTO = new ConsultaSeriesDTO();
        // consultaSeriesDTO.setIntCodModVenta(1);
        // consultaSeriesDTO.setStrCodCategoria();
        // consultaSeriesDTO.setIntIndCausa(1);
        // consultaSeriesDTO.setStrCodOperacion("RE");
        // consultaSeriesDTO.setIntNumMeses(12);
        // consultaSeriesDTO.setStrCodTipContrato("84");
        // consultaSeriesDTO.setStrTipTerminal("T");
        consultaSeriesDTO.setIntCodModVenta(Integer.valueOf(codModVenta));
        consultaSeriesDTO.setStrCodTipContrato(codTipContrato);
        consultaSeriesDTO.setIntCodEstado(codEstado);
        consultaSeriesDTO.setIntCodArticulo(codArticulo);
        consultaSeriesDTO.setIntCodBodega(codBodega);
        consultaSeriesDTO.setIntCodUso(codUso);

        // dummies
        // consultaSeriesDTO.setIntIndCausa(1);
        // consultaSeriesDTO.setIntNumMeses(12);
        // consultaSeriesDTO.setStrCodOperacion("RE");
        // consultaSeriesDTO.setStrTipTerminal("T");
        // dummies

        RecargaListSeriesInDTO recargaListSeriesInDTO = new RecargaListSeriesInDTO();
        recargaListSeriesInDTO.setConsultaSeriesDTO(consultaSeriesDTO);
        recargaListSeriesInDTO.setStrNomUsuario(userName);
        recargaListSeriesInDTO.setLonNumAbonado(Long.valueOf(numAbonado));
        recargaListSeriesInDTO.setLonNumSiniestro(Long.valueOf(numSiniestro));

        RecargaListSeriesOutDTO recargaListSeriesOutDTO = beanLocal.recargaListSeries(recargaListSeriesInDTO);

        SerieDTO[] serieDTO = recargaListSeriesOutDTO.getSerieDTOs();

        String title = "listaEquipos";
        StringBuffer jsonString = new StringBuffer("\r\n{\"" + title + "\": [");

        int numeroEquipos = Integer.valueOf(global.getValorExterno("cantidad.registros.series"));

        if (serieDTO.length > 0) {

            session.setAttribute("series", serieDTO);

            int numeroserieDTO = serieDTO.length;

            if (numeroserieDTO < numeroEquipos) {
                numeroEquipos = numeroserieDTO;
            }

            for (int i = 0; i < numeroEquipos; i++) {

                jsonString.append("\r\n{\"desStock\":\"" + serieDTO[i].getStrDesStock());
                jsonString.append("\",\"numSerie\":\"" + serieDTO[i].getStrNumSerie());
                jsonString.append("\",\"numSerieMec\":\"" + serieDTO[i].getStrNumSerieMec());
                jsonString.append("\",\"tipTerminal\":\"" + serieDTO[i].getStrTipTerminal() + "\"},");
            }

            int lastCharIndex = jsonString.length();
            jsonString.deleteCharAt(lastCharIndex - 1);
            jsonString.append("\r\n]}");

        } else {

            if (session.getAttribute("series") != null) {
                session.removeAttribute("series");
            }

            jsonString.append("\r\n]}");
        }

        return jsonString.toString();
    }

    // Fin carga equipos

    // Inicio desbloquea vendedor
    public void desbloqueaVendedor() throws GestionLimiteConsumoException, RemoteException {

        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getRestitucionEquipoFacade();

        HttpSession session = WebContextFactory.get().getSession();

        UsuarioSistemaDTO usuarioSistemaDTO = new UsuarioSistemaDTO();
        usuarioSistemaDTO = (UsuarioSistemaDTO) session.getAttribute("usuarioSistema");

        UsuarioDTO usuarioDTO = new UsuarioDTO();

        usuarioDTO.setIntCodVendedor(Integer.valueOf((int) usuarioSistemaDTO.getCod_vendedor()));
        beanLocal.desbloquearVendedor(usuarioDTO);

    }
    // Fin desbloquea vendedor
}
