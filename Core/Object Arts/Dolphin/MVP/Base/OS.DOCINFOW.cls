﻿"Filed out from Dolphin Smalltalk"!

OS.Win32Structure subclass: #'OS.DOCINFOW'
	instanceVariableNames: 'docName'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'_OffsetOf_dwSize' -> 16r0.
		'_OffsetOf_fwType' -> 16r10.
		'_OffsetOf_lpszDatatype' -> 16rC.
		'_OffsetOf_lpszDocName' -> 16r4.
		'_OffsetOf_lpszOutput' -> 16r8
	}!
OS.DOCINFOW guid: (Core.GUID fromString: '{87b4c5e8-026e-11d3-9fd7-00a0cc3e4a32}')!
OS.DOCINFOW comment: 'DOCINFO is an <ExternalStructure> class which represents the Win32 DOCINFO structure of the same name.

DOCINFO is used in conjunction with the StartDoc() GDI call.'!
!OS.DOCINFOW categoriesForClass!External-Data-Structured-Win32! !
!OS.DOCINFOW methodsFor!

docName: aString
	docName := aString asUtf16String.
	self lpszDocName: docName!

dwSize: anInteger
	"Set the receiver's 'dwSize' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_dwSize put: anInteger!

fwType: anInteger
	"Set the receiver's 'fwType' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_fwType put: anInteger!

lpszDatatype: anUtf16String
	"Set the receiver's 'lpszDatatype' field to the value of the argument, anUtf16String"

	bytes uintPtrAtOffset: _OffsetOf_lpszDatatype put: anUtf16String yourAddress!

lpszDocName: anUtf16String
	"Set the receiver's 'lpszDocName' field to the value of the argument, anUtf16String"

	bytes uintPtrAtOffset: _OffsetOf_lpszDocName put: anUtf16String yourAddress!

lpszOutput: anUtf16String
	"Set the receiver's 'lpszOutput' field to the value of the argument, anUtf16String"

	bytes uintPtrAtOffset: _OffsetOf_lpszOutput put: anUtf16String yourAddress! !
!OS.DOCINFOW categoriesForMethods!
docName:!accessing!public! !
dwSize:!**compiled accessors**!public! !
fwType:!**compiled accessors**!public! !
lpszDatatype:!**compiled accessors**!public! !
lpszDocName:!**compiled accessors**!public! !
lpszOutput:!**compiled accessors**!public! !
!

!OS.DOCINFOW class methodsFor!

defineFields
	"Define the fields of the Win32 DOCINFOW structure.

		self compileDefinition

	typedef struct {		// di  
		int		cbSize;
		LPCWSTR	lpszDocName;
		LPCWSTR	lpszOutput;
		LPCWSTR	lpszDatatype;	// Windows 95 only; ignored on Windows NT
		DWORD	fwType;		// Windows 95 only; ignored on Windows NT
		} DOCINFO;"

	self
		defineField: #dwSize type: DWORDField writeOnly beOverride;
		defineField: #lpszDocName type: (PointerField type: Utf16String) beWriteOnly;
		defineField: #lpszOutput type: (PointerField type: Utf16String) beWriteOnly;
		defineField: #lpszDatatype type: (PointerField type: Utf16String) beWriteOnly;
		defineField: #fwType type: DWORDField writeOnly!

getFieldNames
	^#(#dwSize #lpszDocName #lpszOutput #lpszDatatype #fwType)! !
!OS.DOCINFOW class categoriesForMethods!
defineFields!public!template definition! !
getFieldNames!**compiled accessors**!constants!private! !
!

