<!-- saved from url=(0014)about:internet -->
<html lang="en">

<!-- 
Smart developers always View Source. 

This application was built using Adobe Flex, an open source framework
for building rich Internet applications that get delivered via the
Flash Player or to desktops via Adobe AIR. 

Learn more about Flex at http://flex.org 
// -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Portal de Servicios Atenci&oacuten Cliente</title>
<script src="./AC_OETags.js" language="javascript"></script>
<style>
body { margin: 0px; overflow:hidden }
</style>
<script language="JavaScript" type="text/javascript">

// -----------------------------------------------------------------------------
// Globals
// Major version of Flash required
var requiredMajorVersion = 10;
// Minor version of Flash required
var requiredMinorVersion = 0;
// Minor version of Flash required
var requiredRevision = 0;
// -----------------------------------------------------------------------------

	var paso = 'NO';

	function controlSession(){
		if('NO' == paso){
			alert('La sesion a caducado, sera redirigido a al inicio de la aplicacion.');
			paso = 'SI';
		}
		return true;
	}

	function abrirSTP(URL) {
		
		var Ventana = 'Portal_STP';
	 	var Ancho = '1002';
	 	var Alto = '642';
	 	var MargenS = '0';
	 	var MargenI = '0';
	 	var Barras = 'yes';
		var win = null;
		win = window.open(URL, Ventana, "width="+Ancho+", height="+Alto+", scrollbars="+Barras+", top="+MargenS+", left="+MargenI+", resizable=yes, toolbar=No");
		win.focus();
		
	}

	window.onbeforeunload = function () {
		if(!app.cancloseornot()){
			return "Presione 'Cancelar' para completar el registro de consulta. Si presiona 'Aceptar' saldra de la pagina sin dejar el registro, si ya ha dejado registro de la ultima consulta presione 'Aceptar' para salir.";	
		}
	}

</script>
</head>

<body scroll="no">
<script language="JavaScript" type="text/javascript">
// Version check for the Flash Player that has the ability to start Player Product Install (6.0r65)
var hasProductInstall = DetectFlashVer(6, 0, 65);

// Version check based upon the values defined in globals
var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);


// Check to see if a player with Flash Product Install is available and the version does not meet the requirements for playback
if ( hasProductInstall && !hasRequestedVersion ) {
	// MMdoctitle is the stored document.title value used by the installation process to close the window that started the process
	// This is necessary in order to close browser windows that are still utilizing the older version of the player after installation has completed
	// DO NOT MODIFY THE FOLLOWING FOUR LINES
	// Location visited after installation is complete if installation is required
	var MMPlayerType = (isIE == true) ? "ActiveX" : "PlugIn";
	var MMredirectURL = window.location;
    document.title = document.title.slice(0, 47) + " - Flash Player Installation";
    var MMdoctitle = document.title;

	AC_FL_RunContent(
		"src", "playerProductInstall",
		"FlashVars", "usuario=<%= request.getRemoteUser() %>&server=<%="https://" + request.getServerName() + ":" + request.getServerPort()%>&MMredirectURL="+MMredirectURL+'&MMplayerType='+MMPlayerType+'&MMdoctitle='+MMdoctitle+"",
		"width", "1024",
		"height", "640",
		"align", "middle",
		"id", "app",
		"quality", "high",
		"bgcolor", "blue",
		"name", "app",
		"allowScriptAccess","sameDomain",
		"type", "application/x-shockwave-flash",
		"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
} else if (hasRequestedVersion) {
	// if we've detected an acceptable version
	// embed the Flash Content SWF when all tests are passed
	
	var servidor = "https://";
	servidor = servidor + "<%=request.getServerName()%>";
	servidor = servidor + ":";
	servidor = servidor + "<%=request.getServerPort()%>";
	servidor = servidor +  "/";

	AC_FL_RunContent(
			"src", "PortalSAC",
			"width", "1024",
			"height", "640",
			"align", "middle",
			"id", "app",
			"quality", "high",
			"bgcolor", "blue",
			"FlashVars", "usuario=<%= request.getRemoteUser() %>&server=" + servidor,
			"name", "app",
			"allowScriptAccess","sameDomain",
			"type", "application/x-shockwave-flash",
			"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
  } else {  // flash is too old or we can't detect the plugin
    var alternateContent = 'Alternate HTML content should be placed here. '
  	+ 'This content requires the Adobe Flash Player. '
   	+ '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
    document.write(alternateContent);  // insert non-flash content
  }

function ejecutaOOSSExterna(url, w, h)	{
		window.open(url,"","toolbar=0,location=0,directories=0,menubar=0,scrollbars=1,resizable=1,width=" + w + ",height=" + h + "");
	
		//window.showModalDialog(url,'','dialogWidth: '+ w +'px;dialogHeight:'+ h +'px; resizable=yes;');
	}

</script>
<noscript>
			<param name="movie" value="PortalSAC.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="blue" />
			<param name="allowScriptAccess" value="sameDomain" />
			<embed src="PortalSAC.swf" quality="high" bgcolor="blue"
				width="1024" height="640" name="app" align="middle"
				play="true"
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
</noscript>
</body>
</html>
