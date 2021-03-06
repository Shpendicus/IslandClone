﻿'''<Summary>The BasicCardRequest dictionary is a JavaScript object-structure that can be used in the Payment Request API. The properties of BasicCardRequest are defined in the Basic Card Payment spec).</Summary>
<DynamicInterface(GetType(EcmaScriptObject))>
Public Interface [BasicCardRequest]
  '''<Summary>An optional array of DOMStrings representing the card networks that the retailer supports (e.g. "amex", "mastercard"); see Card network identifiers for a complete list. If the property is missing, it implies that all networks are supported.</Summary>
  Property [supportedNetworks] As String
End Interface