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

echo,test:
echo,%strv%
echo,test:

::���´����滻�ı����ݣ�����Ҫ������ı�Ϊ1.txt

(For /f "delims=" %%i in (FNM\Client\FNMAuto.rc) do (
	echo %%i| Find /i "FILEVERSION 1,1,">nul
	If !errorLevel!==0 (echo %strv%) Else (echo %%i)
))>FNMAutoTemp.rc

If !errorLevel!==1 goto :end

del FNM\Client\FNMAuto.rc
ren FNM\Client\FNMAutoTemp.rc FNMAuto.rc


brcc32 "FNM\Client\fnmauto.rc"

dcc32 -b "FNM\Client\fnm.dpr"

pause

:end