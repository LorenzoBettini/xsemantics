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

package org.eclipse.xsemantics.example.fj.tests

import org.eclipse.xsemantics.example.fj.fj.Cast
import org.eclipse.xsemantics.example.fj.fj.Field
import org.eclipse.xsemantics.example.fj.fj.Method
import org.eclipse.xsemantics.example.fj.fj.New
import org.eclipse.xsemantics.example.fj.fj.Selection
import org.eclipse.xsemantics.example.fj.typing.FjStringRepresentation
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.nodemodel.util.NodeModelUtils
import org.eclipse.xsemantics.example.fj.fj.ClassType
import org.eclipse.xsemantics.example.fj.fj.BasicType
import org.eclipse.xsemantics.example.fj.fj.MethodBody

class FjStringRepresentationForTests extends FjStringRepresentation {
	override stringRep(EObject eObject) {
		val node = NodeModelUtils::getNode(eObject)
		if (node !== null)
			return super.stringRep(eObject)
		else
			return customRep(eObject).toString
	}
	
	def dispatch customRep(EObject eObject) {
		super.stringRep(eObject)
	}
	
	def dispatch customRep(New exp) {
		'''new «exp.type.classref.name»(''' +
		exp.args.map [
			it.string
		].join(", ") +
		''')'''
	}
	
	def dispatch customRep(Selection exp) {
		'''«exp.receiver.string».''' +
		switch (exp.message) {
			Field : {
				exp.message.name
			}
			Method : {
				exp.message.name + "(" +
				exp.args.map[it.string].join(", ") +
				")"
			}
		}
	}
	
	def dispatch customRep(Cast cast) {
		'''(«cast.type.classref.name») «cast.expression.string»'''
	}
	
	def dispatch customRep(ClassType c) {
		c.classref.name
	}

	def dispatch customRep(BasicType c) {
		c.basic
	}
	
	def dispatch customRep(MethodBody m) {
		m.expression.stringRep
	}
}