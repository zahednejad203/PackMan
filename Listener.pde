class Listener {
	Response callback;
	String type = "";
	int id = 0;

	public Listener(String initialType , Response initialCallback , int initialId){
		type = initialType;
		callback = initialCallback;
		id = initialId;
	}

	String getType(){
		return type;
	}

	int getId(){
		return id;
	}
	
	void excuteCallback(){
		if (type == "clicked") {
			callback.onClickResponse();
		}else if (type == "keyPress"){
			callback.onKeyPressedResponse();
		}
	}
}