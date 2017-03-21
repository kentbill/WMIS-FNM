@echo off&SetLocal EnableDelayedExpansion

del FNM\Client\FNMAutoTemp.rc

for /f "skip=1 delims=" %%i in (FNM\Client\fnmauto.rc) do ( 
    set str=%%~i 
    goto Next 
) 
:Next 

set stra=%str:~18,9999%   
set strf=%str:~0,18%

set /a stra+=1          

set strv=%strf%%stra%     

::echo,%strv%

::以下代码替换文本内容，假设要处理的文本为1.txt

(For /f "delims=" %%i in (FNMAuto.rc) do (
	echo %%i| Find /i "FILEVERSION 1,1,">nul
	If !errorLevel!==0 (echo %strv%) Else (echo %%i)
))>FNMAutoTemp.rc

del FNM\Client\FNMAuto.rc
ren FNM\Client\FNMAutoTemp.rc FNMAuto.rc


brcc32 "FNM\Client\fnmauto.rc"

dcc32 -b "FNM\Client\fnm.dpr"

pause

