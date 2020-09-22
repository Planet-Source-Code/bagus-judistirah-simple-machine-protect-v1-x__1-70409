Attribute VB_Name = "mdlFileFolder"
'---------------------------------------------------------------------------------------'
'                                                                                       '
' SIMPLE MACHINE PROTECT                                                                '
' Copyright (C) 2008 Bagus Judistirah                                                   '
'                                                                                       '
' This program is free software; you can redistribute it and/or modify                  '
' it under the terms of the GNU General Public License as published by                  '
' the Free Software Foundation; either version 2 of the License, or                     '
' (at your option) any later version.                                                   '
'                                                                                       '
' This program is distributed in the hope that it will be useful,                       '
' but WITHOUT ANY WARRANTY; without even the implied warranty of                        '
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                         '
' GNU General Public License for more details.                                          '
'                                                                                       '
' You should have received a copy of the GNU General Public License along               '
' with this program; if not, write to the Free Software Foundation, Inc.,               '
' 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.                           '
'                                                                                       '
'---------------------------------------------------------------------------------------'
'                                                                                       '
' Module     : Simple Machine Protect - Portable Edition                                '
' Author     : Bagus Judistirah (bagus_badboy)                                          '
' E-mail     : bagus.judistirah@hotmail.com or bagus_badboy@users.sourceforge.net       '
' Homepage   : http://wwww.e-freshware.com                                              '
'            : http://smp.e-freshware.com                                               '
' Project    : http://sourceforge.net/projects/smpav/                                   '
' License    : GNU General Public License                                               '
' History    : Minor bugs fixed.                                                        '
'                                                                                       '
'---------------------------------------------------------------------------------------'
'                                                                                       '
' Note       : I try to keep my software as bug-free as possible.                       '
'              But it's a general rule that no software ever is error free,             '
'              and the number of errors increases with the complexity of the program.   '
'                                                                                       '
'---------------------------------------------------------------------------------------'
'                                                                                       '
' Control    : Simple Machine Protect has been written and developed using Microsoft    '
'              Visual Basic 6. Portions of the source code of this program have been    '
'              taken from or inspired by the source of the following products. Please   '
'              do not remove these copyright notices. The following code & control was  '
'              used during the development of Simple Machine Protect.                   '
'              * Calculate CRC32 Checksum Precompiled Assembler Code, Get Icon          '
'                Coded by: Noel A Dacara                                                '
'                Downloaded from: http://www.planetsourcecode.com                       '
'              * XP Theme                                                               '
'                Coded by: Steve McMahon                                                '
'                Downloaded from: http://www.vbaccelerator.com                          '
'              * Chameleon Button                                                       '
'                Coded by: Gonchuki                                                     '
'                Downloaded from: http://www.planetsourcecode.com                       '
'              * Cool XP ProgressBar                                                    '
'                Coded by: Mario Flores                                                 '
'                Downloaded from: http://www.planetsourcecode.com                       '
'              * OnSystray                                                              '
'                Coded by: Bagus Judistirah                                             '
'                                                                                       '
'---------------------------------------------------------------------------------------'
'                                                                                       '
' Disclaimer : Modifying the registry can cause serious problems that may require you   '
'              to reinstall your operating system. I cannot guarantee that problems     '
'              resulting from modifications to the registry can be solved.              '
'              Use the information provided at your own risk.                           '
'                                                                                       '
'---------------------------------------------------------------------------------------'
' Thanks     : * SOURCEFORGE.NET [http://www.sourceforge.net]                           '
'              * OGNIZER [http://www.ognizer.net or http://virus.ognizer.net]           '
'              * VIROLOGI [http://www.virologi.info]                                    '
'              * ANSAV [http://www.ansav.com]                                           '
'              * VBACCELERATOR [http://www.vbaccelerator.com]                           '
'              * VBBEGO [http://www.vb-bego.com]                                        '
'              * MIGHTHOST [http://www.mighthost.com]                                   '
'              * UDARAMAYA [http://www.udaramaya.com]                                   '
'              * PSC - The home millions of lines of source code.                       '
'                [http://www.planetsourcecode.com]                                      '
'              * DONIXSOFTWARE - Dony Wahyu Isp [http://donixsoftware.web.id]           '
'              * Aat Shadewa, Jan Kristanto, Boby Ertanto, Irwan Halim, Dony Wahyu Isp, '
'                Yusuf Teretsa Patiku, Erwin, MI People, Nita, Husni, I Gede, Fadil,    '
'                Harry, Jimmy Wijaya, Sumanto Adi, Gafur, Selwin, Deny Kurniawan,       '
'                Paul, Marx, Gonchuki, Noel A Dacara, Steve McMahon, Mario Flores,      '
'                VM, Wardana, Achmad Darmal, Andi, Septian, all my friends,             '
'                Dream Theater, Evanescence, & Umild.                                   '
'              * Free software developer around the world.                              '
'              * Thanks to all for the suggestions and comments.                        '
'                                                                                       '
'---------------------------------------------------------------------------------------'
'                                                                                       '
' Contact    : If you have any questions, suggestions, bug reports or anything else,    '
'              feel free to contact me at bagus.judistirah@hotmail.com or               '
'              bagus_badboy@users.sourceforge.net.                                      '
'                                                                                       '
'---------------------------------------------------------------------------------------'

Option Explicit

Public Declare Sub Sleep Lib _
    "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function SHGetSpecialFolderLocation Lib _
    "shell32.dll" (ByVal hwndOwner As Long, _
    ByVal nFolder As Long, _
    pidl As ITEMIDLIST) As Long
Private Declare Function SHGetPathFromIDList Lib _
    "shell32" (ByVal pidList As Long, _
    ByVal lpBuffer As String) As Long
Private Declare Function GetWindowsDirectory Lib _
    "kernel32.dll" Alias "GetWindowsDirectoryA" ( _
    ByVal lpBuffer As String, _
    ByVal nSize As Long) As Long
Private Declare Function GetSystemDirectory Lib _
    "kernel32.dll" Alias "GetSystemDirectoryA" ( _
    ByVal lpBuffer As String, _
    ByVal nSize As Long) As Long
Private Declare Function SHRunDialog Lib _
    "shell32" Alias "#61" ( _
    ByVal hOwner As Long, _
    ByVal Unknown1 As Long, _
    ByVal Unknown2 As Long, _
    ByVal szTitle As String, _
    ByVal szPrompt As String, _
    ByVal uFlags As Long) As Long
Private Declare Function ShellExecuteEx Lib _
    "shell32" Alias "ShellExecuteExA" ( _
    SEI As SHELLEXECUTEINFO) As Long
Private Declare Function ShellExecute Lib _
    "shell32.dll" Alias "ShellExecuteA" ( _
    ByVal hwnd As Long, _
    ByVal lpOperation As String, _
    ByVal lpFile As String, _
    ByVal lpParameters As String, _
    ByVal lpDirectory As String, _
    ByVal nShowCmd As Long) As Long
Private Declare Function SHGetFileInfo Lib _
    "shell32.dll" Alias "SHGetFileInfoA" ( _
    ByVal pszPath As String, _
    ByVal dwFileAttributes As Long, _
    psfi As SHFILEINFO, _
    ByVal cbFileInfo As Long, _
    ByVal uFlags As Long) As Long
    
Private Type SHELLEXECUTEINFO
    cbSize As Long
    fMask As Long
    hwnd As Long
    lpVerb As String
    lpFile As String
    lpParameters As String
    lpDirectory As String
    nShow As Long
    hInstApp As Long
    lpIDList As Long
    lpClass As String
    hkeyClass As Long
    dwHotKey As Long
    hIcon As Long
    hProcess As Long
End Type

Private Type BrowseInfo
    lnghwnd As Long
    pIDLRoot As Long
    pszDisplayName As Long
    lpszTitle As Long
    ulFlags As Long
    lpfnCallback As Long
    lParam As Long
    iImage As Long
End Type

Private Type SHITEMID
    cb As Long
    abID As Byte
End Type

Private Type ITEMIDLIST
    mkid As SHITEMID
End Type

Public Enum SpecialFolder
    CSIDL_RECENT = &H8
    CSIDL_PROFILER = &H28
    CSIDL_HISTORY = &H22
End Enum

Private Const BIF_NEWDIALOGSTYLE As Long = &H40
Private Const BIF_EDITBOX As Long = &H10
Private Const MAX_PATH As Integer = 260
Private Const SEE_MASK_INVOKEIDLIST = &HC
Private Const SEE_MASK_NOCLOSEPROCESS = &H40
Private Const SEE_MASK_FLAG_NO_UI = &H400
Private Const OFN_OVERWRITEPROMPT = &H2
Private Const OFN_PATHMUSTEXIST = &H800
Private Const OFN_EXPLORER = &H80000
Private Const OFN_ENABLEHOOK = &H20
Private Const OFN_HIDEREADONLY = &H4
Private Const SHGFI_DISPLAYNAME As Long = &H200
Private Const SHGFI_TYPENAME As Long = &H400

Private Type SHFILEINFO
    hIcon As Long
    iIcon As Long
    dwAttributes As Long
    szDisplayName As String * MAX_PATH
    szTypeName As String * 80
End Type

Private Declare Sub CoTaskMemFree Lib _
    "ole32.dll" (ByVal hMem As Long)
Private Declare Function lstrcat Lib _
    "kernel32" Alias "lstrcatA" _
    (ByVal lpString1 As String, _
    ByVal lpString2 As String) As Long
Private Declare Function SHBrowseForFolder Lib _
    "shell32" (lpBI As BrowseInfo) As Long

Public Function BrowseForFolder(lnghwnd As Long, _
    strPrompt As String) As String
    On Error GoTo ehBrowseForFolder
    Dim intNull As Integer
    Dim lngIDList As Long, lngResult As Long
    Dim strPath As String
    Dim udtBI As BrowseInfo
    With udtBI
        .lnghwnd = lnghwnd
        .lpszTitle = lstrcat(strPrompt, "")
        .ulFlags = BIF_NEWDIALOGSTYLE + BIF_EDITBOX
    End With
    lngIDList = SHBrowseForFolder(udtBI)
    If lngIDList <> 0 Then
        strPath = String(MAX_PATH, 0)
        lngResult = SHGetPathFromIDList(lngIDList, _
            strPath)
        Call CoTaskMemFree(lngIDList)
        intNull = InStr(strPath, vbNullChar)
            If intNull > 0 Then
                strPath = Left(strPath, intNull - 1)
            End If
    End If
    BrowseForFolder = strPath
    Exit Function
ehBrowseForFolder:
    BrowseForFolder = Empty
End Function

Public Function GetSpecialFolder(FolderType As SpecialFolder) As String
    Dim r As Long, sPath As String
    Dim IDL As ITEMIDLIST
    r = SHGetSpecialFolderLocation(100, FolderType, IDL)
    sPath = Space$(512)
    r = SHGetPathFromIDList(ByVal IDL.mkid.cb, ByVal sPath)
    GetSpecialFolder = Left$(sPath, InStr(1, sPath, Chr$(0)) - 1)
End Function

Public Function GetWindowsPath() As String
    Dim lpBuffer As String * 255
    Dim nSize As Long
    nSize = GetWindowsDirectory(lpBuffer, 255)
    GetWindowsPath = Left(lpBuffer, nSize) & "\"
End Function

Public Function GetSystem32Path() As String
    Dim lpBuffer As String * 255
    Dim nSize As Long
    nSize = GetSystemDirectory(lpBuffer, 255)
    GetSystem32Path = Left(lpBuffer, nSize) & "\"
End Function

Public Function OpenInFolder(lvwItemExe As ListView, ItemId As Integer) As Double
    On Error Resume Next
    OpenInFolder = Shell("explorer.exe /select, " & _
        lvwItemExe.SelectedItem.SubItems(ItemId), vbNormalFocus)
End Function

Public Function OpenDosPrompt(lvwFilePath As ListView, _
    ItemExepath As Integer) As Long
    On Error Resume Next
    OpenDosPrompt = ShellExecute(1, vbNullString, "command.com", _
        vbNullString, GetFilePath(lvwFilePath.SelectedItem.SubItems(ItemExepath)), 1)
End Function

Public Function ShowRunApp(hwnd As Long) As Long
    On Error Resume Next
    ShowRunApp = SHRunDialog(hwnd, 0, 0, _
        StrConv("New Process", vbUnicode), _
        StrConv("Type the name of a program, folder, document, or Internet Resource," _
        & " and Windows will open it for you.", vbUnicode), 0)
End Function

Public Function OpenXPTool(hwnd As Long, lpOperation As String) As Long
    On Error Resume Next
    OpenXPTool = ShellExecute(hwnd, vbNullString, lpOperation, _
        vbNullString, Left(GetWindowsPath, 3), 1)
End Function

Public Function OnlineHelp(hwnd As Long, strSite As String) As Long
    On Error Resume Next
    OnlineHelp = ShellExecute(hwnd, vbNullString, _
        "http://" & strSite, vbNullString, Left(GetWindowsPath, 3), 1)
End Function

Public Function ShowFileProperties(hwndOwner As Long, _
    lvwFilePath As ListView, ItemExepath As Integer, _
    Optional lUseSubItem As Boolean = True) _
     As Long
    On Error Resume Next
    Dim SEI As SHELLEXECUTEINFO
    Dim slpFileName As String
    If lUseSubItem Then
        slpFileName = lvwFilePath.SelectedItem.SubItems(ItemExepath)
    Else
        slpFileName = lvwFilePath.SelectedItem
    End If
    With SEI
        .cbSize = Len(SEI)
        .fMask = SEE_MASK_NOCLOSEPROCESS Or _
            SEE_MASK_INVOKEIDLIST Or SEE_MASK_FLAG_NO_UI
        .hwnd = hwndOwner
        .lpVerb = "properties"
        .lpFile = slpFileName
        .lpParameters = vbNullChar
        .lpDirectory = vbNullChar
        .nShow = 0
        .hInstApp = 1
        .lpIDList = 0
    End With
    Call ShellExecuteEx(SEI)
End Function

Public Function GetFilePath(sPath As String) As String
    Dim i As Integer
    For i = Len(sPath) To 1 Step -1
        If Mid$(sPath, i, 1) = "\" Then
            GetFilePath = Mid$(sPath, 1, i)
            Exit For
        End If
    Next i
End Function

Public Function GetPathType(Path As String) As String
    Dim FileInfo As SHFILEINFO, lngRet As Long
    lngRet = SHGetFileInfo(Path, 0, FileInfo, _
        Len(FileInfo), SHGFI_DISPLAYNAME Or SHGFI_TYPENAME)
    If lngRet = 0 Then GetPathType = _
        Trim$(GetFileExtension(Path) & " File"): Exit Function
    GetPathType = Left$(FileInfo.szTypeName, _
        InStr(1, FileInfo.szTypeName, vbNullChar) - 1)
End Function

Public Function GetFileExtension(Path As String) As String
    Dim intRet As Integer: intRet = InStrRev(Path, ".")
    If intRet = 0 Then Exit Function
    GetFileExtension = UCase(Mid$(Path, intRet + 1))
End Function
