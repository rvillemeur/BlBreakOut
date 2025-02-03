"
`AeFontManager globalInstance scanDirectory: 'C:\devzone\BlBreakOut\assets\font' asFileReference.`

you can load a directory with fonts (e.g. .ttf and .otf files) this way: 
`AeFontManager globalInstance scanDirectory: '../../fonts' asFileReference`

There is also 
`AeFontManager globalInstance scanDefaultDirectories`
which takes a second to find font files in the typical font directories in current platform (OS)

For example, say you have a font called ""Minecraft"" in a relative directory. 
This font has only ""Medium"" type (this is important, too):

```smalltalk 
AeFontManager globalInstance scanDirectory: '../../fonts' asFileReference.

BlTextElement new
    text: ('Hola, Bonjour, Hello!' asRopedText
            fontName: 'Minecraft' ""<--- family name"";
            medium; ""<--- weight""
            fontSize: 50;
            yourself);
    openInNewSpace.
```

Reset font after image restart:
```smalltalk
AeFontManager resetGlobalInstance.
AeFontManager globalInstance scanDirectory: AeFilesystemResources fontsDirectory
```
"
Class {
	#name : 'BROutLEDText',
	#superclass : 'BlElement',
	#instVars : [
		'label',
		'textPadding'
	],
	#category : 'BlBreakOut-Helper',
	#package : 'BlBreakOut',
	#tag : 'Helper'
}

{ #category : 'initialization' }
BROutLEDText >> initialize [
	"AeFontManager globalInstance scanDirectory: 'C:\devzone\BlBreakOut\assets\font' asFileReference."

"trick
when I set the Digital-7 mono family name and set the medium weight, then by default it will lookup for a Digital-7 regular weight font, it won't find it (the TTF only comes with a Medium weight face), and then will use the default font (source sans) ."
	super initialize.
	textPadding :=10.
	self
		geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
		background: Color black;
		border: (BlBorder paint: Color darkGray width: 4);
		layout: BlFrameLayout new;
		padding: (BlInsets all: 10);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		effect: (BlGaussianShadowEffect
				 color: (Color gray alpha: 1.0)
				 offset: 0 @ 0
				 width: 4).
	label := BlTextElement new.
	label text: ('1234567890' asRopedText
			 fontName: 'Digital-7 Mono';
			 foreground: Color green;
			 fontSize: 50;
			 yourself).
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: label
]

{ #category : 'accessing' }
BROutLEDText >> label [

	^ label
]

{ #category : 'accessing' }
BROutLEDText >> label: aText [

	| mask |
	mask := '0000000000' , aText.

	label text: ((mask last: textPadding ) asRopedText
			 fontName: 'Digital-7 Mono';
			 foreground: Color green;
			 fontSize: 50;
			 yourself).
]

{ #category : 'accessing' }
BROutLEDText >> textPadding [

	^ textPadding
]

{ #category : 'accessing' }
BROutLEDText >> textPadding: anObject [

	textPadding := anObject
]
