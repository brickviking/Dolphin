﻿"Filed out from Dolphin Smalltalk"!

Graphics.Gdiplus.GdiplusBase subclass: #'Graphics.Gdiplus.FontFamily'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Graphics.Gdiplus.FontFamily guid: (Core.GUID fromString: '{c09d8c08-5f28-11d7-b609-00e0987e8081}')!
Graphics.Gdiplus.FontFamily comment: 'GdiplusFontFamily represents a set of fonts that make up a font family. A font family is a group of fonts that have the same typeface but different styles.

'!
!Graphics.Gdiplus.FontFamily categoriesForClass!Unclassified! !
!Graphics.Gdiplus.FontFamily methodsFor!

basicFree
	"Private - Free up external resources held by the receiver.  Ignore any errors which might arise."

	Gdip gdipDeleteFontFamily: handle!

clone
	"Answer a copy of the receiver."

	| gpHandle |
	gpHandle := Handle new.
	Gdip gdipCloneFontFamily: self asParameter clonedFontFamily: gpHandle.
	^(self class fromOwnedHandle: gpHandle)
		initializer: initializer;
		yourself!

getName: anInteger
	| name |
	name := Utf16String newFixed: LF_FACESIZE.
	Gdip
		gdipGetFamilyName: self asParameter
		name: name
		language: anInteger.
	^name asString trimNulls!

lineSpacing
	"Answer the vertical distance between the base lines of two consecutive lines of text."

	| lineSpacing |
	lineSpacing := ByteArray newFixed: 2.
	Gdip
		gdipGetLineSpacing: self asParameter
		style: 0
		lineSpacing: lineSpacing.
	^lineSpacing wordAtOffset: 0!

name
	"Answer the String name of the receiver (e.g., 'Arial')."

	^self getName: Locale userDefault languageId! !
!Graphics.Gdiplus.FontFamily categoriesForMethods!
basicFree!private!realizing/unrealizing! !
clone!copying!public! !
getName:!helpers!private! !
lineSpacing!accessing!public! !
name!accessing!public! !
!

!Graphics.Gdiplus.FontFamily class methodsFor!

exampleGdipFFClone
	"MSDN: FontFamily::Clone
	This example creates a GdiplusFontFamily, clones it, then creates a GdiplusFont from the clone.

		self exampleGdipFFClone showExample
	"

	| bitmap fontFamily cloneFontFamily font |
	bitmap := Bitmap extent: 250 @ 100.
	fontFamily := FontFamily fromName: 'arial'.
	cloneFontFamily := fontFamily clone.
	font := Font fontFamily: cloneFontFamily pointSize: 16.
	bitmap graphics
		drawString: ('This is an <1s> font' expandMacrosWith: font name)
		font: font
		at: 10 @ 10
		format: nil
		brush: nil.
	^bitmap!

fromName: aString
	^self fromName: aString fontCollection: nil!

fromName: aString fontCollection: aFontCollection
	^self fromInitializer: (FontFamilyInitializer name: aString fontCollection: aFontCollection)!

genericSansSerif
	^self fromInitializer: FontFamilyInitializer genericSansSerif!

genericSerif
	^self fromInitializer: FontFamilyInitializer genericSerif!

icon
	"Answers an Icon that can be used to represent this class"

	^Graphics.Font icon! !
!Graphics.Gdiplus.FontFamily class categoriesForMethods!
exampleGdipFFClone!examples!public!sunit! !
fromName:!instance creation!public! !
fromName:fontCollection:!instance creation!public! !
genericSansSerif!instance creation!public! !
genericSerif!instance creation!public! !
icon!constants!development!public! !
!

