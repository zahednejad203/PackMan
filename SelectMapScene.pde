String fileName = "maps/map1.json";
ArrayList<Button> mapsButton = new ArrayList<Button>();
BackButton selectMapBackBtn;

void createSelectMapScene(){	
	
	JSONArray createdMapList = loadJSONArray("maps/list.json");

	for (int i = 0; i < createdMapList.size(); ++i) {
		String selectFileName = "map"+createdMapList.getInt(i);
		int column = i%5;
		int row = floor(i/5);
		Button createdMap = new Button( 200 + width/16 + column*width/7 , 100 + row*height/16 , selectFileName , width/8 , height/18 , color(0) , new Callback(){		
			public void callbackfunction(String param){
				selectMap(param);
			}
		});
		addEventListener("clicked" , createdMap);
		mapsButton.add(createdMap);
	}

	selectMapBackBtn = new BackButton(new Callback(){
		public void callbackfunction(String param){
			hideSelectMapScene();
			createMainScene();
		}
	});
	addEventListener("clicked" , selectMapBackBtn);

	gameState = GAME_SELECTIN_MAP;
}

void selectMap(String selectedFileName){
	fileName = "maps/"+selectedFileName+".json";
	hideSelectMapScene();
	createGameScene();
}

void showSelectMapScene(){	
	for (int i = 0; i < mapsButton.size(); ++i) {
		Button selectButton = mapsButton.get(i);
		selectButton.drawMe();
	}
	selectMapBackBtn.drawMe();
}

void hideSelectMapScene(){
	for (int i = 0; i < mapsButton.size(); ++i) {
		Button selectButton = mapsButton.get(i);
		removeEventListener(selectButton);
	}
	removeEventListener(selectMapBackBtn);
}

