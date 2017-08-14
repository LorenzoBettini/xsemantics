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

/**
 * 
 */
package org.eclipse.xsemantics.example.lambda.xsemantics;

import org.eclipse.xsemantics.example.lambda.lambda.Abstraction;
import org.eclipse.xsemantics.example.lambda.lambda.Application;
import org.eclipse.xsemantics.example.lambda.lambda.Arithmetics;
import org.eclipse.xsemantics.example.lambda.lambda.ArrowType;
import org.eclipse.xsemantics.example.lambda.lambda.IntConstant;
import org.eclipse.xsemantics.example.lambda.lambda.IntType;
import org.eclipse.xsemantics.example.lambda.lambda.Parameter;
import org.eclipse.xsemantics.example.lambda.lambda.Program;
import org.eclipse.xsemantics.example.lambda.lambda.StringConstant;
import org.eclipse.xsemantics.example.lambda.lambda.StringType;
import org.eclipse.xsemantics.example.lambda.lambda.Type;
import org.eclipse.xsemantics.example.lambda.lambda.TypeVariable;
import org.eclipse.xsemantics.example.lambda.lambda.Variable;
import org.eclipse.xsemantics.runtime.StringRepresentation;

import java.util.Map.Entry;

/**
 * @author Lorenzo Bettini
 * 
 */
public class LambdaStringRepresentation extends StringRepresentation {

	protected String stringRep(Program program) {
		return string(program.getTerm());
	}
	
	protected String stringRep(ArrowType arrowType) {
		return "(" + string(arrowType.getLeft()) + " -> "
				+ string(arrowType.getRight()) + ")";
	}

	protected String stringRep(Abstraction abstraction) {
		return "lambda " + string(abstraction.getParam()) + " . ("
				+ string(abstraction.getTerm()) + ")";
	}

	protected String stringRep(Application application) {
		return "(" + string(application.getFun()) + " "
				+ string(application.getArg()) + ")";
	}

	protected String stringRep(IntConstant intConstant) {
		return intConstant.getInt() + "";
	}

	protected String stringRep(StringConstant stringConstant) {
		return "'" + stringConstant.getString() + "'";
	}

	protected String stringRep(Parameter parameter) {
		return parameter.getName()
				+ (parameter.getType() != null ? " : "
						+ string(parameter.getType()) : "");
	}

	protected String stringRep(Arithmetics arithmetics) {
		return "-" + string(arithmetics.getTerm());
	}

	protected String stringRep(Variable variable) {
		return variable.getRef().getName();
	}

	protected String stringRep(TypeVariable typeVariable) {
		return typeVariable.getTypevarName();
	}

	protected String stringRep(TypeSubstitutions substitutions) {
		return "subst{" + stringIterable(substitutions.getSubstitutions())
				+ "}";
	}

	protected String stringRep(StringType type) {
		return "String";
	}

	protected String stringRep(IntType type) {
		return "int";
	}

	protected String stringRep(Entry<String, Type> entry) {
		return string(entry.getKey()) + "=" + string(entry.getValue());
	}
}
