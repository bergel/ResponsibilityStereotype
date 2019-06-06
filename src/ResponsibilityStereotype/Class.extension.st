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
	^ (self rsMethods select: #isMutator) size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> isAbstractClass [
	^ self isAbstract or: [ '*Abstract*' match: self name ]
]

{ #category : #'*ResponsibilityStereotype' }
Class >> isClassRes [
	^ self isAbstractClass not
]

{ #category : #'*ResponsibilityStereotype' }
Class >> isCollection [
	^ self inheritsFrom: Collection
]

{ #category : #'*ResponsibilityStereotype' }
Class >> isController [
	^ self name asLowercase endsWith: 'controller'
]

{ #category : #'*ResponsibilityStereotype' }
Class >> isOrEr [
	^ (self name endsWith: 'or') or: [ (self name endsWith: 'er') ]
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
	ls := ((self rsMethods flatCollect: #literals) select: #isSymbol) groupedBy: #yourself.
	result := 0.
	#(#ifTrue: #ifFalse: #ifTrue:ifFalse: #detect:IfNone: #whileTrue: #whileFalse: #remove:ifAbsent:) do: [ :k | (ls includesKey: k) ifTrue: [ result := result + (ls at: k) size ] ].
	^ result	
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numImports [
	^ self dependentClasses size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numMethods [
	"	
	RTView numMethods 
	"	
	^ self numberOfMethods
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numOutboundInv [
	"
	RTView numOutboundInv
	A numOutboundInv
	"
	| methodsToExclude |
	methodsToExclude := self withAllSuperclasses flatCollect: #selectors.
	^ ((self rsMethods flatCollect: #messages) copyWithoutAll: methodsToExclude) size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numParameters [
	"	
	RTView numParameters 
	"	
	self rsMethods ifEmpty: [ ^ 0 ].
	^ (self rsMethods collect: #numArgs) sum
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numPrivateMethods [
	"	
	Return public or private indicating the class visibility.
	RTView numPrivateMethods 5 
	RTView numPublicMethods 55 
	RTView numberOfMethods 61 
	"	
	^ (self rsMethods select: [ :cm | 
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
	^ (self rsMethods select: [ :cm | 
		(SystemNavigation default allCallsOn: cm selector) allSatisfy: [ :cmm | (cmm realClass == cm realClass) or: [ cmm realClass inheritsFrom: cm realClass ] ] ]) size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numPublicMethods [
	"	

	RSReport numPublicMethods
	
	SystemNavigation default allCallsOn: #printOn:
	"	
	^ (self rsMethods select: [ :cm | 
		(SystemNavigation default allCallsOn: cm selector) anySatisfy: [ :cmm | (cmm realClass ~~ cm realClass) and: [ (cmm realClass inheritsFrom: cm realClass) not ] ] ]) size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> numWordName [
	^ self name cutCamelCase size
]

{ #category : #'*ResponsibilityStereotype' }
Class >> rsMethods [
	^ self instanceSide methods , self classSide methods
]

{ #category : #'*ResponsibilityStereotype' }
Class >> setters [ 
	"
	RTView setters
	"
	^ (self rsMethods select: #isAccessor) size
]
