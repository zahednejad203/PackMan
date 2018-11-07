GameMap gameMap; 
CreationMap mapCreator;
String gameState = "";
ArrayList<Listener> activeListeners = new ArrayList<Listener>();

void setup(){
  	// fullScreen();
  	size(800, 800);
  	frameRate(5);
  	gameState = GAME_NOT_STARTED;
  	createMainScene();
}

void draw(){
	background(0);
	if (gameState == GAME_NOT_STARTED) {
		showMainScene();
	}else if (gameState == GAME_PLAYING) {		
		gameMap.drawMap();
		gameMap.updatePackMan();
	}else if (gameState == GAME_FINISHED){
		gameMap.showResult();
	}else if (gameState == GAME_CREATING) {
		mapCreator.drawMap();
	}
}

void addEventListener(String type , Response callback){
	Listener newListener = new Listener(type , callback);
	activeListeners.add(newListener);	
	callback.setNumber(activeListeners.size()-1);
}

void removeEventListener(Response callback){
	ArrayList<Integer> listenerList = callback.getNumber();
	for (int i = 0; i < listenerList.size(); ++i) {
		int listenerNum = listenerList.get(i);
		activeListeners.remove(listenerNum);	
	}
}

// events 

void keyPressed() {
	for (int i = 0; i < activeListeners.size(); ++i) {
		Listener myListener = activeListeners.get(i);
		if (myListener.getType() == "keyPress") {
			myListener.excuteCallback();
		}
	}
	if (gameState == GAME_FINISHED) {
		if (key != CODED) {
			if (key == 'r') {
				startGame();
			}
		}
	}
}

void mouseClicked() {
	for (int i = 0; i < activeListeners.size(); ++i) {
		Listener myListener = activeListeners.get(i);
		if (myListener.getType() == "clicked") {
			myListener.excuteCallback();
		}
	}
}

void beansEaten(){
	gameMap.beansEaten();
}

void gameHasFinished(){	
	gameState = GAME_FINISHED;	
}