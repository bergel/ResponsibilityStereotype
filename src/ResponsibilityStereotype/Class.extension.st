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

{ #category : #'*ResponsibilityStereotype' }
Class >> loc [
	^ self numberOfLinesOfCode
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numPrivateMethods [
	"	
	Return public or private indicating the class visibility.
	RTView numPrivateMethods 5 
	RTView numPublicMethods 55 
	RTView numberOfMethods 61 
	"	
	^ (self methods select: [ :cm | 
		(SystemNavigation default allCallsOn: cm selector) allSatisfy: [ :cmm | cmm realClass == cm realClass ] ]) size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numProtectedMethods [
	"	
	Return public or private indicating the class visibility.
	RTView numPrivateMethods 5 
	RTView numPublicMethods 55 
	RTView numberOfMethods 61 
	RTView numProtectedMethods 5
	RTView loc
	"	
	^ (self methods select: [ :cm | 
		(SystemNavigation default allCallsOn: cm selector) allSatisfy: [ :cmm | (cmm realClass == cm realClass) or: [ cmm realClass inheritsFrom: cm realClass ] ] ]) size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numPublicMethods [
	"	
	Return public or private indicating the class visibility.
	RSReport numPublicMethods
	
	SystemNavigation default allCallsOn: #printOn:
	"	
	^ (self methods select: [ :cm | 
		(SystemNavigation default allCallsOn: cm selector) anySatisfy: [ :cmm | cmm realClass ~~ cm realClass ] ]) size
]
