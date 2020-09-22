VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmChecksum 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Get Checksum"
   ClientHeight    =   1230
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5835
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmChecksum.frx":0000
   LinkTopic       =   "frmChecksum"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   1230
   ScaleWidth      =   5835
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtSTRING 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1080
      Locked          =   -1  'True
      TabIndex        =   5
      Top             =   840
      Width           =   1695
   End
   Begin VB.TextBox txtCRC32 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1080
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   480
      Width           =   1695
   End
   Begin VB.CommandButton cmdOpen 
      Caption         =   "..."
      Height          =   255
      Left            =   5160
      TabIndex        =   1
      Top             =   120
      Width           =   615
   End
   Begin VB.TextBox txtLocation 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   0
      Top             =   120
      Width           =   4935
   End
   Begin MSComDlg.CommonDialog cdlOpen 
      Left            =   600
      Top             =   4080
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Label lblEmpty 
      AutoSize        =   -1  'True
      Caption         =   "Drag && Drop file here!"
      Height          =   195
      Index           =   2
      Left            =   4080
      TabIndex        =   6
      Top             =   840
      Width           =   1575
   End
   Begin VB.Label lblEmpty 
      Caption         =   "STRING:"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   3
      Top             =   840
      Width           =   735
   End
   Begin VB.Label lblEmpty 
      Caption         =   "CRC32:"
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   735
   End
End
Attribute VB_Name = "frmChecksum"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOpen_Click()
    Dim fName As String
    cdlOpen.ShowOpen
    fName = cdlOpen.FileName
    txtLocation.Text = fName
End Sub

Private Sub Form_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim fName As Variant
    For Each fName In Data.Files
        txtLocation.Text = CStr(fName)
    Next
End Sub

Private Sub txtLocation_Change()
    txtCRC32.Text = GetFullCRC(txtLocation.Text)
    txtSTRING.Text = GetChecksum(txtLocation.Text)
End Sub
