class CreationMap extends Map implements Response {

	MapCreatorCell selectedCell ;
	JSONArray mapList;
	int mapNumber = 0;	
	ArrayList<Integer> listenersNumber = new ArrayList<Integer>();

	public CreationMap(int initialWidthSize , int initialHeightSize , int initialBlockSize , String initailMapFile){
		super(initialWidthSize, initialHeightSize, initialBlockSize, initailMapFile);
		getMapList();
	}

	@Override
	void createMap(){
		for (int i = 0; i < widthSize*heightSize ; ++i) {
			int[] walls = {1,1,1,1};
			MapCreatorCell newCell = new MapCreatorCell(left + blockSize/2 + blockSize*(i%widthSize) , top + blockSize/2 + blockSize*(floor(i/widthSize)) , walls , blockSize , i);
			map.add(newCell);
		}		
	}

	@Override
	void drawMap(){
		for (int i = 0; i < map.size(); ++i) {
			MapCreatorCell singleCell = (MapCreatorCell)map.get(i);
			singleCell.drawMe();		
		}
	}

	void getMapList(){
		mapList = loadJSONArray("maps/list.json");
		mapNumber = mapList.size();
		mapList.setInt(mapNumber , mapNumber);
	}

	void onKeyPressedResponse(){
		if (keyPressed) {
			if (key != CODED) {
				if (key == '1' || key == '2' || key == '3' || key == '4') {
					int keyValue = int(key) - 48 - 1;
					if (selectedCell != null) {
						MapCreatorCell nextCell = getNextCell(selectedCell , keyValue);
						if (nextCell != null) {
							selectedCell.setWall(keyValue);
							if (nextCell.hasWall(changeDir(keyValue))) {
								nextCell.setWall(changeDir(keyValue));
							}
						}
					}
				}else if (key == 's') {
					saveMap();
				}
			}else{
				if (selectedCell != null) {
					int direction = -1;
					if (keyCode == RIGHT) {
						direction = RIGHT_DIR;
					}else if (keyCode == DOWN) {
						direction = DOWN_DIR;
					}else if (keyCode == LEFT) {
						direction = LEFT_DIR;
					}else if (keyCode == UP) {
						direction = UP_DIR;
					}

					if (direction != -1 ) {
						MapCreatorCell nextCell = getNextCell(selectedCell,direction);
						if (nextCell != null) {
							selectedCell.setStatus(false);
							selectedCell = (MapCreatorCell)map.get(nextCell.getCellNumber());
							selectedCell.setStatus(true);						
						}
					}
				}
			}			
		}
	}

	void onClickResponse(){
		if (mouseX - left > 0 && left + widthSize*blockSize - mouseX > 0 && mouseY - top > 0 && top + heightSize*blockSize - mouseY > 0){
			int xPos = floor( ( mouseX - left )/blockSize );
			int yPos = floor( ( mouseY - top )/blockSize );

			if (selectedCell != null) {
				selectedCell.setStatus(false);
			}
			MapCreatorCell clickedCell = (MapCreatorCell)map.get(xPos + yPos*widthSize);
			selectedCell = clickedCell;
			selectedCell.setStatus(true);
		}
	}

	void setNumber(int number){
		listenersNumber.add(number);
	}
	ArrayList<Integer> getNumber(){
		return listenersNumber;
	}


	void saveMap(){
		JSONArray mapJson = new JSONArray();
		for (int i = 0; i < map.size(); ++i) {
			MapCreatorCell cell = (MapCreatorCell)map.get(i);
			JSONArray cellJson = cell.getWallJsonArray();
			mapJson.setJSONArray(i,cellJson);
		}
		saveJSONArray(mapList,"maps/list.json");	
		saveJSONArray(mapJson,"maps/map"+mapNumber+".json");
	}
}