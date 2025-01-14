Class {
	#name : 'BlUndestroyableBrickElement',
	#superclass : 'BlBrickElement',
	#category : 'BlBreakOut-Core',
	#package : 'BlBreakOut',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
BlUndestroyableBrickElement class >> descriptionCharacter [

	^ $U
]

{ #category : 'testing' }
BlUndestroyableBrickElement class >> isDestroyable [

	^ false
]

{ #category : 'as yet unclassified' }
BlUndestroyableBrickElement >> actionWhenBumped [
"we do nothing - original tutorial include sounds, not this version"
"(SampledSound soundNamed: ’clink’) play"
]

{ #category : 'initialization' }
BlUndestroyableBrickElement >> initialize [
	"self new openInNewSpace"

	super initialize.
	self
		geometry: BlRectangleGeometry new;
		size: self brickSize;
		background:  (Color r: 0.6 g: 1.0 b: 1.0);
		border: (BlBorder paint: (Color r: 0.3 g: 1.0 b: 1.0) width: 4);
		effect: (BlGaussianShadowEffect color: Color black offset: 0@0 width: 2)
]
