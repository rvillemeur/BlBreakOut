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
		spec postLoadDoIt: #useMorphicAsPreferedBlocHost.
]

{ #category : 'baselines' }
BaselineOfBlBreakOut >> useMorphicAsPreferedBlocHost [

	BlHost preferableHostClass: BlMorphicWindowHost
]
