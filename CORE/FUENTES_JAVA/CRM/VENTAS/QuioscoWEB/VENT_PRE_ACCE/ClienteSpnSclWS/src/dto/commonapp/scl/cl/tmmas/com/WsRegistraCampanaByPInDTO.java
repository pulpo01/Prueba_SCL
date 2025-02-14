/**
 * WsRegistraCampanaByPInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsRegistraCampanaByPInDTO  implements java.io.Serializable {
    private java.lang.String codigoCampana;

    private java.lang.String codigoCliente;

    private java.lang.String indicadorAsignacion;

    private java.lang.String numeroAbonado;

    public WsRegistraCampanaByPInDTO() {
    }

    public WsRegistraCampanaByPInDTO(
           java.lang.String codigoCampana,
           java.lang.String codigoCliente,
           java.lang.String indicadorAsignacion,
           java.lang.String numeroAbonado) {
           this.codigoCampana = codigoCampana;
           this.codigoCliente = codigoCliente;
           this.indicadorAsignacion = indicadorAsignacion;
           this.numeroAbonado = numeroAbonado;
    }


    /**
     * Gets the codigoCampana value for this WsRegistraCampanaByPInDTO.
     * 
     * @return codigoCampana
     */
    public java.lang.String getCodigoCampana() {
        return codigoCampana;
    }


    /**
     * Sets the codigoCampana value for this WsRegistraCampanaByPInDTO.
     * 
     * @param codigoCampana
     */
    public void setCodigoCampana(java.lang.String codigoCampana) {
        this.codigoCampana = codigoCampana;
    }


    /**
     * Gets the codigoCliente value for this WsRegistraCampanaByPInDTO.
     * 
     * @return codigoCliente
     */
    public java.lang.String getCodigoCliente() {
        return codigoCliente;
    }


    /**
     * Sets the codigoCliente value for this WsRegistraCampanaByPInDTO.
     * 
     * @param codigoCliente
     */
    public void setCodigoCliente(java.lang.String codigoCliente) {
        this.codigoCliente = codigoCliente;
    }


    /**
     * Gets the indicadorAsignacion value for this WsRegistraCampanaByPInDTO.
     * 
     * @return indicadorAsignacion
     */
    public java.lang.String getIndicadorAsignacion() {
        return indicadorAsignacion;
    }


    /**
     * Sets the indicadorAsignacion value for this WsRegistraCampanaByPInDTO.
     * 
     * @param indicadorAsignacion
     */
    public void setIndicadorAsignacion(java.lang.String indicadorAsignacion) {
        this.indicadorAsignacion = indicadorAsignacion;
    }


    /**
     * Gets the numeroAbonado value for this WsRegistraCampanaByPInDTO.
     * 
     * @return numeroAbonado
     */
    public java.lang.String getNumeroAbonado() {
        return numeroAbonado;
    }


    /**
     * Sets the numeroAbonado value for this WsRegistraCampanaByPInDTO.
     * 
     * @param numeroAbonado
     */
    public void setNumeroAbonado(java.lang.String numeroAbonado) {
        this.numeroAbonado = numeroAbonado;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsRegistraCampanaByPInDTO)) return false;
        WsRegistraCampanaByPInDTO other = (WsRegistraCampanaByPInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoCampana==null && other.getCodigoCampana()==null) || 
             (this.codigoCampana!=null &&
              this.codigoCampana.equals(other.getCodigoCampana()))) &&
            ((this.codigoCliente==null && other.getCodigoCliente()==null) || 
             (this.codigoCliente!=null &&
              this.codigoCliente.equals(other.getCodigoCliente()))) &&
            ((this.indicadorAsignacion==null && other.getIndicadorAsignacion()==null) || 
             (this.indicadorAsignacion!=null &&
              this.indicadorAsignacion.equals(other.getIndicadorAsignacion()))) &&
            ((this.numeroAbonado==null && other.getNumeroAbonado()==null) || 
             (this.numeroAbonado!=null &&
              this.numeroAbonado.equals(other.getNumeroAbonado())));
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
        if (getCodigoCampana() != null) {
            _hashCode += getCodigoCampana().hashCode();
        }
        if (getCodigoCliente() != null) {
            _hashCode += getCodigoCliente().hashCode();
        }
        if (getIndicadorAsignacion() != null) {
            _hashCode += getIndicadorAsignacion().hashCode();
        }
        if (getNumeroAbonado() != null) {
            _hashCode += getNumeroAbonado().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsRegistraCampanaByPInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsRegistraCampanaByPInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCampana");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoCampana"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorAsignacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "IndicadorAsignacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroAbonado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumeroAbonado"));
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
