@echo off&SetLocal EnableDelayedExpansion

del D:\Work\WMIS\SVN\CODE\FNM\Client\FNMAutoTemp.rc

for /f "skip=1 delims=" %%i in (D:\Work\WMIS\SVN\CODE\FNM\Client\fnmauto.rc) do ( 
    set str=%%~i 
    goto Next 
) 
:Next 

set stra=%str:~18,9999%   
set strf=%str:~0,18%

set /a stra+=1          

set strv=%strf%%stra%     

::echo,%strv%

::���´����滻�ı����ݣ�����Ҫ������ı�Ϊ1.txt

(For /f "delims=" %%i in (FNMAuto.rc) do (
	echo %%i| Find /i "FILEVERSION 1,1,">nul
	If !errorLevel!==0 (echo %strv%) Else (echo %%i)
))>FNMAutoTemp.rc

del D:\Work\WMIS\SVN\CODE\FNM\Client\FNMAuto.rc
ren D:\Work\WMIS\SVN\CODE\FNM\Client\FNMAutoTemp.rc FNMAuto.rc


brcc32 "D:\Work\WMIS\SVN\CODE\FNM\Client\fnmauto.rc"

dcc32 -b "D:\Work\WMIS\SVN\CODE\FNM\Client\fnm.dpr"

pause

