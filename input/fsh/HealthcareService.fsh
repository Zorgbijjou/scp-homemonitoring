Instance: zbj-healthcareservice-telemonitoring
InstanceOf: HealthcareService
Usage: #example
Title: "Zorg bij jou - HealthcareService - Telemonitoring"
Description: "Defines which services are provided by the HealthcareService for telemonitoring"
* identifier.system = "urn:oid:2.16.840.1.113883.2.4.3.224"
* identifier.value = "urn:uuid:91a9be09-eb97-4c0f-9a61-27a1985ae38b"
* active = true
* providedBy.identifier.system = $ura
* providedBy.identifier.value = "86446"
* category[+] = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* type[+] = $sct#715191006 "monitoren van asthma via telegeneeskunde (regime/therapie)"
* type[+] = $sct#879780004 "monitoren van chronisch hartfalen via telegeneeskunde (regime/therapie)" 
* type[+] = $sct#716358000 "monitoren van chronische obstructieve longziekte via telegeneeskunde (regime/therapie)" 
* type[+] = $sct#84114007 "hartfalen (aandoening)"
* type[+] = $sct#195979001 "Asthma unspecified (disorder)"
* type[+] = $sct#195967001 "astma (aandoening)"
* type[+] = $sct#304527002 "acuut astma (aandoening)"
* type[+] = $sct#389145006 "allergisch astma (aandoening)"
* type[+] = $sct#13645005 "chronische obstructieve longaandoening (aandoening)"
// 13645005 (COPD)
//    84114007 (Hartfalen)
//    195979001, 304527002, 389145006 (Astma)
//    840539006 (COVID)
//    11687002 (Zwangerschapsdiabetes)
//    46635009, 1290118005 (Diabetes type 1)
//    230690007 (Post-CVA)
//    (Post-darm)
//    49436004 (Atriumfibrilleren)
//    16114001 (Enkelfractuur)
//    125605004 (VFC)
//    (Geboortezorg)
//    (Perioperatief)
//    (Sys. therapie)
//    431855005 (Chr. nierschade)
//    38341003 (Hypertensie)
//    239873007, 239872002 (Knie/heup-atrose)
//    64766004 (IBD)
//    254637007 (Longkanker)


Instance: zbj-bundle-healthcareservices
InstanceOf: Bundle
Usage: #example
Title: "Zorg bij jou - Bundle - HealthcareServices"
Description: "Bundle containing HealthcareService instances"
* type = #batch
* insert BundleEntry(zbj-healthcareservice-telemonitoring, #PUT, HealthcareService?identifier=urn:uuid:91a9be09-eb97-4c0f-9a61-27a1985ae38b)
