﻿"Filed out from Dolphin Smalltalk"!

Graphics.Gdiplus.Initializer subclass: #'Graphics.Gdiplus.BitmapFromIconInitializer'
	instanceVariableNames: 'icon'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Graphics.Gdiplus.BitmapFromIconInitializer guid: (Core.GUID fromString: '{c320278a-5152-4eda-8a58-6911de50cc40}')!
Graphics.Gdiplus.BitmapFromIconInitializer comment: ''!
!Graphics.Gdiplus.BitmapFromIconInitializer categoriesForClass!Unclassified! !
!Graphics.Gdiplus.BitmapFromIconInitializer methodsFor!

createHandle
	"Private -  Bitmap::FromHICON(
	    IN HICON hicon
	    )
	{
	    return new Bitmap(hicon);
	}"

	| gpHandle |
	gpHandle := Handle new.
	self library gdipCreateBitmapFromHICON: icon asParameter bitmap: gpHandle.
	^gpHandle!

icon: anIcon
	icon := anIcon! !
!Graphics.Gdiplus.BitmapFromIconInitializer categoriesForMethods!
createHandle!private!realizing/unrealizing! !
icon:!initializing!private! !
!

!Graphics.Gdiplus.BitmapFromIconInitializer class methodsFor!

icon: anIcon
	"Creates a Bitmap object based on an icon."

	^self new icon: anIcon! !
!Graphics.Gdiplus.BitmapFromIconInitializer class categoriesForMethods!
icon:!instance creation!public! !
!

