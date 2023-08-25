B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
#Event : onErrorStoryMusic
#Event : onCompleteStorymusic
Sub Class_Globals
	Private Canvas As Panel
	Private callBAck As Object
	Private EvantName As String
	

'	Private blur As PT_Blurry

	Private SymmetricWaveVisualizer As PuzzleTak_SymmetricWaveVisualizer
	' donloader
	Private id_name_music As String = "name_c"
	Private id_name_image As String = "name_c"
	Dim imageUrl As String
	Dim musicUrl As String
	Dim userid As String
End Sub

Public Sub Initialize(call As Object,ev As String,username As String, cover As String,music As String)
	callBAck  =call
	EvantName = ev
	Canvas.Initialize("Canvas")
	Canvas.Color = 0xFF313131
	SymmetricWaveVisualizer.Initialize("SymmetricWaveVisualizer")
	imageUrl = cover
	musicUrl = music
	Dim util As UtilsAudio
	id_name_music = util.getFileNameFromUrl(music)
	id_name_image = util.getFileNameFromUrl(cover)
	Log(id_name_music)
	Log(id_name_image)

End Sub


Public Sub AsView As Panel
	Return Canvas
End Sub

Public Sub initState
	initDownloader

End Sub




Private Sub initDownloader
	Dim pd As Panel
	pd.Initialize("")
	Canvas.AddView(pd,0,0,Canvas.Width,Canvas.Height)

	
	Dim title As Label
	title.Initialize("title")
	title.Text = "درحال دانلود"
	title.Gravity = Bit.Or(Gravity.CENTER_HORIZONTAL,Gravity.TOP)
	title.SingleLine  =True
	title.TextColor = Colors.White
	title.TextSize = 12
	title.Enabled = False
	title.Color = Colors.Transparent
	pd.AddView(title,0,pd.Height / 2 -9%x,pd.Width,6%x)
	
	Dim progressbar As ProgressBar
	progressbar.Initialize("progressbar")
	progressbar.Indeterminate = False
	progressbar.Progress = 0
	pd.AddView(progressbar,20%x,pd.Height / 2 - 1.5%x,pd.Width - 40%x,3%x)
	
	If File.Exists(File.DirInternal,id_name_image) == False Then
		Dim downloader_cover As Amir_Retrofit
		downloader_cover.Initialize3
		downloader_cover.Download("downloader_cover",imageUrl)
	Else
		If File.Exists(File.DirInternal,id_name_music) == False Then
			Dim downloader As Amir_Retrofit
			downloader.Initialize3
			downloader.Download("downloader",musicUrl)
		Else
'			Utils.Animation
			Canvas.GetView(0).RemoveView
			initStory
		End If
	End If
	

	
	
	
	
End Sub
Private Sub title_click
	Canvas.RemoveViewAt(0)
	initDownloader
End Sub
Private Sub downloader_onSucess (key As String,path As String,Name As String,FileSize As Long)
	File.Copy(path,Name,File.DirInternal,id_name_music)
	If Canvas.GetView(0).As(Panel).GetView(0).As(Label).IsInitialized Then
		Canvas.GetView(0).As(Panel).GetView(0).As(Label).Text = "دانلود با موفقیت انجام شد"
		Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).SetVisibleAnimated(100,False)
	End If
'	Utils.Animation
	Canvas.GetView(0).RemoveView
	initStory
End Sub
Private Sub downloader_onError (Error As String,Code As Int)
	If Canvas.GetView(0).As(Panel).GetView(0).As(Label).IsInitialized Then
		Canvas.GetView(0).As(Panel).GetView(0).As(Label).Text = "خطا در دانلود استوری برای دانلود مجدد کلیک کنید"
		Canvas.GetView(0).As(Panel).GetView(0).As(Label).Enabled = True
		Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).SetVisibleAnimated(100,False)
	End If
End Sub
Private Sub downloader_onProgress (key As String,progress As Int,downloadedsize As Long,totalsize As Long)
	If Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).IsInitialized Then
		Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).Progress = progress
	End If
End Sub

Private Sub downloader_cover_onSucess (key As String,path As String,Name As String,FileSize As Long)
	File.Copy(path,Name,File.DirInternal,id_name_image)
	Try
		If Canvas.GetView(0).As(Panel).GetView(0).As(Label).IsInitialized Then
			Canvas.GetView(0).As(Panel).GetView(0).As(Label).Text = "دانلود کاور انجام شد"
			Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).SetVisibleAnimated(100,False)
		End If
		Sleep(150)
		If Canvas.GetView(0).As(Panel).GetView(0).As(Label).IsInitialized Then
			Canvas.GetView(0).As(Panel).GetView(0).As(Label).Text ="درحال دانلود"
			Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).Progress = 0
			Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).SetVisibleAnimated(100,True)
		End If
		If File.Exists(File.DirInternal,id_name_music) == False Then
			Dim downloader As Amir_Retrofit
			downloader.Initialize3
			downloader.Download("downloader",musicUrl)
		Else
'			Utils.Animation
			Canvas.GetView(0).RemoveView
			initStory
		End If
	Catch
		Log(LastException)
	End Try
End Sub
Private Sub downloader_cover_onError (Error As String,Code As Int)
	If Canvas.GetView(0).As(Panel).GetView(0).As(Label).IsInitialized Then
		Canvas.GetView(0).As(Panel).GetView(0).As(Label).Text = "خطا در دانلود استوری برای دانلود مجدد کلیک کنید"
		Canvas.GetView(0).As(Panel).GetView(0).As(Label).Enabled = True
		Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).SetVisibleAnimated(100,False)
	End If
End Sub
Private Sub downloader_cover_onProgress (key As String,progress As Int,downloadedsize As Long,totalsize As Long)
	If Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).IsInitialized Then
		Canvas.GetView(0).As(Panel).GetView(1).As(ProgressBar).Progress = progress
	End If
End Sub




Private Sub initStory
	Dim picName  As String = id_name_image
	Dim musicName  As String = id_name_music
	Dim ps As Panel
	ps.Initialize("")
	ps.Color = Colors.Gray
	Canvas.AddView(ps,0,0,Canvas.Width,Canvas.Height)
	
	Dim imageCoverBlur As Hitex_ImageView
'	Dim pt As PT_Blurry
	imageCoverBlur.Initialize("")
	
	imageCoverBlur.Gravity  =Gravity.FILL
	ps.AddView(imageCoverBlur,0,0,ps.Width,ps.Height)
	Dim glide As Hitex_Glide
	Dim util As UtilsAudio
	Dim b As Bitmap = util.BlurImage(LoadBitmap(File.DirInternal,picName),15,6)
	glide.With.Load3(b).Apply(glide.RequestOptions.CenterCrop).Into(imageCoverBlur)
	
	
		
	Dim w As Int = PerXToCurrent(70)
	Dim h As Int = b.Height*PerXToCurrent(70)/b.Width
	Dim l As Int = ((ps.Width / 2) - (w / 2))
	Dim t As Int = ((ps.Height / 2) - (h / 2))

	Dim PanelImage As Panel
	PanelImage.Initialize("PanelImage")
'	PanelImage.Background = Utils.Background(Colors.White,5)
	PanelImage.Elevation = 5dip
	ps.AddView(PanelImage,l,t,w,h)
	Dim image As Hitex_ImageView
	image.Initialize("")
	PanelImage.AddView(image,0,0,PanelImage.Width,PanelImage.Height)
	SetClipToOutline(PanelImage)
	glide.With.Load3(LoadBitmap(File.DirInternal,picName)).Apply(glide.RequestOptions.FitCenter).Into(image)
	

	'	pv.ColorWaveBar = 0xFFA808DA
	SymmetricWaveVisualizer.LevelBar = SymmetricWaveVisualizer.LEVEL_ALPHA
	SymmetricWaveVisualizer.AlphaBar = 100
	SymmetricWaveVisualizer.WidthLine =600.0f
	Dim palette As PaletteBuilder
	palette.Initialize("palette",LoadBitmap(File.DirInternal,picName))
	palette.MaximumColorCount = 24
	palette.GenerateAsync

	

	Sleep(600)

	
	CallSubDelayed3(ServiceMusic,"StartMusic",Me,File.Combine(File.DirInternal,musicName))
	
'	ps.Color = pt.getDominantColor2(LoadBitmap(File.DirInternal,picName))
	

'	AudioPlayer.start

	
	
	
	
	
End Sub
Private Sub palette_Generated (Palette As Palette)
	Log("colors")
	Dim lc As List
	lc.Initialize
	lc.Clear
	
	Dim lc2 As List
	lc2.Initialize
	lc2.Clear
'	lc.Add(Palette.GetDominantColor(0xFF355599))
'	lc.Add(Palette.GetMutedColor(0xFF355599))
'	lc.Add(Palette.GetLightMutedColor(0xFF355599))
'	lc.Add(Palette.GetDarkMutedColor(0xFF355599))
'	lc.Add(Palette.GetLightVibrantColor(0xFF355599))
'	lc.Add(Palette.GetVibrantColor(0xFF355599))
'	lc.Add(Palette.GetDarkVibrantColor(0xFF355599))
'	Log(Palette.GetAllSwatches.Size - 1)
	For i = 0 To Palette.GetAllSwatches.Size - 1
		Dim sw As Swatch
		sw = Palette.GetAllSwatches.Get(i)
	Try
			If SymmetricWaveVisualizer.isColorDark(sw.RGB,200,250) Then
				lc2.Add(sw.RGB)
			End If
	Catch
		Log(LastException)
	End Try
	Try
			If SymmetricWaveVisualizer.isColorDark(sw.RGB,40,90) Then
				lc.Add(sw.RGB)
			End If
	Catch
		Log(LastException)
	End Try

	Next
	SymmetricWaveVisualizer.ColorList = lc
	Dim shadow As ImageView
	shadow.Initialize("")
	
	
	Canvas.GetView(0).As(Panel).AddView(SymmetricWaveVisualizer,0,0,Canvas.GetView(0).As(Panel).Width,Canvas.GetView(0).As(Panel).Height)
	Canvas.GetView(0).As(Panel).GetView(1).As(Panel).AddView(shadow,0,0,Canvas.GetView(0).As(Panel).GetView(1).As(Panel).Width,Canvas.GetView(0).As(Panel).GetView(1).As(Panel).Height)
	SymmetricWaveVisualizer.setViewAlpha(shadow,0.3f)
	If(lc2.Size >= 2) Then SymmetricWaveVisualizer.createSmoothGradientAnimation(shadow,lc2,5000)
End Sub
Private Sub onGetByteMusic(bytes() As Byte)
	SymmetricWaveVisualizer.RawAudioBytes = bytes
End Sub
Private Sub onGetAudioSession(sectionId As Int)
	Log("sectionId : "&sectionId)
	SymmetricWaveVisualizer.AudioSessionId = sectionId
End Sub
Public Sub SetClipToOutline (Panel As Panel)
	Dim jo As JavaObject = Panel
	jo.RunMethod("setClipToOutline", Array(True))
End Sub

