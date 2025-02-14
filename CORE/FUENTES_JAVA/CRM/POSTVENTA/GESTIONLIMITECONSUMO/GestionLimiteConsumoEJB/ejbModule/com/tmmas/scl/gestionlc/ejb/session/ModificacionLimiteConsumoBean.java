/**
 * 
 */
package com.tmmas.scl.gestionlc.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import com.tmmas.scl.gestionlc.common.dto.ws.CargaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.common.validation.ValidationHelper;
import com.tmmas.scl.gestionlc.common.validation.exception.CampoObligatorioException;
import com.tmmas.scl.gestionlc.common.validation.exception.FormatoDecimalException;
import com.tmmas.scl.gestionlc.common.validation.exception.LargoInferiorAlMinimoException;
import com.tmmas.scl.gestionlc.common.validation.exception.LargoSuperiorAlMaximoException;
import com.tmmas.scl.gestionlc.common.validation.exception.NoEsDecimalException;
import com.tmmas.scl.gestionlc.common.validation.exception.NoEsEnteroException;
import com.tmmas.scl.gestionlc.ejb.common.GestionLimiteConsumoAbstractBean;
import com.tmmas.scl.gestionlc.srv.ModificacionLimiteConsumoSrv;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!--
 * begin-xdoclet-definition -->
 * 
 * @ejb.bean name="ModificacionLimiteConsumo"
 *           description="An EJB named ModificacionLimiteConsumo"
 *           display-name="ModificacionLimiteConsumo"
 *           jndi-name="ModificacionLimiteConsumo" type="Stateless"
 *           transaction-type="Container"
 * 
 *           <!-- end-xdoclet-definition -->
 * @generated
 */

public class ModificacionLimiteConsumoBean extends GestionLimiteConsumoAbstractBean implements javax.ejb.SessionBean {

    ModificacionLimiteConsumoSrv modificacionLimiteConsumoSrv = new ModificacionLimiteConsumoSrv();

    private GlobalProperties global = GlobalProperties.getInstance();

    /**
     * <!-- begin-xdoclet-definition --> <!-- end-xdoclet-definition -->
     * 
     * @generated
     */
    private static final long serialVersionUID = 1L;

    /**
     * 
     * <!-- begin-xdoclet-definition -->
     * 
     * @ejb.create-method view-type="remote" <!-- end-xdoclet-definition -->
     * @generated
     * 
     *            //TODO: Must provide implementation for bean create stub
     */
    public void ejbCreate() {
    }

    /**
     * 
     * <!-- begin-xdoclet-definition -->
     * 
     * @ejb.interface-method view-type="remote"
     * @ejb.transaction type="Required"
     * 
     *                  <!-- end-xdoclet-definition -->
     * @generated
     * 
     *            //TODO: Must provide implementation for bean method stub
     */
    public CargaModificacionLimiteConsumoOutDTO cargarModificacionLimiteConsumo(CargaModificacionLimiteConsumoInDTO pIn) {

        CargaModificacionLimiteConsumoOutDTO result = null;

        try {

            loggerDebug(" Inicio cargarModificacionLimiteConsumo");

            result = modificacionLimiteConsumoSrv.cargarModificacionLimiteConsumo(pIn);

            loggerDebug(" Fin cargarModificacionLimiteConsumo");

        } catch (GestionLimiteConsumoException e) {

            e.printStackTrace();

            result = new CargaModificacionLimiteConsumoOutDTO();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            loggerError(e);

        } catch (Exception ex) {

            ex.printStackTrace();

            result = new CargaModificacionLimiteConsumoOutDTO();

            // result.setIEvento();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));

            loggerError(ex);

        }

        return result;

    }

    /**
     * 
     * <!-- begin-xdoclet-definition -->
     * 
     * @ejb.interface-method view-type="remote"
     * @ejb.transaction type="Required"
     * 
     *                  <!-- end-xdoclet-definition -->
     * @generated
     * 
     *            //TODO: Must provide implementation for bean method stub
     */
    public WSCargaModificacionLimiteConsumoOutDTO cargarModificacionLimiteConsumoWS(WSCargaModificacionLimiteConsumoInDTO pIn) {

        loggerDebug("Inicio(Bean): cargarModificacionLimiteConsumoWS");
        
        WSCargaModificacionLimiteConsumoOutDTO result = new WSCargaModificacionLimiteConsumoOutDTO();
        
        try{
            loggerDebug("**********************************************");
            loggerDebug("getLonNumAbonado: " + pIn.getStrNumAbonado());
            loggerDebug("**********************************************");
            loggerDebug("validando parametro pIn");
            
            ValidationHelper.validarParametro(true, pIn);
            
            loggerDebug("**********************************************");
            loggerDebug("getLonNumAbonado: " + pIn.getStrNumAbonado());
            loggerDebug("**********************************************");

            loggerDebug("validando parametro pIn");
            
            ValidationHelper.validarParametro(true, pIn);
            
            loggerDebug("**********************************************");
            loggerDebug("getLonNumAbonado: " + pIn.getStrNumAbonado());
            loggerDebug("**********************************************");

        
        }catch(CampoObligatorioException coEx){
            
            result.setStrCodError("10009");
            result.setStrDesError("No se han informado datos de entrada");
            //result.setStrNumeroEvento("");
            
            return result;
        }
        
        try{
            
            ValidationHelper.validarParametro(ValidationHelper.entero, true, 1, 8, pIn.getStrNumAbonado());
            if(pIn.getStrNumAbonado() != null){
                ValidationHelper.validarParametro(ValidationHelper.entero, true, 1, 8, String.valueOf(pIn.getStrNumAbonado()));
            }else{
                ValidationHelper.validarParametro(ValidationHelper.entero, true, 1, 8, null);
            }
            if(pIn.getStrNumAbonado() != null){
                ValidationHelper.validarParametro(ValidationHelper.entero, true, 1, 8, String.valueOf(pIn.getStrNumAbonado()));
            }else{
                ValidationHelper.validarParametro(ValidationHelper.entero, true, 1, 8, null);
            }
            
        }catch(CampoObligatorioException coEx){
            
            result.setStrCodError("10010");
            result.setStrDesError("Parametro Número de Abonado no puede ser nulo");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoInferiorAlMinimoException limEx){

            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo Número de Abonado invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoSuperiorAlMaximoException lsmEx){
            
            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo Número de Abonado invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(NoEsEnteroException neeEx){
            
            result.setStrCodError("10020");
            result.setStrDesError("Valor del campo Número de Abonado con formato invalido");
            //result.setIEvento("");
            
            return result;
        }
        
        try {

            loggerDebug(" Inicio cargarModificacionLimiteConsumoWS");

            result = modificacionLimiteConsumoSrv.cargarModificacionLimiteConsumoWS(pIn);

            loggerDebug(" Fin cargarModificacionLimiteConsumo");

        } catch (GestionLimiteConsumoException e) {

            e.printStackTrace();

            result = new WSCargaModificacionLimiteConsumoOutDTO();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            loggerError(e);

        } catch (Exception ex) {

            ex.printStackTrace();

            result = new WSCargaModificacionLimiteConsumoOutDTO();

            // result.setIEvento();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));

            loggerError(ex);

        }

        loggerDebug("Fin(Bean): cargarModificacionLimiteConsumoWS");
        
        return result;

    }

    /**
     * 
     * <!-- begin-xdoclet-definition -->
     * 
     * @ejb.interface-method view-type="remote"
     * @ejb.transaction type="Required"
     * 
     *                  <!-- end-xdoclet-definition -->
     * @generated
     * 
     *            //TODO: Must provide implementation for bean method stub
     */
    public EjecutaModificacionLimiteConsumoOutDTO ejecutaModificacionLimiteConsumo(EjecutaModificacionLimiteConsumoInDTO pIn) {

        loggerDebug("Inicio(Bean): ejecutaModificacionLimiteConsumo");
        
        EjecutaModificacionLimiteConsumoOutDTO result = null;

        try {

            loggerDebug(" Inicio ejecutaModificacionLimiteConsumo");

            result = modificacionLimiteConsumoSrv.ejecutarModificacionLimiteConsumo(pIn);

            loggerDebug(" Fin ejecutaModificacionLimiteConsumo");

        } catch (GestionLimiteConsumoException e) {

            e.printStackTrace();

            result = new EjecutaModificacionLimiteConsumoOutDTO();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            loggerError(e);

        } catch (Exception ex) {

            ex.printStackTrace();

            result = new EjecutaModificacionLimiteConsumoOutDTO();

            // result.setIEvento();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));

            loggerError(ex);

        }

        loggerDebug("Fin(Bean): ejecutaModificacionLimiteConsumo");
        return result;

    }

    /**
     * 
     * <!-- begin-xdoclet-definition -->
     * 
     * @ejb.interface-method view-type="remote"
     * @ejb.transaction type="Required"
     * 
     *                  <!-- end-xdoclet-definition -->
     * @generated
     * 
     *            //TODO: Must provide implementation for bean method stub
     */
    public WSEjecutaModificacionLimiteConsumoOutDTO ejecutaModificacionLimiteConsumoWS(WSEjecutaModificacionLimiteConsumoInDTO pIn) {

        WSEjecutaModificacionLimiteConsumoOutDTO result = new WSEjecutaModificacionLimiteConsumoOutDTO();

        try{
            loggerDebug("**********************************************");
            loggerDebug("getLonNumAbonado: " + pIn.getStrNumAbonado());
            loggerDebug("getLonNumAbonado: " + pIn.getStrMonto());
            loggerDebug("getLonNumAbonado: " + pIn.getStrUserName());
            loggerDebug("getLonNumAbonado: " + pIn.getStrComentario());
            loggerDebug("**********************************************");
            ValidationHelper.validarParametro(true, pIn);
        
        }catch(CampoObligatorioException coEx){
            
            result.setStrCodError("10009");
            result.setStrDesError("No se han informado datos de entrada");
            //result.setStrNumeroEvento("");
            
            return result;
        }
        
        try{
            
            ValidationHelper.validarParametro(ValidationHelper.entero, true, 1, 8, String.valueOf(pIn.getStrNumAbonado()));
            
        }catch(CampoObligatorioException coEx){
            
            result.setStrCodError("10010");
            result.setStrDesError("Parametro Número de Abonado no puede ser nulo");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoInferiorAlMinimoException limEx){

            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo Número de Abonado invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoSuperiorAlMaximoException lsmEx){
            
            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo Número de Abonado invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(NoEsEnteroException neeEx){
            
            result.setStrCodError("10020");
            result.setStrDesError("Valor del campo Número de Abonado con formato invalido");
            //result.setIEvento("");
            
            return result;
        }
        
        try{
            
            ValidationHelper.validarParametro(ValidationHelper.decimal, true, 1, 14, String.valueOf(pIn.getStrMonto()));
            
        }catch(CampoObligatorioException coEx){
            
            result.setStrCodError("10010");
            result.setStrDesError("Parametro Monto no puede ser nulo");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoInferiorAlMinimoException limEx){

            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo del Monto es invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoSuperiorAlMaximoException lsmEx){
            
            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo Monto es invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(NoEsDecimalException neeEx){
            
            result.setStrCodError("10020");
            result.setStrDesError("Valor del campo Monto con formato invalido");
            //result.setIEvento("");
            
            return result;
        }
        
        int numeroDecimales = 0;
        
        try{
            numeroDecimales = modificacionLimiteConsumoSrv.obtieneDecimales();
            loggerDebug("numeroDecimales: "+numeroDecimales);
            
        } catch (GestionLimiteConsumoException e) {

            e.printStackTrace();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            loggerError(e);
            
            return result;

        }
        
        boolean validaFormatoDecimal = ValidationHelper.validateFormatFloat(pIn.getStrMonto(), 10, numeroDecimales);
        
        if(!validaFormatoDecimal){
            
            result.setStrCodError("10020");
            result.setStrDesError("Valor del campo Monto con formato invalido");
            //result.setIEvento("");
            
            return result;
        }
        
        try{
            
            ValidationHelper.validarParametro(ValidationHelper.alfaNumerico, true, 1, 30, String.valueOf(pIn.getStrUserName()));
            
        }catch(CampoObligatorioException coEx){
            
            result.setStrCodError("10010");
            result.setStrDesError("Parametro Nombre de Usuario no puede ser nulo");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoInferiorAlMinimoException limEx){

            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo Nombre de Usuario invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoSuperiorAlMaximoException lsmEx){
            
            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo Nombre de Usuario invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(NoEsEnteroException neeEx){
            
            result.setStrCodError("10020");
            result.setStrDesError("Valor del campo Nombre de Usuario con formato invalido");
            //result.setIEvento("");
            
            return result;
        }
        
        try{
            
            ValidationHelper.validarParametro(ValidationHelper.alfaNumerico, true, 1, 500, String.valueOf(pIn.getStrComentario()));
            
        }catch(CampoObligatorioException coEx){
            
            result.setStrCodError("10010");
            result.setStrDesError("Parametro Comentario no puede ser nulo");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoInferiorAlMinimoException limEx){

            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo Comentario invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(LargoSuperiorAlMaximoException lsmEx){
            
            result.setStrCodError("10021");
            result.setStrDesError("Largo del campo Comentario invalido");
            //result.setIEvento("");
            
            return result;
            
        }catch(NoEsEnteroException neeEx){
            
            result.setStrCodError("10020");
            result.setStrDesError("Valor del campo Comentario con formato invalido");
            //result.setIEvento("");
            
            return result;
        }
        
        try {

            loggerDebug(" Inicio ejecutaModificacionLimiteConsumoWS");

            result = modificacionLimiteConsumoSrv.ejecutarModificacionLimiteConsumoWS(pIn);

            loggerDebug(" Fin ejecutaModificacionLimiteConsumoWS");

        } catch (GestionLimiteConsumoException e) {

            e.printStackTrace();

            result = new WSEjecutaModificacionLimiteConsumoOutDTO();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            loggerError(e);

        } catch (Exception ex) {

            ex.printStackTrace();

            result = new WSEjecutaModificacionLimiteConsumoOutDTO();

            // result.setIEvento();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));

            loggerError(ex);

        }

        return result;

    }

    /*
     * (non-Javadoc)
     * 
     * @see javax.ejb.SessionBean#ejbActivate()
     */
    public void ejbActivate() throws EJBException, RemoteException {
        // TODO Auto-generated method stub

    }

    /*
     * (non-Javadoc)
     * 
     * @see javax.ejb.SessionBean#ejbPassivate()
     */
    public void ejbPassivate() throws EJBException, RemoteException {
        // TODO Auto-generated method stub

    }

    /*
     * (non-Javadoc)
     * 
     * @see javax.ejb.SessionBean#ejbRemove()
     */
    public void ejbRemove() throws EJBException, RemoteException {
        // TODO Auto-generated method stub

    }

    /*
     * (non-Javadoc)
     * 
     * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
     */
    public void setSessionContext(SessionContext arg0) throws EJBException, RemoteException {
        // TODO Auto-generated method stub

    }

    /**
	 * 
	 */
    public ModificacionLimiteConsumoBean() {
        // TODO Auto-generated constructor stub
    }
}
