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
package org.eclipse.xsemantics.dsl.typing;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.ListIterator;

import org.eclipse.xtext.common.types.JvmType;
import org.eclipse.xtext.common.types.JvmTypeReference;

/**
 * @author Lorenzo Bettini
 * 
 */
public class TupleType extends ArrayList<JvmTypeReference> {

	private static final long serialVersionUID = 1L;
	private static final int ODD_PRIME = 31;

	/**
	 * Redefined so that we use the referred JvmType
	 */
	@Override
	public int hashCode() {
		int hashCode = 1;
		Iterator<JvmTypeReference> i = iterator();
		while (i.hasNext()) {
			JvmType type = i.next().getType();
			if (type != null && !type.eIsProxy()) {
				hashCode = ODD_PRIME * hashCode + type.hashCode();
			}
		}
		return hashCode;
	}

	/**
	 * Redefined so that we use the referred JvmType
	 */
	@Override
	public boolean equals(Object o) {
		if (o == null || !(o instanceof TupleType)) {
			return false;
		}

		ListIterator<JvmTypeReference> e1 = listIterator();
		ListIterator<JvmTypeReference> e2 = ((TupleType) o).listIterator();
		while (e1.hasNext() && e2.hasNext()) {
			JvmTypeReference o1 = e1.next();
			JvmTypeReference o2 = e2.next();
			if (!(o1 == null ? o2 == null : o1.getType().equals(o2.getType()))) {
				return false;
			}
		}
		return !(e1.hasNext() || e2.hasNext());
	}

}
