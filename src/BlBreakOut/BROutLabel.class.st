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
	label text: ('label' asRopedText
			 fontSize: 50;
			 yourself).

	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: label.
]

{ #category : 'accessing' }
BROutLabel >> label [

	^ label
]

{ #category : 'accessing' }
BROutLabel >> label: anObject [

	label text: (anObject asRopedText
			 fontSize: 50;
			 yourself)
]
