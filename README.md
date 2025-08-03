# My Tasks App

A Flutter application for managing tasks with authentication and state management using BLoC pattern.

## 🚀 Instrucciones para correr el proyecto

### Requisitos previos
- Flutter SDK (versión 3.8.1 o superior)
- Dart SDK (versión 3.1.0 o superior)
- Android Studio / Xcode (para emuladores/dispositivos móviles)
- Firebase project configurado (para autenticación)

### Pasos de instalación

1. Clona el repositorio:
   ```bash
   git clone [url-del-repositorio]
   cd my_tasks_app
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Configura Firebase:
   - Agrega los archivos de configuración de Firebase (google-services.json para Android y GoogleService-Info.plist para iOS)
   - Configura la autenticación por correo/contraseña en Firebase Console

4. Genera los archivos necesarios:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## 🏗️ Arquitectura implementada

La aplicación sigue una arquitectura limpia (Clean Architecture) con las siguientes capas:

### Capas principales:
1. **Presentación (UI)**: 
   - Widgets y pantallas de Flutter
   - Controladores de formularios con Cubit
   - Navegación con GoRouter

2. **Dominio (Domain)**:
   - Entidades de negocio (Task, User)
   - Repositorios abstractos
   - Casos de uso

3. **Datos (Data)**:
   - Implementaciones de repositorios
   - Fuentes de datos (Firebase, local)
   - Mapeadores de datos

### Características clave:
- Inyección de dependencias con GetIt e Injectable
- Enrutamiento declarativo con GoRouter
- Tema personalizado con soporte para modo claro/oscuro
- Validación de formularios con Formz

## 🔄 Patrón de estado usado

La aplicación utiliza el patrón BLoC (Business Logic Component) para la gestión de estado, complementado con Cubit para casos más simples:

### BLoC
- **AuthBloc**: Maneja la autenticación del usuario
- **TasksBloc**: Gestiona las operaciones CRUD de tareas

### Cubit
- **SignInFormCubit**: Maneja el estado del formulario de inicio de sesión
- **RegisterFormCubit**: Gestiona el estado del formulario de registro
- **TaskFormCubit**: Controla el estado del formulario de creación/edición de tareas

### Beneficios de esta implementación:
- Separación clara entre la lógica de negocio y la interfaz de usuario
- Fácil de probar y mantener
- Estado predecible y rastreable
- Reactividad a los cambios de estado

## 📦 Dependencias principales
- `flutter_bloc`: Para la gestión de estado con BLoC
- `get_it` e `injectable`: Para inyección de dependencias
- `go_router`: Para navegación
- `firebase_auth` y `firebase_core`: Para autenticación
- `equatable`: Para comparación de objetos
- `formz`: Para validación de formularios
