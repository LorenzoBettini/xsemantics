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
package org.eclipse.xsemantics.tests.swtbot.wizards;

import static org.eclipse.swtbot.swt.finder.waits.Conditions.shellCloses;
import static org.eclipse.xtext.ui.testing.util.IResourcesSetupUtil.*;
import static org.junit.Assert.assertTrue;
import org.eclipse.xsemantics.tests.swtbot.XsemanticsSwtbotTestBase;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.swtbot.swt.finder.junit.SWTBotJunit4ClassRunner;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotMenu;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotShell;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotTreeItem;
import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;

/**
 * @author bettini
 * 
 */
@RunWith(SWTBotJunit4ClassRunner.class)
public class XsemanticsImportExamplesProjectWizardTests extends
		XsemanticsSwtbotTestBase {

	@After
	public void runAfterEveryTest() throws CoreException {
		// bot.sleep(2000);
		disableBuildAutomatically();
		cleanWorkspace();
		enableBuildAutomatically();
		waitForBuild();
	}

	@Test
	public void canCreateExampleFJProjects() throws Exception {
		createExampleProjectsAndAssertNoErrorMarker("Xsemantics FJ Example",
				"org.eclipse.xsemantics.example.fj");
		createExampleProjects("Xsemantics FJ (with cached type system) Example",
				"org.eclipse.xsemantics.example.fjcached");
		waitForBuild();
		
		// if we don't clean this project the fjcached project
		// presents an error in the xsemantics file...
		// cleanProject("org.eclipse.xsemantics.example.fj");

		// This does not seem to be required in Xtext 2.9.0
		// on the contrary, cleaning the fj project results in
		// errors in fj.cached project
		
		waitForBuildAndAssertNoErrors();
	}

	@Test
	public void canCreateExampleExpressionsProjects() throws Exception {
		createExampleProjectsAndAssertNoErrorMarker(
				"Xsemantics Expressions Example",
				"org.eclipse.xsemantics.example.expressions");
	}

	@Test
	public void canCreateExampleLambdaProjects() throws Exception {
		createExampleProjectsAndAssertNoErrorMarker(
				"Xsemantics Lambda Example", "org.eclipse.xsemantics.example.lambda");
	}

	protected void createExampleProjectsAndAssertNoErrorMarker(
			String projectType, String mainProjectId) throws CoreException {
		createExampleProjects(projectType, mainProjectId);

		waitForBuildAndAssertNoErrors();
	}

	protected void createExampleProjects(String projectType,
			String mainProjectId) {
		SWTBotMenu fileMenu = bot.menu("File");
		SWTBotMenu newMenu = fileMenu.menu("New");
		SWTBotMenu otherMenu = newMenu.menu("Other...");
		otherMenu.click();

		SWTBotShell shell = bot.shell("Select a wizard");
		shell.activate();
		SWTBotTreeItem xsemanticsNode = bot.tree().expandNode("Xsemantics");
		waitForTreeItems(xsemanticsNode);
		SWTBotTreeItem examplesNode = xsemanticsNode.expandNode("Examples");
		waitForTreeItems(examplesNode);
		examplesNode.expandNode(projectType).select();
		bot.button("Next >").click();

		bot.button("Finish").click();

		// creation of a project might require some time
		bot.waitUntil(shellCloses(shell), SHELL_TIMEOUT);
		assertTrue("Project doesn't exist", isProjectCreated(mainProjectId));
		assertTrue("Project doesn't exist", isProjectCreated(mainProjectId
				+ ".tests"));
		assertTrue("Project doesn't exist", isProjectCreated(mainProjectId
				+ ".ui"));
	}
}
