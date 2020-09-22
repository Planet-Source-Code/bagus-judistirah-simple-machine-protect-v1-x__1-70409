Attribute VB_Name = "mdlMain"
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

'Code by Steve McMahon http://www.vbaccelerator.com
Option Explicit

Private Type tagInitCommonControlsEx
   lngSize As Long
   lngICC As Long
End Type

Public Declare Function InitCommonControls Lib _
    "comctl32.dll" () As Long
Private Declare Function InitCommonControlsEx Lib _
    "comctl32.dll" (iccex As tagInitCommonControlsEx) As Boolean

Private Const ICC_USEREX_CLASSES = &H200

Sub Main()
    'If Year(Now) < 2008 Then
    '    MsgBox "Cannot open application: System Time is not valid.", _
    '        vbCritical + vbSystemModal, "Error Opening Application"
    '    End
    'End If
    Dim iccex As tagInitCommonControlsEx
    With iccex
        .lngSize = LenB(iccex)
        .lngICC = ICC_USEREX_CLASSES
    End With
    InitCommonControlsEx iccex
    On Error GoTo 0
    App.TaskVisible = False
    App.Title = GenerateRandomTitle(True)
    frmLoading.Show
End Sub

'Private Sub Register_Ext()
'    CreateRegistryKey HKEY_CLASSES_ROOT, "evdfile"
'    CreateRegistryKey HKEY_CLASSES_ROOT, "evdfile\DefaultIcon"
'    CreateStringValue HKEY_CLASSES_ROOT, "evdfile", "", _
'        "External Virus Database"
'    CreateStringValue HKEY_CLASSES_ROOT, "evdfile\DefaultIcon", "", _
'        "%SystemRoot%\System32\shell32.dll,-154"
'    CreateRegistryKey HKEY_CLASSES_ROOT, ".evd"
'    CreateStringValue HKEY_CLASSES_ROOT, ".evd", "", "evdfile"
'End Sub

'Sub SaveAppSettings()
'    Dim lReg As Long
'    With frmMain
'        ' Register Application
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "Register", 1
'        Register_Ext
'        ' Save File Extensions
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "UseExtensionList", _
'            Abs(CLng(.optExt.Value))
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "Extension", _
'            CLng(.cboExt.ListIndex)
'        ' Save Scan Options
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "FixErrorRegistry", _
'            CLng(.chkFixReg.Value)
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "RepairData", _
'            CLng(.chkRep.Value)
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "HiddenRecovery", _
'            CLng(.chkHidden.Value)
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "ScanMemory", _
'            CLng(.chkScanMem.Value)
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "WarningSound", _
'            CLng(.chkSound.Value)
'        ' Save Window Settings
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "AlwaysOnTop", _
'            CLng(.chkOnTop.Value)
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "Transparency", _
'            CLng(.chkTrans.Value)
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "HideWindowTitle", _
'            CLng(.chkHideTitle.Value)
'        ' Save Reporting Service
'        If .optReport.Value = True Then
'            lReg = 1
'        ElseIf .optFullReport.Value = True Then
'            lReg = 2
'        Else
'            lReg = 0
'        End If
'        CreateDwordValue HKEY_CURRENT_USER, SMP_KEY, "ReportingService", lReg
'    End With
'End Sub

'Sub LoadAppSettings()
'    Dim lReg As Long
'    With frmMain
'        ' Load File Extensions
'        lReg = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "UseExtensionList")
'        If lReg = 1 Then
'            .optAllFiles.Value = False
'            .optExt.Value = True
'            .cboExt.Enabled = True
'        Else
'            .optAllFiles.Value = True
'            .optExt.Value = False
'            .cboExt.Enabled = False
'        End If
'        .cboExt.ListIndex = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "Extension")
'        ' Load Scan Options
'        .chkFixReg.Value = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "FixErrorRegistry")
'        .chkRep.Value = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "RepairData")
'        .chkHidden.Value = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "HiddenRecovery")
'        .chkScanMem.Value = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "ScanMemory")
'        .chkSound.Value = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "WarningSound")
'        ' Load Window Settings
'        .chkTrans.Value = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "AlwaysOnTop")
'        .chkHideTitle.Value = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "Transparency")
'        .chkOnTop.Value = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "HideWindowTitle")
'        ' Load Reporting Service
'        lReg = GetDWORDValue(HKEY_CURRENT_USER, SMP_KEY, "ReportingService")
'        If lReg = 1 Then
'            .optReport.Value = True
'        ElseIf lReg = 2 Then
'            .optFullReport.Value = True
'        Else
'            .optOffReport.Value = True
'        End If
'    End With
'End Sub

'Sub DefaultAppSettings()
'    With frmMain
'        .optAllFiles.Value = True
'        .cboExt.ListIndex = 4
'        .chkRep.Value = vbChecked
'        .chkScanMem.Value = vbChecked
'        .chkSound.Value = vbChecked
'        .chkOnTop.Value = vbChecked
'        .chkHideTitle.Value = vbChecked
'        .optReport.Value = True
'    End With
'End Sub
