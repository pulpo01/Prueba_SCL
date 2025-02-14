/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */

package com.tmmas.scl.wsseguridad.autenticacion;

import java.lang.reflect.UndeclaredThrowableException;

import javax.naming.Context;
import javax.naming.NamingException;

import weblogic.management.MBeanHome;
import weblogic.management.configuration.DomainMBean;
import weblogic.management.security.RealmMBean;
import weblogic.management.security.authentication.AuthenticationProviderMBean;
import weblogic.management.security.authentication.UserEditorMBean;

public class EditorUsuarios
{
	private MBeanHome home;

	private Context ctx;

	private AuthenticationProviderMBean[] providers;

	public EditorUsuarios(Context ctx) throws NamingException
	{
		this.ctx = ctx;
		this.home = (MBeanHome) ctx.lookup(MBeanHome.ADMIN_JNDI_NAME);
		DomainMBean domain = home.getActiveDomain();
		RealmMBean realm = domain.getSecurityConfiguration().findDefaultRealm();
		this.providers = realm.getAuthenticationProviders();
	}

	private void cerrarContexto() throws NamingException
	{
		ctx.close();
	}

	public boolean cambiarPassword(String usuario, String passwordActual, String passwordNueva) throws Throwable
	{
		try
		{
			for (int i = 0; i < providers.length; i++)
			{
				AuthenticationProviderMBean bean = providers[i];
				if (bean instanceof UserEditorMBean)
				{
					UserEditorMBean editor = (UserEditorMBean) bean;
					editor.changeUserPassword(usuario, passwordActual, passwordNueva);
				}
			}
		}
		catch (UndeclaredThrowableException e)
		{
			Throwable t = e.getUndeclaredThrowable();
			throw t;
		}
		catch (Throwable e)
		{
			throw e;
		}
		finally
		{
			cerrarContexto();
		}
		return true;
	}

	public boolean crearUsuario(String usuario, String password, String passwordConfirmada) throws Throwable
	{
		try
		{
			for (int i = 0; i < providers.length; i++)
			{
				AuthenticationProviderMBean bean = providers[i];
				if (bean instanceof UserEditorMBean)
				{
					UserEditorMBean editor = (UserEditorMBean) bean;
					editor.createUser(usuario, password, passwordConfirmada);
				}
			}
		}
		catch (UndeclaredThrowableException e)
		{
			Throwable t = e.getUndeclaredThrowable();
			throw t;
		}
		catch (Throwable e)
		{
			throw e;
		}
		finally
		{
			cerrarContexto();
		}
		return true;
	}
}
