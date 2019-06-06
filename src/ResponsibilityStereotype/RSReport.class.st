Class {
	#name : #RSReport,
	#superclass : #Object,
	#instVars : [
		'regExps'
	],
	#category : #ResponsibilityStereotype
}

{ #category : #'as yet unclassified' }
RSReport >> exampleOnRoassal2 [
	<script: 'self new exampleOnRoassal2 writeCSVTo: ''/Users/alexandrebergel/Dropbox/GitRepos/ResponsibilityStereotype/Data/Roassal.csv'''>

	^ self
		regExps: #('Roassal2' 'Trachel');
		yourself.
]

{ #category : #'as yet unclassified' }
RSReport >> exampleOnSmallExample [
	<script: 'self new exampleOnSmallExample inspect'>

	^ self
		regExps: #('Tool-Catalog');
		yourself.
]

{ #category : #'as yet unclassified' }
RSReport >> fields [
	^ #('name' 'classPublicity' 'numPublicMethods' 'numPrivateMethods' 'numProtectedMethods' 'loc' 'numParameters' 'numAttr' 'numMethods' 'setters' 'getters' 'isCollection' 'isAbstractClass' 'numWordName' 'isOrEr' 'isController' 'numImports' 'numOutboundInv' 'numIfs' 'isClassRes')
]

{ #category : #'as yet unclassified' }
RSReport >> getAllDefinedClasses [
	^ self getPackages flatCollect: #definedClasses
]

{ #category : #'as yet unclassified' }
RSReport >> getPackages [
	^ RPackageOrganizer default packages
		select: [ :p | regExps anySatisfy: [ :pre | p packageName beginsWith: pre ] ]
]

{ #category : #'as yet unclassified' }
RSReport >> getSortedAllDefinedClasses [
	^ self getAllDefinedClasses sortedAs: [ :c1 :c2 | c1 name < c2 name ]
]

{ #category : #'as yet unclassified' }
RSReport >> microPause [
    "Useful when you wish to log in the Transcript and see progresses"
    (Delay forMilliseconds: 1) wait.
    World doOneCycleNow.
]

{ #category : #'as yet unclassified' }
RSReport >> produceReportAsCSV [
	| str classes |
	str := WriteStream on: String new.
	classes := self getSortedAllDefinedClasses.
	self writeHeaderOn: str.
	UIManager default
        informUserDuring: [ :bar |
				classes doWithIndex: [ :cls :index |
					bar label: (index / classes size * 100) asInteger asString, ' %'.
					bar current: (index / classes size * 100) asInteger.
             	self microPause.
					self write: cls on: str.
					str cr.
				]
			].
	^ str contents
]

{ #category : #documentation }
RSReport >> readme [

	"
	F6 numIfs. Counted the derived whileTrue, whileFalse. detect:ifNone:
	Not done: 
	F12 isPersist. There is no interface Serializable
	F14 isClass. There are only classes
	F15 isEnum. There are no enum in Pharo
	F17 isStatisClass. There are no statis classes
	F18 isInterface. There are no interfaces
	
	"
]

{ #category : #accessing }
RSReport >> regExps [
	^ regExps
]

{ #category : #accessing }
RSReport >> regExps: anObject [
	regExps := anObject
]

{ #category : #'as yet unclassified' }
RSReport >> write: cls on: str [
	| values |
	values := self fields collect: [ :k | (cls perform: k asSymbol) asString ].
	str nextPutAll: (',' join: values)
]

{ #category : #'as yet unclassified' }
RSReport >> writeCSVTo: aFilename [
	aFilename asFileReference writeStream nextPutAll: self produceReportAsCSV
]

{ #category : #'as yet unclassified' }
RSReport >> writeHeaderOn: str [
	str nextPutAll: (',' join: self fields).
	str cr.
]
