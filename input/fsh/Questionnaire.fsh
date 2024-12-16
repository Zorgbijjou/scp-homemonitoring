





Instance: zbj-telemonitoring-heartfailure-enrollment
InstanceOf: Questionnaire
Usage: #example
* meta.tag = $FHIR-version#4.0.1
//* contained[0] = YesNo
* language = #nl-NL
* title = "Vragenlijst voor aanmelding van patienten met hartfalen voor telemonitoring"
* url = "https://zorgbijjou.github.io/scp-homemonitoring/Questionnaire-zbj-telemonitoring-heartfailure-enrollment|0.3"
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
* item[+].linkId = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].text = "Selecteer het Meetprotocol"
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

* item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "1b81f13b-923e-4fc8-b758-08b3f172b2de"
* item[=].item[=].text = "Titratie"
* item[=].item[=].code = $sct#713838004 "optimaliseren van medicatie"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, titratie"

// //if you'd want to change previous question to a yes/no radio button:
// * item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
// * item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#radio-button
// * item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
// * item[=].item[=].extension[=].valueCode = #horizontal
// * item[=].item[=].linkId = "1b81f13b-923e-4fc8-b758-08b3f172b2de"
// * item[=].item[=].text = "Titratie"
// * item[=].item[=].code = $sct#713838004 "optimaliseren van medicatie"
// * item[=].item[=].type = #choice
// * item[=].item[=].repeats = false
// * item[=].item[=].answerValueSet = "#YesNo"

* item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "dcba2829-32d8-4390-b1d4-32a5fefda539"
* item[=].item[=].text = "Recompensatie"
* item[=].item[=].code = $sct#308118002 "behandelen van hartfalen"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, recompensatie"

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

* item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "135aec2f-e410-4668-9a26-f745dc1789af"
* item[=].item[=].text = "Ziekenhuispatiënt"
* item[=].item[=].code = $sct#266938001 "ziekenhuispatiënt"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, patiënt is opgenomen geweest"

* item[=].item[+].extension.url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension.valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "345ca4a3-1bc8-4358-8d78-783c05953261"
* item[=].item[=].text = "Apparatuur beschikbaar"
* item[=].item[=].code = $sct#735333005 "apparatuur beschikbaar"
* item[=].item[=].type = #choice
* item[=].item[=].required = true
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, patiënt beschikt over een weegschaal en bloeddrukmeter (of is bereid deze aan te schaffen)"

* item[=].item[+].extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension.valueString = "Notitie (optioneel)"
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

* item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "295a22d7-d0ff-4546-b2a0-ce46beeba086"
* item[=].item[=].text = "Moeite met apps"
* item[=].item[=].code = $sct#761731000000100 "moeite met gebruiken van personal computer"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, patiënt heeft hulp nodig bij het downloaden en inloggen in de app"

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


Instance: zbj-bundle-questionnaires
InstanceOf: Bundle
Usage: #example
Title: "Zorg bij jou - Bundle - Questionnaires"
Description: "Bundle containing Questionnaire instances"
* type = #batch
* insert BundleEntry(zbj-telemonitoring-heartfailure-enrollment, #PUT, Questionnaire?identifier=urn:uuid:ca893f5c-2868-4349-bc0f-66f67d4ab3a2)


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
* item[=].text = "Selecteer het Meetprotocol"
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

* item[=].item[+].extension.url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension.valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "345ca4a3-1bc8-4358-8d78-783c05953261"
* item[=].item[=].code = $sct#404684003 "klinische bevinding (bevinding)"
* item[=].item[=].type = #choice
* item[=].item[=].required = true
* item[=].item[=].answerOption.valueCoding = $sct#735333005 "De patiënt beschikt over een weegschaal en bloeddrukmeter (of is bereid deze aan te schaffen)"

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