﻿"Filed out from Dolphin Smalltalk"!

Graphics.Gdiplus.CustomLineCap subclass: #'Graphics.Gdiplus.AdjustableArrowCap'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Graphics.Gdiplus.AdjustableArrowCap guid: (Core.GUID fromString: '{c1fcc800-8763-11d7-b609-00e0987e8081}')!
Graphics.Gdiplus.AdjustableArrowCap comment: 'GdiplusAdjustableArrowCap creates a line cap that looks like an arrow.'!
!Graphics.Gdiplus.AdjustableArrowCap categoriesForClass!Unclassified! !
!Graphics.Gdiplus.AdjustableArrowCap methodsFor!

height
	"Answer the height of the receiver's cap."

	| height |
	height := ByteArray newFixed: 4.
	Gdip gdipGetAdjustableArrowCapHeight: self asParameter height: height.
	^height floatAtOffset: 0!

height: aNumber
	"Set the height of the receiver's arrow cap."

	Gdip gdipSetAdjustableArrowCapHeight: self asParameter height: aNumber!

isFilled
	"Answer whether the receiver's cap is filled."

	| isFilled |
	isFilled := ByteArray newFixed: 4.
	Gdip gdipGetAdjustableArrowCapFillState: self asParameter fillState: isFilled.
	^(isFilled sdwordAtOffset: 0) ~~ 0!

isFilled: aBoolean
	"Set whether the receiver's arrow cap should be filled."

	Gdip gdipSetAdjustableArrowCapFillState: self asParameter fillState: aBoolean asParameter!

middleInset
	"Answer the middleInset of the receiver's cap."

	| middleInset |
	middleInset := ByteArray newFixed: 4.
	Gdip gdipGetAdjustableArrowCapMiddleInset: self asParameter middleInset: middleInset.
	^middleInset floatAtOffset: 0!

middleInset: aNumber
	"Set the middleInset of the receiver's arrow cap."

	Gdip gdipSetAdjustableArrowCapMiddleInset: self asParameter middleInset: aNumber!

width
	"Answer the width of the receiver's cap."

	| width |
	width := ByteArray newFixed: 4.
	Gdip gdipGetAdjustableArrowCapWidth: self asParameter width: width.
	^width floatAtOffset: 0!

width: aNumber
	"Set the width of the receiver's arrow cap."

	Gdip gdipSetAdjustableArrowCapWidth: self asParameter width: aNumber! !
!Graphics.Gdiplus.AdjustableArrowCap categoriesForMethods!
height!accessing!public! !
height:!accessing!public! !
isFilled!accessing!public! !
isFilled:!accessing!public! !
middleInset!accessing!public! !
middleInset:!accessing!public! !
width!accessing!public! !
width:!accessing!public! !
!

!Graphics.Gdiplus.AdjustableArrowCap class methodsFor!

exampleGdipAACArrowCap
	"This example displays several lines with arrow caps, showing the effects of changing aspects.

		self exampleGdipAACArrowCap showExample
	"

	| bitmap graphics arrowCap pen |
	bitmap := Bitmap extent: 350 @ 300.
	graphics := bitmap graphics.
	arrowCap := AdjustableArrowCap
				height: 10
				width: 5
				isFilled: false.
	pen := Pen red width: 2.
	pen customEndCap: arrowCap.
	graphics drawLine: (20 @ 20 extent: 250 @ 0) pen: pen.
	pen customStartCap: arrowCap.
	arrowCap isFilled: true.
	pen customEndCap: arrowCap.
	graphics drawLine: (20 @ 70 extent: 250 @ 0) pen: pen.
	pen customStartCap: arrowCap.
	arrowCap height: 20.
	pen customEndCap: arrowCap.
	graphics drawLine: (20 @ 120 extent: 250 @ 0) pen: pen.
	pen customStartCap: arrowCap.
	arrowCap width: 10.
	pen customEndCap: arrowCap.
	graphics drawLine: (20 @ 170 extent: 250 @ 0) pen: pen.
	pen customStartCap: arrowCap.
	arrowCap middleInset: 5.
	pen customEndCap: arrowCap.
	graphics drawLine: (20 @ 220 extent: 250 @ 0) pen: pen.
	pen customStartCap: arrowCap.
	pen customEndCap: CustomLineCap new.
	graphics drawLine: (20 @ 270 extent: 250 @ 0) pen: pen.
	^bitmap!

height: heightReal width: widthReal isFilled: isFilledBoolean
	^self fromInitializer: (AdjustableArrowCapInitializer
				height: heightReal
				width: widthReal
				isFilled: isFilledBoolean)!

strokePath: aStrokePath
	^self shouldNotImplement! !
!Graphics.Gdiplus.AdjustableArrowCap class categoriesForMethods!
exampleGdipAACArrowCap!examples!public!unit tests! !
height:width:isFilled:!instance creation!public! !
strokePath:!instance creation!public! !
!

