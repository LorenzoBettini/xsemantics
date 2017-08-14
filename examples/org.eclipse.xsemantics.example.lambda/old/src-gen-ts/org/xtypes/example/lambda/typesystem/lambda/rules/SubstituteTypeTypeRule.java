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

public class SubstituteTypeTypeRule extends LambdaTypeSystemRule {

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> var_t = new Variable<org.eclipse.xsemantics.example.lambda.lambda.Type>(
			createEClassifierType(basicPackage.getType()));

	protected Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> var_result = new Variable<org.eclipse.xsemantics.example.lambda.lambda.Type>(
			createEClassifierType(basicPackage.getType()));

	protected TypingJudgmentEnvironment env_G = new TypingJudgmentEnvironment();

	public SubstituteTypeTypeRule() {
		this("SubstituteType", "|-", "==>");
	}

	public SubstituteTypeTypeRule(String ruleName, String typeJudgmentSymbol,
			String typeStatementRelation) {
		super(ruleName, typeJudgmentSymbol, typeStatementRelation);
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> getLeft() {
		return var_t;
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.lambda.lambda.Type> getRight() {
		return var_result;
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
		return new SubstituteTypeTypeRule("SubstituteType", "|-", "==>");
	}

	@Override
	public void applyImpl() throws RuleFailedException {

		assignment(var_result, var_t);

		// final check for variable initialization

	}

}
