GameMap gameMap; 
BackButton gameBackBtn;
Button resetButton;
Button homeButton;

void createGameScene(){
	gameMap = new GameMap(8 , 8 , 60 , fileName);
	gameMap.createMap();
	gameMap.initPackMans();	
	addEventListener("keyPress" , gameMap);

	gameBackBtn = new BackButton(new Callback(){
		public void callbackfunction(String param){
			hideGameScene();
			createMainScene();
		}
	});
	addEventListener("clicked" , gameBackBtn);

	color c2 = color(0,0,255);
	resetButton = new Button(width/2 + width/4.5 , height/1.3 , "Again" , width/5 , height/12 , c2 , new Callback(){
		public void callbackfunction(String param){
			hideGameScene();
			createGameScene();
		}
	});
	addEventListener("clicked" , resetButton);

	color c3 = color(0,255,0);
	homeButton = new Button(width/2 - width/4.5 , height/1.3 , "Home" , width/5 , height/12 , c3 , new Callback(){
		public void callbackfunction(String param){
			hideGameScene();
			createMainScene();
		}
	});
	addEventListener("clicked" , homeButton);

	gameState = GAME_PLAYING;
}

void showGameScene(){
	if (gameState == GAME_PLAYING) {
		gameMap.drawMap();
		gameMap.updatePackMan();		
		gameBackBtn.drawMe();

		String playerOneGuide = "UP/DOWN/RIGHT/LEFT keys : player one control keys";
		textSize(width/65);
		float playerOneTxtWidth = textWidth(playerOneGuide);	
		text(playerOneGuide, width/2 - playerOneTxtWidth/2 - width/4 , height/1.1);

		String playerTwoGuide = "W/S/A/D keys : player Two control keys";
		textSize(width/65);
		float playerTwoTxtWidth = textWidth(playerTwoGuide);	
		text(playerTwoGuide, width/2 - playerTwoTxtWidth/2 + width/4 , height/1.1);

	}else if (gameState == GAME_FINISHED){
		gameMap.showResult();
		resetButton.drawMe();
		homeButton.drawMe();
	}
}

void hideGameScene(){
	removeEventListener(gameMap);
	removeEventListener(gameBackBtn);
	removeEventListener(resetButton);
	removeEventListener(homeButton);
}