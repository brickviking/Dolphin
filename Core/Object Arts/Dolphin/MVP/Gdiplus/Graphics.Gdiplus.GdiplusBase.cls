﻿"Filed out from Dolphin Smalltalk"!

Graphics.GraphicsTool subclass: #'Graphics.Gdiplus.GdiplusBase'
	instanceVariableNames: 'initializer'
	classVariableNames: ''
	imports: #(#{Graphics.Gdiplus.GdiplusGUIDs})
	classInstanceVariableNames: ''
	classConstants: {}!
Graphics.Gdiplus.GdiplusBase guid: (Core.GUID fromString: '{9368410d-787c-4331-994e-9bc2c3f0fe46}')!
Graphics.Gdiplus.GdiplusBase isNonInstantiable: true!
Graphics.Gdiplus.GdiplusBase comment: 'GdiplusBase is an abstract class that represents the Win32 GDI+ GdiplusBase class.  Instances of this class contain a reference to an initializer which creates the Win32 object - see #createHandle.  In most cases, the initializer can also recreate the instance, though not all can (see #isPersistent), and recreation of an instance does not guarantee the instance will be at the same state as when it was freed.

Since instances of this hierarchy have no (or few) instance variables, most state information is accessed directly through calls to Win32 GDI+ functions.  In some cases, calls are made to the initializer which, as mentioned, does reference instance variables.

Win32 constants, enumerations, and GUIDs are contained in the pool dictionaries GdiplusConstants and GdiplusGUIDs.  GdiplusBase class has helper methods that answer the subsets of constants for a particular Win32 type of constant (e.g., #enumsStringFormatFlags and #guidsEncoder).'!
!Graphics.Gdiplus.GdiplusBase categoriesForClass!Unclassified! !
!Graphics.Gdiplus.GdiplusBase methodsFor!

= anObject
	"Answer whether the receiver and anObject are equivalent."

	"SW - What does it mean for Gdiplus objects to be equal? 
	  -This tests whether the objects are constructed equal, however that can change during the lifetime of the objects.
		-Do we need a #equalityDirty flag?"

	self == anObject ifTrue: [^true].
	^self class == anObject class and: [initializer = anObject initializer]!

basicFree
	"Private - Free up external resources held by the receiver.  Ignore any errors which might arise."

	self subclassResponsibility!

copy
	^self class fromInitializer: initializer!

createHandle
	"Private - Create and answer an external resource handle associated with the receiver."

	^initializer createHandle!

hash
	^initializer hash!

initializer
	^initializer!

initializer: aGdiplusInitializer
	initializer := aGdiplusInitializer!

isPersistent
	"Private - Answer true if the receiver holds sufficient information such that
		it can recreate itself 
	 - ask the receiver's initializer"

	^initializer isPersistent!

printOn: aStream 
	"Append a developer friendly textual representation of the receiver to aStream."

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: handle;
		nextPut: $)!

setInitializer: aGdiplusInitializer
	self initialize.
	initializer := aGdiplusInitializer.
	^self! !
!Graphics.Gdiplus.GdiplusBase categoriesForMethods!
=!comparison!public! !
basicFree!private!realizing/unrealizing! !
copy!copying!public! !
createHandle!private!realizing/unrealizing! !
hash!comparison!public! !
initializer!accessing!public! !
initializer:!accessing!public! !
isPersistent!private!testing! !
printOn:!printing!public! !
setInitializer:!initializing!private! !
!

!Graphics.Gdiplus.GdiplusBase class methodsFor!

enumsColorAdjustType
	"Answer a key-value collection of Win32 ColorAdjustType enumerated types.
	These specify which Gdiplus objects use color-adjustment information."

	^self enumsWithPrefix: 'ColorAdjustType'!

enumsColorChannelFlags
	"Answer a key-value collection of Win32 ColorChannelFlags enumerated types.
	These specify individual channels in the CMYK (cyan, magenta, yellow, black) color space."

	^self enumsWithPrefix: 'ColorChannelFlags'!

enumsColorMatrixFlags
	"Answer a key-value collection of Win32 ColorMatrixFlags enumerated types.
	These specify the types of images and colors that will be affected by color and grayscale adjustment settings."

	^self enumsWithPrefix: 'ColorMatrixFlags'!

enumsCombineMode
	"Answer a key-value collection of Win32 CombineMode enumerated types.
	These specify how a new region is combined with an existing region."

	^self enumsWithPrefix: 'CombineMode'!

enumsCompositingMode
	"Answer a key-value collection of Win32 CompositingMode enumerated types.
	These specify how rendered colors are combined with background colors."

	^self enumsWithPrefix: 'CompositingMode'!

enumsCompositingQuality
	"Answer a key-value collection of Win32 CompositingQuality enumerated types.
	These specify whether gamma correction is applied when colors are blended with background colors."

	^self enumsWithPrefix: 'CompositingQuality'!

enumsDashCap
	"Answer a key-value collection of Win32 DashCap enumerated types.
	These specify the type of graphic shape to use on both ends of each dash in a dashed line."

	^self enumsWithPrefix: 'DashCap'!

enumsDashStyle
	"Answer a key-value collection of Win32 DashStyle enumerated types.
	These specify the line style, including custom, of a line drawn with a pen."

	^self enumsWithPrefix: 'DashStyle'!

enumsEncoderParameterValueType
	"Answer a key-value collection of Win32 EncoderParameterValueType enumerated types.
	These specify data types for image codec (encoder/decoder) parameters."

	^self enumsWithPrefix: 'EncoderParameterValueType'!

enumsEncoderValue
	"Answer a key-value collection of Win32 EncoderValue enumerated types.
	These specify values that can be passed as arguments to image encoders."

	^self enumsWithPrefix: 'EncoderValue'!

enumsFillMode
	"Answer a key-value collection of Win32 FillMode enumerated types.
	These specify how to fill areas that are formed when a path or curve intersects itself."

	^self enumsWithPrefix: 'FillMode'!

enumsFlushIntention
	"Answer a key-value collection of Win32 FlushIntention enumerated types.
	These specify when to flush the queue of graphics operations."

	^self enumsWithPrefix: 'FlushIntention'!

enumsFontStyle
	"Answer a key-value collection of Win32 FontStyle enumerated types.
	These specify the style of the typeface of a font. Styles can be combined."

	^self enumsWithPrefix: 'FontStyle'!

enumsHatchStyle
	"Answer a key-value collection of Win32 HatchStyle enumerated types.
	These specify the hatch pattern used by a HatchBrush. The hatch pattern consists of a solid 
	background color and lines drawn over the background."

	^self enumsWithPrefix: 'HatchStyle'!

enumsImageFlags
	"Answer a key-value collection of Win32 ImageFlags enumerated types.
	These specify the attributes of the pixel data contained in a GdiplusImage object."

	^self enumsWithPrefix: 'ImageFlags'!

enumsImageType
	"Answer a key-value collection of Win32 ImageType enumerated types.
	These indicate whether an image is a bitmap or a metafile."

	^self enumsWithPrefix: 'ImageType'!

enumsInterpolationMode
	"Answer a key-value collection of Win32 InterpolationMode enumerated types.
	These specify the algorithm that is used when images are scaled or rotated."

	^self enumsWithPrefix: 'InterpolationMode'!

enumsLinearGradientMode
	"Answer a key-value collection of Win32 LinearGradientMode enumerated types.
	These specify the direction in which the change of color occurs for a linear gradient brush."

	^self enumsWithPrefix: 'LinearGradientMode'!

enumsLineCap
	"Answer a key-value collection of Win32 LineCap enumerated types.
	These specify the shape to use on the end of a line drawn with a GdiplusPen. The cap can 
	be a square, circle, triangle, arrowhead, custom, or masked (hidden). End caps can also 
	anchor' the line by centering the cap at the end of the line."

	^self enumsWithPrefix: 'LineCap'!

enumsLineJoin
	"Answer a key-value collection of Win32 LineJoin enumerated types."

	^self enumsWithPrefix: 'LineJoin'!

enumsMatrixOrder
	"Answer a key-value collection of Win32 MatrixOrder enumerated types.
	These specify the order of multiplication when a new matrix is multiplied by an existing matrix.
	MatrixOrderPrepend specifies that the new matrix is on the left.  This is the default.
	MatrixOrderAppend specifies that the new matrix is on the right."

	^self enumsWithPrefix: 'MatrixOrder'!

enumsPathPointType
	"Answer a key-value collection of Win32 PathPointType enumerated types.
	These specify point types and flags for the data points in a path. Bits 0 through 2 indicate 
	the type of a point, and bits 3 through 7 hold a set of flags that specify attributes of a point."

	^self enumsWithPrefix: 'PathPointType'!

enumsPenAlignment
	"Answer a key-value collection of Win32 PenAlignment enumerated types.
	These specify the alignment of a pen relative to the stroke that is being drawn."

	^self enumsWithPrefix: 'PenAlignment'!

enumsPixelFormat
	"Answer a key-value collection of Win32 PixelFormat enumerated types.
	These specify various pixel formats used in bitmaps."

	^self enumsWithPrefix: 'PixelFormat'!

enumsPropertyTag
	"Answer a key-value collection of Win32 PropertyTag enumerated types.
	These specify a particular property item (e.g., camera model, title, extent) stored in an image."

	^self enumsWithPrefix: 'PropertyTag'!

enumsRotate
	"Answer a key-value collection of Win32 Rotate enumerated types.
	These specify the direction of an image's rotation and the axis used to flip the image."

	^self enumsWithPrefix: 'Rotate'!

enumsSmoothingMode
	"Answer a key-value collection of Win32 SmoothingMode enumerated types.
	These specify the type of smoothing (antialiasing) that is applied to lines and curves."

	^self enumsWithPrefix: 'SmoothingMode'!

enumsStringAlignment
	"Answer a key-value collection of Win32 StringAlignment enumerated types.
	These specify how a string is aligned in reference to a layout rectangle."

	^self enumsWithPrefix: 'StringAlignment'!

enumsStringFormatFlags
	"Answer a key-value collection of Win32 StringFormatFlags enumerated types.
	These specify text layout information (such as orientation and clipping) and display manipulations (such
	as ellipsis insertion, digit substitution, and representation of characters that are not supported by a font)."

	^self enumsWithPrefix: 'StringFormatFlags'!

enumsStringTrimming
	"Answer a key-value collection of Win32 StringTrimming enumerated types.
	These specify how to trim characters from a string so that the string fits into a layout rectangle."

	^self enumsWithPrefix: 'StringTrimming'!

enumsTextRenderingHint
	"Answer a key-value collection of Win32 TextRenderingHint enumerated types.
	These specify process used to render text. The process affects the quality of the text."

	^self enumsWithPrefix: 'TextRenderingHint'!

enumsUnit
	"Answer a key-value collection of Win32 Unit enumerated types.
	These specify the unit of measure for a given data type."

	^self enumsWithPrefix: 'Unit'!

enumsWarpMode
	"Answer a key-value collection of Win32 WarpMode enumerated types.
	These specify warp modes (e.g., perspective or bilinear) that can be used to transform images."

	^self enumsWithPrefix: 'WarpMode'!

enumsWithPrefix: aString
	"Private - Answer a key-value collection of Win32 enumerated types that begin with aString.

		self enumsWithPrefix: 'Unit'
	"

	^(Gdiplus classConstants select: [:each | each key beginsWith: aString])
		asSortedCollection: [:a :b | a value < b value]!

enumsWrapMode
	"Answer a key-value collection of Win32 WrapMode enumerated types.
	These specify how repeated copies of an image are used to tile an area."

	^self enumsWithPrefix: 'WrapMode'!

fileResource
	"Answer a TestResource that provides access to resources, e.g., disk files, for examples and testing."

	^#{Graphics.Gdiplus.Tests.FileResource} ifDefined: [:class | class current]
		ifNotDefined: 
			["If you encounter this error, you can load the test packages by evaluating: 
				SourceManager default fileIn: (FileLocator installRelative localFileSpecFor: 'RegressionTestsLoad.st')
			"
			self error: 'GdiplusTests package needs to be installed for this example to work.']!

fromInitializer: aGdiplusInitializer
	"Answer an instance of the receiver based on aspects of aGdiplusInitializer.  The instance holds
	a reference to the initializer which is expected to hold enough information to create the instance."

	^self basicNew setInitializer: aGdiplusInitializer!

guidNamesWithPrefix: aString
	"Private - Answer a GUID collection of Win32 types that begin with aString.

		self guidNamesWithPrefix: 'Encoder'
	"

	^GdiplusGUIDs keys select: [:e | e beginsWith: aString]!

guidsEncoder
	"Answer a key-value collection of Win32 Encoder GUID constants."

	^self guidsWithPrefix: 'Encoder'!

guidsFrameDimension
	"Answer a key-value collection of Win32 FrameDimension GUID string constants."

	^self guidsWithPrefix: 'FrameDimension'!

guidsWithPrefix: aString
	"Private - Answer a key-value collection of Win32 GUIDs that begin with aString.

		self guidsWithPrefix: 'Encoder'
	"

	^((self guidNamesWithPrefix: aString) collect: [:e | e -> (GdiplusGUIDs at: e)]) 
		asSortedCollection: [:a :b | a key < b key]!

showExample: anImage
	"Display anImage."

	^self showExample: anImage viewMode: #normal!

showExample: anImage viewMode: aSymbol
	"Display anImage."

	| presenter |
	presenter := UI.ImagePresenter show: 'Basic image' on: anImage.
	presenter view viewMode: aSymbol.
	presenter topShell extent: anImage extent + presenter topShell rectangle extent
				- presenter topShell clientRectangle extent.
	^presenter! !
!Graphics.Gdiplus.GdiplusBase class categoriesForMethods!
enumsColorAdjustType!constants!public! !
enumsColorChannelFlags!constants!public! !
enumsColorMatrixFlags!constants!public! !
enumsCombineMode!constants!public! !
enumsCompositingMode!constants!public! !
enumsCompositingQuality!constants!public! !
enumsDashCap!constants!public! !
enumsDashStyle!constants!public! !
enumsEncoderParameterValueType!constants!public! !
enumsEncoderValue!constants!public! !
enumsFillMode!constants!public! !
enumsFlushIntention!constants!public! !
enumsFontStyle!constants!public! !
enumsHatchStyle!constants!public! !
enumsImageFlags!constants!public! !
enumsImageType!constants!public! !
enumsInterpolationMode!constants!public! !
enumsLinearGradientMode!constants!public! !
enumsLineCap!constants!public! !
enumsLineJoin!constants!public! !
enumsMatrixOrder!constants!public! !
enumsPathPointType!constants!public! !
enumsPenAlignment!constants!public! !
enumsPixelFormat!constants!public! !
enumsPropertyTag!constants!public! !
enumsRotate!constants!public! !
enumsSmoothingMode!constants!public! !
enumsStringAlignment!constants!public! !
enumsStringFormatFlags!constants!public! !
enumsStringTrimming!constants!public! !
enumsTextRenderingHint!constants!public! !
enumsUnit!constants!public! !
enumsWarpMode!constants!public! !
enumsWithPrefix:!constants!private! !
enumsWrapMode!constants!public! !
fileResource!examples!public! !
fromInitializer:!instance creation!public! !
guidNamesWithPrefix:!constants!private! !
guidsEncoder!constants!public! !
guidsFrameDimension!constants!public! !
guidsWithPrefix:!constants!private! !
showExample:!examples!public! !
showExample:viewMode:!examples!public! !
!

