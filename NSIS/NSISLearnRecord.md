# NSIS指令记录  

* 包含文件：***!include 文件名***。例：  
~~~  
  !include "MUI2.nsh"
  !include nsDialogs.nsh
  !include LogicLib.nsh  
~~~   
* 安装时显示的软件名称设置：***Name 名称***。例：   
~~~
  Name "我是一个软件"  
~~~    
* 输出安装包名称设置：***OutFile 名称***。当名称仅为文件名时，其输出路径为脚本文件所在路径。例：  
~~~
  OutFile "软件.exe"
~~~  
* 默认安装路径设置：***InstallDir 路径***。使用此设置后，脚本中宏$INSTDIR既是设置的路径。例：  
~~~
  InstallDir "$LOCALAPPDATA\A0410"
~~~  
* 安装包所需权限设置：***RequestExecutionLevel 权限名***。未设置则默认为管理员权限。例：  
~~~
  RequestExecutionLevel user
~~~   
* 使用宏：***!insertmacro 宏*** 或 ***!macro 宏***。例：  
~~~
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "English"   
  !insertmacro MUI_LANGUAGE "SimpChinese"
~~~  
* 组件标识符：***Section 组件名*** 和结束标记 ***SectionEnd***。例：  
~~~
Section "软件组件1" SecDummy

  SetOutPath "$INSTDIR"
  File "..\file.exe"
  ;ADD YOUR OWN FILES HERE...
     
  SetOutPath $INSTDIR
  CreateShortCut "$DESKTOP\我是桌面快捷方式.lnk" $INSTDIR\软件.exe
SectionEnd
~~~  
* 设置文件输出路径：***SetOutPath 路径***。例：  
~~~
  SetOutPath "$INSTDIR"
  File "..\file.exe"
~~~  
* 创建快捷方式：***CreateShortCut "路径\快捷方式名称.lnk" 源程序地址***。例：  
~~~
  SetOutPath $INSTDIR
  CreateShortCut "$DESKTOP\我是桌面快捷方式.lnk" $INSTDIR\软件.exe
~~~  
* 声明变量：***Var 变量名***。例：  
~~~
    Var i
~~~  
* 自定义函数：***Function 函数名*** 和 ***FunctionEnd*** 组成。例：  
~~~
Function FileWrite
 FileOpen $4 "$INSTDIR\Path.csv" w
 FileWrite $4 "Index,Name,Settings,Note$\r$\n1,SlotCol,1,$\r$\n 2,SlotRow,1"
 FileClose $4
FunctionEnd
~~~  
* 调用函数：***Call 函数名***。例：  
~~~
Function DirctionsLeave
Call FileWrite
FunctionEnd
~~~   
* 初始化窗口前调用：***Function .onInit*** 和 ***FunctionEnd*** 。例：  
~~~
Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
  StrCpy $DirSequence_State "$INSTDIR"
  StrCpy $DirProject_State "$INSTDIR"
  StrCpy $DirBIN_State "$INSTDIR"
  StrCpy $DirLog_State "$INSTDIR"
FunctionEnd
~~~  
* 文件操作：***FileOpen、FileWrite、FileRead、FileSeek、FileClose***  
    * FileOpen使用方式：***FileOpen 保存打开文件的地址的变量 文件地址 打开方式*** ，打开方式有w、a、r三种，分别为覆盖或创建写、追加写和读取。  
    * FileWrite使用方式：***FileWrite 文件地址 写入值***  
    * FileRead使用方式：比较复杂，移步至[NSIS文件读写](https://nsis.sourceforge.io/Reading_and_Writing_in_files)  
    * FileSeek使用方式：同上  
    * FileClose使用方式：***FileClose 文件地址***  
例：  
~~~
FileOpen $4 "$DESKTOP\SomeFile.txt" w
FileWrite $4 "hello"
FileClose $4

FileOpen $4 "$DESKTOP\SomeFile.txt" a
FileSeek $4 0 END
FileWrite $4 "$\r$\n" ; we write a new line
FileWrite $4 "hello"
FileWrite $4 "$\r$\n" ; we write an extra line
FileClose $4 ; and close the file

FileOpen $4 "$DESKTOP\SomeFile.txt" r
FileSeek $4 1000 ; we want to start reading at the 1000th byte
FileRead $4 $1 ; we read until the end of line (including carriage return and new line) and save it to $1
FileRead $4 $2 10 ; read 10 characters from the next line
FileClose $4 ; and close the file
~~~  
* 宏指令说明：  
    * LOCALAPPDATA：获取计算机本地路径，一般为 ***C:\Users\用户名\AppData\Local*** ,会在运行时检查  
    * MUI_LANGDLL_ALLLANGUAGES：在语言选择对话框中，显示所有脚本支持的语言  
    * MUI_PAGE_WELCOME：欢迎界面  
    * MUI_PAGE_LICENSE：软件安装许可界面，使用方式：***!insertmacro MUI_PAGE_LICENSE "许可文件"***  
    * MUI_PAGE_COMPONENTS：组件选择界面  
    * MUI_PAGE_DIRECTORY：设置安装目录界面  
    * MUI_PAGE_INSTFILES：安装文件界面  
    * MUI_PAGE_FINISH：完成界面  
    * MUI_UNPAGE_CONFIRM：卸载确认界面  
    * MUI_UNPAGE_INSTFILES：卸载文件界面  
    * MUI_LANGUAGE：支持语言设置，使用方式：***!insertmacro MUI_LANGUAGE "语言名"*** v
    * INSTDIR：程序安装地址  
    * DESKTOP：桌面地址，运行时检查  
    * MUI_LANGDLL_DISPLAY：显示语言选择对话框  
    * MUI_HEADER_TEXT：标题文本设置，使用方式：***!insertmacro MUI_HEADER_TEXT "标题文本" "标题子文本"***  


# 自定义安装界面  
界面描述：需要可设置四个地址，且将设置好的地址按指定格式写入指定文件内  

* 绘制界面：添加自定义函数，界面使用nsDialogs插件  
~~~
Var Dialog
Var BrowseButton

Var Dir1
Var Dir2
Var Dir3
Var Dir4

; _State用于保存地址记录
Var Dir1_State
Var Dir2_State
Var Dir3_State
Var Dir4_State

Function Dirctions
  !insertmacro MUI_HEADER_TEXT "自定义安装界面" "请完成四个地址设置"

  nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

	${NSD_CreateLabel} 0 0 100% 12u "设置文件夹1路径:"
	Pop $0
	${NSD_CreateText} 0 13u 75% 12u $Dir1_State
	Pop $Dir1
	${NSD_CreateBrowseButton} 80% 13u 20% 12u "浏览..."
	Pop $BrowseButton
  ${NSD_OnClick} $BrowseButton SelectFolder1

	${NSD_CreateLabel} 0 26u 100% 12u "设置文件夹2路径:"
	Pop $0
	${NSD_CreateDirRequest} 0 39u 75% 12u $Dir2_State
	Pop $Dir2
	${NSD_CreateBrowseButton} 80% 39u 20% 12u "浏览..."
	Pop $BrowseButton
  ${NSD_OnClick} $BrowseButton SelectFolder2

	${NSD_CreateLabel} 0 52u 100% 12u "设置文件夹3路径:"
	Pop $0
	${NSD_CreateDirRequest} 0 65u 75% 12u $Dir3_State
	Pop $Dir3
	${NSD_CreateBrowseButton} 80% 65u 20% 12u "浏览..."
	Pop $BrowseButton
  ${NSD_OnClick} $BrowseButton SelectFolder3

	${NSD_CreateLabel} 0 78u 100% 12u "设置文件夹4路径:"
	Pop $0
	${NSD_CreateDirRequest} 0 91u 75% 12u $Dir4_State
	Pop $Dir4
	${NSD_CreateBrowseButton} 80% 91u 20% 12u "浏览..."
	Pop $BrowseButton
  ${NSD_OnClick} $BrowseButton SelectFolder4

	nsDialogs::Show
FunctionEnd
~~~  
* 添加点击按钮响应函数：四个按钮对应四个不同文本框  
~~~
Function SelectFolder1
  nsDialogs::SelectFolderDialog "选择文件夹" "$INSTDIR"
  Pop $0
  ${NSD_SetText} $Dir1 $0
FunctionEnd

Function SelectFolder2
  nsDialogs::SelectFolderDialog "选择文件夹" "$INSTDIR"
  Pop $0
  ${NSD_SetText} $Dir2 $0
FunctionEnd

Function SelectFolder3
  nsDialogs::SelectFolderDialog "选择文件夹" "$INSTDIR"
  Pop $0
  ${NSD_SetText} $Dir3 $0
FunctionEnd

Function SelectFolder4
  nsDialogs::SelectFolderDialog "选择文件夹" "$INSTDIR"
  Pop $0
  ${NSD_SetText} $Dir4 $0
FunctionEnd
~~~  
* 初始化四个文本框的值：使用.onInit内置回调  
~~~
Function .onInit
  StrCpy $Dir1_State "$INSTDIR" ;"$INSTDIR"可修改为指定地址
  StrCpy $Dir2_State "$INSTDIR"
  StrCpy $Dir3_State "$INSTDIR"
  StrCpy $Dir4_State "$INSTDIR"
FunctionEnd 
~~~  
* 写文件：使用覆盖或创建方式打开文件  
~~~
Function FileWrite
 FileOpen $4 "$INSTDIR\Path.csv" w
 FileWrite $4 "Path1,$Dir1_State,$\r$\n Path2,$Dir2_State,$\r$\nPath3,$Dir3_State,$\r$\n Path4,$Dir4_State"
 FileClose $4
FunctionEnd
~~~
* 离开自定义界面时保存设置记录并写文件：使用Leave内置回调  
~~~
Function DirctionsLeave
${NSD_GetText} $Dir1 $Dir1_State
${NSD_GetText} $Dir2 $Dir2_State
${NSD_GetText} $Dir3 $Dir3_State
${NSD_GetText} $Dir4 $Dir4_State

Call FileWrite ;调用写文件函数
FunctionEnd
~~~  
* 使用自定义界面：***Page custom 界面名称 界面名称Leave*** ， ***界面名称Leave*** 若不使用可删除。例：  
~~~
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  Page custom Dirctions DirctionsLeave
  !insertmacro MUI_PAGE_FINISH
~~~  






