/**
 * WsTarjetaCreditoInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsTarjetaCreditoInDTO  implements java.io.Serializable {
    private java.lang.String fechaDeVencimiento;

    private java.lang.String numeroTarjeta;

    private java.lang.String tipoTarjeta;

    public WsTarjetaCreditoInDTO() {
    }

    public WsTarjetaCreditoInDTO(
           java.lang.String fechaDeVencimiento,
           java.lang.String numeroTarjeta,
           java.lang.String tipoTarjeta) {
           this.fechaDeVencimiento = fechaDeVencimiento;
           this.numeroTarjeta = numeroTarjeta;
           this.tipoTarjeta = tipoTarjeta;
    }


    /**
     * Gets the fechaDeVencimiento value for this WsTarjetaCreditoInDTO.
     * 
     * @return fechaDeVencimiento
     */
    public java.lang.String getFechaDeVencimiento() {
        return fechaDeVencimiento;
    }


    /**
     * Sets the fechaDeVencimiento value for this WsTarjetaCreditoInDTO.
     * 
     * @param fechaDeVencimiento
     */
    public void setFechaDeVencimiento(java.lang.String fechaDeVencimiento) {
        this.fechaDeVencimiento = fechaDeVencimiento;
    }


    /**
     * Gets the numeroTarjeta value for this WsTarjetaCreditoInDTO.
     * 
     * @return numeroTarjeta
     */
    public java.lang.String getNumeroTarjeta() {
        return numeroTarjeta;
    }


    /**
     * Sets the numeroTarjeta value for this WsTarjetaCreditoInDTO.
     * 
     * @param numeroTarjeta
     */
    public void setNumeroTarjeta(java.lang.String numeroTarjeta) {
        this.numeroTarjeta = numeroTarjeta;
    }


    /**
     * Gets the tipoTarjeta value for this WsTarjetaCreditoInDTO.
     * 
     * @return tipoTarjeta
     */
    public java.lang.String getTipoTarjeta() {
        return tipoTarjeta;
    }


    /**
     * Sets the tipoTarjeta value for this WsTarjetaCreditoInDTO.
     * 
     * @param tipoTarjeta
     */
    public void setTipoTarjeta(java.lang.String tipoTarjeta) {
        this.tipoTarjeta = tipoTarjeta;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsTarjetaCreditoInDTO)) return false;
        WsTarjetaCreditoInDTO other = (WsTarjetaCreditoInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.fechaDeVencimiento==null && other.getFechaDeVencimiento()==null) || 
             (this.fechaDeVencimiento!=null &&
              this.fechaDeVencimiento.equals(other.getFechaDeVencimiento()))) &&
            ((this.numeroTarjeta==null && other.getNumeroTarjeta()==null) || 
             (this.numeroTarjeta!=null &&
              this.numeroTarjeta.equals(other.getNumeroTarjeta()))) &&
            ((this.tipoTarjeta==null && other.getTipoTarjeta()==null) || 
             (this.tipoTarjeta!=null &&
              this.tipoTarjeta.equals(other.getTipoTarjeta())));
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
        if (getFechaDeVencimiento() != null) {
            _hashCode += getFechaDeVencimiento().hashCode();
        }
        if (getNumeroTarjeta() != null) {
            _hashCode += getNumeroTarjeta().hashCode();
        }
        if (getTipoTarjeta() != null) {
            _hashCode += getTipoTarjeta().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsTarjetaCreditoInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsTarjetaCreditoInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fechaDeVencimiento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "FechaDeVencimiento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroTarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumeroTarjeta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipoTarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "TipoTarjeta"));
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
