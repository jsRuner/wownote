@echo off
set SourceFile="E:\Ä§ÊÞÊÀ½ç\WTF\Account\WUWENFU090\SavedVariables\WowNote.lua"

set ToDir="E:\wuwenfu\wownote\"

set filename=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%


echo %SourceFile%

echo %ToDir%

echo %ToDir%%filename%.txt


move "%SourceFile%" "%ToDir%%filename%.txt"


