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
package org.eclipse.xsemantics.example.lambda.tests.util;

import org.eclipse.xsemantics.example.lambda.lambda.Abstraction;
import org.eclipse.xsemantics.example.lambda.lambda.Application;
import org.eclipse.xsemantics.example.lambda.lambda.ArrowType;
import org.eclipse.xsemantics.example.lambda.lambda.Term;
import org.eclipse.xsemantics.example.lambda.lambda.Type;
import org.eclipse.xsemantics.example.lambda.lambda.TypeVariable;
import org.eclipse.xsemantics.example.lambda.lambda.Variable;
import org.eclipse.xsemantics.example.lambda.xsemantics.LambdaTypeBeautifier;

/**
 * @author Lorenzo Bettini
 * 
 */
public class LambdaTestsUtil {
	public static Abstraction getAbstraction(Term term) {
		return (Abstraction) term;
	}

	public static Application getApplication(Term term) {
		return (Application) term;
	}

	public static TypeVariable getTypeVariable(Type type) {
		return (TypeVariable) type;
	}

	public static ArrowType getArrowType(Type type) {
		return (ArrowType) type;
	}

	public static Variable getVariable(Term term) {
		return (Variable) term;
	}

	public static String rep(Type type) {
		return new LambdaTypeBeautifier().getBeautifiedString(type);
	}

	public static void repOut(Type type) {
		System.out.println(rep(type));
	}

}
