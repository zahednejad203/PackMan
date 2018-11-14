import java.util.Iterator;
import java.util.List;

String gameState = "";
ArrayList<Listener> activeListeners = new ArrayList<Listener>();

void setup(){
  	fullScreen();
  	// size(800, 800);
  	frameRate(5);
  	createMainScene();
}

void draw(){
	background(0);
	if (gameState == GAME_NOT_STARTED) {
		showMainScene();
	}else if (gameState == GAME_PLAYING || gameState == GAME_FINISHED) {		
		showGameScene();
	}else if (gameState == GAME_CREATING) {
		showNewMapScene();
	}else if (gameState == GAME_SELECTIN_MAP){
		showSelectMapScene();
	}
}

void addEventListener(String type , Response callback){
	Listener newListener = new Listener(type , callback , activeListeners.size());
	activeListeners.add(newListener);
	callback.setNumber(activeListeners.size()-1);
	// println("added number: " + activeListeners.size());
}

void removeEventListener(Response callback){
	List<Listener> activeListenerList = activeListeners;	
	List<Integer> listenerList = callback.getNumber();

	Iterator itr = activeListeners.iterator(); 
    while (itr.hasNext()) 
    { 
        Listener x = (Listener)itr.next();
        
        for (int i = 0; i < listenerList.size(); ++i) {
        	int listenerNum = listenerList.get(i);
	        if (x.getId() == listenerNum) 
	        	itr.remove();         	
        }
    } 
}

void dispatchEvent(String type){
	for (int i = 0; i < activeListeners.size(); ++i) {
		Listener myListener = activeListeners.get(i);
		if (myListener.getType() == type) {
			myListener.excuteCallback();
		}
	}
}

// events 

void keyPressed() {
	dispatchEvent("keyPress");
}

void mouseClicked() {
	dispatchEvent("clicked");
}

void gameHasFinished(){	
	gameState = GAME_FINISHED;	
}