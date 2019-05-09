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
RSReport >> getAllDefinedClasses [
	^ self getPackages flatCollect: #definedClasses
]

{ #category : #'as yet unclassified' }
RSReport >> getPackages [
	^ RPackageOrganizer default packages
		select: [ :p | regExps anySatisfy: [ :pre | p packageName beginsWith: pre ] ]
]

{ #category : #accessing }
RSReport >> regExps [
	^ regExps
]

{ #category : #accessing }
RSReport >> regExps: anObject [
	regExps := anObject
]
