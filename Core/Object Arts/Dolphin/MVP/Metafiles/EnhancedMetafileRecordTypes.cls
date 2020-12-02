﻿"Filed out from Dolphin Smalltalk 7"!

SharedPool subclass: #EnhancedMetafileRecordTypes
	instanceVariableNames: ''
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {
		'EMR_ABORTPATH' -> 16r44.
		'EMR_ALPHABLEND' -> 16r72.
		'EMR_ANGLEARC' -> 16r29.
		'EMR_ARC' -> 16r2D.
		'EMR_ARCTO' -> 16r37.
		'EMR_BEGINPATH' -> 16r3B.
		'EMR_BITBLT' -> 16r4C.
		'EMR_CHORD' -> 16r2E.
		'EMR_CLOSEFIGURE' -> 16r3D.
		'EMR_COLORCORRECTPALETTE' -> 16r6F.
		'EMR_COLORMATCHTOTARGETW' -> 16r79.
		'EMR_CREATEBRUSHINDIRECT' -> 16r27.
		'EMR_CREATECOLORSPACE' -> 16r63.
		'EMR_CREATECOLORSPACEW' -> 16r7A.
		'EMR_CREATEDIBPATTERNBRUSHPT' -> 16r5E.
		'EMR_CREATEMONOBRUSH' -> 16r5D.
		'EMR_CREATEPALETTE' -> 16r31.
		'EMR_CREATEPEN' -> 16r26.
		'EMR_DELETECOLORSPACE' -> 16r65.
		'EMR_DELETEOBJECT' -> 16r28.
		'EMR_ELLIPSE' -> 16r2A.
		'EMR_ENDPATH' -> 16r3C.
		'EMR_EOF' -> 16rE.
		'EMR_EXCLUDECLIPRECT' -> 16r1D.
		'EMR_EXTCREATEFONTINDIRECTW' -> 16r52.
		'EMR_EXTCREATEPEN' -> 16r5F.
		'EMR_EXTFLOODFILL' -> 16r35.
		'EMR_EXTSELECTCLIPRGN' -> 16r4B.
		'EMR_EXTTEXTOUTA' -> 16r53.
		'EMR_EXTTEXTOUTW' -> 16r54.
		'EMR_FILLPATH' -> 16r3E.
		'EMR_FILLRGN' -> 16r47.
		'EMR_FLATTENPATH' -> 16r41.
		'EMR_FRAMERGN' -> 16r48.
		'EMR_GDICOMMENT' -> 16r46.
		'EMR_GLSBOUNDEDRECORD' -> 16r67.
		'EMR_GLSRECORD' -> 16r66.
		'EMR_GRADIENTFILL' -> 16r76.
		'EMR_HEADER' -> 16r1.
		'EMR_INTERSECTCLIPRECT' -> 16r1E.
		'EMR_INVERTRGN' -> 16r49.
		'EMR_LINETO' -> 16r36.
		'EMR_MASKBLT' -> 16r4E.
		'EMR_MAX' -> 16r7A.
		'EMR_MIN' -> 16r1.
		'EMR_MODIFYWORLDTRANSFORM' -> 16r24.
		'EMR_MOVETOEX' -> 16r1B.
		'EMR_OFFSETCLIPRGN' -> 16r1A.
		'EMR_PAINTRGN' -> 16r4A.
		'EMR_PIE' -> 16r2F.
		'EMR_PIXELFORMAT' -> 16r68.
		'EMR_PLGBLT' -> 16r4F.
		'EMR_POLYBEZIER' -> 16r2.
		'EMR_POLYBEZIER16' -> 16r55.
		'EMR_POLYBEZIERTO' -> 16r5.
		'EMR_POLYBEZIERTO16' -> 16r58.
		'EMR_POLYDRAW' -> 16r38.
		'EMR_POLYDRAW16' -> 16r5C.
		'EMR_POLYGON' -> 16r3.
		'EMR_POLYGON16' -> 16r56.
		'EMR_POLYLINE' -> 16r4.
		'EMR_POLYLINE16' -> 16r57.
		'EMR_POLYLINETO' -> 16r6.
		'EMR_POLYLINETO16' -> 16r59.
		'EMR_POLYPOLYGON' -> 16r8.
		'EMR_POLYPOLYGON16' -> 16r5B.
		'EMR_POLYPOLYLINE' -> 16r7.
		'EMR_POLYPOLYLINE16' -> 16r5A.
		'EMR_POLYTEXTOUTA' -> 16r60.
		'EMR_POLYTEXTOUTW' -> 16r61.
		'EMR_REALIZEPALETTE' -> 16r34.
		'EMR_RECTANGLE' -> 16r2B.
		'EMR_RESERVED_105' -> 16r69.
		'EMR_RESERVED_106' -> 16r6A.
		'EMR_RESERVED_107' -> 16r6B.
		'EMR_RESERVED_108' -> 16r6C.
		'EMR_RESERVED_109' -> 16r6D.
		'EMR_RESERVED_110' -> 16r6E.
		'EMR_RESERVED_117' -> 16r75.
		'EMR_RESERVED_119' -> 16r77.
		'EMR_RESERVED_120' -> 16r78.
		'EMR_RESIZEPALETTE' -> 16r33.
		'EMR_RESTOREDC' -> 16r22.
		'EMR_ROUNDRECT' -> 16r2C.
		'EMR_SAVEDC' -> 16r21.
		'EMR_SCALEVIEWPORTEXTEX' -> 16r1F.
		'EMR_SCALEWINDOWEXTEX' -> 16r20.
		'EMR_SELECTCLIPPATH' -> 16r43.
		'EMR_SELECTOBJECT' -> 16r25.
		'EMR_SELECTPALETTE' -> 16r30.
		'EMR_SETARCDIRECTION' -> 16r39.
		'EMR_SETBKCOLOR' -> 16r19.
		'EMR_SETBKMODE' -> 16r12.
		'EMR_SETBRUSHORGEX' -> 16rD.
		'EMR_SETCOLORADJUSTMENT' -> 16r17.
		'EMR_SETCOLORSPACE' -> 16r64.
		'EMR_SETDIBITSTODEVICE' -> 16r50.
		'EMR_SETICMMODE' -> 16r62.
		'EMR_SETICMPROFILEA' -> 16r70.
		'EMR_SETICMPROFILEW' -> 16r71.
		'EMR_SETLAYOUT' -> 16r73.
		'EMR_SETMAPMODE' -> 16r11.
		'EMR_SETMAPPERFLAGS' -> 16r10.
		'EMR_SETMETARGN' -> 16r1C.
		'EMR_SETMITERLIMIT' -> 16r3A.
		'EMR_SETPALETTEENTRIES' -> 16r32.
		'EMR_SETPIXELV' -> 16rF.
		'EMR_SETPOLYFILLMODE' -> 16r13.
		'EMR_SETROP2' -> 16r14.
		'EMR_SETSTRETCHBLTMODE' -> 16r15.
		'EMR_SETTEXTALIGN' -> 16r16.
		'EMR_SETTEXTCOLOR' -> 16r18.
		'EMR_SETVIEWPORTEXTEX' -> 16rB.
		'EMR_SETVIEWPORTORGEX' -> 16rC.
		'EMR_SETWINDOWEXTEX' -> 16r9.
		'EMR_SETWINDOWORGEX' -> 16rA.
		'EMR_SETWORLDTRANSFORM' -> 16r23.
		'EMR_STRETCHBLT' -> 16r4D.
		'EMR_STRETCHDIBITS' -> 16r51.
		'EMR_STROKEANDFILLPATH' -> 16r3F.
		'EMR_STROKEPATH' -> 16r40.
		'EMR_TRANSPARENTBLT' -> 16r74.
		'EMR_WIDENPATH' -> 16r42
	}!
EnhancedMetafileRecordTypes guid: (GUID fromString: '{c7e0098e-0256-4501-8c4c-ff3e15338278}')!
EnhancedMetafileRecordTypes comment: ''!
!EnhancedMetafileRecordTypes categoriesForClass!Unclassified! !