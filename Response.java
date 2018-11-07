import java.util.ArrayList;

public interface Response {
	public void setNumber(int number);	
	public ArrayList<Integer> getNumber();
	public void onClickResponse();
	public void onKeyPressedResponse();
}