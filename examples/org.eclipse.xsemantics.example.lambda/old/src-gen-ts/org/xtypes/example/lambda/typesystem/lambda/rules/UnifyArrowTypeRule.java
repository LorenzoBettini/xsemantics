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

public class UnifyArrowTypeRule extends LambdaTypeSystemRule {

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType> var_a1 = new Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType>(
			createEClassifierType(basicPackage.getArrowType()));

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType> var_a2 = new Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType>(
			createEClassifierType(basicPackage.getArrowType()));

	protected TypingJudgmentEnvironment env_G = new TypingJudgmentEnvironment();

	public UnifyArrowTypeRule() {
		this("UnifyArrow", "|-", "==");
	}

	public UnifyArrowTypeRule(String ruleName, String typeJudgmentSymbol,
			String typeStatementRelation) {
		super(ruleName, typeJudgmentSymbol, typeStatementRelation);
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType> getLeft() {
		return var_a1;
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType> getRight() {
		return var_a2;
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
		return new UnifyArrowTypeRule("UnifyArrow", "|-", "==");
	}

	@Override
	public void applyImpl() throws RuleFailedException {

		applyUnifyRule(env_G, var_a1.getValue().getLeft(), var_a2.getValue()
				.getLeft());

		applyUnifyRule(env_G, var_a1.getValue().getRight(), var_a2.getValue()
				.getRight());

		// final check for variable initialization

	}

}
