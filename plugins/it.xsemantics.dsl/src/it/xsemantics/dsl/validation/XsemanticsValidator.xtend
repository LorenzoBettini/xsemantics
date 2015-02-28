/*
 * generated by Xtext
 */
package it.xsemantics.dsl.validation

import com.google.inject.Inject
import it.xsemantics.dsl.XsemanticsConstants
import it.xsemantics.dsl.typing.TupleType
import it.xsemantics.dsl.typing.XsemanticsTypeSystem
import it.xsemantics.dsl.util.XsemanticsNodeModelUtils
import it.xsemantics.dsl.util.XsemanticsUtils
import it.xsemantics.dsl.xsemantics.AuxiliaryDescription
import it.xsemantics.dsl.xsemantics.AuxiliaryFunction
import it.xsemantics.dsl.xsemantics.Injected
import it.xsemantics.dsl.xsemantics.JudgmentDescription
import it.xsemantics.dsl.xsemantics.JudgmentParameter
import it.xsemantics.dsl.xsemantics.OutputParameter
import it.xsemantics.dsl.xsemantics.Overrider
import it.xsemantics.dsl.xsemantics.ReferToJudgment
import it.xsemantics.dsl.xsemantics.Rule
import it.xsemantics.dsl.xsemantics.RuleConclusionElement
import it.xsemantics.dsl.xsemantics.RuleInvocation
import it.xsemantics.dsl.xsemantics.RuleParameter
import it.xsemantics.dsl.xsemantics.UniqueByName
import it.xsemantics.dsl.xsemantics.XsemanticsPackage
import it.xsemantics.dsl.xsemantics.XsemanticsSystem
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EStructuralFeature
import org.eclipse.xtext.common.types.JvmFormalParameter
import org.eclipse.xtext.common.types.JvmTypeReference
import org.eclipse.xtext.common.types.TypesPackage
import org.eclipse.xtext.validation.Check
import org.eclipse.xtext.validation.ValidationMessageAcceptor
import org.eclipse.xtext.xbase.XAssignment
import org.eclipse.xtext.xbase.XClosure
import org.eclipse.xtext.xbase.XExpression
import org.eclipse.xtext.xbase.XFeatureCall
import org.eclipse.xtext.xbase.XReturnExpression
import org.eclipse.xtext.xbase.XThrowExpression
import org.eclipse.xtext.xbase.XVariableDeclaration
import org.eclipse.xtext.xbase.XbasePackage
import org.eclipse.xtext.xbase.typesystem.util.Multimaps2
import org.eclipse.xtext.xbase.validation.IssueCodes

import static extension org.eclipse.xtext.EcoreUtil2.*

//import org.eclipse.xtext.validation.Check

/**
 * Custom validation rules. 
 *
 * see http://www.eclipse.org/Xtext/documentation.html#validation
 */
class XsemanticsValidator extends AbstractXsemanticsValidator {

	@Inject
	protected XsemanticsTypeSystem typeSystem;

	@Inject
	protected extension XsemanticsUtils;

	@Inject
	protected XsemanticsXExpressionHelper xExpressionHelper;

	@Inject
	protected XsemanticsNodeModelUtils nodeModelUtils;

	public final static int maxOfOutputParams = 3;

	protected boolean enableWarnings = true;
	
		public static final String PREFIX = "it.xsemantics.dsl.validation.";

	public static final String DUPLICATE_JUDGMENT_DESCRIPTION_SYMBOLS = PREFIX
			+ "DuplicateJudgmentDescriptionSymbols";

	public static final String NO_JUDGMENT_DESCRIPTION = PREFIX + "NoJudgmentDescription";

	public static final String NOT_SUBTYPE = PREFIX + "NotSubtype";

	public static final String DUPLICATE_RULE_WITH_SAME_ARGUMENTS = PREFIX
			+ "DuplicateRulesWithSameArguments";

	public static final String DUPLICATE_AUXFUN_WITH_SAME_ARGUMENTS = PREFIX
			+ "DuplicateAuxFunWithSameArguments";
	
	public static final String MUST_OVERRIDE = PREFIX
			+ "MustOverride";

	public static final String DUPLICATE_NAME = PREFIX
			+ "DuplicateName";
	
	public static final String NOT_VALIDATOR = PREFIX + "NotAbstractDeclarativeValidator";
	
	public static final String NOT_PARAMETER = PREFIX + "NotParameter";
	
	public static final String NOT_VALID_OUTPUT_ARG = PREFIX + "NotValidOutputArg";
	
	public static final String NOT_VALID_INPUT_ARG = PREFIX + "NotValidInputArg";
	
	public static final String TOO_MANY_OUTPUT_PARAMS = PREFIX + "TooManyOutputParams";
	
	public static final String NO_INPUT_PARAM = PREFIX + "NoInputParam";

	public static final String ASSIGNMENT_TO_INPUT_PARAM = PREFIX + "AssignmentToInputParam";

	public static final String NO_RULE_FOR_JUDGMENT_DESCRIPTION = PREFIX + "NoRuleForJudgmentDescription";

	public static final String NO_AUXFUN_FOR_AUX_DESCRIPTION = PREFIX + "NoAuxFunForAuxiliaryDescription";

	public static final String RETURN_NOT_ALLOWED = PREFIX + "ReturnNotAllowed";

	public static final String THROW_NOT_ALLOWED = PREFIX + "ThrowNotAllowed";

	public static final String NOT_VALID_SUPER_SYSTEM = PREFIX + "NotValidSuperSystem";

	public static final String CYCLIC_HIERARCHY = PREFIX + "CyclicHierarchy";

	public static final String EXTENDS_CANNOT_COEXIST_WITH_VALIDATOR_EXTENDS = PREFIX + "ExtendsCannotCoexistWithValidatorExtends";

	public static final String OVERRIDE_WITHOUT_SYSTEM_EXTENDS = PREFIX + "OverrideWithoutSystemExtends";

	public static final String NOTHING_TO_OVERRIDE = PREFIX + "NothingToOverride";

	public static final String DUPLICATE_AUXILIARY_NAME = PREFIX + "DuplicateAuxiliaryDescription";

	public static final String NO_AUXDESC_FOR_AUX_FUNCTION = PREFIX + "NoAuxDescForAuxiliaryFunction";

	public static final String PARAMS_SIZE_DONT_MATCH = PREFIX + "ParamsSizeDontMatch";
	
	public static final String ACCESS_TO_OUTPUT_PARAM_WITHIN_CLOSURE = PREFIX + "AccessToOutputParamWithinClosure";

	public static final String RESERVED_VARIABLE_NAME = PREFIX + "ReservedVariableName";

	@Check
	override void checkAssignment(XAssignment assignment) {
		// we allow assignment to output parameters
		val assignmentFeature = assignment.getFeature();
		if (assignmentFeature instanceof JvmFormalParameter) {
			if (assignmentFeature.isInputParam()) {
				error("Assignment to input parameter",
						XbasePackage.Literals.XASSIGNMENT__ASSIGNABLE,
						ValidationMessageAcceptor.INSIGNIFICANT_INDEX,
						ASSIGNMENT_TO_INPUT_PARAM);
			}
			return;
		}
		super.checkAssignment(assignment);
	}

	@Check
	override void checkReturn(XReturnExpression expr) {
		// better to allow return statements in auxiliary functions
		// see https://github.com/LorenzoBettini/xsemantics/issues/18
		if (!expr.isContainedInAuxiliaryFunction()) {
			error("Return statements are not allowed here", expr, null,
				RETURN_NOT_ALLOWED);
		}
	}

	@Check
	override checkVariableDeclaration(XVariableDeclaration declaration) {
		super.checkVariableDeclaration(declaration)
		if (XsemanticsConstants.PREVIOUS_FAILURE.equals(declaration.name)) {
			error(XsemanticsConstants.PREVIOUS_FAILURE +
				" is a reserved name", declaration, null,
					RESERVED_VARIABLE_NAME);
		}
	}

//	@Override
//	protected boolean supportsCheckedExceptions() {
//		// we generate Java code which already handles exceptions
//		return false;
//	}

	def protected boolean isContainedInAuxiliaryFunction(XExpression expr) {
		return expr.getContainerOfType(AuxiliaryFunction) != null
	}

//	override protected boolean isImplicitReturn(XExpression expr) {
//		if (expr.isContainedInAuxiliaryFunction()) {
//			return super.isImplicitReturn(expr);
//		}
//
//		// we will deal with this during generation
//		return false;
//	}

	@Check
	def void checkThrow(XThrowExpression expr) {
		error("Throw statements are not allowed here", expr, null,
				THROW_NOT_ALLOWED);
	}

	override protected boolean isLocallyUsed(EObject target, EObject containerToFindUsage) {
		if (containerToFindUsage instanceof RuleInvocation) {
			// we don't want warning when a variable declaration appears as
			// output argument: it is implicitly used for the result
			return true;
		}
		return super.isLocallyUsed(target, containerToFindUsage);
	}

	override protected boolean isValueExpectedRecursive(XExpression expr) {
		// this is used by Xbase validator to check expressions with
		// side effects, by inspecting expr's container
		// so we must customize it when the container is one of our
		// custom XExpressions
		val valueExpectedRecursive = super
				.isValueExpectedRecursive(expr);
		return valueExpectedRecursive
				|| xExpressionHelper.isXsemanticsXExpression(expr.eContainer());
	}

	@Check
	def void checkJudgmentDescription(JudgmentDescription judgmentDescription) {
		checkNumOfOutputParams(judgmentDescription);
		checkInputParams(judgmentDescription);
		checkJudgmentDescriptionRules(judgmentDescription)
	}

	def void checkJudgmentDescriptionRules(
			JudgmentDescription judgmentDescription) {
		val rulesForJudgmentDescription = judgmentDescription.rulesForJudgmentDescription
		
		if (rulesForJudgmentDescription.isEmpty()) {
			if (isEnableWarnings && !judgmentDescription.override)
				warning("No rule defined for the judgment description",
					XsemanticsPackage.Literals.JUDGMENT_DESCRIPTION
							.getEIDAttribute(),
					NO_RULE_FOR_JUDGMENT_DESCRIPTION);
		} else {
			val judgmentParameters = judgmentDescription.judgmentParameters
			for (rule : rulesForJudgmentDescription) {
				val conclusionElements = rule.conclusion.conclusionElements
				// judgmentParameters.size() == conclusionElements.size())
				// otherwise we could not find a JudgmentDescription for the rule
				val judgmentParametersIt = judgmentParameters
						.iterator();
				for (RuleConclusionElement ruleConclusionElement : conclusionElements) {
					if (!judgmentParametersIt.next().isOutputParameter()
							&& !(ruleConclusionElement instanceof RuleParameter)) {
						error("Must be a parameter, not an expression",
								ruleConclusionElement,
								XsemanticsPackage.Literals.RULE_CONCLUSION_ELEMENT
										.getEIDAttribute(),
								NOT_PARAMETER);
					}
				}
				
				rule.checkRuleConformantToJudgmentDescription(judgmentDescription)
			}
		}
	}

	def protected void checkNumOfOutputParams(
			JudgmentDescription judgmentDescription) {
		if (judgmentDescription.outputJudgmentParameters()
				.size() > maxOfOutputParams) {
			error("No more than " + maxOfOutputParams
					+ " output parameters are handled at the moment",
					XsemanticsPackage.Literals.JUDGMENT_DESCRIPTION__JUDGMENT_PARAMETERS,
					TOO_MANY_OUTPUT_PARAMS);
		}
	}

	def protected void checkInputParams(JudgmentDescription judgmentDescription) {
		val inputParams = judgmentDescription.inputParams()
		if (inputParams.empty) {
			error("No input parameter; at least one is needed",
					XsemanticsPackage.Literals.JUDGMENT_DESCRIPTION__JUDGMENT_PARAMETERS,
					NO_INPUT_PARAM);
		} else {
			inputParams.checkDuplicatesByName(null, DUPLICATE_NAME)
		}
	}

	@Check
	def void checkRule(Rule rule) {
		val conclusion = rule.conclusion
		rule.findJudgmentDescriptionOrError(
			conclusion.judgmentSymbol, 
			conclusion.relationSymbols, 
			XsemanticsPackage.Literals.RULE__CONCLUSION);
	}

	@Check
	def public void checkRuleInvocation(RuleInvocation ruleInvocation) {
		val judgmentDescription = checkRuleInvocationConformantToJudgmentDescription(ruleInvocation);
		if (judgmentDescription != null) {
			val judgmentParameters = judgmentDescription
					.getJudgmentParameters();
			val invocationExpressions = ruleInvocation
					.getExpressions();
			// judgmentParamters.size() == conclusionElements.size())
			// otherwise we could not find a JudgmentDescription for the rule
			val judgmentParametersIt = judgmentParameters
					.iterator();
			for (XExpression ruleInvocationExpression : invocationExpressions) {
				if (judgmentParametersIt
						.next().isOutputParameter()) {
					if (!ruleInvocationExpression
							.validOutputArgExpression()) {
						error("Not a valid argument for output parameter: "
								+ nodeModelUtils
										.getProgramText(ruleInvocationExpression),
								ruleInvocationExpression,
								null,
								NOT_VALID_OUTPUT_ARG);
					}
				} else {
					if (!ruleInvocationExpression
							.validInputArgExpression()) {
						error("Not a valid argument for input parameter: "
								+ nodeModelUtils
										.getProgramText(ruleInvocationExpression),
								ruleInvocationExpression,
								null,
								NOT_VALID_INPUT_ARG);
					}
				}

			}
		}
	}

	@Check
	def public void checkSystem(XsemanticsSystem system) {
		val validatorExtends = system
				.getValidatorExtends();
		if (validatorExtends != null) {
			if (!typeSystem.isAbstractDeclarativeValidator(validatorExtends,
					system)) {
				error("Not an AbstractDeclarativeValidator: "
						+ getNameOfTypes(validatorExtends),
						XsemanticsPackage.Literals.XSEMANTICS_SYSTEM__VALIDATOR_EXTENDS,
						NOT_VALIDATOR);
			}
		}
		val superSystem = system.getSuperSystem();
		if (superSystem != null) {
			if (!typeSystem.isValidSuperSystem(superSystem, system)) {
				error("Not an Xsemantics system: "
						+ getNameOfTypes(superSystem),
						XsemanticsPackage.Literals.XSEMANTICS_SYSTEM__SUPER_SYSTEM,
						NOT_VALID_SUPER_SYSTEM);
			}
			if (validatorExtends != null) {
				error("system 'extends' cannot coexist with 'validatorExtends'",
						XsemanticsPackage.Literals.XSEMANTICS_SYSTEM__SUPER_SYSTEM,
						EXTENDS_CANNOT_COEXIST_WITH_VALIDATOR_EXTENDS);
				error("system 'extends' cannot coexist with 'validatorExtends'",
						XsemanticsPackage.Literals.XSEMANTICS_SYSTEM__VALIDATOR_EXTENDS,
						EXTENDS_CANNOT_COEXIST_WITH_VALIDATOR_EXTENDS);
			}
		}

		val superSystems = system
				.allSuperSystemDefinitions();
		if (superSystems.contains(system)) {
			error("Cycle in extends relation",
					XsemanticsPackage.Literals.XSEMANTICS_SYSTEM__SUPER_SYSTEM,
					CYCLIC_HIERARCHY);
		}
		
		val superSystemDefinition = system.superSystemDefinition

		val allSuperJudgments = superSystemDefinition?.allJudgments
		system.judgmentDescriptions.
			checkOverrides(allSuperJudgments,
			[j1, j2 |
				j1.judgmentSymbol == j2.judgmentSymbol &&
				j1.relationSymbols.elementsEqual(j2.relationSymbols) &&
				typeSystem.equals(j1, j2)
			],
			"judgment")
		
		val allSuperAuxiliaryDescriptions = superSystemDefinition?.allAuxiliaryDescriptions
		system.auxiliaryDescriptions.
			checkOverrides(allSuperAuxiliaryDescriptions,
			[a1, a2 |
				typeSystem.equals(a1, a2)
			],
			"auxiliary description")

		val allSuperCheckRules = superSystemDefinition?.allCheckRules
		system.checkrules.
			checkOverrides(allSuperCheckRules, 
			[r1, r2 |
				typeSystem.equals(
							r1.element.parameter.parameterType, 
							r2.element.parameter.parameterType, 
							r1
						)
			],
			"checkrule")
		
		val allSuperRules = superSystemDefinition?.allRules
		system.rules.
			checkOverrides(allSuperRules, 
			[r1, r2 |
				r1.conclusion.judgmentSymbol.equals(r2.conclusion.judgmentSymbol) &&
				r1.conclusion.relationSymbols.elementsEqual(r2.conclusion.relationSymbols)
				&&
				typeSystem.equals(
					typeSystem.getInputTypes(r1),
					typeSystem.getInputTypes(r2)
				)
			],
			"rule")
		
		// the following check must be done like that:
		// we need to check each rule in the system against rules possibly
		// "inherited" from a supersystem, and the corresponding judgment
		// could be defined in the supersystem and not in this system
		for (rule : system.rules) {
			val conclusion = rule.conclusion
			val rulesOfTheSameKind = 
				system.allRulesByJudgmentDescription(
					conclusion.judgmentSymbol, conclusion.relationSymbols
				)
			if (rulesOfTheSameKind.size() > 1) {
				val tupleType = typeSystem.getInputTypes(rule);
				for (Rule rule2 : rulesOfTheSameKind) {
					if (rule2 != rule && !rule.isOverride()) {
						val tupleType2 = typeSystem.getInputTypes(rule2);
						if (typeSystem.equals(tupleType, tupleType2)) {
							error("Duplicate rule of the same kind with parameters: "
									+ tupleTypeRepresentation(tupleType)
									+ reportContainingSystemName(rule2),
									rule,
									XsemanticsPackage.Literals.RULE__CONCLUSION,
									DUPLICATE_RULE_WITH_SAME_ARGUMENTS);
						}
					}
				}
			}
		}
		
		val elements = system.fields + 
			system.judgmentDescriptions +
			system.auxiliaryDescriptions +
			// system.auxiliaryFunctions + 
			// aux functions have the same name of aux descriptions
			system.rules + 
			system.checkrules
		elements.checkDuplicatesByName(null, DUPLICATE_NAME)
		
		system.judgmentDescriptions.checkDuplicates(
			XsemanticsPackage.Literals.JUDGMENT_DESCRIPTION__JUDGMENT_SYMBOL,
			DUPLICATE_JUDGMENT_DESCRIPTION_SYMBOLS,
			[judgmentRepresentation(judgmentSymbol, relationSymbols)],
			[key, it | 
				"Duplicate judgment symbols '" + 
				key + "' (" + eClass.name + ")"
			]
		)
	}

	def private <T extends UniqueByName> checkDuplicatesByName(
		Iterable<T> collection,
		EStructuralFeature feature,
		String issue
	) {
		collection.checkDuplicates(feature, issue, [name],
			[key, it | "Duplicate name '" + name + "' (" + eClass.name + ")"]
		)
	}

	def private <T extends EObject, K> checkDuplicates(
		Iterable<T> collection,
		EStructuralFeature feature,
		String issue,
		(T) => K keyComputer,
		(K, T) => String errorMessageProvider
	) {
		if (!collection.empty) {
			val map = duplicatesMultimap
			for (e : collection) {
				map.put(keyComputer.apply(e), e)
			}

			for (entry : map.asMap.entrySet) {
				val duplicates = entry.value
				if (duplicates.size > 1) {
					for (d : duplicates)
						error(
							errorMessageProvider.apply(entry.key, d),
							d,
							feature, 
							issue);
				}
			}
		}
	}

	def private <T extends Overrider> checkOverrides(Iterable<T> collection, 
			Iterable<T> superCollection, 
			(T, T) => boolean conformanceComputer,
			String kind) {
		
		if (superCollection == null) {
			for (j : collection.filter[override]) {
				error(
					"Cannot override " + kind + " without system 'extends'",
					j,
					null, 
					OVERRIDE_WITHOUT_SYSTEM_EXTENDS);
			}
		} else {
			val superMap = superCollection.toMap[name]
			for (j : collection) {
				val name = j.name
				val overridden = superMap.get(name)
					
				if (!j.override) {
					if (overridden != null)
						error(
							kind + " '" + name + "' must override " + kind +
								reportContainingSystemName(overridden),
							j,
							null, 
							MUST_OVERRIDE);
				} else {
					if (overridden == null || !conformanceComputer.apply(j, overridden))
						error("No " + kind + " to override: " + name,
							j,
							null,
							NOTHING_TO_OVERRIDE);
				}
			}
		}
	}

	@Check
	def public void checkAuxiliaryDescription(AuxiliaryDescription aux) {
		if (aux.parameters.empty) {
			error("No input parameter; at least one is needed",
					XsemanticsPackage.Literals.AUXILIARY_DESCRIPTION__NAME,
					NO_INPUT_PARAM);
		}
		
		val functionsForAuxiliaryDescrition = aux.functionsForAuxiliaryDescrition();
		if (isEnableWarnings
				&& functionsForAuxiliaryDescrition.empty && !aux.override) {
			warning("No function defined for the auxiliary description",
					XsemanticsPackage.Literals.AUXILIARY_DESCRIPTION
							.getEIDAttribute(),
					NO_AUXFUN_FOR_AUX_DESCRIPTION);
		}
		
		if (functionsForAuxiliaryDescrition.size() > 1) {
			functionsForAuxiliaryDescrition.checkDuplicates(
			XsemanticsPackage.Literals.AUXILIARY_FUNCTION__PARAMETERS,
			DUPLICATE_AUXFUN_WITH_SAME_ARGUMENTS,
			[typeSystem.getInputTypes(it)],
			[key, it | 
				"Duplicate auxiliary function of the same kind with parameters: "
							+ tupleTypeRepresentation(key)
							+ reportContainingSystemName(it)
			])
		}
	}

	@Check
	def public void checkAuxiliaryFunctionHasAuxiliaryDescription(
			AuxiliaryFunction aux) {
		val auxiliaryDescription = aux
				.getAuxiliaryDescription();
		if (auxiliaryDescription == null) {
			error("No auxiliary description for auxiliary function '"
					+ aux.getName() + "'",
					XsemanticsPackage.Literals.AUXILIARY_FUNCTION__NAME,
					NO_AUXDESC_FOR_AUX_FUNCTION);
		} else
			checkConformanceOfAuxiliaryFunction(aux, auxiliaryDescription);
	}

	@Check
	def public void checkOutputParamAccessWithinClosure(XFeatureCall featureCall) {
		val feature = featureCall.getFeature();
		if (feature instanceof JvmFormalParameter) {
			val container = feature.eContainer();
			if (container instanceof RuleParameter) {
				if (container.isOutputParam
						&& insideClosure(featureCall)) {
					error("Cannot refer to an output parameter "
							+ feature.getIdentifier()
							+ " from within a closure", featureCall, null,
							ACCESS_TO_OUTPUT_PARAM_WITHIN_CLOSURE);
				}
			}
			return;
		}
	}

	@Check
	def protected void ensureNotPrimitive(JvmTypeReference typeRef) {
		val reference = toLightweightTypeReference(typeRef);
		if (reference.isPrimitive()) {
			val container = typeRef.eContainer
			if (container instanceof OutputParameter || container instanceof JvmFormalParameter ||
					container instanceof Injected || container instanceof AuxiliaryDescription)
				error("Primitives cannot be used in this context.", typeRef, null, 
					IssueCodes.INVALID_USE_OF_TYPE
				);
		}
	}

	def private boolean insideClosure(XFeatureCall featureCall) {
		return featureCall.getContainerOfType(XClosure) != null;
	}

	def protected void checkConformanceOfAuxiliaryFunction(AuxiliaryFunction aux,
			AuxiliaryDescription auxiliaryDescription) {
		val funParams = aux.getParameters();
		val descParams = auxiliaryDescription
				.getParameters();

		if (funParams.size() != descParams.size()) {
			error("expected " + descParams.size() + " parameter(s), but was "
					+ funParams.size(),
					aux,
					XsemanticsPackage.Literals.AUXILIARY_FUNCTION__PARAMETERS,
					PARAMS_SIZE_DONT_MATCH);
		} else {
			val funParamsIt = funParams.iterator();
			for (JvmFormalParameter jvmFormalParameter : descParams) {
				val expected = typeSystem
						.getType(jvmFormalParameter);
				val funParam = funParamsIt.next();
				val actual = typeSystem.getType(funParam);
				if (!typeSystem.isConformant(expected, actual, funParam)) {
					error("parameter type "
							+ getNameOfTypes(actual)
							+ " is not subtype of AuxiliaryDescription declared type "
							+ getNameOfTypes(expected),
							funParam,
							TypesPackage.Literals.JVM_FORMAL_PARAMETER__PARAMETER_TYPE,
							NOT_SUBTYPE);
				}
			}
		}
	}

	def protected String reportContainingSystemName(EObject object) {
		return ", in system: "
				+ object.containingSystem().getName();
	}

	def private void checkRuleConformantToJudgmentDescription(
			Rule rule,
			JudgmentDescription judgmentDescription) {
		val conclusion = rule.getConclusion();
		checkConformanceAgainstJudgmentDescription(
				judgmentDescription,
				conclusion,
				conclusion.getJudgmentSymbol(),
				conclusion.getRelationSymbols(),
				conclusion.getConclusionElements(), "Rule conclusion",
				XsemanticsPackage.Literals.RULE__CONCLUSION,
				XsemanticsPackage.Literals.RULE_CONCLUSION_ELEMENT
						.getEIDAttribute());
	}

	def private JudgmentDescription checkRuleInvocationConformantToJudgmentDescription(
			RuleInvocation ruleInvocation) {
		return checkConformanceAgainstJudgmentDescription(
				ruleInvocation,
				ruleInvocation.getJudgmentSymbol(),
				ruleInvocation.getRelationSymbols(),
				ruleInvocation.getExpressions(),
				"Rule invocation",
				XsemanticsPackage.Literals.RULE_INVOCATION.getEIDAttribute(),
				null);
	}

	def private JudgmentDescription checkConformanceAgainstJudgmentDescription(
			ReferToJudgment element, String judgmentSymbol,
			Iterable<String> relationSymbols,
			Iterable<? extends EObject> elements,
			String elementDescription, EStructuralFeature elementFeature,
			EStructuralFeature conformanceFeature) {
		val judgmentDescription = element
				.findJudgmentDescriptionOrError(judgmentSymbol, relationSymbols, elementFeature);
		checkConformanceAgainstJudgmentDescription(
			judgmentDescription,
			element,
			judgmentSymbol,
			relationSymbols,
			elements,
			elementDescription,
			elementFeature,
			conformanceFeature
		)
		return judgmentDescription;
	}

	def private findJudgmentDescriptionOrError(ReferToJudgment element, String judgmentSymbol,
			Iterable<String> relationSymbols, EStructuralFeature elementFeature) {
		val judgmentDescription = element.getJudgmentDescription
		if (judgmentDescription == null) {
			error("No Judgment description for: "
					+ judgmentRepresentation(judgmentSymbol, relationSymbols),
					elementFeature, NO_JUDGMENT_DESCRIPTION);
		}
		return judgmentDescription;
	}

	def private checkConformanceAgainstJudgmentDescription(
			JudgmentDescription judgmentDescription,
			EObject element, String judgmentSymbol,
			Iterable<String> relationSymbols,
			Iterable<? extends EObject> elements,
			String elementDescription, EStructuralFeature elementFeature,
			EStructuralFeature conformanceFeature) {
		if (judgmentDescription != null) {
			val judgmentParameters = judgmentDescription
					.getJudgmentParameters();
			val elementsIt = elements.iterator();
			for (judgmentParameter : judgmentParameters) {
				// the element might still be incomplete, thus we must check
				// whether there is an element to check against.
				// Recall that the judgment has been searched for using only
				// the symbols, not the rule conclusion elements
				if (elementsIt.hasNext())
					checkConformance(judgmentParameter, elementsIt.next(),
						elementDescription, conformanceFeature);
			}
		}
	}

	def protected void checkConformance(JudgmentParameter judgmentParameter,
			EObject element, String elementDescription,
			EStructuralFeature feature) {
		val expected = typeSystem.getType(judgmentParameter);
		val actual = typeSystem.getType(element);
		if (!typeSystem.isConformant(expected, actual, element)) {
			error(elementDescription + " type " + getNameOfTypes(actual)
					+ " is not subtype of JudgmentDescription declared type "
					+ getNameOfTypes(expected), element, feature,
					NOT_SUBTYPE);
		}
	}

	def protected String judgmentRepresentation(String judgmentSymbol,
			Iterable<String> relationSymbols) {
		return judgmentSymbol + " "
				+ IterableExtensions.join(relationSymbols, " ");
	}

	def protected String tupleTypeRepresentation(TupleType tupleType) {
		val builder = new StringBuilder();
		val it = tupleType.iterator();
		while (it.hasNext()) {
			builder.append(getNameOfTypes(it.next()));
			if (it.hasNext())
				builder.append(", ");
		}
		return builder.toString();
	}

	def private Object getNameOfTypes(JvmTypeReference typeRef) {
		return if (typeRef == null)  "<null>" else typeRef.getSimpleName();
	}

	def public boolean isEnableWarnings() {
		return enableWarnings;
	}

	def public void setEnableWarnings(boolean enableWarnings) {
		this.enableWarnings = enableWarnings;
	}

	def private <K, T> duplicatesMultimap() {
		return Multimaps2.<K, T> newLinkedHashListMultimap();
	}
}
