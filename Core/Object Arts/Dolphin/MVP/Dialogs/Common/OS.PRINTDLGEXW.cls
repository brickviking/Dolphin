﻿"Filed out from Dolphin Smalltalk"!

OS.CommonDialogStructure subclass: #'OS.PRINTDLGEXW'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'_OffsetOf_dwResultAction' -> 16r50.
		'_OffsetOf_ExclusionFlags' -> 16r1C.
		'_OffsetOf_flags' -> 16r14.
		'_OffsetOf_Flags2' -> 16r18.
		'_OffsetOf_hDC' -> 16r10.
		'_OffsetOf_hDevMode' -> 16r8.
		'_OffsetOf_hDevNames' -> 16rC.
		'_OffsetOf_hInstance' -> 16r38.
		'_OffsetOf_hwndOwner' -> 16r4.
		'_OffsetOf_lpCallback' -> 16r40.
		'_OffsetOf_lphPropertyPages' -> 16r48.
		'_OffsetOf_lpPageRanges' -> 16r28.
		'_OffsetOf_lpPrintTemplateName' -> 16r3C.
		'_OffsetOf_lStructSize' -> 16r0.
		'_OffsetOf_nCopies' -> 16r34.
		'_OffsetOf_nMaxPage' -> 16r30.
		'_OffsetOf_nMaxPageRanges' -> 16r24.
		'_OffsetOf_nMinPage' -> 16r2C.
		'_OffsetOf_nPageRanges' -> 16r20.
		'_OffsetOf_nPropertyPages' -> 16r44.
		'_OffsetOf_nStartPage' -> 16r4C
	}!
OS.PRINTDLGEXW guid: (Core.GUID fromString: '{46f06e70-1bb5-4b02-98ee-6ab442f3b43f}')!
OS.PRINTDLGEXW comment: '<PRINTDLGEX> is an <ExternalStructure> class to wrap the struct ''Win32.PRINTDLGEX'' from type information in the ''Win32 API (ANSI). Derived from Bruce McKinney´s Hardcore Visual Basic Type Library'' library.

The type library contains no documentation for this struct

Warning: This comment was automatically generated from the struct''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

typedef [uuid(46F06E70-1BB5-4B02-98EE-6AB442F3B43F)]
struct tagPRINTDLGEX {
	DWORD lStructSize;
	HWND hwndOwner;
	HGLOBAL hDevMode;
	HGLOBAL hDevNames;
	HDC HDC;
	DWORD flags;
	DWORD Flags2;
	DWORD ExclusionFlags;
	DWORD nPageRanges;
	DWORD nMaxPageRanges;
	PRINTPAGERANGE* lpPageRanges;
	DWORD nMinPage;
	DWORD nMaxPage;
	DWORD nCopies;
	HINSTANCE HINSTANCE;
	LPCSTR lpPrintTemplateName;
	IUnknown* lpCallback;
	DWORD nPropertyPages;
	HPROPSHEETPAGE* lphPropertyPages;
	DWORD nStartPage;
	DWORD dwResultAction;
} PRINTDLGEX;
'!
!OS.PRINTDLGEXW categoriesForClass!Win32-Structs! !
!OS.PRINTDLGEXW methodsFor!

dwResultAction
	"Answer the <Integer> value of the receiver's 'dwResultAction' field."

	^bytes dwordAtOffset: _OffsetOf_dwResultAction!

dwResultAction: anInteger
	"Set the receiver's 'dwResultAction' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_dwResultAction put: anInteger!

ExclusionFlags
	"Answer the <Integer> value of the receiver's 'ExclusionFlags' field."

	^bytes dwordAtOffset: _OffsetOf_ExclusionFlags!

ExclusionFlags: anInteger
	"Set the receiver's 'ExclusionFlags' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_ExclusionFlags put: anInteger!

flags
	"Answer the <Integer> value of the receiver's 'flags' field."

	^bytes dwordAtOffset: _OffsetOf_flags!

flags: anInteger
	"Set the receiver's 'flags' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_flags put: anInteger!

Flags2
	"Answer the <Integer> value of the receiver's 'Flags2' field."

	^bytes dwordAtOffset: _OffsetOf_Flags2!

Flags2: anInteger
	"Set the receiver's 'Flags2' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_Flags2 put: anInteger!

hDC
	"Answer the <ExternalHandle> value of the receiver's 'hDC' field."

	^(bytes uintPtrAtOffset: _OffsetOf_hDC) asExternalHandle!

hDC: anExternalHandle
	"Set the receiver's 'hDC' field to the value of the argument, anExternalHandle"

	bytes uintPtrAtOffset: _OffsetOf_hDC put: anExternalHandle!

hDevMode
	"Answer the <ExternalHandle> value of the receiver's 'hDevMode' field."

	^(bytes uintPtrAtOffset: _OffsetOf_hDevMode) asExternalHandle!

hDevMode: anExternalHandle
	"Set the receiver's 'hDevMode' field to the value of the argument, anExternalHandle"

	bytes uintPtrAtOffset: _OffsetOf_hDevMode put: anExternalHandle!

hDevNames
	"Answer the <ExternalHandle> value of the receiver's 'hDevNames' field."

	^(bytes uintPtrAtOffset: _OffsetOf_hDevNames) asExternalHandle!

hDevNames: anExternalHandle
	"Set the receiver's 'hDevNames' field to the value of the argument, anExternalHandle"

	bytes uintPtrAtOffset: _OffsetOf_hDevNames put: anExternalHandle!

hInstance
	"Answer the <ExternalHandle> value of the receiver's 'hInstance' field."

	^(bytes uintPtrAtOffset: _OffsetOf_hInstance) asExternalHandle!

hInstance: anExternalHandle
	"Set the receiver's 'hInstance' field to the value of the argument, anExternalHandle"

	bytes uintPtrAtOffset: _OffsetOf_hInstance put: anExternalHandle!

hwndOwner
	"Answer the <ExternalHandle> value of the receiver's 'hwndOwner' field."

	^(bytes uintPtrAtOffset: _OffsetOf_hwndOwner) asExternalHandle!

hwndOwner: anExternalHandle
	"Set the receiver's 'hwndOwner' field to the value of the argument, anExternalHandle"

	bytes uintPtrAtOffset: _OffsetOf_hwndOwner put: anExternalHandle!

lpCallback
	"Answer the <IUnknown> value of the receiver's 'lpCallback' field."

	^COM.IUnknown fromAddress: (bytes intPtrAtOffset: _OffsetOf_lpCallback)!

lpCallback: anIUnknown
	"Set the receiver's 'lpCallback' field to the value of the argument, anIUnknown"

	bytes uintPtrAtOffset: _OffsetOf_lpCallback put: anIUnknown yourAddress!

lphPropertyPages
	"Answer the <ExternalHandle> value of the receiver's 'lphPropertyPages' field."

	^Handle fromAddress: (bytes intPtrAtOffset: _OffsetOf_lphPropertyPages)!

lphPropertyPages: anExternalHandle
	"Set the receiver's 'lphPropertyPages' field to the value of the argument, anExternalHandle"

	bytes uintPtrAtOffset: _OffsetOf_lphPropertyPages put: anExternalHandle yourAddress!

lpPageRanges
	"Answer the <PRINTPAGERANGE> value of the receiver's 'lpPageRanges' field."

	^PRINTPAGERANGE fromAddress: (bytes intPtrAtOffset: _OffsetOf_lpPageRanges)!

lpPageRanges: aPRINTPAGERANGE
	"Set the receiver's 'lpPageRanges' field to the value of the argument, aPRINTPAGERANGE"

	bytes uintPtrAtOffset: _OffsetOf_lpPageRanges put: aPRINTPAGERANGE yourAddress!

lpPrintTemplateName
	"Answer the <Utf16String> value of the receiver's 'lpPrintTemplateName' field."

	^Utf16String fromAddress: (bytes intPtrAtOffset: _OffsetOf_lpPrintTemplateName)!

lpPrintTemplateName: anUtf16String
	"Set the receiver's 'lpPrintTemplateName' field to the value of the argument, anUtf16String"

	bytes uintPtrAtOffset: _OffsetOf_lpPrintTemplateName put: anUtf16String yourAddress!

lStructSize
	"Answer the <Integer> value of the receiver's 'lStructSize' field."

	^bytes dwordAtOffset: _OffsetOf_lStructSize!

lStructSize: anInteger
	"Set the receiver's 'lStructSize' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_lStructSize put: anInteger!

nCopies
	"Answer the <Integer> value of the receiver's 'nCopies' field."

	^bytes dwordAtOffset: _OffsetOf_nCopies!

nCopies: anInteger
	"Set the receiver's 'nCopies' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_nCopies put: anInteger!

nMaxPage
	"Answer the <Integer> value of the receiver's 'nMaxPage' field."

	^bytes dwordAtOffset: _OffsetOf_nMaxPage!

nMaxPage: anInteger
	"Set the receiver's 'nMaxPage' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_nMaxPage put: anInteger!

nMaxPageRanges
	"Answer the <Integer> value of the receiver's 'nMaxPageRanges' field."

	^bytes dwordAtOffset: _OffsetOf_nMaxPageRanges!

nMaxPageRanges: anInteger
	"Set the receiver's 'nMaxPageRanges' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_nMaxPageRanges put: anInteger!

nMinPage
	"Answer the <Integer> value of the receiver's 'nMinPage' field."

	^bytes dwordAtOffset: _OffsetOf_nMinPage!

nMinPage: anInteger
	"Set the receiver's 'nMinPage' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_nMinPage put: anInteger!

nPageRanges
	"Answer the <Integer> value of the receiver's 'nPageRanges' field."

	^bytes dwordAtOffset: _OffsetOf_nPageRanges!

nPageRanges: anInteger
	"Set the receiver's 'nPageRanges' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_nPageRanges put: anInteger!

nPropertyPages
	"Answer the <Integer> value of the receiver's 'nPropertyPages' field."

	^bytes dwordAtOffset: _OffsetOf_nPropertyPages!

nPropertyPages: anInteger
	"Set the receiver's 'nPropertyPages' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_nPropertyPages put: anInteger!

nStartPage
	"Answer the <Integer> value of the receiver's 'nStartPage' field."

	^bytes dwordAtOffset: _OffsetOf_nStartPage!

nStartPage: anInteger
	"Set the receiver's 'nStartPage' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_nStartPage put: anInteger! !
!OS.PRINTDLGEXW categoriesForMethods!
dwResultAction!**compiled accessors**!public! !
dwResultAction:!**compiled accessors**!public! !
ExclusionFlags!**compiled accessors**!public! !
ExclusionFlags:!**compiled accessors**!public! !
flags!**compiled accessors**!public! !
flags:!**compiled accessors**!public! !
Flags2!**compiled accessors**!public! !
Flags2:!**compiled accessors**!public! !
hDC!**compiled accessors**!public! !
hDC:!**compiled accessors**!public! !
hDevMode!**compiled accessors**!public! !
hDevMode:!**compiled accessors**!public! !
hDevNames!**compiled accessors**!public! !
hDevNames:!**compiled accessors**!public! !
hInstance!**compiled accessors**!public! !
hInstance:!**compiled accessors**!public! !
hwndOwner!**compiled accessors**!public! !
hwndOwner:!**compiled accessors**!public! !
lpCallback!**compiled accessors**!public! !
lpCallback:!**compiled accessors**!public! !
lphPropertyPages!**compiled accessors**!public! !
lphPropertyPages:!**compiled accessors**!public! !
lpPageRanges!**compiled accessors**!public! !
lpPageRanges:!**compiled accessors**!public! !
lpPrintTemplateName!**compiled accessors**!public! !
lpPrintTemplateName:!**compiled accessors**!public! !
lStructSize!**compiled accessors**!public! !
lStructSize:!**compiled accessors**!public! !
nCopies!**compiled accessors**!public! !
nCopies:!**compiled accessors**!public! !
nMaxPage!**compiled accessors**!public! !
nMaxPage:!**compiled accessors**!public! !
nMaxPageRanges!**compiled accessors**!public! !
nMaxPageRanges:!**compiled accessors**!public! !
nMinPage!**compiled accessors**!public! !
nMinPage:!**compiled accessors**!public! !
nPageRanges!**compiled accessors**!public! !
nPageRanges:!**compiled accessors**!public! !
nPropertyPages!**compiled accessors**!public! !
nPropertyPages:!**compiled accessors**!public! !
nStartPage!**compiled accessors**!public! !
nStartPage:!**compiled accessors**!public! !
!

!OS.PRINTDLGEXW class methodsFor!

defineFields
	"Define the fields of the PRINTDLGEX structure.

	self compileDefinition

		typedef [uuid(46F06E70-1BB5-4B02-98EE-6AB442F3B43F)]
		struct tagPRINTDLGEX {
			DWORD lStructSize;
			HWND hwndOwner;
			HGLOBAL hDevMode;
			HGLOBAL hDevNames;
			HDC HDC;
			DWORD flags;
			DWORD Flags2;
			DWORD ExclusionFlags;
			DWORD nPageRanges;
			DWORD nMaxPageRanges;
			PRINTPAGERANGE* lpPageRanges;
			DWORD nMinPage;
			DWORD nMaxPage;
			DWORD nCopies;
			HINSTANCE HINSTANCE;
			LPCSTR lpPrintTemplateName;
			IUnknown* lpCallback;
			DWORD nPropertyPages;
			HPROPSHEETPAGE* lphPropertyPages;
			DWORD nStartPage;
			DWORD dwResultAction;
		} PRINTDLGEX;
"

	self
		defineField: #lStructSize type: DWORDField new;
		defineField: #hwndOwner type: HANDLEField new;
		defineField: #hDevMode type: HANDLEField new;
		defineField: #hDevNames type: HANDLEField new;
		defineField: #hDC type: HANDLEField new;
		defineField: #flags type: DWORDField new;
		defineField: #Flags2 type: DWORDField new;
		defineField: #ExclusionFlags type: DWORDField new;
		defineField: #nPageRanges type: DWORDField new;
		defineField: #nMaxPageRanges type: DWORDField new;
		defineField: #lpPageRanges type: (PointerField type: PRINTPAGERANGE);
		defineField: #nMinPage type: DWORDField new;
		defineField: #nMaxPage type: DWORDField new;
		defineField: #nCopies type: DWORDField new;
		defineField: #hInstance type: HANDLEField new;
		defineField: #lpPrintTemplateName type: (PointerField type: Utf16String);
		defineField: #lpCallback type: (PointerField type: COM.IUnknown);
		defineField: #nPropertyPages type: DWORDField new;
		defineField: #lphPropertyPages type: (PointerField type: Handle);
		defineField: #nStartPage type: DWORDField new;
		defineField: #dwResultAction type: DWORDField new!

getFieldNames
	^#(#lStructSize #hwndOwner #hDevMode #hDevNames #hDC #flags #Flags2 #ExclusionFlags #nPageRanges #nMaxPageRanges #lpPageRanges #nMinPage #nMaxPage #nCopies #hInstance #lpPrintTemplateName #lpCallback #nPropertyPages #lphPropertyPages #nStartPage #dwResultAction)! !
!OS.PRINTDLGEXW class categoriesForMethods!
defineFields!**auto generated**!public!template definition! !
getFieldNames!**compiled accessors**!constants!private! !
!

