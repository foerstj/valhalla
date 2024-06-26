:: This script is supposed to be executed from your DS installation folder.
:: TankCreator is expected to be in a sibling dir.

:: name of mod, case-sensitive
set mod_cs=Valhalla
:: path of DSLOA documents dir (where Bits are)
set doc_dsloa=%USERPROFILE%\Documents\Dungeon Siege LoA
:: path of DS installation
set ds=.
:: path of TankCreator
set tc=..\TankCreator

set copyright=CC-BY-SA 2024
set author=Johannes Förstner

:: param
set mode=%1
echo %mode%

:: Compile resource file
rmdir /S /Q "%tmp%\Bits"
robocopy "%doc_dsloa%\Bits\world\contentdb\templates\veteran" "%tmp%\Bits\world\contentdb\templates\veteran" /E
robocopy "%doc_dsloa%\Bits\world\contentdb\templates\elite" "%tmp%\Bits\world\contentdb\templates\elite" /E
%tc%\RTC.exe -source "%tmp%\Bits" -out "%ds%\DSLOA\%mod_cs%.dsres" -copyright "%copyright%" -title "%mod_cs%" -author "%author%"
if %errorlevel% neq 0 pause

setlocal EnableDelayedExpansion
if "%mode%"=="release" (
  :: Compile vanilla-only resource file
  rmdir /S /Q "%tmp%\Bits"
  robocopy "%doc_dsloa%\Bits\world\contentdb\templates\veteran" "%tmp%\Bits\world\contentdb\templates\veteran" /E /xf dsx_* /xf *_dsx_*
  robocopy "%doc_dsloa%\Bits\world\contentdb\templates\elite" "%tmp%\Bits\world\contentdb\templates\elite" /E /xf dsx_* /xf *_dsx_*
  %tc%\RTC.exe -source "%tmp%\Bits" -out "%ds%\DSLOA\%mod_cs% - Vanilla.dsres" -copyright "%copyright%" -title "%mod_cs%" -author "%author%"
  if !errorlevel! neq 0 pause
)
endlocal

:: Cleanup
rmdir /S /Q "%tmp%\Bits"
