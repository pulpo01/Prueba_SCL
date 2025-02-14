/**
 * WsStructuraComercialOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.quiosco.spnsclwscommon.scl.cl.tmmas.com;

public class WsStructuraComercialOutDTO  implements java.io.Serializable {
    private java.lang.String codigoCliente;

    private dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] errores;

    private dto.commonapp.scl.cl.tmmas.com.WsLineaOutDTO[] lineaOut;

    private java.lang.String numVenta;

    private byte[] pdfAsBytes;

    private java.lang.String procesoFacturacion;

    private java.lang.String resultadoTransaccion;

    public WsStructuraComercialOutDTO() {
    }

    public WsStructuraComercialOutDTO(
           java.lang.String codigoCliente,
           dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] errores,
           dto.commonapp.scl.cl.tmmas.com.WsLineaOutDTO[] lineaOut,
           java.lang.String numVenta,
           byte[] pdfAsBytes,
           java.lang.String procesoFacturacion,
           java.lang.String resultadoTransaccion) {
           this.codigoCliente = codigoCliente;
           this.errores = errores;
           this.lineaOut = lineaOut;
           this.numVenta = numVenta;
           this.pdfAsBytes = pdfAsBytes;
           this.procesoFacturacion = procesoFacturacion;
           this.resultadoTransaccion = resultadoTransaccion;
    }


    /**
     * Gets the codigoCliente value for this WsStructuraComercialOutDTO.
     * 
     * @return codigoCliente
     */
    public java.lang.String getCodigoCliente() {
        return codigoCliente;
    }


    /**
     * Sets the codigoCliente value for this WsStructuraComercialOutDTO.
     * 
     * @param codigoCliente
     */
    public void setCodigoCliente(java.lang.String codigoCliente) {
        this.codigoCliente = codigoCliente;
    }


    /**
     * Gets the errores value for this WsStructuraComercialOutDTO.
     * 
     * @return errores
     */
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] getErrores() {
        return errores;
    }


    /**
     * Sets the errores value for this WsStructuraComercialOutDTO.
     * 
     * @param errores
     */
    public void setErrores(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO[] errores) {
        this.errores = errores;
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO getErrores(int i) {
        return this.errores[i];
    }

    public void setErrores(int i, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO _value) {
        this.errores[i] = _value;
    }


    /**
     * Gets the lineaOut value for this WsStructuraComercialOutDTO.
     * 
     * @return lineaOut
     */
    public dto.commonapp.scl.cl.tmmas.com.WsLineaOutDTO[] getLineaOut() {
        return lineaOut;
    }


    /**
     * Sets the lineaOut value for this WsStructuraComercialOutDTO.
     * 
     * @param lineaOut
     */
    public void setLineaOut(dto.commonapp.scl.cl.tmmas.com.WsLineaOutDTO[] lineaOut) {
        this.lineaOut = lineaOut;
    }

    public dto.commonapp.scl.cl.tmmas.com.WsLineaOutDTO getLineaOut(int i) {
        return this.lineaOut[i];
    }

    public void setLineaOut(int i, dto.commonapp.scl.cl.tmmas.com.WsLineaOutDTO _value) {
        this.lineaOut[i] = _value;
    }


    /**
     * Gets the numVenta value for this WsStructuraComercialOutDTO.
     * 
     * @return numVenta
     */
    public java.lang.String getNumVenta() {
        return numVenta;
    }


    /**
     * Sets the numVenta value for this WsStructuraComercialOutDTO.
     * 
     * @param numVenta
     */
    public void setNumVenta(java.lang.String numVenta) {
        this.numVenta = numVenta;
    }


    /**
     * Gets the pdfAsBytes value for this WsStructuraComercialOutDTO.
     * 
     * @return pdfAsBytes
     */
    public byte[] getPdfAsBytes() {
        return pdfAsBytes;
    }


    /**
     * Sets the pdfAsBytes value for this WsStructuraComercialOutDTO.
     * 
     * @param pdfAsBytes
     */
    public void setPdfAsBytes(byte[] pdfAsBytes) {
        this.pdfAsBytes = pdfAsBytes;
    }


    /**
     * Gets the procesoFacturacion value for this WsStructuraComercialOutDTO.
     * 
     * @return procesoFacturacion
     */
    public java.lang.String getProcesoFacturacion() {
        return procesoFacturacion;
    }


    /**
     * Sets the procesoFacturacion value for this WsStructuraComercialOutDTO.
     * 
     * @param procesoFacturacion
     */
    public void setProcesoFacturacion(java.lang.String procesoFacturacion) {
        this.procesoFacturacion = procesoFacturacion;
    }


    /**
     * Gets the resultadoTransaccion value for this WsStructuraComercialOutDTO.
     * 
     * @return resultadoTransaccion
     */
    public java.lang.String getResultadoTransaccion() {
        return resultadoTransaccion;
    }


    /**
     * Sets the resultadoTransaccion value for this WsStructuraComercialOutDTO.
     * 
     * @param resultadoTransaccion
     */
    public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
        this.resultadoTransaccion = resultadoTransaccion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsStructuraComercialOutDTO)) return false;
        WsStructuraComercialOutDTO other = (WsStructuraComercialOutDTO) obj;
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
            ((this.errores==null && other.getErrores()==null) || 
             (this.errores!=null &&
              java.util.Arrays.equals(this.errores, other.getErrores()))) &&
            ((this.lineaOut==null && other.getLineaOut()==null) || 
             (this.lineaOut!=null &&
              java.util.Arrays.equals(this.lineaOut, other.getLineaOut()))) &&
            ((this.numVenta==null && other.getNumVenta()==null) || 
             (this.numVenta!=null &&
              this.numVenta.equals(other.getNumVenta()))) &&
            ((this.pdfAsBytes==null && other.getPdfAsBytes()==null) || 
             (this.pdfAsBytes!=null &&
              java.util.Arrays.equals(this.pdfAsBytes, other.getPdfAsBytes()))) &&
            ((this.procesoFacturacion==null && other.getProcesoFacturacion()==null) || 
             (this.procesoFacturacion!=null &&
              this.procesoFacturacion.equals(other.getProcesoFacturacion()))) &&
            ((this.resultadoTransaccion==null && other.getResultadoTransaccion()==null) || 
             (this.resultadoTransaccion!=null &&
              this.resultadoTransaccion.equals(other.getResultadoTransaccion())));
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
        if (getErrores() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getErrores());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getErrores(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getLineaOut() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getLineaOut());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getLineaOut(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getNumVenta() != null) {
            _hashCode += getNumVenta().hashCode();
        }
        if (getPdfAsBytes() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getPdfAsBytes());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getPdfAsBytes(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getProcesoFacturacion() != null) {
            _hashCode += getProcesoFacturacion().hashCode();
        }
        if (getResultadoTransaccion() != null) {
            _hashCode += getResultadoTransaccion().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsStructuraComercialOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraComercialOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("errores");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Errores"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RetornoDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("lineaOut");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "LineaOut"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsLineaOutDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numVenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "NumVenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("pdfAsBytes");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "PdfAsBytes"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("procesoFacturacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "ProcesoFacturacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("resultadoTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "ResultadoTransaccion"));
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
