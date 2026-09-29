Class {
	#name : 'BlBonusTest',
	#superclass : 'TestCase',
	#instVars : [
		'field',
		'space'
	],
	#category : 'BlBreakOut-Tests',
	#package : 'BlBreakOut',
	#tag : 'Tests'
}

{ #category : 'private' }
BlBonusTest >> extentAfterLayoutOf: anElement [

	space pulse.
	^ anElement extent
]

{ #category : 'running' }
BlBonusTest >> setUp [

	super setUp.
	field := BlBreakoutField new.
	space := BlSpace new.
	space extent: BlBreakoutField playFieldSize.
	space root addChild: field.
	space pulse
]

{ #category : 'running' }
BlBonusTest >> tearDown [

	space close.
	super tearDown
]

{ #category : 'tests' }
BlBonusTest >> testDestroyedBrickActivatesItsBonus [

	| brick |
	brick := field destroyableBricks first.
	brick bonus: BatterShrinker new.
	brick actionWhenBumpedBy: (field instVarNamed: #ball).
	self assert: (self extentAfterLayoutOf: field batter) equals: 25 @ 10
]

{ #category : 'tests' }
BlBonusTest >> testDispatchBonuses [

	| withBonus |
	withBonus := field destroyableBricks count: [ :each | each hasBonus ].
	self assert: withBonus > 0.
	self assert: withBonus <= (field destroyableBricks size * 0.25) rounded
]

{ #category : 'tests' }
BlBonusTest >> testEnlargerKeepsBatterInField [

	| batter |
	batter := field batter.
	batter position: field width - batter width @ batter position y.
	space pulse.
	field addActiveBonus: BatterEnlarger new.
	self assert: (self extentAfterLayoutOf: batter) equals: 100 @ 10.
	self assert: batter position x + batter width equals: field width
]

{ #category : 'tests' }
BlBonusTest >> testShrinkerLastsItsDuration [

	| bonus |
	bonus := BatterShrinker new.
	field addActiveBonus: bonus.
	self assert: (self extentAfterLayoutOf: field batter) equals: 25 @ 10.
	bonus duration - 1 timesRepeat: [ field stepBonuses ].
	self assert: (self extentAfterLayoutOf: field batter) equals: 25 @ 10.
	field stepBonuses.
	self
		assert: (self extentAfterLayoutOf: field batter)
		equals: field defaultBatterSize.
	self assert: (field instVarNamed: #activeBonuses) isEmpty
]
