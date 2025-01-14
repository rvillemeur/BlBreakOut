Class {
	#name : 'BROutExample',
	#superclass : 'BlElement',
	#category : 'BlBreakOut-Example',
	#package : 'BlBreakOut',
	#tag : 'Example'
}

{ #category : 'instance creation' }
BROutExample class >> newFieldGame [

	<sampleInstance>
	^ BlBreakoutField new openInNewSpace
]

{ #category : 'examples' }
BROutExample class >> sampleButton [

	<sampleInstance>
	^ BROutButton new
		  label: 'Button Label Example';
		  action: [ self inform: 'clicked' ];
		  openInNewSpace
]

{ #category : 'examples' }
BROutExample class >> sampleStandaloneButton [

	<sampleInstance>
	^ BROutButton new
		  label: 'example'
]

{ #category : 'see class side' }
BROutExample >> seeClassSide [ 
]
