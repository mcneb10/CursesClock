#include <stdio.h>
#include <time.h>
#include <ncurses.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdlib.h>
#define TITLE_PAIR 1
#define TIME_PAIR 2

//Ben's Cool Clock
int main() {
	//Initialize clock
	initscr();
	//Set input timeout to 0
	timeout(0);
	//Hide cursor
	curs_set(0);
	//If terminal has colors
	if (has_colors()) {
		//Initialize color stuff
		start_color();
		//Set title color scheme
		init_pair(TITLE_PAIR, COLOR_WHITE, COLOR_BLUE);
		//Set time color scheme
		init_pair(TIME_PAIR, COLOR_GREEN, COLOR_RED);
	}
	//Run until someone hits q
	while(getch() != 'q') {
		//Get time
		time_t t = time(NULL);
		struct tm tm = *localtime(&t);
		//Get window size
		struct winsize w;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
		//Clear screen
		erase();
		//Center and fill clock
		for(int i=0; i < (w.ws_row/2)-5;i++) {
			printw("\n");
		}
		for(int i=0; i < (w.ws_col/2)-10;i++) {
			printw("*");
		}
		//If terminal has color set and unset colorscheme
		if(has_colors()) attron(COLOR_PAIR(TITLE_PAIR));
		printw("  Ben's Cool Clock  ");
		if(has_colors()) attroff(COLOR_PAIR(TITLE_PAIR));
		//More filling
		for(int i=0; i < (w.ws_col/2)-10;i++) {
			printw("*");
		}
    for(int i=0; i < w.ws_col; i++) {
			printw("*");
		}
		for(int i=0; i < (w.ws_col/2)-12; i++) {
			printw("*");
		}
		//Set terminal time color
		if(has_colors()) attron(COLOR_PAIR(TIME_PAIR));
		//Print time
		printw(
				"    %02d/%02d/%0004d %02d-%02d-%02d %s  ",
				tm.tm_mon+1,
				tm.tm_mday,
				tm.tm_year+1900,
				tm.tm_hour > 12 ? tm.tm_hour - 12 : tm.tm_hour,
				tm.tm_min,
				tm.tm_sec,
				tm.tm_hour > 12 ? "PM" : "AM" 
		);
		//Unset time color
		if(has_colors()) attroff(COLOR_PAIR(TIME_PAIR));
		//More filling
		for(int i=0; i < (w.ws_col/2)-12; i++) {
			printw("*");
		}
		for(int i=0; i < w.ws_col*2; i++) {
			printw("*");
		}
		//Refresh screen
		refresh();
	}
	//End curses session
	endwin();
	//Print end messare
	printf("Thanks for using my clock\n");
	return 0;
}
