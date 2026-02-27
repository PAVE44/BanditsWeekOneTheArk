@echo off
mkdir output

for %%F in (*.*) do (
    "C:\Program Files (x86)\sox-14-4-2\sox.exe" "%%F" "output\%%F" vol 7dB
)

echo Done!
pause
