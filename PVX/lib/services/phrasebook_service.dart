
import '../models/phrase_item.dart';

class PhrasebookService {
  static const themes = ['Restaurant','Bus','Magasin','Musée','Hôtel','Urgence','Voyage'];
  static const languages = ['Anglais','Espagnol','Italien','Allemand'];

  static const List<PhraseItem> phrases = [
    PhraseItem(theme:'Restaurant', fr:'Bonjour, je voudrais une table pour deux.', translations:{'Anglais':'Hello, I would like a table for two.','Espagnol':'Hola, quisiera una mesa para dos.','Italien':'Buongiorno, vorrei un tavolo per due.','Allemand':'Hallo, ich hätte gern einen Tisch für zwei.'}),
    PhraseItem(theme:'Restaurant', fr:'Je voudrais commander un café, s’il vous plaît.', translations:{'Anglais':'I would like to order a coffee, please.','Espagnol':'Quisiera pedir un café, por favor.','Italien':'Vorrei ordinare un caffè, per favore.','Allemand':'Ich möchte bitte einen Kaffee bestellen.'}),
    PhraseItem(theme:'Restaurant', fr:'L’addition, s’il vous plaît.', translations:{'Anglais':'The bill, please.','Espagnol':'La cuenta, por favor.','Italien':'Il conto, per favore.','Allemand':'Die Rechnung, bitte.'}),
    PhraseItem(theme:'Bus', fr:'Ce bus va-t-il au centre-ville ?', translations:{'Anglais':'Does this bus go to the city centre?','Espagnol':'¿Este autobús va al centro?','Italien':'Questo autobus va in centro?','Allemand':'Fährt dieser Bus ins Stadtzentrum?'}),
    PhraseItem(theme:'Bus', fr:'Où puis-je acheter un ticket ?', translations:{'Anglais':'Where can I buy a ticket?','Espagnol':'¿Dónde puedo comprar un billete?','Italien':'Dove posso comprare un biglietto?','Allemand':'Wo kann ich ein Ticket kaufen?'}),
    PhraseItem(theme:'Bus', fr:'À quel arrêt dois-je descendre ?', translations:{'Anglais':'At which stop should I get off?','Espagnol':'¿En qué parada debo bajarme?','Italien':'A quale fermata devo scendere?','Allemand':'An welcher Haltestelle soll ich aussteigen?'}),
    PhraseItem(theme:'Magasin', fr:'Combien cela coûte-t-il ?', translations:{'Anglais':'How much does this cost?','Espagnol':'¿Cuánto cuesta esto?','Italien':'Quanto costa questo?','Allemand':'Wie viel kostet das?'}),
    PhraseItem(theme:'Magasin', fr:'Avez-vous une autre taille ?', translations:{'Anglais':'Do you have another size?','Espagnol':'¿Tiene otra talla?','Italien':'Avete un’altra taglia?','Allemand':'Haben Sie eine andere Größe?'}),
    PhraseItem(theme:'Magasin', fr:'Puis-je payer par carte ?', translations:{'Anglais':'Can I pay by card?','Espagnol':'¿Puedo pagar con tarjeta?','Italien':'Posso pagare con carta?','Allemand':'Kann ich mit Karte bezahlen?'}),
    PhraseItem(theme:'Musée', fr:'Où puis-je acheter un billet ?', translations:{'Anglais':'Where can I buy a ticket?','Espagnol':'¿Dónde puedo comprar una entrada?','Italien':'Dove posso comprare un biglietto?','Allemand':'Wo kann ich eine Eintrittskarte kaufen?'}),
    PhraseItem(theme:'Musée', fr:'Y a-t-il une visite guidée ?', translations:{'Anglais':'Is there a guided tour?','Espagnol':'¿Hay una visita guiada?','Italien':'C’è una visita guidata?','Allemand':'Gibt es eine Führung?'}),
    PhraseItem(theme:'Hôtel', fr:'Bonjour, j’ai une réservation.', translations:{'Anglais':'Hello, I have a reservation.','Espagnol':'Hola, tengo una reserva.','Italien':'Buongiorno, ho una prenotazione.','Allemand':'Hallo, ich habe eine Reservierung.'}),
    PhraseItem(theme:'Hôtel', fr:'À quelle heure est le petit-déjeuner ?', translations:{'Anglais':'What time is breakfast?','Espagnol':'¿A qué hora es el desayuno?','Italien':'A che ora è la colazione?','Allemand':'Um wie viel Uhr ist das Frühstück?'}),
    PhraseItem(theme:'Urgence', fr:'J’ai besoin d’aide, s’il vous plaît.', translations:{'Anglais':'I need help, please.','Espagnol':'Necesito ayuda, por favor.','Italien':'Ho bisogno di aiuto, per favore.','Allemand':'Ich brauche bitte Hilfe.'}),
    PhraseItem(theme:'Urgence', fr:'Appelez les secours, s’il vous plaît.', translations:{'Anglais':'Please call emergency services.','Espagnol':'Llame a emergencias, por favor.','Italien':'Chiami i soccorsi, per favore.','Allemand':'Bitte rufen Sie den Notdienst.'}),
    PhraseItem(theme:'Voyage', fr:'Où est la gare ?', translations:{'Anglais':'Where is the train station?','Espagnol':'¿Dónde está la estación de tren?','Italien':'Dov’è la stazione ferroviaria?','Allemand':'Wo ist der Bahnhof?'}),
    PhraseItem(theme:'Voyage', fr:'Je voudrais acheter un billet.', translations:{'Anglais':'I would like to buy a ticket.','Espagnol':'Quisiera comprar un billete.','Italien':'Vorrei comprare un biglietto.','Allemand':'Ich möchte ein Ticket kaufen.'}),
  ];

  List<PhraseItem> byTheme(String theme) => phrases.where((p) => p.theme == theme).toList();
}
