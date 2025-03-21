import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Suraksha',
      'locationService': 'Location Service',
      'active': 'Active',
      'initializing': 'Initializing location service...',
      'locationDisabled': 'Location services are disabled. Please enable GPS.',
      'permissionDenied': 'Location permissions are denied',
      'permissionPermanentlyDenied': 'Location permissions are permanently denied. Please enable in settings.',
      'gettingLocation': 'Getting your location...',
      'currentLocation': 'Current Location',
      'latitude': 'Latitude',
      'longitude': 'Longitude',
      'nearestLocation': 'Nearest location',
      'kmAway': 'km away',
      'noLocations': 'No nearby locations found',
      'invalidData': 'Invalid location data received',
      'serverError': 'Server error',
      'connectionTimeout': 'Server connection timed out. Please try again later.',
      'retrying': 'Retrying server connection',
      'errorProcessing': 'Error processing server data',
      'emergencyContacts': 'Emergency Contacts',
      'addContact': 'Add Contact',
      'settings': 'Settings',
      'notifications': 'Notifications',
      'language': 'Language',
      'about': 'About',
      'help': 'Help',
      'logout': 'Logout',
      'profile': 'Profile',
      'editProfile': 'Edit Profile',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'confirm': 'Confirm',
      'error': 'Error',
      'success': 'Success',
      'warning': 'Warning',
      'info': 'Information',
    },
    'hi': {
      'appTitle': 'सुरक्षा',
      'locationService': 'स्थान सेवा',
      'active': 'सक्रिय',
      'initializing': 'स्थान सेवा प्रारंभ हो रही है...',
      'locationDisabled': 'स्थान सेवाएं अक्षम हैं। कृपया GPS सक्षम करें।',
      'permissionDenied': 'स्थान अनुमतियां अस्वीकृत हैं',
      'permissionPermanentlyDenied': 'स्थान अनुमतियां स्थायी रूप से अस्वीकृत हैं। कृपया सेटिंग्स में सक्षम करें।',
      'gettingLocation': 'आपका स्थान प्राप्त किया जा रहा है...',
      'currentLocation': 'वर्तमान स्थान',
      'latitude': 'अक्षांश',
      'longitude': 'देशांतर',
      'nearestLocation': 'निकटतम स्थान',
      'kmAway': 'किमी दूर',
      'noLocations': 'कोई निकटवर्ती स्थान नहीं मिला',
      'invalidData': 'अमान्य स्थान डेटा प्राप्त हुआ',
      'serverError': 'सर्वर त्रुटि',
      'connectionTimeout': 'सर्वर कनेक्शन टाइमआउट। कृपया बाद में पुनः प्रयास करें।',
      'retrying': 'सर्वर कनेक्शन पुनः प्रयास कर रहा है',
      'errorProcessing': 'सर्वर डेटा प्रोसेसिंग में त्रुटि',
      'emergencyContacts': 'आपातकालीन संपर्क',
      'addContact': 'संपर्क जोड़ें',
      'settings': 'सेटिंग्स',
      'notifications': 'सूचनाएं',
      'language': 'भाषा',
      'about': 'हमारे बारे में',
      'help': 'सहायता',
      'logout': 'लॉग आउट',
      'profile': 'प्रोफ़ाइल',
      'editProfile': 'प्रोफ़ाइल संपादित करें',
      'save': 'सहेजें',
      'cancel': 'रद्द करें',
      'delete': 'हटाएं',
      'confirm': 'पुष्टि करें',
      'error': 'त्रुटि',
      'success': 'सफलता',
      'warning': 'चेतावनी',
      'info': 'जानकारी',
    },
    'ta': {
      'appTitle': 'சுரக்ஷா',
      'locationService': 'இருப்பிட சேவை',
      'active': 'செயலில்',
      'initializing': 'இருப்பிட சேவை துவங்குகிறது...',
      'locationDisabled': 'இருப்பிட சேவைகள் முடக்கப்பட்டுள்ளன. GPS ஐ இயக்கவும்.',
      'permissionDenied': 'இருப்பிட அனுமதிகள் மறுக்கப்பட்டன',
      'permissionPermanentlyDenied': 'இருப்பிட அனுமதிகள் நிரந்தரமாக மறுக்கப்பட்டுள்ளன. அமைப்புகளில் இயக்கவும்.',
      'gettingLocation': 'உங்கள் இருப்பிடத்தைப் பெறுகிறது...',
      'currentLocation': 'தற்போதைய இருப்பிடம்',
      'latitude': 'அட்சரேகை',
      'longitude': 'தீர்க்கரேகை',
      'nearestLocation': 'அருகிலுள்ள இடம்',
      'kmAway': 'கி.மீ தொலைவில்',
      'noLocations': 'அருகில் இடங்கள் எதுவும் இல்லை',
      'invalidData': 'தவறான இருப்பிட தரவு பெறப்பட்டது',
      'serverError': 'சேவையக பிழை',
      'connectionTimeout': 'சேவையக இணைப்பு நேரம் முடிந்தது. பிறகு முயற்சிக்கவும்.',
      'retrying': 'சேவையக இணைப்பை மீண்டும் முயற்சிக்கிறது',
      'errorProcessing': 'சேவையக தரவு செயலாக்கத்தில் பிழை',
      'emergencyContacts': 'அவசர தொடர்புகள்',
      'addContact': 'தொடர்பு சேர்க்க',
      'settings': 'அமைப்புகள்',
      'notifications': 'அறிவிப்புகள்',
      'language': 'மொழி',
      'about': 'பற்றி',
      'help': 'உதவி',
      'logout': 'வெளியேறு',
      'profile': 'சுயவிவரம்',
      'editProfile': 'சுயவிவரத்தை திருத்து',
      'save': 'சேமி',
      'cancel': 'ரத்து செய்',
      'delete': 'நீக்கு',
      'confirm': 'உறுதிப்படுத்து',
      'error': 'பிழை',
      'success': 'வெற்றி',
      'warning': 'எச்சரிக்கை',
      'info': 'தகவல்',
    },
    'te': {
      'appTitle': 'సురక్ష',
      'locationService': 'స్థాన సేవ',
      'active': 'చురుకుగా ఉంది',
      'initializing': 'స్థాన సేవ ప్రారంభమవుతోంది...',
      'locationDisabled': 'స్థాన సేవలు నిలిపివేయబడ్డాయి. దయచేసి GPS ని ప్రారంభించండి.',
      'permissionDenied': 'స్థాన అనుమతులు నిరాకరించబడ్డాయి',
      'permissionPermanentlyDenied': 'స్థాన అనుమతులు శాశ్వతంగా నిరాకరించబడ్డాయి. దయచేసి సెట్టింగ్స్‌లో ప్రారంభించండి.',
      'gettingLocation': 'మీ స్థానాన్ని పొందుతోంది...',
      'currentLocation': 'ప్రస్తుత స్థానం',
      'latitude': 'అక్షాంశం',
      'longitude': 'రేఖాంశం',
      'nearestLocation': 'సమీప స్థానం',
      'kmAway': 'కి.మీ దూరం',
      'noLocations': 'సమీపంలో స్థానాలు కనుగొనబడలేదు',
      'invalidData': 'చెల్లని స్థాన డేటా స్వీకరించబడింది',
      'serverError': 'సర్వర్ లోపం',
      'connectionTimeout': 'సర్వర్ కనెక్షన్ సమయం ముగిసింది. దయచేసి తర్వాత మళ్లీ ప్రయత్నించండి.',
      'retrying': 'సర్వర్ కనెక్షన్ మళ్లీ ప్రయత్నిస్తోంది',
      'errorProcessing': 'సర్వర్ డేటా ప్రాసెసింగ్‌లో లోపం',
      'emergencyContacts': 'అత్యవసర సంప్రదింపులు',
      'addContact': 'సంప్రదింపును జోడించు',
      'settings': 'సెట్టింగ్స్',
      'notifications': 'నోటిఫికేషన్లు',
      'language': 'భాష',
      'about': 'గురించి',
      'help': 'సహాయం',
      'logout': 'లాగ్అవుట్',
      'profile': 'ప్రొఫైల్',
      'editProfile': 'ప్రొఫైల్ సవరించు',
      'save': 'సేవ్ చేయి',
      'cancel': 'రద్దు చేయి',
      'delete': 'తొలగించు',
      'confirm': 'నిర్ధారించు',
      'error': 'లోపం',
      'success': 'విజయం',
      'warning': 'హెచ్చరిక',
      'info': 'సమాచారం',
    },
    'ml': {
      'appTitle': 'സുരക്ഷ',
      'locationService': 'ലൊക്കേഷൻ സേവനം',
      'active': 'സജീവം',
      'initializing': 'ലൊക്കേഷൻ സേവനം ആരംഭിക്കുന്നു...',
      'locationDisabled': 'ലൊക്കേഷൻ സേവനങ്ങൾ പ്രവർത്തനരഹിതമാണ്. ദയവായി GPS പ്രവർത്തനക്ഷമമാക്കുക.',
      'permissionDenied': 'ലൊക്കേഷൻ അനുമതികൾ നിരസിച്ചു',
      'permissionPermanentlyDenied': 'ലൊക്കേഷൻ അനുമതികൾ സ്ഥിരമായി നിരസിച്ചു. ദയവായി ക്രമീകരണങ്ങളിൽ പ്രവർത്തനക്ഷമമാക്കുക.',
      'gettingLocation': 'നിങ്ങളുടെ ലൊക്കേഷൻ ലഭ്യമാക്കുന്നു...',
      'currentLocation': 'നിലവിലെ ലൊക്കേഷൻ',
      'latitude': 'അക്ഷാംശം',
      'longitude': 'രേഖാംശം',
      'nearestLocation': 'ഏറ്റവും അടുത്ത സ്ഥലം',
      'kmAway': 'കി.മീ ദൂരെ',
      'noLocations': 'സമീപത്ത് സ്ഥലങ്ങളൊന്നും കണ്ടെത്തിയില്ല',
      'invalidData': 'അസാധുവായ ലൊക്കേഷൻ ഡാറ്റ ലഭിച്ചു',
      'serverError': 'സെർവർ പിശക്',
      'connectionTimeout': 'സെർവർ കണക്ഷൻ ടൈംഔട്ട്. ദയവായി പിന്നീട് വീണ്ടും ശ്രമിക്കുക.',
      'retrying': 'സെർവർ കണക്ഷൻ വീണ്ടും ശ്രമിക്കുന്നു',
      'errorProcessing': 'സെർവർ ഡാറ്റ പ്രോസസ്സിംഗിൽ പിശക്',
      'emergencyContacts': 'അടിയന്തിര കോൺടാക്റ്റുകൾ',
      'addContact': 'കോൺടാക്റ്റ് ചേർക്കുക',
      'settings': 'ക്രമീകരണങ്ങൾ',
      'notifications': 'അറിയിപ്പുകൾ',
      'language': 'ഭാഷ',
      'about': 'കുറിച്ച്',
      'help': 'സഹായം',
      'logout': 'ലോഗ്ഔട്ട്',
      'profile': 'പ്രൊഫൈൽ',
      'editProfile': 'പ്രൊഫൈൽ എഡിറ്റ് ചെയ്യുക',
      'save': 'സേവ് ചെയ്യുക',
      'cancel': 'റദ്ദാക്കുക',
      'delete': 'ഇല്ലാതാക്കുക',
      'confirm': 'സ്ഥിരീകരിക്കുക',
      'error': 'പിശക്',
      'success': 'വിജയം',
      'warning': 'മുന്നറിയിപ്പ്',
      'info': 'വിവരം',
    },
    'bn': {
      'appTitle': 'সুরক্ষা',
      'locationService': 'লোকেশন সার্ভিস',
      'active': 'সক্রিয়',
      'initializing': 'লোকেশন সার্ভিস শুরু হচ্ছে...',
      'locationDisabled': 'লোকেশন সার্ভিস নিষ্ক্রিয় আছে। অনুগ্রহ করে GPS চালু করুন।',
      'permissionDenied': 'লোকেশন অনুমতি প্রত্যাখ্যান করা হয়েছে',
      'permissionPermanentlyDenied': 'লোকেশন অনুমতি স্থায়ীভাবে প্রত্যাখ্যান করা হয়েছে। অনুগ্রহ করে সেটিংসে চালু করুন।',
      'gettingLocation': 'আপনার লোকেশন পাওয়া যাচ্ছে...',
      'currentLocation': 'বর্তমান লোকেশন',
      'latitude': 'অক্ষাংশ',
      'longitude': 'দ্রাঘিমাংশ',
      'nearestLocation': 'নিকটতম স্থান',
      'kmAway': 'কি.মি. দূরে',
      'noLocations': 'কাছাকাছি কোন স্থান পাওয়া যায়নি',
      'invalidData': 'অবৈধ লোকেশন ডেটা পাওয়া গেছে',
      'serverError': 'সার্ভার ত্রুটি',
      'connectionTimeout': 'সার্ভার কানেকশন টাইমআউট। অনুগ্রহ করে পরে আবার চেষ্টা করুন।',
      'retrying': 'সার্ভার কানেকশন পুনরায় চেষ্টা করা হচ্ছে',
      'errorProcessing': 'সার্ভার ডেটা প্রসেসিংয়ে ত্রুটি',
      'emergencyContacts': 'জরুরি যোগাযোগ',
      'addContact': 'যোগাযোগ যোগ করুন',
      'settings': 'সেটিংস',
      'notifications': 'নোটিফিকেশন',
      'language': 'ভাষা',
      'about': 'সম্পর্কে',
      'help': 'সাহায্য',
      'logout': 'লগআউট',
      'profile': 'প্রোফাইল',
      'editProfile': 'প্রোফাইল সম্পাদনা',
      'save': 'সংরক্ষণ',
      'cancel': 'বাতিল',
      'delete': 'মুছুন',
      'confirm': 'নিশ্চিত করুন',
      'error': 'ত্রুটি',
      'success': 'সফল',
      'warning': 'সতর্কতা',
      'info': 'তথ্য',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]?['appTitle'] ?? 'Suraksha';
  String get locationService => _localizedValues[locale.languageCode]?['locationService'] ?? 'Location Service';
  String get active => _localizedValues[locale.languageCode]?['active'] ?? 'Active';
  String get initializing => _localizedValues[locale.languageCode]?['initializing'] ?? 'Initializing location service...';
  String get locationDisabled => _localizedValues[locale.languageCode]?['locationDisabled'] ?? 'Location services are disabled. Please enable GPS.';
  String get permissionDenied => _localizedValues[locale.languageCode]?['permissionDenied'] ?? 'Location permissions are denied';
  String get permissionPermanentlyDenied => _localizedValues[locale.languageCode]?['permissionPermanentlyDenied'] ?? 'Location permissions are permanently denied. Please enable in settings.';
  String get gettingLocation => _localizedValues[locale.languageCode]?['gettingLocation'] ?? 'Getting your location...';
  String get currentLocation => _localizedValues[locale.languageCode]?['currentLocation'] ?? 'Current Location';
  String get latitude => _localizedValues[locale.languageCode]?['latitude'] ?? 'Latitude';
  String get longitude => _localizedValues[locale.languageCode]?['longitude'] ?? 'Longitude';
  String get nearestLocation => _localizedValues[locale.languageCode]?['nearestLocation'] ?? 'Nearest location';
  String get kmAway => _localizedValues[locale.languageCode]?['kmAway'] ?? 'km away';
  String get noLocations => _localizedValues[locale.languageCode]?['noLocations'] ?? 'No nearby locations found';
  String get invalidData => _localizedValues[locale.languageCode]?['invalidData'] ?? 'Invalid location data received';
  String get serverError => _localizedValues[locale.languageCode]?['serverError'] ?? 'Server error';
  String get connectionTimeout => _localizedValues[locale.languageCode]?['connectionTimeout'] ?? 'Server connection timed out. Please try again later.';
  String get retrying => _localizedValues[locale.languageCode]?['retrying'] ?? 'Retrying server connection';
  String get errorProcessing => _localizedValues[locale.languageCode]?['errorProcessing'] ?? 'Error processing server data';
  String get emergencyContacts => _localizedValues[locale.languageCode]?['emergencyContacts'] ?? 'Emergency Contacts';
  String get addContact => _localizedValues[locale.languageCode]?['addContact'] ?? 'Add Contact';
  String get settings => _localizedValues[locale.languageCode]?['settings'] ?? 'Settings';
  String get notifications => _localizedValues[locale.languageCode]?['notifications'] ?? 'Notifications';
  String get language => _localizedValues[locale.languageCode]?['language'] ?? 'Language';
  String get about => _localizedValues[locale.languageCode]?['about'] ?? 'About';
  String get help => _localizedValues[locale.languageCode]?['help'] ?? 'Help';
  String get logout => _localizedValues[locale.languageCode]?['logout'] ?? 'Logout';
  String get profile => _localizedValues[locale.languageCode]?['profile'] ?? 'Profile';
  String get editProfile => _localizedValues[locale.languageCode]?['editProfile'] ?? 'Edit Profile';
  String get save => _localizedValues[locale.languageCode]?['save'] ?? 'Save';
  String get cancel => _localizedValues[locale.languageCode]?['cancel'] ?? 'Cancel';
  String get delete => _localizedValues[locale.languageCode]?['delete'] ?? 'Delete';
  String get confirm => _localizedValues[locale.languageCode]?['confirm'] ?? 'Confirm';
  String get error => _localizedValues[locale.languageCode]?['error'] ?? 'Error';
  String get success => _localizedValues[locale.languageCode]?['success'] ?? 'Success';
  String get warning => _localizedValues[locale.languageCode]?['warning'] ?? 'Warning';
  String get info => _localizedValues[locale.languageCode]?['info'] ?? 'Information';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'ta', 'te', 'ml', 'bn'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
