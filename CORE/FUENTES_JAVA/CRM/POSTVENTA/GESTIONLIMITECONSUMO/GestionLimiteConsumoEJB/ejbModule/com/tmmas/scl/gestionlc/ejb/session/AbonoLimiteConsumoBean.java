/**
 * 
 */
package com.tmmas.scl.gestionlc.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import com.tmmas.scl.gestionlc.common.dto.ws.CargaAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecucionAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecucionAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaAbonoLimiteConsumoOutDTO;
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
import com.tmmas.scl.gestionlc.srv.AbonoLimiteConsumoSrv;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!--
 * begin-xdoclet-definition -->
 * 
 * @ejb.bean name="AbonoLimiteConsumo"
 *           description="An EJB named AbonoLimiteConsumo"
 *           display-name="AbonoLimiteConsumo" jndi-name="AbonoLimiteConsumo"
 *           type="Stateless" transaction-type="Container"
 * 
 *           <!-- end-xdoclet-definition -->
 * @generated
 */

public class AbonoLimiteConsumoBean extends GestionLimiteConsumoAbstractBean implements javax.ejb.SessionBean {

    private GlobalProperties global = GlobalProperties.getInstance();

    AbonoLimiteConsumoSrv abonoLimiteConsumoSrv = new AbonoLimiteConsumoSrv();

    private SessionContext context = null;

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
     * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
     * @generated
     * 
     *            //TODO: Must provide implementation for bean method stub
     */
    public CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumo(CargaAbonoLimiteConsumoInDTO pIn) {

        CargaAbonoLimiteConsumoOutDTO result = null;

        try {

            loggerDebug(" Inicio cargaAbonoLimiteConsumo");

            result = abonoLimiteConsumoSrv.cargaAbonoLimiteConsumo(pIn);

            loggerDebug(" Fin cargaAbonoLimiteConsumo");

        } catch (GestionLimiteConsumoException e) {

            loggerError(e);

            e.printStackTrace();

            result = new CargaAbonoLimiteConsumoOutDTO();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            context.setRollbackOnly();

        } catch (Exception ex) {

            loggerError(ex);

            ex.printStackTrace();

            result = new CargaAbonoLimiteConsumoOutDTO();

            // result.setIEvento();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));

            context.setRollbackOnly();
        }

        return result;

    }

    /**
     * 
     * <!-- begin-xdoclet-definition -->
     * 
     * @ejb.interface-method view-type="remote"
     * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
     * @generated
     * 
     *            //TODO: Must provide implementation for bean method stub
     */
    public WSCargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoWS(WSCargaAbonoLimiteConsumoInDTO pIn) {

        WSCargaAbonoLimiteConsumoOutDTO result = new WSCargaAbonoLimiteConsumoOutDTO();
        
        try{
            loggerDebug("**********************************************");
            loggerDebug("getLonNumAbonado: " + pIn.getStrNumAbonado());
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

        try {

            loggerDebug(" Inicio cargaAbonoLimiteConsumoWS");

            result = abonoLimiteConsumoSrv.cargaAbonoLimiteConsumoWS(pIn);

            loggerDebug(" Fin cargaAbonoLimiteConsumo");

        } catch (GestionLimiteConsumoException e) {

            loggerError(e);

            e.printStackTrace();

            result = new WSCargaAbonoLimiteConsumoOutDTO();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            context.setRollbackOnly();

        } catch (Exception ex) {

            loggerError(ex);

            ex.printStackTrace();

            result = new WSCargaAbonoLimiteConsumoOutDTO();

            // result.setIEvento();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));

            context.setRollbackOnly();
        }

        return result;

    }

    /**
     * 
     * <!-- begin-xdoclet-definition -->
     * 
     * @ejb.interface-method view-type="remote"
     * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
     * @generated
     * 
     *            //TODO: Must provide implementation for bean method stub
     */
    public EjecucionAbonoLimiteConsumoOutDTO ejecutarAbonoLimiteConsumo(EjecucionAbonoLimiteConsumoInDTO pIn) {

        EjecucionAbonoLimiteConsumoOutDTO result = null;
        
        try {

            loggerDebug(" Inicio ejecutarAbonoLimiteConsumo");

            result = abonoLimiteConsumoSrv.ejecutarAbonoLimiteConsumo(pIn);

            loggerDebug(" Fin ejecutarAbonoLimiteConsumo");

        } catch (GestionLimiteConsumoException e) {

            loggerError(e);

            e.printStackTrace();

            result = new EjecucionAbonoLimiteConsumoOutDTO();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            context.setRollbackOnly();

        } catch (Exception ex) {

            loggerError(ex);

            ex.printStackTrace();

            result = new EjecucionAbonoLimiteConsumoOutDTO();

            // result.setIEvento();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));

            context.setRollbackOnly();
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
    public WSEjecutaAbonoLimiteConsumoOutDTO ejecutaAbonoLimiteConsumoWS(WSEjecutaAbonoLimiteConsumoInDTO pIn) {

        WSEjecutaAbonoLimiteConsumoOutDTO result = new WSEjecutaAbonoLimiteConsumoOutDTO();

        try{
            loggerDebug("**********************************************");
            loggerDebug("getLonNumAbonado: " + pIn.getStrNumAbonado());
            loggerDebug("getLonNumAbonado: " + pIn.getStrAbono());
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
            
            ValidationHelper.validarParametro(ValidationHelper.decimal, true, 1, 14, pIn.getStrAbono());
            
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
            numeroDecimales = abonoLimiteConsumoSrv.obtieneDecimales();
            
        } catch (GestionLimiteConsumoException e) {

            e.printStackTrace();

            result = new WSEjecutaAbonoLimiteConsumoOutDTO();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            loggerError(e);
            
            return result;

        }
        
        boolean validaFormatoDecimal = ValidationHelper.validateFormatFloat(pIn.getStrAbono(), 10, numeroDecimales);
            
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

            result = abonoLimiteConsumoSrv.ejecutarAbonoLimiteConsumoWS(pIn);

            loggerDebug(" Fin ejecutaModificacionLimiteConsumoWS");

        } catch (GestionLimiteConsumoException e) {

            e.printStackTrace();

            result = new WSEjecutaAbonoLimiteConsumoOutDTO();

            result.setIEvento(e.getCodigoEvento());
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());

            loggerError(e);

        } catch (Exception ex) {

            ex.printStackTrace();

            result = new WSEjecutaAbonoLimiteConsumoOutDTO();

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

        this.context = arg0;

    }

    /**
	 * 
	 */
    public AbonoLimiteConsumoBean() {
        // TODO Auto-generated constructor stub
    }
}
