Instance: zbj-telemonitoring-copd-enrollment
InstanceOf: Questionnaire
Usage: #example
* meta.tag = $FHIR-version#4.0.1
* language = #nl-NL
* title = "Vragenlijst voor aanmelding van patienten met COPD voor telemonitoring"
* url = "https://zorgbijjou.github.io/scp-homemonitoring/Questionnaire-zbj-telemonitoring-copd-enrollment|0.5"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:a2b92428-4afb-4ba8-9a7f-7165bc46f24c"
* status = #active
* publisher = "Zorg bij jou B.V."
* contact.telecom.system = #url
* contact.telecom.value = "https://zorgbijjou.nl"
* experimental = false
* date = "2025-11-18"
* effectivePeriod.start = "2025-11-18"
* useContext[0].code = $usage-context-type#task
* useContext[=].valueCodeableConcept = $v3-ActCode#OE "order entry task"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#13645005 "chronische obstructieve longaandoening (aandoening)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#716358000 "monitoren van chronische obstructieve longziekte via telegeneeskunde (regime/therapie)"

* item[0].linkId = "5c167c2d-f518-4bc1-adb7-ea06bc789a36"
* item[=].text = "Zorgpad"
* item[=].code = $sct#64572001 "aandoening"
* item[=].type = #choice
* item[=].readOnly = true
* item[=].answerOption[0].valueCoding = $sct#13645005 "COPD"
* item[=].answerOption[=].initialSelected = true

* item[+].linkId = "274e66c7-1e60-4075-bcde-1d11876e3897"
* item[=].text = "Meetprotocol"
* item[=].code = $sct#243120004 "Protocolvraag (regime/therapie)"
* item[=].type = #choice
* item[=].required = true
* item[=].answerOption[0].valueString = "Instelfase"
* item[=].answerOption[+].valueString = "Intensieve monitoring 14 dagen na opname"
* item[=].answerOption[+].valueString = "Wekelijks"
* item[=].answerOption[+].valueString = "Maandelijks"
* item[=].answerOption[+].valueString = "Intensieve monitoring 7 dagen vanuit instelfase"
* item[=].answerOption[+].valueString = "Intensieve monitoring 7 dagen vanuit reguliere monitoring"
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].extension[=].valueString = "Selecteer protocol"

* item[+].linkId = "df40d8e5-bd4e-43c9-a3a6-667e161a5ce8"
* item[=].text = "COPD onderhouds- en rescuemedicatie (optioneel)"
* item[=].code = $sct#11181000146103 "actueel medicatieoverzicht (gegevensobject)"
* item[=].type = #text
* item[=].repeats = false
* item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].extension.valueString = "Vul COPD onderhouds- en rescuemedicatie in (optioneel)"

* item[+].linkId = "75ef8921-cfc9-4573-8ff0-99b650c860de"
* item[=].text = "Gerelateerde ziekenhuisopname"
* item[=].type = #boolean
* item[=].initial.valueBoolean = false
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
// Custom rendering since FHIR Questionnaire does not support labels next to boolean checkboxes
* item[=].extension[=].valueString = "<style>label:has(#boolean-75ef8921-cfc9-4573-8ff0-99b650c860de)::after {content: 'Ja, de patiënt start de thuismonitoring na gerelateerde ziekenhuisopname';}</style>Gerelateerde ziekenhuisopname"

* item[+].linkId = "be4b671d-f91f-4fc3-a6d8-fcafa8e67161"
* item[=].text = "Notitie (optioneel)"
* item[=].code = $sct#11221000146107 "notitie (gegevensobject)"
* item[=].type = #text
* item[=].repeats = false
* item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].extension.valueString = "Notitie (optioneel)"
* item[=].item[+].linkId = "c230b150-c66f-4892-b9f6-5fff067962ee"
* item[=].item[=].text = "Voorbeelden: patiënt is slechthorend, patiënt wordt geholpen door mantelzorger."
* item[=].item[=].type = #display
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-displayCategory"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-display-category#instructions

* item[+].linkId = "295a22d7-d0ff-4546-b2a0-ce46beeba086"
* item[=].text = "Begeleiding"
* item[=].code = $sct#761731000000100 "moeite met gebruiken van personal computer"
* item[=].type = #choice
* item[=].repeats = true
* item[=].answerOption.valueCoding = $sct#373066001 "Ja, de patiënt heeft hulp nodig bij het downloaden en inloggen in de app"
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
