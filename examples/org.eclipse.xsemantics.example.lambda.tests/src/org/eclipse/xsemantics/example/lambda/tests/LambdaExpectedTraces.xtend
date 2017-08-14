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

package org.eclipse.xsemantics.example.lambda.tests

class LambdaExpectedTraces {
	
	def notOccurTypeVariablesInArrowTypeFails()
'''failed: a occurs in ((X1 -> X2) -> (X3 -> a))
 failed: a occurs in (X3 -> a)
  failed: a occurs in a
   failed: variable.typevarName != other.typevarName'''

	def unifyTypeVariableOccursInArrowTypeFails()
'''
failed: UnifyTypeVariableArrowType: [] |- subst{} |> a ~~ ((X1 -> X2) -> (X3 -> a)) ~> ArrowType ~~ ArrowType
 «notOccurTypeVariablesInArrowTypeFails»'''

	def arithmeticsFails()
'''failed: AbstractionType: [] |- subst{} |> lambda x . (-'foo') : ArrowType
 failed: ArithmeticsType: [x <- X1] |- subst{} |> -'foo' : IntType
  failed: cannot unify String with int'''

	def omegaFails()
'''failed: AbstractionType: [] |- subst{X1=(X2 -> X3)} |> lambda x . ((x x)) : ArrowType
 failed: ApplicationType: [x <- X1] |- subst{X1=(X2 -> X3)} |> (x x) : Type
  failed: cannot unify X2 with (X2 -> X3)
   failed: X2 occurs in (X2 -> X3)
    failed: X2 occurs in X2
     failed: variable.typevarName != other.typevarName'''
}