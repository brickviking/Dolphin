﻿"Filed out from Dolphin Smalltalk"!

External.Structure subclass: #'OS.MIB_TCPROW'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'_OffsetOf_dwLocalAddr' -> 16r4.
		'_OffsetOf_dwLocalPort' -> 16r8.
		'_OffsetOf_dwRemoteAddr' -> 16rC.
		'_OffsetOf_dwRemotePort' -> 16r10.
		'_OffsetOf_dwState' -> 16r0
	}!
OS.MIB_TCPROW guid: (Core.GUID fromString: '{f066336f-3aa1-4146-8b59-29b9f4cd065b}')!
OS.MIB_TCPROW comment: '<MIB_TCPROW> is an <ExternalStructure> class to wrap the struct ''Win32.MIB_TCPROW'' from type information in the ''Win32 API (ANSI). Derived from Bruce McKinney´s Hardcore Visual Basic Type Library'' library.

The type library contains no documentation for this struct

Warning: This comment was automatically generated from the struct''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

typedef 
struct tagMIB_TCPROW {
	unsigned long dwState;
	unsigned long dwLocalAddr;
	unsigned long dwLocalPort;
	unsigned long dwRemoteAddr;
	unsigned long dwRemotePort;
} MIB_TCPROW;
'!
!OS.MIB_TCPROW categoriesForClass!Win32-Structs! !
!OS.MIB_TCPROW methodsFor!

displayOn: aPuttableStream
	"Append to the <puttableStream> first argument a String whose characters are a representation of the receiver that an end-user might want to see."

	aPuttableStream
		display: self port;
		nextPut: $:;
		display: self portName!

dwLocalAddr
	"Answer the <Integer> value of the receiver's 'dwLocalAddr' field."

	^bytes dwordAtOffset: _OffsetOf_dwLocalAddr!

dwLocalPort
	"Answer the <Integer> value of the receiver's 'dwLocalPort' field."

	^bytes dwordAtOffset: _OffsetOf_dwLocalPort!

dwRemoteAddr
	"Answer the <Integer> value of the receiver's 'dwRemoteAddr' field."

	^bytes dwordAtOffset: _OffsetOf_dwRemoteAddr!

dwRemotePort
	"Answer the <Integer> value of the receiver's 'dwRemotePort' field."

	^bytes dwordAtOffset: _OffsetOf_dwRemotePort!

dwState
	"Answer the <Integer> value of the receiver's 'dwState' field."

	^bytes dwordAtOffset: _OffsetOf_dwState!

port
	^Ws2_32 htons: self dwLocalPort lowWord!

portName
	| psrvent |
	psrvent := Ws2_32 getservbyport: self dwLocalPort proto: 'tcp'.
	^psrvent isNull ifFalse: [psrvent s_name]! !
!OS.MIB_TCPROW categoriesForMethods!
displayOn:!public! !
dwLocalAddr!**compiled accessors**!public! !
dwLocalPort!**compiled accessors**!public! !
dwRemoteAddr!**compiled accessors**!public! !
dwRemotePort!**compiled accessors**!public! !
dwState!**compiled accessors**!public! !
port!accessing!public! !
portName!accessing!public! !
!

!OS.MIB_TCPROW class methodsFor!

defineFields
	"Define the fields of the MIB_TCPROW structure.
		MIB_TCPROW compileDefinition
	
		typedef 
		struct tagMIB_TCPROW {
			unsigned long dwState;
			unsigned long dwLocalAddr;
			unsigned long dwLocalPort;
			unsigned long dwRemoteAddr;
			unsigned long dwRemotePort;
		} MIB_TCPROW;
"

	self
		defineField: #dwState
			type: DWORDField readOnly
			offset: 0;
		defineField: #dwLocalAddr
			type: DWORDField readOnly
			offset: 4;
		defineField: #dwLocalPort
			type: DWORDField readOnly
			offset: 8;
		defineField: #dwRemoteAddr
			type: DWORDField readOnly
			offset: 12;
		defineField: #dwRemotePort
			type: DWORDField readOnly
			offset: 16.
	self byteSize: 20!

getFieldNames
	^#(#dwState #dwLocalAddr #dwLocalPort #dwRemoteAddr #dwRemotePort)! !
!OS.MIB_TCPROW class categoriesForMethods!
defineFields!initializing!public! !
getFieldNames!**compiled accessors**!constants!private! !
!

