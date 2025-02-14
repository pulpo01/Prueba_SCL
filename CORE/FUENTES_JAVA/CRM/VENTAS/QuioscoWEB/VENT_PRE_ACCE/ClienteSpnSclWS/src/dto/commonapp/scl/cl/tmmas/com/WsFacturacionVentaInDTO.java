/**
 * WsFacturacionVentaInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsFacturacionVentaInDTO  implements java.io.Serializable {
    private dto.commonapp.scl.cl.tmmas.com.WsFacturacionLineaDTO[] facturacionLinea;

    private java.lang.String identificadorTransaccion;

    private java.lang.String nomUsuario;

    private java.lang.String numVenta;

    private java.lang.String obsFactVenta;

    private boolean facturaACiclo;

    public WsFacturacionVentaInDTO() {
    }

    public WsFacturacionVentaInDTO(
           dto.commonapp.scl.cl.tmmas.com.WsFacturacionLineaDTO[] facturacionLinea,
           java.lang.String identificadorTransaccion,
           java.lang.String nomUsuario,
           java.lang.String numVenta,
           java.lang.String obsFactVenta,
           boolean facturaACiclo) {
           this.facturacionLinea = facturacionLinea;
           this.identificadorTransaccion = identificadorTransaccion;
           this.nomUsuario = nomUsuario;
           this.numVenta = numVenta;
           this.obsFactVenta = obsFactVenta;
           this.facturaACiclo = facturaACiclo;
    }


    /**
     * Gets the facturacionLinea value for this WsFacturacionVentaInDTO.
     * 
     * @return facturacionLinea
     */
    public dto.commonapp.scl.cl.tmmas.com.WsFacturacionLineaDTO[] getFacturacionLinea() {
        return facturacionLinea;
    }


    /**
     * Sets the facturacionLinea value for this WsFacturacionVentaInDTO.
     * 
     * @param facturacionLinea
     */
    public void setFacturacionLinea(dto.commonapp.scl.cl.tmmas.com.WsFacturacionLineaDTO[] facturacionLinea) {
        this.facturacionLinea = facturacionLinea;
    }

    public dto.commonapp.scl.cl.tmmas.com.WsFacturacionLineaDTO getFacturacionLinea(int i) {
        return this.facturacionLinea[i];
    }

    public void setFacturacionLinea(int i, dto.commonapp.scl.cl.tmmas.com.WsFacturacionLineaDTO _value) {
        this.facturacionLinea[i] = _value;
    }


    /**
     * Gets the identificadorTransaccion value for this WsFacturacionVentaInDTO.
     * 
     * @return identificadorTransaccion
     */
    public java.lang.String getIdentificadorTransaccion() {
        return identificadorTransaccion;
    }


    /**
     * Sets the identificadorTransaccion value for this WsFacturacionVentaInDTO.
     * 
     * @param identificadorTransaccion
     */
    public void setIdentificadorTransaccion(java.lang.String identificadorTransaccion) {
        this.identificadorTransaccion = identificadorTransaccion;
    }


    /**
     * Gets the nomUsuario value for this WsFacturacionVentaInDTO.
     * 
     * @return nomUsuario
     */
    public java.lang.String getNomUsuario() {
        return nomUsuario;
    }


    /**
     * Sets the nomUsuario value for this WsFacturacionVentaInDTO.
     * 
     * @param nomUsuario
     */
    public void setNomUsuario(java.lang.String nomUsuario) {
        this.nomUsuario = nomUsuario;
    }


    /**
     * Gets the numVenta value for this WsFacturacionVentaInDTO.
     * 
     * @return numVenta
     */
    public java.lang.String getNumVenta() {
        return numVenta;
    }


    /**
     * Sets the numVenta value for this WsFacturacionVentaInDTO.
     * 
     * @param numVenta
     */
    public void setNumVenta(java.lang.String numVenta) {
        this.numVenta = numVenta;
    }


    /**
     * Gets the obsFactVenta value for this WsFacturacionVentaInDTO.
     * 
     * @return obsFactVenta
     */
    public java.lang.String getObsFactVenta() {
        return obsFactVenta;
    }


    /**
     * Sets the obsFactVenta value for this WsFacturacionVentaInDTO.
     * 
     * @param obsFactVenta
     */
    public void setObsFactVenta(java.lang.String obsFactVenta) {
        this.obsFactVenta = obsFactVenta;
    }


    /**
     * Gets the facturaACiclo value for this WsFacturacionVentaInDTO.
     * 
     * @return facturaACiclo
     */
    public boolean isFacturaACiclo() {
        return facturaACiclo;
    }


    /**
     * Sets the facturaACiclo value for this WsFacturacionVentaInDTO.
     * 
     * @param facturaACiclo
     */
    public void setFacturaACiclo(boolean facturaACiclo) {
        this.facturaACiclo = facturaACiclo;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsFacturacionVentaInDTO)) return false;
        WsFacturacionVentaInDTO other = (WsFacturacionVentaInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.facturacionLinea==null && other.getFacturacionLinea()==null) || 
             (this.facturacionLinea!=null &&
              java.util.Arrays.equals(this.facturacionLinea, other.getFacturacionLinea()))) &&
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
              this.obsFactVenta.equals(other.getObsFactVenta()))) &&
            this.facturaACiclo == other.isFacturaACiclo();
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
        if (getFacturacionLinea() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getFacturacionLinea());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getFacturacionLinea(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
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
        _hashCode += (isFacturaACiclo() ? Boolean.TRUE : Boolean.FALSE).hashCode();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsFacturacionVentaInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsFacturacionVentaInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("facturacionLinea");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "FacturacionLinea"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsFacturacionLineaDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
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
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("facturaACiclo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "FacturaACiclo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        elemField.setNillable(false);
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
