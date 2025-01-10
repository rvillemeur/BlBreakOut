Class {
	#name : 'BlResistantBrickElement',
	#superclass : 'BlBrickElement',
	#instVars : [
		'resistanceNumber'
	],
	#category : 'BlBreakOut',
	#package : 'BlBreakOut'
}

{ #category : 'as yet unclassified' }
BlResistantBrickElement class >> descriptionCharacter [

	^ $X
]

{ #category : 'action  handling' }
BlResistantBrickElement >> actionWhenBumpedBy: aBall [

	self decreaseResistanceNumber.
	self feedbackHitDecrease.
	resistanceNumber isZero
		ifTrue: [ super actionWhenBumpedBy: aBall ]
		ifFalse: [ aBall bounceTopBottom ]
]

{ #category : 'as yet unclassified' }
BlResistantBrickElement >> decreaseResistanceNumber [

	resistanceNumber := resistanceNumber - 1
]

{ #category : 'as yet unclassified' }
BlResistantBrickElement >> feedbackHitDecrease [

	self background: (Color gray alpha: (1 - (resistanceNumber * 0.3)))
]

{ #category : 'initialization' }
BlResistantBrickElement >> initialize [
	"self new openInNewSpace"

	super initialize.
	self
		geometry: BlRectangleGeometry new;
		size: self brickSize;
		background: (Color gray alpha: 1);
		border: (BlBorder paint: Color gray width: 4);
		effect: (BlGaussianShadowEffect color: Color black offset: 0@0 width: 2).
	resistanceNumber := 3.
]
