﻿"Filed out from Dolphin Smalltalk"!

External.RECT subclass: #'Graphics.Gdiplus.RECTF'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'_OffsetOf_height' -> 16rC.
		'_OffsetOf_width' -> 16r8.
		'_OffsetOf_x' -> 16r0.
		'_OffsetOf_y' -> 16r4
	}!
Graphics.Gdiplus.RECTF guid: (Core.GUID fromString: '{9a449c4a-8ae9-45d9-b94d-1e1d91fedcd5}')!
Graphics.Gdiplus.RECTF comment: '<RECTF> is an <ExternalStructure> class to wrap the struct ''Gdiplus.RECTF'' from type information in the ''GDI+ Library 1.0'' library.

The type library contains no documentation for this struct

Warning: This comment was automatically generated from the struct''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

typedef [uuid(9A449C4A-8AE9-45D9-B94D-1E1D91FEDCD5)]
struct tagRECTF {
	float x;
	float y;
	float Width;
	float Height;
} RECTF;
'!
!Graphics.Gdiplus.RECTF categoriesForClass!Unclassified! !
!Graphics.Gdiplus.RECTF methodsFor!

asRectangle
	^self x @ self y extent: self width @ self height!

bottom
	^self y + self height!

height
	"Answer the <Float> value of the receiver's 'height' field."

	^bytes floatAtOffset: _OffsetOf_height!

height: aFloat
	"Set the receiver's 'height' field to the value of the argument, aFloat"

	bytes floatAtOffset: _OffsetOf_height put: aFloat!

left
	^self x!

right
	^self x + self width!

top
	^self y!

width
	"Answer the <Float> value of the receiver's 'width' field."

	^bytes floatAtOffset: _OffsetOf_width!

width: aFloat
	"Set the receiver's 'width' field to the value of the argument, aFloat"

	bytes floatAtOffset: _OffsetOf_width put: aFloat!

x
	"Answer the <Float> value of the receiver's 'x' field."

	^bytes floatAtOffset: _OffsetOf_x!

x: aFloat
	"Set the receiver's 'x' field to the value of the argument, aFloat"

	bytes floatAtOffset: _OffsetOf_x put: aFloat!

y
	"Answer the <Float> value of the receiver's 'y' field."

	^bytes floatAtOffset: _OffsetOf_y!

y: aFloat
	"Set the receiver's 'y' field to the value of the argument, aFloat"

	bytes floatAtOffset: _OffsetOf_y put: aFloat! !
!Graphics.Gdiplus.RECTF categoriesForMethods!
asRectangle!converting!public! !
bottom!accessing!public! !
height!**compiled accessors**!public! !
height:!**compiled accessors**!public! !
left!public! !
right!accessing!public! !
top!public! !
width!**compiled accessors**!public! !
width:!**compiled accessors**!public! !
x!**compiled accessors**!public! !
x:!**compiled accessors**!public! !
y!**compiled accessors**!public! !
y:!**compiled accessors**!public! !
!

!Graphics.Gdiplus.RECTF class methodsFor!

defineFields
	"Define the fields of the RECTF structure.
		RECTF compileDefinition
	
		typedef [uuid(9A449C4A-8AE9-45D9-B94D-1E1D91FEDCD5)]
		struct tagRECTF {
			float x;
			float y;
			float Width;
			float Height;
		} RECTF;
"

	self
		defineField: #x type: FLOATField new;
		defineField: #y type: FLOATField new;
		defineField: #width type: FLOATField new;
		defineField: #height type: FLOATField new!

fromRectangle: aRect
	self == aRect class ifTrue: [^aRect].
	^(self new)
		x: aRect left;
		y: aRect top;
		width: aRect width;
		height: aRect height;
		yourself!

getFieldNames
	^#(#x #y #width #height)!

left: left top: top right: right bottom: bottom
	"Answer a new instance of the receiver with the specified position corner positions."

	^self
		left: left
		top: top
		width: right - left
		height: bottom - top!

left: left top: top width: width height: height
	"Answer a new instance of the receiver with the specified origin and extent."

	^self basicNew bytes: ((ByteArray newFixed: 16)
				floatAtOffset: 0 put: left;
				floatAtOffset: 4 put: top;
				floatAtOffset: 8 put: width;
				floatAtOffset: 12 put: height;
				yourself)!

newBuffer
	^self basicNew bytes: (ByteArray newFixed: 16)! !
!Graphics.Gdiplus.RECTF class categoriesForMethods!
defineFields!public!template definition! !
fromRectangle:!instance creation!public! !
getFieldNames!**compiled accessors**!constants!private! !
left:top:right:bottom:!instance creation!public! !
left:top:width:height:!instance creation!public! !
newBuffer!instance creation!public! !
!

