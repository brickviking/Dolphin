﻿"Filed out from Dolphin Smalltalk"!

OS.Win32Structure subclass: #'OS.LASTINPUTINFO'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'_OffsetOf_dwSize' -> 16r0.
		'_OffsetOf_dwTime' -> 16r4
	}!
OS.LASTINPUTINFO guid: (Core.GUID fromString: '{71c57485-4335-49cf-8a38-99d1c4d2a51b}')!
OS.LASTINPUTINFO comment: 'LASTINPUTINFO is an <ExternalStructure> class to represent the Win32 structure of the same name.

typedef struct tagLASTINPUTINFO {
	UINT  cbSize;		//	The size of the structure, in bytes. This member must be set to sizeof(LASTINPUTINFO)
	DWORD dwTime;	//	The tick count when the last input event was received
} LASTINPUTINFO, *PLASTINPUTINFO;

This function is useful for input idle detection. For more information on tick counts, see GetTickCount.

https://msdn.microsoft.com/en-us/library/windows/desktop/ms646272(v=vs.85).aspx'!
!OS.LASTINPUTINFO categoriesForClass!Unclassified! !
!OS.LASTINPUTINFO methodsFor!

dwSize: anInteger
	"Set the receiver's 'dwSize' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_dwSize put: anInteger!

dwTime
	"Answer the <Integer> value of the receiver's 'dwTime' field."

	^bytes dwordAtOffset: _OffsetOf_dwTime!

dwTime: anInteger
	"Set the receiver's 'dwTime' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_dwTime put: anInteger! !
!OS.LASTINPUTINFO categoriesForMethods!
dwSize:!**compiled accessors**!public! !
dwTime!**compiled accessors**!public! !
dwTime:!**compiled accessors**!public! !
!

!OS.LASTINPUTINFO class methodsFor!

defineFields
	"
		self compileDefinition.

		typedef struct tagLASTINPUTINFO {
			UINT  cbSize;		//	The size of the structure, in bytes. This member must be set to sizeof(LASTINPUTINFO)
			DWORD dwTime;	//	The tick count when the last input event was received
		} LASTINPUTINFO, *PLASTINPUTINFO;
	"

	self
		defineField: #dwSize type: DWORDField writeOnly;
		defineField: #dwTime type: DWORDField new;
		yourself!

getFieldNames
	^#(#dwSize #dwTime)! !
!OS.LASTINPUTINFO class categoriesForMethods!
defineFields!**auto generated**!public!template definition! !
getFieldNames!**compiled accessors**!constants!private! !
!

