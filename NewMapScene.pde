CreationMap mapCreator;
Button saveButton;
BackButton backBtn;

void createNewMapScene(){
	mapCreator = new CreationMap(8 , 8 , 60 , "");
	mapCreator.createMap();
	addEventListener("clicked" , mapCreator);
	addEventListener("keyPress" , mapCreator);
	gameState = GAME_CREATING;

	color c2 = color(0,0,255);
	saveButton = new Button(width/2 , mapCreator.top + mapCreator.heightSize*mapCreator.blockSize + height/8 , "save Map" , width/5 , height/12 , c2 , new Callback(){
		public void callbackfunction(String param){
			mapCreator.saveMap();
			hideNewMapScene();
			createMainScene();
		}
	});
	addEventListener("clicked" , saveButton);

	backBtn = new BackButton(new Callback(){
		public void callbackfunction(String param){
			hideNewMapScene();
			createMainScene();
		}
	});
	addEventListener("clicked" , backBtn);

}

void showNewMapScene(){
	mapCreator.drawMap();
	saveButton.drawMe();
	backBtn.drawMe();

	String startText = "****  Select a cell to start creating ****";
	textSize(width/40);
	float txtWidth = textWidth(startText);	
	text(startText, width/2 - txtWidth/2 , height/5);

	String toggleGuid = "1/2/3/4 keys: toggle the walls";
	textSize(width/80);
	float toggleTxtWidth = textWidth(toggleGuid);	
	text(toggleGuid, width/2 - toggleTxtWidth/2 - width/4 , height/9);

	String arrowKeysGuid = "UP/DOWN/RIGHT/LEFT keys : change selected cell";
	textSize(width/80);
	float arrowKeysTxtWidth = textWidth(arrowKeysGuid);	
	text(arrowKeysGuid, width/2 - arrowKeysTxtWidth/2 + width/4 , height/9);	
}

void hideNewMapScene(){
	removeEventListener(mapCreator);	
	removeEventListener(saveButton);	
	removeEventListener(backBtn);	
}