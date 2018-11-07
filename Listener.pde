class Listener {
	Response callback;
	String type = "";

	public Listener(String initialType , Response initialCallback){
		type = initialType;
		callback = initialCallback;
	}

	String getType(){
		return type;
	}

	void excuteCallback(){
		if (type == "clicked") {
			callback.onClickResponse();
		}else if (type == "keyPress"){
			callback.onKeyPressedResponse();
		}
	}
}