Instance: zbj-telemonitoring-atrial-fibrilation-enrollment
InstanceOf: Questionnaire
Usage: #example

// Data about the questionnaire and some housekeeping
* meta.tag = $FHIR-version#4.0.1
* language = #nl-NL
* title = "Vragenlijst voor aanmelding van patienten met atriumfibrileren voor thuismonitoring"
* url = "https://zorgbijjou.github.io/scp-homemonitoring/Questionnaire-zbj-telemonitoring-artial-fibrilation-enrollment|0.5"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:a56b90af-69a3-4bbb-908a-51ddae553092"
* status = #active
* publisher = "Zorg bij jou B.V."
* contact.telecom.system = #url
* contact.telecom.value = "https://zorgbijjou.nl"
* experimental = false
* date = "2026-06-26"
* effectivePeriod.start = "2026-08-01"
* useContext[0].code = $usage-context-type#task
* useContext[=].valueCodeableConcept = $v3-ActCode#OE "order entry task"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#49436004 "Boezemfibrilleren (aandoening)"

// These extensions allow disabling submitting the entire form, there a complex beasts and a LLM was used to figure this out:
// Disable sending based on the Pacemaker question
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/targetConstraint"
  * extension[+].url = "key"
  * extension[=].valueId = "no-pacemaker"
  * extension[+].url = "severity"
  * extension[=].valueCode = #error
  * extension[+].url = "expression"
  * extension[=].valueExpression.language = #text/fhirpath
  * extension[=].valueExpression.expression = "%resource.item.where(linkId='ff69bb6f-cbc2-48f2-9cae-d465c95e53d0').answer.valueBoolean = true"
  * extension[+].url = "human"
  * extension[=].valueString = "Een patiënt met pacemaker komt niet in aanmerking voor thuismonitoring. Vervolg de zorg via het reguliere behandeltraject."
  * extension[+].url = "location"
  * extension[=].valueString = "Questionnaire.item.where(linkId='ff69bb6f-cbc2-48f2-9cae-d465c95e53d0')"

// Disable sending based on the Pacemaker question
// Flutter = 1f14f9d4-12e5-4cff-a226-65b4bd9d9ba8
// PAS = 
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/targetConstraint"
  * extension[+].url = "key"
  * extension[=].valueId = "flutter-or-AT"
  * extension[+].url = "severity"
  * extension[=].valueCode = #error
  * extension[+].url = "expression"
  * extension[=].valueExpression.language = #text/fhirpath
  // When Flutter == true and PAF == 'Pre-ECV'
  * extension[=].valueExpression.expression = "%resource.repeat(item).where(linkId='1f14f9d4-12e5-4cff-a226-65b4bd9d9ba8').answer.valueBoolean = true and %resource.repeat(item).where(linkId='71fc98ad-2dba-4ecd-91d4-a70807dc72ac').answer.valueString = 'Pre-ECV'"
  * extension[+].url = "human"
  * extension[=].valueString = "Een patiënt met flutter of atriale tachycardie komt niet in aanmerking voor thuismonitoring. Vervolg de zorg via het reguliere behandeltraject."
  * extension[+].url = "location"
  * extension[=].valueString = "Questionnaire.repeat(item).where(linkId='1f14f9d4-12e5-4cff-a226-65b4bd9d9ba8')"

// -----------------
// |   ZorgPad     |
// -----------------

* item[0]
  * linkId = "61695e96-c574-453f-8722-8d5e9b22e5be"
  * text = "Zorgpad"
  * code = $sct#64572001 "aandoening"
  * type = #choice
  * readOnly = true
  * answerOption[+].initialSelected = true
  * answerOption[0].valueString = "Boezemfibrilleren"

// var paceMaker = "ff69bb6f-cbc2-48f2-9cae-d465c95e53d0"
* item[+]
  * linkId = "ff69bb6f-cbc2-48f2-9cae-d465c95e53d0"
  * text = "Heeft de patiënt een pacemaker?"
  * type = #boolean
  * required = true

// var groupLinkId = "39abcb98-97c7-43b5-bbab-13646b6db6e4"
* item[+]
  * linkId = "39abcb98-97c7-43b5-bbab-13646b6db6e4"
  * type = #group
  * enableWhen[+].question = "ff69bb6f-cbc2-48f2-9cae-d465c95e53d0"
  * enableWhen[=].operator = #=
  * enableWhen[=].answerBoolean = false

//   var PAF_Question = "71fc98ad-2dba-4ecd-91d4-a70807dc72ac"
  * item[+]
    * code = $sct#243120004 "Protocolvraag (regime/therapie)"
    * linkId = "71fc98ad-2dba-4ecd-91d4-a70807dc72ac"
    * text = "Meetprotocol"
    * extension[+]
      * url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
      * valueString = "<style>div:has(> div[data-linkid=\"71fc98ad-2dba-4ecd-91d4-a70807dc72ac\"]) { padding: 0; overflow: visible; box-shadow: none; background-color: unset; } }</style>Meetprotocol"
    * type = #choice
    * required = true
    * answerOption[+].valueString = "Paroxysmaal AF (PAF)"
    * answerOption[+].valueString = "Pre-ECV"
    * answerOption[+].valueString = "Klachten monitoring AF"
    * answerOption[+].valueString = "Pre en Post-ablatie"
    * answerOption[+].valueString = "Rate control"
    * answerOption[+].valueString = "Post-ECV"


  // From here on the questionnaire changes based on the selected Meetprotocol
  
  // ---------------------
  // |   Paroxysmaal     |
  // ---------------------
  
//   var BeeldBijKlachten = "7f151cd0-11f4-4ddb-a7e6-d206d52b4e8b"
//   var PillInPocketNemen = "Pill in the pocket innemen"
  * item[+]
    * linkId = "7f151cd0-11f4-4ddb-a7e6-d206d52b4e8b"
    * text = "Wat is het beleid bij de klachten?"
    * required = true
    * type = #open-choice
    * extension[+]
      * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
      * valueCode = #vertical
    * answerOption[+].valueString = "Niets doen en afwachten"
    * answerOption[+].valueString = "Pill in the pocket innemen"
    * enableWhen[+].question = "71fc98ad-2dba-4ecd-91d4-a70807dc72ac"
    * enableWhen[=].operator = #=
    * enableWhen[=].answerString = "Paroxysmaal AF (PAF)"
    * extension[+]
      * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
      * valueCodeableConcept = $questionnaire-item-control#radio-button
    * extension[+]
      * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel"
      * valueString = "Anders, namelijk"

  * item[+]
    * linkId = "fb6e09a5-386f-4330-ac7c-0c6c17ce234c"
    * required = true
    * type = #string
    * initial.valueString = "Anders namelijk"
    * enableWhen[+].question = "7f151cd0-11f4-4ddb-a7e6-d206d52b4e8b"
    * enableWhen[=].operator = #=
    * enableWhen[=].answerString = "Anders, namelijk"
  
  // -----------------------------------
  // |    pill-in-the-pocket group     |
  // -----------------------------------
  * item[+]
    * linkId = "8b74cd45-0dcb-45de-b22a-30adf1aefab3"
    * type = #group
    * enableBehavior = #all
    * enableWhen[+].question = "7f151cd0-11f4-4ddb-a7e6-d206d52b4e8b"
    * enableWhen[=].operator = #=
    * enableWhen[=].answerString = "Pill in the pocket innemen"
    * enableWhen[+].question = "71fc98ad-2dba-4ecd-91d4-a70807dc72ac"      
    * enableWhen[=].operator = #=
    * enableWhen[=].answerString = "Paroxysmaal AF (PAF)"

//   var PillInPocket = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
//   var Verapamil = "Verapamil kortwerkend - 1 tablet"
//   var Verapamil2x = "Verapamil kortwerkend - 2 tabletten"
//   var Metroprolol = "Metroprolol kortwerkend - 1 tablet"
//   var Metroprolol2x = "Metroprolol kortwerkend - 2 tabletten"
//   var Flecainide = "Flecainide kortwerkend - 1 tablet"
//   var Flecainide2x = "Flecainide kortwerkend - 2 tabletten"
//   var Solatol = "Solatol 1 tablet"
//   var Solatol2x = "Solatol 2 tabletten"
  
    * item[+]
      * linkId = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * text = "Welke pill in the pocket?"
      * required = true
      * type = #choice
      * answerOption[+].valueString = "Verapamil kortwerkend - 1 tablet"
      * answerOption[+].valueString = "Verapamil kortwerkend - 2 tabletten"
      * answerOption[+].valueString = "Metroprolol kortwerkend - 1 tablet"
      * answerOption[+].valueString = "Metroprolol kortwerkend - 2 tabletten"
      * answerOption[+].valueString = "Flecainide kortwerkend - 1 tablet"
      * answerOption[+].valueString = "Flecainide kortwerkend - 2 tabletten"
      * answerOption[+].valueString = "Solatol 1 tablet"
      * answerOption[+].valueString = "Solatol 2 tabletten"
      * extension[+]
        * url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
        * valueString = "<style>div:has(> div[data-linkid=\"27f19772-d2fe-4d3e-8f93-ab16ad948a23\"]) { padding: 0; overflow: visible; box-shadow: none; background-color: unset; } }</style>Welke pill in the pocket?"
   

  
  // Verapamil
  // Dosering
//   var VeraDossering = "134abd7b-b5da-482b-a794-9fa5b1025cfe"
    * item[+]
      * linkId = "134abd7b-b5da-482b-a794-9fa5b1025cfe" 
      * text = "Welke dosering?"
      * required = true
      * type = #open-choice
      * extension[+]  
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
        * valueCode = #vertical
      * enableBehavior = #any
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Verapamil kortwerkend - 1 tablet"  
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Verapamil kortwerkend - 2 tabletten"  
      * answerOption[+].valueString = "40 mg"
      * answerOption[+].valueString = "80 mg"
      * extension[+]
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
        * valueCodeableConcept = $questionnaire-item-control#radio-button
      * extension[+]
        * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel"
        * valueString = "Anders, namelijk"

    * item[+]
      * linkId = "feca4c2f-5b14-4b40-8ae8-b0596956257a"
      * required = true
      * type = #string
      * initial.valueString = "Anders namelijk"
      * enableWhen[+].question = "134abd7b-b5da-482b-a794-9fa5b1025cfe"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Anders, namelijk"
  
    * item[+]
      * linkId = "37bde553-9376-481e-92f3-dba979aad7a7"
      * text = "Zo nodig herhalen na hoeveel uur?"  
      * type = #integer
      * required = true
      * enableBehavior = #any
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Verapamil kortwerkend - 1 tablet" 
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Verapamil kortwerkend - 2 tabletten"
  
  // Metroprolol
  // Dosering
//   var MetroprololDosering = "26e84dfb-b26e-46f6-a2f8-b4ac63a66107"
    * item[+]
      * linkId = "26e84dfb-b26e-46f6-a2f8-b4ac63a66107"
      * text = "Welke dosering?"
      * required = true
      * type = #open-choice
      * extension[+]  
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
        * valueCode = #vertical
      * enableBehavior = #any
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Metroprolol kortwerkend - 1 tablet" 
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Metroprolol kortwerkend - 2 tabletten"
      * answerOption[+].valueString = "25 mg"
      * answerOption[+].valueString = "50 mg"
      * extension[+]
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
        * valueCodeableConcept = $questionnaire-item-control#radio-button
      * extension[+]
        * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel"
        * valueString = "Anders, namelijk"

    * item[+]
      * linkId = "ab639196-5a43-42a8-af57-997946eba0b5"
      * required = true
      * type = #string
      * initial.valueString = "Anders namelijk"
      * enableWhen[+].question = "26e84dfb-b26e-46f6-a2f8-b4ac63a66107"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Anders, namelijk"

    * item[+]
      * linkId = "189bdc00-cfe5-491b-ac89-d90b735ba5b1"
      * text = "Zo nodig herhalen na hoeveel uur?"  
      * required = true
      * type = #integer
      * enableBehavior = #any
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Metroprolol kortwerkend - 1 tablet" 
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Metroprolol kortwerkend - 2 tabletten"
  
  // Flecainide
  // Dosering
//   var FlecainideDosering = "27e5fb2e-ce3d-4182-91d9-982855e0d371"
    * item[+]
      * linkId = "27e5fb2e-ce3d-4182-91d9-982855e0d371"
      * text = "Welke dosering?"
      * required = true
      * type = #open-choice
      * extension[+]  
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
        * valueCode = #vertical
      * enableBehavior = #any
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Flecainide kortwerkend - 1 tablet" 
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Flecainide kortwerkend - 2 tabletten"
      * answerOption[+].valueString = "100 mg"
      * extension[+]
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
        * valueCodeableConcept = $questionnaire-item-control#radio-button
      * extension[+]
        * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel"
        * valueString = "Anders, namelijk"

    * item[+]
      * linkId = "0ef921f4-16ec-4cf7-b6f2-3762440e7801"
      * required = true
      * type = #string
      * initial.valueString = "Anders namelijk"
      * enableWhen[+].question = "27e5fb2e-ce3d-4182-91d9-982855e0d371"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Anders, namelijk"

  
  // Solatol
  // Dosering
//   var SolatolDosering = "805edc15-4336-4c26-bb89-d511a3d6d2ae"
    * item[+]
      * linkId = "805edc15-4336-4c26-bb89-d511a3d6d2ae"
      * text = "Welke dosering?"
      * required = true
      * type = #open-choice
      * extension[+]  
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
        * valueCode = #vertical
      * enableBehavior = #any
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Solatol 1 tablet"
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Solatol 2 tabletten"
      * answerOption[+].valueString = "40 mg"
      * answerOption[+].valueString = "80 mg"
      * extension[+]
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
        * valueCodeableConcept = $questionnaire-item-control#radio-button
      * extension[+]
        * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel"
        * valueString = "Anders, namelijk"

    * item[+]
      * linkId = "d198c8ed-ec31-47e0-b712-2c280aabec0f"
      * required = true
      * type = #string
      * initial.valueString = "Anders namelijk"
      * enableWhen[+].question = "805edc15-4336-4c26-bb89-d511a3d6d2ae"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Anders, namelijk"

  
    * item[+]
      * linkId = "44782d3b-3b06-471b-9e30-6e4c2a1b3764"
      * text = "Zo nodig herhalen na hoeveel uur?"  
      * type = #integer
      * enableBehavior = #any
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Solatol 1 tablet" 
      * enableWhen[+].question = "27f19772-d2fe-4d3e-8f93-ab16ad948a23"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Solatol 2 tabletten"

    // ------------------------------------------
    // |    Tweede pill in the pocket magic     |
    // ------------------------------------------
    // ToDo: Only show when first pill in pocket was completely filled in
    // ToDo: Do we want a checkbox for pill in pocket?

//     var TweedePillInPocketBoolean = "2920ac88-872e-4c6f-a15a-18d694696e61"
//     var TweedePillInPocketYesValue = "De patiënt heeft een tweede pill in the pocket"
    * item[+]
      * linkId = "2920ac88-872e-4c6f-a15a-18d694696e61"
      * type = #choice
      * answerOption.valueString = "De patiënt heeft een tweede pill in the pocket"
      * extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
      * extension[=].valueCodeableConcept = $questionnaire-item-control#check-box

    * item[+]
      * linkId = "47d96451-b8dc-4755-a12e-076c9cb9cd91"
      * type = #group
      * enableBehavior = #all
      * enableWhen[+].question = "2920ac88-872e-4c6f-a15a-18d694696e61"
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "De patiënt heeft een tweede pill in the pocket"
      * enableWhen[+].question = "71fc98ad-2dba-4ecd-91d4-a70807dc72ac"      
      * enableWhen[=].operator = #=
      * enableWhen[=].answerString = "Paroxysmaal AF (PAF)"

      * item[+]
        * linkId = "836b1e03-129c-47e5-aeb8-dd788c1dc311"
        * type = #display
        * text = ""
        * text.extension[+].url = "http://hl7.org/fhir/StructureDefinition/rendering-style"
        * text.extension[=].valueString = "font-weight: bold;"
        * extension[+]
          * url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
          * valueString = "<style>div:has(> div[data-linkid=\"836b1e03-129c-47e5-aeb8-dd788c1dc311\"]) { padding: 0; overflow: visible; box-shadow: none; background-color: unset; } }</style>"
    
//       var TweedePillInPocket = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
      * item[+]
        * linkId = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * text = "Welke pill in the pocket"
        * required = true
        * type = #choice
        * answerOption[+].valueString = "Verapamil kortwerkend - 1 tablet"
        * answerOption[+].valueString = "Verapamil kortwerkend - 2 tabletten"
        * answerOption[+].valueString = "Metroprolol kortwerkend - 1 tablet"
        * answerOption[+].valueString = "Metroprolol kortwerkend - 2 tabletten"
        * answerOption[+].valueString = "Flecainide kortwerkend - 1 tablet"
        * answerOption[+].valueString = "Flecainide kortwerkend - 2 tabletten"
        * answerOption[+].valueString = "Solatol 1 tablet"
        * answerOption[+].valueString = "Solatol 2 tabletten"      
    
      // Verapamil
      // Dosering
//       var VeraDossering2 = "295f7d5f-97d8-4093-b925-45a83da854e2"
      * item[+]
        * linkId = "295f7d5f-97d8-4093-b925-45a83da854e2" 
        * text = "Welke dosering?"
        * required = true
        * type = #open-choice
        * extension[+]  
          * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
          * valueCode = #vertical
        * enableBehavior = #any
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Verapamil kortwerkend - 1 tablet"
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Verapamil kortwerkend - 2 tabletten"
        * answerOption[+].valueString = "40 mg"
        * answerOption[+].valueString = "80 mg"  
        * extension[+]
          * url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
          * valueString = "Anders, namelijk <br /> "
      
        * extension[+]
          * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
          * valueCodeableConcept = $questionnaire-item-control#radio-button
        * extension[+]
          * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel"
          * valueString = "Anders, namelijk"

      * item[+]
        * linkId = "e5b742ff-d503-4eb8-9f6a-497eb896daec"
        * required = true
        * type = #string
        * initial.valueString = "Anders namelijk"
        * enableWhen[+].question = "295f7d5f-97d8-4093-b925-45a83da854e2"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Anders, namelijk"

      * item[+]
        * linkId = "6d28a3e1-5fb9-43d0-92d3-84860c8a1a75"
        * text = "Zo nodig herhalen na hoeveel uur?"  
        * required = true        
        * type = #integer
        * extension[+]  
          * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
          * valueCode = #horizontal
        * enableBehavior = #any
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Verapamil kortwerkend - 1 tablet" 
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Verapamil kortwerkend - 2 tabletten"
    
      // Metroprolol
      // Dosering
//       var MetroprololDosering2 = "93263165-130a-4176-933a-20fb29a0ab6e"
      * item[+]
        * linkId = "93263165-130a-4176-933a-20fb29a0ab6e"
        * text = "Welke dosering?"
        * required = true
        * type = #open-choice
        * extension[+]  
          * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
          * valueCode = #vertical
        * enableBehavior = #any
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Metroprolol kortwerkend - 1 tablet" 
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Metroprolol kortwerkend - 2 tabletten"
        * answerOption[+].valueString = "25 mg"
        * answerOption[+].valueString = "50 mg"
        * extension[+]
          * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
          * valueCodeableConcept = $questionnaire-item-control#radio-button
        * extension[+]
          * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel"
          * valueString = "Anders, namelijk"

      * item[+]
        * linkId = "64e52812-0645-4e06-88c1-df80b7d20ad8"
        * required = true
        * type = #string
        * initial.valueString = "Anders namelijk"
        * enableWhen[+].question = "93263165-130a-4176-933a-20fb29a0ab6e"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Anders, namelijk"
    
      * item[+]
        * linkId = "4ef30d7c-5367-480e-8c10-ac9a6395a474"
        * text = "Zo nodig herhalen na hoeveel uur?"  
        * required = true        
        * type = #integer
        * enableBehavior = #any
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Metroprolol kortwerkend - 1 tablet" 
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Metroprolol kortwerkend - 2 tabletten"
    
      // Flecainide
      // Dosering
//       var FlecainideDosering2 = "e8c4b0a4-bab9-4849-a52d-aa89b2be4c7c"
      * item[+]
        * linkId = "e8c4b0a4-bab9-4849-a52d-aa89b2be4c7c"
        * text = "Welke dosering?"
        * required = true
        * type = #open-choice
        * extension[+]  
          * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
          * valueCode = #vertical
        * enableBehavior = #any
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Flecainide kortwerkend - 1 tablet" 
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Flecainide kortwerkend - 2 tabletten"
        * answerOption[+].valueString = "100 mg"
        * extension[+]
          * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
          * valueCodeableConcept = $questionnaire-item-control#radio-button
        * extension[+]
          * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel"
          * valueString = "Anders, namelijk"

      * item[+]
        * linkId = "57785bd6-4a85-4bad-b0bc-b2f00698c655"
        * required = true
        * type = #string
        * initial.valueString = "Anders namelijk"
        * enableWhen[+].question = "e8c4b0a4-bab9-4849-a52d-aa89b2be4c7c"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Anders, namelijk"

      // Solatol
      // Dosering
//       var SolatolDosering2 = "ecb0e6e7-231d-4d57-ab96-3ab4b3cf513f"
      * item[+]
        * linkId = "ecb0e6e7-231d-4d57-ab96-3ab4b3cf513f"
        * text = "Welke dosering?"
        * required = true
        * type = #open-choice
        * extension[+]  
          * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
          * valueCode = #vertical
        * enableBehavior = #any
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Solatol 1 tablet"
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Solatol 2 tabletten"
        * answerOption[+].valueString = "40 mg"
        * answerOption[+].valueString = "80 mg"
        * extension[+]
          * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
          * valueCodeableConcept = $questionnaire-item-control#radio-button
        * extension[+]
          * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-openLabel"
          * valueString = "Anders, namelijk"

      * item[+]
        * linkId = "02ee563f-b7a1-4713-875f-383e52297689"
        * required = true
        * type = #string
        * initial.valueString = "Anders namelijk"
        * enableWhen[+].question = "ecb0e6e7-231d-4d57-ab96-3ab4b3cf513f"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Anders, namelijk"

      * item[+]
        * linkId = "68f821a5-ed4d-4d35-8c94-cf6c8e962928"
        * text = "Zo nodig herhalen na hoeveel uur?"  
        * type = #integer
        * enableBehavior = #any
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Solatol 1 tablet" 
        * enableWhen[+].question = "485351f0-cb37-40ea-aed7-c27778d7f7bc"
        * enableWhen[=].operator = #=
        * enableWhen[=].answerString = "Solatol 2 tabletten"

  * item[+]
    * linkId = "95bea39f-3a48-45c7-bd5c-e87d12e1afb5"
    * text = "Is er risico op tachycardiomyopathie (tcm)?"
    * required = true
    * type = #choice
    * extension[+]
      * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
      * valueCode = #horizontal
    * answerOption[+].valueString = "Ja (wekelijks meten)"
    * answerOption[+].valueString = "Nee (maandelijks meten)"
    * enableWhen[+].question = "71fc98ad-2dba-4ecd-91d4-a70807dc72ac"      
    * enableWhen[=].operator = #=
    * enableWhen[=].answerString = "Paroxysmaal AF (PAF)"
    * extension[+]
      * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
      * valueCodeableConcept = $questionnaire-item-control#radio-button

    
  // -----------------
  // |   Pre-ECV     |
  // -----------------
//   var PreECVId  = af60d0f9-eb1e-45df-bb73-6bf501c13636
  * item[+]
    * linkId = "af60d0f9-eb1e-45df-bb73-6bf501c13636"
    * type = #group
    * enableWhen[+].question = "71fc98ad-2dba-4ecd-91d4-a70807dc72ac"
    * enableWhen[=].operator = #=
    * enableWhen[=].answerString = "Pre-ECV"
    * text = " "

    // This UUID is used in the extensions at the root of this form to disable sending it.
//     var tachyCardia = "1f14f9d4-12e5-4cff-a226-65b4bd9d9ba8"
    * item[+]
      * linkId = "1f14f9d4-12e5-4cff-a226-65b4bd9d9ba8"
      * text = "Heeft de patiënt een flutter of atriale tachycardie?"
      * required = true
      * type = #boolean
      * extension[+]
        * url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
        * valueString = "<style>div:has(> div[data-linkid=\"1f14f9d4-12e5-4cff-a226-65b4bd9d9ba8\"]) { padding: 0; overflow: visible; box-shadow: none; background-color: unset; } }</style>Heeft de patiënt een flutter of atriale tachycardie?"
    
//     var DatumIsNogNietBekend = "Datum ECV is nog niet bekend"
//     var DatumECVUnkown = "4721a5b7-8343-4bde-9b4b-50da53c29178"

    * item[+]
      * linkId = "e918123c-c6db-42f6-a30c-3df41280ee15"
      * text = "Datum ECV"
      * type = #date
      * required = true
      * enableWhen[+].question = "4721a5b7-8343-4bde-9b4b-50da53c29178"
      * enableWhen[=].operator = #exists
      * enableWhen[=].answerBoolean = false

    * item[+]
      * linkId = "4721a5b7-8343-4bde-9b4b-50da53c29178"
      * text = ""
      * type = #choice
      * answerOption.valueString = "Datum ECV is nog niet bekend"
      * extension[+]
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
        * valueCodeableConcept = $questionnaire-item-control#check-box

  // -----------------
  // |   Post-ECV     |
  // -----------------
  * item[+]
    * linkId = "058dba5a-c7c0-4247-ba24-e3fef1443e0b"
    * text = "Datum ECV"
    * required = true
    * type = #date  
    * enableWhen[+].question = "71fc98ad-2dba-4ecd-91d4-a70807dc72ac"
    * enableWhen[=].operator = #=
    * enableWhen[=].answerString = "Post-ECV"
  
  // -----------------------------
  // |   Pre en Post-ablatie     |
  // -----------------------------
//   var PrePostAblatieId = c2f0b347-2977-4541-8177-99a4f5079b6e
  * item[+]
    * linkId = "c2f0b347-2977-4541-8177-99a4f5079b6e"
    * type = #group
    * enableWhen[+].question = "71fc98ad-2dba-4ecd-91d4-a70807dc72ac"
    * enableWhen[=].operator = #=
    * enableWhen[=].answerString = "Pre en Post-ablatie"
    * text = " "
  
//     var DatumAblatieUnknown = "d88c5d33-a24a-42db-a708-418bbefc0efc"
    * item[+]
      * linkId = "1c2e30f2-a71d-4d97-9bc6-0580012b4900"
      * text = "Datum Ablatie (PVI)"
      * required = true
      * type = #date
      * enableWhen[+].question = "d88c5d33-a24a-42db-a708-418bbefc0efc"
      * enableWhen[=].operator = #exists
      * enableWhen[=].answerBoolean = false

    * item[+]
      * linkId = "d88c5d33-a24a-42db-a708-418bbefc0efc"
      * text = ""
      * type = #choice
      * answerOption.valueString = "Datum is nog niet bekend"
      * extension[+]
        * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
        * valueCodeableConcept = $questionnaire-item-control#check-box
      * extension[+]
        * url = "http://hl7.org/fhir/StructureDefinition/rendering-xhtml"
        * valueString = "<style>div:has(> div[data-linkid=\"d88c5d33-a24a-42db-a708-418bbefc0efc\"]) { padding: 0; overflow: visible; box-shadow: none; background-color: unset; } }</style>"


  // -------------------------
  // |    Footer             |
  // -------------------------
  
  * item[+]
    * linkId = "89d7580e-70f6-498d-873a-bbd58ac0b699"
    * text = "Notitie (optioneel)"
    * code = $sct#11221000146107 "notitie (gegevensobject)"
    * type = #text
    * repeats = false
    * extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
    * extension.valueString = "Notitie (optioneel)"
  
  * item[+]
    * linkId = "55871c14-8b10-420b-a676-0a2ac2779c2c"
    * text = "Begeleiding"
    * code = $sct#761731000000100 "moeite met gebruiken van personal computer"
    * type = #choice
    * answerOption.valueCoding = $sct#373066001 "Ja, de patiënt heeft hulp nodig bij het downloaden en inloggen in de app"
    * extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
    * extension[=].valueCodeableConcept = $questionnaire-item-control#check-box

