
@echo off

set PERL=perl-561\perl.exe

set SENS=+
set DUREE=00:49

rem -------------------------------------------------
rem Filtre les lignes du fichier concernant le centre
rem -------------------------------------------------

set SCRIPT=shift-subtitles.pl

set FIC=test.srt
set FIC_OUT=test_out.srt

call %PERL% %SCRIPT% %FIC% %SENS% %DUREE% > %FIC_OUT%

pause

