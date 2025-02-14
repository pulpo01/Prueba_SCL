/**
 * WsBeneficioPromocionInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsBeneficioPromocionInDTO  implements java.io.Serializable {
    private java.lang.String clienteAboando;

    private java.lang.String codigoTipoPlan;

    public WsBeneficioPromocionInDTO() {
    }

    public WsBeneficioPromocionInDTO(
           java.lang.String clienteAboando,
           java.lang.String codigoTipoPlan) {
           this.clienteAboando = clienteAboando;
           this.codigoTipoPlan = codigoTipoPlan;
    }


    /**
     * Gets the clienteAboando value for this WsBeneficioPromocionInDTO.
     * 
     * @return clienteAboando
     */
    public java.lang.String getClienteAboando() {
        return clienteAboando;
    }


    /**
     * Sets the clienteAboando value for this WsBeneficioPromocionInDTO.
     * 
     * @param clienteAboando
     */
    public void setClienteAboando(java.lang.String clienteAboando) {
        this.clienteAboando = clienteAboando;
    }


    /**
     * Gets the codigoTipoPlan value for this WsBeneficioPromocionInDTO.
     * 
     * @return codigoTipoPlan
     */
    public java.lang.String getCodigoTipoPlan() {
        return codigoTipoPlan;
    }


    /**
     * Sets the codigoTipoPlan value for this WsBeneficioPromocionInDTO.
     * 
     * @param codigoTipoPlan
     */
    public void setCodigoTipoPlan(java.lang.String codigoTipoPlan) {
        this.codigoTipoPlan = codigoTipoPlan;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsBeneficioPromocionInDTO)) return false;
        WsBeneficioPromocionInDTO other = (WsBeneficioPromocionInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.clienteAboando==null && other.getClienteAboando()==null) || 
             (this.clienteAboando!=null &&
              this.clienteAboando.equals(other.getClienteAboando()))) &&
            ((this.codigoTipoPlan==null && other.getCodigoTipoPlan()==null) || 
             (this.codigoTipoPlan!=null &&
              this.codigoTipoPlan.equals(other.getCodigoTipoPlan())));
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
        if (getClienteAboando() != null) {
            _hashCode += getClienteAboando().hashCode();
        }
        if (getCodigoTipoPlan() != null) {
            _hashCode += getCodigoTipoPlan().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsBeneficioPromocionInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBeneficioPromocionInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("clienteAboando");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "ClienteAboando"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoPlan");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoTipoPlan"));
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
