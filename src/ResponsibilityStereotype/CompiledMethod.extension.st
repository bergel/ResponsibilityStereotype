Extension { #name : #CompiledMethod }

{ #category : #'*ResponsibilityStereotype' }
CompiledMethod >> isAccessor [
	"
	(self >> #isAccessor) isAccessor
	"
	| a c1 c2 c3 c4 c5 |
	a := self ast.
	
	c1 := [ :ast | ast body size = 1 ].
	c2 := [ :ast | ast body statements notEmpty ].
	c3 := [ :ast | ast body statements first class == RBReturnNode ].
	c4 := [ :ast | ast body statements first value class == RBInstanceVariableNode ].
	c5 := [ :ast | ast body statements first value name == self selector ].	
	^ { c1 . c2 . c3 . c4 . c5 } allSatisfy: [ :vv | vv value: a ]
]

{ #category : #'*ResponsibilityStereotype' }
CompiledMethod >> isMutator [
	"
	(self >> #isAccessor) isAccessor
	(self >> #isAccessor) isMutator
	"
	| a c1 c2 c3 c4 |
	a := self ast.
	
	c1 := [ :ast | ast body size = 1 ].
	c2 := [ :ast | ast body statements notEmpty ].
	c3 := [ :ast | ast body statements first class == RBAssignmentNode ].
	c4 := [ :ast | ast body statements first variable name, #':' == self selector ].
	^ { c1 . c2 . c3 . c4 } allSatisfy: [ :vv | vv value: a ]
]
