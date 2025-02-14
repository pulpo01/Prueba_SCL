package com.tmmas.scl.wsportal.businessobject.dao.helper;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework20.util.UtilProperty;

public class JndiHelper
{
	public static final String PROPERTIES_INTERNO = "com/tmmas/scl/wsportal/properties/WSPortalSrv.properties";

	public static final String PROPERTIES_EXTERNO = "WSPortalSrv.properties";

	private JndiForDataSource jndiForDataSource = null;

	private static Logger logger = Logger.getLogger(JndiHelper.class);

	private static JndiHelper instance = null;

	protected static final String INICIO_LOG = "Inicio";

	protected static final String FIN_LOG = "Fin";

	protected static CompositeConfiguration config = UtilProperty.getConfiguration(PROPERTIES_EXTERNO,
			PROPERTIES_INTERNO);

	private JndiHelper()
	{

	}

	public static synchronized JndiHelper getInstance()
	{
		if (instance == null)
		{
			instance = new JndiHelper();
		}
		return instance;
	}

	public JndiForDataSource getJndiForDataSource(String jndi)
	{
		logger.info(INICIO_LOG);
		if (jndiForDataSource == null)
		{
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(jndi);
		}
		logger.info(FIN_LOG);
		return jndiForDataSource;
	}
}
