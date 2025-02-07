"
Very simple LED widget using Digital7_mono font. The font has been loaded in the image.

You can specify how many digit you want to display with `textPadding`.

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
			c vertical matchParent ];
		effect: (BlGaussianShadowEffect
				 color: (Color gray alpha: 1.0)
				 offset: 0 @ 0
				 width: 4).
	label := BlTextElement new.
	label text: ('1234567890' asRopedText
			 fontName: 'Digital-7 Mono';
			 foreground: Color green;
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
