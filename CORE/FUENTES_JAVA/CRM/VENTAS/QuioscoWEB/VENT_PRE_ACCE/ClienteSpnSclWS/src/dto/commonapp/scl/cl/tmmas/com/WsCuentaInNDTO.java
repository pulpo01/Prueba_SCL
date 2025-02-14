/**
 * WsCuentaInNDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsCuentaInNDTO  implements java.io.Serializable {
    private dto.commonapp.scl.cl.tmmas.com.WsClienteInDTO clienteDTO;

    private java.lang.String codigoCuenta;

    private java.lang.String nomUsuarioOra;

    public WsCuentaInNDTO() {
    }

    public WsCuentaInNDTO(
           dto.commonapp.scl.cl.tmmas.com.WsClienteInDTO clienteDTO,
           java.lang.String codigoCuenta,
           java.lang.String nomUsuarioOra) {
           this.clienteDTO = clienteDTO;
           this.codigoCuenta = codigoCuenta;
           this.nomUsuarioOra = nomUsuarioOra;
    }


    /**
     * Gets the clienteDTO value for this WsCuentaInNDTO.
     * 
     * @return clienteDTO
     */
    public dto.commonapp.scl.cl.tmmas.com.WsClienteInDTO getClienteDTO() {
        return clienteDTO;
    }


    /**
     * Sets the clienteDTO value for this WsCuentaInNDTO.
     * 
     * @param clienteDTO
     */
    public void setClienteDTO(dto.commonapp.scl.cl.tmmas.com.WsClienteInDTO clienteDTO) {
        this.clienteDTO = clienteDTO;
    }


    /**
     * Gets the codigoCuenta value for this WsCuentaInNDTO.
     * 
     * @return codigoCuenta
     */
    public java.lang.String getCodigoCuenta() {
        return codigoCuenta;
    }


    /**
     * Sets the codigoCuenta value for this WsCuentaInNDTO.
     * 
     * @param codigoCuenta
     */
    public void setCodigoCuenta(java.lang.String codigoCuenta) {
        this.codigoCuenta = codigoCuenta;
    }


    /**
     * Gets the nomUsuarioOra value for this WsCuentaInNDTO.
     * 
     * @return nomUsuarioOra
     */
    public java.lang.String getNomUsuarioOra() {
        return nomUsuarioOra;
    }


    /**
     * Sets the nomUsuarioOra value for this WsCuentaInNDTO.
     * 
     * @param nomUsuarioOra
     */
    public void setNomUsuarioOra(java.lang.String nomUsuarioOra) {
        this.nomUsuarioOra = nomUsuarioOra;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsCuentaInNDTO)) return false;
        WsCuentaInNDTO other = (WsCuentaInNDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.clienteDTO==null && other.getClienteDTO()==null) || 
             (this.clienteDTO!=null &&
              this.clienteDTO.equals(other.getClienteDTO()))) &&
            ((this.codigoCuenta==null && other.getCodigoCuenta()==null) || 
             (this.codigoCuenta!=null &&
              this.codigoCuenta.equals(other.getCodigoCuenta()))) &&
            ((this.nomUsuarioOra==null && other.getNomUsuarioOra()==null) || 
             (this.nomUsuarioOra!=null &&
              this.nomUsuarioOra.equals(other.getNomUsuarioOra())));
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
        if (getClienteDTO() != null) {
            _hashCode += getClienteDTO().hashCode();
        }
        if (getCodigoCuenta() != null) {
            _hashCode += getCodigoCuenta().hashCode();
        }
        if (getNomUsuarioOra() != null) {
            _hashCode += getNomUsuarioOra().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsCuentaInNDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsCuentaInNDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("clienteDTO");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "ClienteDTO"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsClienteInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoCuenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomUsuarioOra");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NomUsuarioOra"));
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
