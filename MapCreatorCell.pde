class MapCreatorCell extends Cell {

	boolean hasBeenSelected = false;

	public MapCreatorCell(float initialX , float initialY , int[] initialWalls , int initialBlockSize , int initialNumber) {
		super(initialX, initialY, initialWalls, initialBlockSize, initialNumber);
	}

	@Override 
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
		
		if (hasBeenSelected) {
			fill(255, 255, 0);
			noStroke();
			rect(x - blockSize/2.4, y - blockSize/2.4, blockSize/1.2, blockSize/1.2);
		}

		if (hasBean == true) {
			fill(0, 255, 0);
			noStroke();
			ellipse(x, y, blockSize/8, blockSize/8);
		}
	}

	void setStatus(boolean status){
		hasBeenSelected = status;
	}
}