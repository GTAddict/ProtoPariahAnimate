This is a Rapid Prototype developed in 2 weeks by Cohort 13 students of Florida Interactive Entertainment Academy.
It was initially developed in FlashDevelop, however there were problems creating a release build using the Flex SDK. Thinking it was a problem with the way FlashDevelop interacts with the MXMLC compiler, we ported the entire project to a Flash Builder project, but the same problems arose. Namely, the generated SWF file would run fine on the debug version of the standalone Flash Player, but would fail to run on a browser. Note that the generated SWF file would be generated with enable-debug=false, i.e. in release mode. Also, if the SWF was moved to a different directory (along with all file references) after building, it would fail to work. Weird.
Although we were fine with it for development and grading purposes, eventually we decided we had to move everything over to Animate, where we could package it as a projector. This kinda beat the philosophy of cross-platform distribution, but well, beggars can't be choosers.

Team:
Brian Foye
Dale Diaz
Krishna Bharadwaj Y
Kory Lauver
Melissa Almirall
Michael Voguel

