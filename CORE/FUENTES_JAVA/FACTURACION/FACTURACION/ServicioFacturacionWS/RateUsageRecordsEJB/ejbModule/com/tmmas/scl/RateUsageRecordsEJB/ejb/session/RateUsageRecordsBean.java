/**
 * 
 */
package com.tmmas.scl.RateUsageRecordsEJB.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.FacturaMiscelaneaEntradaDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.FacturaMiscelaneaSalidaDTO;
import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;
import com.tmmas.scl.operation.smo.ssir.RateUsageRecordsSrv.Interface.RateUsageRecordsSrvIT;
import com.tmmas.scl.operation.smo.ssir.RateUsageRecordsSrv.manager.RateUsageRecordsSrvFactory;
import com.tmmas.scl.operation.smo.ssir.RateUsageRecordsSrv.srv.RateUsageRecordsSrv;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!--
 * begin-xdoclet-definition -->
 * 
 * @ejb.bean name="RateUsageRecords" description="An EJB named RateUsageRecords"
 *           display-name="RateUsageRecordsEJB" jndi-name="RateUsageRecordsEJB"
 *           type="Stateless" transaction-type="Container" view-type="remote"
 * 
 * <!-- end-xdoclet-definition -->
 * @generated
 */

public abstract class RateUsageRecordsBean implements javax.ejb.SessionBean {
	private static Logger logger = Logger.getLogger(RateUsageRecordsBean.class);

	private CompositeConfiguration config;

	private SessionContext context;

	public RateUsageRecordsBean() {
		super();
		config = UtilProperty
				.getConfiguration("ServicioFacturacionWS.properties",
						"com/tmmas/scl/framework/properties/archivorecursos.properties");
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.create-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() {
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @throws NamingException
	 * 
	 * @throws OperationServiceResourceException
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public FacturaMiscelaneaSalidaDTO generarFacturaMiscelanea(
			FacturaMiscelaneaEntradaDTO facturaMiscelaneaEntradaDTO)
			throws RateUsageRecordsException {
		UtilLog.setLog(config.getString("RateUsageRecordsEJB.log"));
		FacturaMiscelaneaSalidaDTO facturaMiscelaneaSalidaDTO = null; ;
		// obtiene intancia del dao a traves de su clase factory
		RateUsageRecordsSrvIT rateUsageRecordsSrv = (RateUsageRecordsSrv) new RateUsageRecordsSrvFactory()
				.getInstance().getManageServiceInventorySrv();
		logger.debug("generarFacturaMiscelanea():start ");
		try {
			facturaMiscelaneaSalidaDTO = rateUsageRecordsSrv
					.generarFacturaMiscelanea(facturaMiscelaneaEntradaDTO);
		} catch (RateUsageRecordsException e) {
			facturaMiscelaneaSalidaDTO=new FacturaMiscelaneaSalidaDTO();
			logger.debug("REALIZANDO ROLLBACK ... ");
			context.setRollbackOnly();
			logger.debug("ROLLBACK ... OK ");
			facturaMiscelaneaSalidaDTO.setSnError(e.getCodigo());
			facturaMiscelaneaSalidaDTO.setSnEvento(String.valueOf(e
					.getCodigoEvento()));
			facturaMiscelaneaSalidaDTO.setSvMensaje(e.getDescripcionEvento());
			logger.debug(" generarFacturaMiscelanea():end ");
			return facturaMiscelaneaSalidaDTO;

		}
		logger.debug(" generarFacturaMiscelanea():end ");
		return facturaMiscelaneaSalidaDTO;

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
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		context = arg0;

	}

}
