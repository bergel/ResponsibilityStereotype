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
Class >> getters [ 
	"
	RTView getters
	"
	^ (self methods select: #isMutator) size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> loc [
	^ self numberOfLinesOfCode
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numAttr [
	"	
	RTView numAttr 
	"	
	^ self instVarNames size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numIfs [
	"	
	RTView numIfs 
	"	
	| ls result |
	ls := ((self methods flatCollect: #literals) select: #isSymbol) groupedBy: #yourself.
	result := 0.
	#(#ifTrue: #ifFalse: #ifTrue:ifFalse: #detect:IfNone: #whileTrue: #whileFalse: #remove:ifAbsent:) do: [ :k | (ls includesKey: k) ifTrue: [ result := result + (ls at: k) size ] ].
	^ result	
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numMethods [
	"	
	RTView numMethods 
	"	
	^ self numberOfMethods
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numParameters [
	"	
	RTView numParameters 
	"	
	^ (self methods collect: #numArgs) sum
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

{ #category : #'*ResponsibilityStereotype' }
Class >> setters [ 
	"
	RTView setters
	"
	^ (self methods select: #isAccessor) size
]
