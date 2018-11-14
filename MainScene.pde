Button playButton;
Button createMapButton;
PImage logo;

void createMainScene(){	
	color c1 = color(255,0,0);
	playButton = new Button(width/2 , height/2 , "play" , width/5 , height/12 , c1 , new Callback(){		
		public void callbackfunction(String param){
			hideMainScene();
			createSelectMapScene();
		}
	});
	addEventListener("clicked" , playButton);

	color c2 = color(0,0,255);
	createMapButton = new Button(width/2 , height/1.6 , "create Map" , width/5 , height/12 , c2 , new Callback(){
		public void callbackfunction(String param){
			hideMainScene();
			createNewMapScene();
		}
	});
	addEventListener("clicked" , createMapButton);

	logo = loadImage("images/packman-logo.png");

	gameState = GAME_NOT_STARTED;
}

void showMainScene(){	
	playButton.drawMe();
	createMapButton.drawMe();
	image(logo, width/2 - width/3 , height/12 , width/1.5 , 0.2616*width/1.5);
}

void hideMainScene(){
	removeEventListener(playButton);
	removeEventListener(createMapButton);
}

