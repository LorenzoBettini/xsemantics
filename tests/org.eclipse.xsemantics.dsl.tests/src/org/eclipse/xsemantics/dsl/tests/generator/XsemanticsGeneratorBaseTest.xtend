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

package org.eclipse.xsemantics.dsl.tests.generator

import com.google.inject.Inject
import org.eclipse.xsemantics.dsl.tests.XsemanticsInjectorProvider
import org.eclipse.xsemantics.dsl.tests.XsemanticsBaseTest
import org.eclipse.xsemantics.dsl.xsemantics.CheckRule
import org.eclipse.xsemantics.dsl.xsemantics.Rule
import org.eclipse.xsemantics.dsl.xsemantics.RuleParameter
import java.util.List
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.xbase.compiler.GeneratorConfigProvider
import org.eclipse.xtext.xbase.compiler.ImportManager
import org.eclipse.xtext.xbase.compiler.JvmModelGenerator
import org.eclipse.xtext.xbase.compiler.output.FakeTreeAppendable
import org.eclipse.xtext.xbase.compiler.output.ITreeAppendable
import org.eclipse.xtext.xbase.jvmmodel.JvmModelAssociator
import org.junit.runner.RunWith

import static extension org.eclipse.xtext.EcoreUtil2.*

@InjectWith(typeof(XsemanticsInjectorProvider))
@RunWith(typeof(XtextRunner))
abstract class XsemanticsGeneratorBaseTest extends XsemanticsBaseTest {
	
	@Inject JvmModelGenerator jvmModelGenerator
	
	@Inject JvmModelAssociator associator
	
	@Inject GeneratorConfigProvider generatorConfigProvider
	
	def ITreeAppendable createAppendable(Rule rule) {
		createAndConfigureAppendable(rule, createImportManager)
	}
	
	def ITreeAppendable createAppendable(CheckRule rule) {
		createJvmModelGeneratorConfiguredAppendable(rule)
	}
	
	def createAndConfigureAppendable(Rule rule, ImportManager importManager) {
		val appendable = createAppendable
		rule.configureAppendable(appendable)
		appendable
	}
	
	def configureAppendable(Rule rule, ITreeAppendable appendable) {
		rule.ruleParams.forEach([
			appendable.declareVariable(it.parameter, it.parameter.simpleName)
		])
	}
	
	def createJvmModelGeneratorConfiguredAppendable(Rule rule) {
		val appendable = rule.createJvmModelGeneratorAppendable
		rule.configureAppendable(appendable)
		appendable
	}
	
	def createJvmModelGeneratorConfiguredAppendable(CheckRule rule) {
		val appendable = rule.createJvmModelGeneratorAppendable
		appendable.declareVariable(rule.element.parameter, rule.element.parameter.simpleName)
		appendable
	}

	def createJvmModelGeneratorAppendable(EObject context) {
		// the inferrer created a Java class for the generated system
		// so we retrieve this JvmGenericType from the associator
		val container = associator.getNearestLogicalContainer(context)
		// the created appendable contains the correct bindings for 'this'
		jvmModelGenerator.createAppendable
			(container, createImportManager, generatorConfig)
	}
	
	def createAppendable() {
		new FakeTreeAppendable(createImportManager)
	}
	
	def createImportManager() {
		new ImportManager(true)
	}
	
	def generatorConfig() {
		generatorConfigProvider.get(null)
	}

	def private List<RuleParameter> ruleParams(Rule rule) {
		rule.conclusion.conclusionElements.typeSelect(typeof(RuleParameter))
	}

}
