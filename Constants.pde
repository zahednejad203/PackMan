// variables

int UP_DIR = 0 ;
int RIGHT_DIR = 1;
int DOWN_DIR = 2 ;
int LEFT_DIR = 3 ;

char UP_DIR_L = 'w';
char DONW_DIR_L = 's';
char RIGHT_DIR_L = 'd';
char LEFT_DIR_L = 'a';

String GAME_FINISHED = "Finished";
String GAME_PLAYING = "Playing";

// functions

int changeDir(int dir){
	if (dir == RIGHT_DIR) {
		return LEFT_DIR;
	}else if (dir == LEFT_DIR){
		return RIGHT_DIR;
	}else if (dir == UP_DIR) {
		return DOWN_DIR;
	}else {
		return UP_DIR;
	}
}