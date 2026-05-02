@echo off
:loop
::this is a bit awkward...
ping -n 5 127.0.0.1 >NUL
goto loop