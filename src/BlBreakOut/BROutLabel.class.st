"
Very simple label, created to help position text in the score bar of the game.
"
Class {
	#name : 'BROutLabel',
	#superclass : 'BlElement',
	#instVars : [
		'label'
	],
	#category : 'BlBreakOut-Helper',
	#package : 'BlBreakOut',
	#tag : 'Helper'
}

{ #category : 'initialization' }
BROutLabel >> initialize [

	super initialize.
	self
		geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
		layout: BlFrameLayout new;
		padding: (BlInsets all: 10);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical matchParent ].

	label := BlTextElement new.
	label text: 'label' asRopedText.

	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
		"c horizontal matchParent.
			c vertical matchParent"].
	self addChild: label.
]

{ #category : 'accessing' }
BROutLabel >> label [

	^ label
]

{ #category : 'accessing' }
BROutLabel >> label: anObject [

	label text: anObject asRopedText
]
