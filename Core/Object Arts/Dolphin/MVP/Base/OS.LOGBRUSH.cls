﻿"Filed out from Dolphin Smalltalk"!

OS.Win32Structure subclass: #'OS.LOGBRUSH'
	instanceVariableNames: 'hatch'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'_OffsetOf_lbColor' -> 16r4.
		'_OffsetOf_lbHatch' -> 16r8.
		'_OffsetOf_lbStyle' -> 16r0
	}!
OS.LOGBRUSH guid: (Core.GUID fromString: '{87b4c5f8-026e-11d3-9fd7-00a0cc3e4a32}')!
OS.LOGBRUSH comment: '<LOGBRUSH> is an <ExternalStructure> class to wrap the struct ''Win.LOGBRUSH'' from type information in the ''Windows API (ANSI)'' library.

From MSDN: "The LOGBRUSH structure defines the style, color, and pattern of a physical brush. It is used by the CreateBrushIndirect and ExtCreatePen functions."

Instance Variables:
	hatch		<integer> hatch code from the HS_XXX enumeration, or <Bitmap> (for a bitmap brush, preventing the premature GC of that Bitmap).

'!
!OS.LOGBRUSH categoriesForClass!Win32-Structs! !
!OS.LOGBRUSH methodsFor!

color
	"Answer the colour member of the receiver as a Colour"

	^Graphics.Color fromCOLORREF: self lbColor!

color: aColor
	"Sets the colour member of the receiver from  the <Color> argument."

	self lbColor: aColor asCOLORREF!

hatch
	"Answer the hatch object. This is either a <Bitmap>, or one of a set of standard <integer> constants."

	^hatch
		ifNil: 
			[self lbStyle = BS_PATTERN ifTrue: [hatch := Graphics.Bitmap fromHandle: self lbHatch] ifFalse: [self lbHatch]]!

hatch: aBitmapOrInteger 
	hatch := aBitmapOrInteger.
	self lbHatch: aBitmapOrInteger asParameter!

hatchStyleName
	"Answer the symbolic hatch style name, or if not a hatched brush"

	^self lbStyle == BS_HATCHED
		ifTrue: [#(#horizontal #vertical #reverseDiagonal #diagonal #cross #diamond) lookup: self lbHatch + 1]!

lbColor
	"Answer the <Integer> value of the receiver's 'lbColor' field."

	^bytes dwordAtOffset: _OffsetOf_lbColor!

lbColor: anInteger
	"Set the receiver's 'lbColor' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_lbColor put: anInteger!

lbHatch
	"Answer the <Integer> value of the receiver's 'lbHatch' field."

	^bytes uintPtrAtOffset: _OffsetOf_lbHatch!

lbHatch: anInteger
	"Set the receiver's 'lbHatch' field to the value of the argument, anInteger"

	bytes uintPtrAtOffset: _OffsetOf_lbHatch put: anInteger!

lbStyle
	"Answer the <Integer> value of the receiver's 'lbStyle' field."

	^bytes dwordAtOffset: _OffsetOf_lbStyle!

lbStyle: anInteger
	"Set the receiver's 'lbStyle' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_lbStyle put: anInteger! !
!OS.LOGBRUSH categoriesForMethods!
color!accessing!public! !
color:!accessing!public! !
hatch!accessing!public! !
hatch:!accessing!public! !
hatchStyleName!accessing!public! !
lbColor!**compiled accessors**!public! !
lbColor:!**compiled accessors**!public! !
lbHatch!**compiled accessors**!public! !
lbHatch:!**compiled accessors**!public! !
lbStyle!**compiled accessors**!public! !
lbStyle:!**compiled accessors**!public! !
!

!OS.LOGBRUSH class methodsFor!

defineFields
	"Define the fields of the LOGBRUSH structure.

	LOGBRUSH  compileDefinition

		typedef [uuid(87B4C5F8-026E-11D3-9FD7-00A0CC3E4A32), helpstring('The LOGBRUSH structure defines the style, color, and pattern of a physical brush. It is used by the CreateBrushIndirect and ExtCreatePen functions.')]
		struct tagLOGBRUSH {
			unsigned int lbStyle;
			COLORREF lbColor;
			ULONG_PTR lbHatch;
		} LOGBRUSH;
"

	self
		defineField: #lbStyle type: DWORDField new;
		defineField: #lbColor type: DWORDField new;
		defineField: #lbHatch type: UINT_PTRField new!

getFieldNames
	^#(#lbStyle #lbColor #lbHatch)!

stbConvertFrom: anSTBClassFormat 
	"Version 1 adds hatch instance variables to hold Bitmap preventing it being GC'd (#1052)."

	^
	[:data | 
	| newInstance |
		newInstance := self basicNew.
		1 to: data size do: [:i | newInstance instVarAt: i put: (data at: i)].
		newInstance]!

stbVersion
	^1! !
!OS.LOGBRUSH class categoriesForMethods!
defineFields!**auto generated**!public!template definition! !
getFieldNames!**compiled accessors**!constants!private! !
stbConvertFrom:!binary filing!public! !
stbVersion!binary filing!public! !
!

