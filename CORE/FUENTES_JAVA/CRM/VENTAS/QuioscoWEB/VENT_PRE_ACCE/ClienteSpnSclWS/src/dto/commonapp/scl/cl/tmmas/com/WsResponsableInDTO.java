/**
 * WsResponsableInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsResponsableInDTO  implements java.io.Serializable {
    private java.lang.String codigoTipident;

    private java.lang.String nombreResponsable;

    private java.lang.String numeroIdent;

    public WsResponsableInDTO() {
    }

    public WsResponsableInDTO(
           java.lang.String codigoTipident,
           java.lang.String nombreResponsable,
           java.lang.String numeroIdent) {
           this.codigoTipident = codigoTipident;
           this.nombreResponsable = nombreResponsable;
           this.numeroIdent = numeroIdent;
    }


    /**
     * Gets the codigoTipident value for this WsResponsableInDTO.
     * 
     * @return codigoTipident
     */
    public java.lang.String getCodigoTipident() {
        return codigoTipident;
    }


    /**
     * Sets the codigoTipident value for this WsResponsableInDTO.
     * 
     * @param codigoTipident
     */
    public void setCodigoTipident(java.lang.String codigoTipident) {
        this.codigoTipident = codigoTipident;
    }


    /**
     * Gets the nombreResponsable value for this WsResponsableInDTO.
     * 
     * @return nombreResponsable
     */
    public java.lang.String getNombreResponsable() {
        return nombreResponsable;
    }


    /**
     * Sets the nombreResponsable value for this WsResponsableInDTO.
     * 
     * @param nombreResponsable
     */
    public void setNombreResponsable(java.lang.String nombreResponsable) {
        this.nombreResponsable = nombreResponsable;
    }


    /**
     * Gets the numeroIdent value for this WsResponsableInDTO.
     * 
     * @return numeroIdent
     */
    public java.lang.String getNumeroIdent() {
        return numeroIdent;
    }


    /**
     * Sets the numeroIdent value for this WsResponsableInDTO.
     * 
     * @param numeroIdent
     */
    public void setNumeroIdent(java.lang.String numeroIdent) {
        this.numeroIdent = numeroIdent;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsResponsableInDTO)) return false;
        WsResponsableInDTO other = (WsResponsableInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoTipident==null && other.getCodigoTipident()==null) || 
             (this.codigoTipident!=null &&
              this.codigoTipident.equals(other.getCodigoTipident()))) &&
            ((this.nombreResponsable==null && other.getNombreResponsable()==null) || 
             (this.nombreResponsable!=null &&
              this.nombreResponsable.equals(other.getNombreResponsable()))) &&
            ((this.numeroIdent==null && other.getNumeroIdent()==null) || 
             (this.numeroIdent!=null &&
              this.numeroIdent.equals(other.getNumeroIdent())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getCodigoTipident() != null) {
            _hashCode += getCodigoTipident().hashCode();
        }
        if (getNombreResponsable() != null) {
            _hashCode += getNombreResponsable().hashCode();
        }
        if (getNumeroIdent() != null) {
            _hashCode += getNumeroIdent().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsResponsableInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsResponsableInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipident");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoTipident"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreResponsable");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NombreResponsable"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroIdent");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumeroIdent"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
