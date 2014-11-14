/**
 * 
 */
package it.xsemantics.runtime;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EStructuralFeature;

/**
 * Error information for a RuleFailedException that will be used primarily
 * for error marker generation.
 * 
 * @author Lorenzo Bettini
 * 
 */
public class ErrorInformation {

	/**
	 * The {@link EObject} that will be used as the source for error markers.
	 */
	private EObject source;

	/**
	 * The {@link EStructuralFeature} that will be used to place the
	 * error marker.
	 */
	private EStructuralFeature feature;

	/**
	 * Any additional error information.
	 */
	private Object data;

	/**
	 * @since 1.7
	 */
	public ErrorInformation(EObject source, EStructuralFeature feature,
			Object data) {
		this.source = source;
		this.feature = feature;
		this.data = data;
	}

	public ErrorInformation(EObject source, EStructuralFeature feature) {
		this(source, feature, null);
	}

	public ErrorInformation(EObject source) {
		this(source, null);
	}

	public EObject getSource() {
		return source;
	}

	public EStructuralFeature getFeature() {
		return feature;
	}

	/**
	 * @since 1.7
	 */
	public Object getData() {
		return data;
	}
	
}
