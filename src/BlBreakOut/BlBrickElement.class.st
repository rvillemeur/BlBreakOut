"
```smalltalk
BlBrickElement new openInNewSpace
```
"
Class {
	#name : 'BlBrickElement',
	#superclass : 'BlElement',
	#category : 'BlBreakOut',
	#package : 'BlBreakOut'
}

{ #category : 'as yet unclassified' }
BlBrickElement class >> defaultBrickSize [

	^ 71 @ 15
]

{ #category : 'as yet unclassified' }
BlBrickElement class >> descriptionCharacter [

	^ $S
]

{ #category : 'action  handling' }
BlBrickElement >> actionWhenBumpedBy: aBall [

	aBall bounceTopBottom.
	self parent increaseScoreBy: 10.
	self parent removeBrick: self.
	self parent removeChild: self.
]

{ #category : 'initialization' }
BlBrickElement >> brickSize [

	^ self class defaultBrickSize
]

{ #category : 'initialization' }
BlBrickElement >> initialize [
	"self new openInNewSpace"

	super initialize.
	self
		geometry: BlRectangleGeometry new;
		size: self brickSize;
		background: (Color red alpha: 0.5);
		border: (BlBorder paint: Color red width: 4);
		effect: (BlGaussianShadowEffect color: Color black offset: 0@0 width: 2)
]
