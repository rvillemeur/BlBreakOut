"
Initial test:

```smalltalk
BlBallElement new openInNewSpace
```
"
Class {
	#name : 'BlBallElement',
	#superclass : 'BlElement',
	#instVars : [
		'speed',
		'direction'
	],
	#category : 'BlBreakOut',
	#package : 'BlBreakOut'
}

{ #category : 'accessing' }
BlBallElement >> animation [

	| animation |
	animation := BlAnimation new
		             beInfinite;
		             duration: 50 milliSeconds.

	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :anEvent |
			 self position: self position + (speed * direction) ]).

	^ animation
]

{ #category : 'accessing' }
BlBallElement >> direction: aPoint [

	direction := aPoint
]

{ #category : 'initialization' }
BlBallElement >> initialize [

	super initialize.
	self
		geometry: (BlCircleGeometry new matchExtent: 9 @ 9);
		size: 9 @ 9;
		background: Color yellow;
		border: (BlBorder paint: Color black width: 1);
		addAnimation: self animation.
	speed := 3.
	direction := 1 @ 1
]
