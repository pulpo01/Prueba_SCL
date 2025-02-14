/**
 * DescuentoDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dataTransferObject.customerDomain.framework.scl.tmmas.com;

public class DescuentoDTO  implements java.io.Serializable {
    private java.lang.String codigoConcepto;

    private java.lang.String codigoConceptoCargo;

    private java.lang.String codigoMoneda;

    private java.lang.String descripcionConcepto;

    private float maxDescuento;

    private float minDescuento;

    private float monto;

    private float montoCalculado;

    private java.lang.String numTransaccion;

    private java.lang.String tipo;

    private java.lang.String tipoAplicacion;

    private boolean aprobacion;

    public DescuentoDTO() {
    }

    public DescuentoDTO(
           java.lang.String codigoConcepto,
           java.lang.String codigoConceptoCargo,
           java.lang.String codigoMoneda,
           java.lang.String descripcionConcepto,
           float maxDescuento,
           float minDescuento,
           float monto,
           float montoCalculado,
           java.lang.String numTransaccion,
           java.lang.String tipo,
           java.lang.String tipoAplicacion,
           boolean aprobacion) {
           this.codigoConcepto = codigoConcepto;
           this.codigoConceptoCargo = codigoConceptoCargo;
           this.codigoMoneda = codigoMoneda;
           this.descripcionConcepto = descripcionConcepto;
           this.maxDescuento = maxDescuento;
           this.minDescuento = minDescuento;
           this.monto = monto;
           this.montoCalculado = montoCalculado;
           this.numTransaccion = numTransaccion;
           this.tipo = tipo;
           this.tipoAplicacion = tipoAplicacion;
           this.aprobacion = aprobacion;
    }


    /**
     * Gets the codigoConcepto value for this DescuentoDTO.
     * 
     * @return codigoConcepto
     */
    public java.lang.String getCodigoConcepto() {
        return codigoConcepto;
    }


    /**
     * Sets the codigoConcepto value for this DescuentoDTO.
     * 
     * @param codigoConcepto
     */
    public void setCodigoConcepto(java.lang.String codigoConcepto) {
        this.codigoConcepto = codigoConcepto;
    }


    /**
     * Gets the codigoConceptoCargo value for this DescuentoDTO.
     * 
     * @return codigoConceptoCargo
     */
    public java.lang.String getCodigoConceptoCargo() {
        return codigoConceptoCargo;
    }


    /**
     * Sets the codigoConceptoCargo value for this DescuentoDTO.
     * 
     * @param codigoConceptoCargo
     */
    public void setCodigoConceptoCargo(java.lang.String codigoConceptoCargo) {
        this.codigoConceptoCargo = codigoConceptoCargo;
    }


    /**
     * Gets the codigoMoneda value for this DescuentoDTO.
     * 
     * @return codigoMoneda
     */
    public java.lang.String getCodigoMoneda() {
        return codigoMoneda;
    }


    /**
     * Sets the codigoMoneda value for this DescuentoDTO.
     * 
     * @param codigoMoneda
     */
    public void setCodigoMoneda(java.lang.String codigoMoneda) {
        this.codigoMoneda = codigoMoneda;
    }


    /**
     * Gets the descripcionConcepto value for this DescuentoDTO.
     * 
     * @return descripcionConcepto
     */
    public java.lang.String getDescripcionConcepto() {
        return descripcionConcepto;
    }


    /**
     * Sets the descripcionConcepto value for this DescuentoDTO.
     * 
     * @param descripcionConcepto
     */
    public void setDescripcionConcepto(java.lang.String descripcionConcepto) {
        this.descripcionConcepto = descripcionConcepto;
    }


    /**
     * Gets the maxDescuento value for this DescuentoDTO.
     * 
     * @return maxDescuento
     */
    public float getMaxDescuento() {
        return maxDescuento;
    }


    /**
     * Sets the maxDescuento value for this DescuentoDTO.
     * 
     * @param maxDescuento
     */
    public void setMaxDescuento(float maxDescuento) {
        this.maxDescuento = maxDescuento;
    }


    /**
     * Gets the minDescuento value for this DescuentoDTO.
     * 
     * @return minDescuento
     */
    public float getMinDescuento() {
        return minDescuento;
    }


    /**
     * Sets the minDescuento value for this DescuentoDTO.
     * 
     * @param minDescuento
     */
    public void setMinDescuento(float minDescuento) {
        this.minDescuento = minDescuento;
    }


    /**
     * Gets the monto value for this DescuentoDTO.
     * 
     * @return monto
     */
    public float getMonto() {
        return monto;
    }


    /**
     * Sets the monto value for this DescuentoDTO.
     * 
     * @param monto
     */
    public void setMonto(float monto) {
        this.monto = monto;
    }


    /**
     * Gets the montoCalculado value for this DescuentoDTO.
     * 
     * @return montoCalculado
     */
    public float getMontoCalculado() {
        return montoCalculado;
    }


    /**
     * Sets the montoCalculado value for this DescuentoDTO.
     * 
     * @param montoCalculado
     */
    public void setMontoCalculado(float montoCalculado) {
        this.montoCalculado = montoCalculado;
    }


    /**
     * Gets the numTransaccion value for this DescuentoDTO.
     * 
     * @return numTransaccion
     */
    public java.lang.String getNumTransaccion() {
        return numTransaccion;
    }


    /**
     * Sets the numTransaccion value for this DescuentoDTO.
     * 
     * @param numTransaccion
     */
    public void setNumTransaccion(java.lang.String numTransaccion) {
        this.numTransaccion = numTransaccion;
    }


    /**
     * Gets the tipo value for this DescuentoDTO.
     * 
     * @return tipo
     */
    public java.lang.String getTipo() {
        return tipo;
    }


    /**
     * Sets the tipo value for this DescuentoDTO.
     * 
     * @param tipo
     */
    public void setTipo(java.lang.String tipo) {
        this.tipo = tipo;
    }


    /**
     * Gets the tipoAplicacion value for this DescuentoDTO.
     * 
     * @return tipoAplicacion
     */
    public java.lang.String getTipoAplicacion() {
        return tipoAplicacion;
    }


    /**
     * Sets the tipoAplicacion value for this DescuentoDTO.
     * 
     * @param tipoAplicacion
     */
    public void setTipoAplicacion(java.lang.String tipoAplicacion) {
        this.tipoAplicacion = tipoAplicacion;
    }


    /**
     * Gets the aprobacion value for this DescuentoDTO.
     * 
     * @return aprobacion
     */
    public boolean isAprobacion() {
        return aprobacion;
    }


    /**
     * Sets the aprobacion value for this DescuentoDTO.
     * 
     * @param aprobacion
     */
    public void setAprobacion(boolean aprobacion) {
        this.aprobacion = aprobacion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof DescuentoDTO)) return false;
        DescuentoDTO other = (DescuentoDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoConcepto==null && other.getCodigoConcepto()==null) || 
             (this.codigoConcepto!=null &&
              this.codigoConcepto.equals(other.getCodigoConcepto()))) &&
            ((this.codigoConceptoCargo==null && other.getCodigoConceptoCargo()==null) || 
             (this.codigoConceptoCargo!=null &&
              this.codigoConceptoCargo.equals(other.getCodigoConceptoCargo()))) &&
            ((this.codigoMoneda==null && other.getCodigoMoneda()==null) || 
             (this.codigoMoneda!=null &&
              this.codigoMoneda.equals(other.getCodigoMoneda()))) &&
            ((this.descripcionConcepto==null && other.getDescripcionConcepto()==null) || 
             (this.descripcionConcepto!=null &&
              this.descripcionConcepto.equals(other.getDescripcionConcepto()))) &&
            this.maxDescuento == other.getMaxDescuento() &&
            this.minDescuento == other.getMinDescuento() &&
            this.monto == other.getMonto() &&
            this.montoCalculado == other.getMontoCalculado() &&
            ((this.numTransaccion==null && other.getNumTransaccion()==null) || 
             (this.numTransaccion!=null &&
              this.numTransaccion.equals(other.getNumTransaccion()))) &&
            ((this.tipo==null && other.getTipo()==null) || 
             (this.tipo!=null &&
              this.tipo.equals(other.getTipo()))) &&
            ((this.tipoAplicacion==null && other.getTipoAplicacion()==null) || 
             (this.tipoAplicacion!=null &&
              this.tipoAplicacion.equals(other.getTipoAplicacion()))) &&
            this.aprobacion == other.isAprobacion();
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
        if (getCodigoConcepto() != null) {
            _hashCode += getCodigoConcepto().hashCode();
        }
        if (getCodigoConceptoCargo() != null) {
            _hashCode += getCodigoConceptoCargo().hashCode();
        }
        if (getCodigoMoneda() != null) {
            _hashCode += getCodigoMoneda().hashCode();
        }
        if (getDescripcionConcepto() != null) {
            _hashCode += getDescripcionConcepto().hashCode();
        }
        _hashCode += new Float(getMaxDescuento()).hashCode();
        _hashCode += new Float(getMinDescuento()).hashCode();
        _hashCode += new Float(getMonto()).hashCode();
        _hashCode += new Float(getMontoCalculado()).hashCode();
        if (getNumTransaccion() != null) {
            _hashCode += getNumTransaccion().hashCode();
        }
        if (getTipo() != null) {
            _hashCode += getTipo().hashCode();
        }
        if (getTipoAplicacion() != null) {
            _hashCode += getTipoAplicacion().hashCode();
        }
        _hashCode += (isAprobacion() ? Boolean.TRUE : Boolean.FALSE).hashCode();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(DescuentoDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "DescuentoDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoConcepto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CodigoConcepto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoConceptoCargo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CodigoConceptoCargo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoMoneda");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CodigoMoneda"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionConcepto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "DescripcionConcepto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("maxDescuento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "MaxDescuento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("minDescuento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "MinDescuento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("monto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Monto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("montoCalculado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "MontoCalculado"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "NumTransaccion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Tipo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipoAplicacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "TipoAplicacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("aprobacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Aprobacion"));
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
