@echo off

echo Author: AMazhindu
echo Email:  amazhindu@gmail.com
echo Date created: 19 July 2021

:: echo %~dp0
cd /D %~dp0
if not exist "pratyush_temporary\" mkdir pratyush_temporary

echo .
echo .
echo Sit back and relax while your files are being downloaded.
echo .
echo .
echo Downloading Python 3.7.9 32-bit
echo ....................................................................................
echo ####################################################################################
:: If you want to download a different Python version, update the below line.
curl --output pratyush_temporary\python-3.7.9.exe --url https://www.python.org/ftp/python/3.7.9/python-3.7.9.exe

echo .
echo .
echo Downloading GDAL Core 3.1.1 32-bit
echo ....................................................................................
echo ####################################################################################
:: If you want to download a different GDAL version, update the below line.
curl --output pratyush_temporary\gdal-301-1900-core.msi --url http://download.gisinternals.com/sdk/downloads/release-1900-gdal-3-1-3-mapserver-7-6-1/gdal-301-1900-core.msi

echo .
echo .
echo Downloading GDAL for Python
echo ....................................................................................
echo ####################################################################################
:: If you changed the Python version, update the below line too.
curl --output pratyush_temporary\GDAL-3.1.3.win32-py2.7.msi --url http://download.gisinternals.com/sdk/downloads/release-1900-gdal-3-1-3-mapserver-7-6-1/GDAL-3.1.3.win32-py2.7.msi

echo .
echo .

:: Perform checks for the files.
if exist pratyush_temporary\python-3.7.9.exe (
echo Python 3.7.9 32bit successfully downloaded!
) else (
echo Python download failed. The program will now terminate, please start manually.
TIMEOUT /T 15
exit /B
)

if exist pratyush_temporary\gdal-301-1900-core.msi (
echo GDAL Core 3.1.1 32bit successfully downloaded!
) else (
echo GDAL core download failed. The program will now terminate, please start manually.
TIMEOUT /T 15
exit /B
)

if exist pratyush_temporary\GDAL-3.1.3.win32-py2.7.msi (
echo GDAL for Python successfully downloaded!
) else (
echo GDAL for Python download failed. The program will now terminate, please start manually.
TIMEOUT /T 15
exit /B
)

echo .
echo .
echo Proceeding to installation. Please assign the installation directories..
TIMEOUT /T 10

:: Run the three setup files successively.
pratyush_temporary\python-3.7.9.exe
pratyush_temporary\gdal-301-1900-core.msi
pratyush_temporary\GDAL-3.1.3.win32-py2.7.msi

echo .
echo .
echo All programs installed. Adding paths to environment variables.

:: Add the path to system environment variables.
if "%path%"=="%path:C:\Program Files\GDAL=%" (
setx /m path "%path%;C:\Program Files\GDAL;
)
if "%path%"=="%path:C:\Python37=%" (
setx /m path "%path%;C:\Python37;
)
if "%path%"=="%path:C:\Python37\Scripts=%" (
setx /m path "%path%;C:\Python37\Scripts;
)

:: Create new variables in the system environment for GDAL.
setx /m GDAL_DATA "C:\Program Files\GDAL\gdal-data"
setx /m GDAL_DRIVER_PATH "C:\Program Files\GDAL\gdalplugins"
setx /m GDAL_VERSION "3.1.1"

:: Rename the Python file to be able to call from Command Prompt.
copy "C:\Python37\python.exe" "C:\Python37\python37.exe"

echo .
echo .
echo Installation complete! The program will terminate in 30 seconds.
echo .
echo .
TIMEOUT /T 30
