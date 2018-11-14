class PackMan {

	float pWidth = 0;
	float pHeight = 0;
	float x = 0;
	float y = 0;
	Cell currentCell;
	int state = 0;
	int direction = RIGHT_DIR;
	int score = 0;
	color packColor ;
	String name = "";
	Callback callback;

	public PackMan (Cell initialCell, float initialWidth , float initialHeight , color initialColor , String initalName , Callback initialCallback) {
		pWidth = initialWidth;
		pHeight = initialHeight;
		packColor = initialColor;
		name = initalName;
		callback = initialCallback;
		this.setCurrentCell(initialCell);
	}

	void setWidth(float newWidth){
		pWidth = newWidth;
	}

	void setHeight(float newHeight){
		pHeight = newHeight;
	}

	Cell getCurrentCell(){
		return currentCell;
	}

	void setCurrentCell (Cell newCell){
		if (newCell.getBean()) {
			newCell.setBean(false);
			score = score + 1;
			callback.callbackfunction("");
		}
		currentCell = newCell;
		x = newCell.getX();
		y = newCell.getY();
	}

	void setX(float newX){
		x = newX;
	}

	void setY(float newY){
		y = newY;
	}

	void setDirection(int newDirection){
		direction = newDirection;
	}

	int getDirection(){
		return direction;
	}

	void drawScore(int scoreX , int scoreY){
		fill(255, 255, 255);
		textSize(25);
		text( name + " : " + score , scoreX, scoreY);
	}

	void drawMe() {
		fill(packColor);
		noStroke();		
		if (state == 0 ) {
			state = 1;
			if (direction == RIGHT_DIR) {
				arc(x, y, pWidth, pHeight , radians(20) , radians(340) , PIE);
				fill(0);
				ellipse(x + pWidth/20, y - pHeight/6, pWidth/15, pHeight/15);
			}else if (direction == DOWN_DIR) {
				arc(x, y, pWidth, pHeight , radians(110) , radians(430) , PIE);
				fill(0);
				ellipse(x + pWidth/6, y + pHeight/6, pWidth/15, pHeight/15);
			}else if (direction == LEFT_DIR) {
				arc(x, y, pWidth, pHeight , radians(-160) , radians(160) , PIE);
				fill(0);
				ellipse(x - pWidth/6, y - pHeight/6, pWidth/15, pHeight/15);
			}else if (direction == UP_DIR) {
				arc(x, y, pWidth, pHeight , radians(-70) , radians(250) , PIE);
				fill(0);
				ellipse(x - pWidth/6, y - pHeight/6, pWidth/15, pHeight/15);
			}
		}else{
			state = 0;
			ellipse(x, y, pWidth, pHeight);
			if (direction == RIGHT_DIR){
				fill(0);
				ellipse(x + pWidth/10, y - pHeight/10, pWidth/15, pHeight/15);				
			}else if (direction == DOWN_DIR) {
				fill(0);
				ellipse(x + pWidth/10, y + pHeight/4, pWidth/15, pHeight/15);
			}else if (direction == LEFT_DIR) {
				fill(0);
				ellipse(x - pWidth/4, y - pHeight/10, pWidth/15, pHeight/15);
			}else if (direction == UP_DIR) {
				fill(0);
				ellipse(x - pWidth/6, y - pHeight/6, pWidth/15, pHeight/15);
			}
		}
	}
}