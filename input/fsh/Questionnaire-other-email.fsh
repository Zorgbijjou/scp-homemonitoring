Instance: zbj-telemonitoring-other-email
InstanceOf: Questionnaire
Usage: #example
* meta.tag = $FHIR-version#4.0.1
* language = #nl-NL
* title = "Vragenlijst voor het aanvragen van een ander e-mailadres voor een patiënt"
* url = "https://zorgbijjou.github.io/scp-homemonitoring/Questionnaire-other-email|0.5"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:a7d00e8b-09cc-467a-ad7b-a4b16d1a9fbc"
* status = #active
* publisher = "Zorg bij jou B.V."
* contact.telecom.system = #url
* contact.telecom.value = "https://zorgbijjou.nl"
* experimental = false
* date = "2025-07-28"
* effectivePeriod.start = "2025-07-28"
* useContext[0].code = $usage-context-type#task
* useContext[=].valueCodeableConcept = $v3-ActCode#OE "order entry task"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#260686007 "Contact Point"


* item[0].linkId = "eab9d251-2192-4998-beda-0a911e2ac9a0"
* item[=].text = "E-mailadres"
* item[=].required = true
* item[=].code = $sct#260686007 "Contact Point"
* item[=].type = #string
* item[=].repeats = false