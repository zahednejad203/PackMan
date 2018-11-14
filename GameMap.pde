class GameMap extends Map implements Response,Callback{	
	ArrayList<PackMan> myPack = new ArrayList<PackMan>() ;
	ArrayList<Integer> listenersNumber = new ArrayList<Integer>();

	public GameMap(int initialWidthSize , int initialHeightSize , int initialBlockSize , String initailMapFile){
		super(initialWidthSize, initialHeightSize, initialBlockSize, initailMapFile);
	}

	void initPackMans(){
		color c1 = color(255, 0, 0);
		PackMan firstPack = new PackMan((Cell)map.get(0),blockSize/2 , blockSize/2,c1,"packOne" , this);
		myPack.add(firstPack);

		color c2 = color(255, 255, 0);
		PackMan secondPack = new PackMan((Cell)map.get(widthSize - 1),blockSize/2 , blockSize/2,c2,"packTwo" , this);
		myPack.add(secondPack);
	}

	void updatePackMan(){
		movePackMan();
		for (int i = 0; i < myPack.size(); ++i) {
			PackMan pack = myPack.get(i);
			pack.drawMe();
			pack.drawScore(width/4 + i*width/3 , height/12);
		}
	}

	void onClickResponse(){}

	void onKeyPressedResponse() {
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

	void setNumber(int number){
		listenersNumber.add(number);
	}

	ArrayList<Integer> getNumber(){
		return listenersNumber;
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

	void callbackfunction(String param){
		beansNumber = beansNumber - 1;		
		if (beansNumber <= 0) {
			gameHasFinished();
		}
	}

	void showResult(){
		String winnerName = "";
		int winnerScore = 0;
		PackMan winnerPack = myPack.get(0);
		for (int i = 0; i < myPack.size(); ++i) {
			PackMan tmpPack = myPack.get(i);
			if (tmpPack.score > winnerScore) {
				winnerName = tmpPack.name;
				winnerScore = tmpPack.score;			
				winnerPack = tmpPack;
			}else if (tmpPack.score == winnerScore){
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
			text(winnerName + " with " + winnerScore + " points", width/2 - winnerNameWidth/2 , height/2 + 25);

			winnerPack.setX(width/2);
			winnerPack.setY(height/4);
			winnerPack.setWidth(width/5);
			winnerPack.setHeight(width/5);
			winnerPack.drawMe();			
		}

	}
}