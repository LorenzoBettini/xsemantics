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
import org.eclipse.xsemantics.dsl.xsemantics.EnvironmentMapping
import org.eclipse.xsemantics.dsl.xsemantics.ErrorSpecification
import org.eclipse.xsemantics.dsl.xsemantics.RuleInvocation
import org.eclipse.xsemantics.dsl.xsemantics.RuleWithPremises
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.eclipse.xtext.xbase.XBinaryOperation
import org.eclipse.xtext.xbase.XBlockExpression
import org.eclipse.xtext.xbase.XFeatureCall
import org.eclipse.xtext.xbase.XMemberFeatureCall
import org.junit.Test
import org.junit.runner.RunWith

@InjectWith(typeof(XsemanticsInjectorProvider))
@RunWith(typeof(XtextRunner))
class XsemanticsScopingTest extends XsemanticsBaseTest {

	@Inject extension ValidationTestHelper

	@Test
	def void testScopingForParameters() {
		val system = testFiles.testScopingForParameters.parse
		system.assertNoErrors
		val xBlockExpression = (system.rules.head as RuleWithPremises).premises as XBlockExpression
		val leftOperandReferringToOutputParam = ((xBlockExpression).expressions.head as XBinaryOperation).leftOperand
		//println((leftOperandReferringToOutputParam as XMemberFeatureCall).feature)
		val leftOperandReferringToInputParam = ((xBlockExpression).expressions.get(1) as XBinaryOperation).leftOperand
		//println((leftOperandReferringToInputParam as XMemberFeatureCall).feature)
		"org.eclipse.emf.ecore.EObject.eContainer()".assertEqualsStrings((leftOperandReferringToInputParam as XMemberFeatureCall).
			feature.identifier
		)
		"org.eclipse.emf.ecore.ENamedElement.getName()".assertEqualsStrings((leftOperandReferringToOutputParam as XMemberFeatureCall).
			feature.identifier
		)
	}

	@Test
	def void testScopingForVariableAsOutputParam() {
		val system = testFiles.testScopingForVariableDeclarationAsOutputArgument.parse
		//system.assertNoErrors
		val xBlockExpression = (system.rules.head as RuleWithPremises).premises as XBlockExpression
		val leftOperandReferringToOutputParam = ((xBlockExpression).expressions.get(1) as XBinaryOperation).leftOperand
		"org.eclipse.emf.ecore.ENamedElement.getName()".assertEqualsStrings((leftOperandReferringToOutputParam as XMemberFeatureCall).
			feature.identifier
		)
	}
	
	@Test
	def void testScopingForExpressionInConclusion() {
		val expInConcl = 
			testFiles.testAxiomWithExpressionInConclusion.
				getRuleWithoutValidation(0).
					expressionInConclusion(0).expression
		//system.assertNoErrors
		val feature = (expInConcl as XMemberFeatureCall).feature
		"org.eclipse.emf.ecore.EObject.eClass()".assertEqualsStrings(
			feature.identifier
		)
	}
	
	@Test
	def void testScopingForErrorSpecificationInJudgment() {
		val errSpec = testFiles.
			testJudgmentDescriptionsWithErrorSpecification.
				parse.judgmentDescriptions.head.error as ErrorSpecification
		val feature = (errSpec.feature as XMemberFeatureCall).feature
		"org.eclipse.emf.ecore.EObject.eContainingFeature()".assertEqualsStrings(
			feature.identifier
		)
	}

	@Test
	def void testScopingForErrorSpecificationInRule() {
		val errSpec = testFiles.
			testRuleWithErrorSpecifications.
				parse.rules.head.conclusion.error as ErrorSpecification
		val feature = (errSpec.feature as XMemberFeatureCall).feature
		"org.eclipse.emf.ecore.EObject.eContainingFeature()".assertEqualsStrings(
			feature.identifier
		)
	}

	@Test
	def void testScopingForEnvironmentMapping() {
		val system = testFiles.
			testSingleEnvironmentMapping.parse
		val xBlockExpression = (system.rules.head as RuleWithPremises).premises as XBlockExpression
		val ruleInvk = xBlockExpression.expressions.head as RuleInvocation
		val envMapping = ruleInvk.environment as EnvironmentMapping
		val feature = (envMapping.value as XFeatureCall).feature
		"object".assertEqualsStrings(
			feature.identifier
		)
	}

}
