﻿"Filed out from Dolphin Smalltalk"!

External.DynamicLinkLibrary subclass: #'OS.AdvApiLibrary'
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!
OS.AdvApiLibrary guid: (Core.GUID fromString: '{64674054-3a82-101b-8181-00aa003743d3}')!
OS.AdvApiLibrary comment: 'AdvApiLibrary is the <ExternalLibrary> class to represent the Win32 system DLL, ADVAPI32.DLL.

This DLL contains functions mainly to do with accessing the registry, high-level access to which is available via Dolphin''s Registry Access package.
'!
!OS.AdvApiLibrary categoriesForClass!External-Libraries-Win32! !
!OS.AdvApiLibrary methodsFor!

deregisterEventSource: anExternalHandle
	<stdcall: bool DeregisterEventSource handle>
	^self invalidCall: _failureCode!

getUserName: buffer nSize: pBufSize
	"Retrieve the user name of the current thread. This is the name of the user currently 
	logged onto the system. 
		BOOL GetUserName(
  			LPTSTR lpBuffer,	// address of name buffer 
			LPDWORD nSize 		// address of size of name buffer 
		);"

	<stdcall: bool GetUserNameW lpwstr dword*>
	^self invalidCall: _failureCode!

isTextUnicode: lpv iSize: iSize lpiResult: lpiResult
	"
	BOOL IsTextUnicode(
		_In_        const VOID  *lpv,
		_In_              int   iSize,
	_Inout_opt_       LPINT lpiResult
	);
	"

	<stdcall: bool IsTextUnicode lpvoid sdword sdword*>
	^self invalidCall: _failureCode!

reportEvent: hEventLog wType: wType wCategory: wCategory dwEventId: dwEventId lpUserSid: lpUserSid wNumStrings: wNumStrings dwDataSize: dwDataSize lpStrings: lpStrings lpRawData: lpRawData
	"
		BOOL ReportEvent(
			HANDLE hEventLog,	// handle returned by RegisterEventSource 
			WORD wType,		// event type to log 
			WORD wCategory,	// event category 
			DWORD dwEventID,	// event identifier 
			PSID lpUserSid,		// user security identifier (optional) 
			WORD wNumStrings,	// number of strings to merge with message  
			DWORD dwDataSize,	// size of binary data, in bytes
			LPCWSTR *lpStrings,	// array of strings to merge with message 
			LPVOID lpRawData 	// address of binary data 
		);"

	<stdcall: bool ReportEventW handle word word dword lpvoid word dword lpvoid lpvoid>
	^self invalidCall: _failureCode! !
!OS.AdvApiLibrary categoriesForMethods!
deregisterEventSource:!public!win32 functions-events! !
getUserName:nSize:!public!win32 functions-system information! !
isTextUnicode:iSize:lpiResult:!public!win32 functions-unicode and character set! !
reportEvent:wType:wCategory:dwEventId:lpUserSid:wNumStrings:dwDataSize:lpStrings:lpRawData:!public!win32 functions-events! !
!

!OS.AdvApiLibrary class methodsFor!

fileName
	"Answer the host system file name for the library"

	^'ADVAPI32'!

sharedVariableName
	^#{AdvApi32}! !
!OS.AdvApiLibrary class categoriesForMethods!
fileName!constants!public! !
sharedVariableName!constants!private! !
!

