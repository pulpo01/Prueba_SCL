package org.eclipse.jst.j2ee.ejb.gmf.templates.session;

import java.util.*;
import org.eclipse.jst.j2ee.ejb.annotation.internal.model.*;

public class TypeCommentGenerator
{
  protected static String nl;
  public static synchronized TypeCommentGenerator create(String lineSeparator)
  {
    nl = lineSeparator;
    TypeCommentGenerator result = new TypeCommentGenerator();
    nl = null;
    return result;
  }

  protected final String NL = nl == null ? (System.getProperties().getProperty("line.separator")) : nl;
  protected final String TEXT_1 = "/**" + NL + " *" + NL + " * <!-- begin-user-doc -->" + NL + " * A generated session bean" + NL + " * <!-- end-user-doc -->" + NL + " * *" + NL + " * <!-- begin-xdoclet-definition --> " + NL + " * @ejb.bean name=\"";
  protected final String TEXT_2 = "\"\t" + NL + " *           description=\"";
  protected final String TEXT_3 = "\"" + NL + " *           display-name=\"";
  protected final String TEXT_4 = "\"" + NL + " *           jndi-name=\"";
  protected final String TEXT_5 = "\"" + NL + " *           type=\"";
  protected final String TEXT_6 = "\" " + NL + " *           transaction-type=\"";
  protected final String TEXT_7 = "\"" + NL + " * " + NL + " * <!-- end-xdoclet-definition --> " + NL + " * @generated" + NL + " */";
  protected final String TEXT_8 = NL;

  public String generate(Object argument)
  {
    final StringBuffer stringBuffer = new StringBuffer();
      ISessionBean session  = (ISessionBean)argument; 
    stringBuffer.append(TEXT_1);
    stringBuffer.append(session.getEjbName() );
    stringBuffer.append(TEXT_2);
    stringBuffer.append(session.getDescription());
    stringBuffer.append(TEXT_3);
    stringBuffer.append(session.getDisplayName());
    stringBuffer.append(TEXT_4);
    stringBuffer.append(session.getJndiName());
    stringBuffer.append(TEXT_5);
    stringBuffer.append(session.getSessionType() );
    stringBuffer.append(TEXT_6);
    stringBuffer.append( session.getTransactionType());
    stringBuffer.append(TEXT_7);
    stringBuffer.append(TEXT_8);
    return stringBuffer.toString();
  }
}
