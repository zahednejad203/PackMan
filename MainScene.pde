String fileName = "maps/map1.json";
Button playButton;
Button createMapButton;

void createMainScene(){	
	color c1 = color(255,0,0);
	playButton = new Button(width/2 , height/2 , "play" , width/5 , height/12 , c1 , new Response(){
		@Override
		public void setNumber(int number){}

		@Override
		public ArrayList<Integer> getNumber(){
			ArrayList<Integer> temp = new ArrayList<Integer>();
			return temp;
		}

		@Override
		public void onKeyPressedResponse(){}

		@Override
		public void onClickResponse(){
			hideMainScene();
			startGameScene();
		}
	});
	addEventListener("clicked" , playButton);

	color c2 = color(0,0,255);
	createMapButton = new Button(width/2 , height/1.6 , "create Map" , width/5 , height/12 , c2 , new Response(){
		@Override
		public void setNumber(int number){}

		@Override
		public ArrayList<Integer> getNumber(){
			ArrayList<Integer> temp = new ArrayList<Integer>();
			return temp;
		}

		@Override
		public void onKeyPressedResponse(){}

		@Override
		public void onClickResponse(){
			hideMainScene();
			createNewMapScene();
		}
	});
	addEventListener("clicked" , createMapButton);
}

void showMainScene(){
	if (playButton != null) {
		playButton.drawMe();
	}
	if (createMapButton != null) {
		createMapButton.drawMe();
	}
}

void hideMainScene(){
	removeEventListener(playButton);
	removeEventListener(createMapButton);
}

void startGameScene(){
	gameMap = new GameMap(8 , 8 , 60 , fileName);
	gameMap.createMap();
	gameMap.initPackMans();	
	addEventListener("keyPress" , gameMap);
	gameState = GAME_PLAYING;	
}

void createNewMapScene(){
	mapCreator = new CreationMap(8 , 8 , 60 , "");
	mapCreator.createMap();
	addEventListener("clicked" , mapCreator);
	addEventListener("keyPress" , mapCreator);
	gameState = GAME_CREATING;
}

