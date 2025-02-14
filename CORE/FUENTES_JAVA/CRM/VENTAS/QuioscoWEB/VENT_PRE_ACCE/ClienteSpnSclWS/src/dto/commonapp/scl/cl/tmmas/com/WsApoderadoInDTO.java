/**
 * WsApoderadoInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsApoderadoInDTO  implements java.io.Serializable {
    private java.lang.String codigoTipident;

    private java.lang.String nomApoderado;

    private java.lang.String numeroIdent;

    public WsApoderadoInDTO() {
    }

    public WsApoderadoInDTO(
           java.lang.String codigoTipident,
           java.lang.String nomApoderado,
           java.lang.String numeroIdent) {
           this.codigoTipident = codigoTipident;
           this.nomApoderado = nomApoderado;
           this.numeroIdent = numeroIdent;
    }


    /**
     * Gets the codigoTipident value for this WsApoderadoInDTO.
     * 
     * @return codigoTipident
     */
    public java.lang.String getCodigoTipident() {
        return codigoTipident;
    }


    /**
     * Sets the codigoTipident value for this WsApoderadoInDTO.
     * 
     * @param codigoTipident
     */
    public void setCodigoTipident(java.lang.String codigoTipident) {
        this.codigoTipident = codigoTipident;
    }


    /**
     * Gets the nomApoderado value for this WsApoderadoInDTO.
     * 
     * @return nomApoderado
     */
    public java.lang.String getNomApoderado() {
        return nomApoderado;
    }


    /**
     * Sets the nomApoderado value for this WsApoderadoInDTO.
     * 
     * @param nomApoderado
     */
    public void setNomApoderado(java.lang.String nomApoderado) {
        this.nomApoderado = nomApoderado;
    }


    /**
     * Gets the numeroIdent value for this WsApoderadoInDTO.
     * 
     * @return numeroIdent
     */
    public java.lang.String getNumeroIdent() {
        return numeroIdent;
    }


    /**
     * Sets the numeroIdent value for this WsApoderadoInDTO.
     * 
     * @param numeroIdent
     */
    public void setNumeroIdent(java.lang.String numeroIdent) {
        this.numeroIdent = numeroIdent;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsApoderadoInDTO)) return false;
        WsApoderadoInDTO other = (WsApoderadoInDTO) obj;
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
            ((this.nomApoderado==null && other.getNomApoderado()==null) || 
             (this.nomApoderado!=null &&
              this.nomApoderado.equals(other.getNomApoderado()))) &&
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
        if (getNomApoderado() != null) {
            _hashCode += getNomApoderado().hashCode();
        }
        if (getNumeroIdent() != null) {
            _hashCode += getNumeroIdent().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsApoderadoInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsApoderadoInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipident");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoTipident"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomApoderado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NomApoderado"));
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
