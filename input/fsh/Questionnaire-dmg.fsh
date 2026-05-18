Instance: zbj-telemonitoring-dmg-enrollment
InstanceOf: Questionnaire
Usage: #example
* meta.tag = $FHIR-version#4.0.1
* language = #nl-NL
* title = "Vragenlijst voor aanmelding van patienten met zwangerschapsdiabetes voor thuismonitoring"
* url = "https://zorgbijjou.github.io/scp-homemonitoring/Questionnaire-zbj-telemonitoring-dmg-enrollment|0.5"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:c55ca8ee-8b29-4788-9f6a-26155659e9f5"
* status = #active
* publisher = "Zorg bij jou B.V."
* contact.telecom.system = #url
* contact.telecom.value = "https://zorgbijjou.nl"
* experimental = false
* date = "2026-05-18"
* effectivePeriod.start = "2026-05-18"
* useContext[0].code = $usage-context-type#task
* useContext[=].valueCodeableConcept = $v3-ActCode#OE "order entry task"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#11687002 "zwangerschapsdiabetes (aandoening)"

* item[0].linkId = "a1e3c5d7-4b6f-8a2e-9c0d-1b3e5a7c9f2d"
* item[=].text = "Zorgpad"
* item[=].code = $sct#64572001 "aandoening"
* item[=].type = #choice
* item[=].readOnly = true
* item[=].answerOption[0].valueCoding = $sct#11687002 "Zwangerschapsdiabetes"
* item[=].answerOption[=].initialSelected = true

* item[+].linkId = "b2f4d6e8-5c7a-9b3f-0d1e-2c4f6b8d0a3e"
* item[=].text = "Meetprotocol"
* item[=].code = $sct#243120004 "Protocolvraag (regime/therapie)"
* item[=].type = #choice
* item[=].required = true
* item[=].answerOption[0].valueString = "Dagelijks instel zonder insuline"
* item[=].answerOption[+].valueString = "4x per week zonder insuline"
* item[=].answerOption[+].valueString = "2x per week zonder insuline"
* item[=].answerOption[+].valueString = "Dagelijks instel met insuline"
* item[=].answerOption[+].valueString = "4x per week met insuline"
* item[=].answerOption[+].valueString = "Patiënt met sensor"
* item[=].answerOption[+].valueString = "Na de geboorte"
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].extension[=].valueString = "Selecteer protocol"
// Custom rendering to set a custom width for this choice only to prevent wrapping of the answer options.
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
* item[=].extension[=].valueString = "<style>div[data-linkid=\"b2f4d6e8-5c7a-9b3f-0d1e-2c4f6b8d0a3e\"] > div > div:last-child > div {  &, & > div { max-width: 350px;} }</style>Meetprotocol"


* item[+].linkId = "7cc84231-040b-49b4-beff-64ca901f776c" //extra-parameters
* item[=].type = #group
* item[=].enableWhen[+].question = "b2f4d6e8-5c7a-9b3f-0d1e-2c4f6b8d0a3e"
* item[=].enableWhen[=].operator = #=
* item[=].enableWhen[=].answerString = "Dagelijks instel met insuline"
* item[=].enableWhen[+].question = "b2f4d6e8-5c7a-9b3f-0d1e-2c4f6b8d0a3e"
* item[=].enableWhen[=].operator = #=
* item[=].enableWhen[=].answerString = "4x per week met insuline"
* item[=].enableWhen[+].question = "b2f4d6e8-5c7a-9b3f-0d1e-2c4f6b8d0a3e"
* item[=].enableWhen[=].operator = #=
* item[=].enableWhen[=].answerString = "Patiënt met sensor"
* item[=].enableBehavior = #any

* item[=].item[+].linkId = "b54871e3-1b87-4705-a6d3-d0f93a61d9cc" //extra-parameters
* item[=].item[=].text = "Dosis"
* item[=].item[=].required = true
* item[=].item[=].type = #text
* item[=].item[=].repeats = false
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension[=].valueString = "Vul het type insuline en de dosering in"

* item[+].linkId = "28755b2e-7fb4-4f4a-a104-4a7cbdf4eea6"
* item[=].code = $sct#23667007 "aterme partus (bevinding)"
* item[=].text = "A terme datum (ATD)"
* item[=].required = true
* item[=].type = #date

* item[+].linkId = "d4b6f0a1-7e9c-1d5b-2f3a-4e6b8d0c1f2a"
* item[=].text = "Notitie (optioneel)"
* item[=].code = $sct#11221000146107 "notitie (gegevensobject)"
* item[=].type = #text
* item[=].repeats = false
* item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].extension.valueString = "Notitie (optioneel)"
* item[=].item[+].linkId = "e5c7a1b2-8f0d-2e6c-3a4b-5f7c9e1d2a3b"
* item[=].item[=].text = "Voorbeelden: patiënt is slechthorend, patiënt wordt geholpen door mantelzorger."
* item[=].item[=].type = #display
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-displayCategory"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-display-category#instructions

* item[+].linkId = "f6d8b2c3-9a1e-3f7d-4b5c-6a8d0f2e3b4c"
* item[=].text = "Begeleiding"
* item[=].code = $sct#761731000000100 "moeite met gebruiken van personal computer"
* item[=].type = #choice
* item[=].repeats = true
* item[=].answerOption.valueCoding = $sct#373066001 "Ja, de patiënt heeft hulp nodig bij het downloaden en de eerste keer inloggen in de apps"
* item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
