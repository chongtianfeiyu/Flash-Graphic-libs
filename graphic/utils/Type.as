package graphic.utils {

	/**
	 * ...
	 * @author Locke
	 */
	public class Type{
		public static const INPUT_TEXT:String = "input";
		public static const LABEL_TEXT:String = "output";
		
		public static const BUTTON:String = "buttons";
		public static const CLICK:String = "click";

		/**
		   Defines the value of the type property of a doubleClick event object. The doubleClickEnabled property
		   must be true for an object to generate the doubleClick event.

		   This event has the following properties:PropertyValuealtKeytrue if the Alt key is active (Windows or Linux).bubblestruebuttonDownFor double-click events, this value is always false.cancelablefalse; there is no default behavior to cancel.commandKeytrue on the Mac if the Command key is active; false if it is inactive. Always false on Windows.controlKeytrue if the Ctrl or Control key is active; false if it is inactive.ctrlKeytrue on Windows or Linux if the Ctrl key is active. true on Mac if either the Ctrl key or the Command key is active. Otherwise, false.currentTargetThe object that is actively processing the Event
		   object with an event listener.localXThe horizontal coordinate at which the event occurred relative to the containing sprite.localYThe vertical coordinate at which the event occurred relative to the containing sprite.shiftKeytrue if the Shift key is active; false if it is inactive.stageXThe horizontal coordinate at which the event occurred in global stage coordinates.stageYThe vertical coordinate at which the event occurred in global stage coordinates.targetThe InteractiveObject instance under the pointing device.
		   The target is not always the object in the display list
		   that registered the event listener. Use the currentTarget
		   property to access the object in the display list that is currently processing the event.
		 */
		public static const DOUBLE_CLICK:String = "doubleClick";

		/**
		   Defines the value of the type property of a mouseDown event object.
		   This event has the following properties:PropertyValuealtKeytrue if the Alt key is active (Windows or Linux).bubblestruebuttonDowntrue if the primary mouse button is pressed; false otherwise.cancelablefalse; the default behavior cannot be canceled.commandKeytrue on the Mac if the Command key is active; false if it is inactive. Always false on Windows.controlKeytrue if the Ctrl or Control key is active; false if it is inactive.ctrlKeytrue on Windows and Linux if the Ctrl key is active. true on Mac if either the Ctrl key or the Command key is active. Otherwise, false.currentTargetThe object that is actively processing the Event
		   object with an event listener.localXThe horizontal coordinate at which the event occurred relative to the containing sprite.localYThe vertical coordinate at which the event occurred relative to the containing sprite.shiftKeytrue if the Shift key is active; false if it is inactive.clickCountCount of the number of mouse clicks to indicate whether the event is part of a multi-click sequence.stageXThe horizontal coordinate at which the event occurred in global stage coordinates.stageYThe vertical coordinate at which the event occurred in global stage coordinates.targetThe InteractiveObject instance under the pointing device.
		   The target is not always the object in the display list
		   that registered the event listener. Use the currentTarget
		   property to access the object in the display list that is currently processing the event.
		 */
		public static const MOUSE_DOWN:String = "mouseDown";

		/**
		   Defines the value of the type property of a mouseMove event object.

		   This event has the following properties:PropertyValuealtKeytrue if the Alt key is active (Windows or Linux).bubblestruebuttonDowntrue if the primary mouse button is pressed; false otherwise.cancelablefalse; the default behavior cannot be canceled.commandKeytrue on the Mac if the Command key is active; false if it is inactive. Always false on Windows.controlKeytrue if the Ctrl or Control key is active; false if it is inactive.ctrlKeytrue on Windows or Linux if the Ctrl key is active. true on Mac if either the Ctrl key or the Command key is active. Otherwise, false.currentTargetThe object that is actively processing the Event
		   object with an event listener.localXThe horizontal coordinate at which the event occurred relative to the containing sprite.localYThe vertical coordinate at which the event occurred relative to the containing sprite.shiftKeytrue if the Shift key is active; false if it is inactive.stageXThe horizontal coordinate at which the event occurred in global stage coordinates.stageYThe vertical coordinate at which the event occurred in global stage coordinates.targetThe InteractiveObject instance under the pointing device.
		   The target is not always the object in the display list
		   that registered the event listener. Use the currentTarget
		   property to access the object in the display list that is currently processing the event.
		 */
		public static const MOUSE_MOVE:String = "mouseMove";

		/**
		   Defines the value of the type property of a mouseOut event object.

		   This event has the following properties:PropertyValuealtKeytrue if the Alt key is active (Windows or Linux).bubblestruebuttonDowntrue if the primary mouse button is pressed; false otherwise.cancelablefalse; the default behavior cannot be canceled.commandKeytrue on the Mac if the Command key is active; false if it is inactive. Always false on Windows.controlKeytrue if the Ctrl or Control key is active; false if it is inactive.ctrlKeytrue on Windows or Linux if the Ctrl key is active. true on Mac if either the Ctrl key or the Command key is active. Otherwise, false.currentTargetThe object that is actively processing the Event
		   object with an event listener.relatedObjectThe display list object to which the pointing device now points.localXThe horizontal coordinate at which the event occurred relative to the containing sprite.localYThe vertical coordinate at which the event occurred relative to the containing sprite.shiftKeytrue if the Shift key is active; false if it is inactive.stageXThe horizontal coordinate at which the event occurred in global stage coordinates.stageYThe vertical coordinate at which the event occurred in global stage coordinates.targetThe InteractiveObject instance under the pointing device.
		   The target is not always the object in the display list
		   that registered the event listener. Use the currentTarget
		   property to access the object in the display list that is currently processing the event.
		 */
		public static const MOUSE_OUT:String = "mouseOut";

		/**
		   Defines the value of the type property of a mouseOver event object.

		   This event has the following properties:PropertyValuealtKeytrue if the Alt key is active (Windows or Linux).bubblestruebuttonDowntrue if the primary mouse button is pressed; false otherwise.cancelablefalse; the default behavior cannot be canceled.commandKeytrue on the Mac if the Command key is active; false if it is inactive. Always false on Windows.controlKeytrue if the Ctrl or Control key is active; false if it is inactive.ctrlKeytrue on Windows or Linux if the Ctrl key is active. true on Mac if either the Ctrl key or the Command key is active. Otherwise, false.currentTargetThe object that is actively processing the Event
		   object with an event listener.relatedObjectThe display list object to which the pointing device was pointing.localXThe horizontal coordinate at which the event occurred relative to the containing sprite.localYThe vertical coordinate at which the event occurred relative to the containing sprite.shiftKeytrue if the Shift key is active; false if it is inactive.stageXThe horizontal coordinate at which the event occurred in global stage coordinates.stageYThe vertical coordinate at which the event occurred in global stage coordinates.targetThe InteractiveObject instance under the pointing device.
		   The target is not always the object in the display list
		   that registered the event listener. Use the currentTarget
		   property to access the object in the display list that is currently processing the event.
		 */
		public static const MOUSE_OVER:String = "mouseOver";

		/**
		   Defines the value of the type property of a mouseUp event object.

		   This event has the following properties:PropertyValuealtKeytrue if the Alt key is active (Windows or Linux).bubblestruebuttonDowntrue if the primary mouse button is pressed; false otherwise.cancelablefalse; the default behavior cannot be canceled.commandKeytrue on the Mac if the Command key is active; false if it is inactive. Always false on Windows.controlKeytrue if the Ctrl or Control key is active; false if it is inactive.ctrlKeytrue on Windows or Linux if the Ctrl key is active. true on Mac if either the Ctrl key or the Command key is active. Otherwise, false.currentTargetThe object that is actively processing the Event
		   object with an event listener.localXThe horizontal coordinate at which the event occurred relative to the containing sprite.localYThe vertical coordinate at which the event occurred relative to the containing sprite.shiftKeytrue if the Shift key is active; false if it is inactive.clickCountCount of the number of mouse clicks to indicate whether the event is part of a multi-click sequence.stageXThe horizontal coordinate at which the event occurred in global stage coordinates.stageYThe vertical coordinate at which the event occurred in global stage coordinates.targetThe InteractiveObject instance under the pointing device.
		   The target is not always the object in the display list
		   that registered the event listener. Use the currentTarget
		   property to access the object in the display list that is currently processing the event.
		 */
		public static const MOUSE_UP:String = "mouseUp";

		/**
		   Defines the value of the type property of a mouseWheel event object.

		   This event has the following properties:PropertyValuealtKeytrue if the Alt key is active (Windows or Linux).bubblestruebuttonDowntrue if the primary mouse button is pressed; false otherwise.cancelablefalse; the default behavior cannot be canceled.commandKeytrue on the Mac if the Command key is active; false if it is inactive. Always false on Windows.controlKeytrue if the Ctrl or Control key is active; false if it is inactive.ctrlKeytrue on Windows or Linux if the Ctrl key is active. true on Mac if either the Ctrl key or the Command key is active. Otherwise, false.currentTargetThe object that is actively processing the Event
		   object with an event listener.deltaThe number of lines that that each notch on the mouse wheel represents.localXThe horizontal coordinate at which the event occurred relative to the containing sprite.localYThe vertical coordinate at which the event occurred relative to the containing sprite.shiftKeytrue if the Shift key is active; false if it is inactive.stageXThe horizontal coordinate at which the event occurred in global stage coordinates.stageYThe vertical coordinate at which the event occurred in global stage coordinates.targetThe InteractiveObject instance under the pointing device.
		   The target is not always the object in the display list
		   that registered the event listener. Use the currentTarget
		   property to access the object in the display list that is currently processing the event.
		 */
		public static const MOUSE_WHEEL:String = "mouseWheel";

		/**
		   Defines the value of the type property of a rollOut event object.

		   This event has the following properties:PropertyValuealtKeytrue if the Alt key is active (Windows or Linux).bubblesfalsebuttonDowntrue if the primary mouse button is pressed; false otherwise.cancelablefalse; there is no default behavior to cancel.commandKeytrue on the Mac if the Command key is active; false if it is inactive. Always false on Windows.controlKeytrue if the Ctrl or Control key is active; false if it is inactive.ctrlKeytrue on Windows or Linux if the Ctrl key is active. true on Mac if either the Ctrl key or the Command key is active. Otherwise, false.currentTargetThe object that is actively processing the Event
		   object with an event listener.relatedObjectThe display list object to which the pointing device now points.localXThe horizontal coordinate at which the event occurred relative to the containing sprite.localYThe vertical coordinate at which the event occurred relative to the containing sprite.shiftKeytrue if the Shift key is active; false if it is inactive.stageXThe horizontal coordinate at which the event occurred in global stage coordinates.stageYThe vertical coordinate at which the event occurred in global stage coordinates.targetThe InteractiveObject instance under the pointing device.
		   The target is not always the object in the display list
		   that registered the event listener. Use the currentTarget
		   property to access the object in the display list that is currently processing the event.
		 */
		public static const ROLL_OUT:String = "rollOut";

		/**
		   Defines the value of the type property of a rollOver event object.

		   This event has the following properties:PropertyValuealtKeytrue if the Alt key is active (Windows or Linux).bubblesfalsebuttonDowntrue if the primary mouse button is pressed; false otherwise.cancelablefalse; there is no default behavior to cancel.commandKeytrue on the Mac if the Command key is active; false if it is inactive. Always false on Windows.controlKeytrue if the Ctrl or Control key is active; false if it is inactive.ctrlKeytrue on Windows or Linux if the Ctrl key is active. true on Mac if either the Ctrl key or the Command key is active. Otherwise, false.currentTargetThe object that is actively processing the Event
		   object with an event listener.relatedObjectThe display list object to which the pointing device was pointing.localXThe horizontal coordinate at which the event occurred relative to the containing sprite.localYThe vertical coordinate at which the event occurred relative to the containing sprite.shiftKeytrue if the Shift key is active; false if it is inactive.stageXThe horizontal coordinate at which the event occurred in global stage coordinates.stageYThe vertical coordinate at which the event occurred in global stage coordinates.targetThe InteractiveObject instance under the pointing device.
		   The target is not always the object in the display list
		   that registered the event listener. Use the currentTarget
		   property to access the object in the display list that is currently processing the event.
		 */
		public static const ROLL_OVER:String = "rollOver";

		public function Type(){

		}

	}

}

