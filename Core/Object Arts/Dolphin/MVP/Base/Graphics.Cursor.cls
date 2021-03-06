﻿"Filed out from Dolphin Smalltalk"!

Graphics.Icon subclass: #'Graphics.Cursor'
	instanceVariableNames: ''
	classVariableNames: 'AppStarting Arrow Cross Current DDCopy DDCopyScroll DDLink DDLinkScroll DDMove DDMoveScroll DDNone Hand Help IBeam No SizeAll SizeNESW SizeNS SizeNWSE SizeWE SplitHorizontal SplitVertical UpArrow Wait'
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
Graphics.Cursor guid: (Core.GUID fromString: '{87b4c640-026e-11d3-9fd7-00a0cc3e4a32}')!
Graphics.Cursor comment: ''!
!Graphics.Cursor categoriesForClass!Graphics-Tools! !
!Graphics.Cursor methodsFor!

imageType
	"Private - Answer the Win32 image type for the receiver."

	^IMAGE_CURSOR!

load: identifierObject fromInstance: hModule extent: aPoint
	"Private - Attempts to load the receiver as a resource from an instance.
	Answers the image's handle, or nil if the image could not be loaded."

	^User32
		loadImage: hModule asParameter
		lpszName: identifierObject asResourceId
		uType: self imageType
		cxDesired: aPoint x
		cyDesired: aPoint y
		fuLoad: LR_SHARED!

loadFromInstance: hModule
	"Private - Attempts to load the receiver as a resource from an instance. 
	I would have expected the User32 loadImage function to be capable of this but
	it does not appear to work for instance 0; the system. Hence this method 
	which tries the old way. Answers the loaded handle or nil if the load failed"

	^User32 loadCursor: hModule asParameter lpCursorName: identifier asResourceId!

makeCurrent
	"Make the receiver become the current global cursor."

	self class current: self!

printOn: aStream
	instanceHandle == 0
		ifTrue: 
			[(##(LookupTable new
				at: IDC_APPSTARTING put: #appStarting;
				at: IDC_ARROW put: #arrow;
				at: IDC_CROSS put: #cross;
				at: IDC_HAND put: #hand;
				at: IDC_HELP put: #help;
				at: IDC_IBEAM put: #iBeam;
				at: IDC_NO put: #no;
				at: IDC_SIZEALL put: #sizeAll;
				at: IDC_SIZENESW put: #sizeNESW;
				at: IDC_SIZENS put: #sizeNS;
				at: IDC_SIZENWSE put: #sizeNWSE;
				at: IDC_SIZEWE put: #sizeWE;
				at: IDC_UPARROW put: #upArrow;
				at: IDC_WAIT put: #wait;
				shrink) lookup: self identifier)
				ifNotNil: 
					[:name |
					aStream
						print: self class;
						space;
						nextPutAll: name.
					^self]].
	super printOn: aStream!

setCursor
	"Private - Set the receiver as the current Windows cursor. Answers the handle of the old
	cursor."

	^User32 setCursor: self asParameter!

showWhile: aBlock
	"Maintain the wait cursor while aBlock is executed, answering the result of the block.
	The actual cursor which was current is restored (rather than the one we think is Current)."

	| previous actual |
	previous := Current.
	Current := self.
	actual := self setCursor.
	^aBlock ensure: 
			[Current := previous.
			User32 setCursor: actual]! !
!Graphics.Cursor categoriesForMethods!
imageType!constants!private! !
load:fromInstance:extent:!private!realizing/unrealizing! !
loadFromInstance:!private!realizing/unrealizing! !
makeCurrent!operations!public! !
printOn:!development!printing!public! !
setCursor!operations!private! !
showWhile:!operations!public! !
!

!Graphics.Cursor class methodsFor!

appStarting
	"Answer the instance that is the AppStarting cursor."

	AppStarting isNil ifTrue: [AppStarting := self fromSystemId: IDC_APPSTARTING].
	^AppStarting!

arrow
	"Answer the instance that is the Arrow cursor."

	Arrow isNil ifTrue: [Arrow := self fromSystemId: IDC_ARROW].
	^Arrow!

cross
	"Answer the instance that is the Cross cursor."

	Cross isNil ifTrue: [Cross := self fromSystemId: IDC_CROSS].
	^Cross!

current
	"Answers the current global cursor. This may be nil."

	^Current!

current: aCursorOrNil
	"Private - Set the current cursor to aCursorOrNil.
	Answers the previous current cursor (or nil)."

	| original |
	original := Current.
	Current := aCursorOrNil.
	User32 setCursor: Current asParameter.
	^original!

ddCopy
	"Answer the instance that is the OLE DROPEFFECT_COPY cursor."

	DDCopy isNil ifTrue: [DDCopy := self fromId: 3 in: (External.ResourceLibrary open: 'ole32')].
	^DDCopy!

ddCopyScroll
	"Answer the instance that is the OLE DROPEFFECT_COPY | DROPEFFECT_SCROLL cursor."

	DDCopyScroll isNil
		ifTrue: [DDCopyScroll := self fromId: 6 in: (External.ResourceLibrary open: 'ole32')].
	^DDCopyScroll!

ddLink
	"Answer the instance that is the OLE DROPEFFECT_LINK cursor."

	DDLink isNil ifTrue: [DDLink := self fromId: 4 in: (External.ResourceLibrary open: 'ole32')].
	^DDLink!

ddLinkScroll
	"Answer the instance that is the OLE DROPEFFECT_LINK | DROPEFFECT_SCROLL cursor."

	DDLinkScroll isNil
		ifTrue: [DDLinkScroll := self fromId: 7 in: (External.ResourceLibrary open: 'ole32')].
	^DDLinkScroll!

ddMove
	"Answer the instance that is the OLE DROPEFFECT_MOVE cursor."

	DDMove isNil ifTrue: [DDMove := self fromId: 2 in: (External.ResourceLibrary open: 'ole32')].
	^DDMove!

ddMoveScroll
	"Answer the instance that is the OLE DROPEFFECT_MOVE | DROPEFFECT_SCROLL cursor."

	DDMoveScroll isNil
		ifTrue: [DDMoveScroll := self fromId: 5 in: (External.ResourceLibrary open: 'ole32')].
	^DDMoveScroll!

ddNone
	"Answer the instance that is the OLE DROPEFFECT_NONE cursor."

	DDNone isNil ifTrue: [DDNone := self fromId: 1 in: (External.ResourceLibrary open: 'ole32')].
	^DDNone!

defaultExtent
	"Answer a Point that gives the dimensions of a standard size cursor."

	^SystemMetrics current cursorExtent!

filesType
	"Private - Answer a two element array suitable for adding to the FileDialog
	with the fileTypes: message."

	^#('Cursor Files (*.cur)' '*.cur')!

hand
	"Answer the instance that is the Help cursor."

	Hand isNil ifTrue: [Hand := self fromSystemId: IDC_HAND].
	^Hand!

help
	"Answer the instance that is the Help cursor."

	Help isNil ifTrue: [Help := self fromSystemId: IDC_HELP].
	^Help!

hide
	"Hide the current cursor"

	self show: false!

iBeam
	"Answer the instance that is the IBeam cursor."

	IBeam isNil ifTrue: [IBeam := self fromSystemId: IDC_IBEAM].
	^IBeam!

icon
	"Answers an Icon that can be used to represent this class"

	^self hand!

no
	"Answer the instance that is the No cursor."

	No isNil ifTrue: [No := self fromSystemId: IDC_NO].
	^No!

onPreStripImage
	"Private - The image is about to be stripped. Nil the lazily initialized cursors to allow
	them to be removed (and also perhaps the ref to the resource library)."

	self uninitialize!

position
	"Answer a Point containing the current cursor position in screen co-ordinates."

	| pos |
	pos := POINTL new.
	User32 getCursorPos: pos.
	^pos asPoint!

position: aPoint
	"Move the mouse cursor (if permitted) to the Point specified in screen co-ordinates."

	^(User32 setCursorPosX: aPoint x y: aPoint y) ~~ 0!

reset
	"Clear the global cursor setting. Answers the previous global cursor (or nil if none)."

	^self current: nil!

show
	"Shows the current cursor"

	self show: true!

show: aBoolean
	"Show or hide the current cursor according to aBoolean"

	User32 showCursor: aBoolean asParameter!

sizeAll
	"Answer the instance that is the SizeAll cursor."

	SizeAll isNil ifTrue: [SizeAll := self fromSystemId: IDC_SIZEALL].
	^SizeAll!

sizeNESW
	"Answer the instance that is the SizeNESW cursor."

	SizeNESW isNil ifTrue: [SizeNESW := self fromSystemId: IDC_SIZENESW].
	^SizeNESW!

sizeNS
	"Answer the instance that is the SizeNS cursor."

	SizeNS isNil ifTrue: [SizeNS := self fromSystemId: IDC_SIZENS].
	^SizeNS!

sizeNWSE
	"Answer the instance that is the SizeNWSE cursor."

	SizeNWSE isNil ifTrue: [SizeNWSE := self fromSystemId: IDC_SIZENWSE].
	^SizeNWSE!

sizeWE
	"Answer the instance that is the SizeWE cursor."

	SizeWE isNil ifTrue: [SizeWE := self fromSystemId: IDC_SIZEWE].
	^SizeWE!

splitHorizontal
	"Answer the instance that is the SplitHorizontal cursor."

	SplitHorizontal isNil ifTrue: [SplitHorizontal := self fromId: 'HSPLIT' in: VM].
	^SplitHorizontal!

splitVertical
	"Answer the instance that is the SplitVertical cursor."

	SplitVertical isNil ifTrue: [SplitVertical := self fromId: 'VSPLIT' in: VM].
	^SplitVertical!

uninitialize
	"Private - Uninitialize the receiver as it is about to be removed from the system."

	DDCopy := DDCopyScroll := 
		DDLink := DDLinkScroll := 
		DDMove := DDMoveScroll := 
		DDNone := nil.

	AppStarting := Arrow := Cross := Help := IBeam := No := Wait :=
		SizeAll := SizeNESW := SizeNS := SizeNWSE := SizeWE := 
		SplitHorizontal := SplitVertical := UpArrow := nil.

	Current := nil.!

upArrow
	"Answer the instance that is the UpArrow cursor."

	UpArrow isNil ifTrue: [UpArrow := self fromSystemId: IDC_UPARROW].
	^UpArrow!

wait
	"Answer the instance that is the Wait cursor."

	Wait isNil ifTrue: [Wait := self fromSystemId: IDC_WAIT].
	^Wait! !
!Graphics.Cursor class categoriesForMethods!
appStarting!accessing!public! !
arrow!instance creation!public! !
cross!instance creation!public! !
current!accessing!public! !
current:!accessing!private! !
ddCopy!instance creation!public! !
ddCopyScroll!instance creation!public! !
ddLink!instance creation!public! !
ddLinkScroll!instance creation!public! !
ddMove!instance creation!public! !
ddMoveScroll!instance creation!public! !
ddNone!instance creation!public! !
defaultExtent!constants!public! !
filesType!constants!private! !
hand!instance creation!public! !
help!instance creation!public! !
hide!operations!public! !
iBeam!instance creation!public! !
icon!constants!public! !
no!instance creation!public! !
onPreStripImage!class hierarchy-removing!private! !
position!accessing!public! !
position:!accessing!public! !
reset!initializing!public! !
show!operations!public! !
show:!operations!public! !
sizeAll!instance creation!public! !
sizeNESW!instance creation!public! !
sizeNS!instance creation!public! !
sizeNWSE!instance creation!public! !
sizeWE!instance creation!public! !
splitHorizontal!instance creation!public! !
splitVertical!instance creation!public! !
uninitialize!class hierarchy-removing!private! !
upArrow!instance creation!public! !
wait!instance creation!public! !
!

