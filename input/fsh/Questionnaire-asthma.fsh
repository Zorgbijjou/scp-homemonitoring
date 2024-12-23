Instance: zbj-telemonitoring-asthma-enrollment
InstanceOf: Questionnaire
Usage: #example
* meta.tag = $FHIR-version#4.0.1
// * contained[0] = YesNo
* language = #nl-NL
* title = "Vragenlijst voor aanmelding van patienten met astma voor telemonitoring"
* url = "https://zorgbijjou.github.io/scp-homemonitoring/Questionnaire-zbj-telemonitoring-asthma-enrollment|0.2"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:503d6f64-27af-4480-ad99-e357cea2decb"
* status = #active
* publisher = "Zorg bij jou B.V."
* contact.telecom.system = #url
* contact.telecom.value = "https://zorgbijjou.nl"
* experimental = false
* date = "2024-12-23"
* effectivePeriod.start = "2024-12-23"
* useContext[0].code = $usage-context-type#task
* useContext[=].valueCodeableConcept = $v3-ActCode#OE "order entry task"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#195967001 "astma (aandoening)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#715191006 "monitoren van astma via e-health (regime/therapie)"

* item[0].linkId = "2302252c-9360-4a96-a75e-e04f84952af8"
* item[=].text = "Zorgpad"
* item[=].code = $sct#64572001 "aandoening"
* item[=].type = #choice
* item[=].readOnly = true
* item[=].answerOption[0].valueCoding = $sct#195967001 "Astma"
* item[=].answerOption[=].initialSelected = true

* item[+].linkId = "da65ffd8-fb90-4918-becf-dfe0439577d8"
* item[=].text = "Instel / titratiefase"
* item[=].code = $sct#713838004 "optimaliseren van medicatie"
* item[=].type = #choice
* item[=].answerOption[0].valueCoding = $sct#373066001 "ja, instel / titratiefase"
* item[=].answerOption[=].initialSelected = true
* item[=].answerOption[+].valueCoding = $sct#373067005 "nee, bestaande patient"
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
* item[=].extension[=].valueCode = #horizontal

* item[+].linkId = "4b2e2ce0-37c5-4240-a733-872836382c5b" //extra-parameters
* item[=].type = #group
* item[=].enableWhen.question = "da65ffd8-fb90-4918-becf-dfe0439577d8"
* item[=].enableWhen.operator = #=
* item[=].enableWhen.answerCoding = $sct#373067005

* item[=].item[+].linkId = "6635f5c1-8ed0-44ad-ad3d-8f763b9ca123"
* item[=].item[=].text = "Biologicals"
* item[=].item[=].code = $sct#76334006 "immunotherapie"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, biologicals"
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box

* item[=].item[+].linkId = "fd9da7fd-aab7-4dc4-8ca5-6b70c1c671df"
* item[=].item[=].text = "Frequentie"
* item[=].item[=].code = $sct#307459002 "frequentie interval"
* item[=].item[=].type = #choice
* item[=].item[=].answerOption[0].valueCoding = $sct#14497002 "wekelijks"
* item[=].item[=].answerOption[+].valueCoding = $sct#89185003 "maandelijks"
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
* item[=].item[=].extension[=].valueCode = #horizontal

* item[+].linkId = "7cc84231-040b-49b4-beff-64ca901f776c" //extra-parameters
* item[=].type = #group

* item[=].item[+].linkId = "2c1136b1-6f99-444a-b3d3-c0a2521091dd"
* item[=].item[=].text = "Long aanval actie plan"
* item[=].item[=].code = $loinc#80796-6 "behandelplan longaandoening notitie (document)"
* item[=].item[=].required = true
* item[=].item[=].type = #text
* item[=].item[=].repeats = false
* item[=].item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension.valueString = "Plak hier het LAAP uit het EPD"

* item[=].item[+].linkId = "90770491-49f9-4e2e-b629-046fe98f1716"
* item[=].item[=].text = "Asthma Control Questionnaire score"
* item[=].item[=].code = $sct#763077003 "Asthma Control Questionnaire score"
* item[=].item[=].required = true
* item[=].item[=].type = #decimal
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension[=].valueString = "ACQ '0.0'"

* item[=].item[+].linkId = "2c1136b1-6f99-444a-b3d3-c0a2521091dd"
* item[=].item[=].text = "Medicatie"
* item[=].item[=].code = $sct#410942007 "drug of geneesmiddel"
* item[=].item[=].required = true
* item[=].item[=].type = #text
* item[=].item[=].repeats = false
* item[=].item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension.valueString = "Rescuemedicatie, onderhoudsmedicatie, ..."

* item[=].item[+].linkId = "c758a1da-4938-4f95-abf5-a2956761dcd4"
* item[=].item[=].text = "Notitie"
* item[=].item[=].code = $sct#11221000146107 "notitie (gegevensobject)"
* item[=].item[=].type = #text
* item[=].item[=].repeats = false
* item[=].item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension.valueString = "Notitie (optioneel)"

* item[+].linkId = "ec55071b-b4b0-44c9-927c-9df3b9508afc"
* item[=].text = "Begeleiding bij onboarding"
* item[=].text.extension[+].url = "http://hl7.org/fhir/StructureDefinition/rendering-style"
* item[=].text.extension[=].valueString = "font-size: 1.25rem;"
* item[=].type = #group

* item[=].item[+].linkId = "d1965bee-c1ca-408b-9085-ff748390d2d6"
* item[=].item[=].text = "Moeite met apps"
* item[=].item[=].code = $sct#761731000000100 "moeite met gebruiken van personal computer"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, patiënt heeft hulp nodig bij het downloaden en inloggen in de app"
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box