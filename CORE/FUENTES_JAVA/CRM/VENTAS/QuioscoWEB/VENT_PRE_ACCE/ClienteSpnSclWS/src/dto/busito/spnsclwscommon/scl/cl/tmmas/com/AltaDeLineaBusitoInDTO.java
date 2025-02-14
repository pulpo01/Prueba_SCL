/**
 * AltaDeLineaBusitoInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.busito.spnsclwscommon.scl.cl.tmmas.com;

public class AltaDeLineaBusitoInDTO  implements java.io.Serializable {
    private java.lang.String codigoCliente;

    private java.lang.String codigoVendedor;

    private java.lang.String nomUsuario;

    private java.lang.String numeroSerieKit;

    public AltaDeLineaBusitoInDTO() {
    }

    public AltaDeLineaBusitoInDTO(
           java.lang.String codigoCliente,
           java.lang.String codigoVendedor,
           java.lang.String nomUsuario,
           java.lang.String numeroSerieKit) {
           this.codigoCliente = codigoCliente;
           this.codigoVendedor = codigoVendedor;
           this.nomUsuario = nomUsuario;
           this.numeroSerieKit = numeroSerieKit;
    }


    /**
     * Gets the codigoCliente value for this AltaDeLineaBusitoInDTO.
     * 
     * @return codigoCliente
     */
    public java.lang.String getCodigoCliente() {
        return codigoCliente;
    }


    /**
     * Sets the codigoCliente value for this AltaDeLineaBusitoInDTO.
     * 
     * @param codigoCliente
     */
    public void setCodigoCliente(java.lang.String codigoCliente) {
        this.codigoCliente = codigoCliente;
    }


    /**
     * Gets the codigoVendedor value for this AltaDeLineaBusitoInDTO.
     * 
     * @return codigoVendedor
     */
    public java.lang.String getCodigoVendedor() {
        return codigoVendedor;
    }


    /**
     * Sets the codigoVendedor value for this AltaDeLineaBusitoInDTO.
     * 
     * @param codigoVendedor
     */
    public void setCodigoVendedor(java.lang.String codigoVendedor) {
        this.codigoVendedor = codigoVendedor;
    }


    /**
     * Gets the nomUsuario value for this AltaDeLineaBusitoInDTO.
     * 
     * @return nomUsuario
     */
    public java.lang.String getNomUsuario() {
        return nomUsuario;
    }


    /**
     * Sets the nomUsuario value for this AltaDeLineaBusitoInDTO.
     * 
     * @param nomUsuario
     */
    public void setNomUsuario(java.lang.String nomUsuario) {
        this.nomUsuario = nomUsuario;
    }


    /**
     * Gets the numeroSerieKit value for this AltaDeLineaBusitoInDTO.
     * 
     * @return numeroSerieKit
     */
    public java.lang.String getNumeroSerieKit() {
        return numeroSerieKit;
    }


    /**
     * Sets the numeroSerieKit value for this AltaDeLineaBusitoInDTO.
     * 
     * @param numeroSerieKit
     */
    public void setNumeroSerieKit(java.lang.String numeroSerieKit) {
        this.numeroSerieKit = numeroSerieKit;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof AltaDeLineaBusitoInDTO)) return false;
        AltaDeLineaBusitoInDTO other = (AltaDeLineaBusitoInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoCliente==null && other.getCodigoCliente()==null) || 
             (this.codigoCliente!=null &&
              this.codigoCliente.equals(other.getCodigoCliente()))) &&
            ((this.codigoVendedor==null && other.getCodigoVendedor()==null) || 
             (this.codigoVendedor!=null &&
              this.codigoVendedor.equals(other.getCodigoVendedor()))) &&
            ((this.nomUsuario==null && other.getNomUsuario()==null) || 
             (this.nomUsuario!=null &&
              this.nomUsuario.equals(other.getNomUsuario()))) &&
            ((this.numeroSerieKit==null && other.getNumeroSerieKit()==null) || 
             (this.numeroSerieKit!=null &&
              this.numeroSerieKit.equals(other.getNumeroSerieKit())));
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
        if (getCodigoCliente() != null) {
            _hashCode += getCodigoCliente().hashCode();
        }
        if (getCodigoVendedor() != null) {
            _hashCode += getCodigoVendedor().hashCode();
        }
        if (getNomUsuario() != null) {
            _hashCode += getNomUsuario().hashCode();
        }
        if (getNumeroSerieKit() != null) {
            _hashCode += getNumeroSerieKit().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(AltaDeLineaBusitoInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.busito.dto", "AltaDeLineaBusitoInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.busito.dto", "CodigoCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoVendedor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.busito.dto", "CodigoVendedor"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomUsuario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.busito.dto", "NomUsuario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroSerieKit");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.busito.dto", "NumeroSerieKit"));
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
