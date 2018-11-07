class Map{
	ArrayList map = new ArrayList();
	String mapFile = "";	
	float top = 0; 
	float left = 0; 
	int widthSize = 0; 
	int heightSize = 0; 
	int blockSize = 0; 
	int beansNumber = 0;

	public Map(int initialWidthSize , int initialHeightSize , int initialBlockSize , String initailMapFile){
		widthSize = initialWidthSize;
		heightSize = initialHeightSize;
		blockSize = initialBlockSize;
		mapFile = initailMapFile;
		beansNumber = widthSize * heightSize;
		top = height/2 - (initialHeightSize*initialBlockSize)/2;
		left = width/2 - (initialWidthSize*initialBlockSize)/2;
	}

	void createMap(){
		JSONArray values = loadJSONArray(mapFile);

		for (int i = 0; i < widthSize*heightSize ; ++i) {			
			JSONArray myWalls = values.getJSONArray(i);			
			int[] walls = new int[4];
			for (int j = 0; j < myWalls.size(); ++j) {
				walls[j] = myWalls.getInt(j);	
			}

			Cell newCell = new Cell(left + blockSize/2 + blockSize*(i%widthSize) , top + blockSize/2 + blockSize*(floor(i/widthSize)) , walls , blockSize , i);
			map.add(newCell);
		}		
	}

	void drawMap(){
		for (int i = 0; i < map.size(); ++i) {
			Cell singleCell = (Cell)map.get(i);
			singleCell.drawMe();		
		}
	}

	Cell getNextCell(Cell currentCell , int dir){
		Cell nextCell ;
		int curCellNum = currentCell.getCellNumber();
		if (dir == RIGHT_DIR) {
			nextCell = (Cell)map.get(curCellNum + 1);
		}else if (dir == LEFT_DIR) {			
			nextCell = (Cell)map.get(curCellNum - 1);
		}else if (dir == UP_DIR) {
			nextCell = (Cell)map.get(curCellNum - widthSize);
		}else {
			nextCell = (Cell)map.get(curCellNum + widthSize);
		}
		return nextCell;
	}

	MapCreatorCell getNextCell(MapCreatorCell currentCell , int dir){
		MapCreatorCell nextCell = null ;
		int curCellNum = currentCell.getCellNumber();
		if (dir == RIGHT_DIR) {
			if ((curCellNum + 1)%widthSize != 0) {
				nextCell = (MapCreatorCell)map.get(curCellNum + 1);				
			}
		}else if (dir == LEFT_DIR) {
			if (curCellNum - 1 >= 0 && (curCellNum - 1)%widthSize != widthSize - 1) {
				nextCell = (MapCreatorCell)map.get(curCellNum - 1);				
			}
		}else if (dir == UP_DIR) {
			if (curCellNum - widthSize >= 0) {
				nextCell = (MapCreatorCell)map.get(curCellNum - widthSize);				
			}
		}else {
			if (curCellNum + widthSize < widthSize*heightSize) {				
				nextCell = (MapCreatorCell)map.get(curCellNum + widthSize);
			}
		}
		return nextCell;
	}
}