"
Special kind of brick that need to be hit `resistanceNumber` to be destroyed
"
Class {
	#name : 'BlResistantBrickElement',
	#superclass : 'BlBrickElement',
	#instVars : [
		'resistanceNumber'
	],
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
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

{ #category : 'feedback' }
BlResistantBrickElement >> destructionAnimation [
	"Return the animation played when the receiver is destroyed"

	^ (BlTransformAnimation scale: 0 @ 0)
		  duration: 300 milliSeconds;
		  yourself
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
		extent: self brickSize;
		background: (Color gray alpha: 1);
		border: (BlBorder paint: Color gray width: 4);
		effect: (BlGaussianShadowEffect color: Color black offset: 0@0 width: 2).
	resistanceNumber := 3.
]
