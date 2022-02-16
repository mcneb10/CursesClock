       IDENTIFICATION DIVISION.
       PROGRAM-ID. clock.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TIMETOEXIT PICTURE X VALUE IS 'N'.
       01 KEYINPUT PICTURE 9(8) USAGE IS COMP.
       01 QUITKEY PICTURE 9(8) VALUE IS 113.
       01 YYYY PICTURE 9(4).
       01 MM PICTURE 9(2).
       01 DD PICTURE 9(2).
       01 HH PICTURE 9(2).
       01 MI PICTURE 9(2).
       01 SS PICTURE 9(2).    
       01 DATETEMP PICTURE 9(14).
       01 TITLE_PAIR PICTURE 9 VALUE IS 1.
       01 TIME_PAIR PICTURE 9 VALUE IS 2.
       01 HAS_COLORS PICTURE 9 USAGE IS COMP.
       01 WINDOWVAR USAGE POINTER.
       01 XSIZE PICTURE 9(3) USAGE IS COMP.
       01 YSIZE PICTURE 9(3) USAGE IS COMP.
       01 DV PICTURE 9(8) VALUE 0.
       01 TV PICTURE 9(8) VALUE 0.
       01 WS-TEMP-DT.
        05 WS-TEMP-DATE-TIME.
           10 WS-TEMP-DATE.
               15 WS-TEMP-YEAR  PIC  9(4).
               15 WS-TEMP-MONTH PIC  9(2).
               15 WS-TEMP-DAY   PIC  9(2).
           10 WS-TEMP-TIME.
               15 WS-TEMP-HOUR  PIC  9(2).
               15 WS-TEMP-MIN   PIC  9(2).
               15 WS-TEMP-SEC   PIC  9(2).
               15 WS-TEMP-MS    PIC  9(2).
           10 WS-DIFF-GMT         PIC S9(4).
       01 TEMPHOUR PIC 9(2) VALUE 0.
       01 MERIDIAN PIC X(2) VALUE 'AM'.
       01 COUNTER PIC 9(3) VALUE 0.
       01 NUMTEMP PIC 9(3) VALUE 0.
       PROCEDURE DIVISION.
       CALL "initscr" RETURNING WINDOWVAR.
       CALL "timeout" USING BY VALUE 0.
       CALL "curs_set" USING BY VALUE 0.
       CALL "has_colors" RETURNING HAS_COLORS.
       IF HAS_COLORS<>0 THEN
           CALL "start_color"
           CALL "init_pair" USING TITLE_PAIR, BY VALUE 7, BY VALUE 4
           CALL "init_pair" USING TIME_PAIR, BY VALUE 2, BY VALUE 1
       END-IF.
       PERFORM LOOP UNTIL TIMETOEXIT IS EQUAL TO 'Y'.
       CALL "erase".
       CALL "endwin".    
       DISPLAY "Thanks for using my clock!".
       STOP RUN.

       LOOP.
           ACCEPT XSIZE FROM COLUMNS.
           ACCEPT YSIZE FROM LINES.
           CALL "getch" RETURNING KEYINPUT.
           CALL "erase".
           SET COUNTER TO 0
           DIVIDE YSIZE BY 2 GIVING NUMTEMP
           SUBTRACT 5 FROM NUMTEMP
           PERFORM NL UNTIL COUNTER IS EQUAL TO NUMTEMP.
           SET COUNTER TO 0
           DIVIDE XSIZE BY 2 GIVING NUMTEMP
           SUBTRACT 10 FROM NUMTEMP
           PERFORM STAR UNTIL COUNTER IS EQUAL TO NUMTEMP.
      *>Color code not working        
      *    IF HAS_COLORS<>0 THEN
      *        CALL "attron" USING BY VALUE 256
      *    END-IF
           CALL "printw" USING "  Ben's Cool Clock  "
      *    IF HAS_COLORS<>0 THEN
      *        CALL "attroff" USING BY VALUE 256
      *    END-IF
           SET COUNTER TO 0
           DIVIDE XSIZE BY 2 GIVING NUMTEMP
           SUBTRACT 10 FROM NUMTEMP
           PERFORM STAR UNTIL COUNTER IS EQUAL TO NUMTEMP.
           SET COUNTER TO 0
           SET NUMTEMP TO XSIZE
           PERFORM STAR UNTIL COUNTER IS EQUAL TO NUMTEMP.
           SET COUNTER TO 0
           DIVIDE XSIZE BY 2 GIVING NUMTEMP
           SUBTRACT 12 FROM NUMTEMP
           PERFORM STAR UNTIL COUNTER IS EQUAL TO NUMTEMP.
           IF KEYINPUT IS EQUAL TO QUITKEY THEN
               MOVE 'Y' TO TIMETOEXIT
           ELSE
               MOVE FUNCTION CURRENT-DATE TO WS-TEMP-DATE-TIME
               SET TEMPHOUR TO WS-TEMP-HOUR
               IF WS-TEMP-HOUR > 12 THEN
                  MOVE "PM" TO MERIDIAN
                  SUBTRACT 12 FROM TEMPHOUR
               ELSE
                  MOVE "AM" TO MERIDIAN 
               END-IF
      *    IF HAS_COLORS<>0 THEN
      *        CALL "attron" USING BY VALUE 512
      *    END-IF
         CALL "printw" USING "    %02d/%02d/%0004d %02d-%02d-%02d %s  ",
      - BY VALUE WS-TEMP-MONTH, BY VALUE WS-TEMP-DAY, BY VALUE WS-TEMP-Y
      -EAR BY VALUE TEMPHOUR, BY VALUE WS-TEMP-MIN, BY VALUE WS-TEMP
      --SEC, BY VALUE MERIDIAN
      *    IF HAS_COLORS<>0 THEN
      *        CALL "wattroff" USING BY REFERENCE BY VALUE 512
      *    END-IF
           SET COUNTER TO 0
           DIVIDE XSIZE BY 2 GIVING NUMTEMP
           SUBTRACT 12 FROM NUMTEMP
           PERFORM STAR UNTIL COUNTER IS EQUAL TO NUMTEMP
           SET COUNTER TO 0
           MULTIPLY XSIZE BY 2 GIVING NUMTEMP
           PERFORM STAR UNTIL COUNTER IS EQUAL TO NUMTEMP
            CALL "refresh"
          END-IF.
        

       NL.
           CALL "printw" USING "%s", BY VALUE X'0A'
           ADD 1 TO COUNTER.
       
       STAR.
         CALL "printw" USING "*"
         ADD 1 TO COUNTER. 

