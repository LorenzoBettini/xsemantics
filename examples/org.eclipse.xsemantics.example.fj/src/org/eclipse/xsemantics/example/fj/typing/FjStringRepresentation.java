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
package org.eclipse.xsemantics.example.fj.typing;

import org.eclipse.xsemantics.example.fj.fj.BoolConstant;
import org.eclipse.xsemantics.example.fj.fj.IntConstant;
import org.eclipse.xsemantics.example.fj.fj.StringConstant;
import org.eclipse.xsemantics.example.fj.fj.This;
import org.eclipse.xsemantics.runtime.StringRepresentation;

/**
 * @author bettini
 * 
 */
public class FjStringRepresentation extends StringRepresentation {

	public String stringRep(StringConstant s) {
		return "'" + s.getConstant() + "'";
	}

	public String stringRep(IntConstant s) {
		return s.getConstant() + "";
	}

	public String stringRep(BoolConstant s) {
		return s.getConstant() + "";
	}

	public String stringRep(This t) {
		return "this";
	}
}
