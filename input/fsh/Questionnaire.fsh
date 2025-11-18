Instance: zbj-bundle-questionnaires
InstanceOf: Bundle
Usage: #example
Title: "Zorg bij jou - Bundle - Questionnaires"
Description: "Bundle containing Questionnaire instances"
* type = #batch
* insert BundleEntry(zbj-telemonitoring-heartfailure-enrollment, #PUT, Questionnaire?identifier=urn:uuid:ca893f5c-2868-4349-bc0f-66f67d4ab3a2)
* insert BundleEntry(zbj-telemonitoring-asthma-enrollment, #PUT, Questionnaire?identifier=urn:uuid:503d6f64-27af-4480-ad99-e357cea2decb)
* insert BundleEntry(zbj-telemonitoring-copd-enrollment, #PUT, Questionnaire?identifier=urn:uuid:a2b92428-4afb-4ba8-9a7f-7165bc46f24c)


Instance: YesNo
InstanceOf: ValueSet
Usage: #inline
* name = "YesNo"
* title = "Yes/No"
* status = #draft
* description = "Concepts for Yes and No"
* expansion.timestamp = "2023-09-01T11:16:50+10:00"
* expansion.contains[0].system = $sct
* expansion.contains[=].code = #373066001
* expansion.contains[=].display = "Ja"
* expansion.contains[+].system = $sct
* expansion.contains[=].code = #373067005
* expansion.contains[=].display = "Nee"