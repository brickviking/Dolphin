﻿"Filed out from Dolphin Smalltalk"!

Graphics.Image subclass: #'Graphics.Metafile'
	instanceVariableNames: 'header'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Graphics.Metafile guid: (Core.GUID fromString: '{9afeffe3-f782-4d07-ad88-4aab4659091e}')!
Graphics.Metafile comment: 'Metafile is the class of <Image>s that represent Windows'' Enhanced Metafiles.

Instance Variables:
	header	<ENHMETAHEADER>. Header data for the metafile.
'!
!Graphics.Metafile categoriesForClass!Graphics-Tools! !
!Graphics.Metafile methodsFor!

addToImageList: anImageList mask: aColorOrNil
	"Private - Add a pictorial representation of the receiver to anImageList"

	| extent bmp |
	extent := anImageList extent.
	bmp := Bitmap
				width: extent x
				height: extent y
				depth: ImageList defaultColorDepth.
	self
		drawOn: bmp canvas
		at: 0 @ 0
		extent: extent.
	bmp addToImageList: anImageList mask: aColorOrNil.
	bmp free!

basicFree
	Gdi32 deleteEnhMetaFile: handle!

clearCached
	header := nil.
	^super clearCached!

copyHandle
	^Gdi32 copyEnhMetaFile: self asParameter lpszFile: nil!

description
	"Return the description string associated with the receiver, if any."

	| count strings |
	count := Gdi32
				getEnhMetaFileDescription: self asParameter
				cchBuffer: 0
				lpszDescription: nil.
	strings := Utf16String newFixed: count.
	Gdi32
		getEnhMetaFileDescription: self asParameter
		cchBuffer: count
		lpszDescription: strings.
	^$\0 split: strings!

drawDisabledOn: aCanvas at: aPoint extent: sizePoint 
	"Draw a disabled/grayed representation of the receiver on aCanvas at aPoint with extent sizePoint."

	^self shouldNotImplement!

drawOn: aCanvas at: aPoint extent: sizePoint
	"Draw the receiver on aCanvas at aPoint with size sizePoint."

	| rect |
	rect := RECTL origin: aPoint extent: sizePoint.
	(Gdi32
		playEnhMetaFile: aCanvas asParameter
		hemf: self asParameter
		lpRect: rect)
			ifFalse: 
				["Fail silently"
				]!

extent
	"Answers the dimensions of the receiver in pixels"

	^self header rclBounds extent!

getData: aWinStruct
	^Gdi32
		getEnhMetaFileBits: self asParameter
		cbBuffer: aWinStruct byteSize
		lpbBuffer: aWinStruct!

header
	"Answer an <ENHMETAHEADER> with header details for the receiver."

	header isNil
		ifTrue: 
			[header := ENHMETAHEADER new.
			Gdi32
				getEnhMetaFileHeader: self asParameter
				cbBuffer: header byteSize
				lpemnh: header].
	^header!

imageType
	"Private - Answer the Win32 image type for the receiver."

	^IMAGE_ENHMETAFILE!

loadFromFile: pathString extent: aPoint
	"Private - Attempts to load an Windows Enhanced Metafile (.emf) from a disk file. Answers
	the image's handle, or nil if the image could not be loaded. Note that we use the GDI
	function intended specifically for this purpose (though LoadImage should work), and the
	specified extent is ignored."

	^Gdi32 getEnhMetaFile: pathString!

play: operation on: aCanvas at: originPoint extent: sizePoint
	"Play the records in the metafile through the triadic valuable, operation, onto the
	<Canvas>, aCanvas, at origin, originPoint, and with extent, sizePoint. The operation is
	passed the <Canvas> to which the metafile is being rendered (not necessarily aCanvas), a
	sub-instance of ENHMETARECORD representing each metafile record, and an array of handles of
	GDI objects currently in use. The operation should evaluate to true to continue playing records,
	or false to stop after the current record."

	| callback answer lpRect |
	callback := External.Callback block: 
					[:hDC :lpHTable :lpEMFR :nObj :lpData |
					| handles emfr |
					handles := HandleArray fromAddress: lpHTable length: nObj.
					emfr := ENHMETARECORD fromAddress: lpEMFR.
					operation
						value: (Canvas withNonOwnedDC: hDC)
						value: emfr
						value: handles]
				descriptor: (External.FunctionDescriptor returnType: 'int'
						argumentTypes: 'handle lpvoid lpvoid sdword lpvoid').
	lpRect := RECTL origin: originPoint extent: sizePoint.
	answer := Gdi32
				enumEnhMetaFile: aCanvas asParameter
				hemf: self asParameter
				lpEnhMetaFunc: callback asParameter
				lpData: 0
				lpRect: lpRect.
	callback free.
	^answer!

printRecordsOn: aPuttableStream
	"Print a diagnostic trace of the records in the receiving metafile onto the specified stream.
	Note that when the metafile records package is installed, this will provide a detailed trace of the record contents, otherwise
	the data will be quite limited."

	| i block bmp |
	i := 0.
	block := 
			[:canvas :emfr :handles |
			i := i + 1.
			aPuttableStream
				print: i;
				display: ': ';
				print: emfr;
				cr.
			true].
	bmp := Bitmap displayCompatibleWithExtent: self extent.
	self
		play: block
		on: bmp canvas
		at: 0 @ 0
		extent: self extent.
	bmp free!

saveAsFile: pathString
	"Save this Metafile to a file at the specified path, any existing file at that path is
	overwritten."

	Gdi32 copyEnhMetaFile: self asParameter lpszFile: pathString! !
!Graphics.Metafile categoriesForMethods!
addToImageList:mask:!private!testing! !
basicFree!private!realizing/unrealizing! !
clearCached!private!realizing/unrealizing! !
copyHandle!private!realizing/unrealizing! !
description!accessing!public! !
drawDisabledOn:at:extent:!drawing-bitmaps!public! !
drawOn:at:extent:!drawing-bitmaps!public! !
extent!accessing!public! !
getData:!accessing!private! !
header!public! !
imageType!constants!private!testing! !
loadFromFile:extent:!private!realizing/unrealizing! !
play:on:at:extent:!enumerating!public! !
printRecordsOn:!public! !
saveAsFile:!file operations!public! !
!

!Graphics.Metafile class methodsFor!

playRecord: anENHMETARECORD on: aCanvas handleTable: aHandleArray
	"Play an individual metafile record on to the specified <Canvas> and with the specified array of GDI object handles."

	Gdi32
		playEnhMetaFileRecord: aCanvas asParameter
		lpHandletable: aHandleArray
		lpEnhMetaRecord: anENHMETARECORD
		nHandles: aHandleArray length! !
!Graphics.Metafile class categoriesForMethods!
playRecord:on:handleTable:!operations!public! !
!

