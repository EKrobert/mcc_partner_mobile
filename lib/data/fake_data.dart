class Company {
  final String id;
  final String name;
  final String country;
  final String flag;
  final String sector;
  final String contact;
  final String email;
  final String description;
  final bool isChinese;
  final String? standNumber;

  const Company({
    required this.id,
    required this.name,
    required this.country,
    required this.flag,
    required this.sector,
    required this.contact,
    required this.email,
    required this.description,
    required this.isChinese,
    this.standNumber,
  });
}

class Message {
  final String sender;
  final String text;
  final String time;
  final bool isMe;

  const Message({
    required this.sender,
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class Appointment {
  final String company;
  final String contact;
  final String time;
  final String stand;
  final String flag;
  final bool confirmed;

  const Appointment({
    required this.company,
    required this.contact,
    required this.time,
    required this.stand,
    required this.flag,
    required this.confirmed,
  });
}

class FakeData {
  static const List<Company> companies = [
    Company(
      id: '001',
      name: 'Shenzhen Tech Solutions',
      country: 'Chine',
      flag: '🇨🇳',
      sector: 'Technologie',
      contact: 'Wang Lei',
      email: 'wang@sztech.cn',
      description: 'Solutions IoT et automatisation industrielle pour marchés émergents.',
      isChinese: true,
      standNumber: 'A-12',
    ),
    Company(
      id: '002',
      name: 'Guangzhou Trade Co.',
      country: 'Chine',
      flag: '🇨🇳',
      sector: 'Commerce & Distribution',
      contact: 'Li Mei',
      email: 'li.mei@gztrade.cn',
      description: 'Import-export de produits manufacturés vers l\'Afrique.',
      isChinese: true,
      standNumber: 'B-05',
    ),
    Company(
      id: '003',
      name: 'BYD Maghreb',
      country: 'Chine',
      flag: '🇨🇳',
      sector: 'Énergie & Mobilité',
      contact: 'Zhang Wei',
      email: 'zhang@byd-maghreb.cn',
      description: 'Véhicules électriques et solutions énergétiques pour l\'Afrique du Nord.',
      isChinese: true,
      standNumber: 'C-01',
    ),
    Company(
      id: '004',
      name: 'Hunan Green Agriculture',
      country: 'Chine',
      flag: '🇨🇳',
      sector: 'Agroalimentaire',
      contact: 'Chen Fang',
      email: 'chen@hunangreen.cn',
      description: 'Acheteur de produits agricoles premium marocains pour le marché chinois.',
      isChinese: true,
      standNumber: 'A-07',
    ),
    Company(
      id: '005',
      name: 'AfrikHub Maroc',
      country: 'Maroc',
      flag: '🇲🇦',
      sector: 'Logistique & Commerce',
      contact: 'Youssef Benali',
      email: 'youssef@afrikhub.ma',
      description: 'Plateforme de sourcing et distribution de produits marocains premium.',
      isChinese: false,
    ),
    Company(
      id: '006',
      name: 'Myrass Cosmétiques',
      country: 'Maroc',
      flag: '🇲🇦',
      sector: 'Cosmétique & Argan',
      contact: 'Fatima Ouali',
      email: 'f.ouali@myrass.ma',
      description: 'Huile d\'argan et cosmétiques naturels premium — certifiés export Chine.',
      isChinese: false,
    ),
    Company(
      id: '007',
      name: 'Oriental Olive Export',
      country: 'Maroc',
      flag: '🇲🇦',
      sector: 'Agroalimentaire',
      contact: 'Hassan Khattabi',
      email: 'h.khattabi@olivexport.ma',
      description: 'Huile d\'olive AOC de la région de l\'Oriental — export Asie.',
      isChinese: false,
    ),
    Company(
      id: '008',
      name: 'NWM Logistics',
      country: 'Maroc',
      flag: '🇲🇦',
      sector: 'Logistique & Transport',
      contact: 'Rachid Tazi',
      email: 'r.tazi@nwm-logistics.ma',
      description: 'Opérateur logistique basé à Nador West Med — transit international.',
      isChinese: false,
    ),
  ];

  static const List<Message> chatMessages = [
    Message(sender: 'Wang Lei', text: 'Bonjour ! Nous sommes intéressés par vos produits d\'argan.', time: '09:14', isMe: false),
    Message(sender: 'Moi', text: 'Bonjour Wang Lei ! Avec plaisir, je vous envoie notre catalogue.', time: '09:22', isMe: true),
    Message(sender: 'Wang Lei', text: 'Parfait. Pouvez-vous préciser vos capacités d\'export mensuel ?', time: '09:35', isMe: false),
    Message(sender: 'Moi', text: 'Nous pouvons fournir jusqu\'à 5 tonnes/mois en certifié bio.', time: '09:48', isMe: true),
    Message(sender: 'Wang Lei', text: 'Excellent ! Proposons un RDV au stand A-12 demain à 14h ?', time: '10:02', isMe: false),
    Message(sender: 'Moi', text: 'Confirmé, à demain au stand A-12 à 14h00 !', time: '10:05', isMe: true),
  ];

  static const List<Appointment> appointments = [
    Appointment(
      company: 'Shenzhen Tech Solutions',
      contact: 'Wang Lei',
      time: 'Demain 14:00',
      stand: 'Stand A-12',
      flag: '🇨🇳',
      confirmed: true,
    ),
    Appointment(
      company: 'Guangzhou Trade Co.',
      contact: 'Li Mei',
      time: 'Demain 16:30',
      stand: 'Stand B-05',
      flag: '🇨🇳',
      confirmed: true,
    ),
    Appointment(
      company: 'Hunan Green Agriculture',
      contact: 'Chen Fang',
      time: 'J+2 10:00',
      stand: 'Stand A-07',
      flag: '🇨🇳',
      confirmed: false,
    ),
  ];

  static const List<Map<String, String>> webinaireSpeakers = [
    {'name': 'M. Lu', 'role': 'Partenaire Fondateur MCC — Chine', 'flag': '🇨🇳'},
    {'name': 'Mme Dai', 'role': 'Directrice Partenariats Sino-Africains', 'flag': '🇨🇳'},
    {'name': 'Youssef Benali', 'role': 'Co-Fondateur MCC Partners — Maroc', 'flag': '🇲🇦'},
    {'name': 'Hassan Khattabi', 'role': 'Expert Commerce International', 'flag': '🇲🇦'},
  ];
}
