B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=12.2
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
  Private callBack As Object
	Private AudioPlayer As PuzzleTak_AudioPlayer
End Sub

Sub Service_Create

End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy

End Sub
Public Sub StartMusic(call As Object,path As String)
	callBack  =call
	AudioPlayer.initialize("AudioPlayer")
	AudioPlayer.PathFile = path
	Log("StartMusic")
	CallSub2(callBack,"onGetByteMusic",AudioPlayer.Byte)
	If AudioPlayer.AudioSessionId <> -1 Then
		Log(AudioPlayer.AudioSessionId)
		If IsPaused(callBack) == False Then CallSub2(callBack,"onGetAudioSession",AudioPlayer.AudioSessionId)
	End If
End Sub


Private Sub AudioPlayer_onBufferingUpdate(buffer As Int)
	Log("buffer :::: "&buffer)
End Sub
Private Sub AudioPlayer_onCompletion()
	Log("AudioPlayer_onCompletion")
End Sub
Private Sub AudioPlayer_onError()
	Log("AudioPlayer_onError")
End Sub
Private Sub AudioPlayer_onInfo(p0 As Int ,p1 As Int)
	Log("AudioPlayer_onInfo : p0 = "&p0&" p1 = "&p1)
End Sub
Private Sub AudioPlayer_onPrepared()
	Log("AudioPlayer_onPrepared")
End Sub
Private Sub AudioPlayer_onSeekComplete()
	Log("AudioPlayer_onSeekComplete")
	
End Sub
