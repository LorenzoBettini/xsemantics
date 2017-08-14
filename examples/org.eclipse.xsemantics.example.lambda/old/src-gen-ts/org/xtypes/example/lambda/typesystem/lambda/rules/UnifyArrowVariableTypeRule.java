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

public class UnifyArrowVariableTypeRule extends LambdaTypeSystemRule {

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType> var_a2 = new Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType>(
			createEClassifierType(basicPackage.getArrowType()));

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> var_t1 = new Variable<org.eclipse.xsemantics.example.lambda.lambda.Type>(
			createEClassifierType(basicPackage.getType()));

	protected TypingJudgmentEnvironment env_G = new TypingJudgmentEnvironment();

	public UnifyArrowVariableTypeRule() {
		this("UnifyArrowVariable", "|-", "==");
	}

	public UnifyArrowVariableTypeRule(String ruleName,
			String typeJudgmentSymbol, String typeStatementRelation) {
		super(ruleName, typeJudgmentSymbol, typeStatementRelation);
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.lambda.lambda.ArrowType> getLeft() {
		return var_a2;
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> getRight() {
		return var_t1;
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
		return new UnifyArrowVariableTypeRule("UnifyArrowVariable", "|-", "==");
	}

	@Override
	public void applyImpl() throws RuleFailedException {

		applyUnifyRule(env_G, var_t1, var_a2);

		// final check for variable initialization

	}

}
