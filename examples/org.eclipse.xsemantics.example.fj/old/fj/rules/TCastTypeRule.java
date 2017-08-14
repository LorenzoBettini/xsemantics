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

package org.eclipse.xsemantics.example.fj.typesystem.fj.rules;

import it.xtypes.runtime.*;

public class TCastTypeRule extends FJTypeSystemRule {

	protected Variable<org.eclipse.xsemantics.example.fj.fj.Type> var_objectType = new Variable<org.eclipse.xsemantics.example.fj.fj.Type>(
			createEClassifierType(basicPackage.getType()));

	protected Variable<org.eclipse.xsemantics.example.fj.fj.Cast> var_cast = new Variable<org.eclipse.xsemantics.example.fj.fj.Cast>(
			createEClassifierType(basicPackage.getCast()));

	protected Variable<org.eclipse.xsemantics.example.fj.fj.Type> var_t = new Variable<org.eclipse.xsemantics.example.fj.fj.Type>(
			createEClassifierType(basicPackage.getType()));

	protected TypingJudgmentEnvironment env_G = new TypingJudgmentEnvironment();

	public TCastTypeRule() {
		this("TCast", "|-", ":");
	}

	public TCastTypeRule(String ruleName, String typeJudgmentSymbol,
			String typeStatementRelation) {
		super(ruleName, typeJudgmentSymbol, typeStatementRelation);
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.fj.fj.Cast> getLeft() {
		return var_cast;
	}

	@Override
	public Variable<org.eclipse.xsemantics.example.fj.fj.Type> getRight() {
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
		return new TCastTypeRule("TCast", "|-", ":");
	}

	@Override
	public void applyImpl() throws RuleFailedException {

		var_objectType = new Variable<org.eclipse.xsemantics.example.fj.fj.Type>(
				createEClassifierType(basicPackage.getType()), null);

		applyTypeRule(env_G, var_cast.getValue().getExpression(), var_objectType);

		boolean or_temp_1 = false;
		// first or branch
		try {
			applySubtypeRule(env_G, var_cast.getValue().getType(),
					var_objectType);

			or_temp_1 = true;
		} catch (Throwable e) {
			registerFailure(e);
			// go on with other branches
		}

		// last or branch
		if (!or_temp_1) {
			try {
				applySubtypeRule(env_G, var_objectType, var_cast.getValue()
						.getType());

			} catch (Throwable e) {
				registerFailure(e);
				throw new RuleFailedException(
						stringRep(var_objectType.getValue()) + " and "
								+ stringRep(var_cast.getValue().getType())
								+ " are incompatible types");
			}
		}

		assignment(var_t, var_cast.getValue().getType());

		// final check for variable initialization

	}

	@Override
	protected String ruleFailureMessage() {
		return "invalid cast";
	}

	@Override
	protected String failMessage() {
		return "cannot type";
	}

}
