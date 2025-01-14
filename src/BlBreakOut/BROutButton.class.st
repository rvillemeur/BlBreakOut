"
A very simple button, used for BreakOut game
"
Class {
	#name : 'BROutButton',
	#superclass : 'BlElement',
	#instVars : [
		'label',
		'action'
	],
	#category : 'BlBreakOut-Helper',
	#package : 'BlBreakOut',
	#tag : 'Helper'
}

{ #category : 'accessing' }
BROutButton >> action: anObject [

	action := anObject
]

{ #category : 'initialization' }
BROutButton >> initialize [
	super initialize.
	self
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
	label := BlTextElement new.
	label text: 'label' asRopedText.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: label.
	self
		addEventHandlerOn: BlClickEvent 
		do: [ action value].
]

{ #category : 'accessing' }
BROutButton >> label [

	^ label
]

{ #category : 'accessing' }
BROutButton >> label: aText [

		label text: aText asRopedText.
]
