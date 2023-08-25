# AudioPlayer Library 

## Description
The `AudioPlayer` module is designed to handle audio playback functionality in your application. It provides methods for starting and controlling audio playback, as well as handling various events related to audio playback.

## Usage
To use the `AudioPlayer` module in your application, follow these steps:

1. **Initialization:** Initialize the `AudioPlayer` and set the audio file path using the `StartMusic` method.

    ```vbnet
    Public Sub StartMusic(call As Object, path As String)
        ' Initialize the AudioPlayer
        Private AudioPlayer As PuzzleTak_AudioPlayer
        Private callBack As Object
        callBack = call
        AudioPlayer.initialize("AudioPlayer")
        AudioPlayer.PathFile = path
        Log("StartMusic")
        
        ' Notify the caller about the audio byte data
        CallSub2(callBack, "onGetByteMusic", AudioPlayer.Byte)
        
        ' Check if an audio session is available
        If AudioPlayer.AudioSessionId <> -1 Then
            Log(AudioPlayer.AudioSessionId)
            
            ' Notify the caller about the audio session ID
            If IsPaused(callBack) == False Then CallSub2(callBack, "onGetAudioSession", AudioPlayer.AudioSessionId)
        End If
    End Sub
    ```

2. **Event Handlers:** The module includes various event handlers to monitor the audio playback status:

    - `AudioPlayer_onBufferingUpdate(buffer As Int)`: Handles buffering updates.
    - `AudioPlayer_onCompletion()`: Handles audio playback completion.
    - `AudioPlayer_onError()`: Handles audio playback errors.
    - `AudioPlayer_onInfo(p0 As Int, p1 As Int)`: Handles audio playback information updates.
    - `AudioPlayer_onPrepared()`: Handles audio player preparation.
    - `AudioPlayer_onSeekComplete()`: Handles seek operations completion.

    Customize these event handlers as needed for your application.

### Handling Audio Data and Audio Session

The `AudioPlayer` module provides two important callback methods for handling audio data and audio session information.

#### `onGetByteMusic(bytes() As Byte)`
- **Description:** This callback is triggered to provide the raw audio bytes to the `SymmetricWaveVisualizer` component for visualization or processing. It takes an array of bytes as a parameter, which represents the audio data.
- **Parameters:**
  - `bytes() As Byte`: An array of bytes containing audio data.
- **Usage Example:**
  ```vbnet
  Private Sub onGetByteMusic(bytes() As Byte)
      SymmetricWaveVisualizer.RawAudioBytes = bytes
  End Sub
```vbnet
Private Sub onGetAudioSession(sessionId As Int)
    SymmetricWaveVisualizer.AudioSessionId = sessionId
End Sub


## Example
Here's an example of how to use the `StartMusic` method to start audio playback:

```vbnet
Sub StartAudioPlayback()
	Dim sm As StoryMusic
	sm.Initialize(Me,"sm","dadadada","https://site.com/cover.png","https://site.com/file.mp3")
	Activity.AddView(sm.AsView,0,0,Activity.Width,Activity.Height)
	sm.initState
End Sub
