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
	<script: 'self new exampleOnRoassal2 inspect'>

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
	^ #('name' 'classPublicity')
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
RSReport >> produceReportAsCSV [
	| str classes |
	str := WriteStream on: String new.
	classes := self getSortedAllDefinedClasses.
	self writeHeaderOn: str.
	classes do: [ :cls |
		self write: cls on: str.
		str cr.
	].
	^ str contents
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
RSReport >> writeHeaderOn: str [
	str nextPutAll: (',' join: self fields).
	str cr.
]
