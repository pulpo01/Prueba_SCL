/**
 * WsAntecedentesVentaInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsAntecedentesVentaInDTO  implements java.io.Serializable {
    private java.lang.String codigoDealer;

    private java.lang.String codigoModalidadVenta;

    private java.lang.String codigoReserva;

    private java.lang.String codigoTipoContrato;

    private java.lang.String codigoVendedor;

    private java.lang.String cuotas;

    public WsAntecedentesVentaInDTO() {
    }

    public WsAntecedentesVentaInDTO(
           java.lang.String codigoDealer,
           java.lang.String codigoModalidadVenta,
           java.lang.String codigoReserva,
           java.lang.String codigoTipoContrato,
           java.lang.String codigoVendedor,
           java.lang.String cuotas) {
           this.codigoDealer = codigoDealer;
           this.codigoModalidadVenta = codigoModalidadVenta;
           this.codigoReserva = codigoReserva;
           this.codigoTipoContrato = codigoTipoContrato;
           this.codigoVendedor = codigoVendedor;
           this.cuotas = cuotas;
    }


    /**
     * Gets the codigoDealer value for this WsAntecedentesVentaInDTO.
     * 
     * @return codigoDealer
     */
    public java.lang.String getCodigoDealer() {
        return codigoDealer;
    }


    /**
     * Sets the codigoDealer value for this WsAntecedentesVentaInDTO.
     * 
     * @param codigoDealer
     */
    public void setCodigoDealer(java.lang.String codigoDealer) {
        this.codigoDealer = codigoDealer;
    }


    /**
     * Gets the codigoModalidadVenta value for this WsAntecedentesVentaInDTO.
     * 
     * @return codigoModalidadVenta
     */
    public java.lang.String getCodigoModalidadVenta() {
        return codigoModalidadVenta;
    }


    /**
     * Sets the codigoModalidadVenta value for this WsAntecedentesVentaInDTO.
     * 
     * @param codigoModalidadVenta
     */
    public void setCodigoModalidadVenta(java.lang.String codigoModalidadVenta) {
        this.codigoModalidadVenta = codigoModalidadVenta;
    }


    /**
     * Gets the codigoReserva value for this WsAntecedentesVentaInDTO.
     * 
     * @return codigoReserva
     */
    public java.lang.String getCodigoReserva() {
        return codigoReserva;
    }


    /**
     * Sets the codigoReserva value for this WsAntecedentesVentaInDTO.
     * 
     * @param codigoReserva
     */
    public void setCodigoReserva(java.lang.String codigoReserva) {
        this.codigoReserva = codigoReserva;
    }


    /**
     * Gets the codigoTipoContrato value for this WsAntecedentesVentaInDTO.
     * 
     * @return codigoTipoContrato
     */
    public java.lang.String getCodigoTipoContrato() {
        return codigoTipoContrato;
    }


    /**
     * Sets the codigoTipoContrato value for this WsAntecedentesVentaInDTO.
     * 
     * @param codigoTipoContrato
     */
    public void setCodigoTipoContrato(java.lang.String codigoTipoContrato) {
        this.codigoTipoContrato = codigoTipoContrato;
    }


    /**
     * Gets the codigoVendedor value for this WsAntecedentesVentaInDTO.
     * 
     * @return codigoVendedor
     */
    public java.lang.String getCodigoVendedor() {
        return codigoVendedor;
    }


    /**
     * Sets the codigoVendedor value for this WsAntecedentesVentaInDTO.
     * 
     * @param codigoVendedor
     */
    public void setCodigoVendedor(java.lang.String codigoVendedor) {
        this.codigoVendedor = codigoVendedor;
    }


    /**
     * Gets the cuotas value for this WsAntecedentesVentaInDTO.
     * 
     * @return cuotas
     */
    public java.lang.String getCuotas() {
        return cuotas;
    }


    /**
     * Sets the cuotas value for this WsAntecedentesVentaInDTO.
     * 
     * @param cuotas
     */
    public void setCuotas(java.lang.String cuotas) {
        this.cuotas = cuotas;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsAntecedentesVentaInDTO)) return false;
        WsAntecedentesVentaInDTO other = (WsAntecedentesVentaInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoDealer==null && other.getCodigoDealer()==null) || 
             (this.codigoDealer!=null &&
              this.codigoDealer.equals(other.getCodigoDealer()))) &&
            ((this.codigoModalidadVenta==null && other.getCodigoModalidadVenta()==null) || 
             (this.codigoModalidadVenta!=null &&
              this.codigoModalidadVenta.equals(other.getCodigoModalidadVenta()))) &&
            ((this.codigoReserva==null && other.getCodigoReserva()==null) || 
             (this.codigoReserva!=null &&
              this.codigoReserva.equals(other.getCodigoReserva()))) &&
            ((this.codigoTipoContrato==null && other.getCodigoTipoContrato()==null) || 
             (this.codigoTipoContrato!=null &&
              this.codigoTipoContrato.equals(other.getCodigoTipoContrato()))) &&
            ((this.codigoVendedor==null && other.getCodigoVendedor()==null) || 
             (this.codigoVendedor!=null &&
              this.codigoVendedor.equals(other.getCodigoVendedor()))) &&
            ((this.cuotas==null && other.getCuotas()==null) || 
             (this.cuotas!=null &&
              this.cuotas.equals(other.getCuotas())));
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
        if (getCodigoDealer() != null) {
            _hashCode += getCodigoDealer().hashCode();
        }
        if (getCodigoModalidadVenta() != null) {
            _hashCode += getCodigoModalidadVenta().hashCode();
        }
        if (getCodigoReserva() != null) {
            _hashCode += getCodigoReserva().hashCode();
        }
        if (getCodigoTipoContrato() != null) {
            _hashCode += getCodigoTipoContrato().hashCode();
        }
        if (getCodigoVendedor() != null) {
            _hashCode += getCodigoVendedor().hashCode();
        }
        if (getCuotas() != null) {
            _hashCode += getCuotas().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsAntecedentesVentaInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAntecedentesVentaInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoDealer");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoDealer"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoModalidadVenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoModalidadVenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoReserva");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoReserva"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoContrato");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoTipoContrato"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoVendedor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoVendedor"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("cuotas");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Cuotas"));
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
