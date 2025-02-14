package generated.webservices.orquestador
{
	 import mx.rpc.xml.Schema
	 public class BaseWSSEGPortalSchema
	{
		 public var schemas:Array = new Array();
		 public var targetNamespaces:Array = new Array();
		 public function BaseWSSEGPortalSchema():void
		{
			 var xsdXML15:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax212="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax213="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax217="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax219="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax221="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax223="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax225="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax227="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax229="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax24="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax26="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ax27="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ax29="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:complexType name="AbonoLimiteConsumoServicioSuplementarioVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="checked" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codPlanTarif" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="limiteactual" type="xs:double"/>
            <xs:element minOccurs="0" name="nomservicio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="servicio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="vallimcons" type="xs:double"/>
            <xs:element minOccurs="0" name="valmin" type="xs:double"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="SiniestrosVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCausa" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCausa" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desEstado" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipTerminal" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecFormalizacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecSiniestro" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numConstancia" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numSiniestro" type="xs:long"/>
            <xs:element minOccurs="0" name="observacion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="BloqueArticulosVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codArt" type="xs:int"/>
            <xs:element minOccurs="0" name="desArt" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="BloqueUsosVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codUso" type="xs:int"/>
            <xs:element minOccurs="0" name="desUso" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CausasCambioVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCauCambio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCauCambio" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="PlanTarifarioVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCargoBasico" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codPlanTarif" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCargoBasico" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desPlanTarif" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="valorCargoBasico" type="xs:double"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="TiposContratosVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codTipContrato" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipContrato" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="vigContrato" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="TiposTerminalesVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codTipTerminal" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipTerminal" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="BloqueSuspensionesActivasVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCargoBasico" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codNR" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codNivelSrvSupl" type="xs:int"/>
            <xs:element minOccurs="0" name="codSrvSupl" type="xs:int"/>
            <xs:element minOccurs="0" name="codSrvSusp" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desNivelSrvSupl" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desSrvSupl" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desSrvSusp" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nivelReha" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipoSuspension" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CargosVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codArticulo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codBodega" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codConcDto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codConcepto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codMoneda" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desMoneda" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desServicio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="impTarifa" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indAutManCarg" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indCargoEquipo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indCargoOcasional" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indEquipo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numSerie" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numUnidades" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipoDto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="valDto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="valMax" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="valMin" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CausasSuspensionVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCauSusp" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCauSusp" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ServicioSuspensionVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codSrvSusp" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desSrvSusp" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DetalleAjusteVO">
        <xs:complexContent>
            <xs:extension base="ax27:ComunesAjusteCExcepcionCargosVO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="codProducto" type="xs:int"/>
                    <xs:element minOccurs="0" name="importeConcepto" type="xs:double"/>
                    <xs:element minOccurs="0" name="numAbonado" type="xs:int"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="NumeroFrecuenteFijoVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="numFrecFijos" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="NumeroFrecuenteMovilVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="numFrecMoviles" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CausasPagoVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCauPago" type="xs:int"/>
            <xs:element minOccurs="0" name="desCauPago" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="NotaCreditoVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codNC" type="xs:int"/>
            <xs:element minOccurs="0" name="desNC" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="OrigenPagoVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codOriPago" type="xs:int"/>
            <xs:element minOccurs="0" name="desOriPago" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="NotaDebitoVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codND" type="xs:int"/>
            <xs:element minOccurs="0" name="desND" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema15:Schema = new Schema(xsdXML15);
			schemas.push(xsdSchema15);
			targetNamespaces.push(new Namespace('','http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML13:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax212="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax213="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax217="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax219="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax221="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax223="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax225="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax227="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax229="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax26="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ax27="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ax29="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://vo.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:complexType name="ComunesAjusteCExcepcionCargosVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCentrEmi" type="xs:int"/>
            <xs:element minOccurs="0" name="codTipDocum" type="xs:int"/>
            <xs:element minOccurs="0" name="codVendedor" type="xs:long"/>
            <xs:element minOccurs="0" name="letra" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="monto" type="xs:double"/>
            <xs:element minOccurs="0" name="nroSecuencia" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema13:Schema = new Schema(xsdXML13);
			schemas.push(xsdSchema13);
			targetNamespaces.push(new Namespace('','http://vo.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML1:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax228="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:complexType name="EjecucionCambioDatosIdentificacionClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codTipoIdentificacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numIdentificacion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema1:Schema = new Schema(xsdXML1);
			schemas.push(xsdSchema1);
			targetNamespaces.push(new Namespace('','http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML9:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax210="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax211="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax212="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax214="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax226="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax228="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax25="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:import namespace="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:complexType name="CargaCambioDatosBancariosDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayBancosTarjetaVO" nillable="true" type="ns6:BancosVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayBancosVO" nillable="true" type="ns6:BancosVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arraySistemaPagoVO" nillable="true" type="ns6:SistemaPagoVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayTiposTarjetaVO" nillable="true" type="ns6:TiposTarjetaVO"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="EjecucionCambioDatosBancariosDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codBanco" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codBancoTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codSisPago" nillable="true" type="xs:int"/>
            <xs:element minOccurs="0" name="codSucursal" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desIndDebito" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="limPago" nillable="true" type="xs:decimal"/>
            <xs:element minOccurs="0" name="numCuentaCte" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipoCuentaCte" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="vencTarjeta" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema9:Schema = new Schema(xsdXML9);
			schemas.push(xsdSchema9);
			targetNamespaces.push(new Namespace('','http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML12:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax212="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax213="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax217="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax219="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax221="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax223="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax225="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax227="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax229="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax26="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ax29="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:complexType name="TipoIdentificacionVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codTipident" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipident" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="TipoIdiomaVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codIdioma" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcionIdioma" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="TipoInformacionPersonalVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codTipoInfoPersonal" type="xs:int"/>
            <xs:element minOccurs="0" name="desTipo" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema12:Schema = new Schema(xsdXML12);
			schemas.push(xsdSchema12);
			targetNamespaces.push(new Namespace('','http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML17:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax212="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax213="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax217="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax218="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax219="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax220="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax221="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax222="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax224="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax227="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax229="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax24="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax26="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ax27="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:import namespace="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:complexType name="CargaCambioDatosPersonalesClienteDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayTiposIdentificacionVO" nillable="true" type="ns12:TipoIdentificacionVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayTiposIdiomaVO" nillable="true" type="ns12:TipoIdiomaVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayTiposInformacionVO" nillable="true" type="ns12:TipoInformacionPersonalVO"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="EjecucionCambioDatosPersonalesClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="apellido1" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="apellido2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codIdioma" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipIdent2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipoInfoPersonal" type="xs:int"/>
            <xs:element minOccurs="0" name="email" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numFax" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numIdent2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numTelefono" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numTelefono2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="referencia" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema17:Schema = new Schema(xsdXML17);
			schemas.push(xsdSchema17);
			targetNamespaces.push(new Namespace('','http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML6:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax211="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax214="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax216="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax226="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax228="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:complexType name="BancosVO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arraySucursalesVO" nillable="true" type="ns6:SucursalVO"/>
            <xs:element minOccurs="0" name="codBanco" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomBanco" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="SucursalVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codSucursal" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomSucursal" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="SistemaPagoVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codSisPago" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="indicador" nillable="true" type="xs:int"/>
            <xs:element minOccurs="0" name="nomSisPago" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="TiposTarjetaVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codTipTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomtarjeta" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema6:Schema = new Schema(xsdXML6);
			schemas.push(xsdSchema6);
			targetNamespaces.push(new Namespace('','http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML7:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax211="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax214="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax216="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax226="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax228="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:complexType name="ActividadVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codActividad" nillable="true" type="xs:int"/>
            <xs:element minOccurs="0" name="desActividad" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="OficinaVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codOficina" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desOficina" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="PaisVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codPais" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desPais" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema7:Schema = new Schema(xsdXML7);
			schemas.push(xsdSchema7);
			targetNamespaces.push(new Namespace('','http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML3:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax214="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax216="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax226="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax228="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:import namespace="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:complexType name="CargaCambioDatosGeneralesClienteDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayActividadVO" nillable="true" type="ax216:ActividadVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOficinaVO" nillable="true" type="ax216:OficinaVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayPaisVO" nillable="true" type="ax216:PaisVO"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="EjecucionCambioDatosGeneralesClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codActividad" nillable="true" type="xs:int"/>
            <xs:element minOccurs="0" name="codOficina" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codPais" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema3:Schema = new Schema(xsdXML3);
			schemas.push(xsdSchema3);
			targetNamespaces.push(new Namespace('','http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML5:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax214="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax216="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax226="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax228="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://exception.framework.cl.tmmas.com/xsd">
    <xs:complexType name="GeneralException">
        <xs:complexContent>
            <xs:extension base="ns14:Exception">
                <xs:sequence>
                    <xs:element minOccurs="0" name="cause" nillable="true" type="xs:anyType"/>
                    <xs:element minOccurs="0" name="codigo" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="codigoEvento" type="xs:long"/>
                    <xs:element minOccurs="0" name="descripcionEvento" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="message" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="messageUser" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="trace" nillable="true" type="xs:string"/>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="traces" nillable="true" type="xs:anyType"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema5:Schema = new Schema(xsdXML5);
			schemas.push(xsdSchema5);
			targetNamespaces.push(new Namespace('','http://exception.framework.cl.tmmas.com/xsd'));
			 var xsdXML0:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://dto.common.wsportal.scl.tmmas.com/xsd">
    <xs:complexType name="AbonadoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="apellidoMaterno" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="apellidoPaterno" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codCuenta" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codUso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desSituacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAlta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAltaOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecBaja" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecBajaOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numAbonado" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="numCelular" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="numVenta" nillable="true" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DetalleAbonadoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codPlanTarif" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codSituacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipContrato" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codUso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codUsuario" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desPlanTarif" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desSituacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipContrato" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAceptVenta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecActCen" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAlta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecBaja" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecFinContrato" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="gama" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numAbonado" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="numCelular" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="numVenta" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="tipoPlan" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DetalleClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCatImpositiva" type="xs:int"/>
            <xs:element minOccurs="0" name="codCatribut" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codCiclo" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCatImpositiva" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCategoria" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipIndet" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="email" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="esDealer" type="xs:int"/>
            <xs:element minOccurs="0" name="fecAceptVenta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAlta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecBaja" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecVenciTarj" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indDebito" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="ingresoSalarial" type="xs:long"/>
            <xs:element minOccurs="0" name="nomCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numIdent" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="telCliente1" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="tipPersona" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DetalleCuentaDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCuenta" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCategoria" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCuenta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipIdent" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAlta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomResponsable" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numIdent" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="telContacto" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="tipCuenta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="totClientes" nillable="true" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DetalleDireccionDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCiudad" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codComuna" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codProvincia" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codRegion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCiudad" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desComuna" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desProvincia" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desRegion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomCalle" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numCalle" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numPiso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="obsDireccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="obsDireccion2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="zip" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DetallePlanTarifarioDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCargoBasico" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codLimiteConsumo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codPlanTarifario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desPlanTarifario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="impLimiteConsumo" nillable="true" type="xs:double"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DeudaClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="deudaTotal" type="xs:float"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DatosDireccionClienteINDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codDisplay" nillable="true" type="xs:int"/>
            <xs:element minOccurs="0" name="codTipDireccion" nillable="true" type="xs:int"/>
            <xs:element minOccurs="0" name="conDescripcion" nillable="true" type="xs:boolean"/>
            <xs:element minOccurs="0" name="tipSujeto" nillable="true" type="xs:int"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DireccionPorClienteDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayValorCampos" nillable="true" type="ax28:ValorCampoDireccionDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ValorCampoDireccionDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codParamDir" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codValor" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desValor" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="secDat" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipDat" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="EquipoSimcardDetalleDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codArticuloEquipo" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codArticuloSimcard" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codGama" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codModeloEquipo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codModeloSimcard" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desArticuloEquipo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desArticuloSimcard" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desGama" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTecnologia" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaAltaEquipo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaAltaSimcard" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indEquipoPrestado" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indProcEquipo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indProcSimcard" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numImei" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numSerieEquipo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numSerieSimcard" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListaAtencionClienteDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayAtencionCliente" nillable="true" type="ax28:AtencionClienteDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="AtencionClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codAtencion" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="desAtencion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="grpAtencion" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="indObserv" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numNivel" nillable="true" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListaCausalCambioDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="causalCambioDTO" nillable="true" type="ax28:CausalCambioDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CausalCambioDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCaucaser" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCaucaser" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoAbonadosDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayAbonados" nillable="true" type="ax28:AbonadoDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoAjustesDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayAjustes" nillable="true" type="ax28:AjusteDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="AjusteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codTipDocum" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="concepto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipDocum" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="factura" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecEfectividad" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="importeDebe" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="numSecuencia" nillable="true" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoBeneficiosDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayBeneficios" nillable="true" type="ax28:BeneficioDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="BeneficioDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="cntPeriodos" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codPlan" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desEstado" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desPlan" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTiplan" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecEstado" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecEstadoOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecIngreso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecIngresoOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="valAcumulado" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="valBeneficio" nillable="true" type="xs:double"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoCambiosPlanTarifDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCambiosPlanTarif" nillable="true" type="ax28:CambioPlanTarifDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CambioPlanTarifDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desPlanTarifDestino" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desPlanTarifOrigen" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaDesde" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="usuario" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoCamposDireccionDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCampos" nillable="true" type="ax28:CampoDireccionDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CampoDireccionDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="caption" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codParamDir" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indObligatorio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="largo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="orden" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="secDat" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipDat" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoClientesDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayClientes" nillable="true" type="ax28:ClienteDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codCuenta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAlta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAltaOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipPersona" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoConsultasDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayProcesos" nillable="true" type="ax28:ConsultaDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ConsultaDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codProceso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desProceso" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoCuentasCorrientesDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCarteras" nillable="true" type="ax28:CuentaCorrienteDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CuentaCorrienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="acumNetoGrav" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codTipDocumento" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="desTipDocumento" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="importeDebe" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="importeHaber" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="numAbonado" nillable="true" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoCuentasDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCuentas" nillable="true" type="ax28:CuentaDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CuentaDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCuenta" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="desCuenta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAlta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAltaOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipCuenta" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoDetalleLlamadosDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayLlamadas" nillable="true" type="ax28:DetalleLlamadaDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DetalleLlamadaDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="celularDest" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="celularOrig" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="duracion" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="fechaLlamada" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="horario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="valor" nillable="true" type="xs:double"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoDireccionesDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayDirecciones" nillable="true" type="ax28:DireccionDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DireccionDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codDireccion" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codTipDireccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipDireccion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="GetDocsClienteINDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="fecFin" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecInicio" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoDocCtaCteClienteDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayDocumentos" nillable="true" type="ax28:DocCtaCteClienteDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DocCtaCteClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="acumNetoGrav" nillable="true" type="xs:float"/>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codTipDocum" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desObserva" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipDocum" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecEmision" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecEmisionOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecVencimiento" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecVencimientoOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="importeDebe" nillable="true" type="xs:float"/>
            <xs:element minOccurs="0" name="indOrdenTotal" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="numFolio" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="textoDetalle" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="totalIVA" nillable="true" type="xs:float"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoFacturasDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayFacturas" nillable="true" type="ax28:FacturaDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="FacturaDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="acumIva" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="codCiclo" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="desTipDocumento" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecEmision" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecEmisionOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecVencimiento" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecVencimientoOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numFolio" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="totFactura" nillable="true" type="xs:double"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoGruposDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayGrupos" nillable="true" type="ax28:GrupoDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="GrupoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codGrupo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desGrupo" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoLimiteConsumoDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayLimitesConsumo" nillable="true" type="ax28:LimiteConsumoDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="LimiteConsumoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="acuConsumo" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="codLimCons" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codUmbralMin" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desUmbral" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoNumerosFrecuentesDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayNumerosFrecuentes" nillable="true" type="ax28:NumeroFrecuenteDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="NumeroFrecuenteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="numTelefEspecial" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipNumFrecuente" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoOrdenesAgendadasDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOOSS" nillable="true" type="ax28:OOSSAgendadaDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="OOSSAgendadaDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codEstado" nillable="true" type="xs:int"/>
            <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desProceso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcionOOSS" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaEjecucion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaIngreso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numOOSS" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="status" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="usuario" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoOrdenesProcesoDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOOSS" nillable="true" type="ax28:OOSSProcesoDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="OOSSProcesoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codOOSS" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcionOOSS" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaIngreso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numOOSS" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="status" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipEstado" nillable="true" type="xs:int"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoOrdenesServicioDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOOSS" nillable="true" type="ax28:OOSSEjecutadaDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="OOSSEjecutadaDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codigo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaEjecucion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaEjecucionOrd" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numOOSS" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="status" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="textoDetalle" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoPagosDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayPagos" nillable="true" type="ax28:PagoDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="PagoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codTipDocum" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="desTipDocum" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecEfectividad" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="impPago" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="numSecuencia" nillable="true" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoPagosLimiteConsumoDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayPagosLimiteConsumo" nillable="true" type="ax28:PagoLimiteConsumoDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="PagoLimiteConsumoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="desPago" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecValor" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="impPago" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="nomUsuarora" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoProductosDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayProductos" nillable="true" type="ax28:ProductoDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ProductoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codConcepto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codProducto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desProducto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="estadoAltBaj" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecBajaBD" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecBajaCentral" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechAltaBD" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechAltaCentral" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="importeCargoBasico" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="textoDetalle" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoReporteCamEquiGenDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="reporteCamEquiGenDTO" nillable="true" type="ax28:ReporteCamEquiGenDTO"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ReporteCamEquiGenDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="abonado" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="causalCambio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="celular" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiAntMarca" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiAntModelo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiAntSerie" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiAnterior" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiCamMarca" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiCamModelo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiCamSerie" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiCambio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecCambio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipTerminal" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoReporteIngrStatusEquiDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="reporteIngrStatusEquiDTO" nillable="true" type="ax28:ReporteIngrStatusEquiDTO"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ReporteIngrStatusEquiDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="abonado" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="celular" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiMarca" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiModelo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiSerie" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equipo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="etapa" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecIngr" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="status" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="stsFecha" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="stsStatus" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="stsUsuario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipTerminal" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoReportePresEquiIntDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="reportePresEquiIntDTO" nillable="true" type="ax28:ReportePresEquiIntDTO"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ReportePresEquiIntDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="abonado" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiMarca" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiModelo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equiSerie" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="equipo" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecPrestamo" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoServSuplementariosDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arraySS" nillable="true" type="ax28:ServSuplementarioDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ServSuplementarioDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="aplica" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codServicio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desConcepto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desServicio" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAltaBD" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecAltaCEN" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="impTarifa" nillable="true" type="xs:double"/>
            <xs:element minOccurs="0" name="numAbonado" nillable="true" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoServSuplxOOSSDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayServSupl" nillable="true" type="ax28:ServSuplXOOSSDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ServSuplXOOSSDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="accion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codServSupl" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desServSupl" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoUmtsAbonadosDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayUmtsAbonados" nillable="true" type="ax28:UmtsAbonadoDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="UmtsAbonadoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codSituacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTecnologia" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipoPlan" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desSituacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTecnologia" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipoPlan" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="total" type="xs:int"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="MenuDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOOSSXAbonado" nillable="true" type="ax28:OOSSXAbonadoDTO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOOSSXCliente" nillable="true" type="ax28:OOSSXClienteDTO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOOSSXCuenta" nillable="true" type="ax28:OOSSXCuentaDTO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOOSSXUsuario" nillable="true" type="ax28:OOSSXUsuarioDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codUsuario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nombreOperador" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="oficina" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="OOSSXAbonadoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codOOSS" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desValor" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="OOSSXClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codOOSS" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desValor" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="OOSSXCuentaDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codOOSS" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desValor" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="OOSSXUsuarioDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codOOSS" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desValor" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ResulTransaccionDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codRetorno" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="menRetorno" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numEvento" nillable="true" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="MuestraURLDTO">
        <xs:complexContent>
            <xs:extension base="ax28:ResulTransaccionDTO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="strUrlDomPuer" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="ParametrosKioscoDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="dominioKiosco" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="flagKiosco" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ResgistroAtencionDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codAtencion" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="fechaFin" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaIni" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsua" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numAbonado" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="observacion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema0:Schema = new Schema(xsdXML0);
			schemas.push(xsdSchema0);
			targetNamespaces.push(new Namespace('','http://dto.common.wsportal.scl.tmmas.com/xsd'));
			 var xsdXML10:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax210="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax212="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax213="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax217="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax221="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax225="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax227="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax229="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax26="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ax29="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://dto.wsseguridad.scl.tmmas.com/xsd">
    <xs:import namespace="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:import namespace="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:import namespace="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:import namespace="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:import namespace="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:import namespace="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:import namespace="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:complexType name="EjecucionAjusteCExcepcionCargosSACDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayDetalleAjusteSACVO" nillable="true" type="ax26:DetalleAjusteSACVO"/>
            <xs:element minOccurs="0" name="codCauPago" type="xs:int"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codNC" type="xs:int"/>
            <xs:element minOccurs="0" name="codOriPago" type="xs:int"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desNC" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="montoTotalAjuste" type="xs:double"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="observacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipoAjuste" type="xs:int"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DetalleAjusteSACVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCentrEmi" type="xs:int"/>
            <xs:element minOccurs="0" name="codProducto" type="xs:int"/>
            <xs:element minOccurs="0" name="codTipDocum" type="xs:int"/>
            <xs:element minOccurs="0" name="codVendedor" type="xs:long"/>
            <xs:element minOccurs="0" name="importeConcepto" type="xs:double"/>
            <xs:element minOccurs="0" name="letra" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="monto" type="xs:double"/>
            <xs:element minOccurs="0" name="nroSecuencia" type="xs:long"/>
            <xs:element minOccurs="0" name="numAbonado" type="xs:int"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="EjecucionAjusteCReversionCargosSACDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayDetalleAjusteSACVO" nillable="true" type="ax26:DetalleAjusteSACVO"/>
            <xs:element minOccurs="0" name="codCauPago" type="xs:int"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codND" type="xs:int"/>
            <xs:element minOccurs="0" name="codOriPago" type="xs:int"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desND" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecVencimiento" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="montoTotalAjuste" type="xs:double"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="observacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipoAjuste" type="xs:int"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CargaAjusteCExcepcionCargosSACDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCausasPagoVO" nillable="true" type="ax29:CausasPagoVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayFoliosFacturasVO" nillable="true" type="ax26:FoliosFacturasSACVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayNotaCreditoVO" nillable="true" type="ax29:NotaCreditoVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOrigenPagoVO" nillable="true" type="ax29:OrigenPagoVO"/>
            <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nombreCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="password" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="saldoCliente" type="xs:double"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="FoliosFacturasSACVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCentrEmi" type="xs:int"/>
            <xs:element minOccurs="0" name="codTipDocum" type="xs:int"/>
            <xs:element minOccurs="0" name="codVendedor" type="xs:long"/>
            <xs:element minOccurs="0" name="desAbreviada" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecEfectividad" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fecVencimiento" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indContado" type="xs:int"/>
            <xs:element minOccurs="0" name="letra" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="monto" type="xs:double"/>
            <xs:element minOccurs="0" name="nroFolio" type="xs:long"/>
            <xs:element minOccurs="0" name="nroSecuencia" type="xs:long"/>
            <xs:element minOccurs="0" name="numVenta" type="xs:long"/>
            <xs:element minOccurs="0" name="prefPlaza" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CargaAjusteCReversionCargosSACDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCausasPagoVO" nillable="true" type="ax29:CausasPagoVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayFoliosFacturasVO" nillable="true" type="ax26:FoliosFacturasSACVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayNotaDebitoVO" nillable="true" type="ax29:NotaDebitoVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOrigenPagoVO" nillable="true" type="ax29:OrigenPagoVO"/>
            <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nombreCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="password" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="saldoCliente" type="xs:double"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CargaCambioDatosClienteSACDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="apellido1" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="apellido2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="cargaCambioDatosBancariosDTO" nillable="true" type="ax210:CargaCambioDatosBancariosDTO"/>
            <xs:element minOccurs="0" name="cargaCambioDatosGeneralesClienteDTO" nillable="true" type="ns3:CargaCambioDatosGeneralesClienteDTO"/>
            <xs:element minOccurs="0" name="cargaCambioDatosPersonalesClienteDTO" nillable="true" type="ax221:CargaCambioDatosPersonalesClienteDTO"/>
            <xs:element minOccurs="0" name="cargaCambioDatosTributariosClienteDTO" nillable="true" type="ax225:CargaCambioDatosTributariosClienteDTO"/>
            <xs:element minOccurs="0" name="codActividad" nillable="true" type="xs:int"/>
            <xs:element minOccurs="0" name="codBanco" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codBancoTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codCatImpositiva" type="xs:int"/>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codCuenta" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codIdioma" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codNpi" type="xs:int"/>
            <xs:element minOccurs="0" name="codOficina" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codPais" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codPinCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codSisPago" nillable="true" type="xs:int"/>
            <xs:element minOccurs="0" name="codSucursal" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipIdent" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipIdent2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipIdentTrib" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desCuenta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desIdioma" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desIndDebito" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desNpi" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desSisPago" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipIdent" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipIdent2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desTipIdentTrib" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="email" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indTraspaso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="limPago" nillable="true" type="xs:decimal"/>
            <xs:element minOccurs="0" name="nomBanco" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomBancoTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomSucursal" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomTipTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numCuentaCte" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numFax" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numIdent" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numIdent2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numIdentTrib" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numTarjeta" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numTelefono" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numTelefono2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipoCuentaCte" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="vencTarjeta" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CargaCambioNumFrecuentesSACDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayNumFrecuentesPlan" nillable="true" type="ns2:NumFrecuentesFirmaVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayNumFrecuentesSS" nillable="true" type="ns2:NumFrecuentesFirmaVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayTipoNumFrecuentes" nillable="true" type="ns2:TipoNumFrecuenteFirmaVO"/>
            <xs:element minOccurs="0" name="cantRedFija" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="cantRedFijaSS" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="cantRedMovil" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="cantRedMovilSS" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="cantidadMaximoTotal" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="cantidadMaximoTotalSS" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codCliente" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codPlantarif" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desPlantarif" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="mensajeNumFrec" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numAbonado" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="numCelular" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CargaOSGenericaDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DireccionSACDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codigoPostal" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcionDireccion1" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="descripcionDireccion2" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="fechaActivacion" nillable="true" type="xs:dateTime"/>
            <xs:element minOccurs="0" name="idCiudad" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="idComuna" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="idProvincia" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="idRegion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="idTecnologia" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="idTipoDireccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nombreCalle" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nombreCiudad" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nombreCliente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nombreComuna" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nombreProvincia" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nombreRegion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numeroCalle" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numeroPiso" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="observacion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipoDireccion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ConsultarOrdenServicioSACDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="servicio" type="xs:int"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="EjecucionCambioDatosClienteSACDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="ejecucionCambioDatosBancariosDTO" nillable="true" type="ax210:EjecucionCambioDatosBancariosDTO"/>
            <xs:element minOccurs="0" name="ejecucionCambioDatosGeneralesClienteDTO" nillable="true" type="ns3:EjecucionCambioDatosGeneralesClienteDTO"/>
            <xs:element minOccurs="0" name="ejecucionCambioDatosIdentificacionClienteDTO" nillable="true" type="ns1:EjecucionCambioDatosIdentificacionClienteDTO"/>
            <xs:element minOccurs="0" name="ejecucionCambioDatosPersonalesClienteDTO" nillable="true" type="ax221:EjecucionCambioDatosPersonalesClienteDTO"/>
            <xs:element minOccurs="0" name="ejecucionCambioDatosTributariosClienteDTO" nillable="true" type="ax225:EjecucionCambioDatosTributariosClienteDTO"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="EjecucionCambioNumFrecuentesSACDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="bloqueNumFrecuentePlanTarifarioEliminar" nillable="true" type="ns2:NumFrecuentesFirmaVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="bloqueNumFrecuentePlanTarifarioInsertar" nillable="true" type="ns2:NumFrecuentesFirmaVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="bloqueNumFrecuenteServicioSuplementarioEliminar" nillable="true" type="ns2:NumFrecuentesFirmaVO"/>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="bloqueNumFrecuenteServicioSuplementarioInsertar" nillable="true" type="ns2:NumFrecuentesFirmaVO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numAbonado" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="FiltroDetDocAjusteCCargosSACDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayDetalleDocumentoVO" nillable="true" type="ax26:DetalleDocumentoSACVO"/>
            <xs:element minOccurs="0" name="codCentrEmi" type="xs:int"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="codTipDocum" type="xs:int"/>
            <xs:element minOccurs="0" name="codVendedor" type="xs:int"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="letra" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="nroSecuencia" type="xs:int"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="DetalleDocumentoSACVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCentrEmi" type="xs:int"/>
            <xs:element minOccurs="0" name="codProducto" type="xs:int"/>
            <xs:element minOccurs="0" name="codTipDocum" type="xs:int"/>
            <xs:element minOccurs="0" name="codVendedor" type="xs:long"/>
            <xs:element minOccurs="0" name="desProducto" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="indContado" type="xs:int"/>
            <xs:element minOccurs="0" name="letra" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="monto" type="xs:double"/>
            <xs:element minOccurs="0" name="montoNIC" type="xs:double"/>
            <xs:element minOccurs="0" name="nroSecuencia" type="xs:long"/>
            <xs:element minOccurs="0" name="numAbonado" type="xs:int"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoDireccionesSACDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayDirecciones" nillable="true" type="ax26:DireccionSACDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="ListadoOrdenesServicioSACDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayOOSS" nillable="true" type="ax26:ConsultarOrdenServicioSACDTO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="RealizarBloqueoRoboSACINDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="causaSiniestro" type="xs:long"/>
            <xs:element minOccurs="0" name="numCelular" type="xs:long"/>
            <xs:element minOccurs="0" name="tipoSiniestro" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipoSusp" type="xs:long"/>
            <xs:element minOccurs="0" name="usuario" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="RealizarBloqueoRoboSACOUTDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="causaSiniestro" type="xs:long"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numCelular" type="xs:long"/>
            <xs:element minOccurs="0" name="numSolEqu" type="xs:long"/>
            <xs:element minOccurs="0" name="numSolSim" type="xs:long"/>
            <xs:element minOccurs="0" name="tipoSiniestro" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipoSusp" type="xs:long"/>
            <xs:element minOccurs="0" name="usuario" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema10:Schema = new Schema(xsdXML10);
			schemas.push(xsdSchema10);
			targetNamespaces.push(new Namespace('','http://dto.wsseguridad.scl.tmmas.com/xsd'));
			 var xsdXML4:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax214="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax216="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax226="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax228="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://exception.common.wsportal.scl.tmmas.com/xsd">
    <xs:complexType name="PortalSACException">
        <xs:complexContent>
            <xs:extension base="ns5:GeneralException">
                <xs:sequence/>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema4:Schema = new Schema(xsdXML4);
			schemas.push(xsdSchema4);
			targetNamespaces.push(new Namespace('','http://exception.common.wsportal.scl.tmmas.com/xsd'));
			 var xsdXML14:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax212="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax213="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax217="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax219="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax221="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax223="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax225="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax227="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax229="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax26="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ax27="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ax29="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://wsservices.wsseguridad.scl.tmmas.com">
    <xs:complexType name="Exception">
        <xs:sequence>
            <xs:element minOccurs="0" name="Exception" nillable="true" type="xs:anyType"/>
        </xs:sequence>
    </xs:complexType>
    <xs:element name="PortalSACException">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="PortalSACException" nillable="true" type="ax21:PortalSACException"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAbonoLimiteConsumo">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codSujeto" type="xs:long"/>
                <xs:element minOccurs="0" name="tipoAbono" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAbonoLimiteConsumoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:CargaAbonoLimConDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAbonoLimiteConsumoSS">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codSujeto" type="xs:long"/>
                <xs:element minOccurs="0" name="tipoAbono" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="tipoOOSS" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAbonoLimiteConsumoSSResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:CargaAbonoLimiteConsumoServicioSuplementarioDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAnulacionSiniestro">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAnulacionSiniestroResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:CargaAnulacionSiniestroDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarCambioEquipoGSM">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarCambioEquipoGSMResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:CargaCambioEquipoGSMDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarCambioPlanPostPagoIndividual">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarCambioPlanPostPagoIndividualResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:CargaCambioPlanPostPagoIndividualDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarCambioSIMCard">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarCambioSIMCardResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:CargaCambioSIMCardDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarReposicionSrvCelular">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarReposicionSrvCelularResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:CargaReposicionSrvCelDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaServicioCargos">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:CargaServicioCargosDTO"/>
                <xs:element minOccurs="0" name="ventaSimcard" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaServicioCargosResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:CargaServicioCargosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarSuspensionSrvCelular">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarSuspensionSrvCelularResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:CargaSuspensionSrvCelDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAbonoLimiteConsumo">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:EjecucionAbonoLimConDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAbonoLimiteConsumoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionAbonoLimConDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAbonoLimiteConsumoSS">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAbonoLimiteConsumoSSResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAjusteCExcepcionCargos">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ax26:EjecucionAjusteCExcepcionCargosSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAjusteCExcepcionCargosResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionAjusteCExcepcionCargosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAjusteCReversionCargos">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ax26:EjecucionAjusteCReversionCargosSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAjusteCReversionCargosResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionAjusteCReversionCargosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAnulacionSiniestro">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:EjecucionAnulacionSiniestroDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarAnulacionSiniestroResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionAnulacionSiniestroDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarCambioEquipoGSM">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:EjecucionCambioEquipoGSMDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarCambioEquipoGSMResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionCambioEquipoGSMDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarCambioPlanPostPagoIndividual">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:EjecucionCambioPlanPostPagoIndividualDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarCambioPlanPostPagoIndividualResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionCambioPlanPostPagoIndividualDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarCambioSIMCard">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:EjecucionCambioSIMCardDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarCambioSIMCardResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionCambioSIMCardDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarReposicionSrvCelular">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:EjecucionReposicionSrvCelDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarReposicionSrvCelularResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionReposicionSrvCelDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecucionServicioCargos">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:EjecucionServicioCargosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecucionServicioCargosResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionServicioCargosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarSuspensionSrvCelular">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ns8:EjecucionSuspensionSrvCelDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarSuspensionSrvCelularResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ns8:EjecucionSuspensionSrvCelDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerDatosAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerDatosAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:AbonadoDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:DetalleAbonadoDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:DetalleClienteDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleCuenta">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCuenta" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleCuentaResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:DetalleCuentaDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleDireccion">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codDireccion" type="xs:long"/>
                <xs:element minOccurs="0" name="codTipDireccion" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleDireccionResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:DetalleDireccionDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="detallePlanTarifario">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codPlanTarifario" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="detallePlanTarifarioResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:DetallePlanTarifarioDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDeudaCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDeudaClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:DeudaClienteDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerDatosDireccionCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="pIn" nillable="true" type="ax28:DatosDireccionClienteINDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerDatosDireccionClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:DireccionPorClienteDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleEquipo">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDetalleEquipoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:EquipoSimcardDetalleDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="consultaAtencionResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListaAtencionClienteDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerCausalCambioResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListaCausalCambioDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="abonadosXCelular">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numCelular" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="abonadosXCelularResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoAbonadosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="abonadosXCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="abonadosXClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoAbonadosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="consultaCuenta">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCuenta" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="consultaCuentaResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoAbonadosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerListDatosAbonados">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerListDatosAbonadosResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoAbonadosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ajustesXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ajustesXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoAjustesDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="beneficiosXClienteAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="beneficiosXClienteAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoBeneficiosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiosPlanAbonadoPospago">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numOS" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiosPlanAbonadoPospagoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoCambiosPlanTarifDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiosPlanAbonadoPrepago">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numOS" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiosPlanAbonadoPrepagoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoCambiosPlanTarifDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiosPlanCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numOS" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiosPlanClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoCambiosPlanTarifDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerCamposDireccionResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoCamposDireccionDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="clientesXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="clientesXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoClientesDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="clientesXCuenta">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCuenta" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="clientesXCuentaResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoClientesDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="clientesXNombre">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="nombre" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="clientesXNombreResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoClientesDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="consultasXCodGrupo">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codGrupo" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codPrograma" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="numVersion" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="consultasXCodGrupoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoConsultasDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ccXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ccXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoCuentasCorrientesDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cuentasXCodigo">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCuenta" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cuentasXCodigoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoCuentasDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cuentasXNombre">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="descCuenta" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cuentasXNombreResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoCuentasDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cuentasXNumIdent">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numIdent" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cuentasXNumIdentResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoCuentasDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="detalleLlamadas">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="codCiclo" type="xs:long"/>
                <xs:element minOccurs="0" name="tipoLlamada" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="detalleLlamadasResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoDetalleLlamadosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="direccionesXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="direccionesXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoDireccionesDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDocsAjustesCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="obj" nillable="true" type="ax28:GetDocsClienteINDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDocsAjustesClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoDocCtaCteClienteDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDocsCtaCteCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="obj" nillable="true" type="ax28:GetDocsClienteINDTO"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDocsCtaCteClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoDocCtaCteClienteDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDocsFactCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="obj" nillable="true" type="ax28:GetDocsClienteINDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDocsFactClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoDocCtaCteClienteDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDocsPagosCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="obj" nillable="true" type="ax28:GetDocsClienteINDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="getDocsPagosClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoDocCtaCteClienteDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="facturasXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="facturasXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoFacturasDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="gruposXNomUsuario">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="nomUsuario" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="gruposXNomUsuarioResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoGruposDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="limiteConsumoXClienteAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="limiteConsumoXClienteAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoLimiteConsumoDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="numerosFrecuentesXPlan">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="numerosFrecuentesXPlanResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoNumerosFrecuentesDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerOoSsAgendadas">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numDato" type="xs:long"/>
                <xs:element minOccurs="0" name="tipoDato" type="xs:int"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerOoSsAgendadasResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoOrdenesAgendadasDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerOoSsProceso">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="nomUsuario" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerOoSsProcesoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoOrdenesProcesoDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="oossEjecutadasXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="oossEjecutadasXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoOrdenesServicioDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="oossEjecutadasXCodCuenta">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCuenta" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="oossEjecutadasXCodCuentaResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoOrdenesServicioDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="oossEjecutadasXNumAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="oossEjecutadasXNumAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoOrdenesServicioDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="pagosXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="pagosXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoPagosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="pagoLimiteConsumoXClienteAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="pagoLimiteConsumoXClienteAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoPagosLimiteConsumoDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="productosXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="productosXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoProductosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="productosXNumAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="productosXNumAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoProductosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerReporteCambioEquiGene">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="fechaDesde" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="fechaHasta" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codCausalCam" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerReporteCambioEquiGeneResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoReporteCamEquiGenDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerReporteIngrStatusEqui">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="fechaDesde" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="fechaHasta" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerReporteIngrStatusEquiResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoReporteIngrStatusEquiDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerReportePresEquiInt">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="fechaDesde" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="fechaHasta" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerReportePresEquiIntResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoReportePresEquiIntDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="servSumplemetariosXAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="servSumplemetariosXAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoServSuplementariosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ssXDefectoXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ssXDefectoXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoServSuplementariosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ssXDefectoXNumAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ssXDefectoXNumAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoServSuplementariosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="servSuplXOOSS">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numOOSS" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="servSuplXOOSSResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoServSuplxOOSSDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="umtsAbonadosXCodCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="umtsAbonadosXCodClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ListadoUmtsAbonadosDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaValidaOSUsuario">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="usuario" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaValidaOSUsuarioResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:MenuDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="solicitaUrlDominioPuerto">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="strCodOrdenServ" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="solicitaUrlDominioPuertoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:MuestraURLDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="obtenerParametroKioscoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ParametrosKioscoDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ingresoAtencion">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="resgistroAtencionDTO" nillable="true" type="ax28:ResgistroAtencionDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ingresoAtencionResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ResulTransaccionDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="insertComentario">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="numOoss" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="insertComentarioResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ResulTransaccionDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="insertComentarioPvIorserv">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="numOoss" type="xs:long"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="insertComentarioPvIorservResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax28:ResulTransaccionDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAjusteCExcepcionCargos">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="pwd" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAjusteCExcepcionCargosResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:CargaAjusteCExcepcionCargosSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAjusteCReversionCargos">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="pwd" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargarAjusteCReversionCargosResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:CargaAjusteCReversionCargosSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaCambioDatosCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaCambioDatosClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:CargaCambioDatosClienteSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaNumFrecuentes">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaNumFrecuentesResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:CargaCambioNumFrecuentesSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaOSGenericaAbonado">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="codEvento" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cargaOSGenericaAbonadoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:CargaOSGenericaDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiarDireccionCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="dto" nillable="true" type="ax26:DireccionSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiarDireccionClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:ConsultarOrdenServicioSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="consultaOrdenServicio">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="codOOSS" type="xs:long"/>
                <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="consultaOrdenServicioResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:ConsultarOrdenServicioSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecucionCambioDatosCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ax26:EjecucionCambioDatosClienteSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecucionCambioDatosClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:EjecucionCambioDatosClienteSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarCambioNumFrecuente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ax26:EjecucionCambioNumFrecuentesSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="ejecutarCambioNumFrecuenteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:EjecucionCambioNumFrecuentesSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="filtrarDetDocAjusteCExcepcionCargos">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ax26:FiltroDetDocAjusteCCargosSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="filtrarDetDocAjusteCExcepcionCargosResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:FiltroDetDocAjusteCCargosSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="filtrarDetDocAjusteCReversionCargos">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="entrada" nillable="true" type="ax26:FiltroDetDocAjusteCCargosSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="filtrarDetDocAjusteCReversionCargosResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:FiltroDetDocAjusteCCargosSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiarDireccionesCliente">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="dto" nillable="true" type="ax26:ListadoDireccionesSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiarDireccionesClienteResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:ListadoOrdenesServicioSACDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="realizarBloqueoRobo">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="dto" nillable="true" type="ax26:RealizarBloqueoRoboSACINDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="realizarBloqueoRoboResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="ax26:RealizarBloqueoRoboSACOUTDTO"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiarPassword">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="usuario" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="passwordActual" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="passwordNueva" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="cambiarPasswordResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" type="xs:boolean"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="crearUsuario">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="usuario" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="password" nillable="true" type="xs:string"/>
                <xs:element minOccurs="0" name="passwordConfirmada" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="crearUsuarioResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" type="xs:boolean"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="consultaOoSsProceso">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="nomUsuario" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="consultaOoSsProcesoResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" type="xs:boolean"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="esPrimerLogin">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="nomUsuario" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="esPrimerLoginResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" type="xs:boolean"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="decirHelloWorldResponse">
        <xs:complexType>
            <xs:sequence>
                <xs:element minOccurs="0" name="return" nillable="true" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
</xs:schema>
;
			 var xsdSchema14:Schema = new Schema(xsdXML14);
			schemas.push(xsdSchema14);
			targetNamespaces.push(new Namespace('','http://wsservices.wsseguridad.scl.tmmas.com'));
			 var xsdXML16:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax212="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax213="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax217="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax219="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax221="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax222="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax223="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax224="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax225="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax227="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax229="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax24="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax26="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ax27="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:import namespace="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:complexType name="CargaCambioDatosTributariosClienteDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCategoriasImpositivaVO" nillable="true" type="ns11:CategoriaImpositivaVO"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="EjecucionCambioDatosTributariosClienteDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCatImpositiva" type="xs:int"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema16:Schema = new Schema(xsdXML16);
			schemas.push(xsdSchema16);
			targetNamespaces.push(new Namespace('','http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML8:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax211="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax214="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax226="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax228="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax25="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://dto.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:import namespace="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd"/>
    <xs:complexType name="OOSSDTO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nroOOSS" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="CargaAbonoLimConDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="codLimCon" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="codSujeto" type="xs:long"/>
                    <xs:element minOccurs="0" name="codUmbral" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desLimCon" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desUmbral" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="montoLimCon" type="xs:double"/>
                    <xs:element minOccurs="0" name="nivelConsumo" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="nombreCliente" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numTerminal" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="tipoAbono" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="CargaAbonoLimiteConsumoServicioSuplementarioDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayAbonoLimiteConsumoServicioSuplementarioVOs" nillable="true" type="ns15:AbonoLimiteConsumoServicioSuplementarioVO"/>
                    <xs:element minOccurs="0" name="codCliente" type="xs:long"/>
                    <xs:element minOccurs="0" name="codPlanTarif" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="codSujeto" type="xs:long"/>
                    <xs:element minOccurs="0" name="desCodPlanTarif" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="key" type="xs:int"/>
                    <xs:element minOccurs="0" name="nombreCliente" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numCelular" type="xs:long"/>
                    <xs:element minOccurs="0" name="tipoOOSS" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="CargaAnulacionSiniestroDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arraySiniestrosVO" nillable="true" type="ns15:SiniestrosVO"/>
                    <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                    <xs:element minOccurs="0" name="numCelular" type="xs:long"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="CargaCambioEquipoGSMDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayBloqueArticulosVO" nillable="true" type="ns15:BloqueArticulosVO"/>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayBloqueUsosVO" nillable="true" type="ns15:BloqueUsosVO"/>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCausasCambioVO" nillable="true" type="ns15:CausasCambioVO"/>
                    <xs:element minOccurs="0" name="codModVenta" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desEquipo" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desIndPropiedad" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desModVenta" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desProcedEqui" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desTipContrato" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desTipTerminal" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desUso" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="nombreUsuario" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                    <xs:element minOccurs="0" name="numCelular" type="xs:long"/>
                    <xs:element minOccurs="0" name="numSerie" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numSerieMec" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="CargaCambioPlanPostPagoIndividualDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="aplicaNumeroFrecuente" type="xs:int"/>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayPlanTarifarioVO" nillable="true" type="ns15:PlanTarifarioVO"/>
                    <xs:element minOccurs="0" name="desCargoBasico" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desCargoBasicoProxCiclo" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desLimConActual" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desLimConProximo" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desPlanTarif" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desPlanTarifProxCiclo" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                    <xs:element minOccurs="0" name="numeroCelular" type="xs:long"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="CargaCambioSIMCardDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayBloqueUsosVO" nillable="true" type="ns15:BloqueUsosVO"/>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCausasCambioVO" nillable="true" type="ns15:CausasCambioVO"/>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayTiposContratosVO" nillable="true" type="ns15:TiposContratosVO"/>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayTiposTerminalesVO" nillable="true" type="ns15:TiposTerminalesVO"/>
                    <xs:element minOccurs="0" name="codModVenta" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="codTec" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desEquipo" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desIndPropiedad" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desModVenta" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desProcedEqui" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desTipTerminal" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="desUso" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="indProcedencia" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="nombreUsuario" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                    <xs:element minOccurs="0" name="numSerie" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="CargaReposicionSrvCelDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayBloqueSuspensionesActivasVO" nillable="true" type="ns15:BloqueSuspensionesActivasVO"/>
                    <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="CargaServicioCargosDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCargosVO" nillable="true" type="ns15:CargosVO"/>
                    <xs:element minOccurs="0" name="codAntiSerie" type="xs:long"/>
                    <xs:element minOccurs="0" name="codArticulo" type="xs:long"/>
                    <xs:element minOccurs="0" name="codArticuloSim" type="xs:long"/>
                    <xs:element minOccurs="0" name="codEstadoSim" type="xs:long"/>
                    <xs:element minOccurs="0" name="codModVenta" type="xs:long"/>
                    <xs:element minOccurs="0" name="codStockSim" type="xs:long"/>
                    <xs:element minOccurs="0" name="codUsoLineaSim" type="xs:long"/>
                    <xs:element minOccurs="0" name="indCreaDto" type="xs:long"/>
                    <xs:element minOccurs="0" name="indFacturaCiclo" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="indModCargos" type="xs:long"/>
                    <xs:element minOccurs="0" name="indModDtos" type="xs:long"/>
                    <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                    <xs:element minOccurs="0" name="pntDtoInf" type="xs:long"/>
                    <xs:element minOccurs="0" name="pntDtoSup" type="xs:long"/>
                    <xs:element minOccurs="0" name="prcCargInf" type="xs:long"/>
                    <xs:element minOccurs="0" name="prcDtoInf" type="xs:long"/>
                    <xs:element minOccurs="0" name="prcDtoSup" type="xs:long"/>
                    <xs:element minOccurs="0" name="prcNewDtoSup" type="xs:long"/>
                    <xs:element minOccurs="0" name="prcNewDtoinf" type="xs:long"/>
                    <xs:element minOccurs="0" name="prccargSup" type="xs:long"/>
                    <xs:element minOccurs="0" name="ventaSimCard" type="xs:boolean"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="CargaSuspensionSrvCelDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCausasSuspensionVO" nillable="true" type="ns15:CausasSuspensionVO"/>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayServicioSuspensionVO" nillable="true" type="ns15:ServicioSuspensionVO"/>
                    <xs:element minOccurs="0" name="indBloqueoCausaSuspension" type="xs:int"/>
                    <xs:element minOccurs="0" name="nombreCliente" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numAbonado" type="xs:long"/>
                    <xs:element minOccurs="0" name="numeroCelular" type="xs:long"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionAbonoLimConDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="montoAbono" type="xs:double"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionAbonoLimiteConsumoServicioSuplementarioDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayAbonoLimiteConsumoServicioSuplementarioVOs" nillable="true" type="ns15:AbonoLimiteConsumoServicioSuplementarioVO"/>
                    <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="mensaje" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionAjusteCExcepcionCargosDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayDetalleAjusteVO" nillable="true" type="ns15:DetalleAjusteVO"/>
                    <xs:element minOccurs="0" name="codCauPago" type="xs:int"/>
                    <xs:element minOccurs="0" name="codNC" type="xs:int"/>
                    <xs:element minOccurs="0" name="codOriPago" type="xs:int"/>
                    <xs:element minOccurs="0" name="desNC" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="montoTotalAjuste" type="xs:double"/>
                    <xs:element minOccurs="0" name="observacion" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="tipoAjuste" type="xs:int"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionAjusteCReversionCargosDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayDetalleAjusteVO" nillable="true" type="ns15:DetalleAjusteVO"/>
                    <xs:element minOccurs="0" name="codCauPago" type="xs:int"/>
                    <xs:element minOccurs="0" name="codND" type="xs:int"/>
                    <xs:element minOccurs="0" name="codOriPago" type="xs:int"/>
                    <xs:element minOccurs="0" name="desND" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="fecVencimiento" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="montoTotalAjuste" type="xs:double"/>
                    <xs:element minOccurs="0" name="observacion" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="tipoAjuste" type="xs:int"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionAnulacionSiniestroDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numConstancia" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numSiniestro" type="xs:long"/>
                    <xs:element minOccurs="0" name="observacion" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionCambioEquipoGSMDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="codArt" type="xs:int"/>
                    <xs:element minOccurs="0" name="codCauCambio" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="codTipTerminal" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="codUso" type="xs:int"/>
                    <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="iLargoSerie" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="indProcedencia" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numSerie" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionCambioPlanPostPagoIndividualDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayNumeroFrecuenteFijoVO" nillable="true" type="ns15:NumeroFrecuenteFijoVO"/>
                    <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayNumeroFrecuenteMovilVO" nillable="true" type="ns15:NumeroFrecuenteMovilVO"/>
                    <xs:element minOccurs="0" name="codPlanTarifNuevo" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionCambioSIMCardDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="codCauCambio" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="codModVenta" type="xs:long"/>
                    <xs:element minOccurs="0" name="codUso" type="xs:int"/>
                    <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="numSerie" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="tipTerminal" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionReposicionSrvCelDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
    <xs:complexType name="EjecucionServicioCargosDTO">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" minOccurs="0" name="arrayCargosVO" nillable="true" type="ns15:CargosVO"/>
            <xs:element minOccurs="0" name="codError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="desError" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="factura" type="xs:boolean"/>
            <xs:element minOccurs="0" name="indContado" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="indCuota" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="mesGarantia" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="nomUsuaSupervisor" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="nomUsuarioSCL" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="numCargo" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="numTransaccion" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="passwordSupervisor" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="tipPantalla" nillable="true" type="xs:long"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="EjecucionSuspensionSrvCelDTO">
        <xs:complexContent>
            <xs:extension base="ns8:OOSSDTO">
                <xs:sequence>
                    <xs:element minOccurs="0" name="codCauSusp" nillable="true" type="xs:string"/>
                    <xs:element minOccurs="0" name="comentario" nillable="true" type="xs:string"/>
                </xs:sequence>
            </xs:extension>
        </xs:complexContent>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema8:Schema = new Schema(xsdXML8);
			schemas.push(xsdSchema8);
			targetNamespaces.push(new Namespace('','http://dto.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML2:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax226="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax228="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:complexType name="NumFrecuentesFirmaVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="numFrecuente" nillable="true" type="xs:long"/>
            <xs:element minOccurs="0" name="tipoNumFrecuente" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="TipoNumFrecuenteFirmaVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="desTipFrecuente" nillable="true" type="xs:string"/>
            <xs:element minOccurs="0" name="idTipFrecuente" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema2:Schema = new Schema(xsdXML2);
			schemas.push(xsdSchema2);
			targetNamespaces.push(new Namespace('','http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd'));
			 var xsdXML11:XML = <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ax21="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ax212="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax213="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax215="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax217="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax22="http://exception.framework.cl.tmmas.com/xsd" xmlns:ax221="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax223="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax225="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax227="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax229="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax23="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ax26="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ax28="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ax29="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://dto.common.wsportal.scl.tmmas.com/xsd" xmlns:ns1="http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns10="http://dto.wsseguridad.scl.tmmas.com/xsd" xmlns:ns11="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns12="http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns13="http://vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns14="http://wsservices.wsseguridad.scl.tmmas.com" xmlns:ns15="http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns16="http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns17="http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns2="http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns3="http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns4="http://exception.common.wsportal.scl.tmmas.com/xsd" xmlns:ns5="http://exception.framework.cl.tmmas.com/xsd" xmlns:ns6="http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns7="http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns8="http://dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:ns9="http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="qualified" elementFormDefault="qualified" targetNamespace="http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd">
    <xs:complexType name="CategoriaImpositivaVO">
        <xs:sequence>
            <xs:element minOccurs="0" name="codCatImpositiva" type="xs:int"/>
            <xs:element minOccurs="0" name="desCatImpositiva" nillable="true" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
</xs:schema>
;
			 var xsdSchema11:Schema = new Schema(xsdXML11);
			schemas.push(xsdSchema11);
			targetNamespaces.push(new Namespace('','http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd'));
			xsdSchema10.addImport(new Namespace("http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema3)
			xsdSchema9.addImport(new Namespace("http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema6)
			xsdSchema10.addImport(new Namespace("http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema2)
			xsdSchema10.addImport(new Namespace("http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema17)
			xsdSchema10.addImport(new Namespace("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema15)
			xsdSchema10.addImport(new Namespace("http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema1)
			xsdSchema8.addImport(new Namespace("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema15)
			xsdSchema16.addImport(new Namespace("http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema11)
			xsdSchema3.addImport(new Namespace("http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema7)
			xsdSchema10.addImport(new Namespace("http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema16)
			xsdSchema17.addImport(new Namespace("http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema12)
			xsdSchema10.addImport(new Namespace("http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd"), xsdSchema9)
		}
	}
}