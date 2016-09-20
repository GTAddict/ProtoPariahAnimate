mkdir ProtoPariah
cd ProtoPariah
mkdir Win
mkdir Mac
cd ..

cd bin

REM Copy windows
xcopy "ProtoPariah.exe" "../ProtoPariah/Win/*" /Y
xcopy "game.config" "../ProtoPariah/Win/*" /Y


REM Copy mac
xcopy "ProtoPariah.app" "../ProtoPariah/Mac/ProtoPariah.app" /S /Y /I
xcopy "game.config" "../ProtoPariah/Mac/*" /Y

cd ..

REM Copy levels
xcopy "levels" "ProtoPariah/levels" /S /Y /I

REM Copy misc
xcopy "XenonLayoutExporter.jsx" "ProtoPariah/*" /Y
xcopy "Credits.txt" "ProtoPariah/*" /Y
7za a ProtoPariah.zip ProtoPariah -xr!*.psd
7za a ProtoPariahWithPSLevels.zip ProtoPariah

rmdir ProtoPariah /s /q
