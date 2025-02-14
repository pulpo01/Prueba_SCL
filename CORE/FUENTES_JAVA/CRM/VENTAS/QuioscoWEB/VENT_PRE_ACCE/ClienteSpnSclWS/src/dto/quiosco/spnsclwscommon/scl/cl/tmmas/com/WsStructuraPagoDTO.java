/**
 * WsStructuraPagoDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.quiosco.spnsclwscommon.scl.cl.tmmas.com;

public class WsStructuraPagoDTO  implements java.io.Serializable {
    private java.lang.Boolean aplicapago;

    private java.lang.String codBanco;

    private java.lang.String codCajaQuiosco;

    private java.lang.String codTipTarjeta;

    private java.lang.String numCuentaCorriente;

    private java.lang.String numDocumento;

    private java.lang.String numTarjetaCredito;

    private java.lang.String sistemaPago;

    public WsStructuraPagoDTO() {
    }

    public WsStructuraPagoDTO(
           java.lang.Boolean aplicapago,
           java.lang.String codBanco,
           java.lang.String codCajaQuiosco,
           java.lang.String codTipTarjeta,
           java.lang.String numCuentaCorriente,
           java.lang.String numDocumento,
           java.lang.String numTarjetaCredito,
           java.lang.String sistemaPago) {
           this.aplicapago = aplicapago;
           this.codBanco = codBanco;
           this.codCajaQuiosco = codCajaQuiosco;
           this.codTipTarjeta = codTipTarjeta;
           this.numCuentaCorriente = numCuentaCorriente;
           this.numDocumento = numDocumento;
           this.numTarjetaCredito = numTarjetaCredito;
           this.sistemaPago = sistemaPago;
    }


    /**
     * Gets the aplicapago value for this WsStructuraPagoDTO.
     * 
     * @return aplicapago
     */
    public java.lang.Boolean getAplicapago() {
        return aplicapago;
    }


    /**
     * Sets the aplicapago value for this WsStructuraPagoDTO.
     * 
     * @param aplicapago
     */
    public void setAplicapago(java.lang.Boolean aplicapago) {
        this.aplicapago = aplicapago;
    }


    /**
     * Gets the codBanco value for this WsStructuraPagoDTO.
     * 
     * @return codBanco
     */
    public java.lang.String getCodBanco() {
        return codBanco;
    }


    /**
     * Sets the codBanco value for this WsStructuraPagoDTO.
     * 
     * @param codBanco
     */
    public void setCodBanco(java.lang.String codBanco) {
        this.codBanco = codBanco;
    }


    /**
     * Gets the codCajaQuiosco value for this WsStructuraPagoDTO.
     * 
     * @return codCajaQuiosco
     */
    public java.lang.String getCodCajaQuiosco() {
        return codCajaQuiosco;
    }


    /**
     * Sets the codCajaQuiosco value for this WsStructuraPagoDTO.
     * 
     * @param codCajaQuiosco
     */
    public void setCodCajaQuiosco(java.lang.String codCajaQuiosco) {
        this.codCajaQuiosco = codCajaQuiosco;
    }


    /**
     * Gets the codTipTarjeta value for this WsStructuraPagoDTO.
     * 
     * @return codTipTarjeta
     */
    public java.lang.String getCodTipTarjeta() {
        return codTipTarjeta;
    }


    /**
     * Sets the codTipTarjeta value for this WsStructuraPagoDTO.
     * 
     * @param codTipTarjeta
     */
    public void setCodTipTarjeta(java.lang.String codTipTarjeta) {
        this.codTipTarjeta = codTipTarjeta;
    }


    /**
     * Gets the numCuentaCorriente value for this WsStructuraPagoDTO.
     * 
     * @return numCuentaCorriente
     */
    public java.lang.String getNumCuentaCorriente() {
        return numCuentaCorriente;
    }


    /**
     * Sets the numCuentaCorriente value for this WsStructuraPagoDTO.
     * 
     * @param numCuentaCorriente
     */
    public void setNumCuentaCorriente(java.lang.String numCuentaCorriente) {
        this.numCuentaCorriente = numCuentaCorriente;
    }


    /**
     * Gets the numDocumento value for this WsStructuraPagoDTO.
     * 
     * @return numDocumento
     */
    public java.lang.String getNumDocumento() {
        return numDocumento;
    }


    /**
     * Sets the numDocumento value for this WsStructuraPagoDTO.
     * 
     * @param numDocumento
     */
    public void setNumDocumento(java.lang.String numDocumento) {
        this.numDocumento = numDocumento;
    }


    /**
     * Gets the numTarjetaCredito value for this WsStructuraPagoDTO.
     * 
     * @return numTarjetaCredito
     */
    public java.lang.String getNumTarjetaCredito() {
        return numTarjetaCredito;
    }


    /**
     * Sets the numTarjetaCredito value for this WsStructuraPagoDTO.
     * 
     * @param numTarjetaCredito
     */
    public void setNumTarjetaCredito(java.lang.String numTarjetaCredito) {
        this.numTarjetaCredito = numTarjetaCredito;
    }


    /**
     * Gets the sistemaPago value for this WsStructuraPagoDTO.
     * 
     * @return sistemaPago
     */
    public java.lang.String getSistemaPago() {
        return sistemaPago;
    }


    /**
     * Sets the sistemaPago value for this WsStructuraPagoDTO.
     * 
     * @param sistemaPago
     */
    public void setSistemaPago(java.lang.String sistemaPago) {
        this.sistemaPago = sistemaPago;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsStructuraPagoDTO)) return false;
        WsStructuraPagoDTO other = (WsStructuraPagoDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.aplicapago==null && other.getAplicapago()==null) || 
             (this.aplicapago!=null &&
              this.aplicapago.equals(other.getAplicapago()))) &&
            ((this.codBanco==null && other.getCodBanco()==null) || 
             (this.codBanco!=null &&
              this.codBanco.equals(other.getCodBanco()))) &&
            ((this.codCajaQuiosco==null && other.getCodCajaQuiosco()==null) || 
             (this.codCajaQuiosco!=null &&
              this.codCajaQuiosco.equals(other.getCodCajaQuiosco()))) &&
            ((this.codTipTarjeta==null && other.getCodTipTarjeta()==null) || 
             (this.codTipTarjeta!=null &&
              this.codTipTarjeta.equals(other.getCodTipTarjeta()))) &&
            ((this.numCuentaCorriente==null && other.getNumCuentaCorriente()==null) || 
             (this.numCuentaCorriente!=null &&
              this.numCuentaCorriente.equals(other.getNumCuentaCorriente()))) &&
            ((this.numDocumento==null && other.getNumDocumento()==null) || 
             (this.numDocumento!=null &&
              this.numDocumento.equals(other.getNumDocumento()))) &&
            ((this.numTarjetaCredito==null && other.getNumTarjetaCredito()==null) || 
             (this.numTarjetaCredito!=null &&
              this.numTarjetaCredito.equals(other.getNumTarjetaCredito()))) &&
            ((this.sistemaPago==null && other.getSistemaPago()==null) || 
             (this.sistemaPago!=null &&
              this.sistemaPago.equals(other.getSistemaPago())));
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
        if (getAplicapago() != null) {
            _hashCode += getAplicapago().hashCode();
        }
        if (getCodBanco() != null) {
            _hashCode += getCodBanco().hashCode();
        }
        if (getCodCajaQuiosco() != null) {
            _hashCode += getCodCajaQuiosco().hashCode();
        }
        if (getCodTipTarjeta() != null) {
            _hashCode += getCodTipTarjeta().hashCode();
        }
        if (getNumCuentaCorriente() != null) {
            _hashCode += getNumCuentaCorriente().hashCode();
        }
        if (getNumDocumento() != null) {
            _hashCode += getNumDocumento().hashCode();
        }
        if (getNumTarjetaCredito() != null) {
            _hashCode += getNumTarjetaCredito().hashCode();
        }
        if (getSistemaPago() != null) {
            _hashCode += getSistemaPago().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsStructuraPagoDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraPagoDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("aplicapago");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Aplicapago"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codBanco");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodBanco"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCajaQuiosco");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodCajaQuiosco"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codTipTarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodTipTarjeta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numCuentaCorriente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "NumCuentaCorriente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numDocumento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "NumDocumento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numTarjetaCredito");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "NumTarjetaCredito"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("sistemaPago");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "SistemaPago"));
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
