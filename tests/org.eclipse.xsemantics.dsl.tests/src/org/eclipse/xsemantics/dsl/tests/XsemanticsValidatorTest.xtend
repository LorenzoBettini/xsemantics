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

package org.eclipse.xsemantics.dsl.tests

import com.google.inject.Inject
import org.eclipse.xsemantics.dsl.xsemantics.XsemanticsPackage
import org.eclipse.xsemantics.dsl.xsemantics.XsemanticsSystem
import org.eclipse.xtext.common.types.TypesPackage
import org.eclipse.xtext.diagnostics.Diagnostic
import org.eclipse.xtext.diagnostics.Severity
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.eclipse.xtext.xbase.XbasePackage
import org.eclipse.xtext.xbase.validation.IssueCodes
import org.junit.Test
import org.junit.runner.RunWith

import static org.eclipse.xsemantics.dsl.validation.XsemanticsValidator.*

@InjectWith(typeof(XsemanticsInjectorProvider))
@RunWith(typeof(XtextRunner))
class XsemanticsValidatorTest extends XsemanticsBaseTest {
	
	@Inject extension ValidationTestHelper
	
	@Test
	def void testCyclicHierarchy() {
		parseSystems(
			testFiles.testSystemBaseWithCycle,
			testFiles.testSystemExtendsSystemWithJudgmentsReferringToEcore,
			testFiles.testSystemBaseWithCycle2).
		assertError(
			XsemanticsPackage::eINSTANCE.xsemanticsSystem,
			CYCLIC_HIERARCHY,
			"Cycle in extends relation"
		)
	}

	@Test
	def void testSystemExtendsWithValidatorExtends() {
		parseSystems(
			testFiles.testJudgmentDescriptions,
			testFiles.testSystemExtendsWithValidatorExtends
		).
		assertError(
			XsemanticsPackage::eINSTANCE.xsemanticsSystem,
			EXTENDS_CANNOT_COEXIST_WITH_VALIDATOR_EXTENDS,
			"system 'extends' cannot coexist with 'validatorExtends'"
		)
	}

	@Test
	def void testInvalidRuleOverrideWithoutSystemExtends() {
		val ts = testFiles.testInvalidRuleOverrideWithoutSystemExtends.parse
		ts.assertError(
			XsemanticsPackage::eINSTANCE.rule,
			OVERRIDE_WITHOUT_SYSTEM_EXTENDS,
			"Cannot override rule without system 'extends'"
		)
		ts.assertError(
			XsemanticsPackage::eINSTANCE.checkRule,
			OVERRIDE_WITHOUT_SYSTEM_EXTENDS,
			"Cannot override checkrule without system 'extends'"
		)
	}

	@Test
	def void testDuplicateRuleOfTheSameKindFromBaseSystem() {
		parseWithBaseSystems(
			testFiles.testDuplicateRuleOfTheSameKindFromSuperSystem
		).
		assertError(
			XsemanticsPackage::eINSTANCE.rule,
			DUPLICATE_RULE_WITH_SAME_ARGUMENTS,
			"Duplicate rule of the same kind with parameters: EObject, in system: org.eclipse.xsemantics.test.ExtendedTypeSystem2"
		)
	}

	@Test
	def void testDuplicateRuleOfTheSameKindFromSuperSystemButWithDifferentName() {
		parseWithBaseSystems(
			testFiles.testDuplicateRuleOfTheSameKindFromSuperSystemButWithDifferentName
		).
		assertError(
			XsemanticsPackage::eINSTANCE.rule,
			DUPLICATE_RULE_WITH_SAME_ARGUMENTS,
			"Duplicate rule of the same kind with parameters: EObject, in system: org.eclipse.xsemantics.test.ExtendedTypeSystem2"
		)
	}

	@Test
	def void testDuplicateCheckRuleOfTheSameKindFromBaseSystem() {
		parseWithBaseSystems(
			testFiles.testDuplicateCheckRuleOfTheSameKindFromSuperSystem
		).
		assertError(
			XsemanticsPackage::eINSTANCE.checkRule,
			MUST_OVERRIDE,
			"checkrule 'CheckEObject' must override checkrule, in system: org.eclipse.xsemantics.test.ExtendedTypeSystem2"
		)
	}

	@Test
	def void testNoRuleOfTheSameKindToOverride() {
		parseWithBaseSystems(
			testFiles.testNoRuleOfTheSameKindToOverride
		).
		assertError(
			XsemanticsPackage::eINSTANCE.rule,
			NOTHING_TO_OVERRIDE,
			"No rule to override: FromTypeSystem"
		)
	}
	
	@Test
	def void testOverrideRuleWithDifferentName() {
		parseWithBaseSystems(
			testFiles.testOverrideRuleWithDifferentName
		).
		assertError(
			XsemanticsPackage::eINSTANCE.rule,
			NOTHING_TO_OVERRIDE,
			"No rule to override: DifferentName"
		)
	}

	@Test
	def void testNoCheckRuleToOverride() {
		val ts = parseWithBaseSystems(
			testFiles.testNoCheckRuleToOverride
		)
		ts.assertError(
			XsemanticsPackage::eINSTANCE.checkRule,
			NOTHING_TO_OVERRIDE,
			"No checkrule to override: WrongCheckEObject"
		)
		ts.assertError(
			XsemanticsPackage::eINSTANCE.checkRule,
			NOTHING_TO_OVERRIDE,
			"No checkrule to override: CheckEObject"
		)
	}

	@Test
	def void testInvalidJudgmentWithTheSameNameOfBaseSystem() {
		parseWithBaseSystems(
			testFiles.testInvalidJudgmentWithTheSameNameOfBaseSystem
		).
		assertErrorMessages(
'''
judgment 'type' must override judgment, in system: org.eclipse.xsemantics.test.TypeSystem
'''	
		)
	}

	@Test
	def void testInvalidJudgmentOverrideWithoutSystemExtends() {
		val ts = testFiles.testInvalidOverrideWithoutSystemExtends.parse
		ts.assertError(
			XsemanticsPackage.eINSTANCE.judgmentDescription,
			OVERRIDE_WITHOUT_SYSTEM_EXTENDS,
			"Cannot override judgment without system 'extends'"
		)
		ts.assertError(
			XsemanticsPackage.eINSTANCE.auxiliaryDescription,
			OVERRIDE_WITHOUT_SYSTEM_EXTENDS,
			"Cannot override auxiliary description without system 'extends'"
		)
	}

	@Test
	def void testInvalidOverrideJudgment() {
		val ts = parseWithBaseSystems(
			testFiles.testInvalidOverrideJudgment
		)
		ts.assertError(
			XsemanticsPackage::eINSTANCE.judgmentDescription,
			NOTHING_TO_OVERRIDE,
			"No judgment to override: type"
		)
		ts.assertError(
			XsemanticsPackage::eINSTANCE.judgmentDescription,
			NOTHING_TO_OVERRIDE,
			"No judgment to override: subtype2"
		)
	}

	@Test
	def void testWrongAuxiliaryDescriptionOverride() {
		val ts = parseSystems(
			testFiles.testAuxiliaryDescriptions,
			testFiles.testWrongAuxiliaryDescriptionOverride
		)
		ts.assertError(
			XsemanticsPackage.eINSTANCE.auxiliaryDescription,
			MUST_OVERRIDE,
			"auxiliary description 'isValue' must override auxiliary description, in system: org.eclipse.xsemantics.test.TypeSystem"
		)
		ts.assertError(
			XsemanticsPackage.eINSTANCE.auxiliaryDescription,
			NOTHING_TO_OVERRIDE,
			"No auxiliary description to override: voidFun"
		)
		ts.assertError(
			XsemanticsPackage.eINSTANCE.auxiliaryDescription,
			NOTHING_TO_OVERRIDE,
			"No auxiliary description to override: objectClass"
		)
	}

	@Test
	def testNoRuleForJudgmentDescriptionOverridden() {
		systemExtendsSystemWithJudgmentOverride.parseSystemsAndAssertNoErrors.
			assertNoIssues
	}

	@Test
	def testDuplicateAuxiliaryDescriptions() {
		testFiles.testDuplicateAuxiliaryDescriptions.
		assertErrorMessages(
'''
Duplicate name 'foo' (AuxiliaryDescription)
Duplicate name 'foo' (AuxiliaryDescription)
'''
		)
	}

	@Test
	def testAuxiliaryFunctionWithWrongReturnExpression() {
		parser.parse(testFiles.testAuxiliaryFunctionWithWrongReturnExpression).
			assertError(
			XbasePackage::eINSTANCE.XMemberFeatureCall,
			IssueCodes.INCOMPATIBLE_TYPES,
			"Type mismatch: cannot convert from EClass to Boolean"
		)
	}

	@Test
	def testAuxiliaryDescriptionWithTheSameNameOfJudgment() {
		testFiles.testAuxiliaryDescriptionWithTheSameNameOfJudgment.
		assertErrorMessages(
'''
Duplicate name 'foo' (JudgmentDescription)
Duplicate name 'foo' (AuxiliaryDescription)
'''
		)
	}

	@Test
	def testAuxiliaryFunctionWithoutAuxiliaryDescription() {
		parser.parse(testFiles.testAuxiliaryFunctionWithoutAuxiliaryDescription).
			assertError(
			XsemanticsPackage::eINSTANCE.auxiliaryFunction,
			NO_AUXDESC_FOR_AUX_FUNCTION,
			"No auxiliary description for auxiliary function 'foobar'"
		)
	}

	@Test
	def testNonConformantAuxiliaryFunction() {
		val s = parser.parse(testFiles.testNonConformantAuxiliaryFunction)
		s.assertError(
			XsemanticsPackage::eINSTANCE.auxiliaryFunction,
			PARAMS_SIZE_DONT_MATCH,
			"expected 1 parameter(s), but was 2"
		)
		s.assertError(
			TypesPackage::eINSTANCE.jvmFormalParameter,
			NOT_SUBTYPE,
			"parameter type EObject is not subtype of AuxiliaryDescription declared type EClass"
		)
	}

	@Test
	def testDuplicateAuxiliaryFunctionsWithSameParameterTypes_Issue_9() {
		val s = parser.parse(testFiles.testDuplicateAuxiliaryFunctionsWithSameParameterTypes_Issue_9)
		s.assertError(
			XsemanticsPackage.eINSTANCE.auxiliaryFunction,
			DUPLICATE_AUXFUN_WITH_SAME_ARGUMENTS,
			"Duplicate auxiliary function of the same kind with parameters: EClass, EClass"
		)
	}

	@Test
	def testInvalidRuleInvocationIsVoidInClosures() {
		val s = parser.parse(testFiles.testRuleInvocationIsVoidInClosures)
		s.assertError(
			XsemanticsPackage::eINSTANCE.ruleInvocation,
			IssueCodes.INCOMPATIBLE_TYPES,
			"Type mismatch: cannot convert from void to Boolean"
		)
	}

	@Test
	def testInvalidRuleInvocationIsNotOfExpectedType() {
		val s = parser.parse(testFiles.testInvalidRuleInvocationIsNotOfExpectedType)
		s.assertError(
			XsemanticsPackage::eINSTANCE.ruleInvocation,
			IssueCodes.INCOMPATIBLE_TYPES,
			"Type mismatch: cannot convert from boolean to Integer"
		)
	}

	@Test
	def void testAccessToVarInsideClosure() {
		parser.parse(testFiles
				.testAccessToVarInsideClosure()).
		assertError(
			XbasePackage::eINSTANCE.XFeatureCall,
			IssueCodes.INVALID_MUTABLE_VARIABLE_ACCESS,
			"Cannot refer to the non-final variable s inside a lambda expression"
		)
	}

	@Test
	def void testVarDeclInRuleInvokationShadowsPreviousVariable() {
		parser.parse(testFiles
				.testVarDeclInRuleInvokationShadowsPreviousVariable()).
		assertError(
			XbasePackage::eINSTANCE.XVariableDeclaration,
			IssueCodes.VARIABLE_NAME_SHADOWING,
			"Duplicate local variable s"
		)
	}

	@Test
	def void testDuplicateParamNamesInRule() {
		parser.parse(testFiles
				.testDuplicateParamsInRule()).
		assertError(
			XsemanticsPackage::eINSTANCE.ruleParameter,
			IssueCodes.VARIABLE_NAME_SHADOWING,
			"Duplicate local variable eClass"
		)
	}

	@Test
	def void testVisibilityForVarDeclInRuleInvocation() {
		parser.parse(testFiles
				.testVisibilityForVarDeclInRuleInvocation()).
		assertError(
			XbasePackage::eINSTANCE.XFeatureCall,
			Diagnostic::LINKING_DIAGNOSTIC,
			"The method or field cc is undefined"
		)
	}

	@Test
	def void testDuplicateInjectedFields() {
		testFiles.testSystemWithDuplicateInjections.
		assertErrorMessages(
'''
Duplicate name 'strings' (Injected)
Duplicate name 'strings' (Injected)
'''
		)
	}

	@Test
	def void testDuplicateFields() {
		'''
		system Test
		
		/* a utility field */
		val int strings = 0
		val String strings = ""
		'''.
		assertErrorMessages(
'''
Duplicate name 'strings' (FieldDefinition)
Duplicate name 'strings' (FieldDefinition)
'''
		)
	}

	@Test
	def void testDuplicateFieldAndInjectedField() {
		'''
		system Test
		
		/* a utility field */
		inject Boolean strings
		val String strings = ""
		'''.
		assertErrorMessages(
'''
Duplicate name 'strings' (Injected)
Duplicate name 'strings' (FieldDefinition)
'''
		)
	}

	@Test
	def void testFinalFieldNotInitialized() {
		'''
		system Test
		
		val String string1 // final field not initialized
		var String string2 // OK non final field, no initialization required
		'''.
		assertErrorMessages(
'''
The final field string1 may not have been initialized
'''
		)
	}

	@Test
	def void testFieldWithoutDeclaredTypeNotInitialized() {
		'''
		system Test

		var foo1 // no type, so an initialization is required
		var foo2 = "foo" // OK: no declared type, but initialization expression provided
		'''.
		assertErrorMessages(
'''
The field foo1 needs an explicit type since there is no initialization expression to infer the type from.
'''
		)
	}

	@Test
	def void testWrongEnvironmentXExpression() {
		parser.parse(testFiles.testWrongEnvironmentXExpression).
		assertError(
			XbasePackage::eINSTANCE.XStringLiteral,
			IssueCodes.INCOMPATIBLE_TYPES,
			"Type mismatch: cannot convert from String to RuleEnvironment"
		)
	}

	@Test
	def void testWrongEnvironmentXExpression2() {
		parser.parse(testFiles.testWrongEnvironmentXExpression2).
		assertError(
			XbasePackage::eINSTANCE.XStringLiteral,
			IssueCodes.INCOMPATIBLE_TYPES,
			"Type mismatch: cannot convert from String to RuleEnvironment"
		)
	}

	@Test
	def void testErrorSpecificationFeatureNotEStructuralFeature() {
		parser.parse(testFiles.testErrorSpecificationFeatureNotEStructuralFeature).
		assertError(
			XbasePackage::eINSTANCE.XMemberFeatureCall,
			IssueCodes.INCOMPATIBLE_TYPES,
			"Type mismatch: cannot convert from EClass to EStructuralFeature"
		)
	}

	@Test
	def void testErrorSpecificationSourceNotEObject() {
		parser.parse(testFiles.testErrorSpecificationSourceNotEObject).
		assertError(
			XbasePackage::eINSTANCE.XMemberFeatureCall,
			IssueCodes.INCOMPATIBLE_TYPES,
			"Type mismatch: cannot convert from String to EObject"
		)
	}

	@Test
	def void testErrorSpecificationDataVoid() {
		testFiles.testErrorSpecificationDataVoid.
			assertErrorMessages(
'''
Type mismatch: type void is not applicable at this location
'''
			)
	}

	@Test
	def void testJudgmentDescriptionsWithDuplicates() {
		testFiles.testJudgmentDescriptionsWithDuplicates.
			assertErrorMessages(
'''
Duplicate name 'type' (JudgmentDescription)
Duplicate name 'type' (JudgmentDescription)
Duplicate name 'type' (JudgmentDescription)
'''
			)
	}

	@Test
	def void testDuplicateRuleNames() {
		testFiles.testDuplicateRuleNames.
			assertErrorMessages(
'''
Duplicate name 'Foo' (Axiom)
Duplicate name 'Foo' (Axiom)
'''
			)
	}

	@Test
	def void testDuplicateRuleNames2() {
		testFiles.testDuplicateRuleNames2.
			assertErrorMessages(
'''
Duplicate name 'Foo' (Axiom)
Duplicate name 'Foo' (RuleWithPremises)
'''
			)
	}

	@Test
	def void testDuplicateCheckRuleNames() {
		testFiles.testDuplicateCheckRuleNames().
			assertErrorMessages(
'''
Duplicate name 'Foo' (CheckRule)
Duplicate name 'Foo' (CheckRule)
'''
			)
	}

	@Test
	def void testDuplicateRuleAndCheckRuleNames() {
		testFiles.testDuplicateRuleAndCheckRuleNames().
			assertErrorMessages(
'''
Duplicate name 'Foo' (Axiom)
Duplicate name 'Foo' (CheckRule)
'''
			)
	}

	@Test
	def void testDuplicateParamNamesInJudgmentDescription() {
		testFiles.testDuplicateParamsInJudgmentDescription().
			assertErrorMessages(
'''
Duplicate name 'eClass' (InputParameter)
Duplicate name 'eClass' (InputParameter)
'''
			)
	}

	@Test
	def void testRulesOfTheSameKindWithSameArgumentTypes() {
		testFiles.testRulesOfTheSameKindWithSameArgumentTypes.
		assertErrorMessages(
'''
Duplicate rule of the same kind with parameters: Object, Integer, in system: org.eclipse.xsemantics.test.TypeSystem
Duplicate rule of the same kind with parameters: Object, Integer, in system: org.eclipse.xsemantics.test.TypeSystem
'''			
		)
	}

	@Test
	def void testAuxiliaryDescriptionsWithNoInputParam() {
		testFiles.testAuxiliaryDescriptionsWithNoInputParam.
			assertErrorMessages(
'''
No input parameter; at least one is needed
'''
			)
	}

	@Test
	def void testInvalidUseOfPrimitiveTypes_Issue_17() {
		testFiles.typeInvalidUseOfPrimitiveTypes_Issue_17.
			assertErrorMessages(
'''
Primitives cannot be used in this context.
Primitives cannot be used in this context.
Primitives cannot be used in this context.
'''
			)
	}

	@Test
	def void testCorrectUseOfPrimitiveTypes_Issue_17() {
		testFiles.typeCorrectUseOfPrimitiveTypes_Issue_17.
			parseAndAssertNoError
	}

	@Test
	def void testCorrectReturnInAuxiliaryFunctions_Issue_18() {
		testFiles.testCorrectReturnInAuxFunction_Issue_18.
			parseAndAssertNoError
	}

	@Test
	def void testAccessToPreviousFailureInOrExpression() {
		testFiles.testOrExpressionsAccessingPreviousFailure.parseAndAssertNoError
	}

	@Test
	def void testWrongAccessToPreviousFailureInFirstOrBranch() {
		'''
		«testFiles.typeSystemQualifiedName»
		
		import org.eclipse.emf.ecore.EClass
		import org.eclipse.emf.ecore.EObject
		
		judgments {
			type |- EClass c : EObject o
		}
		
		rule EClassEObject derives
			G |- EClass eClass : EObject object
		from {
			{
				// previousFailure is not available in the first branch
				println(previousFailure)
			}
			or
			{
				eClass.name == 'bar1'
			}
		}
		'''.assertErrorMessages(
			"The method or field previousFailure is undefined"
		)
	}

	@Test
	def void testWrongWriteAccessToPreviousFailure() {
		'''
		«testFiles.typeSystemQualifiedName»
		
		import org.eclipse.emf.ecore.EClass
		import org.eclipse.emf.ecore.EObject
		
		judgments {
			type |- EClass c : EObject o
		}
		
		rule EClassEObject derives
			G |- EClass eClass : EObject object
		from {
			{
				eClass.name == 'bar1'
			}
			or
			{
				previousFailure = null
			}
		}
		'''.assertErrorMessages(
			"Assignment to final variable"
		)
	}

	@Test
	def void testWrongPreviousFailureVariableDeclaration() {
		'''
		«testFiles.typeSystemQualifiedName»
		
		import org.eclipse.emf.ecore.EClass
		import org.eclipse.emf.ecore.EObject
		
		judgments {
			type |- EClass c : EObject o
		}
		
		rule EClassEObject derives
			G |- EClass eClass : EObject object
		from {
			val previousFailure = 'test'
			{
				eClass.name == 'bar1'
			}
			or
			{
				println(previousFailure)
			}
		}
		'''.assertErrorMessages(
		'''
		Duplicate local variable previousFailure
		previousFailure is a reserved name'''
		)
	}

	def private assertErrorMessages(CharSequence input, CharSequence expected) {
		parse(input).assertErrorMessages(expected)
	}

	def private assertErrorMessages(XsemanticsSystem system, CharSequence expected) {
		expected.toString.trim.assertEqualsStrings(
			system.validate.filter[severity == Severity.ERROR].
				map[message].join("\n")
		)
	}

}