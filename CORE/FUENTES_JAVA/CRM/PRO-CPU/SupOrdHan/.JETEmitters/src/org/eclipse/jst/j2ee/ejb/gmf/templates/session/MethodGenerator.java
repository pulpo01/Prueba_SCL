package org.eclipse.jst.j2ee.ejb.gmf.templates.session;

import java.util.*;
import org.eclipse.jst.j2ee.ejb.annotation.internal.model.*;

public class MethodGenerator
{
  protected static String nl;
  public static synchronized MethodGenerator create(String lineSeparator)
  {
    nl = lineSeparator;
    MethodGenerator result = new MethodGenerator();
    nl = null;
    return result;
  }

  protected final String NL = nl == null ? (System.getProperties().getProperty("line.separator")) : nl;
  protected final String TEXT_1 = NL + "/** " + NL + " *" + NL + " * <!-- begin-xdoclet-definition --> " + NL + " * @ejb.create-method view-type=\"remote\"" + NL + " * <!-- end-xdoclet-definition --> " + NL + " * @generated" + NL + " *" + NL + " * //TODO: Must provide implementation for bean create stub" + NL + " */" + NL + "public void ejbCreate()" + NL + "{" + NL + "}" + NL + "" + NL + "/** " + NL + " *" + NL + " * <!-- begin-xdoclet-definition --> " + NL + " * @ejb.interface-method view-type=\"remote\"" + NL + " * <!-- end-xdoclet-definition --> " + NL + " * @generated" + NL + " *" + NL + " * //TODO: Must provide implementation for bean method stub" + NL + " */" + NL + "public String foo(String param)" + NL + "{" + NL + " \treturn null;" + NL + "}";

  public String generate(Object argument)
  {
    final StringBuffer stringBuffer = new StringBuffer();
      ISessionBean session  = (ISessionBean)argument; 
    stringBuffer.append(TEXT_1);
    return stringBuffer.toString();
  }
}
