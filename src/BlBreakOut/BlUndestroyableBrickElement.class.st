"
Special kind of brick that cannot be destroyed
"
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
BlUndestroyableBrickElement >> actionWhenBumpedBy: aBall [
"we do nothing - original tutorial include sounds, not this version"
"(SampledSound soundNamed: ’clink’) play"

	self flash.
	aBall bounceTopBottom.
	self parent increaseScoreBy: 10.
]

{ #category : 'feedback' }
BlUndestroyableBrickElement >> flash [
	"Make the receiver blink, as a visual feedback"

	self opacity: 0.3.
	self addAnimation: (BlOpacityAnimation new
			 opacity: 1;
			 duration: 200 milliSeconds)
]

{ #category : 'initialization' }
BlUndestroyableBrickElement >> initialize [
	"self new openInNewSpace"

	super initialize.
	self
		geometry: BlRectangleGeometry new;
		extent: self brickSize;
		background:  (Color r: 0.6 g: 1.0 b: 1.0);
		border: (BlBorder paint: (Color r: 0.3 g: 1.0 b: 1.0) width: 4);
		effect: (BlGaussianShadowEffect color: Color black offset: 0@0 width: 2)
]
