/*******************************************************************************
 * Copyright (c) 2013-2017 Lorenzo Bettini.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *   Lorenzo Bettini - Initial contribution and API
 *******************************************************************************/

package org.eclipse.xsemantics.dsl.tests.input

class XsemanticsTestFiles {
	def typeSystemQualifiedName() '''
	system org.eclipse.xsemantics.test.TypeSystem
	'''

	def typeSystemNoQualifiedName() '''
	system TypeSystem
	'''
	
	def testFileWithImports() '''
	«typeSystemQualifiedName»
	
	import java.util.List
	import java.net.*
	'''
	
	def testJudgmentDescriptions() '''
	«typeSystemQualifiedName»
	
	import java.util.List
	
	judgments {
		type |- List<String> list : java.util.Set<Integer> set
	}
	'''
	
	def testJudgmentDescriptions3() '''
	«testFileWithImports»
	
	judgments {
		type |- List<String> list : java.util.Set<Integer> set : Boolean b
	}
	'''
	
	def testJudgmentDescriptionsWithDuplicates() '''
	«typeSystemQualifiedName»
	
	import java.util.List
	
	judgments {
		type |- List<String> list : java.util.Set<Integer> set
		type ||- List<String> list2 : java.util.Set<Integer> set2
		type |~ List<String> list : java.util.Set<Integer> set
	}
	'''
	
	def testJudgmentDescriptionsWithDuplicateSymbols() '''
	«typeSystemQualifiedName»
	
	import java.util.List
	
	judgments {
		type |- List<String> list : java.util.Set<Integer> set
		type2 |- List<String> list : Object o
		type3 ||- List<String> list : Object o
	}
	'''

	def testJudgmentDescriptionsRelatedToXsemantics() '''
	«testFileWithImports»
	
	import org.eclipse.xsemantics.dsl.xsemantics.Rule
	
	judgments {
		type |- List<Rule> list : 
			java.util.Set<org.eclipse.xsemantics.dsl.xsemantics.JudgmentDescription> set
	}
	'''
	
	def testJudgmentDescriptionsReferringToUnknownTypes() '''
	«testFileWithImports»
	
	judgments {
		type |- List<foo.bar.FooBar> list : it.unknown.MyClass foo
	}
	'''

	def testJudgmentDescriptionsReferringToEcore() '''
	«typeSystemQualifiedName»
	
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EcoreFactory
	
	judgments {
		type |- EClass c : EObject o
	}
	'''
	
	def testJudgmentDescriptionsReferringToEClassEObject() '''
	«typeSystemQualifiedName»
	
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	
	judgments {
		type |- EClass c : EObject o
	}
	'''
	
	def testJudgmentDescriptionsReferringToEcoreWithOutput() '''
	«typeSystemQualifiedName»
	
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	
	judgments {
		type |- EClass c : output EObject
	}
	'''
	
	def testJudgmentDescriptionsEObjectEClass() '''
	«typeSystemQualifiedName»
	
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EClass
	
	judgments {
		type |- EObject c : output EClass
	}
	'''
	
	def testJudgmentDescriptionsWithErrorSpecification() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EObject c : output EClass
			error "this " + c + " made an error!"
			source c
			feature c.eClass.eContainingFeature
	}
	'''
	
	def testJudgmentDescriptionsWithErrorSpecificationWithoutSourceAndFeature() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EObject c : output EClass
			error "this " + c + " made an error!"
			
	}
	'''
	
	def testRuleJudgmentDescriptionsWithErrorSpecification() '''
	«testJudgmentDescriptionsWithErrorSpecification»
	
	rule TestRule
		G |- EObject o : EClass c
	from {
		
	}
	'''
	
	def testJudgmentDescriptionsWithCollectionOutput() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c : output java.util.List<EStructuralFeature>
	}
	'''
	
	def testJudgmentDescriptionsReferringToEcore3() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c : EObject o : EStructuralFeature f
		subtype ||- EObject o <: EClass c :> EStructuralFeature f
	}
	'''
	
	def testJudgmentDescriptionsReferringToEcore3WithOutput() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EStructuralFeature
	
	judgments {
		type |- EClass c : output EObject : EStructuralFeature f
		type2 ||- EClass c : output EObject : output EStructuralFeature
		subtype ||- output EObject <: EClass c :> EStructuralFeature f
	}
	'''
	
	def testJudgmentDescriptionsWith2OutputParams() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c : output EObject : output EStructuralFeature
	}
	'''
	
	def testJudgmentDescriptionsWith3OutputParams() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c : output EObject : 
			output EStructuralFeature : output String
	}
	'''

	def testJudgmentDescriptionsWith4OutputParams() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EStructuralFeature
	import org.eclipse.emf.common.notify.Notifier
	
	judgments {
		type |- EClass c : output EObject : 
			output EStructuralFeature : output String : output Notifier
	}
	'''
	
	def testAuxiliaryDescriptionsWithNoInputParam() '''
	«typeSystemQualifiedName»
	
	auxiliary {
		foo()
	}
	
	auxiliary foo() {}
	'''

	def testJudgmentDescriptionsWithNoInputParam() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	
	judgments {
		type |- output EClass : output EObject
	}
	'''
	
	def testRuleWithOutputParams() '''
	«testJudgmentDescriptionsReferringToEcore3WithOutput»
	
	rule EClassEObjectEStructuralFeature derives
		G |- EClass eClass : EObject object : EStructuralFeature feat
	from {
		G |- eClass : object : feat
	}
	'''
	
	def testRuleWithCollectionOutputParam() '''
	«testJudgmentDescriptionsWithCollectionOutput»
	
	rule Features derives
		G |- EClass eClass : List<EStructuralFeature> features
	from {
		G |- eClass : features
	}
	'''
	
	def testRuleWithTwoOutputParams() '''
	«testJudgmentDescriptionsReferringToEcore3WithOutput»
	
	rule EClassEObjectEStructuralFeature derives
		G ||- EClass eClass : EObject object : EStructuralFeature feat
	from {
		G ||- eClass : object : feat
	}
	'''

	def testRuleWith3OutputParams() '''
	«testJudgmentDescriptionsWith3OutputParams»
	
	rule EClassEObjectEStructuralFeatureString derives
		G |- EClass eClass : EObject object : 
			EStructuralFeature feat : String s
	from {
		G |- eClass : object : feat : s
	}
	'''
	
	def testRuleWithOutputParamsAndExplicitAssignment() '''
	«testJudgmentDescriptionsReferringToEcore3WithOutput»
	
	rule EClassEObjectEStructuralFeature derives
		G |- EClass eClass : EObject object : EStructuralFeature feat
	from {
		var EObject objectResult
		G |- eClass : object : feat
		object = objectResult
	}
	'''
	
	def testRuleWithOutputArgAsLocalVariable() '''
	«testJudgmentDescriptionsReferringToEcore3WithOutput»
	
	rule EClassEObjectEStructuralFeature derives
		G |- EClass eClass : EObject object : EStructuralFeature feat
	from {
		var EObject objectResult
		G |- eClass : objectResult : feat
		var EObject myObject
		myObject = objectResult
	}
	'''
	
	def testRuleWithAssignmentToOutputParam() '''
	«testJudgmentDescriptionsReferringToEcore3WithOutput»
	
	rule EClassEObjectEStructuralFeature derives
		G |- EClass eClass : EObject object : EStructuralFeature feat
	from {
		var EObject objectResult
		G |- eClass : objectResult : feat
		object = objectResult
	}
	'''
	
	def testRuleWithAssignmentToInputParam() '''
	«testJudgmentDescriptionsReferringToEcore3WithOutput»
	
	rule EClassEObjectEStructuralFeature derives
		G |- EClass eClass : EObject object : EStructuralFeature feat
	from {
		eClass = object.eClass
	}
	'''

	def testSimpleAxiom() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	axiom eClassEObject
		G |- EClass eClass : EObject object
	'''
	
	def testAxiomWithExpressionInConclusion() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	axiom EObjectEClass
		G |- EObject object : object.eClass
	'''

	def testEnvInExpressionInConclusion() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	axiom EObjectEClass
		G |- EObject object : env(G, "this", EClass)
	'''

	def testSimpleRule() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		// some expressions from Xbase
		'foo' == new String() + "bar".toFirstUpper
		val EClass eC = EcoreFactory::eINSTANCE.createEClass()
		eC.name = 'MyEClass'
		eClass == eC
	}
	'''
	
	def testDuplicateRuleNames() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	axiom Foo
		G |- EClass eClass : EObject object

	axiom Foo
		G1 |- EClass o : EClass o2
	'''

	def testDuplicateRuleNames2() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	axiom Foo
		G |- EClass eClass : EObject object

	rule Foo
		G1 |- EClass o : EClass o2
	from {}
	'''
	
	def testDuplicateCheckRuleNames() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	checkrule Foo for
		EObject o1
	from {}

	checkrule Foo for
		EClass o
	from {}
	'''

	def testDuplicateRuleAndCheckRuleNames() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	axiom Foo
		G |- EClass eClass : EObject object

	checkrule Foo for
		EClass o
	from {}
	'''

	def testDuplicateParamsInRule() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject eClass
	from {
	}
	'''
	
	def testDuplicateParamsInJudgmentDescription() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass eClass : EClass eClass
	}
	'''

	def testRuleWithExpressionInConclusion() '''
	«testJudgmentDescriptionsReferringToEcoreWithOutput»
	
	rule EClassEObject derives
		G |- EClass eClass : org::eclipse::emf::ecore::EcoreFactory::eINSTANCE.createEObject()
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
		val EClass eC = org::eclipse::emf::ecore::EcoreFactory::eINSTANCE.createEClass()
		eC.name = 'MyEClass'
		eClass == eC
	}
	'''
	
	def testRuleWithExpressionInConclusionWithInputParamNameAsXbaseGeneratedVariable() '''
	«testJudgmentDescriptionsReferringToEcoreWithOutput»
	
	rule EClassEObject derives
		G |- EClass _createEObject : org::eclipse::emf::ecore::EcoreFactory::eINSTANCE.createEObject()
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
	}
	'''

	def testRuleWithBlockExpressionInConclusion() '''
	«testJudgmentDescriptionsReferringToEcoreWithOutput»
	
	rule EClassEObject derives
		G |- EClass eClass : { 
			val result = org::eclipse::emf::ecore::EcoreFactory::eINSTANCE.createEClass();
			result.name = 'MyEClass'
			result
		}
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
		val EClass eC = org::eclipse::emf::ecore::EcoreFactory::eINSTANCE.createEClass()
		eC.name = 'MyEClass'
		eClass == eC
	}
	'''

	def testRuleWithExpressionInConclusion2() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EcoreFactory::eINSTANCE.createEClass() : EObject eObject
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
		val EClass eC = EcoreFactory::eINSTANCE.createEClass()
		eC.name = 'MyEClass'
	}
	'''

	def testRulesWithSameEnvironmentNames() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	axiom Foo
		G |- EClass eClass : EObject object

	axiom Foo2
		G |- EClass o : EClass o2
	'''

	def testRuleInvokingAnotherRule() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		// some expressions from Xbase
		'foo' == new String() + "bar".toFirstUpper
		G |- object.eClass : eClass
		G |- eClass : object.eClass
		val EClass eC = EcoreFactory::eINSTANCE.createEClass()
		eC.name = 'MyEClass'
		!(eC.name == 'MyEClass2')
		eC.name.length < 10
		eClass == eC
	}
	'''
	
	def testRuleWithFeatureCalls() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		// some expressions from Xbase
		'foo' == new String() || 'bar' == new String()
		'foo' == new String() && 'bar' == new String()
		'foo' == new String() + 'bar'.toFirstUpper
		'foo' != new String() + 'bar'.toFirstUpper
		val temp = new String() + 'bar'.toFirstUpper
		'foo'.contains('f')
		'foo'.concat('f')
		!('foo'.contains('f'))
		val EClass eC = EcoreFactory::eINSTANCE.createEClass()
	}
	'''
	
	def testRuleWithFeatureCallsForBinaryOps() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		// some expressions from Xbase
		'foo' == new String() || 'bar' == new String()
		'foo' == new String() && 'bar' == new String()
		'foo' == new String() + 'bar'.toFirstUpper
		'foo' != new String() + 'bar'.toFirstUpper
		new String() + 'bar'.toFirstUpper
		'foo'.contains('f')
		'foo'.concat('f')
		!('foo'.contains('f'))
		val EClass eC = EcoreFactory::eINSTANCE.createEClass()
	}
	'''
	
	def testRuleOnlyInvokingRules() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		G |- object.eClass : eClass
		G |- eClass : object.eClass
	}
	'''
	
	def testRuleInvokingAnotherRule3() '''
	«testJudgmentDescriptionsReferringToEcore3»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object : EStructuralFeature feat
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
		G |- object.eClass : eClass : feat
		G |- eClass : object.eClass : feat
		val EClass eC = EcoreFactory::eINSTANCE.createEClass()
		eC.name = 'MyEClass'
		!(feat.name == 'MyEClass')
		eC.name.length < 10
		eClass == eC
	}
	'''
	
	def testRuleInvokingAnotherRuleWith3Params() '''
	«testRuleInvokingAnotherRule3»
	
	rule ESub derives
		G ||- EObject object <: EClass eClass :> EStructuralFeature feat
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
		G ||- object <: eClass :> feat
		G |- eClass : object.eClass : feat
		val EClass eC = EcoreFactory::eINSTANCE.createEClass()
		eC.name = 'MyEClass'
		!(feat.name == 'MyEClass')
		eC.name.length < 10
		eClass == eC
	}
	'''
	
	// this would not pass validation due to the boolean right
	// expression in the second rule invocation
	def testRuleInvokingAnotherRuleNotValid() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
		G |- object.eClass : eClass
		G |- eClass : object.eClass.name == [ s | s.toFirstLower ].apply('foo')
		val EClass eC = EcoreFactory::eINSTANCE.createEClass()
		eC.name = 'MyEClass'
		!(eC.name == 'MyEClass')
		eC.name.length < 10
		eClass == eC
	}
	'''

	def testRuleInvocationsWithOperatorsConflictingXbase() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type1 |- EClass c : EObject o
		type2 |- EClass c <: EObject o
		type3 |- EClass c :> EObject o
		type4 |- EClass c << EObject o
		type5 |- EClass c >> EObject o
		type6 |- EClass c <| EObject o
		type7 |- EClass c ~~ EObject o
		type8 |- EClass c |> EObject o
		type9 |- EClass c --> EObject o
		type10 |- EClass c <- EObject o
		type11 |- EClass c <~ EObject o
		type12 |- EClass c ~> EObject o
		type13 |- EClass c <! EObject o
		type14 |- EClass c !> EObject o
		type15 |- EClass c <<! EObject o
		type16 |- EClass c !>> EObject o
		type17 |- EClass c <~! EObject o
		type18 |- EClass c !~> EObject o
		type19 ||- EClass c >> EObject o
		type20 ||- EClass c \/ EObject o
		type21 ||- EClass c /\ EObject o
	}
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
		// :: as relation symbol disabled due to ambiguities with xbase static access
		//G |- object.eClass :: eClass
		//G |- (eClass) :: eClass // we need () otherwise interpreted as static access
		//G |- (eClass) :: object.eClass.name == [ s | s.toFirstLower ].apply('foo')
		val EClass eC = EcoreFactory::eINSTANCE.createEClass()
		eC.name = 'MyEClass'
		eClass == eC
		G |- object.eClass <: eClass
		eC.name = 'MyEClass'
		eClass == eC
		G |- object.eClass :> eClass
		eC.name = 'MyEClass'
		eClass == eC
		G |- object.eClass << eClass
		eC.name = 'MyEClass'
		eClass == eC
		G |- object.eClass >> eClass
		eC.name = 'MyEClass'
		eClass == eC
		G |- object.eClass <| eClass
		eC.name = 'MyEClass'
		eClass == eC
		G |- object.eClass ~~ eClass
		eC.name = 'MyEClass'
		eClass == eC
		G |- object.eClass |> eClass
		G |- (object.eClass) --> (eClass)
		G |- (object.eClass) <- (eClass)
		G |- (object.eClass) <~ (eClass)
		G |- (object.eClass) ~> (eClass)
		G |- (object.eClass) <! (eClass)
		G |- (object.eClass) !> (eClass)
		G |- (object.eClass) <<! (eClass)
		G |- (object.eClass) !>> (eClass)
		G |- (object.eClass) <~! (eClass)
		G |- (object.eClass) !~> (eClass)
		eC.name = 'MyEClass'
		eClass == eC
		G ||- object.eClass >> eClass
		G ||- object.eClass /\ eClass
		G ||- object.eClass \/ eClass
	}
	'''

	def testRuleWithoutJudgmentDescription() '''
	«testSimpleRule»
	
	rule NoJudgmentDescription derives
		G  ||- EClass eClass : EObject object
	from {
		
	}
	'''
	
	def testRuleInvocationWithoutJudgmentDescription() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	rule NoJudgmentDescription derives
		G  |- EClass eClass : EObject object
	from {
		G ||- eClass : object
		eClass.name = 'MyEClass'
	}
	'''
	
	def testRuleWithConclusionNotSubtype() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	// note that only the left parameter raises an error (EObject not <: EClass)
	// while the right is acceptable since EClass <: EObject
	rule EClassEObject derives
		G |- EObject object : EClass eClass 
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
		eClass == object.eClass
	}
	'''
	
	def testRuleWithConclusionNotSubtypeBoth() '''
	«testJudgmentDescriptionsReferringToEcoreWithOutput»
	
	rule EClassEObject derives
		G |- EObject object : object.eClass.name
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
	}
	'''
	
	def testRuleInvocationWithWrongOutputArg() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EClassEObject derives
		G |- EObject object : EClass eClass 
	from {
		// this is OK
		G |- object : eClass
		// this is NOT: not valid output argument
		G |- object : object.eClass
	}
	'''

	def testRuleInvocationWithWrongOutputArg2() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EClassEObject derives
		G |- EObject object : EClass eClass 
	from {
		// this is NOT: not valid output argument
		G |- object : val EClass c
	}
	'''
	
	def testRuleInvocationWithInputParamPassedAsOutput() '''
	«testJudgmentDescriptionsReferringToEcoreWithOutput»
	
	rule PassInputParamAsOutput derives
		G |- EClass eClass : EObject object
	from {
		// can't pass eClass input param as output
		G |- eClass : eClass
	}
	'''
	
	def testRulesOfTheSameKind() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- Object o1 : Object o2
		subtype |- Object o1 <: Object o2
	}
	
	axiom Type1
		G |- String s1 : Integer i2
	
	axiom Type2
		G |- Boolean b1 : Integer i2
	
	axiom SubType1
		G |- String s1 <: Integer i2
	
	axiom SubType2
		G |- Boolean b1 <: Integer i2
	'''
	
	def testRulesOfTheSameKindWithSameArgumentTypes() '''
	«typeSystemQualifiedName»
	
	judgments {
		type |- Object o1 : Object o2
		subtype |- Object o1 <: Object o2
	}
	
	axiom Type1
		G |- String s1 : Integer i2
	
	axiom Type2
		G |- String b1 : Boolean i2
	
	axiom SubType1
		G |- Object s1 <: Integer i2
	
	axiom SubType2
		G |- Object b1 <: Integer i2
	'''
	
	def testRulesOfTheSameKindWithSameInputArgumentTypes() '''
	«typeSystemQualifiedName»
	
	judgments {
		type |- Object o1 : output Object
	}
	
	axiom Type1
		G |- String s1 : Integer i2
	
	// output params do not make two rules different
	axiom Type2
		G |- String b1 : String i2
	
	'''
	
	def testRuleWithErrorSpecifications() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
			error "this " + stringRep(object) + " made an error!"
			source object.eClass
			feature object.eClass.eContainingFeature
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
	}
	'''

	def testRuleWithSimpleErrorSpecifications() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
			error "this made an error!"
	from {
		// some expressions from Xbase
		'foo' == new String() + 'bar'.toFirstUpper
	}
	'''
	
	def testErrorSpecificationSourceNotEObject() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
			error "Conclusion error"
			source object.eClass.name
	from {
	}
	'''
	
	def testErrorSpecificationFeatureNotEStructuralFeature() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
			error "Conclusion error"
			feature object.eClass
	from {
	}
	'''

	def testErrorSpecificationDataVoid() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
			error "Conclusion error"
			data { println() }
	from {
	}
	'''
	
	def testOrExpression() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		eClass.name == 'foo'
		or
		object.eClass.name == 'bar'
	}
	'''
	
	def testOrExpression2() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		eClass.name == 'foo'
		eClass.name == 'foo'
		or
		object.eClass.name == 'bar'
		object.eClass.name == 'bar'
	}
	'''
	
	def testOrExpressionWithBlocks() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		{eClass.name == 'foo'
		eClass.name == 'foo'}
		or
		{object.eClass.name == 'bar'
		object.eClass.name == 'bar'}
	}
	'''

	def testOrExpressionsAccessingPreviousFailure() '''
	«typeSystemQualifiedName»
	
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EcoreFactory
	import org.eclipse.xsemantics.runtime.TraceUtils
	
	inject extension TraceUtils traceUtils
	
	judgments {
		type |- EClass c : EObject o
	}
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		val className = eClass.name
		
		/*
		{className == 'bar1'}
		or
		{
			println(previousFailure)
			fail
					error "this is the previous error: " +
						previousFailure.message
					source object
		}
		
		*/
		
		if (className.isEmpty()) {
			{className == 'foo'}
			or
			{className == 'bar'}
			or
			{
				{
					// this is the first branch of the or
					// but previousFailure is still available
					// from the outer or branches
					println(previousFailure)
				}
				or
				{className == 'foobar'}
			}
			
			{className == 'foo1'}
			or
			{className == 'bar1'}
			or
			{
				println(previousFailure)
			}
			or
			{
				fail
					error "this is the previous error: " +
						previousFailure.message
					source object
				}
		} else {
			{className == 'foo1'}
			or
			{
				fail
					error "this is the previous error trace: " +
						previousFailure.failureTraceAsString
					source object
					// note the TraceUtils.failureTraceAsString
					// used as an extension method
			}
		}
		
	}
	'''
	
	def testOrExpressionWithRuleInvocations() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		{eClass.name == 'foo'
		G |- object.eClass : eClass}
		or
		{G |- object.eClass : eClass
		object.eClass.name == 'bar'}
	}
	'''
	
	def testOrExpressionWithRuleInvocations2() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		G |- object.eClass : eClass
		or
		G |- object.eClass : eClass
	}
	'''
	
	def testOrExpressionWithManyBranches() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		G |- object.eClass : eClass
		or
		G |- object.eClass : eClass
		or
		{G |- object.eClass : eClass
		object.eClass.name == 'bar'}
		or
		object.eClass.name == 'bar'
	}
	'''
	
	def testEmptyEnvironment() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		empty |- object.eClass : eClass
	}
	'''
	
	def testEnvironmentComposition() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		empty, G |- object.eClass : eClass
	}
	'''
	
	def testEnvironmentComposition2() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		empty, G, empty, G |- object.eClass : eClass
	}
	'''
	
	def testSingleEnvironmentMapping() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		'this' <- object |- object.eClass : eClass
	}
	'''
	
	def testEnvironmentCompositionWithMapping() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		G, 'this' <- object |- object.eClass : eClass
	}
	'''
	
	def testEnvironmentMapping2() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		G, 'this' <- object, object <- EcoreFactory::eINSTANCE.createEClass()
		|- object.eClass : eClass
	}
	'''

	def testEnvironmentCompositions() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		empty |- object.eClass : eClass
		
		empty, G |- object.eClass : eClass
		
		empty, G, empty, G |- object.eClass : eClass
		
		'this' <- object |- object.eClass : eClass
		
		G, 'this' <- object |- object.eClass : eClass
		
		G, 'this' <- object, object <- EcoreFactory::eINSTANCE.createEClass()
		|- object.eClass : eClass
	}
	'''

	def testEnvironmentXExpression() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		new org.eclipse.xsemantics.runtime.RuleEnvironment
		|- eClass : object
		
		new org.eclipse.xsemantics.runtime.RuleEnvironment(G)
		|- eClass : object
		
		environmentComposition(
	      emptyEnvironment(), environmentComposition(
	        G, environmentComposition(
	          emptyEnvironment(), G
	        )
	      )
	    ) |- eClass : object
	    
	    emptyEnvironment, 'a' <- object, new org.eclipse.xsemantics.runtime.RuleEnvironment
	    |- eClass : object
	}
	'''

	def testWrongEnvironmentXExpression() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		"wrong"
		|- eClass : object
		
	}
	'''

	def testWrongEnvironmentXExpression2() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		G, "wrong"
		|- eClass : object
		
	}
	'''
	
	def testRulesWithNonEObjectParams() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass e : String s
	}
	
	axiom EClassString
		G |- EClass e : String s
	'''
	
	def testRulesWithOnlyNonEObjectParams() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- List<String> l : String s
	}
	
	axiom OnlyNonEObject
		G |- List<String> l : String s
	'''
	
	def testCheckRule() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	axiom EObjectEClass
		G |- EObject object : object.eClass
	
	checkrule CheckEObject for
		EObject obj
	from {
		var EClass result
		empty |- obj : result
	}
	'''
	
	def testStringRep() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EObject c : output EClass
			error "this " + stringRep(c) + " made an error!"
			source c
			feature c.eClass.eContainingFeature
	}
	'''
	
	def testForFail() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject obj : EClass eClass
	from {
		empty |- obj : eClass
		fail
	}
	'''
	
	def testForFailWithErrorSpecification() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject obj : EClass eClass
	from {
		empty |- obj : eClass
		fail
			error "this is the error"
			source obj
	}
	'''
	
	def testForClosures()
	'''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c
		useless ||- EStructuralFeature f
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		// boolean expressions inside closures will not
		// throw exception if they fail
		eClass.EStructuralFeatures.forall [
			it.name != 'foo'
		]
		
		// boolean expressions inside blocks inside closures will still
		// throw exception if they fail
		eClass.EStructuralFeatures.forall [
			{ it.name != 'foo' }
		]
		
		// rule invocations inside closures without expected
		// return type will still
		// throw exception if they fail
		eClass.EStructuralFeatures.forEach [
			G ||- it
		]
		
		eClass.EStructuralFeatures.get(0).name != 'foo'
	}
	
	rule Useless
		G ||- EStructuralFeature feat
	from {
		fail
	}
	'''

	def testRuleInvocationIsVoidInClosures()
	'''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c
		useless ||- EStructuralFeature f : output EClass
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		// rule invocations inside closures still have void type
		// so the forall will complain since it expects a boolean type
		eClass.EStructuralFeatures.forall [
			G ||- it
		]
	}
	
	rule Useless
		G ||- EStructuralFeature feat : EClass c
	from {
		fail
	}
	'''

	def testInvalidRuleInvocationIsNotOfExpectedType()
	'''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	import java.util.List
	
	judgments {
		type |- EClass c
		useless ||- EStructuralFeature f 
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		// a List<Boolean> is returned instead
		val List<Integer> result = eClass.EStructuralFeatures.map [
			G ||- it
		]
	}
	
	rule Useless
		G ||- EStructuralFeature feat 
	from {
		fail
	}
	'''

	def testRuleInvocationIsBooleanInClosures()
	'''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c
		useless ||- EStructuralFeature f
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		// rule invocations inside closures has boolean type
		// in case the judgment is a predicate
		eClass.EStructuralFeatures.forall [
			G ||- it
		]
	}
	
	rule Useless
		G ||- EStructuralFeature feat
	from {
		fail
	}
	'''

	def testRuleInvocationIsBooleanInIfExpression()
	'''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c
		useless ||- EStructuralFeature f
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		// rule invocations inside if has boolean type
		// in case the judgment is a predicate
		if ({G ||- eClass.EStructuralFeatures.head}) {
			println("OK")
		}
	}
	
	rule Useless
		G ||- EStructuralFeature feat
	from {
		fail
	}
	'''

	def testRuleInvocationsAsBooleanExpressions()
	'''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c
		useless ||- EStructuralFeature f
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		val features = eClass.EStructuralFeatures

		features.forall [
			// note that {} are required since a rule invocation
			// is NOT an expression
			{G ||- it} || eClass != null
		]
		
		features.forall [
			println("testing")
			G ||- it 
		]
		
	}
	
	rule Useless
		G ||- EStructuralFeature feat
	from {
		fail
	}
	'''

	def testForScopeOfThis() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EClass
	
	judgments {
		type |- EObject c : output EClass
			error "this " + clone(c.eClass) + " made an error!"
			source clone(c)
			feature clone(c.eClass).eContainingFeature
	}
	
	rule EObjectEClass
		G |- EObject obj : EClass eClass
	from {
		// clone is in the base runtime system
		// it should be visible through this
		eClass = clone(obj.eClass)
		
		// clone is in the base runtime system
		// it should be visible through this
		eClass.EAllStructuralFeatures.forEach [
			val e = clone(obj.eClass)
			println(e)
		]
	}
	
	checkrule EObjectEClassCheck
		for EObject obj
	from {
		// clone is in the base runtime system
		// it should be visible through this
		val eClass = clone(obj.eClass)
	}
	'''

	def testOutputParamFromInputParam() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	axiom EObjectEClass
		G |- EClass eClass : eClass
	'''
	
	def testVariableDeclarationAsOutputArgument() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		G |- o : var EClass e
	}
	'''

	def testDuplicateVariableDeclarationAsOutputArgument() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		var temp = c
		or
		{
			G |- o : var EClass temp
		}
	}
	'''
	
	def testScopingForVariableDeclarationAsOutputArgument() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		G |- o : var EClass e
		e.name == 'foo'
	}
	'''

	def testScopingForParameters() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		c.name != null
		o.eContainer != null
	}
	'''
	
	def testForBooleanVariableDeclaration() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		var Boolean b
	}
	'''
	
	def testForNonBooleanPremises() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		var Boolean b
		b = false
		if (b) { true } else { false }
		for (oo : o.eContents) {
			c.name == 'bar'
		}
	}
	'''
	
	def testWrongVariableDeclarationAsOutputArgument() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		G |- o : var EClass e = o.eClass
	}
	'''
	
	def testWrongVariableDeclarationAsInputArgument() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		G |- var EObject o2 : c
	}
	'''
	
	def testRuleInvocationWithOutputArgInsideClosure() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject obj : EClass eC
	from {
		obj.eClass.EAllStructuralFeatures.forEach [
			G |- obj : eC // cannot access output arg in closure
		]
	}
	'''

	def testAccessToVarInsideClosure() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject obj : EClass eClass
	from {
		var s = 'foo'
		eClass.EStructuralFeatures.forEach [
			println(s)
		]
	}
	'''

	def testAccessToOutputParamInsideClosure() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject obj : EClass eC
	from {
		eC.EStructuralFeatures.forEach [
			println(eC)
		]
	}
	'''

	def testVarDeclInRuleInvokationShadowsPreviousVariable() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject obj : EClass eClass
	from {
		var s = 'foo'
		println(s)
		G |- obj : var EClass s // s should shadow previous declaration
		s.EStructuralFeatures.forEach [
			println(it)
		]
	}
	'''	

	def testWrongReturnInPremises() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject obj : EClass eClass
	from {
		obj == obj
		return obj
	}
	'''

	def testCorrectReturnInAuxFunction_Issue_18() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EClass
	
	auxiliary {
		overrides(EObject c)
		isValue(EObject c) : Boolean
	}
	
	auxiliary overrides(EClass c) {
		return true
	}
	
	auxiliary isValue(EClass c) {
		return true
	}
	'''
	
	def testWrongThrowInPremises() '''
	«testJudgmentDescriptionsEObjectEClass»
	
	rule EObjectEClass
		G |- EObject obj : EClass eClass
	from {
		obj == obj
		throw new Exception('foo')
	}
	'''
	
	// Xtext 2.3
	
	def testRuleWithBooleanExpressionsWithNoSideEffect() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		'a' == new String() || 'bar' == new String()
		'a' == new String() + 'bar'.toFirstUpper
	}
	'''
	
	def testRuleWithBooleanExpressionsWithNoSideEffectInFor() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		for (s : eClass.EAllStructuralFeatures) {
			s.name != 'foo'
		}
	}
	'''

	def testRuleWithBooleanExpressionsWithNoSideEffectInIf() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		if (eClass != null) {
			object != 'foo'
		}
	}
	'''

	def testRuleWithBooleanExpressionsWithNoSideEffectInIf2() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		if (eClass != null)
			object != 'foo'
	}
	'''

	def testRuleWithBooleanExpressionsWithNoSideEffectInSwitch() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		switch (object) {
			EClass: { object.name != null }
			default: { object != 'foo' }
		}
	}
	'''

	def testRuleWithBooleanExpressionsWithNoSideEffectInSwitch2() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		switch (object) {
			EClass: object.name != null
			default: object != 'foo'
		}
	}
	'''
	
	def testForClosureWithExpressionWithNoSideEffect()
	'''«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EClass
	
	judgments {
		type |- EClass c
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		// boolean expressions inside block inside closure without side effect
		eClass.EStructuralFeatures.forEach [
			{ it.name != "foo" } // <- this is considered a boolean premise
		]
		
		// boolean expressions inside closures without side effect
		eClass.EStructuralFeatures.forEach [
			it.name != "foo"
		]
		
		// boolean expressions inside closures without side effect
		eClass.EStructuralFeatures.forEach [
			eClass.EStructuralFeatures.forEach [
				it.name != "foo"
			]
		]
	}
	'''

	def testForLambdaWithAuxiliaryFunctionWithNoSideEffect()
	'''«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	
	auxiliary {
		overrides(EObject c)
		isValue(EObject c) : Boolean
	}
	
	judgments {
		type |- EClass c
	}
	
	auxiliary overrides(EClass c) {
		true
	}
	
	auxiliary isValue(EClass c) {
		true
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		// boolean expressions inside closures without side effect
		eClass.EStructuralFeatures.forEach [
			overrides()
		]
		
		// boolean expressions inside closures without side effect
		eClass.EStructuralFeatures.forEach [
			eClass.EStructuralFeatures.forEach [
				isValue
			]
		]
	}
	'''

	def testFailSideEffect()
	'''«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		fail
			error stringRep(eClass)
	}
	'''

	def testFailInsideClosureSideEffect()
	'''«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		eClass.EStructuralFeatures.forEach [
			fail
		]
	}
	'''

	def testFailWithErrorSpecificationInsideClosureSideEffect()
	'''«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EClass c
	}
	
	rule TestForClosures
		G |- EClass eClass
	from {
		eClass.EStructuralFeatures.forEach [
			fail
				error "" + stringRep(eClass)
		]
	}
	'''
	
	def testBooleanExpressionsInIf() '''
	«testJudgmentDescriptionsReferringToEcore»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		if (eClass.name != 'foo') { true } else { false }
		val s = 'foo'
	}
	'''
	
	def testNoSideEffectButNoError() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		eClass.name + 'foo'
	}
	'''
	
	def testErrorNoSideEffect() '''
	«testJudgmentDescriptionsReferringToEClassEObject»
	
	rule EClassEObject derives
		G |- EClass eClass : EObject object
	from {
		eClass.name + 'foo'
		print(eClass.name)
	}
	'''

	def testSystemWithInjections() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	/* a utility field */
	inject List<String> strings
	inject String myString
	/* another utility field */
	inject List<EClass> eClasses
	inject List<EClass> classes
	
	judgments {
		type |- EObject o : output EClass
	}
	'''

	def testSystemWithDuplicateInjections() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	/* a utility field */
	inject List<String> strings
	inject String strings
	'''

	def testAccessToInjectedFields() '''
	«testSystemWithInjections»
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		println(o)
		println(myString)
		strings.add(myString)
		eClasses.add(o.eClass)
	}
	'''

	def testInjectedExtensionFields() '''
	system org.eclipse.xsemantics.test.TypeSystem
	
	import org.eclipse.xsemantics.dsl.tests.input.MyTestExtensions
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EClass
	
	/* a utility field */
	inject extension MyTestExtensions myextensions
	
	judgments {
		type |- EObject o : output EClass
	}
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		val list = newArrayList()
		list.printList // printList comes from MyTestExtensions
	}
	'''

	def testAccessToInjectedFieldsInExpressionInConclusion() '''
	«testSystemWithInjections»
	
	axiom EObjectEClass
		G |- EObject o : classes.get(0)
	'''

	def testAccessToThisInExpressionInConclusion() '''
	«testSystemWithInjections»
	
	axiom EObjectEClass
		G |- EObject o : 
		{ 
			println(this);
			clone(o).eClass
		}
	'''

	def testAxiomWithTwoExpressionsInConclusion() '''
	«testJudgmentDescriptionsWith2OutputParams»
	
	axiom TwoExpressionsInConclusion
		G |- EClass cl : cl : cl.EAllStructuralFeatures.head
	'''

	def testRuleWithTwoExpressionsInConclusion() '''
	«testJudgmentDescriptionsWith2OutputParams»
	
	rule TwoExpressionsInConclusion
		G |- EClass cl : cl : cl.EAllStructuralFeatures.head
	from {
		println(cl.name)
	}
	'''

	def testSystemWithValidatorExtends() '''
	system org.eclipse.xsemantics.test.TypeSystem
	
	validatorExtends org.eclipse.xtext.validation.AbstractDeclarativeValidator
	'''

	def testCheckRuleWithValidatorExtends() '''
	«testSystemWithValidatorExtends»
	
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EObject c : output EClass
	}
	
	axiom EObjectEClass
		G |- EObject object : object.eClass
	
	checkrule CheckEObject for
		EObject obj
	from {
		var EClass result
		empty |- obj : result
	}
	'''

	def testSystemWithValidatorExtendsNotAbstractDeclarativeValidator() '''
	system org.eclipse.xsemantics.test.TypeSystem
	
	validatorExtends org.eclipse.emf.ecore.EClass
	'''

	def testSystemExtends() '''
	system org.eclipse.xsemantics.test.TypeSystem extends org.eclipse.xsemantics.runtime.XsemanticsRuntimeSystem
	'''

	def testSystemExtendsTestBaseSystem() '''
	system org.eclipse.xsemantics.test.TypeSystem extends org.eclipse.xsemantics.dsl.tests.input.TestBaseSystem
	'''

	def testSystemExtendsInvalidBaseSystem() '''
	system org.eclipse.xsemantics.test.TypeSystem extends org.eclipse.xsemantics.dsl.tests.input.TestInvalidBaseSystem
	'''

	def testSystemExtendsSystemWithJudgments() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem 
		extends org.eclipse.xsemantics.test.TypeSystem
	'''

	def testSystemExtendsSystem2() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem2 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem
	'''

	def testSystemExtendsSystemWithJudgmentsReferringToEcore() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem 
		extends org.eclipse.xsemantics.test.TypeSystem
	
	import org.eclipse.emf.ecore.*
	
	judgments {
		subtype |- EClass c1 <: EClass c2
	}
	'''

	def testSystemExtendsExtendedTypeSystem() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem2 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem
	
	import org.eclipse.emf.ecore.*
	
	judgments {
		type2 ||- EClass c1 : EClass c2
	}
	
	// the judgment is defined in TypeSystem
	rule FromTypeSystem
		G |- EObject c : c.eClass
	from {
		G |- c.eClass <: c.eClass
	}
	
	// the judgment is defined in ExtendedTypeSystem
	rule FromExtendedTypeSystem
		G |- EClass c1 <: EClass c2
	from {
		G ||- c1 : c2
	}
	
	// the judgment is defined here
	rule FromThisTypeSystem
		G ||- EClass c1 : EClass c2
	from {
		G |- c1 : var EClass o
	}
	
	checkrule CheckEObject for
		EObject o
	from {
		empty |- o : var EClass c
		empty |- o.eClass <: c
	}
	'''

	def testRuleOverride() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystemWithRuleOverride 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	
	import org.eclipse.emf.ecore.*
	
	// the judgment is defined in TypeSystem
	override axiom FromTypeSystem
		G |- EObject c : c.eClass
	
	// the judgment is defined in ExtendedTypeSystem
	override rule FromExtendedTypeSystem
		G |- EClass c1 <: EClass c2
	from {
		G ||- c1 : c2
	}
	
	// the judgment is defined here
	override rule FromThisTypeSystem
		G ||- EClass c1 : EClass c2
	from {
		G |- c1 : var EClass o
	}
	
	override checkrule CheckEObject for
		EObject o
	from {
		empty |- o : var EClass c
		empty |- o.eClass <: c
	}
	'''

	def testInvalidRuleOverrideWithoutSystemExtends() '''
	system org.eclipse.xsemantics.test.TypeSystem
	
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EObject c : output EClass
	}
	
	// the judgment is defined in TypeSystem
	override axiom FromTypeSystem
		G |- EObject c : c.eClass
	
	override checkrule CheckEObject for
		EObject o
	from {
		empty |- o : var EClass c
		empty |- o.eClass <: c
	}
	'''

	/* TypeSystem -> ExtendedTypeSystem2 -> ExtendedTypeSystem -> TypeSystem */
	def testSystemBaseWithCycle() '''
	system org.eclipse.xsemantics.test.TypeSystem
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	'''

	def testSystemBaseWithCycle2() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem2 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem
	'''

	def testSystemExtendsWithValidatorExtends() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem 
		extends org.eclipse.xsemantics.test.TypeSystem
	
	validatorExtends org.eclipse.xtext.validation.AbstractDeclarativeValidator
	'''

	def testDuplicateRuleOfTheSameKindFromSuperSystem() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystemWithRuleOverride 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	
	import org.eclipse.emf.ecore.*
	
	// the rule is already defined in TypeSystem
	// so an 'override' is mandatory
	axiom FromTypeSystem
		G |- EObject c : c.eClass
	'''

	def testDuplicateRuleOfTheSameKindFromSuperSystemButWithDifferentName() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystemWithRuleOverride 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	
	import org.eclipse.emf.ecore.*
	
	// a rule of the same kind is already defined in TypeSystem
	// but with a different name!
	axiom MyRuleWithDifferentName
		G |- EObject c : c.eClass
	'''

	def testDuplicateCheckRuleOfTheSameKindFromSuperSystem() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystemWithRuleOverride 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	
	import org.eclipse.emf.ecore.*
	
	// the checkrule is already defined in TypeSystem
	// so an 'override' is mandatory
	checkrule CheckEObject for
		EObject o
	from {
		
	}
	'''

	def testNoRuleOfTheSameKindToOverride() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystemWithRuleOverride 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	
	import org.eclipse.emf.ecore.*
	
	// no rule to override in the base system with EClass, EClass
	override axiom FromTypeSystem
		G |- EClass o : EClass c
	'''	

	def testOverrideRuleWithDifferentName() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystemWithRuleOverride 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	
	import org.eclipse.emf.ecore.*
	
	// override rule must have the same name
	// of the one in the base system
	override axiom DifferentName
		G |- EObject o : EClass c
	'''

	def testNoCheckRuleToOverride() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystemWithRuleOverride 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	
	import org.eclipse.emf.ecore.*
	
	// wrong name of override rule
	override checkrule WrongCheckEObject for
		EObject o
	from {
		
	}
	
	// wrong element type
	override checkrule CheckEObject for
		EClass o
	from {
		
	}
	'''

	def testWrongAuxiliaryDescriptionOverride() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem
		extends org.eclipse.xsemantics.test.TypeSystem
	
	import org.eclipse.emf.ecore.*
	
	auxiliary {
		isValue(EObject o, EClass c) : Boolean // must override
		override voidFun(EClass o) // must override with the same parameter type
		override objectClass(EObject o) : EObject // must override with the same return type
	}
	'''

	def testInvalidJudgmentWithTheSameNameOfBaseSystem() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem3 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem
	
	import org.eclipse.emf.ecore.*

	// type judgment already defined in inherited system
	judgments {
		type ||- EClass c1 : EClass c2
	}
	'''

	def testOverrideJudgment() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystemWithJudgmentOverride
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject

	// type judgment already defined in inherited system
	// and we override it, so that's OK
	judgments {
		override type |- EObject obj : output EClass
		
		override subtype |- EClass c1 <: EClass c2
			error stringRep(c1) + " not <: " + stringRep(c2)
				source c1
				feature c1.eClass.eContainingFeature
	}
	'''

	def testOverrideJudgmentWithDifferentParamNames() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystemWithJudgmentOverride
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem2
	
	import org.eclipse.emf.ecore.*

	// type judgment already defined in inherited system
	// and we override it, with different param names
	judgments {
		override subtype |- EClass left <: EClass right
	}
	'''

	def testForJudgmentParameters() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		type0 |- EClass c : output EObject
		type1 ||- EClass c : output EObject
		type2 |~ EClass c : EObject o
		type3 |~ EClass c 
	}
	'''
	
	def testForAuxiliaryDescriptionEquals() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	auxiliary {
		aux0(EClass c) : EObject
		aux1(EClass c) : EObject
		aux2(EClass c, EObject o)
		aux3(EClass c)
	}
	'''

	def testInvalidOverrideWithoutSystemExtends() '''
	system org.eclipse.xsemantics.test.TypeSystem
	
	import org.eclipse.emf.ecore.*
	
	auxiliary {
		override isValue(EObject c)
	}
	
	judgments {
		override type |- EObject c : output EClass
	}
	'''

	def testInvalidOverrideJudgment() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem2 
		extends org.eclipse.xsemantics.test.ExtendedTypeSystem
	
	import org.eclipse.emf.ecore.*

	judgments {
		// EClass was output in the base system
		override type |- EObject obj : EClass c
		// different name of the judgment to override
		override subtype2 |- EClass c1 <: EClass c2
	}
	'''

	def testErrorSpecifications() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		// the judgment has an error specification
		type |- EObject c : output EClass
			error "this " + c + " made an error!"
			source c
			feature c.eClass.eContainingFeature
			data #["some", "additional", "data", c]
		
		subtype |- EObject left <: EObject right
	}
	
	axiom TypeEObject
		G |- EObject o : o.eClass
	
	// this rule has its own error specification
	axiom TypeEClass
		G |- EClass c : c
			error "unexpected error!"
			source c
			feature c.eClass.eContainingFeature
			data #["some", "additional", "data", c]
	
	// this rule has its own error specification
	rule SubtypeEObject
		G |- EObject left <: EObject right
			error "Unhandled case"
			source left
	from { fail }
	
	// this rule fails with its own error specification
	rule SubtypeEStructuralFeature
		G |- EStructuralFeature left <: EObject right
	from { 
		fail
			error "Unhandled case"
			source left
			data #["some", "additional", "data", left, right]
	}
	
	rule SubtypeEClass
		G |- EClass left <: EClass right
	from { right.isSuperTypeOf(left) }
	'''

	def testBaseSystemWithValidatorExtends() '''
	system org.eclipse.xsemantics.test.TypeSystem
	
	validatorExtends org.eclipse.xtext.validation.AbstractDeclarativeValidator
	
	import org.eclipse.emf.ecore.*
	
	judgments {
		type |- EObject c : output EClass
	}
	
	checkrule CheckEObject for
		EObject o
	from {
		
	}
	'''

	def testSystemExtendsSystemWithValidatorExtends() '''
	system org.eclipse.xsemantics.test.ExtendedTypeSystem
		extends org.eclipse.xsemantics.test.TypeSystem
	
	import org.eclipse.emf.ecore.*
	
	override checkrule CheckEObject for
		EObject o
	from {
		
	}
	
	checkrule CheckEClass for
		EClass o
	from {
		
	}
	'''

	def testAuxiliaryDescriptionsWithoutAuxFun() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	
	auxiliary {
		isValue(EObject o, EClass c) : Boolean
		voidFun(EObject o)
		objectClass(EObject o) : EClass
			error "error in objectClass"
			source o
	}
	'''

	def testAuxiliaryDescriptions() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EStructuralFeature
	
	auxiliary {
		isValue(EObject o, EClass c) : Boolean
		voidFun(EObject o)
		objectClass(EObject o) : EClass
			error "error in objectClass"
			source o
	}
	'''

	def testDuplicateAuxiliaryDescriptions() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	auxiliary {
		foo(EObject o)
		foo(EClass o) : EClass
	}
	'''

	def testAuxiliaryFunctions() '''
	«testAuxiliaryDescriptions»
	
	auxiliary isValue(EObject eO, EClass eC) {
		eO.eClass == eC
	}
	
	auxiliary objectClass(EObject o) {
		o.eClass
	}
	
	auxiliary voidFun(EObject o) {
		println(o)
		true
	}
	
	auxiliary voidFun(EStructuralFeature o) {
		println(o)
	}
	'''

	def testAuxiliaryFunctionWithWrongReturnExpression() '''
	«testAuxiliaryDescriptions»
	
	auxiliary isValue(EObject eO, EClass eC) {
		eO.eClass
	}
	'''

	def testAuxiliaryFunctionsInvocation() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	auxiliary {
		objectClass(EObject o) : EClass
			error "error in objectClass()"
			source o
	}
	
	judgments {
		type |- EObject o : output EClass
	}
	
	auxiliary objectClass(EObject o) {
		o.eClass
	}
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		objectClass(o)
		c = objectClass(o)
	}
	
	checkrule CheckEObject
		for EObject o
	from {
		objectClass(o) != null
	}
	'''

	def testAuxiliaryDescriptionWithTheSameNameOfJudgment() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	auxiliary {
		foo(EObject o)
	}
	
	judgments {
		foo |- EClass c
	}
	'''

	def testAuxiliaryFunctionWithoutAuxiliaryDescription() '''
	«testAuxiliaryDescriptions»
	
	auxiliary foobar(EObject eO, EClass eC) {
		eO.eClass == eC
	}
	'''

	def testNonConformantAuxiliaryFunction() '''
	«testAuxiliaryDescriptions»
	
	// the second param EObject is not subtype of
	// EClass as specified in the description
	auxiliary isValue(EClass eO, EObject eC) {
		eO == eC
	}
	
	// wrong number of parameters w.r.t. auxiliary description
	auxiliary voidFun(EObject o, String s) {
		
	}
	'''

	def testDuplicateAuxiliaryFunctionsWithSameParameterTypes_Issue_9() '''
	«testAuxiliaryDescriptions»
	
	auxiliary isValue(EClass eO, EClass eC) {
		eO == eC
	}
	
	// they must differ for the parameters
	auxiliary isValue(EClass e1, EClass e2) {
		true
	}
	'''

	def testForUnresolvedTypeTypeReferences() '''
	«testAuxiliaryDescriptions»
	
	auxiliary isValue(FooBar eO, EClass eC) {
		eO == eC
	}
	
	// they must differ for the parameters
	auxiliary isValue(FooBar e1, EClass e2) {
		true
	}
	'''

	def testExpressionsInConclusion() '''
	«testJudgmentDescriptionsReferringToEcore3WithOutput»
	
	axiom TestRule
		G ||- EClass c : c.getEIDAttribute : c.getEAllStructuralFeatures.get(0)
	'''

	def testVisibilityForVarDeclInRuleInvocation() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EClass
	
	judgments {
		type |- EObject o : output EClass : Object o2
	}
	
	rule TestRule
		G |- EObject o : EClass c : Object oo
	from {
		G |- o : var EClass cc : cc // <- cc must not be resolvable
		cc.name
	}
	'''

	def testStaticImport() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EClass
	
	import static org.eclipse.xtext.EcoreUtil2.*
	
	judgments {
		type |- EObject o : output EClass
	}
	
	axiom TestRule
		G |- EObject o : getContainerOfType(o, typeof(EClass))
	'''

	def testStaticExtensionImport() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EClass
	
	import static extension org.eclipse.xtext.EcoreUtil2.*
	
	judgments {
		type |- EObject o : output EClass
	}
	
	axiom TestRule
		G |- EObject o : o.getContainerOfType(typeof(EClass))
	'''

	def testInstanceOfAsPremise_Issue_1() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	
	judgments {
		type |- EObject o : output EClass
	}
	
	rule TestRule
		G |- EObject o : EClass c
	from {
		o instanceof EClass
	}
	'''

	def testPredicateJudgments() '''
	«typeSystemQualifiedName»
	import org.eclipse.emf.ecore.EClass
	import org.eclipse.emf.ecore.EObject
	
	judgments {
		nonPredicateJudgment |- EObject o : output EClass
		predicateJudgment ||- EObject o : EClass c
	}
	
	rule TestRuleInvokesPredicateJudgment
		G |- EObject o : EClass c
	from {
		G ||- o : c
	}

	rule TestRuleInvokesNonPredicateJudgment
		G ||- EObject o : EClass c
	from {
		G |- o : var EClass result
	}
	'''

	def testOperatorsWithSlashes_Issue_6() '''
	«testFileWithImports»
	import org.eclipse.emf.ecore.*
	
	judgments {
		typeUnion        ||- EClass c \/ EObject o
		typeIntersection ||- EClass c /\ EObject o
	}
	
	rule UnionRule derives
		G ||- EClass eClass \/ EObject object
	from {
		G ||- object.eClass /\ eClass
		G ||- object.eClass \/ eClass
	}
	
	rule IntersectionRule derives
		G ||- EClass eClass /\ EObject object
	from {
		G ||- object.eClass /\ eClass
		G ||- object.eClass \/ eClass
	}
	'''

	def typeSystemWithNoPackage() '''
	system TypeSystem
	
	auxiliary {
		foo(Object o)
	}
	
	judgments {
		type |- Object o
	}
	
	auxiliary foo(String s) { true }
	
	axiom Type G |- String s
	'''

	def typeInvalidUseOfPrimitiveTypes_Issue_17() '''
	system TypeSystem
	
	inject int i
	
	auxiliary {
		foo(Object o) : int
	}
	
	judgments {
		type |- Object o : output boolean 
	}
	
	auxiliary foo(String s) { 0 }
	
	axiom Type G |- String s : true
	'''

	def typeCorrectUseOfPrimitiveTypes_Issue_17() '''
	system TypeSystem
	
	auxiliary {
		foo(Object o) : Integer
	}
	
	judgments {
		type |- Object o : output Boolean
	}
	
	auxiliary foo(String s) { 
		val int i = 0
		i
	}
	
	rule Type G |- String s : Boolean b
	from {
		val boolean b1 = true
		b = b1
	}
	'''

	def cachedDescriptions() '''
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EClass
	import java.util.List
	
	«typeSystemQualifiedName»
	
	auxiliary {
		eclasses(EObject o) : List<EClass> cached
		auxnocacheentryPoints(EObject o) : Boolean cached { condition=(!(o instanceof EClass)) }
	}
	
	judgments {
		type |- EObject o : output EClass cached
		nocacheentryPoints ||- EObject o : output EClass cached { entryPoints=NONE }
		withCacheCondition |= EObject o : output EClass 
			cached { 
				condition = (!environment.isEmpty() && !(o instanceof EClass))
			}
		withCacheConditionBlock |= EObject o :> output EClass 
			cached { 
				condition = { (!environment.isEmpty() && !(o instanceof EClass)) }
			}
	}
	'''

	def testFields() '''
	system org.eclipse.xsemantics.test.TypeSystem
	
	import org.eclipse.xsemantics.dsl.tests.input.MyTestExtensions
	import org.eclipse.emf.ecore.EObject
	import org.eclipse.emf.ecore.EClass
	import com.google.^inject.Inject
	
	/* a utility field with annotation */
	@Inject
	var extension MyTestExtensions myextensions

	/* final field */
	val MyTestExtensions finalField = new MyTestExtensions()

	/* non final field */
	var MyTestExtensions nonFinalField = new MyTestExtensions()

	/* inferred type for field */
	var inferredTypeField = new MyTestExtensions()

	judgments {
		type |- EObject o : output EClass
	}
	
	rule EObjectEClass
		G |- EObject o : EClass c
	from {
		val list = newArrayList()
		list.printList // printList comes from MyTestExtensions
	}
	'''
}
