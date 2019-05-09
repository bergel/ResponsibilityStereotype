Extension { #name : #Class }

{ #category : #'*ResponsibilityStereotype' }
Class >> classPublicity [
	"	
	Return public or private indicating the class visibility.
	RSReport classPublicity
	"	
	| methods |
	methods := SystemNavigation default allCallsOn: self binding.
	^ (methods anySatisfy: [ :m | m package ~~ self package ])
		ifTrue: [ 'public' ]
		ifFalse: [ 'private' ]
]
