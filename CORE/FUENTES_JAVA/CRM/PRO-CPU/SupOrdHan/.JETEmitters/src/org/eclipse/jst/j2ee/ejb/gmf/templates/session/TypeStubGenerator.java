package org.eclipse.jst.j2ee.ejb.gmf.templates.session;

import java.util.*;
import org.eclipse.jst.j2ee.ejb.annotation.internal.model.*;
import org.eclipse.jst.j2ee.internal.common.operations.*;

public class TypeStubGenerator
{
  protected static String nl;
  public static synchronized TypeStubGenerator create(String lineSeparator)
  {
    nl = lineSeparator;
    TypeStubGenerator result = new TypeStubGenerator();
    nl = null;
    return result;
  }

  protected final String NL = nl == null ? (System.getProperties().getProperty("line.separator")) : nl;
  protected final String TEXT_1 = " " + NL + " ";
  protected final String TEXT_2 = NL;
  protected final String TEXT_3 = " ";
  protected final String TEXT_4 = " ";
  protected final String TEXT_5 = " class ";
  protected final String TEXT_6 = " ";
  protected final String TEXT_7 = " implements ";
  protected final String TEXT_8 = NL + "{" + NL + "}";
  protected final String TEXT_9 = NL;

  public String generate(Object argument)
  {
    final StringBuffer stringBuffer = new StringBuffer();
      ISessionBean session  = (ISessionBean)argument; 

      String superclass = ""+session.getDataModel().getProperty(INewJavaClassDataModelProperties.SUPERCLASS);
      if(superclass == null || superclass.length() == 0 )
        superclass = "java.lang.Object";
      Boolean modifier =  ((Boolean)(session.getDataModel().getProperty(INewJavaClassDataModelProperties.MODIFIER_PUBLIC)));
      boolean isPublic  = ( modifier != null && modifier.booleanValue());
      modifier =  ((Boolean)(session.getDataModel().getProperty(INewJavaClassDataModelProperties.MODIFIER_ABSTRACT)));
      boolean isAbstract = ( modifier != null && modifier.booleanValue());
      modifier =  ((Boolean)(session.getDataModel().getProperty(INewJavaClassDataModelProperties.MODIFIER_FINAL)));
      boolean isFinal = ( modifier != null && modifier.booleanValue());

      String publicStr = (isPublic ? "public": "");
      String abstractStr = (isAbstract ? "abstract": "");
      String finalStr = (isFinal ? "final": "");
      String extendsStr = (superclass.equals("java.lang.Object") ? "": "extends " + superclass);
 


    stringBuffer.append(TEXT_1);
    stringBuffer.append(TEXT_2);
    stringBuffer.append( publicStr );
    stringBuffer.append(TEXT_3);
    stringBuffer.append( finalStr );
    stringBuffer.append(TEXT_4);
    stringBuffer.append( abstractStr );
    stringBuffer.append(TEXT_5);
    stringBuffer.append( session.getSimpleClassName());
    stringBuffer.append(TEXT_6);
    stringBuffer.append( extendsStr );
    stringBuffer.append(TEXT_7);
    stringBuffer.append( session.getInterfaces() );
    stringBuffer.append(TEXT_8);
    stringBuffer.append(TEXT_9);
    return stringBuffer.toString();
  }
}
