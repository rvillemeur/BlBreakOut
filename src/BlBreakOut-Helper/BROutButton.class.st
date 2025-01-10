Class {
	#name : 'BROutButton',
	#superclass : 'BlElement',
	#category : 'BlBreakOut-Helper',
	#package : 'BlBreakOut-Helper'
}

{ #category : 'initialization' }
BROutButton >> initialize [

	| inputLabel |
	BlElement new
		geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
		background: (Color red alpha: 0.2);
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
	inputLabel := BlTextElement new.
	inputLabel text: 'MyInputText' asRopedText.
	inputLabel constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: inputLabel
]
