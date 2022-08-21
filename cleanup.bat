:: This script is supposed to be executed from your DS installation folder.

:: name of mod, case-sensitive
set mod_cs=Valhalla
:: path of DS installation
set ds=.

:: Cleanup resources so as not to confuse Siege Editor
del "%ds%\Resources\%mod_cs%.dsres"
