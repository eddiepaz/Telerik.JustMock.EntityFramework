@ECHO OFF
@CLS

SET VSVARSBATCH="%VS140COMNTOOLS%vsvars32.bat"
IF NOT EXIST %VSVARSBATCH% GOTO VS_ERROR

IF "%VARSLOADED%" == "1" GOTO BUILD
CALL %VSVARSBATCH%
IF ERRORLEVEL 1 GOTO VS_ERROR
SET VARSLOADED=1

SET SOLUTION=Telerik.JustMock.EntityFramework.sln

:BUILD

ECHO.
ECHO Building v4.0 ...
ECHO.

MSBUILD.EXE "%SOLUTION%" /p:Configuration=Release /p:TargetFrameworkVersion=v4.0 /p:DefineConstants="NET40;Trace" /v:m
IF ERRORLEVEL 1 GOTO BUILD_ERROR

ECHO.
ECHO Building v4.5 ...
ECHO.

MSBUILD.EXE "%SOLUTION%" /p:Configuration=Release /p:TargetFrameworkVersion=v4.5 /p:DefineConstants="NET45;Trace" /v:m
IF ERRORLEVEL 1 GOTO BUILD_ERROR

GOTO OUT

:VS_ERROR
ECHO ***************************************************************************
ECHO ERROR: Make sure Visual Studio 2015 is installed. If so, modify            
ECHO        the path in this batch file to indicate its location.               
ECHO ***************************************************************************
GOTO OUT

:BUILD_ERROR
ECHO.
ECHO ***************************************************************************
ECHO ERROR: A build error has occurred! The build process has aborted.
ECHO ***************************************************************************
GOTO OUT

:OUT
PAUSE
