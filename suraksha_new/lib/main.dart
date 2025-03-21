import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'translations.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

// Server URL for API requests
const String serverUrl = 'https://nytdevansh.pythonanywhere.com';

Future<void> initializeLocationTracking() async {
  if (Platform.isAndroid) {
    final hasPermissions = await requestPermissions();
    if (!hasPermissions) {
      debugPrint('Required permissions not granted');
      return;
    }

    try {
      await startLocationUpdates();
      debugPrint('Location tracking initialized');
    } catch (e) {
      debugPrint('Error initializing location tracking: $e');
    }
  }
}

Future<void> _sendLocationData(Map<String, dynamic> data) async {
  try {
    final response = await http
        .post(
          Uri.parse('$serverUrl/update_location'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(data),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      debugPrint('Location data sent successfully');
    } else if (response.statusCode == 404) {
      debugPrint('Server endpoint not found: ${response.body}');
    } else {
      debugPrint('Server error: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    if (e is SocketException) {
      debugPrint('Network connection error. Check internet connection.');
    } else if (e is TimeoutException) {
      debugPrint('Server request timed out. Try again later.');
    } else {
      debugPrint('Network error: $e');
    }
  }
}

StreamSubscription<geo.Position>? _locationSubscription;

Future<void> startLocationUpdates() async {
  try {
    // Cancel existing subscription if any
    await stopLocationUpdates();

    bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled');
      throw StateError('Location services are disabled');
    }

    geo.LocationPermission permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied ||
        permission == geo.LocationPermission.deniedForever) {
      debugPrint('Location permission is denied');
      throw StateError('Location permission is denied');
    }

    debugPrint('Starting location updates with background mode...');

    // Get initial position
    geo.Position position = await geo.Geolocator.getCurrentPosition(
      desiredAccuracy: geo.LocationAccuracy.high,
    );

    // Send initial position
    await _sendLocationData({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': DateTime.now().toIso8601String(),
    });

    // Start listening to location updates with background mode enabled
    _locationSubscription = geo.Geolocator.getPositionStream(
      locationSettings: geo.AndroidSettings(
        accuracy: geo.LocationAccuracy.high,
        distanceFilter: 10,
        foregroundNotificationConfig: const geo.ForegroundNotificationConfig(
          notificationText:
              "Suraksha is tracking your location in the background",
          notificationTitle: "Location Tracking",
          enableWakeLock: true,
          notificationIcon: const geo.AndroidResource(
              name: 'notification_icon', defType: 'drawable'),
        ),
      ),
    ).listen(
      (geo.Position position) async {
        try {
          await _sendLocationData({
            'latitude': position.latitude,
            'longitude': position.longitude,
            'timestamp': DateTime.now().toIso8601String(),
          });
          debugPrint(
              'Location updated: ${position.latitude}, ${position.longitude}');
        } catch (e) {
          debugPrint('Error sending location: $e');
        }
      },
      onError: (error) {
        debugPrint('Location stream error: $error');
      },
    );

    debugPrint('Location updates started successfully');
  } catch (e) {
    debugPrint('Error starting location updates: $e');
    rethrow;
  }
}

Future<void> stopLocationUpdates() async {
  try {
    if (_locationSubscription != null) {
      await _locationSubscription!.cancel();
      _locationSubscription = null;
      debugPrint('Location subscription cancelled');
    } else {
      debugPrint('No active location subscription to cancel');
    }
  } catch (e) {
    debugPrint('Error stopping location updates: $e');
    rethrow;
  }
}

Future<bool> requestPermissions() async {
  if (Platform.isAndroid) {
    // Request notification permission for Android 13+
    final notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      final status = await Permission.notification.request();
      if (status.isDenied) {
        debugPrint('Notification permission denied');
        return false;
      }
    }

    // Request location permissions
    final locationStatus = await Permission.location.status;
    if (locationStatus.isDenied) {
      final status = await Permission.location.request();
      if (status.isDenied) {
        debugPrint('Location permission denied');
        return false;
      }
    }

    // Request background location after location permission is granted
    final backgroundStatus = await Permission.locationAlways.status;
    if (backgroundStatus.isDenied) {
      final status = await Permission.locationAlways.request();
      if (status.isDenied) {
        debugPrint('Background location permission denied');
        return false;
      }
    }

    // Double check all required permissions
    final hasNotification = await Permission.notification.isGranted;
    final hasLocation = await Permission.location.isGranted;
    final hasBackground = await Permission.locationAlways.isGranted;

    debugPrint(
        'Permissions status - Notification: $hasNotification, Location: $hasLocation, Background: $hasBackground');

    return hasNotification && hasLocation && hasBackground;
  }
  return true;
}

// Language options for the app
enum AppLanguage {
  english('en', 'English'),
  hindi('hi', 'हिंदी'),
  tamil('ta', 'தமிழ்'),
  telugu('te', 'తెలుగు'),
  malayalam('ml', 'മലയാളം'),
  bengali('bn', 'বাংলা');

  final String code;
  final String displayName;
  const AppLanguage(this.code, this.displayName);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suraksha',
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('ta'),
        Locale('te'),
        Locale('ml'),
        Locale('bn'),
      ],
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: TomTomMap(onLocaleChange: _setLocale),
    );
  }
}

class TomTomMap extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const TomTomMap({super.key, required this.onLocaleChange});

  @override
  State<TomTomMap> createState() => _TomTomMapState();
}

class _TomTomMapState extends State<TomTomMap> with WidgetsBindingObserver {
  late WebViewController controller;
  String? locationMessage;
  geo.Position? currentPosition;
  bool isLoading = true;
  bool isLocationServiceRunning = false;
  AppLanguage _currentLanguage =
      AppLanguage.english; // Changed to private for state management

  // Method to change language
  void _changeLanguage(AppLanguage newLanguage) {
    setState(() {
      _currentLanguage = newLanguage;
    });
    widget.onLocaleChange(Locale(newLanguage.code));
  }

  StreamSubscription<geo.ServiceStatus>? _serviceStatusSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeMap(); // Map initialization will start location service
  }

  Future<void> _initializeLocationService() async {
    try {
      // First check if location services are enabled
      bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          isLocationServiceRunning = false;
          locationMessage = 'Location Service: Stopped\nPlease enable GPS';
        });
        return;
      }

      // Check and request permissions
      final hasPermissions = await requestPermissions();
      if (!hasPermissions) {
        setState(() {
          isLocationServiceRunning = false;
          locationMessage =
              'Location Service: Stopped\nPermissions not granted';
        });
        return;
      }

      // Start location updates
      await startLocationUpdates();
      setState(() {
        isLocationServiceRunning = true;
        locationMessage = 'Location Service: Active';
      });

      // Get initial location
      await _getCurrentLocation();

      // Monitor location service status
      _serviceStatusSubscription
          ?.cancel(); // Cancel existing subscription if any
      _serviceStatusSubscription =
          geo.Geolocator.getServiceStatusStream().listen(
        (geo.ServiceStatus status) async {
          debugPrint('Location service status changed: $status');
          if (status == geo.ServiceStatus.disabled) {
            await stopLocationUpdates();
            setState(() {
              isLocationServiceRunning = false;
              locationMessage = 'Location Service: Stopped\nGPS is disabled';
            });
          } else if (status == geo.ServiceStatus.enabled) {
            // Only restart if we were previously running
            if (!isLocationServiceRunning) {
              await _initializeLocationService();
            }
          }
        },
        onError: (error) {
          debugPrint('Location service status error: $error');
          setState(() {
            isLocationServiceRunning = false;
            locationMessage = 'Location Service: Error\n$error';
          });
        },
      );
    } catch (e) {
      debugPrint('Failed to initialize location service: $e');
      setState(() {
        isLocationServiceRunning = false;
        locationMessage = 'Location Service: Error\n$e';
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _serviceStatusSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // App came to foreground
      if (!isLocationServiceRunning) {
        _initializeLocationService();
      }
    }
  }

  Future<void> _initializeMap() async {
    try {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..enableZoom(false) // Disable zoom to reduce memory usage
        ..loadHtmlString('''
          <!DOCTYPE html>
          <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
              body, html { margin: 0; padding: 0; height: 100%; }
              #map { 
                width: 100%; 
                height: 100%;
                background-color: #f8f9fa;
              }
              .user-marker, .location-marker {
                cursor: pointer;
                transition: transform 0.2s;
              }
              .user-marker:hover, .location-marker:hover {
                transform: scale(1.1);
              }
              /* Style the zoom controls */
              .leaflet-control-zoom {
                margin-bottom: 20px !important;
                margin-left: 20px !important;
                border-radius: 8px !important;
                box-shadow: 0 2px 5px rgba(0,0,0,0.2) !important;
                background-color: rgba(255, 255, 255, 0.9) !important;
              }
              .leaflet-control-zoom a {
                width: 36px !important;
                height: 36px !important;
                line-height: 36px !important;
                border-radius: 4px !important;
                background-color: rgba(255, 255, 255, 0.9) !important;
                color: #333 !important;
                font-size: 18px !important;
                font-weight: bold !important;
                backdrop-filter: blur(5px) !important;
              }
              .leaflet-control-zoom a:hover {
                background-color: rgba(244, 244, 244, 0.9) !important;
              }
              .leaflet-control-scale,
              .leaflet-control-attribution {
                background-color: rgba(255, 255, 255, 0.9) !important;
                backdrop-filter: blur(5px) !important;
              }
            </style>
            <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
            <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
          </head>
          <body>
            <div id="map"></div>
            <script>
              var map = L.map('map', {
                zoomControl: false,
                attributionControl: false
              }).setView([20.5937, 78.9629], 5);
              
              // Add Google Satellite tiles
              L.tileLayer('https://mt0.google.com/vt/lyrs=s&x={x}&y={y}&z={z}', {
                maxZoom: 20,
                subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                attribution: 'Google Maps'
              }).addTo(map);
              
              // Add labels layer
              L.tileLayer('https://mt1.google.com/vt/lyrs=h&x={x}&y={y}&z={z}', {
                maxZoom: 20,
                subdomains: ['mt0', 'mt1', 'mt2', 'mt3']
              }).addTo(map);
              
              // Add zoom control to bottom left
              L.control.zoom({
                position: 'bottomleft'
              }).addTo(map);
              
              // Add scale control
              L.control.scale({
                maxWidth: 200,
                metric: true,
                imperial: false,
                position: 'bottomright'
              }).addTo(map);
              
              // Add attribution
              L.control.attribution({
                position: 'bottomright',
                prefix: 'Google Maps | Suraksha'
              }).addTo(map);
              
              var markers = [];
              
              function clearMarkers() {
                if (markers) {
                  markers.forEach(marker => marker.remove());
                  markers = [];
                }
              }
              
              function addMarker(lat, lng, type) {
                const isUserMarker = type === 'user';
                const icon = L.divIcon({
                  className: isUserMarker ? 'user-marker' : 'location-marker',
                  html: `
                    <div style="
                      background-color: \${isUserMarker ? '#4285f4' : '#db4437'};
                      width: \${isUserMarker ? '16px' : '14px'};
                      height: \${isUserMarker ? '16px' : '14px'};
                      border-radius: 50%;
                      border: \${isUserMarker ? '3px' : '2px'} solid white;
                      box-shadow: 0 2px 4px rgba(0,0,0,0.3);
                    "></div>
                  `,
                  iconSize: isUserMarker ? [22, 22] : [18, 18],
                  iconAnchor: isUserMarker ? [11, 11] : [9, 9]
                });
                
                const marker = L.marker([lat, lng], { icon: icon }).addTo(map);
                markers.push(marker);
                return marker;
              }
              
              function updateMapCenter(lat, lng, zoom) {
                map.setView([lat, lng], zoom, {
                  animate: true,
                  duration: 1
                });
              }
            </script>
          </body>
          </html>
        ''')
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              debugPrint('Map loading started');
            },
            onProgress: (int progress) {
              debugPrint('Map loading progress: $progress%');
            },
            onPageFinished: (String url) {
              debugPrint('Map loading finished');
              _getCurrentLocation();
              setState(() {
                isLoading = false;
                isLocationServiceRunning =
                    true; // Start location service automatically
              });
              startLocationUpdates(); // Start location updates when map loads
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint('WebView error: ${error.description}');
              setState(() {
                locationMessage = 'Map loading error: ${error.description}';
                isLoading = false;
              });
            },
          ),
        );
    } catch (e) {
      debugPrint('Error initializing map: $e');
      setState(() {
        locationMessage = 'Error initializing map: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _updateLocationMessage(AppLocalizations.of(context).locationDisabled);
        return;
      }

      geo.LocationPermission permission = await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          _updateLocationMessage(AppLocalizations.of(context).permissionDenied);
          return;
        }
      }

      if (permission == geo.LocationPermission.deniedForever) {
        _updateLocationMessage(AppLocalizations.of(context).permissionPermanentlyDenied);
        return;
      }

      _updateLocationMessage(AppLocalizations.of(context).gettingLocation);

      geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
        timeLimit: const Duration(seconds: 20),
      );

      setState(() {
        currentPosition = position;
      });

      if (currentPosition != null) {
        try {
          // Clear existing markers
          await controller.runJavaScript('''
            // Clear existing markers
            if (markers) {
              markers.forEach(marker => marker.remove());
              markers = [];
            }
            
            function addMarker(lat, lng, type) {
              const isUserMarker = type === 'user';
              const icon = L.divIcon({
                className: isUserMarker ? 'user-marker' : 'location-marker',
                html: `
                  <div style="
                    background-color: \${isUserMarker ? '#4285f4' : '#db4437'};
                    width: \${isUserMarker ? '16px' : '14px'};
                    height: \${isUserMarker ? '16px' : '14px'};
                    border-radius: 50%;
                    border: \${isUserMarker ? '3px' : '2px'} solid white;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.3);
                  "></div>
                `,
                iconSize: isUserMarker ? [22, 22] : [18, 18],
                iconAnchor: isUserMarker ? [11, 11] : [9, 9]
              });
              
              const marker = L.marker([lat, lng], { icon: icon }).addTo(map);
              markers.push(marker);
              return marker;
            }
          ''');

          final js = '''
            updateMapCenter(${currentPosition!.latitude}, ${currentPosition!.longitude}, 15);
            addMarker(${currentPosition!.latitude}, ${currentPosition!.longitude}, 'user');
          ''';
          await controller.runJavaScript(js);

          // Update location message with current coordinates
          _updateLocationMessage(
            '${AppLocalizations.of(context).currentLocation}\n'
            '${AppLocalizations.of(context).latitude}: ${currentPosition!.latitude.toStringAsFixed(6)}\n'
            '${AppLocalizations.of(context).longitude}: ${currentPosition!.longitude.toStringAsFixed(6)}'
          );

          // Fetch nearby locations
          await fetchNearbyLocation();
        } catch (e) {
          debugPrint('Error updating map: $e');
        }
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      _updateLocationMessage('Error: ${e.toString()}');
    }
  }

  Future<void> fetchNearbyLocation() async {
    if (currentPosition == null) {
      debugPrint('Cannot fetch nearby locations: Current position is null');
      return;
    }

    setState(() {
      locationMessage = 'Fetching nearby locations...';
    });

    try {
      // Add retry mechanism for server connection
      int retryCount = 0;
      const maxRetries = 2;

      while (retryCount <= maxRetries) {
        try {
          final response = await http.get(
            Uri.parse(
                '$serverUrl/?query=${currentPosition!.latitude},${currentPosition!.longitude}'),
            headers: {'Accept': 'application/json'},
          ).timeout(
              const Duration(seconds: 8)); // Shorter timeout for better UX

          if (response.statusCode == 200) {
            try {
              final data = jsonDecode(response.body);

              // Update location message with current coordinates
              setState(() {
                locationMessage =
                    'Current Location\nLatitude: ${currentPosition!.latitude.toStringAsFixed(6)}\nLongitude: ${currentPosition!.longitude.toStringAsFixed(6)}';
              });

              // Check if response contains valid coordinates
              if (data.containsKey('longitude') &&
                  data.containsKey('latitude')) {
                // Validate coordinates before using them
                final double? lat =
                    double.tryParse(data['latitude'].toString());
                final double? lng =
                    double.tryParse(data['longitude'].toString());

                if (lat != null && lng != null) {
                  final js = '''
                    addMarker($lat, $lng, 'location');
                  ''';
                  await controller.runJavaScript(js);

                  // Add distance information if available
                  if (data.containsKey('distance')) {
                    setState(() {
                      locationMessage =
                          '$locationMessage\nNearest location: ${data['distance'].toStringAsFixed(2)} km away';
                    });
                  }
                } else {
                  debugPrint('Invalid coordinate format in server response');
                  setState(() {
                    locationMessage =
                        '$locationMessage\nInvalid location data received';
                  });
                }
              } else {
                debugPrint('Invalid server response format: $data');
                setState(() {
                  locationMessage =
                      '$locationMessage\nNo nearby locations found';
                });
              }

              // Successfully processed response, break out of retry loop
              break;
            } catch (e) {
              debugPrint('Error parsing server response: $e');
              setState(() {
                locationMessage =
                    'Error processing server data: ${e.toString().split('\n')[0]}';
              });
              break; // Break on parsing error, retrying won't help
            }
          } else if (response.statusCode >= 500 && retryCount < maxRetries) {
            // Server error, retry
            retryCount++;
            await Future.delayed(Duration(seconds: 1 * retryCount));
            debugPrint(
                'Retrying server connection (${retryCount}/${maxRetries})');
          } else {
            // Other error codes or max retries reached
            setState(() {
              locationMessage =
                  'Server error (${response.statusCode}): ${response.reasonPhrase}';
            });
            debugPrint(
                'Server error: ${response.statusCode} - ${response.body}');
            break;
          }
        } on TimeoutException {
          if (retryCount < maxRetries) {
            retryCount++;
            await Future.delayed(Duration(seconds: 1 * retryCount));
            debugPrint(
                'Connection timeout, retrying (${retryCount}/${maxRetries})');
          } else {
            setState(() {
              locationMessage =
                  'Server connection timed out. Please try again later.';
            });
            break;
          }
        }
      }
    } catch (e) {
      debugPrint('Server connection error: $e');
      setState(() {
        locationMessage = 'Connection error: ${e.toString().split('\n')[0]}';
      });
    }
  }

  void _updateLocationMessage(String message) {
    final l10n = AppLocalizations.of(context);
    setState(() {
      locationMessage = message;
      // Replace English strings with localized ones
      locationMessage = locationMessage!
          .replaceAll('Location Service: Active', '${l10n.locationService}: ${l10n.active}')
          .replaceAll('Initializing location service...', l10n.initializing)
          .replaceAll('Location services are disabled. Please enable GPS.', l10n.locationDisabled)
          .replaceAll('Location permissions are denied', l10n.permissionDenied)
          .replaceAll('Location permissions are permanently denied. Please enable in settings.', l10n.permissionPermanentlyDenied)
          .replaceAll('Getting your location...', l10n.gettingLocation)
          .replaceAll('Current Location', l10n.currentLocation)
          .replaceAll('Latitude', l10n.latitude)
          .replaceAll('Longitude', l10n.longitude)
          .replaceAll('Nearest location', l10n.nearestLocation)
          .replaceAll('km away', l10n.kmAway)
          .replaceAll('No nearby locations found', l10n.noLocations)
          .replaceAll('Invalid location data received', l10n.invalidData)
          .replaceAll('Server error', l10n.serverError)
          .replaceAll('Server connection timed out. Please try again later.', l10n.connectionTimeout)
          .replaceAll('Retrying server connection', l10n.retrying)
          .replaceAll('Error processing server data', l10n.errorProcessing);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<AppLanguage>(
              value: _currentLanguage,
              icon: const Icon(Icons.language, color: Colors.white),
              style: const TextStyle(color: Colors.white),
              dropdownColor: Theme.of(context).primaryColor,
              underline: Container(),
              onChanged: (AppLanguage? newValue) {
                if (newValue != null) {
                  _changeLanguage(newValue);
                }
              },
              items: AppLanguage.values.map<DropdownMenuItem<AppLanguage>>((AppLanguage language) {
                return DropdownMenuItem<AppLanguage>(
                  value: language,
                  child: Text(
                    language.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    locationMessage ?? 'Initializing map...',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                WebViewWidget(
                  controller: controller,
                  gestureRecognizers: const {}, // Disable gesture recognition to reduce overhead
                ),
                if (locationMessage != null)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    isLocationServiceRunning
                                        ? '${l10n.locationService}: ${l10n.active}'
                                        : l10n.initializing,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isLocationServiceRunning
                                          ? Colors.green
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.refresh, size: 20),
                                  tooltip: 'Refresh Location',
                                  onPressed: _getCurrentLocation,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                            const Divider(),
                            Text(
                              locationMessage!,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            if (isLocationServiceRunning)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: 12,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Location Service: Active',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: _getCurrentLocation,
                    tooltip: 'Get Current Location',
                    child: const Icon(Icons.my_location),
                  ),
                ),
              ],
            ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize OneSignal
  OneSignal.initialize('YOUR-ONESIGNAL-APP-ID');
  OneSignal.Notifications.requestPermission(true);

  // Disable Impeller to avoid DevFS issues
  if (Platform.isAndroid) {
    await SystemChannels.skia
        .invokeMethod('Skia.setResourceCacheMaxBytes', 512 * (1 << 20));
  }

  // Request permissions and initialize location tracking
  await requestPermissions();
  await initializeLocationTracking();
  runApp(const MyApp());
}
