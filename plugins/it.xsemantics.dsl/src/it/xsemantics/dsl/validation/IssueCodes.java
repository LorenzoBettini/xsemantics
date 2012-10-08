package it.xsemantics.dsl.validation;

/**
 * @author Lorenzo Bettini
 */
public interface IssueCodes {

	String PREFIX = "it.xsemantics.dsl.validation.";

	String DUPLICATE_JUDGMENT_DESCRIPTION_SYMBOLS = PREFIX
			+ "DuplicateJudgmentDescriptionSymbols";

	String NO_JUDGMENT_DESCRIPTION = PREFIX + "NoJudgmentDescription";

	String NOT_SUBTYPE = PREFIX + "NotSubtype";

	String DUPLICATE_RULE_WITH_SAME_ARGUMENTS = PREFIX
			+ "DuplicateRulesWithSameArguments";
	
	String DUPLICATE_RULE_NAME = PREFIX
			+ "DuplicateRuleName";
	
	String DUPLICATE_PARAM_NAME = PREFIX
			+ "DuplicateParamName";

	String DUPLICATE_JUDGMENT_NAME = PREFIX
			+ "DuplicateJudgmentName";
	
	String NOT_EOBJECT = PREFIX + "NotEObject";

	String NOT_ESTRUCTURALFEATURE = PREFIX + "NotEStructuralFeature";

	String NOT_VALIDATOR = PREFIX + "NotAbstractDeclarativeValidator";
	
	String NOT_PARAMETER = PREFIX + "NotParameter";
	
	String NOT_VALID_OUTPUT_ARG = PREFIX + "NotValidOutputArg";
	
	String NOT_VALID_INPUT_ARG = PREFIX + "NotValidInputArg";
	
	String TOO_MANY_OUTPUT_PARAMS = PREFIX + "TooManyOutputParams";
	
	String NO_INPUT_PARAM = PREFIX + "NoInputParam";

	String ASSIGNMENT_TO_INPUT_PARAM = PREFIX + "AssignmentToInputParam";

	String NO_RULE_FOR_JUDGMENT_DESCRIPTION = PREFIX + "NoRuleForJudgmentDescription";

	String NO_AUXFUN_FOR_AUX_DESCRIPTION = PREFIX + "NoAuxFunForAuxiliaryDescription";

	String RETURN_NOT_ALLOWED = PREFIX + "ReturnNotAllowed";

	String THROW_NOT_ALLOWED = PREFIX + "ThrowNotAllowed";

	String NOT_VALID_SUPER_SYSTEM = PREFIX + "NotValidSuperSystem";

	String CYCLIC_HIERARCHY = PREFIX + "CyclicHierarchy";

	String EXTENDS_CANNOT_COEXIST_WITH_VALIDATOR_EXTENDS = PREFIX + "ExtendsCannotCoexistWithValidatorExtends";

	String OVERRIDE_WITHOUT_SYSTEM_EXTENDS = PREFIX + "OverrideWithoutSystemExtends";

	String NO_RULE_TO_OVERRIDE_OF_THE_SAME_KIND = PREFIX + "NoRuleToOverrideOfTheSameKind";

	String OVERRIDE_RULE_MUST_HAVE_THE_SAME_NAME = PREFIX + "OverrideRuleMustHaveTheSameName";

	String NO_JUDGMENT_TO_OVERRIDE_OF_THE_SAME_KIND = PREFIX + "NoJudgmentToOverrideOfTheSameKind";

	String OVERRIDE_JUDGMENT_MUST_HAVE_THE_SAME_NAME = PREFIX + "OverrideJudgmentMustHaveTheSameName";

	String DUPLICATE_AUXILIARY_NAME = PREFIX + "DuplicateAuxiliaryDescription";

	String NO_AUXDESC_FOR_AUX_FUNCTION = PREFIX + "NoAuxDescForAuxiliaryFunction";

	String PARAMS_SIZE_DONT_MATCH = PREFIX + "ParamsSizeDontMatch";
}
