  !include "MUI2.nsh"
  !include nsDialogs.nsh
  !include LogicLib.nsh

  Name "ʾ������İ�װ����"
  OutFile "Example.exe"

  ;Default installation folder
  InstallDir "$LOCALAPPDATA\ExampleDir"

  RequestExecutionLevel user
;--------------------------------
;Interface Settings

  !define MUI_LANGDLL_ALLLANGUAGES
 
;--------------------------------



;Pages

  !insertmacro MUI_PAGE_WELCOME
;  !insertmacro MUI_PAGE_LICENSE "License.txt"  ;���û�и��ļ���ɾ���˾�
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  Page custom Dirctions DirctionsLeave

  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"   
  !insertmacro MUI_LANGUAGE "SimpChinese"

;--------------------------------
;Installer Sections

Section "�������" SecDummy

  SetOutPath "$INSTDIR"
;  File "..\Path.csv"  ;���û�и��ļ���ɾ���˾�


  ;ADD YOUR OWN FILES HERE...
     
  SetOutPath $INSTDIR
  CreateShortCut "$DESKTOP\ʾ�������ݷ�ʽ.lnk" $INSTDIR\Example.exe

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd


Var Dialog
Var BrowseButton

Var Dir1
Var Dir2
Var Dir3
Var Dir4

Var Dir1_State
Var Dir2_State
Var Dir3_State
Var Dir4_State

Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY
  StrCpy $Dir1_State "$INSTDIR"
  StrCpy $Dir2_State "$INSTDIR"
  StrCpy $Dir3_State "$INSTDIR"
  StrCpy $Dir4_State "$INSTDIR"
FunctionEnd

Function FileWrite
 FileOpen $4 "$INSTDIR\Path.csv" w
 FileWrite $4 "Path1,$Dir1_State,$\r$\nPath2,$Dir2_State,$\r$\nPath3,$Dir3_State,$\r$\nPath4,$Dir4_State"
 FileClose $4
FunctionEnd


Function Dirctions
  !insertmacro MUI_HEADER_TEXT "�Զ��尲װ����" "������ĸ���ַ����"

  nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

	${NSD_CreateLabel} 0 0 100% 12u "�����ļ���1·��:"
	Pop $0
	${NSD_CreateText} 0 13u 75% 12u $Dir1_State
	Pop $Dir1
	${NSD_CreateBrowseButton} 80% 13u 20% 12u "���..."
	Pop $BrowseButton
  ${NSD_OnClick} $BrowseButton SelectFolder1

	${NSD_CreateLabel} 0 26u 100% 12u "�����ļ���2·��:"
	Pop $0
	${NSD_CreateDirRequest} 0 39u 75% 12u $Dir2_State
	Pop $Dir2
	${NSD_CreateBrowseButton} 80% 39u 20% 12u "���..."
	Pop $BrowseButton
  ${NSD_OnClick} $BrowseButton SelectFolder2

	${NSD_CreateLabel} 0 52u 100% 12u "�����ļ���3·��:"
	Pop $0
	${NSD_CreateDirRequest} 0 65u 75% 12u $Dir3_State
	Pop $Dir3
	${NSD_CreateBrowseButton} 80% 65u 20% 12u "���..."
	Pop $BrowseButton
  ${NSD_OnClick} $BrowseButton SelectFolder3

	${NSD_CreateLabel} 0 78u 100% 12u "�����ļ���4·��:"
	Pop $0
	${NSD_CreateDirRequest} 0 91u 75% 12u $Dir4_State
	Pop $Dir4
	${NSD_CreateBrowseButton} 80% 91u 20% 12u "���..."
	Pop $BrowseButton
  ${NSD_OnClick} $BrowseButton SelectFolder4

	nsDialogs::Show
FunctionEnd

Function DirctionsLeave
${NSD_GetText} $Dir1 $Dir1_State
${NSD_GetText} $Dir2 $Dir2_State
${NSD_GetText} $Dir3 $Dir3_State
${NSD_GetText} $Dir4 $Dir4_State

Call FileWrite ;����д�ļ�����
FunctionEnd

Function SelectFolder1
  nsDialogs::SelectFolderDialog "ѡ���ļ���" "$INSTDIR"
  Pop $0
  ${NSD_SetText} $Dir1 $0
FunctionEnd

Function SelectFolder2
  nsDialogs::SelectFolderDialog "ѡ���ļ���" "$INSTDIR"
  Pop $0
  ${NSD_SetText} $Dir2 $0
FunctionEnd

Function SelectFolder3
  nsDialogs::SelectFolderDialog "ѡ���ļ���" "$INSTDIR"
  Pop $0
  ${NSD_SetText} $Dir3 $0
FunctionEnd

Function SelectFolder4
  nsDialogs::SelectFolderDialog "ѡ���ļ���" "$INSTDIR"
  Pop $0
  ${NSD_SetText} $Dir4 $0
FunctionEnd


Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...
  Delete "$DESKTOP\ʾ�������ݷ�ʽ.lnk"
  Delete "$INSTDIR\Example.exe"
  Delete "$INSTDIR\Path.csv"

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"
SectionEnd

