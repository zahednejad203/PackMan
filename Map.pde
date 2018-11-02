class Map{
	ArrayList map = new ArrayList();
	String mapFile = "";
	ArrayList<PackMan> myPack = new ArrayList<PackMan>() ;
	float top = 0; 
	float left = 0; 
	int widthSize = 0; 
	int heightSize = 0; 
	int blockSize = 0; 
	int beansNumber = 0;

	public Map(float initialTop , float initialLeft , int initialWidthSize , int initialHeightSize , int initialBlockSize , String initailMapFile){
		top = initialTop;
		left = initialLeft;
		widthSize = initialWidthSize;
		heightSize = initialHeightSize;
		blockSize = initialBlockSize;
		mapFile = initailMapFile;
		beansNumber = widthSize * heightSize;
	}

	void createMap(){
		JSONArray values = loadJSONArray(mapFile);

		for (int i = 0; i < widthSize*heightSize ; ++i) {
			JSONArray myWalls = values.getJSONArray(i);
			int[] walls = new int[4];

			for (int j = 0; j < 4; ++j) {
				walls[j] = myWalls.getInt(j);
			}

			Cell newCell = new Cell(left + blockSize*(i%widthSize) , top + blockSize*(floor(i/widthSize)) , walls , blockSize , i);
			map.add(newCell);
		}

		color c1 = color(255, 255, 0);
		PackMan firstPack = new PackMan((Cell)map.get(0),blockSize/2 , blockSize/2,c1,"packOne");
		myPack.add(firstPack);

		color c2 = color(255, 0, 0);
		PackMan secondPack = new PackMan((Cell)map.get(widthSize - 1),blockSize/2 , blockSize/2,c2,"packTwo");
		myPack.add(secondPack);
	}

	void drawMap(){
		movePackMan();
		for (int i = 0; i < myPack.size(); ++i) {
			PackMan pack = myPack.get(i);
			pack.drawMe();
			pack.drawScore(width - width/8 , height/6 + i*height/15);
		}
		for (int i = 0; i < map.size(); ++i) {
			Cell singleCell = (Cell)map.get(i);
			singleCell.drawMe();		
		}
	}

	void keyPressed() {
		PackMan firstPack = myPack.get(0);
		PackMan secondPack = myPack.get(1);
		if (keyPressed) {
			if (key == CODED) {
				if (keyCode == RIGHT) {				
					firstPack.setDirection(RIGHT_DIR);;
				}
				if (keyCode == DOWN) {
					firstPack.setDirection(DOWN_DIR);
				}
				if (keyCode == LEFT) {
					firstPack.setDirection(LEFT_DIR);
				}
				if (keyCode == UP) {
					firstPack.setDirection(UP_DIR);
				}
			}else{
				if (key == UP_DIR_L) {				
					secondPack.setDirection(UP_DIR);
				}
				if (key == DONW_DIR_L) {
					secondPack.setDirection(DOWN_DIR);
				}
				if (key == RIGHT_DIR_L) {
					secondPack.setDirection(RIGHT_DIR);;
				}
				if (key == LEFT_DIR_L) {
					secondPack.setDirection(LEFT_DIR);
				}
			}
		}	
	}

	Cell getNextCell(Cell packCurrentCell , int dir){
		Cell nextCell ;
		int curCellNum = packCurrentCell.getCellNumber();
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

	void movePackMan(){
		for (int i = 0; i < myPack.size(); ++i) {
			PackMan pack = myPack.get(i);
			int packManDir = pack.getDirection();		
			Cell packCurrentCell = pack.getCurrentCell();
			if (!packCurrentCell.hasWall(packManDir)) {
				Cell packNextCell = getNextCell(packCurrentCell,packManDir);
				if (!packNextCell.hasWall(changeDir(packManDir))) {
					pack.setCurrentCell(packNextCell);
				}
			}		
		}
	}	

	void beansEaten(){
		beansNumber = beansNumber - 1;		
		if (beansNumber <= 0) {
			gameHasFinished();
		}
	}

	void showResult(){
		String winnerName = "";
		int winnerScore = 0;
		for (int i = 0; i < myPack.size(); ++i) {
			PackMan winnerPack = myPack.get(i);
			if (winnerPack.score > winnerScore) {
				winnerName = winnerPack.name;
				winnerScore = winnerPack.score;
			}else if (winnerPack.score == winnerScore){
				winnerName = "";
			}
		}
		String winnerText = "The Winner is : ";
		if (winnerName == "") {
			winnerText = "Tie Result";
		}

		textSize(32);
		float winnerTextWidth = textWidth(winnerText);
		text(winnerText, width/2 - winnerTextWidth/2 , height/2 - 16);

		if (winnerName != "") {
			textSize(32);
			float winnerNameWidth = textWidth(winnerName + " with : " + winnerScore + " points");
			text(winnerName + " with : " + winnerScore + " points", width/2 - winnerNameWidth/2 , height/2 + 16);
		}


	}
}