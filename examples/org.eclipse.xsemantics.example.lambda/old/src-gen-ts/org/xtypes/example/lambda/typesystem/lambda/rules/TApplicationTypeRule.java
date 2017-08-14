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

package org.eclipse.xsemantics.example.lambda.typesystem.lambda.rules;

import it.xtypes.runtime.*;

public class TApplicationTypeRule extends LambdaTypeSystemRule {

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> var_funType = new Variable<org.eclipse.xsemantics.example.lambda.lambda.Type>(
			createEClassifierType(basicPackage.getType()));

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType> var_genericArrowType = new Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType>(
			createEClassifierType(basicPackage.getArrowType()));

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> var_argType = new Variable<org.eclipse.xsemantics.example.lambda.lambda.Type>(
			createEClassifierType(basicPackage.getType()));

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.Application> var_a = new Variable<org.eclipse.xsemantics.example.lambda.lambda.Application>(
			createEClassifierType(basicPackage.getApplication()));

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> var_t = new Variable<org.eclipse.xsemantics.example.lambda.lambda.Type>(
			createEClassifierType(basicPackage.getType()));

	protected TypingJudgmentEnvironment env_G = new TypingJudgmentEnvironment();

	public TApplicationTypeRule() {
		this("TApplication", "|-", ":");
	}

	public TApplicationTypeRule(String ruleName, String typeJudgmentSymbol,
			String typeStatementRelation) {
		super(ruleName, typeJudgmentSymbol, typeStatementRelation);
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.lambda.lambda.Application> getLeft() {
		return var_a;
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> getRight() {
		return var_t;
	}

	@Override
	public TypingJudgmentEnvironment getEnvironment() {
		return env_G;
	}

	@Override
	public void setEnvironment(TypingJudgmentEnvironment environment) {
		if (environment != null)
			env_G = environment;
	}

	@Override
	public RuntimeRule newInstance() {
		return new TApplicationTypeRule("TApplication", "|-", ":");
	}

	@Override
	public void applyImpl() throws RuleFailedException {

		var_funType = new Variable<org.eclipse.xsemantics.example.lambda.lambda.Type>(
				createEClassifierType(basicPackage.getType()), null);

		applyTypeRule(env_G, var_a.getValue().getFun(), var_funType);

		var_genericArrowType = new Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType>(
				createEClassifierType(basicPackage.getArrowType()),
				featureAssignments(
						factory.createArrowType(),
						new FeatureAssignmentPair("left", featureAssignments(
								factory.createTypeVariable(),
								new FeatureAssignmentPair("typevarName",
										newName("X")))),
						new FeatureAssignmentPair("right", featureAssignments(
								factory.createTypeVariable(),
								new FeatureAssignmentPair("typevarName",
										newName("X"))))));

		applyUnifyRule(env_G, var_funType, var_genericArrowType);

		applySubstitutionRule(env_G, var_funType, var_genericArrowType);

		var_argType = new Variable<org.eclipse.xsemantics.example.lambda.lambda.Type>(
				createEClassifierType(basicPackage.getType()), null);

		applyTypeRule(env_G, var_a.getValue().getArg(), var_argType);

		applyUnifyRule(env_G, var_genericArrowType.getValue().getLeft(),
				var_argType);

		applySubstitutionRule(env_G, var_genericArrowType, var_genericArrowType);

		assignment(var_t, var_genericArrowType.getValue().getRight());

		// final check for variable initialization

	}

}
