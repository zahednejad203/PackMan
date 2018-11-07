class Cell {
	float x = 0;
	float y = 0;
	int[] walls = new int[4];
	int blockSize = 0;
	boolean hasBean = true;
	int cellNumber = 0;

	public Cell(float initialX , float initialY , int[] initialWalls , int initialBlockSize , int initialNumber) {
		x = initialX;
		y = initialY;
		walls = initialWalls;
		blockSize = initialBlockSize;
		cellNumber = initialNumber;
	}

	void drawMe(){
		if (walls[0] == 1) {
			stroke(255);
			line(x - blockSize/2, y - blockSize/2, x + blockSize/2, y - blockSize/2);
		}
		if (walls[1] == 1) {
			stroke(255);
			line(x + blockSize/2, y - blockSize/2, x + blockSize/2, y + blockSize/2);
		}
		if (walls[2] == 1) {
			stroke(255);
			line(x + blockSize/2, y + blockSize/2, x - blockSize/2, y + blockSize/2);
		}
		if (walls[3] == 1) {
			stroke(255);
			line(x - blockSize/2, y + blockSize/2, x - blockSize/2, y - blockSize/2);
		}

		if (hasBean == true) {
			fill(0, 255, 0);
			noStroke();
			ellipse(x, y, blockSize/8, blockSize/8);
		}	
	}

	JSONArray getWallJsonArray(){
		JSONArray wallJsonArray = new JSONArray();
		for (int i = 0; i < walls.length ; ++i) {
			wallJsonArray.setInt(i,walls[i]);
		}
		return wallJsonArray;
	}

	int getCellNumber(){
		return cellNumber;
	};

	float getX(){
		return x;
	}

	float getY(){
		return y;
	}

	void setBean(boolean status){
		hasBean = status;
	}

	boolean getBean(){
		return hasBean;
	}

	void setWall(int wallNum){		
		int wallValue = walls[wallNum];		
		if (wallValue == 0) {
			walls[wallNum] = 1;				
		}else{
			walls[wallNum] = 0;
		}
	}

	boolean hasWall(int direction){
		if(walls[direction] == 1){
			return true;
		}else {
			return false;
		}
	}
}