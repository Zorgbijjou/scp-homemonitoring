# Introduction
This document describes how to use the Nuts-specifications and Shared Care Planning in the context of home monitoring. This includes the specific agreements that, in addition to the Nuts-specifications "workflow/ notified pull" and "data/ zorginzage 2024" and the Shared Care Planning Implementation Guide, apply to the use case of home monitoring.

This document describes:
- the technical context on how to update questionnaires
- the specific functional processes
- the identifier of the use case;
- the governance;
- the information standards;
- presentation definition for UCL/ Service Discovery
- presentation definition for data requests
- the permitted means of authentication;
- the permitted legal bases;
- naming of actors;
- the access policy; and
- sequence diagram

# How To
- Install sushi through npm: `npm install -g fsh-sushi`
- Update questionnaire definitions in `input/fsh`
- Run `sushi build` in the root of this repository
- Add updated files to git and create a pull request
- Get approval and merge to main
- Restart the ZorgBijJou (ZBJ) ORCA containers to load the updated questionnaires

# functional processes
A general practitioner from organization GP sends a referral request to organization HPO for the treament of patient P.
A head practitioner from organization HPO needs access to data that resides in GP to do her/his job.
A head practitioner from organization HPO sends a request to organization MSC to perform home monitoring services for patient P.
A home monitoring professional (commonly referred to as eNurse) works in a medical service center. The eNurse needs access to data that resides in HPO and in GP to do her/his job.

# use case identifier
The identifier of the use case is 'zorginzage-homemonitoring'.

# Governance
- Information standards for the medical data are developed and maintained by Zorg bij Jou and based on national informayion standards developed and maintained by Nictiz
- Information standards for the composition of the care network (e.g. CarePlan, CareTeam) are developeed and maintained by IHE ([IHE-DCP chapter 6.6](http://ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_DCP.pdf))
- The Shared Care Planning Implementation Guide is developed and maintained by Santeon
- The Nuts-specifications are developed and maintained by the Nuts foundation
- This specification is developed and maintained by [Zorg bij Jou](https://www.zorgbijjou.nl) in collaboration with Santeon

# Information standards
- The content and structure of the medical information to be exchanged comply with the Functioneel Ontwerp BgZ medisch-specialistische zorg 1.0: https://informatiestandaarden.nictiz.nl/wiki/BgZ:V1.0_BgZ_MSZ_Informatiestandaard
- The structure of the data to be exchanged and the data interfaces to be used comply with the BgZ medisch-specialistische zorg Technical Implementation Guide 1.0: https://informatiestandaarden.nictiz.nl/wiki/BgZ:V1.0_BgZ_2017_Technical_IG
- Unstructured documents containing health information are exchanged using the MedMij FHIR Implementation Guide: PDF/A 3.0.37L https://informatiestandaarden.nictiz.nl/wiki/MedMij:V2020.01/FHIR_PDFA#List_of_profiles
- The content and structure of resources that represent the composition of the care network (e.g. CarePlan, CareTeam) comply with chapter 6.6 of the [IHE-DCP profile](http://ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_DCP.pdf).
- Tasks...

# Presentation definition for UCL/ Service Discovery
Parties that support the use case "zorginzage-homemonitoring" can register themselves at a discovery service to become discoverable. To do this the party presents a verifiable presentation to the discovery service.
This verifiable presentation uses the following attributes:
|attribute|description|
|---------|-----------|
|URA| Unique identifier of the organization|
|medical data endpoint|absolute url of fhir endpoint for retrieving medical data|
|CarePlanService endpoint|absolute url of fhir endpoint for the CarePlanService|
- 

The following presentation definition is needed:
<to do>

# Service Discovery definition

- Development environment: TODO
- Test environment: see `config/nuts/discovery/test:SharedCarePlanning2024.json`
- Acceptance environment: TODO
- Production environment: TODO

# presentation definition for data requests
Data users that want to send data requests to a data holder in the context of the use case "zorginzage-homemonitoring" need an access token from the data holder. The access token request requires the data user to present a verifiable presentation to the data holder. This verifiable presentation uses the following attributes:
|attribute|description|
|---------|-----------|
|URA| Unique identifier of the data user organization|
|Homemonitoring membership?| Do we need an attribute that says "this org supports the use case homemonitoring"?|
|UZI| unique identifier op person that requests the data|

# Permitted means of authentication of healthcare professionals
In order to share data securely between different healthcare providers, cross-organizatonal authentication of healthcare professionals is essential. For this use case the following means of healthcare professional authentication are permitted:
- EmployeeID (support is optional): as specified in [RFC019 Employee Identity Authentication Means](https://nuts-foundation.gitbook.io/drafts/rfc/rfc019-employee-identity-means)https://nuts-foundation.gitbook.io/drafts/rfc/rfc019-employee-identity-means
- IRMA/Yivi (support is optional): as specified in [RFC002 Authentication token chapter 7.1](https://nuts-foundation.gitbook.io/drafts/rfc/rfc002-authentication-token#id-7.1.-irma)https://nuts-foundation.gitbook.io/drafts/rfc/rfc002-authentication-token#id-7.1.-irma
- UZI smartcard (support is optional): as specified in [RFC002 Authentication token chapter 7.2](https://nuts-foundation.gitbook.io/drafts/rfc/rfc002-authentication-token#id-7.2-uzi)https://nuts-foundation.gitbook.io/drafts/rfc/rfc002-authentication-token#id-7.2-uzi

# Permitted legal bases and evidence
The following legal bases are supported for the use case medical specialist referral:
- 'implicit consent'
- 'explicit prior consent': not necessary because consent for data processing can be assumed when the patient has given informed consent to the general practiioner for the referral to organization HPO and to the head practitioner at organization HPO for the execution of home monitoring services by organization MSC

The following evidence is allowed for 'implicit consent':
- registration in the source system used by the general practitioner
- registration in the source system used by the head practitioner
- verbal consent given to the head practitioner

# Naming of actors

to do.

# Data availability
- Every party that offers services for the use case homemonitoring is responsible for the availability of its own infrastructure, the system and the Nuts-node.
- Data holders ensure the availability of all components in accordance with the requirements for Availability, Integrity and Confidentiality as included in article <<TO DO>>.

# Access Policy
One aspect of a Nuts Application involves describing authorizations to certain resources. Authorizations are described in an access policy. It is the responsibility of the Data Holder System to adhere to the policy when resources are being requested. The use case homemonitoring involves three different access policies: 
|policy name|description|
|-----------|-----------|
|homemonitoring-dataholder|The homemonitoring-dataholder policy controls access to actual medical data e.g. Observation, Condition, Procedure?, EpisodeOfCare?)|
|homemonitoring-placer|The homemonitoring-filler policy controls data access necessary for sending workflow-requests related to home monitoring (e.g. sending an onboarding-request, MDT-request, medicationrequest or servicerequest) (e.g. CarePlan, CarePlan, Task, ServiceRequest)
|homemonitoring-filler|The homemonitoring-filler policy controls data access necessary for receiving workflow-requests related to home monitoring (e.g. receiving onboarding-request, MDT-request, medicationrequest or servicerequest) (e.g. CarePlan, CarePlan, Task, ServiceRequest)

## homemonitoring-dataholder Policy

The homemonitoring-dataholder policy describes rules for personal resources that containt the actual medical data. For now, we stick to the resources present in the BgZ information standard.

### Personal Resources (medical data resources)

#### Authorization record medical data resources

Pulling medical data resources requires an authorization record that is registered in the data holder system. The record must meet the following requirements:

| Field                                     | Description                                               |
|-------------------------------------------|-----------------------------------------------------------|
| `credentialSubject.id`                    | Data user URA                                             |
| `credentialSubject.purposeOfUse`          | `homemonitoring-datamonitoring`                           |
| `credentialSubject.legalBase.consentType` | `implied`                                                 |

The Dataholder System must check whether the used access token (and thus the presented URA) provides access to the requested resource. The URA of the Data User is included in the VP when requesting the access token.

The homemonitoring-dataholder policy does not provide access to resources other than those resources listed in the authorization record. 

##### Resources
The `resources` field in the Authorization Record must contain at least one element that contains a relative path to a medical data FHIR resource:

```json
{
  "path": "/[type]/[/$operation][?query]",
  "operations": [
    "search"
  ],
  "userContext": true
}
```

For all FHIR *search* operations <--- ??SEARCH OF READ?? that are part of the [MedMij FHIR Implementation Guide: BgZ](https://informatiestandaarden.nictiz.nl/wiki/MedMij:V2020.01/FHIR_BGZ_2017#PHR:_request_message), a rule must be included.
`/[path]` must be replaced by the FHIR type. `/[$operation]` must be replaced by a possibly mandatory operation, e.g., `$lastn`. `[?queries]` must be replace by possibly mandatory query parameters, e.g., `code=http://snomed.info/sct|365508006`.

The following resource types may be included in the Authorization Record:

- Patient
- Coverage
- Consent
- Condition
- Observation
- NutritionOrder
- Flag
- AllergyIntolerance
- MedicationStatement
- MedicationRequest
- MedicationDispense
- DeviceUseStatement
- Immunization
- Procedure
- Encounter
- ProcedureRequest
- ImmunizationRecommendation
- DeviceRequest
- Appointment
- DocumentReference
- Binary

Please see the [FHIR Implementation Guide BgZ](https://informatiestandaarden.nictiz.nl/wiki/MedMij:V2020.01/FHIR_BGZ_2017#PHR:_request_message) for more details.

When requesting the access token, the verifiable presentation must be included in the `vp` claim and meet the requirements of paragraph "presentation definition for data requests".

#### Normative End Date medical data Resources Authorization

When creating an Authorization Credential, an end date must be set on the record using the `expirationDate` field. The end date must be primarily based on the patient's own preferences.
The practitioner needs to ask the patient for the preferred duration of the consent. When the patient's preferences with regard to the duration of the consent are not registered, the following norms apply:

- In case of "explicit prior consent" the end date of the authorization equals the current date plus 14 days;
- In case of "implied consent" the end date of the authorization equals the current date plus 14 days.

#### Revoking the medical data Resources Authorization

When the BgZ referral is complete, it is no longer necessary for the Receiving Organization to pull resources. The Authorization Credential for the BgZ resources can then be revoked.

State machine for revoking authorization for medical data resources:

- When the Task status gets updated to `completed`, then
    - the Placer Organization (which is the same as the Data Holder Organizatino) must revoke the Authorization for the medical data resources.
- When the Filler Organization forgets to complete the process, the Placer Organization may:
    - revoke the Authorization for the medical data FHIR Resources after a reasonable period of time.

#### Access Token medical data FHIR Resources

When requesting the access token, the Authorization Credential must be included and meet the above-mentioned requirements. User details must be included in the `usi` claim.
The `service` field in the credential must equal `bgz-sender`.

Access token lifetime: 300 seconds (5 minutes).

### Authentication Contract medical data FHIR Resources

For access to the medical data FHIR-resource(s) (`"userContext": true`), user details have to be included in the `usi` claim. <--- how to describe this using Nuts v6?

### Medical data resources Access Control

The Dataholder System must only provide access to exactly those resources that are listed in the `resources` field in the Authorization Record.
When the Dataholder System processes an incoming request regarding medical data resources, access must be provided based on the resources listed in the Authorization Record (ACL).

Data access (in this particular Nuts Application) is not controlled by practitioner role.

### Search Narrowing
no search narrowing??

## homemonitoring-placer Policy

The homemonitoring-placer policy describes rules for both personal and non-personal resources. 
For non-personal resources, the `vcs` and `usi` claims may be left out from
the [JWT](https://nuts-foundation.gitbook.io/rfc/rfc003-oauth2-authorization#id-4.2.2-payload) <--- what is Nuts v6 equivalent?

### Non-Personal Resources (Tasks, ActivityDefinition, Organization, ...)

#### Authorization record for Task

Retrieving the Workflow Task falls under the category of non-personal resources. Since this is about accessing a single resource, a VP conforming to paragraph "presentation definition for data requests" is required. But the element "UZI" can be left out.

The Placer System must check whether the incoming request from the filler system is equal to:

```
GET [base]/Task/[id]
```

Where `[base]` represents the path registered under the `fhir` field in the `homemonitoring-placer` service. The Placer System must check whether the used access token provides access to the requested Task resource.
??Both the Sending Organization and Receiving Organization must be included when requesting the access token.?? --> hoe to describe this using Nuts v6 equivalent?

??The `resources` field of the Authorization Record for the Task must contain the following values:

```json
{
  "path": "/Task/[id]",
  "operations": [
    "read",
    "update"
  ],
  "userContext": false
}
```
?? ---> how to replace this with Nuts v6 stuff?

??Where `[id]` must be replaced by an actual ID. This part of the credential provides read and update access to the Task resource.

When requesting the access token, the verifiable presentation must be included in the `vp` claim and meet the above-mentioned requirements.

Part of the home monitoring workflow is that the Filler Organization updates the Task status. This requires a PUT request.

#### Normative Expiration Date Task Authorization 

When creating an Authorization Record for access to the Task, an end date must be set on the record using the `expirationDate` field. The end date must be primarily based on the patient's own preferences.
The practitioner needs to ask the patient for the preferred duration of the consent. When the patient's preferences with regard to the duration of the consent are not registered, the following norms apply:
- In case of "implied consent" the end date of the authorization equals the current date plus 14 days??
- In case of "explicit prior consent" the end date of the authorization equals the current date plus 14 days??

#### Revoking the Task Authorization

The Task resource authorization does not have to be revoked; it can simply expire since the Task contains no personal data.

#### Task Access Token

When requesting the access token for access to the Task, the VP must be included and meet the above-mentioned requirements. No user details have to be included in the `usi` claim.
??The `service` field in the credential must equal `bgz-sender`.

Access token lifetime: 300 seconds (5 minutes).

#### Task Authentication Contract

For access to the Task FHIR-resource(s) (`"userContext": false`), no user details have to be included in the `usi` claim.

#### Task Resource Field

The `resources` field in the Authorization Credential must contain at least one element that contains a relative path to a FHIR Task resource:

#### Task Access Control

The Placer System must only provide access to exactly those resources that are listed in the `resources` field in the Authorization Record.
When the Placer System processes an incoming request regarding a Task, access must be provided based on the resources listed in the Authorization Record to:

1. Task resources if any are included in the `resources` field of the Authorization Record

Data access is not controlled by practitioner role.

#### Task Search Narrowing

The Placer System must not apply search narrowing to incoming requests for Task resources.
The Filler System must perform Task requests in the form of read requests on specific Task resource instances (conform `/Task/[id]`).

### Personal Resources (CarePlan, CareTeam, )

#### CarePlan
Retrieving the CarePlan falls under the category of personal resources. A VP conforming to paragraph "presentation definition for data requests" is required. The element "UZI" must be filled.

#### CareTeam
Retrieving the CarePlan falls under the category of personal resources. A VP conforming to paragraph "presentation definition for data requests" is required. The element "UZI" must be filled.

## homemonitoring-filler Policy

The homemonitoring-filler policy describes rules for non-personal resources. 
For non-personal resources, the `vcs` and `usi` claims may be left out from
the [JWT](https://nuts-foundation.gitbook.io/rfc/rfc003-oauth2-authorization#id-4.2.2-payload) <--- what is Nuts v6 equivalent?

The homemonitoring-filler policy only describes access to the Notification Task endpoint. When requesting an access token from the authorization server, no [Nuts Authorization Credentials](https://nuts-foundation.gitbook.io/rfc/rfc014-authorization-credential) <--- what is Nuts v6 equivalent? are required. No user details are required either. The `vcs` and `usi` claims in the [JWT](https://nuts-foundation.gitbook.io/rfc/rfc003-oauth2-authorization#id-4.2.2-payload) <--- what is Nuts v6 equivalent? may be left empty. The `purposeOfUse` claim must contain `homemonitoring-filler`.

The Filler System must check whether an HTTP POST request is performed to the Notification Task endpoint. This is the relative path that is registered under the `notification` field in the `homemonitoring-filler` service.

# Sequence Diagram

Als iemand binnen thuis-organisatie C de data wil inzien van ziekenhuis B, zullen de systemen van organisatie C, organisatie B en de Care Plan/Team Service (organisatie A) moeten interacteren met elkaar. Dit wordt in het volgende sequence beschreven. Doel hiervan is om de individuele transacties per systeem en de lokalisatie van data inzichtelijk te maken. Enkele stappen als de user-authenticatie, ophalen van de autorisatieserver-url of de access-token validatie zijn weggelaten om het schema overzichtelijk te houden.

![Alt text](https://github.com/SanteonNL/shared-care-planning/blob/main/input/images/example1-retrievingdata.png?raw=true "a title")

[TODO: beschrijving per stap].

# Resources

## Resources for use case Diabetes

The following resources are relevant for the use case Diabetes.
