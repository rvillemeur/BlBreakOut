Class {
	#name : 'BaselineOfBlBreakOut',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBlBreakOut',
	#package : 'BaselineOfBlBreakOut'
}

{ #category : 'baselines' }
BaselineOfBlBreakOut >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'BlBreakOut' ]
]
