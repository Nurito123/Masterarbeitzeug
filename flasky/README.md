Flasky
======

- Rein lesender Zugriff zur DB
- Security vorerst egal, da nur Prototyp, designierte Rechenr im Intranet (mit Internet ->javascript Stuff)

Python pandas macht die SQL-Abfrage mit "?" Parametern, die Pandas-Funktion https://pandas.pydata.org/pandas-docs/version/0.23.4/generated/pandas.DataFrame.to_html.html schreibt mir direkt die table.

Ähnlich gibt es dazu DataFrame.to_csv

Meine Probleme:
  - ich brauche einen Daterangepicker, der die gewählten Daten in die SQL-Query schreibt
  - ich brauche für die anderen SQL-Parameter ein WebForm mit Userinput einmal int, einmal str.
  - und bei jeder Seite einen Link "download csv" der eine Funktion aufruft, die das df per csv runterlädt
  
 
Ich hab keine Lösung wie ich mit einem Link oder Button Click Funktionen aufrufe -> df/csv download starte
 
 Meine Programmstrukturierung ist sicher fragwürdig :-)
 
 Durchreichen der Usereingaben zu den SQL-Parametern
 
 Und Implementierung eines Daterangepickers 
  
  
  
(sekundär relevant: die DataFrame-to_html macht hässliche stylesheets, als Option kann der hübschere table styles mitgeben aber das funktioneirt nicht

wenn der dieser oder ähnliche Lösungen eifach zu implementieren sind wäre das auch gut aber nicht primär wichtig http://www.daterangepicker.com/

Funktion über Erscheinungsbild)
