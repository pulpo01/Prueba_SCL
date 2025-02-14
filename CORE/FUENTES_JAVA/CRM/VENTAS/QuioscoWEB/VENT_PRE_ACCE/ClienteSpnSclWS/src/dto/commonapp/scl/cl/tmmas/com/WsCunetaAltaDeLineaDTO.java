/**
 * WsCunetaAltaDeLineaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsCunetaAltaDeLineaDTO  implements java.io.Serializable {
    private java.lang.String codigoDeCliente;

    private java.lang.String codigoDeCuenta;

    private java.lang.String identificadorTransaccion;

    private dto.commonapp.scl.cl.tmmas.com.WsActivacionLineaDTO linea;

    private java.lang.String nomUsuarioOra;

    public WsCunetaAltaDeLineaDTO() {
    }

    public WsCunetaAltaDeLineaDTO(
           java.lang.String codigoDeCliente,
           java.lang.String codigoDeCuenta,
           java.lang.String identificadorTransaccion,
           dto.commonapp.scl.cl.tmmas.com.WsActivacionLineaDTO linea,
           java.lang.String nomUsuarioOra) {
           this.codigoDeCliente = codigoDeCliente;
           this.codigoDeCuenta = codigoDeCuenta;
           this.identificadorTransaccion = identificadorTransaccion;
           this.linea = linea;
           this.nomUsuarioOra = nomUsuarioOra;
    }


    /**
     * Gets the codigoDeCliente value for this WsCunetaAltaDeLineaDTO.
     * 
     * @return codigoDeCliente
     */
    public java.lang.String getCodigoDeCliente() {
        return codigoDeCliente;
    }


    /**
     * Sets the codigoDeCliente value for this WsCunetaAltaDeLineaDTO.
     * 
     * @param codigoDeCliente
     */
    public void setCodigoDeCliente(java.lang.String codigoDeCliente) {
        this.codigoDeCliente = codigoDeCliente;
    }


    /**
     * Gets the codigoDeCuenta value for this WsCunetaAltaDeLineaDTO.
     * 
     * @return codigoDeCuenta
     */
    public java.lang.String getCodigoDeCuenta() {
        return codigoDeCuenta;
    }


    /**
     * Sets the codigoDeCuenta value for this WsCunetaAltaDeLineaDTO.
     * 
     * @param codigoDeCuenta
     */
    public void setCodigoDeCuenta(java.lang.String codigoDeCuenta) {
        this.codigoDeCuenta = codigoDeCuenta;
    }


    /**
     * Gets the identificadorTransaccion value for this WsCunetaAltaDeLineaDTO.
     * 
     * @return identificadorTransaccion
     */
    public java.lang.String getIdentificadorTransaccion() {
        return identificadorTransaccion;
    }


    /**
     * Sets the identificadorTransaccion value for this WsCunetaAltaDeLineaDTO.
     * 
     * @param identificadorTransaccion
     */
    public void setIdentificadorTransaccion(java.lang.String identificadorTransaccion) {
        this.identificadorTransaccion = identificadorTransaccion;
    }


    /**
     * Gets the linea value for this WsCunetaAltaDeLineaDTO.
     * 
     * @return linea
     */
    public dto.commonapp.scl.cl.tmmas.com.WsActivacionLineaDTO getLinea() {
        return linea;
    }


    /**
     * Sets the linea value for this WsCunetaAltaDeLineaDTO.
     * 
     * @param linea
     */
    public void setLinea(dto.commonapp.scl.cl.tmmas.com.WsActivacionLineaDTO linea) {
        this.linea = linea;
    }


    /**
     * Gets the nomUsuarioOra value for this WsCunetaAltaDeLineaDTO.
     * 
     * @return nomUsuarioOra
     */
    public java.lang.String getNomUsuarioOra() {
        return nomUsuarioOra;
    }


    /**
     * Sets the nomUsuarioOra value for this WsCunetaAltaDeLineaDTO.
     * 
     * @param nomUsuarioOra
     */
    public void setNomUsuarioOra(java.lang.String nomUsuarioOra) {
        this.nomUsuarioOra = nomUsuarioOra;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsCunetaAltaDeLineaDTO)) return false;
        WsCunetaAltaDeLineaDTO other = (WsCunetaAltaDeLineaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoDeCliente==null && other.getCodigoDeCliente()==null) || 
             (this.codigoDeCliente!=null &&
              this.codigoDeCliente.equals(other.getCodigoDeCliente()))) &&
            ((this.codigoDeCuenta==null && other.getCodigoDeCuenta()==null) || 
             (this.codigoDeCuenta!=null &&
              this.codigoDeCuenta.equals(other.getCodigoDeCuenta()))) &&
            ((this.identificadorTransaccion==null && other.getIdentificadorTransaccion()==null) || 
             (this.identificadorTransaccion!=null &&
              this.identificadorTransaccion.equals(other.getIdentificadorTransaccion()))) &&
            ((this.linea==null && other.getLinea()==null) || 
             (this.linea!=null &&
              this.linea.equals(other.getLinea()))) &&
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
        if (getCodigoDeCliente() != null) {
            _hashCode += getCodigoDeCliente().hashCode();
        }
        if (getCodigoDeCuenta() != null) {
            _hashCode += getCodigoDeCuenta().hashCode();
        }
        if (getIdentificadorTransaccion() != null) {
            _hashCode += getIdentificadorTransaccion().hashCode();
        }
        if (getLinea() != null) {
            _hashCode += getLinea().hashCode();
        }
        if (getNomUsuarioOra() != null) {
            _hashCode += getNomUsuarioOra().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsCunetaAltaDeLineaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsCunetaAltaDeLineaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoDeCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoDeCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoDeCuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoDeCuenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("identificadorTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "IdentificadorTransaccion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("linea");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Linea"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsActivacionLineaDTO"));
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
