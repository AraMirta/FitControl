# FitControl 🏋️‍♂️

Una aplicación móvil desarrollada en Flutter para el control y seguimiento de hábitos de fitness, incluyendo gestión de recetas, rutinas de ejercicio y seguimiento de peso.

## 🏗️ Arquitectura del Proyecto

### Patrón Arquitectónico
Este proyecto implementa una **arquitectura MVC (Model-View-Controller)** con separación clara de responsabilidades:

#### 📁 Estructura de Carpetas
```
lib/
├── main.dart              # Punto de entrada de la aplicación
├── models/                # Capa de Modelo (Data Models)
│   └── local_data.dart    # Modelos de datos (Recipe, Workout, User)
├── screens/               # Capa de Vista (UI Screens)
│   ├── welcome_screen.dart
│   ├── main_screen.dart
│   ├── goal_screen.dart
│   ├── recipes_screen.dart
│   ├── workouts_screen.dart
│   ├── weight_screen.dart
│   ├── profile_screen.dart
│   ├── calendar_screen.dart
│   └── edit_profile_screen.dart
├── services/              # Capa de Controlador (Business Logic)
│   └── user_preferences.dart # Gestión de preferencias y datos persistentes
└── widgets/               # Componentes reutilizables
    └── logo.dart          # Widget personalizado del logo
```

#### 🎯 Componentes de la Arquitectura

##### **Models (Modelos)**
- **Recipe**: Modelo para las recetas nutricionales
- **Workout**: Modelo para las rutinas de ejercicio  
- **User**: Modelo para la información del usuario
- Ubicación: `lib/models/local_data.dart`

##### **Views (Vistas)**
- Pantallas de la interfaz de usuario desarrolladas como StatefulWidget/StatelessWidget
- Implementan Material Design 3
- Navegación basada en rutas nombradas
- Ubicación: `lib/screens/`

##### **Controllers (Controladores)**
- **UserPreferences**: Patrón Singleton para gestión de datos persistentes usando SharedPreferences
- Maneja la lógica de negocio y persistencia de datos
- Ubicación: `lib/services/`

### 🔄 Flujo de Datos
1. **Vista** → Usuario interactúa con la UI
2. **Controlador** → Procesa la lógica de negocio y gestiona datos
3. **Modelo** → Define la estructura de datos
4. **Vista** → Se actualiza basada en los cambios del modelo

### 🎨 Patrones de Diseño Implementados
- **Singleton**: Para UserPreferences (gestión de estado global)
- **Navigator Pattern**: Para navegación entre pantallas
- **Widget Composition**: Para reutilización de componentes UI

### � **Estrategia de Persistencia de Datos**

#### **Arquitectura de Datos Híbrida:**

##### **1. Datos Dinámicos del Usuario (SharedPreferences)**
```dart
UserPreferences (Singleton)
├── Información Personal
│   ├── user_name (String)
│   ├── user_age (int)
│   ├── user_email (String)
│   └── user_goal (String)
├── Seguimiento de Peso
│   ├── current_weight (double)
│   ├── target_weight (double)
│   └── weekly_progress (List<double>)
└── Métodos de Gestión
    ├── saveXX() - Operaciones de escritura
    ├── getXX() - Operaciones de lectura
    ├── hasUserData() - Validación
    └── clearAllData() - Limpieza
```

**Características:**
- ✅ **Persistencia local**: Los datos sobreviven al cierre de la app
- ✅ **Acceso rápido**: Almacenamiento clave-valor optimizado
- ✅ **Tipo-seguro**: Validación de tipos de datos
- ✅ **Valores por defecto**: Fallbacks para datos no inicializados

##### **2. Datos Estáticos (Hardcoded)**
```dart
local_data.dart
├── recipes (List<Recipe>) - Recetas predefinidas por día
├── workouts (List<Workout>) - Rutinas de ejercicio por día
└── Modelos de datos inmutables
```

**Características:**
- ⚡ **Rendimiento**: Acceso inmediato sin I/O
- 📋 **Contenido curado**: Datos de ejemplo y plantillas
- 🔒 **Inmutable**: No se modifican durante la ejecución

#### **Ventajas del Enfoque Actual:**
- **Simplicidad**: Fácil implementación y mantenimiento
- **Rendimiento**: Mínima latencia en operaciones de datos
- **Offline-first**: Funciona completamente sin conexión
- **Multiplataforma**: Compatible con todos los targets de Flutter

#### **Consideraciones para Escalabilidad:**
- **Datos relacionales complejos** → Migrar a SQLite (sqflite)
- **Sincronización en la nube** → Firebase/Firestore
- **Datos masivos** → Implementar paginación
- **Búsqueda avanzada** → Indexación con Hive o ObjectBox

### �📱 Tecnologías y Dependencias
- **Flutter SDK**: ^3.7.2
- **Material Design 3**: Para componentes UI
- **SharedPreferences**: Para persistencia local de preferencias del usuario
- **Multiplataforma**: Android, iOS, Web, Windows, macOS, Linux

## Getting Started

Este proyecto está desarrollado en Flutter para el seguimiento de hábitos fitness.

### Recursos útiles para Flutter:
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

Para ayuda con el desarrollo en Flutter, consulta la
[documentación online](https://docs.flutter.dev/), que ofrece tutoriales,
ejemplos, guías de desarrollo móvil y una referencia completa de la API.


## Levantar el proyecto

### Comando para ver los emuladores en los que se puede levantar
flutter emulators

### Comando para abrir emulador (uno a la vez)
flutter emulators --launch Small_Desktop
flutter emulators --launch Pixel 7

### Comando para levantar aplicacion en el emulador
flutter run
