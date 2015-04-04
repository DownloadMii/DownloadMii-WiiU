::Copyright Filiph Sandström 2015

::The main function
:MAIN
@ECHO OFF
CLS
ECHO DownloadMii Wii U build setup 0.1
ECHO ---------------------------------
ECHO.
                                                            
ECHO|SET /p= [*]Copying "OpenSans-Regular.ttf" from external resources...
MKDIR data > NUL 2> nul
CD ..
IF NOT EXIST "externals\OpenSans\" (
     CALL:EXITERROR "Cannot find the OpenSans resource!"
)
@COPY /B /Y "externals\OpenSans\Fonts\OpenSans-Regular.ttf" "src\data\OpenSansRegular.ttf" > NUL
ECHO Done!
CD src
SET /P BUILD=Are you ready to build DownloadMii now? (Y/N)
IF /i {%BUILD%}=={y} (GOTO:MAKE) 
IF /i {%BUILD%}=={yes} (GOTO:MAKE) 
GOTO:END

::Function to exit the program with an error msg
:ExitERROR
ECHO.
ECHO. ****Error: %~1****
PAUSE
GOTO:END

::Function to make the app
:MAKE
ECHO Building...
IF NOT EXIST "makefile" (
	CALL:EXITERROR "Cannot find the makefile!"
)
make > NUL
if ERRORLEVEL 2 (
	CALL:ExitERROR "Makefile is invalid, please re-clone the repo!"
)
if ERRORLEVEL 1 (
	CALL:ExitERROR "There seems to be an error in the code, please correct it and then come back and try again!"
)
ECHO Built!
GOTO:END

:END
ECHO.
ECHO Thanks for using the DownloadMii for Wii U build setup!
ECHO Exiting...
::Sleep for 2.5 seconds
SLEEP 2.5
exit
