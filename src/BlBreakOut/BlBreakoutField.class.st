"
Example

```smalltalk
BlBreakoutField new openInNewSpace
```
"
Class {
	#name : 'BlBreakoutField',
	#superclass : 'BlElement',
	#instVars : [
		'ball',
		'batter'
	],
	#category : 'BlBreakOut',
	#package : 'BlBreakOut'
}

{ #category : 'accessing' }
BlBreakoutField >> ball: aBallElement [

	ball := aBallElement.
	self addChild: aBallElement
]

{ #category : 'accessing' }
BlBreakoutField >> batter: aBatterElement [
	"Add the batter as contained by the receiver"

	batter := aBatterElement.
	self addChild: aBatterElement
]

{ #category : 'positioning' }
BlBreakoutField >> ifBallNotBouncedOnWall: aPoint [

	| fieldBounds |
	fieldBounds := Rectangle origin: 0 @ 0 corner: self extent.
	(ball isNextPosition: aPoint verticallyInside: fieldBounds) ifTrue: [
		ball bounceLeftRight.
		^ false ].
	aPoint y > batter position y ifTrue: [
		self lostABall.
		^ false ].
	(ball isNextPosition: aPoint above: fieldBounds) ifTrue: [
		ball bounceTopBottom.
		^ false ].
	^ true
]

{ #category : 'initialization' }
BlBreakoutField >> initialize [

	super initialize.
	self
		geometry: BlRectangleGeometry new;
		size: 600 @ 350;
		background: (Color red alpha: 0.5);
		border: (BlBorder paint: Color black width: 1).
	self ball: BlBallElement new.
	self batter: BlBatterElement new.

	self addShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination builder n build;
			 action: [ :anEvent :aShortcut |
				 batter moveLeft ]).
	self addShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination builder m build;
			 action: [ :anEvent :aShortcut |
				 batter moveRight ]).

	"necessary, otherwise, keyboard shortcut are not taken into account"
	self requestFocus.
	"the size is not available to children until rendered at least once."
	self addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt |
		ball positionAtStart.
		batter positionAtStart.
		ball startAnimation ]
]

{ #category : 'positioning' }
BlBreakoutField >> lostABall [

	self inform: 'You die'
]

{ #category : 'positioning' }
BlBreakoutField >> moveBall [

	| nextPosition |
	nextPosition := ball nextPosition.
	(self ifBallNotBouncedOnWall: nextPosition) ifFalse: [ ^ self ].
	(batter bounds bounds containsPoint: nextPosition) ifTrue: [ ball bounceTopBottom ].
	ball moveToNextPosition
]
