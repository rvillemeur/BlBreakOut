Class {
	#name : 'BaselineOfBlBreakOut',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBlBreakOut',
	#package : 'BaselineOfBlBreakOut'
}

{ #category : 'baselines' }
BaselineOfBlBreakOut >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'BlBreakOut' with: [ spec requires: #( 'Bloc' ) ].

		spec
			baseline: 'Bloc'
			with: [ spec repository: 'github://pharo-graphics/Bloc:dev/src' ] ].
		spec postLoadDoIt: #postLoad.
]

{ #category : 'operations' }
BaselineOfBlBreakOut >> openBrowser [

	(ClyFullBrowserMorph onDefaultEnvironment selectClass: BROutExample)
		open
]

{ #category : 'operations' }
BaselineOfBlBreakOut >> openGame [

	BlBreakOut new openInNewSpace
]

{ #category : 'script' }
BaselineOfBlBreakOut >> postLoad [

	self useMorphicAsPreferedBlocHost.
	self openBrowser.
	self openGame
]

{ #category : 'operations' }
BaselineOfBlBreakOut >> useMorphicAsPreferedBlocHost [

	BlHost preferableHostClass: BlMorphicWindowHost
]
