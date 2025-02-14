/**
 * WsStructuraAccesorioDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.quiosco.spnsclwscommon.scl.cl.tmmas.com;

public class WsStructuraAccesorioDTO  implements java.io.Serializable {
    private java.lang.String cantidad;

    private java.lang.String codBodega;

    private java.lang.String codigoArticulo;

    private java.lang.String numeroSerie;

    public WsStructuraAccesorioDTO() {
    }

    public WsStructuraAccesorioDTO(
           java.lang.String cantidad,
           java.lang.String codBodega,
           java.lang.String codigoArticulo,
           java.lang.String numeroSerie) {
           this.cantidad = cantidad;
           this.codBodega = codBodega;
           this.codigoArticulo = codigoArticulo;
           this.numeroSerie = numeroSerie;
    }


    /**
     * Gets the cantidad value for this WsStructuraAccesorioDTO.
     * 
     * @return cantidad
     */
    public java.lang.String getCantidad() {
        return cantidad;
    }


    /**
     * Sets the cantidad value for this WsStructuraAccesorioDTO.
     * 
     * @param cantidad
     */
    public void setCantidad(java.lang.String cantidad) {
        this.cantidad = cantidad;
    }


    /**
     * Gets the codBodega value for this WsStructuraAccesorioDTO.
     * 
     * @return codBodega
     */
    public java.lang.String getCodBodega() {
        return codBodega;
    }


    /**
     * Sets the codBodega value for this WsStructuraAccesorioDTO.
     * 
     * @param codBodega
     */
    public void setCodBodega(java.lang.String codBodega) {
        this.codBodega = codBodega;
    }


    /**
     * Gets the codigoArticulo value for this WsStructuraAccesorioDTO.
     * 
     * @return codigoArticulo
     */
    public java.lang.String getCodigoArticulo() {
        return codigoArticulo;
    }


    /**
     * Sets the codigoArticulo value for this WsStructuraAccesorioDTO.
     * 
     * @param codigoArticulo
     */
    public void setCodigoArticulo(java.lang.String codigoArticulo) {
        this.codigoArticulo = codigoArticulo;
    }


    /**
     * Gets the numeroSerie value for this WsStructuraAccesorioDTO.
     * 
     * @return numeroSerie
     */
    public java.lang.String getNumeroSerie() {
        return numeroSerie;
    }


    /**
     * Sets the numeroSerie value for this WsStructuraAccesorioDTO.
     * 
     * @param numeroSerie
     */
    public void setNumeroSerie(java.lang.String numeroSerie) {
        this.numeroSerie = numeroSerie;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsStructuraAccesorioDTO)) return false;
        WsStructuraAccesorioDTO other = (WsStructuraAccesorioDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.cantidad==null && other.getCantidad()==null) || 
             (this.cantidad!=null &&
              this.cantidad.equals(other.getCantidad()))) &&
            ((this.codBodega==null && other.getCodBodega()==null) || 
             (this.codBodega!=null &&
              this.codBodega.equals(other.getCodBodega()))) &&
            ((this.codigoArticulo==null && other.getCodigoArticulo()==null) || 
             (this.codigoArticulo!=null &&
              this.codigoArticulo.equals(other.getCodigoArticulo()))) &&
            ((this.numeroSerie==null && other.getNumeroSerie()==null) || 
             (this.numeroSerie!=null &&
              this.numeroSerie.equals(other.getNumeroSerie())));
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
        if (getCantidad() != null) {
            _hashCode += getCantidad().hashCode();
        }
        if (getCodBodega() != null) {
            _hashCode += getCodBodega().hashCode();
        }
        if (getCodigoArticulo() != null) {
            _hashCode += getCodigoArticulo().hashCode();
        }
        if (getNumeroSerie() != null) {
            _hashCode += getNumeroSerie().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsStructuraAccesorioDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraAccesorioDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("cantidad");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Cantidad"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codBodega");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodBodega"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoArticulo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoArticulo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroSerie");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "NumeroSerie"));
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
