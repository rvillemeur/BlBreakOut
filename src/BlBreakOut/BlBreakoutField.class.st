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
		'ball'
	],
	#category : 'BlBreakOut',
	#package : 'BlBreakOut'
}

{ #category : 'accessing' }
BlBreakoutField >> ball: aBallElement [

	ball := aBallElement.
	self addChild: aBallElement
]

{ #category : 'initialization' }
BlBreakoutField >> initialize [

	super initialize.
	self
		geometry: BlRectangleGeometry new;
		size: 600@350;
		background: (Color red alpha: 0.5);
		border: (BlBorder paint: Color black width: 1).
	self ball: BlBallElement new.
]
