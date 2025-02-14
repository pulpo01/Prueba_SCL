/**
 * WsConsCargosVentaInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsConsCargosVentaInDTO  implements java.io.Serializable {
    private java.lang.String identificadorTransaccion;

    private java.lang.String nomUsuario;

    private java.lang.String numVenta;

    private java.lang.String obsFactVenta;

    public WsConsCargosVentaInDTO() {
    }

    public WsConsCargosVentaInDTO(
           java.lang.String identificadorTransaccion,
           java.lang.String nomUsuario,
           java.lang.String numVenta,
           java.lang.String obsFactVenta) {
           this.identificadorTransaccion = identificadorTransaccion;
           this.nomUsuario = nomUsuario;
           this.numVenta = numVenta;
           this.obsFactVenta = obsFactVenta;
    }


    /**
     * Gets the identificadorTransaccion value for this WsConsCargosVentaInDTO.
     * 
     * @return identificadorTransaccion
     */
    public java.lang.String getIdentificadorTransaccion() {
        return identificadorTransaccion;
    }


    /**
     * Sets the identificadorTransaccion value for this WsConsCargosVentaInDTO.
     * 
     * @param identificadorTransaccion
     */
    public void setIdentificadorTransaccion(java.lang.String identificadorTransaccion) {
        this.identificadorTransaccion = identificadorTransaccion;
    }


    /**
     * Gets the nomUsuario value for this WsConsCargosVentaInDTO.
     * 
     * @return nomUsuario
     */
    public java.lang.String getNomUsuario() {
        return nomUsuario;
    }


    /**
     * Sets the nomUsuario value for this WsConsCargosVentaInDTO.
     * 
     * @param nomUsuario
     */
    public void setNomUsuario(java.lang.String nomUsuario) {
        this.nomUsuario = nomUsuario;
    }


    /**
     * Gets the numVenta value for this WsConsCargosVentaInDTO.
     * 
     * @return numVenta
     */
    public java.lang.String getNumVenta() {
        return numVenta;
    }


    /**
     * Sets the numVenta value for this WsConsCargosVentaInDTO.
     * 
     * @param numVenta
     */
    public void setNumVenta(java.lang.String numVenta) {
        this.numVenta = numVenta;
    }


    /**
     * Gets the obsFactVenta value for this WsConsCargosVentaInDTO.
     * 
     * @return obsFactVenta
     */
    public java.lang.String getObsFactVenta() {
        return obsFactVenta;
    }


    /**
     * Sets the obsFactVenta value for this WsConsCargosVentaInDTO.
     * 
     * @param obsFactVenta
     */
    public void setObsFactVenta(java.lang.String obsFactVenta) {
        this.obsFactVenta = obsFactVenta;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsConsCargosVentaInDTO)) return false;
        WsConsCargosVentaInDTO other = (WsConsCargosVentaInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.identificadorTransaccion==null && other.getIdentificadorTransaccion()==null) || 
             (this.identificadorTransaccion!=null &&
              this.identificadorTransaccion.equals(other.getIdentificadorTransaccion()))) &&
            ((this.nomUsuario==null && other.getNomUsuario()==null) || 
             (this.nomUsuario!=null &&
              this.nomUsuario.equals(other.getNomUsuario()))) &&
            ((this.numVenta==null && other.getNumVenta()==null) || 
             (this.numVenta!=null &&
              this.numVenta.equals(other.getNumVenta()))) &&
            ((this.obsFactVenta==null && other.getObsFactVenta()==null) || 
             (this.obsFactVenta!=null &&
              this.obsFactVenta.equals(other.getObsFactVenta())));
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
        if (getIdentificadorTransaccion() != null) {
            _hashCode += getIdentificadorTransaccion().hashCode();
        }
        if (getNomUsuario() != null) {
            _hashCode += getNomUsuario().hashCode();
        }
        if (getNumVenta() != null) {
            _hashCode += getNumVenta().hashCode();
        }
        if (getObsFactVenta() != null) {
            _hashCode += getObsFactVenta().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsConsCargosVentaInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsConsCargosVentaInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("identificadorTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "IdentificadorTransaccion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomUsuario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NomUsuario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numVenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumVenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("obsFactVenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "ObsFactVenta"));
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
