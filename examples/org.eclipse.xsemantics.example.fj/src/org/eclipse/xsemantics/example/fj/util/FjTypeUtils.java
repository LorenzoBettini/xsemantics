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
package org.eclipse.xsemantics.example.fj.util;

import org.eclipse.xtext.EcoreUtil2;

import org.eclipse.xsemantics.example.fj.fj.BasicType;
import org.eclipse.xsemantics.example.fj.fj.Class;
import org.eclipse.xsemantics.example.fj.fj.ClassType;
import org.eclipse.xsemantics.example.fj.fj.Expression;
import org.eclipse.xsemantics.example.fj.fj.FjFactory;
import org.eclipse.xsemantics.runtime.RuleEnvironment;
import org.eclipse.xsemantics.runtime.RuleEnvironmentEntry;

/**
 * Utility functions for types
 * 
 * @author bettini
 * 
 */
public class FjTypeUtils {

	public ClassType createClassType(Class cl) {
		ClassType type = FjFactory.eINSTANCE.createClassType();
		type.setClassref(cl);
		return type;
	}

	public BasicType createBasicType(String basic) {
		BasicType type = FjFactory.eINSTANCE.createBasicType();
		type.setBasic(basic);
		return type;
	}
	
	public BasicType createStringType() {
		return createBasicType("String");
	}
	
	public BasicType createIntType() {
		return createBasicType("int");
	}

	public RuleEnvironment environmentWithMappedThisAsContainingClass(
			Expression expression) {
		Class containingClass = EcoreUtil2.getContainerOfType(expression,
				Class.class);
		if (containingClass != null) {
			return environmentWithMappedThis(containingClass);
		}
		return null;
	}


	public RuleEnvironment environmentWithMappedThis(Class containingClass) {
		ClassType thisType = createClassType(containingClass);
		return new RuleEnvironment(new RuleEnvironmentEntry("this",
				thisType));
	}
}
