@echo off
setlocal enabledelayedexpansion 
set ip=%~1
set file=%~2
set to_all=1
set all_files=1
REM Remote Machine user
set username=prometheus
REM Remote Machine user password
set passwd=ro
REM Remote Machine destination folder 
set destination=c:/Users/prometheus/PSCP
REM List of all machines ip
set ip_list="192.168.1.136" "192.168.1.137"

REM if there are no parameters in input send all files to all machines
if "%ip%"=="" goto :send_all_to_all

REM Check first parameter, if it's equal to "help" show instructions
if "%ip%"=="help" goto :show_help

REM Check first parameter, if it's not equal to "all" it means we want to send to a specific machine
if not "%ip%"=="" (
    if not "%ip%"=="all" (
        set to_all=0
    )
)

REM Check if second parameter is empty, if not it means we want to send a specific file otherwise all files
if not "%file%"=="" (
    set all_files=0
)

REM Send one or more files to a specific machine
if %to_all% == 0 (
    if %all_files% == 1 (
        goto :send_all_to_one
    ) else (
        goto :send_one_to_one
    )
)

REM Send one file to all machines
if %to_all% == 1 (
    if %all_files% == 0 (
        goto :send_one_to_all
    ) 
)

:send_all_to_all
echo Send all files to all machines...
(for %%a in (%ip_list%) do ( 
   echo Sending all files to machine %%a
   pscp.exe -pw %passwd% *.* %username%@%%a:%destination%
))
echo COMPLETE All files sent to all machines
goto :eof

:send_all_to_one
echo Sending all files to machine %ip%
pscp.exe -pw %passwd% *.* %username%@%ip%:%destination%
echo COMPLETE! All files sent to machine %ip%
goto :eof

:send_one_to_one
echo Sending %file% to machine %ip%
pscp.exe -pw %passwd% %file% %username%@%ip%:%destination%
echo COMPLETE File %file% sent to machine %ip%
goto :eof

:send_one_to_all
(for %%a in (%ip_list%) do ( 
   echo Sending %file% to machine %%a
   pscp.exe -pw %passwd% %file% %username%@%%a:%destination%
))
echo COMPLETE File %file% sent to all machines
goto :eof

:show_help
echo SendFile script created by L.Zanconi
echo -to send a specific file to all machines: SendFile all example.mp4
echo -to send a specific to a specific machine: SendFile 192.168.1.5 example.mp4
echo -to send all files to a specific machine: SendFile 192.168.1.6 
echo -to send all files to all machines just leave empty: SendFile
goto :eof 