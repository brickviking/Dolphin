﻿"Filed out from Dolphin Smalltalk"!

Graphics.Gdiplus.GdiplusBase subclass: #'Graphics.Gdiplus.CustomLineCap'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Graphics.Gdiplus.CustomLineCap guid: (Core.GUID fromString: '{ea986b35-8426-11d7-b609-00e0987e8081}')!
Graphics.Gdiplus.CustomLineCap comment: 'GdiplusCustomLineCap defines the style of graphic used to draw the ends of a line. It can be various shapes, such as a square, circle, or diamond and is defined by the path that draws it. The path is drawn by using a Pen object to draw the outline of a shape or by using a Brush object to fill the interior. The cap can be used on either or both ends of the line. Spacing can be adjusted between the end caps and the line.

'!
!Graphics.Gdiplus.CustomLineCap categoriesForClass!Unclassified! !
!Graphics.Gdiplus.CustomLineCap methodsFor!

baseCap
	"Answer a LineCap integer that represents the style of the base cap used at the end of a line."

	| linecap |
	linecap := ByteArray newFixed: 4.
	Gdip gdipGetCustomLineCapBaseCap: self asParameter baseCap: linecap.
	^linecap sdwordAtOffset: 0!

baseCap: aLineCapConstant
	"Set the style of the base cap used at the end of a line to that represented by aLineCapConstant."

	Gdip gdipSetCustomLineCapBaseCap: self asParameter baseCap: aLineCapConstant!

baseInset
	"Answer the distance between the base cap to the start of the line."

	| baseInset |
	baseInset := ByteArray newFixed: 4.
	Gdip gdipGetCustomLineCapBaseInset: self asParameter inset: baseInset.
	^baseInset floatAtOffset: 0!

baseInset: aNumber
	"Set the distance between the base cap to the start of the line."

	Gdip gdipSetCustomLineCapBaseInset: self asParameter inset: aNumber!

basicFree
	"Private - Free up external resources held by the receiver.  Ignore any errors which might arise."

	Gdip gdipDeleteCustomLineCap: handle!

clone
	"Answer a copy of the receiver."

	| gpHandle |
	gpHandle := Handle new.
	Gdip gdipCloneCustomLineCap: self handle clonedCap: gpHandle.
	^(self class fromOwnedHandle: gpHandle)
		initializer: initializer;
		yourself!

endCap
	"Answer the style of the stroke cap used at the end of lines."

	^self strokeCaps at: 2!

startCap
	"Answer the style of the stroke cap used at the start of lines."

	^self strokeCaps at: 1!

startCap: startLineCapConstant endCap: endLineCapConstant
	"Set the style of the stroke cap used at the start and ends of lines."

	Gdip
		gdipSetCustomLineCapStrokeCaps: self asParameter
		startCap: startLineCapConstant
		endCap: endLineCapConstant!

strokeCaps
	"Private - Answer a 2-element integer array that contains the styles of the start and ending stroke caps."

	| buf |
	buf := ByteArray newFixed: 8.
	Gdip
		gdipGetCustomLineCapStrokeCaps: self asParameter
		startCap: buf
		endCap: buf yourAddress + 4.
	^{buf sdwordAtOffset: 0. buf sdwordAtOffset: 4}!

strokeJoin
	"Answer the style of line join (how intersecting lines are joined) for the stroke."

	| lineJoin |
	lineJoin := ByteArray newFixed: 4.
	Gdip gdipGetCustomLineCapStrokeJoin: self asParameter lineJoin: lineJoin.
	^lineJoin sdwordAtOffset: 0!

strokeJoin: aLineJoinConstant
	"Set the style of line join (how intersecting lines are joined) for the stroke."

	Gdip gdipSetCustomLineCapStrokeJoin: self asParameter lineJoin: aLineJoinConstant!

widthScale
	"Answer the amount to scale the receiver relative to the width of the GdiplusPen used to draw lines."

	| widthScale |
	widthScale := ByteArray newFixed: 4.
	Gdip gdipGetCustomLineCapWidthScale: self asParameter widthScale: widthScale.
	^widthScale floatAtOffset: 0!

widthScale: aNumber
	"Set the amount to scale the receiver relative to the width of the GdiplusPen used to 
	draw lines. The default value of 1.0 does not scale the line cap."

	Gdip gdipSetCustomLineCapWidthScale: self asParameter widthScale: aNumber! !
!Graphics.Gdiplus.CustomLineCap categoriesForMethods!
baseCap!accessing!public! !
baseCap:!accessing!public! !
baseInset!accessing!public! !
baseInset:!accessing!public! !
basicFree!private!realizing/unrealizing! !
clone!copying!public! !
endCap!accessing!public! !
startCap!accessing!public! !
startCap:endCap:!accessing!public! !
strokeCaps!accessing!private! !
strokeJoin!accessing!public! !
strokeJoin:!accessing!public! !
widthScale!accessing!public! !
widthScale:!accessing!public! !
!

!Graphics.Gdiplus.CustomLineCap class methodsFor!

exampleGdipCLCStrokeCaps
	"This example creates a GdiplusCustomLineCap object , sets its stroke cap, and then 
	assigns the custom cap's stroke cap as the end cap of a GdiplusPen.  The pen draws a
	diagonal line.

		self exampleGdipCLCStrokeCaps showExample
	"

	| bitmap graphics path customCap pen rect |
	bitmap := Bitmap extent: 450 @ 300.
	graphics := bitmap graphics.
	path := Path new addLines: {-15 @ -15. 0 @ 0. 15 @ -15}.
	customCap := CustomLineCap strokePath: path.
	customCap startCap: LineCapTriangle endCap: LineCapRound.
	pen := Pen red width: 5.5.
	pen customEndCap: customCap.
	rect := 50 @ 50 extent: 300 @ 100.
	graphics
		drawLine: rect pen: pen;
		drawRectangle: rect pen: Pen black.
	^bitmap!

fillPath: aFillPath strokePath: aStrokePath baseCap: aBaseCap baseInset: aBaseInset
	^self fromInitializer: (CustomLineCapInitializer
				fillPath: aFillPath
				strokePath: aStrokePath
				baseCap: aBaseCap
				baseInset: aBaseInset)!

new
	^self strokePath: Path new!

strokePath: aStrokePath 
	^self 
		fillPath: nil
		strokePath: aStrokePath
		baseCap: LineCapFlat
		baseInset: 0! !
!Graphics.Gdiplus.CustomLineCap class categoriesForMethods!
exampleGdipCLCStrokeCaps!examples!public!unit tests! !
fillPath:strokePath:baseCap:baseInset:!instance creation!public! !
new!instance creation!public! !
strokePath:!instance creation!public! !
!

