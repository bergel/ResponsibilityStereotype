Class {
	#name : #RSMetricTests,
	#superclass : #TestCase,
	#category : #ResponsibilityStereotype
}

{ #category : #tests }
RSMetricTests >> testBasic [
	self assert: (A >> #x) isAccessor.
	self deny: (A >> #x:) isAccessor.
	self deny: (A >> #x2) isAccessor.
	
	self deny: (A >> #x) isMutator.
	self assert: (A >> #x:) isMutator.
	self deny: (A >> #x2) isMutator.

]
