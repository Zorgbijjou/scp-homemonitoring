Instance: zbj-telemonitoring-heartfailure-enrollment
InstanceOf: Questionnaire
Usage: #example
* meta.tag = $FHIR-version#4.0.1
//* contained[0] = YesNo
* language = #nl-NL
* title = "Vragenlijst voor aanmelding van patienten met hartfalen voor telemonitoring"
* url = "https://zorgbijjou.github.io/scp-homemonitoring/Questionnaire-zbj-telemonitoring-heartfailure-enrollment|0.5"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:ca893f5c-2868-4349-bc0f-66f67d4ab3a2"
* status = #active
* publisher = "Zorg bij jou B.V."
* contact.telecom.system = #url
* contact.telecom.value = "https://zorgbijjou.nl"
* experimental = false
* date = "2024-12-11"
* effectivePeriod.start = "2024-12-11"
* useContext[0].code = $usage-context-type#task
* useContext[=].valueCodeableConcept = $v3-ActCode#OE "order entry task"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#84114007 "hartfalen (aandoening)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#879780004 "monitoren van chronisch hartfalen via telegeneeskunde (regime/therapie)"

* item[0].linkId = "5c167c2d-f518-4bc1-adb7-ea06bc789a36"
* item[=].text = "Zorgpad"
* item[=].code = $sct#64572001 "aandoening"
* item[=].type = #choice
* item[=].readOnly = true
* item[=].answerOption[0].valueCoding = $sct#84114007 "Hartfalen"
* item[=].answerOption[=].initialSelected = true

* item[+].linkId = "75ef8921-cfc9-4573-8ff0-99b650c860de"
* item[=].text = "Start thuismonitoring na opname voor hartfalen"
* item[=].type = #boolean
* item[=].initial.valueBoolean = false
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
// Custom rendering since FHIR Questionnaire does not support labels next to boolean checkboxes
* item[=].extension[=].valueString = "<style>label:has(#boolean-75ef8921-cfc9-4573-8ff0-99b650c860de)::after {content: 'Ja, de patiënt start thuismonitoring na opname in het ziekenhuis voor hartfalen';}</style> Start thuismonitoring na opname voor hartfalen"

* item[+].linkId = "274e66c7-1e60-4075-bcde-1d11876e3897"
* item[=].text = "Meetprotocol"
* item[=].code = $sct#243120004 "Protocolvraag (regime/therapie)"
* item[=].type = #choice
* item[=].enableWhen.question = "75ef8921-cfc9-4573-8ff0-99b650c860de"
* item[=].enableWhen.operator = #=
* item[=].enableWhen.answerBoolean = true
* item[=].required = true
* item[=].answerOption[0].valueCoding = $sct#713838004 "Titratie" // optimaliseren van medicatie
* item[=].answerOption[+].valueCoding = $sct#308118002 "Recompensatie" // behandelen van hartfalen
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].extension[=].valueString = "Selecteer protocol"

* item[+].linkId = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].text = "Meetprotocol"
* item[=].code = $sct#243120004 "Protocolvraag (regime/therapie)"
* item[=].type = #choice
* item[=].enableWhen.question = "75ef8921-cfc9-4573-8ff0-99b650c860de"
* item[=].enableWhen.operator = #!=
* item[=].enableWhen.answerBoolean = true
* item[=].required = true
* item[=].answerOption[0].valueCoding = $sct#58158008 "Stabiel"
* item[=].answerOption[+].valueCoding = $sct#713838004 "Titratie" // optimaliseren van medicatie
* item[=].answerOption[+].valueCoding = $sct#308118002 "Recompensatie" // behandelen van hartfalen
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].extension[=].valueString = "Selecteer protocol"

* item[+].linkId = "4e973bcb-bbbb-4a9f-877b-fbf45ab94361"
* item[=].text = "Streefgewicht"
* item[=].required = true
* item[=].type = #decimal
* item[=].code = $sct#1078215008 "Target body weight"
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-unit"
* item[=].extension[=].valueCoding = $unitsofmeasure#kg "kg"
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].extension[=].valueString = "Streefgewicht"

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

* item[+].linkId = "2bc0b73f-506a-48a4-994d-fe355a5825f3"
* item[=].text = "Begeleiding bij onboarding"
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
// Custom rendering since ORCA does not support _text elements
* item[=].extension[=].valueString = "<style>#label-2bc0b73f-506a-48a4-994d-fe355a5825f3 { font-size: 1.25rem; }</style>Begeleiding bij onboarding"
* item[=].type = #display

* item[+].linkId = "295a22d7-d0ff-4546-b2a0-ce46beeba086"
* item[=].text = "Begeleiding"
* item[=].code = $sct#761731000000100 "moeite met gebruiken van personal computer"
* item[=].type = #choice
* item[=].repeats = true
* item[=].answerOption.valueCoding = $sct#373066001 "Ja, de patiënt heeft hulp nodig bij het downloaden en inloggen in de app"
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box




Instance: zbj-telemonitoring-heartfailure-enrollment-assertions
InstanceOf: Questionnaire
Usage: #example
* meta.tag = $FHIR-version#4.0.1
* language = #nl-NL
* title = "Vragenlijst voor aanmelding van patienten met hartfalen voor telemonitoring"
* url = "https://zorgbijjou.github.io/scp-homemonitoring/Questionnaire-zbj-telemonitoring-heartfailure-enrollment-assertions|0.3"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:4803c717-d753-4613-9466-4f8adc85249e"
* status = #draft
* publisher = "Zorg bij jou B.V."
* contact.telecom.system = #url
* contact.telecom.value = "https://zorgbijjou.nl"
* experimental = false
* date = "2024-12-11"
* effectivePeriod.start = "2024-12-11"
* useContext[0].code = $usage-context-type#task
* useContext[=].valueCodeableConcept = $v3-ActCode#OE "order entry task"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#84114007 "hartfalen (aandoening)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#879780004 "monitoren van chronisch hartfalen via telegeneeskunde (regime/therapie)"

* item[0].linkId = "5c167c2d-f518-4bc1-adb7-ea06bc789a36"
* item[=].text = "Zorgpad"
* item[=].type = #string
* item[=].readOnly = true
* item[=].initial.valueString = "Hartfalen"

* item[+].linkId = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].text = "Meetprotocol"
* item[=].code = $sct#362981000 "kwalificatiewaarde"
* item[=].type = #choice
* item[=].required = true
* item[=].answerOption[0].valueCoding = $sct#255299009 "Instabiel"
* item[=].answerOption[+].valueCoding = $sct#58158008 "Stabiel"


* item[+].linkId = "2f505566-ac92-4347-8731-840e6bc84851" //extra-parameters
* item[=].type = #group
* item[=].enableWhen.question = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].enableWhen.operator = #=
* item[=].enableWhen.answerCoding = $sct#255299009

* item[=].item[+].extension.url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension.valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
* item[=].item[=].extension[=].valueCode = #vertical
* item[=].item[=].linkId = "dcba2829-32d8-4390-b1d4-32a5fefda539"
* item[=].item[=].text = "Vink aan indien van toepassing"
* item[=].item[=].code = $sct#276239002 "therapie (regime/therapie)"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption[+].valueCoding = $sct#713838004 "Titratie"
* item[=].item[=].answerOption[+].valueCoding = $sct#308118002 "Recompensatie"


* item[+].linkId = "170292e5-3163-43b4-88af-affb3e4c27ab"
* item[=].type = #group
* item[=].enableWhen.question = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].enableWhen.operator = #exists
* item[=].enableWhen.answerBoolean = true

* item[=].item[0].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-unit"
* item[=].item[=].extension[=].valueCoding = $unitsofmeasure#kg "kg"
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension[=].valueString = "Streefgewicht '0.0'"
* item[=].item[=].linkId = "4e973bcb-bbbb-4a9f-877b-fbf45ab94361"
* item[=].item[=].text = "Streefgewicht"
* item[=].item[=].required = true
* item[=].item[=].type = #decimal
* item[=].item[=].code = $sct#1078215008 "Target body weight"

* item[=].item[+].extension.url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension.valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
* item[=].item[=].extension[=].valueCode = #vertical
* item[=].item[=].linkId = "135aec2f-e410-4668-9a26-f745dc1789af"
* item[=].item[=].text = "Vink aan indien van toepassing"
* item[=].item[=].code = $sct#404684003 "klinische bevinding (bevinding)"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption[+].valueCoding = $sct#266938001 "De patiënt is opgenomen geweest"

* item[=].item[+].extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension.valueString = "Notitie  (optioneel)"
* item[=].item[=].linkId = "be4b671d-f91f-4fc3-a6d8-fcafa8e67161"
* item[=].item[=].text = "Notitie"
* item[=].item[=].code = $sct#11221000146107 "notitie (gegevensobject)"
* item[=].item[=].type = #text
* item[=].item[=].repeats = false


* item[+].linkId = "2bc0b73f-506a-48a4-994d-fe355a5825f3"
* item[=].text = "Begeleiding bij onboarding"
* item[=].text.extension[+].url = "http://hl7.org/fhir/StructureDefinition/rendering-style"
* item[=].text.extension[=].valueString = "font-size: 1.25rem;"
* item[=].type = #group
* item[=].enableWhen.question = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].enableWhen.operator = #exists
* item[=].enableWhen.answerBoolean = true

* item[=].item[+].extension.url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension.valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "295a22d7-d0ff-4546-b2a0-ce46beeba086"
* item[=].item[=].text = "Vink aan indien van toepassing"
* item[=].item[=].code = $sct#404684003 "klinische bevinding (bevinding)"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption[+].valueCoding = $sct#761731000000100 "De patiënt heeft hulp nodig bij het downloaden en inloggen in de app"