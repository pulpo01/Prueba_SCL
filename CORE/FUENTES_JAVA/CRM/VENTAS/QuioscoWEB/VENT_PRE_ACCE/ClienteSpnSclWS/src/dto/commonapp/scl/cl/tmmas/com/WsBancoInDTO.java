/**
 * WsBancoInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsBancoInDTO  implements java.io.Serializable {
    private java.lang.String codBanco;

    private java.lang.String indicadorTipcuenta;

    private java.lang.String numeroCtacorr;

    private dto.commonapp.scl.cl.tmmas.com.WsSucursalBancoInDTO sucursal;

    private dto.commonapp.scl.cl.tmmas.com.WsTarjetaCreditoInDTO tarjeta;

    public WsBancoInDTO() {
    }

    public WsBancoInDTO(
           java.lang.String codBanco,
           java.lang.String indicadorTipcuenta,
           java.lang.String numeroCtacorr,
           dto.commonapp.scl.cl.tmmas.com.WsSucursalBancoInDTO sucursal,
           dto.commonapp.scl.cl.tmmas.com.WsTarjetaCreditoInDTO tarjeta) {
           this.codBanco = codBanco;
           this.indicadorTipcuenta = indicadorTipcuenta;
           this.numeroCtacorr = numeroCtacorr;
           this.sucursal = sucursal;
           this.tarjeta = tarjeta;
    }


    /**
     * Gets the codBanco value for this WsBancoInDTO.
     * 
     * @return codBanco
     */
    public java.lang.String getCodBanco() {
        return codBanco;
    }


    /**
     * Sets the codBanco value for this WsBancoInDTO.
     * 
     * @param codBanco
     */
    public void setCodBanco(java.lang.String codBanco) {
        this.codBanco = codBanco;
    }


    /**
     * Gets the indicadorTipcuenta value for this WsBancoInDTO.
     * 
     * @return indicadorTipcuenta
     */
    public java.lang.String getIndicadorTipcuenta() {
        return indicadorTipcuenta;
    }


    /**
     * Sets the indicadorTipcuenta value for this WsBancoInDTO.
     * 
     * @param indicadorTipcuenta
     */
    public void setIndicadorTipcuenta(java.lang.String indicadorTipcuenta) {
        this.indicadorTipcuenta = indicadorTipcuenta;
    }


    /**
     * Gets the numeroCtacorr value for this WsBancoInDTO.
     * 
     * @return numeroCtacorr
     */
    public java.lang.String getNumeroCtacorr() {
        return numeroCtacorr;
    }


    /**
     * Sets the numeroCtacorr value for this WsBancoInDTO.
     * 
     * @param numeroCtacorr
     */
    public void setNumeroCtacorr(java.lang.String numeroCtacorr) {
        this.numeroCtacorr = numeroCtacorr;
    }


    /**
     * Gets the sucursal value for this WsBancoInDTO.
     * 
     * @return sucursal
     */
    public dto.commonapp.scl.cl.tmmas.com.WsSucursalBancoInDTO getSucursal() {
        return sucursal;
    }


    /**
     * Sets the sucursal value for this WsBancoInDTO.
     * 
     * @param sucursal
     */
    public void setSucursal(dto.commonapp.scl.cl.tmmas.com.WsSucursalBancoInDTO sucursal) {
        this.sucursal = sucursal;
    }


    /**
     * Gets the tarjeta value for this WsBancoInDTO.
     * 
     * @return tarjeta
     */
    public dto.commonapp.scl.cl.tmmas.com.WsTarjetaCreditoInDTO getTarjeta() {
        return tarjeta;
    }


    /**
     * Sets the tarjeta value for this WsBancoInDTO.
     * 
     * @param tarjeta
     */
    public void setTarjeta(dto.commonapp.scl.cl.tmmas.com.WsTarjetaCreditoInDTO tarjeta) {
        this.tarjeta = tarjeta;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsBancoInDTO)) return false;
        WsBancoInDTO other = (WsBancoInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codBanco==null && other.getCodBanco()==null) || 
             (this.codBanco!=null &&
              this.codBanco.equals(other.getCodBanco()))) &&
            ((this.indicadorTipcuenta==null && other.getIndicadorTipcuenta()==null) || 
             (this.indicadorTipcuenta!=null &&
              this.indicadorTipcuenta.equals(other.getIndicadorTipcuenta()))) &&
            ((this.numeroCtacorr==null && other.getNumeroCtacorr()==null) || 
             (this.numeroCtacorr!=null &&
              this.numeroCtacorr.equals(other.getNumeroCtacorr()))) &&
            ((this.sucursal==null && other.getSucursal()==null) || 
             (this.sucursal!=null &&
              this.sucursal.equals(other.getSucursal()))) &&
            ((this.tarjeta==null && other.getTarjeta()==null) || 
             (this.tarjeta!=null &&
              this.tarjeta.equals(other.getTarjeta())));
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
        if (getCodBanco() != null) {
            _hashCode += getCodBanco().hashCode();
        }
        if (getIndicadorTipcuenta() != null) {
            _hashCode += getIndicadorTipcuenta().hashCode();
        }
        if (getNumeroCtacorr() != null) {
            _hashCode += getNumeroCtacorr().hashCode();
        }
        if (getSucursal() != null) {
            _hashCode += getSucursal().hashCode();
        }
        if (getTarjeta() != null) {
            _hashCode += getTarjeta().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsBancoInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBancoInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codBanco");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodBanco"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorTipcuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "IndicadorTipcuenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroCtacorr");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumeroCtacorr"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("sucursal");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Sucursal"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsSucursalBancoInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Tarjeta"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsTarjetaCreditoInDTO"));
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
