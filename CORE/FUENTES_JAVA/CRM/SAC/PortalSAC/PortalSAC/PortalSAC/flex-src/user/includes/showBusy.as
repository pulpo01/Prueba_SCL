// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 28-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	
	private function showBusy():void	{

	    popUpParent = Application.application.document;
	    popUpWindow = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
		PopUpManager.centerPopUp(popUpWindow);
				
	} // showBusy
