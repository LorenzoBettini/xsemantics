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


package org.eclipse.xsemantics.example.expressions;

import org.eclipse.xsemantics.example.expressions.ExpressionsStandaloneSetupGenerated;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class ExpressionsStandaloneSetup extends ExpressionsStandaloneSetupGenerated{

	public static void doSetup() {
		new ExpressionsStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

