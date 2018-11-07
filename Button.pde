class Button implements Response{

	float xPos = 0;
	float yPos = 0;
	String label = "";
	float buttonWidth =	0;
	float buttonHeigth = 0;
	color buttonColor = color(0, 0, 255);	
	Response callback;
	ArrayList<Integer> listenersNumber = new ArrayList<Integer>();

	public Button(float initialXPos, float initialYPos, String initialLabel, float initialButtonWidth, float initialButtonHeigth, color initialColor, Response initialCallback){
		xPos = initialXPos;
		yPos = initialYPos;
		label = initialLabel;
		buttonWidth = initialButtonWidth;
		buttonHeigth = initialButtonHeigth;
		buttonColor = initialColor;
		callback = initialCallback;
	}

	void drawMe(){
		noStroke();
		fill(buttonColor);
		rect(xPos - buttonWidth/2, yPos - buttonHeigth/2 , buttonWidth, buttonHeigth);

		fill(255,255,255);
		textSize(buttonWidth/5);
		float labelWidth = textWidth(label);
		if (labelWidth > buttonWidth) {
			textSize(labelWidth/6.5);
			labelWidth = textWidth(label);
		}
		text(label,xPos - labelWidth/2 , yPos + 7);
	}

	void onClickResponse(){		
		if (mouseX >= xPos-buttonWidth/2 && xPos+buttonWidth/2 >= mouseX && mouseY >= yPos-buttonHeigth && yPos+buttonHeigth/2 >= mouseY) {
			callback.onClickResponse();
		}
	}

	void onKeyPressedResponse(){}

	void setNumber(int number){
		listenersNumber.add(number);
	}

	ArrayList<Integer> getNumber(){
		return listenersNumber;
	}	
}