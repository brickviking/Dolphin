﻿"Filed out from Dolphin Smalltalk"!

OS.Win32Structure subclass: #'OS.GETTEXTEX'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'_OffsetOf_cb' -> 16r0.
		'_OffsetOf_codepage' -> 16r8.
		'_OffsetOf_flags' -> 16r4.
		'_OffsetOf_lpDefaultChar' -> 16rC.
		'_OffsetOf_lpUsedDefChar' -> 16r10
	}!
OS.GETTEXTEX guid: (Core.GUID fromString: '{1ac7d35c-befe-4c13-b0b2-0c96f50feca0}')!
OS.GETTEXTEX comment: ''!
!OS.GETTEXTEX categoriesForClass!External-Data-Structured-Win32! !
!OS.GETTEXTEX methodsFor!

cb
	"Answer the <Integer> value of the receiver's 'cb' field."

	^bytes dwordAtOffset: _OffsetOf_cb!

cb: anInteger
	"Set the receiver's 'cb' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_cb put: anInteger!

codepage: anInteger
	"Set the receiver's 'codepage' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_codepage put: anInteger!

flags: anInteger
	"Set the receiver's 'flags' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_flags put: anInteger! !
!OS.GETTEXTEX categoriesForMethods!
cb!**compiled accessors**!public! !
cb:!**compiled accessors**!public! !
codepage:!**compiled accessors**!public! !
flags:!**compiled accessors**!public! !
!

!OS.GETTEXTEX class methodsFor!

defineFields
	"Define the fields of the GETTEXTEX structure.
		self compileDefinition
	"

	self
		defineField: #cb type: DWORDField new;
		defineField: #flags type: DWORDField writeOnly;
		defineField: #codepage type: DWORDField writeOnly;
		defineField: #lpDefaultChar type: (PointerField type: String) beFiller;
		defineField: #lpUsedDefChar type: (PointerField type: BOOL) beFiller!

getFieldNames
	^#(#cb #flags #codepage)! !
!OS.GETTEXTEX class categoriesForMethods!
defineFields!public!template definition! !
getFieldNames!**compiled accessors**!constants!private! !
!

