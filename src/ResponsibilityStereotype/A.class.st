Class {
	#name : #A,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #ResponsibilityStereotype
}

{ #category : #accessing }
A >> x [
	"
	(self >> #x) isAccessor
	" 
	^ x
]

{ #category : #accessing }
A >> x2 [
	"
	(self >> #x2) isAccessor
	" 
	^ x * x
]

{ #category : #accessing }
A >> x: aVlaue [
	"
	(self >> #x:) isAccessor
	(self >> #x:) isMutator
	" 
	x := aVlaue 
]
