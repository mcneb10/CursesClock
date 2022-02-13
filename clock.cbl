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
       PROCEDURE DIVISION.
       CALL "initscr".
       CALL "timeout" USING 0.
       PERFORM LOOP UNTIL TIMETOEXIT IS EQUAL TO 'Y'.
       CALL "endwin".    
       STOP RUN.

       LOOP.
           CALL "clear".
           CALL "refresh".
           CALL "getch" RETURNING KEYINPUT.
           IF KEYINPUT=QUITKEY THEN
               MOVE 'Y' TO TIMETOEXIT
           ELSE
             ACCEPT DATETEMP FROM DATE
             MOVE DATETEMP(1:4) TO YYYY
             MOVE DATETEMP(5:2) TO MM
             MOVE DATETEMP(7:2) TO DD
             MOVE DATETEMP(9:2) TO HH
             MOVE DATETEMP(11:2) TO MI
             MOVE DATETEMP(13:2) TO SS
            CALL "printw" USING "%d/%d/%d %d-%d-%d", MM, DD YYYY, HH,
      -MI, SS
            CALL "refresh"
            CALL "C$SLEEP" USING 0.1
          END-IF.
