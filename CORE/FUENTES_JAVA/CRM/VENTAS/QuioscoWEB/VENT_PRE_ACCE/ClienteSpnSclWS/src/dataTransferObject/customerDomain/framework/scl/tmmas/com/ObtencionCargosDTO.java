/**
 * ObtencionCargosDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dataTransferObject.customerDomain.framework.scl.tmmas.com;

public class ObtencionCargosDTO  implements java.io.Serializable {
    private dataTransferObject.customerDomain.framework.scl.tmmas.com.CargosDTO[] cargos;

    private java.lang.String codigoConcepto;

    private java.lang.String descripcionConcepto;

    private float maxDescuento;

    private float minDescuento;

    private float monto;

    private java.lang.String numAbonado;

    private float porcentajeDesctoInferior;

    private float porcentajeDesctoSuperior;

    private float puntoDesctoInferior;

    private float puntoDesctoSuperior;

    private java.lang.String tipo;

    private java.lang.String tipoAplicacion;

    private boolean aplicaDescuentoVendedor;

    private boolean aprobacion;

    public ObtencionCargosDTO() {
    }

    public ObtencionCargosDTO(
           dataTransferObject.customerDomain.framework.scl.tmmas.com.CargosDTO[] cargos,
           java.lang.String codigoConcepto,
           java.lang.String descripcionConcepto,
           float maxDescuento,
           float minDescuento,
           float monto,
           java.lang.String numAbonado,
           float porcentajeDesctoInferior,
           float porcentajeDesctoSuperior,
           float puntoDesctoInferior,
           float puntoDesctoSuperior,
           java.lang.String tipo,
           java.lang.String tipoAplicacion,
           boolean aplicaDescuentoVendedor,
           boolean aprobacion) {
           this.cargos = cargos;
           this.codigoConcepto = codigoConcepto;
           this.descripcionConcepto = descripcionConcepto;
           this.maxDescuento = maxDescuento;
           this.minDescuento = minDescuento;
           this.monto = monto;
           this.numAbonado = numAbonado;
           this.porcentajeDesctoInferior = porcentajeDesctoInferior;
           this.porcentajeDesctoSuperior = porcentajeDesctoSuperior;
           this.puntoDesctoInferior = puntoDesctoInferior;
           this.puntoDesctoSuperior = puntoDesctoSuperior;
           this.tipo = tipo;
           this.tipoAplicacion = tipoAplicacion;
           this.aplicaDescuentoVendedor = aplicaDescuentoVendedor;
           this.aprobacion = aprobacion;
    }


    /**
     * Gets the cargos value for this ObtencionCargosDTO.
     * 
     * @return cargos
     */
    public dataTransferObject.customerDomain.framework.scl.tmmas.com.CargosDTO[] getCargos() {
        return cargos;
    }


    /**
     * Sets the cargos value for this ObtencionCargosDTO.
     * 
     * @param cargos
     */
    public void setCargos(dataTransferObject.customerDomain.framework.scl.tmmas.com.CargosDTO[] cargos) {
        this.cargos = cargos;
    }

    public dataTransferObject.customerDomain.framework.scl.tmmas.com.CargosDTO getCargos(int i) {
        return this.cargos[i];
    }

    public void setCargos(int i, dataTransferObject.customerDomain.framework.scl.tmmas.com.CargosDTO _value) {
        this.cargos[i] = _value;
    }


    /**
     * Gets the codigoConcepto value for this ObtencionCargosDTO.
     * 
     * @return codigoConcepto
     */
    public java.lang.String getCodigoConcepto() {
        return codigoConcepto;
    }


    /**
     * Sets the codigoConcepto value for this ObtencionCargosDTO.
     * 
     * @param codigoConcepto
     */
    public void setCodigoConcepto(java.lang.String codigoConcepto) {
        this.codigoConcepto = codigoConcepto;
    }


    /**
     * Gets the descripcionConcepto value for this ObtencionCargosDTO.
     * 
     * @return descripcionConcepto
     */
    public java.lang.String getDescripcionConcepto() {
        return descripcionConcepto;
    }


    /**
     * Sets the descripcionConcepto value for this ObtencionCargosDTO.
     * 
     * @param descripcionConcepto
     */
    public void setDescripcionConcepto(java.lang.String descripcionConcepto) {
        this.descripcionConcepto = descripcionConcepto;
    }


    /**
     * Gets the maxDescuento value for this ObtencionCargosDTO.
     * 
     * @return maxDescuento
     */
    public float getMaxDescuento() {
        return maxDescuento;
    }


    /**
     * Sets the maxDescuento value for this ObtencionCargosDTO.
     * 
     * @param maxDescuento
     */
    public void setMaxDescuento(float maxDescuento) {
        this.maxDescuento = maxDescuento;
    }


    /**
     * Gets the minDescuento value for this ObtencionCargosDTO.
     * 
     * @return minDescuento
     */
    public float getMinDescuento() {
        return minDescuento;
    }


    /**
     * Sets the minDescuento value for this ObtencionCargosDTO.
     * 
     * @param minDescuento
     */
    public void setMinDescuento(float minDescuento) {
        this.minDescuento = minDescuento;
    }


    /**
     * Gets the monto value for this ObtencionCargosDTO.
     * 
     * @return monto
     */
    public float getMonto() {
        return monto;
    }


    /**
     * Sets the monto value for this ObtencionCargosDTO.
     * 
     * @param monto
     */
    public void setMonto(float monto) {
        this.monto = monto;
    }


    /**
     * Gets the numAbonado value for this ObtencionCargosDTO.
     * 
     * @return numAbonado
     */
    public java.lang.String getNumAbonado() {
        return numAbonado;
    }


    /**
     * Sets the numAbonado value for this ObtencionCargosDTO.
     * 
     * @param numAbonado
     */
    public void setNumAbonado(java.lang.String numAbonado) {
        this.numAbonado = numAbonado;
    }


    /**
     * Gets the porcentajeDesctoInferior value for this ObtencionCargosDTO.
     * 
     * @return porcentajeDesctoInferior
     */
    public float getPorcentajeDesctoInferior() {
        return porcentajeDesctoInferior;
    }


    /**
     * Sets the porcentajeDesctoInferior value for this ObtencionCargosDTO.
     * 
     * @param porcentajeDesctoInferior
     */
    public void setPorcentajeDesctoInferior(float porcentajeDesctoInferior) {
        this.porcentajeDesctoInferior = porcentajeDesctoInferior;
    }


    /**
     * Gets the porcentajeDesctoSuperior value for this ObtencionCargosDTO.
     * 
     * @return porcentajeDesctoSuperior
     */
    public float getPorcentajeDesctoSuperior() {
        return porcentajeDesctoSuperior;
    }


    /**
     * Sets the porcentajeDesctoSuperior value for this ObtencionCargosDTO.
     * 
     * @param porcentajeDesctoSuperior
     */
    public void setPorcentajeDesctoSuperior(float porcentajeDesctoSuperior) {
        this.porcentajeDesctoSuperior = porcentajeDesctoSuperior;
    }


    /**
     * Gets the puntoDesctoInferior value for this ObtencionCargosDTO.
     * 
     * @return puntoDesctoInferior
     */
    public float getPuntoDesctoInferior() {
        return puntoDesctoInferior;
    }


    /**
     * Sets the puntoDesctoInferior value for this ObtencionCargosDTO.
     * 
     * @param puntoDesctoInferior
     */
    public void setPuntoDesctoInferior(float puntoDesctoInferior) {
        this.puntoDesctoInferior = puntoDesctoInferior;
    }


    /**
     * Gets the puntoDesctoSuperior value for this ObtencionCargosDTO.
     * 
     * @return puntoDesctoSuperior
     */
    public float getPuntoDesctoSuperior() {
        return puntoDesctoSuperior;
    }


    /**
     * Sets the puntoDesctoSuperior value for this ObtencionCargosDTO.
     * 
     * @param puntoDesctoSuperior
     */
    public void setPuntoDesctoSuperior(float puntoDesctoSuperior) {
        this.puntoDesctoSuperior = puntoDesctoSuperior;
    }


    /**
     * Gets the tipo value for this ObtencionCargosDTO.
     * 
     * @return tipo
     */
    public java.lang.String getTipo() {
        return tipo;
    }


    /**
     * Sets the tipo value for this ObtencionCargosDTO.
     * 
     * @param tipo
     */
    public void setTipo(java.lang.String tipo) {
        this.tipo = tipo;
    }


    /**
     * Gets the tipoAplicacion value for this ObtencionCargosDTO.
     * 
     * @return tipoAplicacion
     */
    public java.lang.String getTipoAplicacion() {
        return tipoAplicacion;
    }


    /**
     * Sets the tipoAplicacion value for this ObtencionCargosDTO.
     * 
     * @param tipoAplicacion
     */
    public void setTipoAplicacion(java.lang.String tipoAplicacion) {
        this.tipoAplicacion = tipoAplicacion;
    }


    /**
     * Gets the aplicaDescuentoVendedor value for this ObtencionCargosDTO.
     * 
     * @return aplicaDescuentoVendedor
     */
    public boolean isAplicaDescuentoVendedor() {
        return aplicaDescuentoVendedor;
    }


    /**
     * Sets the aplicaDescuentoVendedor value for this ObtencionCargosDTO.
     * 
     * @param aplicaDescuentoVendedor
     */
    public void setAplicaDescuentoVendedor(boolean aplicaDescuentoVendedor) {
        this.aplicaDescuentoVendedor = aplicaDescuentoVendedor;
    }


    /**
     * Gets the aprobacion value for this ObtencionCargosDTO.
     * 
     * @return aprobacion
     */
    public boolean isAprobacion() {
        return aprobacion;
    }


    /**
     * Sets the aprobacion value for this ObtencionCargosDTO.
     * 
     * @param aprobacion
     */
    public void setAprobacion(boolean aprobacion) {
        this.aprobacion = aprobacion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ObtencionCargosDTO)) return false;
        ObtencionCargosDTO other = (ObtencionCargosDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.cargos==null && other.getCargos()==null) || 
             (this.cargos!=null &&
              java.util.Arrays.equals(this.cargos, other.getCargos()))) &&
            ((this.codigoConcepto==null && other.getCodigoConcepto()==null) || 
             (this.codigoConcepto!=null &&
              this.codigoConcepto.equals(other.getCodigoConcepto()))) &&
            ((this.descripcionConcepto==null && other.getDescripcionConcepto()==null) || 
             (this.descripcionConcepto!=null &&
              this.descripcionConcepto.equals(other.getDescripcionConcepto()))) &&
            this.maxDescuento == other.getMaxDescuento() &&
            this.minDescuento == other.getMinDescuento() &&
            this.monto == other.getMonto() &&
            ((this.numAbonado==null && other.getNumAbonado()==null) || 
             (this.numAbonado!=null &&
              this.numAbonado.equals(other.getNumAbonado()))) &&
            this.porcentajeDesctoInferior == other.getPorcentajeDesctoInferior() &&
            this.porcentajeDesctoSuperior == other.getPorcentajeDesctoSuperior() &&
            this.puntoDesctoInferior == other.getPuntoDesctoInferior() &&
            this.puntoDesctoSuperior == other.getPuntoDesctoSuperior() &&
            ((this.tipo==null && other.getTipo()==null) || 
             (this.tipo!=null &&
              this.tipo.equals(other.getTipo()))) &&
            ((this.tipoAplicacion==null && other.getTipoAplicacion()==null) || 
             (this.tipoAplicacion!=null &&
              this.tipoAplicacion.equals(other.getTipoAplicacion()))) &&
            this.aplicaDescuentoVendedor == other.isAplicaDescuentoVendedor() &&
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
        if (getCargos() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getCargos());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getCargos(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getCodigoConcepto() != null) {
            _hashCode += getCodigoConcepto().hashCode();
        }
        if (getDescripcionConcepto() != null) {
            _hashCode += getDescripcionConcepto().hashCode();
        }
        _hashCode += new Float(getMaxDescuento()).hashCode();
        _hashCode += new Float(getMinDescuento()).hashCode();
        _hashCode += new Float(getMonto()).hashCode();
        if (getNumAbonado() != null) {
            _hashCode += getNumAbonado().hashCode();
        }
        _hashCode += new Float(getPorcentajeDesctoInferior()).hashCode();
        _hashCode += new Float(getPorcentajeDesctoSuperior()).hashCode();
        _hashCode += new Float(getPuntoDesctoInferior()).hashCode();
        _hashCode += new Float(getPuntoDesctoSuperior()).hashCode();
        if (getTipo() != null) {
            _hashCode += getTipo().hashCode();
        }
        if (getTipoAplicacion() != null) {
            _hashCode += getTipoAplicacion().hashCode();
        }
        _hashCode += (isAplicaDescuentoVendedor() ? Boolean.TRUE : Boolean.FALSE).hashCode();
        _hashCode += (isAprobacion() ? Boolean.TRUE : Boolean.FALSE).hashCode();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ObtencionCargosDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "ObtencionCargosDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("cargos");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Cargos"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CargosDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoConcepto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CodigoConcepto"));
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
        elemField.setFieldName("numAbonado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "NumAbonado"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("porcentajeDesctoInferior");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "PorcentajeDesctoInferior"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("porcentajeDesctoSuperior");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "PorcentajeDesctoSuperior"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("puntoDesctoInferior");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "PuntoDesctoInferior"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("puntoDesctoSuperior");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "PuntoDesctoSuperior"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(false);
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
        elemField.setFieldName("aplicaDescuentoVendedor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "AplicaDescuentoVendedor"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        elemField.setNillable(false);
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
