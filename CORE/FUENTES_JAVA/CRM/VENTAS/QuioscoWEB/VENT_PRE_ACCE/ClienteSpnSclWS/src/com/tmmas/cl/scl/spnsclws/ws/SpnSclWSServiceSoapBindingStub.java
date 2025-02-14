/**
 * SpnSclWSServiceSoapBindingStub.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.tmmas.cl.scl.spnsclws.ws;

public class SpnSclWSServiceSoapBindingStub extends org.apache.axis.client.Stub implements com.tmmas.cl.scl.spnsclws.ws.SpnSclWS {
    private java.util.Vector cachedSerClasses = new java.util.Vector();
    private java.util.Vector cachedSerQNames = new java.util.Vector();
    private java.util.Vector cachedSerFactories = new java.util.Vector();
    private java.util.Vector cachedDeserFactories = new java.util.Vector();

    static org.apache.axis.description.OperationDesc [] _operations;

    static {
        _operations = new org.apache.axis.description.OperationDesc[59];
        _initOperationDesc1();
        _initOperationDesc2();
        _initOperationDesc3();
        _initOperationDesc4();
        _initOperationDesc5();
        _initOperationDesc6();
    }

    private static void _initOperationDesc1(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getClasificaciones");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsClasificacionOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsClasificacionOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[0] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("rechazoVenta");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rechazoVenta"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "WsRechazoVentaInDTO"), in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsRechazoVentaInDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RechazoVentaOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[1] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListadoTipoPago");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListTipoPagoOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTipoPagoOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[2] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListadoPlanTarifario");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListPlanTarifarioOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[3] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListadoCiudades");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "provinciaDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ProvinciaDTO"), dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoCiudadesOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCiudadesOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[4] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("deleteTienda");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codTienda"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), java.lang.Long.class, false, false);
        param.setOmittable(true);
        param.setNillable(true);
        oper.addParameter(param);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[5] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("cancelaVenta");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "cancelaVenta"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "WsRechazoVentaInDTO"), in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsRechazoVentaInDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RechazoVentaOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[6] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getConsultaPlanesTarifarios");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "consultaPlanTarifarioIn"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsConsultaPlanTarifarioInDTO"), dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioInDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListConsultaPlanTarifarioOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListConsultaPlanTarifarioOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[7] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("solicitaBajaAbonado");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "solicitudBajaAbonadoDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WSSolicitudBajaAbonadoDTO"), dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WSSolicitudBajaAbonadoOutDTO"));
        oper.setReturnClass(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[8] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getDetalleUltimaLlamadasRoamingTOL");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rommingDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "RoamingDTO"), dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "RoamingOUTDTO"));
        oper.setReturnClass(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingOUTDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[9] = oper;

    }

    private static void _initOperationDesc2(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("recuperaArrayTipificacion");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ArrayOfTipificaClientizaDTO_literal"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        param = oper.getReturnParamDesc();
        param.setItemQName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificaClientizaDTO"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[10] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getCrediticia");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsCrediticiaOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsCrediticiaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[11] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("clientePorNumeroCelular");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "numeroCelular"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DatosClienteDTO"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[12] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("foo");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "param"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        oper.setReturnClass(java.lang.String.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[13] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getTiposPrestacion");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codGrupoPrestacion"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "tipoCliente"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsListTipoPrestacionOutDTO"));
        oper.setReturnClass(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsListTipoPrestacionOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[14] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListadoRegiones");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoRegionesOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoRegionesOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[15] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getTiendaVendedor");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codTienda"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsTiendaVendedorOutDTO"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[16] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("deleteTipificacion");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codArticulo"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), java.lang.Long.class, false, false);
        param.setOmittable(true);
        param.setNillable(true);
        oper.addParameter(param);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[17] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("recCampanaBeneficio");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "beneficioPromocion"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBeneficioPromocionInDTO"), dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionInDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "ArrayOfWsBeneficioPromocionOutDTO_literal"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionOutDTO[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        param = oper.getReturnParamDesc();
        param.setItemQName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBeneficioPromocionOutDTO"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[18] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListaCaja");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codOficina"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsCajaOutDTO"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsCajaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[19] = oper;

    }

    private static void _initOperationDesc3(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("reservaDesreserva");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "solicitaReservaDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ReservaDTO"), dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "tipoSolicitud"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ReservaOutDTO"));
        oper.setReturnClass(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[20] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("updateTipificacion");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "tipificaClientizaDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificaClientizaDTO"), dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[21] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("agregarDirecciones");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "WsDireccionesIn"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "ArrayOfWsDireccionInDTO_literal"), dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO[].class, false, false);
        param.setItemQName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionInDTO"));
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionesOutDTO"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.WsDireccionesOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[22] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getCategoriasCambio");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoCategoriaCambioDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriaCambioDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[23] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("AltaCuentaSubCuenta");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "cuentaIn"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAltaCuentaSubCuentaInDTO"), dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaInDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAltaCuentaSubCuentaOutDTO"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[24] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("pruebaJMS");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "prueba"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        oper.setReturnClass(java.lang.String.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[25] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("AltaDeLinea");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "altaLinea"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsCunetaAltaDeLineaDTO"), dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsCunetaAltaDeLineaOutDTO"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[26] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getCentralesQuiosco");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WSCentralQuioscoOutDTO"));
        oper.setReturnClass(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSCentralQuioscoOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[27] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListCategorias");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoCategoriasClienteOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriasClienteOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[28] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("insertTienda");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "tiendaDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TiendaDTO"), dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsInsertTiendaOutDTO"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTiendaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[29] = oper;

    }

    private static void _initOperationDesc4(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("registraCampanaBeneficio");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "registraCampanaByPIn"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsRegistraCampanaByPInDTO"), dto.commonapp.scl.cl.tmmas.com.WsRegistraCampanaByPInDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[30] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getTiendas");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsTiendasOutDTO"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendasOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[31] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListadoPlanesTarifarios");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "inWSLstPlanTarifDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsPlanTarifarioInDTO"), dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioInDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListPlanTarifarioOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[32] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getImpuesto");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codigoVendedor"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        oper.setReturnClass(float.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[33] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("solicitaBajaAbonadoPrepago");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "solicitudBajaAbonadoDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WSSolicitudBajaAbonadoDTO"), dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WSSolicitudBajaAbonadoOutDTO"));
        oper.setReturnClass(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[34] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("AltaDeStructuraComercial");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "WsCreaStructuraComercial"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsCreaStructuraComercialInDTO"), dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsCreaStructuraComercialInDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraComercialOutDTO"));
        oper.setReturnClass(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[35] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getCargosFacturacion");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "WsFacturacionVentaIn"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsConsCargosVentaInDTO"), dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaInDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsConsCargosVentaOutDTO"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[36] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("WSMigracionClientePrepagoAPostpago");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "migracionDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "MigracionDTO"), transport.serviciospostventasiga.scl.tmmas.com.MigracionDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "MigracionPrepagoPostpagoDTO"));
        oper.setReturnClass(transport.serviciospostventasiga.scl.tmmas.com.MigracionPrepagoPostpagoDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[37] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("recuperaDatoTipificacion");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "datoTipificacion"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codVendedor"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ArrayOfTipificacionDTO_literal"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        param = oper.getReturnParamDesc();
        param.setItemQName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificacionDTO"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[38] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getZip");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "direccion"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DireccionDTO"), dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        oper.setReturnClass(java.lang.String.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[39] = oper;

    }

    private static void _initOperationDesc5(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListadoTarjetas");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListTarjetaOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTarjetaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[40] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("agregarDireccion");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "WsDireccionesIn"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionInDTO"), dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionOutDTO"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.WsDireccionOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[41] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("AltaCliente");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "cuenta"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsCuentaInNDTO"), dto.commonapp.scl.cl.tmmas.com.WsCuentaInNDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAltaClienteOutDTO"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.WsAltaClienteOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[42] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListadoBancosPAC");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListBancoOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListBancoOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[43] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getSSincluidosEnPlan");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codigoPlanTarifario"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsOutSSuplementariosDTO"));
        oper.setReturnClass(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[44] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("obtieneListaTienda");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ArrayOfTiendaDTO_literal"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        param = oper.getReturnParamDesc();
        param.setItemQName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TiendaDTO"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[45] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("setAgregaEliminaSS");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "sSuplemenAgregar"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ArrayOfWsAgregaEliminaSSInDTO_literal"), dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO[].class, false, false);
        param.setItemQName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsAgregaEliminaSSInDTO"));
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "sSuplemenEliminar"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ArrayOfWsAgregaEliminaSSInDTO_literal"), dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO[].class, false, false);
        param.setItemQName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsAgregaEliminaSSInDTO"));
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "NumeroCelular"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), java.lang.Long.class, false, false);
        param.setOmittable(true);
        param.setNillable(true);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "NomUsuario"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "SSuplementarioOutDTO"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.SSuplementarioOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[46] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("AltaDeLineaBusito");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "altaDeLineaBusitoIn"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.busito.dto", "AltaDeLineaBusitoInDTO"), dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoInDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.busito.dto", "AltaDeLineaBusitoOutDTO"));
        oper.setReturnClass(dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[47] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("aceptacionVenta");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "aceptacionVenta"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "WsAceptacionVentaInDTO"), in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsAceptacionVentaInDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "AceptacionVentaOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.AceptacionVentaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[48] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getSSOpcionalesAlPlan");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codigoPlanTarifario"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codigoArticulo"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "codigCentral"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsOutSSuplementariosDTO"));
        oper.setReturnClass(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[49] = oper;

    }

    private static void _initOperationDesc6(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("cierreVenta");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "cierreVenta"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "WsCierreVentaInDTO"), in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsCierreVentaInDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CierreVentaOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CierreVentaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[50] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getDatosDireccion");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "direccionDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DireccionDTO"), dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "WsDatosDireccionOutDTO"));
        oper.setReturnClass(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.WsDatosDireccionOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[51] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("insertarTipificacion");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "tipificaClientizaDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificaClientizaDTO"), dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsInsertTipificacionOutDTO"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTipificacionOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[52] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getTiposIdentificacion");
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoTiposIdentificacionOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoTiposIdentificacionOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[53] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("updateTienda");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "tiendaModDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TiendaDTO"), dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsUpdateTiendaOutDTO"));
        oper.setReturnClass(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsUpdateTiendaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[54] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("recuperarAltaAsincrono");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "id_transaccion"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsCunetaAltaDeLineaOutDTO"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[55] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListadoProvincias");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "regionDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "RegionDTO"), dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoProvinciasOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoProvinciasOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[56] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getListadoComunas");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "ciudadDTO"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CiudadDTO"), dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoComunasOutDTO"));
        oper.setReturnClass(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoComunasOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[57] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("ProcesoDeFacturacion");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "wsFacturacionVentaIn"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsFacturacionVentaInDTO"), dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaInDTO.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rollback"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsFacturacionVentaOutDTO"));
        oper.setReturnClass(dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaOutDTO.class);
        oper.setReturnQName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "return"));
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"),
                      "exception.framework.cl.tmmas.com.GeneralException",
                      new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException"), 
                      true
                     ));
        _operations[58] = oper;

    }

    public SpnSclWSServiceSoapBindingStub() throws org.apache.axis.AxisFault {
         this(null);
    }

    public SpnSclWSServiceSoapBindingStub(java.net.URL endpointURL, javax.xml.rpc.Service service) throws org.apache.axis.AxisFault {
         this(service);
         super.cachedEndpoint = endpointURL;
    }

    public SpnSclWSServiceSoapBindingStub(javax.xml.rpc.Service service) throws org.apache.axis.AxisFault {
        if (service == null) {
            super.service = new org.apache.axis.client.Service();
        } else {
            super.service = service;
        }
        ((org.apache.axis.client.Service)super.service).setTypeMappingVersion("1.2");
            java.lang.Class cls;
            javax.xml.namespace.QName qName;
            javax.xml.namespace.QName qName2;
            java.lang.Class beansf = org.apache.axis.encoding.ser.BeanSerializerFactory.class;
            java.lang.Class beandf = org.apache.axis.encoding.ser.BeanDeserializerFactory.class;
            java.lang.Class enumsf = org.apache.axis.encoding.ser.EnumSerializerFactory.class;
            java.lang.Class enumdf = org.apache.axis.encoding.ser.EnumDeserializerFactory.class;
            java.lang.Class arraysf = org.apache.axis.encoding.ser.ArraySerializerFactory.class;
            java.lang.Class arraydf = org.apache.axis.encoding.ser.ArrayDeserializerFactory.class;
            java.lang.Class simplesf = org.apache.axis.encoding.ser.SimpleSerializerFactory.class;
            java.lang.Class simpledf = org.apache.axis.encoding.ser.SimpleDeserializerFactory.class;
            java.lang.Class simplelistsf = org.apache.axis.encoding.ser.SimpleListSerializerFactory.class;
            java.lang.Class simplelistdf = org.apache.axis.encoding.ser.SimpleListDeserializerFactory.class;
        addBindings0();
        addBindings1();
    }

    private void addBindings0() {
            java.lang.Class cls;
            javax.xml.namespace.QName qName;
            javax.xml.namespace.QName qName2;
            java.lang.Class beansf = org.apache.axis.encoding.ser.BeanSerializerFactory.class;
            java.lang.Class beandf = org.apache.axis.encoding.ser.BeanDeserializerFactory.class;
            java.lang.Class enumsf = org.apache.axis.encoding.ser.EnumSerializerFactory.class;
            java.lang.Class enumdf = org.apache.axis.encoding.ser.EnumDeserializerFactory.class;
            java.lang.Class arraysf = org.apache.axis.encoding.ser.ArraySerializerFactory.class;
            java.lang.Class arraydf = org.apache.axis.encoding.ser.ArrayDeserializerFactory.class;
            java.lang.Class simplesf = org.apache.axis.encoding.ser.SimpleSerializerFactory.class;
            java.lang.Class simpledf = org.apache.axis.encoding.ser.SimpleDeserializerFactory.class;
            java.lang.Class simplelistsf = org.apache.axis.encoding.ser.SimpleListSerializerFactory.class;
            java.lang.Class simplelistdf = org.apache.axis.encoding.ser.SimpleListDeserializerFactory.class;
            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.framework.exception", "GeneralException");
            cachedSerQNames.add(qName);
            cls = exception.framework.cl.tmmas.com.GeneralException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "ArrayOfWsBeneficioPromocionOutDTO_literal");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionOutDTO[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBeneficioPromocionOutDTO");
            qName2 = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBeneficioPromocionOutDTO");
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "ArrayOfWsDireccionInDTO_literal");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionInDTO");
            qName2 = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionInDTO");
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "SSuplementarioOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.SSuplementarioOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsActivacionLineaDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsActivacionLineaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAltaClienteOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsAltaClienteOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAltaCuentaSubCuentaInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAltaCuentaSubCuentaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsAntecedentesVentaInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsAntecedentesVentaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsApoderadoInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsApoderadoInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBancoInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsBancoInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBeneficioPromocionInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBeneficioPromocionOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsClienteInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsClienteInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsConsCargosVentaInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsConsCargosVentaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsCuentaInNDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsCuentaInNDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsCunetaAltaDeLineaDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsCunetaAltaDeLineaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDatosPlanTerifarioInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsDatosPlanTerifarioInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionesOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsDireccionesOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDireccionOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsDireccionOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsFacturacionLineaDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsFacturacionLineaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsFacturacionVentaInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsFacturacionVentaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsHomeLineaInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsHomeLineaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsLineaInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsLineaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsLineaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsLineaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsRegistraCampanaByPInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsRegistraCampanaByPInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsResponsableInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsResponsableInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsSimcardInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsSimcardInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsSucursalBancoInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsSucursalBancoInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsTarjetaCreditoInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsTarjetaCreditoInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsTerminalInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsTerminalInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsUsuarioInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.scl.cl.tmmas.com.WsUsuarioInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ArrayOfWsAgregaEliminaSSInDTO_literal");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsAgregaEliminaSSInDTO");
            qName2 = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsAgregaEliminaSSInDTO");
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ReservaDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ReservaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "RoamingDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "RoamingOUTDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingOUTDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "SSuplementariosDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.SSuplementariosDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "TipoPrestacionDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.TipoPrestacionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsAgregaEliminaSSInDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WSCentralQuioscoOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSCentralQuioscoOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsListTipoPrestacionOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsListTipoPrestacionOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WsOutSSuplementariosDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WSSolicitudBajaAbonadoDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WSSolicitudBajaAbonadoOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "AceptacionVentaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.AceptacionVentaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CategoriaCambioDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CategoriaCambioDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CentralDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CentralDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CierreVentaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CierreVentaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ClasificacionDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.ClasificacionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ClienteDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.ClienteDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IdentificadorCivilDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.IdentificadorCivilDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RechazoVentaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RepresentanteLegalDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RepresentanteLegalDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RetornoDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RetornoLineaDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoLineaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "TipoPagoDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.TipoPagoDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ValorClasificacionDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.ValorClasificacionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsBancoOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsBancoOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsClasificacionOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsClasificacionOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsConsultaPlanTarifarioInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsConsultaPlanTarifarioOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsCrediticiaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsCrediticiaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoCategoriaCambioDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriaCambioDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoCategoriasClienteOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriasClienteOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoCiudadesOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCiudadesOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoComunasOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoComunasOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoProvinciasOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoProvinciasOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoRegionesOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoRegionesOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListadoTiposIdentificacionOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoTiposIdentificacionOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListBancoOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListBancoOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListConsultaPlanTarifarioOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListConsultaPlanTarifarioOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListPlanTarifarioOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListTarjetaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTarjetaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListTipoPagoOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTipoPagoOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsPlanTarifarioInDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsPlanTarifarioOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsTarjetaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsTarjetaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CiudadDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ComunaSPNDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ComunaSPNDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ConceptoDireccionDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ConceptoDireccionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DatosDireccionDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DatosDireccionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DireccionDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DireccionNegocioDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionNegocioDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ProvinciaDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "RegionDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "WsDatosDireccionOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.WsDatosDireccionOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.busito.dto", "AltaDeLineaBusitoInDTO");
            cachedSerQNames.add(qName);
            cls = dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.busito.dto", "AltaDeLineaBusitoOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "WsAceptacionVentaInDTO");
            cachedSerQNames.add(qName);
            cls = in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsAceptacionVentaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "WsCierreVentaInDTO");
            cachedSerQNames.add(qName);
            cls = in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsCierreVentaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "WsRechazoVentaInDTO");
            cachedSerQNames.add(qName);
            cls = in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsRechazoVentaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsCreaStructuraComercialInDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsCreaStructuraComercialInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsDireccionQuioscoInDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsDireccionQuioscoInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraAccesorioDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAccesorioDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraActivacionLineaDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraActivacionLineaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

    }
    private void addBindings1() {
            java.lang.Class cls;
            javax.xml.namespace.QName qName;
            javax.xml.namespace.QName qName2;
            java.lang.Class beansf = org.apache.axis.encoding.ser.BeanSerializerFactory.class;
            java.lang.Class beandf = org.apache.axis.encoding.ser.BeanDeserializerFactory.class;
            java.lang.Class enumsf = org.apache.axis.encoding.ser.EnumSerializerFactory.class;
            java.lang.Class enumdf = org.apache.axis.encoding.ser.EnumDeserializerFactory.class;
            java.lang.Class arraysf = org.apache.axis.encoding.ser.ArraySerializerFactory.class;
            java.lang.Class arraydf = org.apache.axis.encoding.ser.ArrayDeserializerFactory.class;
            java.lang.Class simplesf = org.apache.axis.encoding.ser.SimpleSerializerFactory.class;
            java.lang.Class simpledf = org.apache.axis.encoding.ser.SimpleDeserializerFactory.class;
            java.lang.Class simplelistsf = org.apache.axis.encoding.ser.SimpleListSerializerFactory.class;
            java.lang.Class simplelistdf = org.apache.axis.encoding.ser.SimpleListDeserializerFactory.class;
            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraAntecedentesVentaDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAntecedentesVentaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraClienteDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraClienteDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraComercialOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraCuentaInDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraCuentaInDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraLineaDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraLineaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraPagoDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraPagoDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraSimcardDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraSimcardDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraTerminalDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraTerminalDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraUsuarioLineaDTO");
            cachedSerQNames.add(qName);
            cls = dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraUsuarioLineaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ArrayOfTiendaDTO_literal");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TiendaDTO");
            qName2 = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TiendaDTO");
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ArrayOfTipificacionDTO_literal");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificacionDTO");
            qName2 = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificacionDTO");
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ArrayOfTipificaClientizaDTO_literal");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificaClientizaDTO");
            qName2 = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificaClientizaDTO");
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CajaDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.CajaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ClienteDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.ClienteDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DatosClienteDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DireccionDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TiendaDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificacionDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificaClientizaDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsCajaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsCajaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsInsertTiendaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTiendaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsInsertTipificacionOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTipificacionOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsTiendasOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendasOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsTiendaVendedorOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "WsUpdateTiendaOutDTO");
            cachedSerQNames.add(qName);
            cls = dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsUpdateTiendaOutDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "AtributosCargoDTO");
            cachedSerQNames.add(qName);
            cls = dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosCargoDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "AtributosMigracionDTO");
            cachedSerQNames.add(qName);
            cls = dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosMigracionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CargosDTO");
            cachedSerQNames.add(qName);
            cls = dataTransferObject.customerDomain.framework.scl.tmmas.com.CargosDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "DescuentoDTO");
            cachedSerQNames.add(qName);
            cls = dataTransferObject.customerDomain.framework.scl.tmmas.com.DescuentoDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "MonedaDTO");
            cachedSerQNames.add(qName);
            cls = dataTransferObject.customerDomain.framework.scl.tmmas.com.MonedaDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "ObtencionCargosDTO");
            cachedSerQNames.add(qName);
            cls = dataTransferObject.customerDomain.framework.scl.tmmas.com.ObtencionCargosDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "PrecioDTO");
            cachedSerQNames.add(qName);
            cls = dataTransferObject.customerDomain.framework.scl.tmmas.com.PrecioDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "MigracionDTO");
            cachedSerQNames.add(qName);
            cls = transport.serviciospostventasiga.scl.tmmas.com.MigracionDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "MigracionPrepagoPostpagoDTO");
            cachedSerQNames.add(qName);
            cls = transport.serviciospostventasiga.scl.tmmas.com.MigracionPrepagoPostpagoDTO.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

    }

    protected org.apache.axis.client.Call createCall() throws java.rmi.RemoteException {
        try {
            org.apache.axis.client.Call _call = super._createCall();
            if (super.maintainSessionSet) {
                _call.setMaintainSession(super.maintainSession);
            }
            if (super.cachedUsername != null) {
                _call.setUsername(super.cachedUsername);
            }
            if (super.cachedPassword != null) {
                _call.setPassword(super.cachedPassword);
            }
            if (super.cachedEndpoint != null) {
                _call.setTargetEndpointAddress(super.cachedEndpoint);
            }
            if (super.cachedTimeout != null) {
                _call.setTimeout(super.cachedTimeout);
            }
            if (super.cachedPortName != null) {
                _call.setPortName(super.cachedPortName);
            }
            java.util.Enumeration keys = super.cachedProperties.keys();
            while (keys.hasMoreElements()) {
                java.lang.String key = (java.lang.String) keys.nextElement();
                _call.setProperty(key, super.cachedProperties.get(key));
            }
            // All the type mapping information is registered
            // when the first call is made.
            // The type mapping information is actually registered in
            // the TypeMappingRegistry of the service, which
            // is the reason why registration is only needed for the first call.
            synchronized (this) {
                if (firstCall()) {
                    // must set encoding style before registering serializers
                    _call.setEncodingStyle(null);
                    for (int i = 0; i < cachedSerFactories.size(); ++i) {
                        java.lang.Class cls = (java.lang.Class) cachedSerClasses.get(i);
                        javax.xml.namespace.QName qName =
                                (javax.xml.namespace.QName) cachedSerQNames.get(i);
                        java.lang.Object x = cachedSerFactories.get(i);
                        if (x instanceof Class) {
                            java.lang.Class sf = (java.lang.Class)
                                 cachedSerFactories.get(i);
                            java.lang.Class df = (java.lang.Class)
                                 cachedDeserFactories.get(i);
                            _call.registerTypeMapping(cls, qName, sf, df, false);
                        }
                        else if (x instanceof javax.xml.rpc.encoding.SerializerFactory) {
                            org.apache.axis.encoding.SerializerFactory sf = (org.apache.axis.encoding.SerializerFactory)
                                 cachedSerFactories.get(i);
                            org.apache.axis.encoding.DeserializerFactory df = (org.apache.axis.encoding.DeserializerFactory)
                                 cachedDeserFactories.get(i);
                            _call.registerTypeMapping(cls, qName, sf, df, false);
                        }
                    }
                }
            }
            return _call;
        }
        catch (java.lang.Throwable _t) {
            throw new org.apache.axis.AxisFault("Failure trying to get the Call object", _t);
        }
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsClasificacionOutDTO getClasificaciones() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[0]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getClasificaciones"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsClasificacionOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsClasificacionOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsClasificacionOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO rechazoVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsRechazoVentaInDTO rechazoVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[1]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "rechazoVenta"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {rechazoVenta, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTipoPagoOutDTO getListadoTipoPago() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[2]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListadoTipoPago"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTipoPagoOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTipoPagoOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTipoPagoOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO getListadoPlanTarifario() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[3]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListadoPlanTarifario"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCiudadesOutDTO getListadoCiudades(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO provinciaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[4]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListadoCiudades"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {provinciaDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCiudadesOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCiudadesOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCiudadesOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public void deleteTienda(java.lang.Long codTienda) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[5]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "deleteTienda"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {codTienda});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        extractAttachments(_call);
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO cancelaVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsRechazoVentaInDTO cancelaVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[6]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "cancelaVenta"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {cancelaVenta, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[7]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getConsultaPlanesTarifarios"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {consultaPlanTarifarioIn});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListConsultaPlanTarifarioOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListConsultaPlanTarifarioOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListConsultaPlanTarifarioOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[8]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "solicitaBajaAbonado"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {solicitudBajaAbonadoDTO, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingOUTDTO getDetalleUltimaLlamadasRoamingTOL(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingDTO rommingDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[9]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getDetalleUltimaLlamadasRoamingTOL"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {rommingDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingOUTDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingOUTDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingOUTDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO[] recuperaArrayTipificacion() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[10]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "recuperaArrayTipificacion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO[]) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsCrediticiaOutDTO getCrediticia() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[11]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getCrediticia"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsCrediticiaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsCrediticiaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsCrediticiaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO clientePorNumeroCelular(long numeroCelular) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[12]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "clientePorNumeroCelular"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {new java.lang.Long(numeroCelular)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String foo(java.lang.String param) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[13]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "foo"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {param});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsListTipoPrestacionOutDTO getTiposPrestacion(java.lang.String codGrupoPrestacion, java.lang.String tipoCliente) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[14]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getTiposPrestacion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {codGrupoPrestacion, tipoCliente});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsListTipoPrestacionOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsListTipoPrestacionOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsListTipoPrestacionOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoRegionesOutDTO getListadoRegiones() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[15]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListadoRegiones"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoRegionesOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoRegionesOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoRegionesOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO getTiendaVendedor(java.lang.String codTienda) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[16]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getTiendaVendedor"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {codTienda});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void deleteTipificacion(java.lang.Long codArticulo) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[17]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "deleteTipificacion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {codArticulo});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        extractAttachments(_call);
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionOutDTO[] recCampanaBeneficio(dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionInDTO beneficioPromocion) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[18]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "recCampanaBeneficio"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {beneficioPromocion});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionOutDTO[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionOutDTO[]) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionOutDTO[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsCajaOutDTO getListaCaja(java.lang.String codOficina) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[19]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListaCaja"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {codOficina});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsCajaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsCajaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsCajaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaOutDTO reservaDesreserva(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaDTO solicitaReservaDTO, java.lang.String tipoSolicitud, int rollback) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[20]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "reservaDesreserva"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {solicitaReservaDTO, tipoSolicitud, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void updateTipificacion(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO tipificaClientizaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[21]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "updateTipificacion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {tipificaClientizaDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        extractAttachments(_call);
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.WsDireccionesOutDTO agregarDirecciones(dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO[] wsDireccionesIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[22]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "agregarDirecciones"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {wsDireccionesIn, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.WsDireccionesOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.WsDireccionesOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.WsDireccionesOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriaCambioDTO getCategoriasCambio() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[23]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getCategoriasCambio"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriaCambioDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriaCambioDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriaCambioDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaOutDTO altaCuentaSubCuenta(dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaInDTO cuentaIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[24]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "AltaCuentaSubCuenta"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {cuentaIn, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String pruebaJMS(java.lang.String prueba) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[25]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "pruebaJMS"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {prueba});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO altaDeLinea(dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaDTO altaLinea, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[26]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "AltaDeLinea"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {altaLinea, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSCentralQuioscoOutDTO getCentralesQuiosco() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[27]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getCentralesQuiosco"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSCentralQuioscoOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSCentralQuioscoOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSCentralQuioscoOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriasClienteOutDTO getListCategorias() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[28]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListCategorias"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriasClienteOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriasClienteOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriasClienteOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTiendaOutDTO insertTienda(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO tiendaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[29]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "insertTienda"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {tiendaDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTiendaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTiendaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTiendaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public void registraCampanaBeneficio(dto.commonapp.scl.cl.tmmas.com.WsRegistraCampanaByPInDTO registraCampanaByPIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[30]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "registraCampanaBeneficio"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {registraCampanaByPIn});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        extractAttachments(_call);
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendasOutDTO getTiendas() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[31]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getTiendas"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendasOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendasOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendasOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioInDTO inWSLstPlanTarifDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[32]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListadoPlanesTarifarios"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {inWSLstPlanTarifDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public float getImpuesto(java.lang.String codigoVendedor) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[33]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getImpuesto"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {codigoVendedor});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Float) _resp).floatValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Float) org.apache.axis.utils.JavaUtils.convert(_resp, float.class)).floatValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[34]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "solicitaBajaAbonadoPrepago"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {solicitudBajaAbonadoDTO, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO altaDeStructuraComercial(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsCreaStructuraComercialInDTO wsCreaStructuraComercial) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[35]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "AltaDeStructuraComercial"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {wsCreaStructuraComercial});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaOutDTO getCargosFacturacion(dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaInDTO wsFacturacionVentaIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[36]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getCargosFacturacion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {wsFacturacionVentaIn});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public transport.serviciospostventasiga.scl.tmmas.com.MigracionPrepagoPostpagoDTO WSMigracionClientePrepagoAPostpago(transport.serviciospostventasiga.scl.tmmas.com.MigracionDTO migracionDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[37]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "WSMigracionClientePrepagoAPostpago"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {migracionDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (transport.serviciospostventasiga.scl.tmmas.com.MigracionPrepagoPostpagoDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (transport.serviciospostventasiga.scl.tmmas.com.MigracionPrepagoPostpagoDTO) org.apache.axis.utils.JavaUtils.convert(_resp, transport.serviciospostventasiga.scl.tmmas.com.MigracionPrepagoPostpagoDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO[] recuperaDatoTipificacion(java.lang.String datoTipificacion, java.lang.String codVendedor) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[38]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "recuperaDatoTipificacion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {datoTipificacion, codVendedor});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO[]) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String getZip(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO direccion) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[39]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getZip"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {direccion});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTarjetaOutDTO getListadoTarjetas() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[40]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListadoTarjetas"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTarjetaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTarjetaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTarjetaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.WsDireccionOutDTO agregarDireccion(dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO wsDireccionesIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[41]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "agregarDireccion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {wsDireccionesIn, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.WsDireccionOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.WsDireccionOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.WsDireccionOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.WsAltaClienteOutDTO altaCliente(dto.commonapp.scl.cl.tmmas.com.WsCuentaInNDTO cuenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[42]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "AltaCliente"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {cuenta, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.WsAltaClienteOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.WsAltaClienteOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.WsAltaClienteOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListBancoOutDTO getListadoBancosPAC() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[43]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListadoBancosPAC"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListBancoOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListBancoOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListBancoOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO getSSincluidosEnPlan(java.lang.String codigoPlanTarifario) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[44]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getSSincluidosEnPlan"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {codigoPlanTarifario});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO[] obtieneListaTienda() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[45]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "obtieneListaTienda"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO[]) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.SSuplementarioOutDTO setAgregaEliminaSS(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO[] sSuplemenAgregar, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO[] sSuplemenEliminar, java.lang.Long numeroCelular, java.lang.String nomUsuario, int rollback) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[46]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "setAgregaEliminaSS"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {sSuplemenAgregar, sSuplemenEliminar, numeroCelular, nomUsuario, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.SSuplementarioOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.SSuplementarioOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.SSuplementarioOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoOutDTO altaDeLineaBusito(dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoInDTO altaDeLineaBusitoIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[47]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "AltaDeLineaBusito"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {altaDeLineaBusitoIn});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.AceptacionVentaOutDTO aceptacionVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsAceptacionVentaInDTO aceptacionVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[48]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "aceptacionVenta"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {aceptacionVenta, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.AceptacionVentaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.AceptacionVentaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.AceptacionVentaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO getSSOpcionalesAlPlan(java.lang.String codigoPlanTarifario, java.lang.String codigoArticulo, java.lang.String codigCentral) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[49]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getSSOpcionalesAlPlan"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {codigoPlanTarifario, codigoArticulo, codigCentral});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CierreVentaOutDTO cierreVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsCierreVentaInDTO cierreVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[50]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "cierreVenta"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {cierreVenta, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CierreVentaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CierreVentaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CierreVentaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.WsDatosDireccionOutDTO getDatosDireccion(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionDTO direccionDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[51]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getDatosDireccion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {direccionDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.WsDatosDireccionOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.WsDatosDireccionOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.WsDatosDireccionOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTipificacionOutDTO insertarTipificacion(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO tipificaClientizaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[52]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "insertarTipificacion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {tipificaClientizaDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTipificacionOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTipificacionOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTipificacionOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoTiposIdentificacionOutDTO getTiposIdentificacion() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[53]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getTiposIdentificacion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoTiposIdentificacionOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoTiposIdentificacionOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoTiposIdentificacionOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsUpdateTiendaOutDTO updateTienda(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO tiendaModDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[54]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "updateTienda"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {tiendaModDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsUpdateTiendaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsUpdateTiendaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsUpdateTiendaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono(java.lang.String id_transaccion) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[55]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "recuperarAltaAsincrono"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {id_transaccion});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoProvinciasOutDTO getListadoProvincias(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO regionDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[56]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListadoProvincias"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {regionDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoProvinciasOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoProvinciasOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoProvinciasOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoComunasOutDTO getListadoComunas(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO ciudadDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[57]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "getListadoComunas"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {ciudadDTO});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoComunasOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoComunasOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoComunasOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaOutDTO procesoDeFacturacion(dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaInDTO wsFacturacionVentaIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[58]);
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://com/tmmas/cl/scl/spnsclws/ws", "ProcesoDeFacturacion"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {wsFacturacionVentaIn, new java.lang.Integer(rollback)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaOutDTO) _resp;
            } catch (java.lang.Exception _exception) {
                return (dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaOutDTO) org.apache.axis.utils.JavaUtils.convert(_resp, dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaOutDTO.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof exception.framework.cl.tmmas.com.GeneralException) {
              throw (exception.framework.cl.tmmas.com.GeneralException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

}
