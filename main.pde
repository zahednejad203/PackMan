Map gameMap; 
String gameState = "";

void setup(){
  	fullScreen();
  	// size(800, 800);
  	frameRate(5);
	startGame();
}

void startGame(){
	gameMap = new Map(25 , 50 , 8 , 8 , 60 , "map1.json");
	gameMap.createMap();	
	gameState = GAME_PLAYING;
}

void draw(){
	background(0);
	if (gameState == GAME_PLAYING) {		
		gameMap.drawMap();
	}else if (gameState == GAME_FINISHED){
		gameMap.showResult();
	}
}

// events 

void keyPressed() {
	gameMap.keyPressed();
	if (gameState == GAME_FINISHED) {
		if (key != CODED) {
			if (key == 'r') {
				startGame();
			}
		}
	}
}

void beansEaten(){
	gameMap.beansEaten();
}

void gameHasFinished(){	
	gameState = GAME_FINISHED;	
}