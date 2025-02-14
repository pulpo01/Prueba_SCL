package com.tmmas.scl.gestionlc.web.action.restitucion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.common.ServiceContextDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeguimientoSiniestroInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeguimientoSiniestroOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.GestLimCon;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class IniciarRestitucionEquipoAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;
    private RestitucionEquipo beanLocal;
    private GestLimCon gestLimCon;

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        loggerDebug("inicio(Action):");
        CargaSeguimientoSiniestroInDTO inDTO = new CargaSeguimientoSiniestroInDTO();
        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getRestitucionEquipoFacade();
        gestLimCon = locator.getGestLimConFacade();

        HttpSession session = request.getSession();
        ServiceContextDTO context = (ServiceContextDTO) session.getAttribute("login");
        context.setUsername(context.getUsername().toUpperCase());

        String strNumAbonado = (String) request.getSession().getAttribute("NumAbonado");

        inDTO.setLonNumAbonado(Long.valueOf(strNumAbonado));
        inDTO.setStrNomUsuario(context.getUsername());

        CargaSeguimientoSiniestroOutDTO outDTO = beanLocal.cargarSeguimientoSiniestro(inDTO);

        validaResult(outDTO.getIEvento(), outDTO.getStrCodError(), outDTO.getStrDesError());

        session.setAttribute("CargaSeguimientoSiniestroOutDTO", outDTO);
        request.getSession().setAttribute("intCantSiniestros", Integer.valueOf(outDTO.getSiniestroDTOs().length));

        // //////////////////

        // Obtengo los datos del abonado
        AbonadoDTO abonadoParam = new AbonadoDTO();
        abonadoParam.setNumAbonado(Long.parseLong(strNumAbonado));
        AbonadoDTO datosAbonado = gestLimCon.obtenerDatosAbonado(abonadoParam);

        UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();

        Long numAbonadoLong = new Long(strNumAbonado);
        usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());

        // Busco los datos para la cabecera de las paginas
        usuarioAbonado = gestLimCon.obtenerDatosUsuarioAbonado(usuarioAbonado);

        ClienteDTO entCliente = new ClienteDTO();
        entCliente.setCodCliente(datosAbonado.getCodCliente());
        loggerDebug("entCliente.getCodCliente: " + entCliente.getCodCliente());
        loggerDebug("obtenerDatosCliente:antes");
        ClienteDTO datosCliente = gestLimCon.obtenerDatosCliente(entCliente);
        loggerDebug("obtenerDatosCliente:despues");

        // Recupera informacion del usuario para las validaciones
        UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
        usuarioSistema.setNom_usuario(context.getUsername());
        usuarioSistema = gestLimCon.obtenerInformacionUsuario(usuarioSistema);

        session.setAttribute("datosAbonado", datosAbonado);
        session.setAttribute("usuarioAbonado", usuarioAbonado);
        session.setAttribute("datosCliente", datosCliente);
        session.setAttribute("usuarioSistema", usuarioSistema);
        session.setAttribute("UserName", context.getUsername());
        loggerDebug("fin(Action):");
        return mapping.findForward("success");

    }

}
